# Technical Architecture

## 1. Architectural goals

Idle Universe should be:

- server-authoritative for economy-critical actions,
- config-driven so content can be added without rewriting systems,
- modular enough for live updates,
- resilient to DataStore and network failures,
- measurable through analytics events,
- performant on mobile hardware,
- migration-safe as player data evolves.

## 2. Proposed Roblox structure

```text
ReplicatedStorage
├── Shared
│   ├── Config
│   │   ├── Machines.lua
│   │   ├── Worlds.lua
│   │   ├── Research.lua
│   │   ├── Prestige.lua
│   │   ├── Quests.lua
│   │   └── Monetization.lua
│   ├── Constants.lua
│   ├── Types.lua
│   ├── NumberFormatter.lua
│   ├── EconomyMath.lua
│   └── Utilities
├── Remotes
│   ├── Requests
│   └── Events
└── Assets

ServerScriptService
├── Services
│   ├── DataService.lua
│   ├── EconomyService.lua
│   ├── MachineService.lua
│   ├── ResearchService.lua
│   ├── WorldService.lua
│   ├── PrestigeService.lua
│   ├── QuestService.lua
│   ├── AchievementService.lua
│   ├── OfflineService.lua
│   ├── PurchaseService.lua
│   ├── AnalyticsService.lua
│   └── SecurityService.lua
└── ServerMain.server.lua

StarterPlayer
└── StarterPlayerScripts
    ├── Controllers
    │   ├── UIController.lua
    │   ├── MachineController.lua
    │   ├── EffectsController.lua
    │   ├── AudioController.lua
    │   └── InputController.lua
    └── ClientMain.client.lua
```

Exact naming can change, but the separation of concerns should remain.

## 3. Server authority

The client may request an action such as:

```text
PurchaseMachine(machineId)
```

The server must independently verify:

1. the machine exists,
2. the player is allowed to access it,
3. the current server-side price,
4. the player's server-side balance,
5. any prerequisites,
6. rate limits / duplicate requests,
7. the resulting state transition.

The client must never be trusted to provide final currency values, prices, rewards, prestige payouts, or purchase ownership.

## 4. Data model

Conceptual profile:

```lua
{
    Credits = 0,
    Research = 0,
    Cores = 0,

    Machines = {},
    MachineLevels = {},
    ResearchNodes = {},
    WorldsUnlocked = {},

    Singularities = 0,
    LifetimeCredits = 0,

    Quests = {},
    Achievements = {},

    Robots = {},
    Blueprints = {},

    Purchases = {},

    LastLogout = 0,
    Playtime = 0,

    DataVersion = 1,
}
```

The final schema should avoid redundant data where possible and clearly distinguish derived values from persisted values.

## 5. DataService responsibilities

- Load profile on join.
- Lock sessions to avoid concurrent-write corruption.
- Supply a default profile for new players.
- Validate/migrate old versions.
- Expose controlled mutation APIs to other server services.
- Save periodically and on shutdown/leave where appropriate.
- Handle transient DataStore failures with bounded retries/backoff.
- Never silently overwrite valid player progress with empty/default data after a failed load.
- Track save/load failures through analytics/logging.

## 6. Data migrations

Every persisted profile includes `DataVersion`.

Example migration chain:

```text
v1 → v2: add ResearchNodes
v2 → v3: convert old machine table format
v3 → v4: add blueprint inventory
```

Migrations should be deterministic and tested with sample historical profiles.

## 7. EconomyService

Responsibilities:

- Read/add/spend currencies.
- Validate affordability.
- Calculate production multipliers.
- Apply global bonuses.
- Produce transaction records/events for analytics.

Prefer APIs like:

```text
CanAfford(player, currency, amount)
Spend(player, currency, amount, reason)
Award(player, currency, amount, reason)
```

Avoid arbitrary direct mutation from unrelated services.

## 8. MachineService

Responsibilities:

- Instantiate machines from config.
- Calculate purchase/upgrade costs.
- Calculate production.
- Process milestone upgrades.
- Validate machine ownership/unlocks.
- Synchronize machine state to clients.
- Trigger visual state changes through replicated state/events.

Machine definitions should be data-driven.

## 9. ResearchService

Responsibilities:

- Validate prerequisites.
- Charge Research/other required resources.
- Unlock research nodes.
- Provide modifiers to Economy/Machine/World systems.
- Prevent circular or impossible dependency graphs.

## 10. WorldService

