# Analytics, Launch & LiveOps

## 1. Commercial flywheel

The intended product loop is:

```text
Strong icon / thumbnail
        ↓
Player joins
        ↓
Fun understood within the first minute
        ↓
Visible progression and automation
        ↓
Player develops short- and long-term goals
        ↓
Singularity creates a meaningful meta loop
        ↓
Player returns
        ↓
Investment in factory/account grows
        ↓
Optional purchases become relevant
        ↓
Revenue funds content, polish, and acquisition
        ↓
Better game and larger audience
```

The central principle is that monetization multiplies a healthy game; it does not replace retention.

## 2. Core analytics events

Instrument these before meaningful external testing.

### Onboarding

- `session_started`
- `tutorial_started`
- `first_scrap_collected`
- `first_machine`
- `first_upgrade`
- `first_automation`
- `tutorial_completed`

### Progression

- `first_research`
- `world_unlocked`
- `machine_milestone`
- `research_completed`
- `singularity_available`
- `singularity_completed`
- `quest_completed`
- `achievement_completed`
- `offline_reward_claimed`

### Monetization

- `shop_opened`
- `product_viewed`
- `offer_viewed`
- `purchase_prompted`
- `purchase_completed`
- `purchase_fulfilled`

### Social

- `factory_visited`
- `server_goal_contributed`
- `leaderboard_viewed`

## 3. Primary funnels

### First-session funnel

```text
JOIN
 ↓
FIRST SCRAP
 ↓
FIRST MACHINE
 ↓
FIRST UPGRADE
 ↓
FIRST AUTOMATION
 ↓
FIRST RESEARCH
 ↓
WORLD 2
 ↓
SINGULARITY AVAILABLE
 ↓
FIRST SINGULARITY
```

### Monetization funnel

```text
SHOP / CONTEXTUAL OFFER VIEW
 ↓
PRODUCT VIEW
 ↓
PURCHASE PROMPT
 ↓
PURCHASE COMPLETE
 ↓
FULFILLMENT CONFIRMED
```

Keep purchase completion and fulfillment separate so technical failures are visible.

## 4. KPI hierarchy

Interpret metrics in this order:

1. **Technical health** — can players load, save, and play without errors?
2. **Onboarding completion** — do players understand the core loop?
3. **Engagement** — are sessions long enough to reach meaningful systems?
4. **Retention** — do players return on D1, then D7/D30 as the cohort matures?
5. **Progression health** — where do players stall or quit?
6. **Monetization** — payer conversion, revenue mix, ARPPU/ARPDAU where available.
7. **Acquisition efficiency** — does the lifetime value of acquired players justify spend?

Do not scale paid acquisition before retention and technical stability are credible.

## 5. Progression diagnostics

Track distributions, not only averages.

Useful measurements:

- time to first machine,
- time to first upgrade,
- time to first automation,
- time to each world,
- time to first Singularity,
- Singularities per session/day,
- Research-node selection order,
- machine-level distribution,
- percentage of players hitting each progression wall,
- offline-return reward sizes,
- quest completion rate.

Averages can hide groups that are stuck or racing too quickly.

## 6. Monetization diagnostics

Track:

- payer conversion,
- first purchase timing,
- first purchased SKU,
- product mix,
- repeat-purchase rate,
- pass ownership,
- boost usage,
- revenue per active user where available,
- revenue per payer,
- retention of payers versus non-payers,
- progression effect of purchases.

Watch for a product that generates revenue but causes players to skip so much content that future retention declines.

## 7. Alpha testing

### Small external cohort

Target approximately 5–20 external testers initially.

Observe players without explaining the interface.

Record:

- where they hesitate,
- what they misunderstand,
- which buttons they overlook,
- where they expect feedback and receive none,
- how quickly they discover automation,
- whether they understand Research and Singularity,
- whether the game feels active enough while idling.

Treat repeated confusion as a design/UI problem rather than a player problem.

## 8. Beta testing

With a larger cohort:

