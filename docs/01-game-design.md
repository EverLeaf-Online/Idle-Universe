# Game Design Document

## 1. Product concept

**Working title:** Idle Universe

**Genre:** Roblox idle / automation / progression

**Elevator pitch:**

The player starts in a tiny scrapyard with one primitive machine, then grows an automated industrial empire across planets and solar systems. The end of a run culminates in creating a Singularity, resetting the current empire in exchange for permanent progression that makes future universes faster and unlocks deeper systems.

The visual fantasy escalates through:

**Scrapyard → Factory → Planetary Industry → Solar-System Industry → Galactic Engineering → Reality-Bending Technology**

## 2. Core design pillars

1. **Visible growth** — progression should physically transform the player's factory and world.
2. **Automation over clicking** — manual input helps onboarding, but automation becomes the primary loop.
3. **Frequent decisions** — players regularly choose what machine, upgrade, research node, or world to pursue next.
4. **Meaningful prestige** — resets should create noticeable acceleration and unlock new strategic options.
5. **Readable complexity** — launch with a small number of currencies and systems, then layer depth over time.
6. **Fair free progression** — monetization accelerates or customizes a satisfying free game instead of repairing artificial frustration.

## 3. Core loop

> Salvage → Earn Credits → Build Machines → Automate Production → Upgrade Machines → Unlock Worlds → Research Technology → Reach Singularity → Prestige → Earn Singularity Cores → Repeat

### Early-session progression target

These are initial design targets and must be validated through analytics and playtesting.

| Approximate time | Expected experience |
|---|---|
| 0–30 sec | Collect scrap and feed the first recycler |
| 30 sec–2 min | Purchase first automated Recycler |
| 2–5 min | Add Smelter/conveyor automation |
| 5–10 min | Upgrade production line |
| 10–20 min | Unlock second industrial area/world milestone |
| 20–35 min | Reach first major progression wall and solve it with upgrades/research |
| ~30 min | First Singularity target |
| Post-prestige | Previous content clears substantially faster |

## 4. Currencies

Launch with only three persistent gameplay currencies.

| Currency | Purpose | Resets on Singularity? |
|---|---|---:|
| Credits | Main production/purchase currency | Yes |
| Research | Technology-tree progression | Usually yes; exact rules subject to balancing |
| Singularity Cores | Permanent prestige currency | No |

Potential future currencies:

- **Quantum Shards:** late-game meta progression.
- **Event Tokens:** temporary event economy.

Do not add additional currencies unless they create a distinct decision or progression layer.

## 5. Machines

Machines are the game's idle generators. They should exist physically in the world and visually improve as the player progresses.

| Tier | Machine | Fantasy / role |
|---|---|---|
| 1 | Scrap Recycler | Converts junk into basic value |
| 2 | Industrial Smelter | Processes refined material |
| 3 | Assembly Line | Manufactures components |
| 4 | Robot Factory | Produces automation technology |
| 5 | Fusion Reactor | Introduces high-energy industry |
| 6 | Nano Fabricator | Advanced material production |
| 7 | Quantum Printer | Manufactures matter directly |
| 8 | Antimatter Reactor | Extreme high-tier production |
| 9 | Dyson Foundry | Harvests stellar-scale energy |
| 10 | Reality Engine | Endgame reality manipulation |

### Machine upgrade dimensions

- **Speed:** shorter production cycle.
- **Output:** more value per cycle.
- **Capacity:** larger processing batches.
- **Efficiency:** reduced input or cost requirements where relevant.
- **Automation:** removes manual actions.
- **Evolution:** upgrades model, effects, and sometimes function.

### Milestone levels

Initial milestone candidates:

**10 → 25 → 50 → 100 → 250 → 500**

Milestones should produce more than a number increase. Important milestones should trigger visible evolution, new VFX, changed machine behavior, or a new bonus.

## 6. World progression

Worlds represent increasingly advanced industrial scale rather than arbitrary multiplier zones.

| World | Theme |
|---|---|
| Earth Scrapyard | Primitive recycling and basic automation |
| Industrial Moon | Heavy manufacturing |
| Mars Foundry | Robotics and automated assembly |
| Asteroid Belt | Large-scale extraction |
| Jupiter Station | Fusion industry |
| Neon Exoplanet | Nanotechnology |
| Dyson System | Stellar engineering |
| Black Hole Forge | Antimatter industry |
| Quantum Realm | Reality manipulation |
| Singularity | End-of-run prestige culmination |

**Launch scope:** 4–5 worlds only. The remaining worlds are future expansion targets.

Each world should add at least one of:

- a new machine category,
- a new production constraint,
- a new research branch,
- a visual transformation,
- a new automation behavior,
- a new strategic decision.

Avoid worlds that are only reskins with larger numbers.

## 7. Research system

Research is the medium-term progression layer inside a run.

Potential research branches:

### Production
- Output multipliers
- Machine speed
- Milestone bonuses
- Cross-machine synergies

### Automation
- Auto-buy machines
- Auto-upgrade
- Auto-research
- Smarter purchasing rules

### Efficiency
- Cost reduction
- Faster unlock requirements
- Better offline conversion

### Specialization
- Robotics
- Fusion
- Nanotechnology
- Quantum engineering

