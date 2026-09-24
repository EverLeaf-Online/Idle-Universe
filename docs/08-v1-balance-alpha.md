# V1 Balance — Alpha Pass

Status: **alpha tuning values**. These numbers are intended to make the economy implementable and simulatable. They are not launch-final values.

The target for the first balance pass is a free-player first Singularity in roughly 25–35 minutes, followed by visibly faster runs through permanent Core upgrades.

## 1. Core formulas

### Machine level cost

```text
NextLevelCost = BaseCost × GrowthRate^CurrentLevel
```

`CurrentLevel` is the level before the purchase.

### Machine production

```text
BaseProductionPerSecond = BaseOutput × Level × MilestoneMultiplier
FinalProductionPerSecond = BaseProductionPerSecond × GlobalProductionModifiers
```

### Standard milestone multiplier

Milestone multipliers are cumulative.

| Level reached | Additional multiplier | Cumulative multiplier |
|---:|---:|---:|
| 10 | ×2 | ×2 |
| 25 | ×2 | ×4 |
| 50 | ×3 | ×12 |
| 100 | ×5 | ×60 |
| 250 | ×10 | ×600 |

These values are intentionally aggressive because milestone jumps are part of the idle-game reward cadence. They must be re-tested once real upgrade choice behavior exists.

## 2. Opening interaction

The player starts with a level-1 Scrap Recycler that requires manual Scrap feeding.

- Manual opening income target: approximately **2 Credits/sec**.
- Recycler Automation unlock: **75 Credits**.
- Target time to automation: approximately **35–45 seconds** for an attentive new player.
- Once automation is purchased, the Recycler begins passive production and manual feeding becomes optional.

After automation, Recycler levels use the normal level-cost formula below.

## 3. Machine alpha values

| Tier | Machine | Base cost | Growth | Base output | Output currency |
|---:|---|---:|---:|---:|---|
| 1 | Scrap Recycler | 50 | 1.14 | 1/sec/level | Credits |
| 2 | Industrial Smelter | 500 | 1.15 | 12/sec/level | Credits |
| 3 | Assembly Line | 20,000 | 1.15 | 500/sec/level | Credits |
| 4 | Research Lab | 50,000 | 1.16 | 0.5/sec/level | Research |
| 5 | Robot Factory | 1,000,000 | 1.16 | 30,000/sec/level | Credits |
| 6 | Fusion Reactor | 10,000,000 | 1.17 | 300,000/sec/level | Credits |
| 7 | Nano Fabricator | 500,000,000 | 1.17 | 15,000,000/sec/level | Credits |
| 8 | Antimatter Reactor | 5,000,000,000 | 1.18 | 175,000,000/sec/level | Credits |
| 9 | Dyson Foundry | 200,000,000,000 | 1.18 | 7,000,000,000/sec/level | Credits |
| 10 | Reality Engine | 2,000,000,000,000 | 1.20 | 90,000,000,000/sec/level | Credits / Singularity progression |

The Reality Engine's displayed production can contribute Credits while its existence/level also gates Singularity progress. V1 should avoid a second hidden production economy unless playtesting shows it is needed.

## 4. World unlock alpha gates

All requirements are evaluated server-side.

### Lunar Industrial Complex

- Current-run lifetime Credits: **25,000**
- Recycler level: **25**
- Smelter level: **10**
- Unlock payment: **10,000 Credits**

### Mars Foundry

- Current-run lifetime Credits: **2,500,000**
- Assembly Line level: **20**
- Required Research: **Orbital Logistics**
- Unlock payment: **500,000 Credits**

### Asteroid Nexus

- Current-run lifetime Credits: **350,000,000**
- Robot Factory level: **20**
- Fusion Reactor level: **10**
- Required Research: **Robotics** and **Deep-Space Logistics**
- Unlock payment: **25,000,000 Credits**

### Solar Forge

- Current-run lifetime Credits: **175,000,000,000**
- Nano Fabricator level: **20**
- Antimatter Reactor level: **10**
- Required Research: **Antimatter Containment**, **Solar Supply Chain**, and **Stellar Engineering**
- Unlock payment: **1,000,000,000 Credits**

## 5. Research node alpha costs and effects

Effects are starting values, not final balance.

### Production

| Node | Cost | Alpha effect |
|---|---:|---|
| Efficient Motors | 5 R | +10% global Credit production |
| Refined Processing | 15 R | +25% Recycler, Smelter, Assembly output |
| Parallel Manufacturing | 40 R | +15% machine milestone bonuses |
| High-Energy Industry | 100 R | +30% Fusion and Antimatter output |
| Stellar Engineering | 250 R | +40% Dyson Foundry output; Solar Forge prerequisite |

### Logistics

| Node | Cost | Alpha effect |
|---|---:|---|
| Conveyor Optimization | 5 R | +10% early-machine output |
| Orbital Logistics | 20 R | Mars Foundry prerequisite |
| Autonomous Routing | 50 R | -5% machine level costs |
| Deep-Space Logistics | 150 R | Asteroid Nexus prerequisite |
| Solar Supply Chain | 400 R | Solar Forge prerequisite; -5% late-machine costs |

### Science

| Node | Cost | Alpha effect |
|---|---:|---|
| Applied Metallurgy | 8 R | +15% Research Lab production |
| Robotics | 30 R | Robot Factory automation bonus; Asteroid prerequisite |
| Nanotechnology | 80 R | +25% Nano Fabricator output |
| Antimatter Containment | 220 R | unlocks full Antimatter Reactor efficiency; Solar prerequisite |
| Reality Theory | 600 R | required for Singularity eligibility |

