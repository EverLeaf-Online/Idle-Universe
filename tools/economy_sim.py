"""Idle Universe alpha economy simulator.

This is a deliberately simple deterministic balance tool. It is not intended to
perfectly model human behavior. Its purpose is to catch obviously broken economy
curves before they are implemented or shipped.

Run:
    python tools/economy_sim.py

The simulator follows a goal-first strategy:
- buy mandatory machine levels for the next progression gate,
- invest in the Research Lab enough to satisfy the current stage,
- otherwise buy upgrades with acceptable payback time,
- unlock the next world as soon as all configured requirements are satisfied.
"""

from __future__ import annotations

from dataclasses import dataclass
from math import floor, sqrt


@dataclass(frozen=True)
class Machine:
    base_cost: float
    growth: float
    base_output: float
    world: int
    currency: str = "credits"


@dataclass(frozen=True)
class WorldGate:
    lifetime_credits: float
    unlock_cost: float
    required_levels: dict[str, int]
    mandatory_research_spend: float


MACHINES: dict[str, Machine] = {
    "Recycler": Machine(50, 1.14, 1, 1),
    "Smelter": Machine(500, 1.15, 12, 1),
    "Assembly": Machine(20_000, 1.15, 500, 2),
    "ResearchLab": Machine(50_000, 1.16, 0.5, 2, "research"),
    "RobotFactory": Machine(1_000_000, 1.16, 30_000, 3),
    "Fusion": Machine(10_000_000, 1.17, 300_000, 3),
    "Nano": Machine(500_000_000, 1.17, 15_000_000, 4),
    "Antimatter": Machine(5_000_000_000, 1.18, 175_000_000, 4),
    "Dyson": Machine(200_000_000_000, 1.18, 7_000_000_000, 5),
    "Reality": Machine(2_000_000_000_000, 1.20, 90_000_000_000, 5),
}

# Cumulative milestone multipliers.
MILESTONES: tuple[tuple[int, float], ...] = (
    (10, 2),
    (25, 2),
    (50, 3),
    (100, 5),
    (250, 10),
)

# World numbers correspond to:
# 1 Earth, 2 Lunar, 3 Mars, 4 Asteroid, 5 Solar.
WORLD_GATES: dict[int, WorldGate] = {
    2: WorldGate(
        lifetime_credits=25_000,
        unlock_cost=10_000,
        required_levels={"Recycler": 25, "Smelter": 10},
        mandatory_research_spend=0,
    ),
    3: WorldGate(
        lifetime_credits=2_500_000,
        unlock_cost=500_000,
        required_levels={"Assembly": 20},
        # Conveyor Optimization + Orbital Logistics.
        mandatory_research_spend=25,
    ),
    4: WorldGate(
        lifetime_credits=350_000_000,
        unlock_cost=25_000_000,
        required_levels={"RobotFactory": 20, "Fusion": 10},
        # Mandatory research path through Robotics and Deep-Space Logistics.
        mandatory_research_spend=263,
    ),
    5: WorldGate(
        lifetime_credits=175_000_000_000,
        unlock_cost=1_000_000_000,
        required_levels={"Nano": 20, "Antimatter": 10},
        # Mandatory cumulative research through Solar prerequisites.
        mandatory_research_spend=1_373,
    ),
}

SINGULARITY_LIFETIME = 80_000_000_000_000
SINGULARITY_REQUIRED_LEVELS = {"Dyson": 20, "Reality": 10}
SINGULARITY_MANDATORY_RESEARCH_SPEND = 2_668

# Goal-first simulator targets for the Research Lab. Human players may choose
# different levels; these targets merely keep the model deterministic.
RESEARCH_LAB_TARGET_BY_WORLD = {2: 3, 3: 6, 4: 10, 5: 15}

RECYCLER_AUTOMATION_COST = 75
MANUAL_CREDITS_PER_SECOND = 2
OPTIONAL_PURCHASE_MAX_PAYBACK_SECONDS = 75


def milestone_multiplier(level: int) -> float:
    multiplier = 1.0
    for required_level, bonus in MILESTONES:
        if level >= required_level:
            multiplier *= bonus
    return multiplier


def next_level_cost(machine_name: str, current_level: int) -> float:
    machine = MACHINES[machine_name]
    return machine.base_cost * (machine.growth**current_level)


def machine_output(machine_name: str, level: int) -> float:
    machine = MACHINES[machine_name]
    return machine.base_output * level * milestone_multiplier(level)


def core_reward(current_run_lifetime_credits: float) -> int:
    return max(1, floor(sqrt(current_run_lifetime_credits / 5_000_000_000_000)))


def format_duration(seconds: int) -> str:
    minutes, seconds = divmod(seconds, 60)
    return f"{minutes:02d}:{seconds:02d}"


