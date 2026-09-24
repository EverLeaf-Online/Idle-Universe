# Economy & Progression Specification

## 1. Economy goals

The economy should create a repeating decision loop:

**Earn → choose upgrade → feel acceleration → hit a new constraint → unlock a new system → prestige → repeat faster**

The economy must avoid two extremes:

- **Flat progression:** purchases barely change anything, so the game feels passive and unrewarding.
- **Runaway progression:** numbers explode so quickly that choices stop mattering.

## 2. Primary progression layers

### Layer A — Credits
Used for machines and most in-run upgrades.

### Layer B — Research
Used for technology unlocks and run-level strategic choices.

### Layer C — Singularity Cores
Permanent prestige currency used for account-level progression.

Future layers such as Quantum Shards should only be introduced when the existing meta progression is exhausted.

## 3. Machine cost model

A standard exponential cost curve is a useful starting point:

```text
Cost(level) = BaseCost × GrowthRate^level
```

Example growth-rate testing range:

```text
1.10–1.20 for frequent small upgrades
1.20–1.35 for stronger milestone purchases
```

The exact values must be tuned per machine. Earlier machines should remain relevant through milestone bonuses or cross-machine synergies instead of becoming completely obsolete.

## 4. Production model

Basic machine output can begin with:

```text
OutputPerSecond = BaseOutput × LevelMultiplier × ResearchMultiplier × PrestigeMultiplier × OtherBonuses
```

A simple level multiplier might begin as linear growth:

```text
LevelMultiplier = level
```

Milestone bonuses can then create discrete jumps:

```text
Level 10: ×2
Level 25: ×2
Level 50: ×3
Level 100: ×5
```

Do not hard-code milestone logic separately for every machine. Store it in configuration.

## 5. Purchase pacing

Early purchases should be frequent enough to teach the loop but not so frequent that the player never evaluates options.

Initial targets:

| Milestone | Target |
|---|---:|
| First meaningful upgrade | 15–30 sec |
| First automated generator | 1–2 min |
| First major unlock | 5–10 min |
| First prestige | ~20–35 min |

These are hypotheses. Replace them with real cohort data after testing.

## 6. Prestige formula

A prestige formula should reward total run progress while producing diminishing returns.

Candidate structure:

```text
Cores = floor((LifetimeRunValue / ScaleConstant)^Exponent)
```

Where:

- `ScaleConstant` controls the first prestige threshold.
- `Exponent` controls how quickly prestige rewards grow.

The formula must be evaluated against multiple run lengths. Players should have a meaningful choice between prestiging now for faster cycles or pushing farther for more Cores.

## 7. Prestige pacing

Desired early behavior:

```text
Run 1 → ~30 min
Run 2 → ~18 min
Run 3 → ~11 min
Run 4 → ~7 min
```

The game should later introduce new worlds, research walls, or meta systems so prestige cycles do not permanently collapse toward zero.

## 8. Permanent upgrades

Core upgrade categories:

- Global production
- Machine speed
- Starting Credits
- Research gain
- Offline efficiency
- Offline duration
- Cost reduction
- Automation unlocks
- Starting-world skips
- Specialized technology branches

Permanent upgrades should combine numeric bonuses with quality-of-life and mechanic unlocks.

## 9. World unlock costs

Each world should represent a distinct progression gate.

Potential unlock requirements can combine:

- Credit threshold
- Required machine level
- Required research node
- Previous world completion milestone
- Prestige count for late-game worlds

Avoid making every world unlock purely a currency purchase.

## 10. Offline earnings

Candidate model:

```text
OfflineEarnings = ProductionAtLogout × OfflineSeconds × OfflineEfficiency
```

Apply:

- a maximum offline duration,
- sanity limits on elapsed time,
- server-side calculation,
- version-safe handling if production formulas change.

Possible progression:

```text
Base cap: 2 hours
Upgrade 1: 4 hours
Upgrade 2: 8 hours
Upgrade 3: 12 hours
Upgrade 4: 24 hours
```

Do not allow client-provided timestamps or client-calculated rewards to determine final payouts.

## 11. Dynamic developer-product currency packs

If currency packs are sold, avoid fixed amounts that become irrelevant at higher progression.

Instead, derive packages from current earning power:

```text
Small pack  ≈ X minutes of current production
Medium pack ≈ Y minutes of current production
Large pack  ≈ Z minutes of current production
```

All calculations should be server-side and bounded so unusual player states cannot generate extreme payouts.

## 12. Economy balancing workflow

Before polished production:

1. Put all machine costs/output into configuration.
2. Simulate the first run from zero to Singularity.
3. Record expected purchase times.
4. Test alternate upgrade choices.
5. Verify no single machine dominates every decision.
6. Simulate several prestige cycles.
7. Test offline rewards.
8. Test paid boosts against free progression.
9. Playtest manually.
10. Replace assumptions with analytics after soft launch.

## 13. Balance checkpoints

At each major content update verify:

- Time to first upgrade
- Time to first automation
- Time to each world
- Time to first Singularity
- Median prestige frequency
- Upgrade-choice diversity
- Research completion order
- Offline reward impact
- Whether paid boosts trivialize progression
- Whether non-paying progression remains satisfying

## 14. Number scaling

Use centralized numerical utilities for:

- suffix formatting,
- safe arithmetic,
- comparison,
- serialization,
- UI display.

If Lua number precision becomes a limiting factor at extreme values, adopt a deterministic large-number representation rather than patching individual systems.

## 15. Economy anti-patterns to avoid

- Artificially slowing free players solely to make boosts attractive.
- Adding currencies that have no unique purpose.
- Infinite multiplicative bonuses without caps or structure.
- Fixed paid currency packs that become useless later.
- Prestige rewards so weak that resetting feels punitive.
- Prestige rewards so strong that normal progression becomes irrelevant.
- Client-authoritative currency or upgrade logic.
- Balancing exclusively by intuition after live data is available.