- validate event instrumentation,
- collect device/performance data,
- measure first-session funnel,
- measure progression pacing,
- measure initial return behavior,
- validate monetization technically,
- identify exploit patterns,
- validate server population performance.

The goal is evidence, not maximum revenue.

## 9. Soft launch

Use limited traffic first.

### Questions to answer

- Do new players reach automation quickly?
- Where is the largest funnel drop?
- What percentage reaches first Singularity?
- Does first Singularity correlate with return behavior?
- Are saves reliable?
- Are lower-end mobile devices stable?
- Is there a progression wall that causes mass exits?
- Which monetization products are understood and used?
- Do paid boosts preserve enough gameplay to maintain future goals?

### Response loop

```text
Observe data
→ identify largest constraint
→ make targeted change
→ compare new cohort
→ repeat
```

Avoid simultaneously changing tutorial, economy, prices, and world progression unless necessary; otherwise it becomes difficult to identify causality.

## 10. Store acquisition assets

Before public launch prepare:

- icon,
- multiple thumbnails,
- accurate game description,
- strong first visual showing the transformation fantasy,
- optional short gameplay video/trailer.

The store promise should match what happens quickly after joining.

A thumbnail showing planet-scale factories is weak if the first session is visually a blank base for twenty minutes. Bring the fantasy forward early.

## 11. Public launch readiness checklist

### Product
- Core loop is understandable.
- First Singularity loop is complete.
- V1 content is polished.
- Free progression is viable.

### Data
- Save/load is reliable.
- Migrations are tested.
- Failure diagnostics exist.

### Security
- Economy is server-authoritative.
- Remotes are validated.
- Receipt fulfillment is secure.
- Reward duplication paths have been tested.

### Performance
- Target mobile devices are tested.
- Full-server behavior is acceptable.
- Heavy visual systems have LOD/pooling/culling where needed.

### Analytics
- Onboarding funnel works.
- Progression events work.
- Prestige events work.
- Monetization events work.

### Presentation
- Icon and thumbnails are final enough for testing.
- Tutorial and UI are mobile-ready.
- Audio/VFX provide sufficient feedback.

## 12. LiveOps priorities

After launch, prioritize in this order unless data indicates otherwise:

1. Critical bugs / progress loss.
2. Exploits / economy integrity.
3. Onboarding and retention problems.
4. Performance.
5. Balance / progression walls.
6. Quality-of-life improvements.
7. New content.
8. New monetization surfaces.

New content should not be used to distract from a broken first session.

## 13. Content pipeline

Potential update rhythm:

- **1.1:** bug fixes, balance, quality of life.
- **1.2:** new world and machines.
- **1.3:** Blueprints expansion.
- **1.4:** Robots expansion.
- **1.5:** social/server systems.
- **2.0:** Dyson System major progression update.
- **2.1:** subscription if recurring value is proven.
- **2.2:** first major themed event.
- **2.5:** seasons if the game supports sustained return play.
- **3.0:** Quantum Realm / second meta layer.

The sequence is provisional. Player data should decide which branch receives development time.

## 14. Systems intentionally deferred

Do not prioritize these during initial development:

- trading,
- guilds,
- PvP,
- dozens of currencies,
- multiple prestige layers,
- massive maps,
- huge generic pet-hatching systems,
- fifty launch worlds.

Each adds cost and complexity before the core product is validated.

## 15. Identity to preserve

Idle Universe should remain recognizable as:

> A visually escalating industrial automation game where the player grows from scrap machinery to planet-scale and reality-bending engineering.

Future features should reinforce that identity rather than copying unrelated Roblox trends.

## 16. Decision framework for future features

Before adding a feature, answer:

1. Which player problem does it solve?
2. Which loop does it strengthen: acquisition, onboarding, progression, retention, social, or monetization?
3. Can its success be measured?
4. Does it fit the industrial-universe fantasy?
5. What ongoing content/maintenance burden does it create?
6. Can a smaller version prove the idea first?
7. What existing work must be delayed to build it?

If those questions have weak answers, the feature should remain deferred.