def simulate(
    production_multiplier: float = 1.0,
    research_multiplier: float = 1.0,
    max_seconds: int = 7_200,
) -> dict:
    levels = {name: 0 for name in MACHINES}
    levels["Recycler"] = 1

    automated = False
    world = 1
    credits = 0.0
    research = 0.0
    research_spent = 0.0
    lifetime_credits = 0.0
    events: list[tuple[int, str]] = []

    for second in range(max_seconds):
        credit_rate = 0.0
        research_rate = 0.0

        if automated:
            for name, level in levels.items():
                machine = MACHINES[name]
                value = machine_output(name, level)
                if machine.currency == "credits":
                    credit_rate += value * production_multiplier
                else:
                    research_rate += value * research_multiplier
        else:
            credit_rate = MANUAL_CREDITS_PER_SECOND

        credits += credit_rate
        lifetime_credits += credit_rate
        research += research_rate

        if not automated and credits >= RECYCLER_AUTOMATION_COST:
            credits -= RECYCLER_AUTOMATION_COST
            automated = True
            events.append((second, "Recycler automated"))

        if not automated:
            continue

        # Buy the cumulative mandatory Research package for the next progression
        # stage when enough Research is available. The full game will buy named
        # nodes individually; aggregate spending keeps this simulator compact.
        if world < 5:
            research_target = WORLD_GATES[world + 1].mandatory_research_spend
        else:
            research_target = SINGULARITY_MANDATORY_RESEARCH_SPEND

        if research_spent < research_target:
            required = research_target - research_spent
            if research >= required:
                research -= required
                research_spent = research_target
                events.append((second, f"Research stage {world + 1} complete"))

        # World progression.
        if world < 5:
            gate = WORLD_GATES[world + 1]
            levels_ready = all(
                levels[name] >= required_level
                for name, required_level in gate.required_levels.items()
            )
            research_ready = research_spent >= gate.mandatory_research_spend

            if (
                levels_ready
                and research_ready
                and lifetime_credits >= gate.lifetime_credits
                and credits >= gate.unlock_cost
            ):
                credits -= gate.unlock_cost
                world += 1
                events.append((second, f"World {world} unlocked"))

        # Singularity progression.
        if world == 5:
            levels_ready = all(
                levels[name] >= required_level
                for name, required_level in SINGULARITY_REQUIRED_LEVELS.items()
            )
            if (
                levels_ready
                and lifetime_credits >= SINGULARITY_LIFETIME
                and research_spent >= SINGULARITY_MANDATORY_RESEARCH_SPEND
            ):
                events.append((second, "Singularity available"))
                return {
                    "seconds": second,
                    "events": events,
                    "levels": levels,
                    "lifetime_credits": lifetime_credits,
                    "research": research,
                    "research_spent": research_spent,
                    "cores": core_reward(lifetime_credits),
                }

        # Required machine targets for the current progression stage.
        if world < 5:
            required_levels = dict(WORLD_GATES[world + 1].required_levels)
        else:
            required_levels = dict(SINGULARITY_REQUIRED_LEVELS)

        if world >= 2:
            required_levels["ResearchLab"] = RESEARCH_LAB_TARGET_BY_WORLD[world]

        # Allow multiple inexpensive purchases in one simulated second.
        for _ in range(100):
            required_candidates: list[tuple[float, str]] = []
            optional_candidates: list[tuple[float, str, float]] = []

            for name, machine in MACHINES.items():
                if machine.world > world:
                    continue

                cost = next_level_cost(name, levels[name])
                if cost > credits:
                    continue

                old_output = machine_output(name, levels[name])
                new_output = machine_output(name, levels[name] + 1)
                delta = new_output - old_output

                if machine.currency == "credits":
                    delta *= production_multiplier
                else:
                    delta *= research_multiplier

                payback = cost / max(delta, 1e-9)

                if levels[name] < required_levels.get(name, 0):
                    required_candidates.append((cost, name))
                else:
                    optional_candidates.append((payback, name, cost))

            if required_candidates:
                required_candidates.sort()
                cost, chosen = required_candidates[0]
            elif optional_candidates:
                optional_candidates.sort()
                payback, chosen, cost = optional_candidates[0]
                if payback > OPTIONAL_PURCHASE_MAX_PAYBACK_SECONDS:
                    break
            else:
                break

            credits -= cost
            levels[chosen] += 1

    return {
        "seconds": max_seconds,
        "events": events,
        "levels": levels,
        "lifetime_credits": lifetime_credits,
        "research": research,
        "research_spent": research_spent,
        "cores": 0,
    }


def print_simulation(production_multiplier: float, research_multiplier: float) -> None:
    result = simulate(production_multiplier, research_multiplier)
    print(
        f"\nProduction x{production_multiplier:.2f} / "
        f"Research x{research_multiplier:.2f}"
    )

    for second, event in result["events"]:
        if "World" in event or event in {"Recycler automated", "Singularity available"}:
            print(f"  {format_duration(second)}  {event}")

    print(
        f"  Finish: {format_duration(result['seconds'])} | "
        f"Cores: {result['cores']} | "
        f"Lifetime: {result['lifetime_credits']:,.0f}"
    )


def main() -> None:
    print("Idle Universe — alpha economy simulation")
    print("Goal-first deterministic strategy; not a human-player prediction.")

    # Baseline plus illustrative prestige-power profiles.
    profiles = (
        (1.0, 1.0),
        (1.5, 1.2),
        (2.2, 1.4),
        (3.2, 1.6),
        (4.5, 1.8),
    )

    for production_multiplier, research_multiplier in profiles:
        print_simulation(production_multiplier, research_multiplier)


if __name__ == "__main__":
    main()
