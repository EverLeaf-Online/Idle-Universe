# Production Roadmap

This is the build sequence for taking Idle Universe from an empty repository to a commercially testable Roblox release.

Each phase has a clear exit condition. Do not move significant effort into later phases while earlier foundations are still unstable.

## Phase 0 — Product definition

### Tasks
- Lock the working concept: Idle Universe.
- Define target audience and device priorities.
- Define the core fantasy and visual progression.
- Define a first-session target experience.
- Define launch scope versus future scope.
- Define monetization principles.

### Exit condition
A concise product vision exists and everyone building the game can describe the core loop consistently.

---

## Phase 1 — Game design specification

### Tasks
- Finalize currencies.
- Finalize launch machines.
- Finalize launch worlds.
- Define machine upgrade dimensions.
- Define Research structure.
- Define Singularity prestige behavior.
- Define permanent Core tree.
- Define offline progression.
- Define quests and achievements.
- Define basic social systems.
- Define V1 UI screens.

### Exit condition
Every major V1 system has written rules and dependencies.

---

## Phase 2 — Economy model

### Tasks
- Create machine base costs.
- Create machine cost-growth rates.
- Create base outputs.
- Create milestone multipliers.
- Set world unlock requirements.
- Set Research costs/bonuses.
- Create first prestige formula.
- Define Core-tree costs.
- Define offline-income formula.
- Simulate first run.
- Simulate several prestige cycles.
- Create a balance sheet/spreadsheet for all configurable values.

### Exit condition
A theoretical player can be simulated from new account to first several Singularities with expected timing.

---

## Phase 3 — Greybox prototype

### Tasks
- Create a simple test plot.
- Add one currency.
- Add one manual earning interaction.
- Add one automated machine.
- Add one upgrade.
- Display income/sec.
- Add placeholder UI.

### Exit condition
The basic act → earn → buy → automate → improve loop can be played inside Roblox Studio.

---

## Phase 4 — Persistence foundation

### Tasks
- Define player profile schema.
- Implement DataService.
- Add default profiles.
- Add session-safety/locking approach.
- Add periodic saves.
- Add leave/shutdown handling.
- Add bounded retry behavior.
- Add DataVersion.
- Add migration framework.
- Add load/save diagnostics.

### Exit condition
Player progression reliably survives reconnects and failure states do not silently replace valid data with defaults.

---

## Phase 5 — Economy backend

### Tasks
- Implement server-side currency APIs.
- Implement transaction reasons/logging.
- Implement affordability checks.
- Implement purchase validation.
- Centralize economy math.
- Add number-formatting utilities.
- Ensure clients cannot authoritatively set economy values.

### Exit condition
All core economy mutations are controlled by server services.

---

## Phase 6 — Machine framework

### Tasks
- Create config-driven machine definitions.
- Implement purchase logic.
- Implement upgrade logic.
- Implement production calculations.
- Implement machine levels.
- Implement milestone bonuses.
- Implement unlock requirements.
- Implement machine visual-state replication.
- Build first several machine models or placeholders.

### Exit condition
A new machine can be introduced mainly through configuration/assets rather than custom economy code.

---

## Phase 7 — Research and world progression

### Tasks
- Implement ResearchService.
- Implement research prerequisites.
- Apply research modifiers.
- Implement WorldService.
- Implement world unlock conditions.
- Add travel/navigation.
- Add content gating per world.
- Add placeholder launch worlds.

### Exit condition
The player can advance through a complete pre-prestige progression path.

---

## Phase 8 — Singularity prestige

### Tasks
- Implement eligibility calculation.
- Implement Core reward preview.
- Implement server-side reward formula.
- Define/reset run-scoped data.
- Preserve permanent progression.
- Implement permanent Core tree.
- Add prestige confirmation UI.
- Add prestige VFX/sequence placeholder.
- Protect against duplicate rewards/interruption.

### Exit condition
The full main loop works: new player → progression → Singularity → stronger new run.

---

## Phase 9 — Offline progression

### Tasks
- Persist trusted last-active timestamps.
- Calculate elapsed offline duration server-side.
- Apply cap and efficiency.
- Reconstruct eligible production.
- Grant reward once.
- Create return summary UI.
- Test clock/edge cases.

### Exit condition
Players receive predictable, bounded offline progress without trusting the client clock.

---

## Phase 10 — UI foundation