Some research nodes should change how the game plays, not only increase multipliers.

## 8. Prestige: Singularity

Prestige is called **Singularity**.

The player eventually generates enough energy/value to create a miniature singularity, destroying the current industrial empire and converting the run's accomplishments into permanent **Singularity Cores**.

Example permanent benefits:

- +15% global production
- +10% machine speed
- Higher starting Credits
- Improved offline production
- Increased Research gain
- New automation nodes
- New starting-world shortcuts

### Prestige objective

A prestige should create an obvious power jump. Early runs could target progression like:

- Run 1: ~30 min
- Run 2: ~18 min
- Run 3: ~11 min
- Run 4: ~7 min

Later mechanics should extend the game again so players do not permanently collapse into seconds-long loops.

## 9. Permanent Singularity tech tree

Possible branches:

### Production
- Production I
- Production II
- Machine Mastery
- Mass Production

### Automation
- Auto Purchase
- Auto Upgrade
- Auto Research
- Advanced Automation

### Offline
- Offline Capacity
- Offline Efficiency
- Offline Research

### Expansion
- World Cost Reduction
- Starting World Bonus
- Research Boost

### Specialization
- Robotics
- Fusion
- Quantum Engineering

The permanent tree should contain both multiplier nodes and mechanic-changing nodes.

## 10. Offline progression

On return, show a concise summary such as:

> While you were away: 12.8B Credits

The base game must provide useful offline progress.

Potential cap progression:

**2h → 4h → 8h → 12h → 24h**

Paid benefits may improve offline efficiency/cap but should not make free offline progress meaningless.

## 11. Quests

Quest categories:

- **Progression:** purchase 10 Smelter upgrades.
- **Production:** produce 1M Credits.
- **Exploration:** reach Mars.
- **Prestige:** perform a Singularity.
- **Research:** complete a technology branch.
- **Social:** visit another factory.

Daily missions can be introduced once the base progression loop is proven.

## 12. Achievements

Examples:

- First Machine
- Industrialist
- First Million
- First Billion
- First Singularity
- 10 Singularities
- 100 Singularities
- Reach Mars
- Unlock Quantum Technology
- Own 100 Machines

Rewards may include cosmetics, titles, small permanent bonuses, or resources.

## 13. Blueprints / collection system

Instead of generic pet hatching, use **Blueprints** that fit the industrial fantasy.

Examples:

- Prototype Recycler
- Military Smelter
- Cyber Assembly Line
- Alien Fabricator
- Void Reactor
- Golden Dyson Forge

Blueprints can change appearance and provide modest specialization bonuses.

Launch with a small version or defer until the core game is validated.

## 14. Robots

Robots are a future/secondary progression system that can visibly inhabit the factory.

| Robot | Specialty |
|---|---|
| Loader Bot | Conveyor efficiency |
| Engineer Bot | Upgrade discount |
| Research Bot | Research bonus |
| Mining Bot | Raw-material bonus |
| Quantum Bot | Late-game production |

Robots should move around the player's world so they contribute to visual progression.

## 15. Social systems

Idle Universe should not feel like isolated single-player games sharing a server.

Potential social features:

- Factory visits
- Factory likes
- Friend production bonus with reasonable caps
- Visible Singularity count/prestige status
- Player titles
- Factory showcases
- Cooperative server milestones

Example server objective:

> Produce 10 Quadrillion Credits as a server. Everyone receives a Research Booster.

Guilds/clans should be deferred until there is evidence they would improve retention.

## 16. Leaderboards

Possible boards:

| Board | Metric |
|---|---|
| Production | Lifetime Credits |
| Singularities | Prestige count |
| Research | Research completed |
| Factory Value | Total upgrades/value |
| Seasonal | Current season score |

Seasonal boards prevent permanent domination by launch-day players.

## 17. Tutorial / onboarding

The tutorial should be interactive rather than dialogue-heavy.

**Collect Scrap → Buy Recycler → Watch Automation Start → Collect Credits → Upgrade Recycler → Unlock Conveyor → Receive Next Goal**

The player should understand the core fantasy in the first minute without reading a wall of text.

## 18. UI structure

### Main HUD

- Credits
- Research
- Current income/sec
- Active quest
- Bottom navigation

### Primary screens

- Machines
- Research
- Worlds
- Singularity
- Missions
- Collection
- Shop
- Settings

Design mobile-first with large touch targets, readable hierarchy, and minimal unnecessary text.

## 19. Number formatting

Build centralized number formatting early.

Examples:

- 1,000 = 1K
- 1,000,000 = 1M
- 1,000,000,000 = 1B
- 1e12 = 1T
- 1e15 = 1Qa
- 1e18 = 1Qi

If progression exceeds conventional suffixes, adopt a consistent scientific/engineering notation or large-number abstraction rather than scattering custom formatting logic throughout UI code.

## 20. V1 content target

- 4–5 worlds
- 8–10 machines
- 20–40 meaningful upgrade nodes/milestones across the launch progression
- 1 prestige currency
- 1 permanent prestige tree
- Offline progress
- Quests
- Achievements
- Basic factory visits
- Basic leaderboards

The exact counts are flexible. The goal is a polished, coherent progression loop rather than maximum content volume.