Responsibilities:

- Determine unlock requirements.
- Validate travel/access.
- Track unlocked worlds.
- Expose content availability based on world progression.

## 11. PrestigeService

Responsibilities:

- Determine whether Singularity is available.
- Calculate Core reward entirely server-side.
- Present preview values to client.
- Reset only intended run-level state.
- Preserve permanent progression.
- Apply post-prestige starting bonuses.
- Record analytics for prestige timing/rewards.

Prestige should be processed atomically enough that interruption cannot duplicate rewards.

## 12. OfflineService

On load:

1. Read server-saved `LastLogout`/last-valid timestamp.
2. Calculate elapsed time.
3. Clamp to allowed offline duration.
4. Reconstruct eligible production rate from trusted persisted state.
5. Calculate reward server-side.
6. Apply caps/sanity checks.
7. Grant once.
8. Record the calculation for analytics/debugging.

Do not trust client clock values.

## 13. QuestService / AchievementService

Use server-generated gameplay events such as:

```text
MachinePurchased
MachineUpgraded
CurrencyEarned
WorldUnlocked
ResearchCompleted
PrestigeCompleted
```

Quest progress should react to authoritative events rather than client reports.

## 14. PurchaseService

Responsibilities:

- Handle pass ownership checks.
- Handle repeatable developer-product receipt processing.
- Ensure rewards are idempotent where required.
- Maintain any necessary fulfillment state.
- Expose shop product metadata to UI.
- Record purchase funnel events.

Never grant a developer product solely because a client says a prompt succeeded.

## 15. SecurityService

Centralize reusable protections:

- remote rate limiting,
- type validation,
- range validation,
- state validation,
- suspicious-action logging,
- exploit heuristics where appropriate.

Validation should also exist at each domain service boundary; SecurityService is not a substitute for correct service logic.

## 16. Remote-event rules

Every client-to-server remote should have:

- a narrow purpose,
- explicit argument types,
- bounds checking,
- ownership/state checking,
- rate limiting where spam is possible,
- no arbitrary instance paths supplied by the client unless independently validated.

Prefer semantic requests (`PurchaseMachine("Smelter")`) over generic mutation remotes (`SetValue(path, value)`).

## 17. Configuration-driven content

Content definitions should contain fields such as:

```lua
{
    Id = "ScrapRecycler",
    BaseCost = 10,
    CostGrowth = 1.15,
    BaseOutput = 1,
    World = "Earth",
    UnlockRequirements = {...},
    Milestones = {...},
}
```

The goal is to make new machines/worlds/research primarily a content/config task rather than a systems rewrite.

## 18. Client responsibilities

The client owns presentation and responsiveness:

- UI rendering
- button interaction
- animation
- local VFX/SFX
- camera feedback
- input abstraction
- optimistic cosmetic feedback when safe

It does **not** own final economy state.

## 19. Mobile-first constraints

- Large touch targets.
- No gameplay requiring precise mouse-only interaction.
- Scalable UI constraints/aspect ratios.
- Avoid excessive simultaneous particles.
- Avoid thousands of independently simulated physical parts.
- Use LOD/culling/pooling strategies where needed.
- Test on lower-end devices throughout development, not only before release.

## 20. Factory visualization strategy

The factory can look complex without simulating every object as high-cost physics.

Possible techniques:

- anchored conveyor visuals,
- pooled moving product models,
- client-side cosmetic item movement,
- simplified server production state,
- distance-based update reduction,
- animation rather than physics where possible.

The production economy should not depend on every visible item physically reaching a destination.

## 21. Testing requirements

Automated/unit-test candidates:

- cost formulas,
- output formulas,
- prestige calculations,
- number formatting,
- migration functions,
- quest progress rules,
- unlock requirement evaluation.

Manual/integration testing:

- reconnect/save behavior,
- server shutdown,
- failed DataStore calls,
- multiple rapid purchase requests,
- mobile UI,
- high-latency interaction,
- receipt processing,
- prestige interruption,
- offline reward edge cases.

## 22. Definition of technical readiness for beta

- No known progress-loss bug.
- Economy actions are server-authoritative.
- Purchase fulfillment is verified and idempotent where necessary.
- Core remotes are validated/rate-limited.
- Data migrations work against historical fixtures.
- Mobile performance is acceptable on target hardware.
- Analytics events are emitted for core funnel/progression actions.
- Error logging provides enough context to diagnose failures.