### Tasks
- Main HUD.
- Currency displays.
- Income/sec display.
- Machine screen.
- Research screen.
- Worlds screen.
- Singularity screen.
- Missions screen.
- Shop shell.
- Settings screen.
- Responsive/mobile constraints.
- Controller/console consideration if supported.

### Exit condition
The entire V1 loop is usable on target devices without Studio-only controls or developer intervention.

---

## Phase 11 — Onboarding

### Tasks
- Guide first scrap collection.
- Guide first Recycler purchase.
- Show automation visually.
- Guide first upgrade.
- Introduce Research at the correct moment.
- Introduce world unlocks.
- Delay monetization until the player understands the loop.
- Instrument tutorial funnel events.

### Exit condition
New testers can understand and complete the opening without verbal explanation from the developer.

---

## Phase 12 — Initial content production

### Launch target
- 4–5 worlds.
- 8–10 machines.
- Meaningful milestone upgrades.
- Research branches.
- One complete Singularity tree.
- Approximately 1–3 hours of initial progression before deeper repetition/meta goals.

### Tasks
- Finalize machine models.
- Finalize world art/environment.
- Add animations.
- Add unlock sequences.
- Add progression VFX.
- Add sounds.
- Add world-specific mechanics where applicable.

### Exit condition
The game has enough coherent content for external alpha testing.

---

## Phase 13 — Quests and achievements

### Tasks
- Implement authoritative gameplay event bus/signals.
- Implement quest definitions.
- Implement quest progress.
- Implement reward claims.
- Implement achievements.
- Add milestone rewards.
- Add daily missions only if needed for the first test cohort.

### Exit condition
Players have clear short-term objectives beyond watching production numbers.

---

## Phase 14 — Social layer

### Tasks
- Factory visits.
- Player identity/title display.
- Basic server cooperative goal.
- Basic leaderboards.
- Optional friend bonus with cap.
- Social analytics.

### Exit condition
Other players contribute visible value to the experience without being required for core progression.

---

## Phase 15 — Game feel and presentation

### Tasks
- Purchase feedback.
- Currency fly effects where appropriate.
- Machine activation animations.
- Upgrade/evolution sequences.
- Prestige sequence.
- Audio feedback.
- Camera feedback used sparingly.
- Improved transitions.
- UI animation polish.

### Exit condition
Core actions feel satisfying even when viewed repeatedly.

---

## Phase 16 — Monetization V1

### Tasks
- Configure launch passes.
- Configure developer products.
- Implement PurchaseService.
- Implement receipt processing.
- Implement pass ownership checks.
- Add Shop UI.
- Add dynamic currency-package calculation if used.
- Add contextual offer framework.
- Add purchase analytics.
- Test every product in safe test environments.

### Exit condition
All paid items grant exactly what they promise and cannot be spoofed through client remotes.

---

## Phase 17 — Retention V1

### Tasks
- Offline rewards.
- Achievements.
- Missions.
- Return goals.
- Optional daily reward structure.
- Avoid punitive streak designs that make missing one day feel catastrophic.

### Exit condition
A returning player has a meaningful next action and can see persistent progress.

---

## Phase 18 — Analytics instrumentation

### Tasks
Track at minimum:
- tutorial_started
- tutorial_completed
- first_machine
- first_upgrade
- first_research
- world_2_unlocked
- world_3_unlocked
- singularity_available
- first_singularity
- singularity_completed
- quest_completed
- shop_opened
- offer_viewed
- purchase_started
- purchase_completed
- session progression checkpoints

### Exit condition
Core onboarding, progression, prestige, and monetization funnels are measurable.

---

## Phase 19 — Security hardening

### Tasks
- Audit all client-to-server remotes.
- Add type/range validation.
- Add rate limits.
- Validate ownership/prerequisites.
- Audit prestige duplication paths.
- Audit reward claims.
- Audit offline rewards.
- Audit purchase fulfillment.
- Add suspicious-action logging where useful.

### Exit condition
No obvious client-controlled path can directly grant arbitrary currency, progression, or paid rewards.

---

## Phase 20 — Performance optimization

### Tasks
- Profile server CPU.
- Profile client CPU/GPU.
- Measure memory.
- Reduce replicated instance count.
- Pool cosmetic moving objects where useful.
- Replace unnecessary physics with animation.
- Add distance-based update reduction/LOD.
- Test low-end mobile devices.
- Stress-test full servers.

