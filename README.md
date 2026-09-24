# Idle Universe

**Idle Universe** is a Roblox idle/automation game about growing from a primitive scrapyard into a civilization capable of building planet-scale industry and reality-bending machines.

## Core fantasy

Start with scrap and a basic recycler, then build increasingly powerful automated production systems. Expand from Earth to other worlds, research new technology, and eventually trigger a **Singularity** that resets the current empire in exchange for permanent progression.

**Core loop:**

> Salvage → Earn Credits → Build Machines → Automate Production → Upgrade → Unlock Worlds → Research → Reach Singularity → Prestige → Earn Singularity Cores → Repeat

The game should feel visually transformative: a player's plot evolves from rusty machinery into a dense sci-fi industrial empire.

## Product goals

- Deliver satisfying idle progression without relying on constant clicking.
- Make automation and visible factory growth the primary reward.
- Support short-term goals, long-term prestige progression, and offline progress.
- Use server-authoritative economy systems and robust persistence.
- Monetize through optional acceleration, convenience, cosmetics, and later subscriptions/seasons rather than making free progression deliberately unpleasant.
- Launch with a focused V1, then expand based on retention, progression, and monetization data.

## Documentation

- [Game Design](docs/01-game-design.md)
- [Economy & Progression](docs/02-economy-progression.md)
- [Technical Architecture](docs/03-technical-architecture.md)
- [Monetization](docs/04-monetization.md)
- [Production Roadmap](docs/05-production-roadmap.md)
- [Analytics, Launch & LiveOps](docs/06-analytics-launch-liveops.md)

## Initial V1 scope

- 4–5 worlds
- 8–10 machines
- Credits, Research, and Singularity Cores
- Machine upgrades and visual evolution
- Research tree
- Singularity prestige system
- Offline progression
- Quests and achievements
- Basic social factory visits and leaderboards
- Mobile-first UI
- Saving/data migration foundation
- Server-side economy validation and anti-exploit controls
- Passes and developer products
- Analytics instrumentation

## Deferred until after the core game proves retention

- Subscription
- Season pass
- Large blueprint collection
- Expanded robot collection
- Guilds
- Trading
- Second prestige layer
- Major live events

## Development principle

Build and validate in this order:

**Core loop → economy → persistence → machines → research → worlds → prestige → offline progress → UI/onboarding → content → social/retention → monetization → analytics/security/performance → alpha/beta → soft launch → optimization → public launch.**

This repository is the source of truth for project design and development decisions.