### Efficiency

| Node | Cost | Alpha effect |
|---|---:|---|
| Bulk Purchasing | 5 R | -3% machine level costs |
| Energy Recovery | 20 R | +15% Fusion and later machine output |
| Research Optimization | 60 R | +25% Research production |
| Industrial Compression | 160 R | -7% machine level costs |
| Singularity Preparation | 450 R | +20% Reality Engine contribution; Singularity prerequisite |

Research purchases reset on Singularity.

## 6. Singularity alpha requirements

A run can trigger Singularity when all conditions are true:

- Solar Forge unlocked.
- Dyson Foundry level **20+**.
- Reality Engine level **10+**.
- Current-run lifetime Credits **80,000,000,000,000 (80T)+**.
- Reality Theory purchased.
- Singularity Preparation purchased.

The 80T threshold is intentionally close to the expected production achieved while satisfying the machine requirements, so it acts as a meaningful final gate rather than a long idle wait.

## 7. Core reward formula

Alpha formula:

```text
Cores = max(1, floor(sqrt(CurrentRunLifetimeCredits / 5,000,000,000,000)))
```

Example rewards:

| Current-run lifetime Credits | Cores |
|---:|---:|
| 5T | 1 |
| 20T | 2 |
| 45T | 3 |
| 80T | 4 |
| 125T | 5 |
| 320T | 8 |

The player may continue a run beyond minimum Singularity eligibility to earn additional Cores, creating a basic prestige-now versus push-further decision.

## 8. Permanent Core tree alpha values

### Industry

| Node | Cost | Effect |
|---|---:|---|
| Core Output I | 1 Core | +25% global production |
| Core Output II | 2 Cores | additional +25% global production |
| Machine Mastery | 4 Cores | +25% milestone bonus strength |
| Genesis Industry | 8 Cores | meaningful early-run starting production bonus; exact implementation to be playtested |

### Knowledge

| Node | Cost | Effect |
|---|---:|---|
| Research Memory I | 1 Core | +20% Research production |
| Research Memory II | 3 Cores | additional +30% Research production |
| Fast Theory | 5 Cores | -15% Research node costs |
| Scientific Legacy | 8 Cores | begin each run with 50 Research |

### Automation

| Node | Cost | Effect |
|---|---:|---|
| Starting Automation | 5 Cores | begin runs with Recycler automation unlocked |
| Auto Purchase | 8 Cores | unlock basic machine auto-buy rules |
| Auto Upgrade | 12 Cores | unlock milestone-oriented automatic upgrades |
| Advanced Automation | 20 Cores | unlock priority/limit controls |

### Offline

| Node | Cost | Effect |
|---|---:|---|
| Offline Efficiency I | 1 Core | 50% → 65% offline efficiency |
| Offline Capacity I | 2 Cores | 2h → 4h cap |
| Offline Efficiency II | 4 Cores | 65% → 80% offline efficiency |
| Offline Capacity II | 6 Cores | 4h → 8h cap |

A likely first-prestige spend is Core Output I + Core Output II + Research Memory I for 4 total Cores. That produces approximately ×1.5 Credit production and ×1.2 Research production on the second run.

## 9. Offline alpha values

```text
OfflineCredits = EligibleCreditProductionAtLogout × OfflineSeconds × OfflineEfficiency
OfflineResearch = EligibleResearchProductionAtLogout × OfflineSeconds × OfflineResearchEfficiency
```

Initial values:

- Base duration cap: **2 hours**.
- Base Credit efficiency: **50%**.
- Base Research offline efficiency: **25%**.
- Maximum reward uses server-trusted elapsed time and a server-saved production snapshot.
- Do not progress one-time unlock cinematics or duplicate reward claims while offline.

## 10. Alpha simulation result

A deterministic goal-first simulator using the machine values above produces an initial free-player path close to:

| Event | Approximate simulated time |
|---|---:|
| Recycler automated | 0:37 |
| Lunar Industrial Complex | ~9:06 |
| Mars Foundry | ~15:13 |
| Asteroid Nexus | ~21:17 |
| Solar Forge | ~27:40 |
| First Singularity | ~33:06 |

This simple simulator does not yet model every Research purchase or human decision. Its purpose is to reject obviously broken curves before Roblox playtesting.

With illustrative permanent multipliers, the same simplified model compresses approximately as follows:

| Production modifier | Research modifier | Approximate run |
|---:|---:|---:|
| ×1.0 | ×1.0 | ~33 min |
| ×1.5 | ×1.2 | ~22 min |
| ×2.2 | ×1.4 | ~16 min |
| ×3.2 | ×1.6 | ~11 min |
| ×4.5 | ×1.8 | ~9 min |

These rows demonstrate the desired prestige direction; they are not promises that the Core tree will produce exactly those modifiers at those prestige counts.

## 11. Required next validation

Before treating these values as beta balance:

1. Reproduce the curve with a checked-in simulator.
2. Model actual Research prerequisites instead of aggregate Research gates.
3. Add alternative purchase strategies.
4. Confirm no machine becomes a universally dominant purchase.
5. Add quest rewards to the simulation.
6. Test first four Singularity cycles using actual Core purchases.
7. Implement the values as config, not hard-coded service logic.
8. Play the greybox in Roblox and compare real human timing to simulation.

If the simulator and human playtests disagree, human behavior and observed analytics win.