### Exit condition
The game remains stable and responsive on intended target devices with realistic server populations.

---

## Phase 21 — Internal alpha

### Cohort
Developer/team + roughly 5–20 external testers.

### Tasks
- Observe without explaining.
- Record confusion points.
- Record progression timing.
- Record save issues.
- Collect device/performance problems.
- Identify dominant/ignored upgrades.

### Exit condition
Major usability and progression defects are understood and prioritized.

---

## Phase 22 — Balance pass

### Tasks
- Tune early purchase cadence.
- Tune world gates.
- Tune first Singularity timing.
- Tune Core rewards.
- Tune research choices.
- Remove dead upgrades.
- Fix progression cliffs.
- Ensure paid boosts do not trivialize content.

### Exit condition
The economy produces the intended pacing across several representative player strategies.

---

## Phase 23 — Beta

### Cohort
Larger controlled player group.

### Tasks
- Validate analytics pipeline.
- Measure tutorial completion.
- Measure first-session drop-offs.
- Measure world progression.
- Measure first prestige completion.
- Measure return behavior.
- Measure monetization interaction without over-optimizing it yet.

### Exit condition
There is enough real behavior data to make evidence-based launch decisions.

---

## Phase 24 — Store packaging

### Tasks
- Final game icon.
- Thumbnails.
- Title/subtitle positioning.
- Description.
- Feature graphics.
- Short gameplay footage/trailer if useful.
- Ensure store promise matches actual first-session experience.

### Exit condition
The experience has launch-quality presentation outside the game.

---

## Phase 25 — Soft launch

### Tasks
- Release to a controlled audience / limited acquisition.
- Watch technical health.
- Track D1 behavior.
- Track onboarding funnel.
- Track first Singularity funnel.
- Track payer conversion and product mix, but prioritize retention interpretation first.
- Gather qualitative feedback.

### Exit condition
A trustworthy baseline exists for retention, progression, technical stability, and monetization.

---

## Phase 26 — Optimization

### Tasks
- Fix the largest first-session drop-offs.
- Improve unclear UI.
- Rebalance progression walls.
- Rework weak offers/products.
- Improve performance hotspots.
- Improve thumbnails/icon if acquisition quality is weak.
- Run controlled tests where traffic supports them.

### Exit condition
Key metrics improve enough to justify broader traffic acquisition.

---

## Phase 27 — Public launch

### Tasks
- Broaden distribution.
- Begin planned marketing/acquisition.
- Monitor errors and economy anomalies.
- Keep rapid-response balance/config capability.
- Publish first post-launch communication/update plan.

### Exit condition
The game is operating as a stable commercial live product.

---

## Phase 28 — Live operations

### Update priorities
1. Bug fixes and balance.
2. Quality-of-life improvements.
3. New world/machine content.
4. Blueprint/robot collection expansion.
5. Social systems.
6. Cosmetics.
7. Subscription only when recurring value exists.
8. Seasonal content after the core loop proves long-term retention.
9. Second prestige layer only after the first meta layer is substantially exhausted.

## Suggested update sequence

| Version | Focus |
|---|---|
| 1.1 | Bug fixes, balance, QoL |
| 1.2 | New world |
| 1.3 | Blueprint collection expansion |
| 1.4 | Robot-system expansion |
| 1.5 | Social/server systems |
| 2.0 | Dyson System / major progression expansion |
| 2.1 | Galactic Engineer Club subscription, if justified |
| 2.2 | First themed event |
| 2.5 | Seasons, if justified |
| 3.0 | Quantum Realm + second meta-progression layer |

Do not publicly commit to the entire sequence until live player data shows what players value.

# V1 scope guardrails

## Build for V1

- 4–5 worlds
- 8–10 machines
- Credits / Research / Singularity Cores
- Machine upgrades
- Research
- Singularity prestige
- Permanent Core tree
- Offline progression
- Quests
- Achievements
- Basic social visits
- Basic leaderboards
- Mobile-first UI
- Persistence/migrations
- Monetization V1
- Analytics
- Security hardening
- Performance optimization

## Defer

- Full season pass
- Subscription
- Guilds
- Trading
- Large pet-like collection systems
- Second prestige layer
- Huge event framework
- Dozens of currencies
- 50+ launch worlds

Scope control is a feature. The fastest path to a profitable game is not the largest V1; it is the smallest polished product that can generate trustworthy retention and monetization data.