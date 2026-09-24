# Monetization Strategy

## 1. Objective

Idle Universe should be designed to become commercially sustainable without making the free experience intentionally frustrating.

The order of operations is:

**Retention → engagement → player goals → optional purchases → reinvestment into content/acquisition**

No monetization system should be considered successful if it improves short-term purchase rate while materially damaging retention or trust.

## 2. Monetization principles

1. Free progression must remain satisfying.
2. Paid options should accelerate, automate, customize, or expand rather than unlock the only viable path.
3. Avoid constant purchase interruptions.
4. Contextual offers should appear after meaningful achievements, not before the player understands the game.
5. Cosmetic monetization should grow over time because it can generate revenue without destabilizing balance.
6. Prices are hypotheses until tested with real conversion and revenue data.
7. All purchase fulfillment is server-validated.

## 3. Launch passes

Candidate launch catalogue:

| Pass | Initial test range | Benefit concept |
|---|---:|---|
| Starter Engineer | 49–79 R$ | Small permanent starter benefits |
| Double Production | 149–249 R$ | ×2 production |
| Double Research | 149–249 R$ | ×2 research |
| Offline Expert | 99–199 R$ | Improved offline efficiency/cap |
| Extra Robot Slots | 199–299 R$ | Additional robot slots once robots exist |
| VIP Engineer | 399–599 R$ | Moderate bundle + cosmetic/status benefits |

These are test ranges, not promises or final prices.

### Pass design rules

- Avoid stacking so many permanent multipliers that balancing free players becomes impossible.
- Make ownership obvious in UI.
- Do not repeatedly prompt a player for something they already declined in the same session.
- Ensure each benefit remains useful at late progression.

## 4. Developer products

Repeatable products are a natural fit for an idle economy.

Candidate products:

- Small Credit Boost
- Medium Credit Boost
- Large Credit Boost
- 15-minute Overclock
- 60-minute Overclock
- Research Surge
- Singularity Accelerator
- Event-specific boosts after live events exist

## 5. Dynamic currency packages

Fixed currency packages become obsolete as the economy scales. Prefer packages tied to current earning power.

Example concept:

```text
Small package  ≈ 10–15 minutes of current production
Medium package ≈ 30–45 minutes of current production
Large package  ≈ 90–120 minutes of current production
```

The actual equivalence must be tested.

Server rules:

- derive current production from trusted state,
- clamp extreme values,
- never accept a client-supplied production rate,
- calculate and grant from receipt processing,
- log the granted value for support/debugging.

## 6. Temporary boosts

Boosts are useful because they monetize active play without permanently distorting every future balance calculation.

Examples:

- ×2 production for 15 minutes
- ×2 research for 15 minutes
- machine overclock for 30 minutes
- world-specific production surge

Boost timers should use server-trusted time/state and survive reconnects if the product promise implies real elapsed duration.

## 7. Subscription — post-launch

Potential subscription name: **Galactic Engineer Club**

Possible monthly benefits:

- +15% production
- +15% Research
- improved offline cap
- extra robot slots
- daily Research reward
- exclusive nameplate/title
- periodic cosmetic machine skin

The subscription should be introduced only after the game demonstrates sufficient retention to justify recurring value.

## 8. Season pass — post-launch

Do not build a large seasonal system for V1.

Potential first season:

**Robot Revolution**

Players progress through normal gameplay:

- producing resources,
- upgrading machines,
- completing quests,
- performing Singularities,
- exploring worlds.

Reward types:

- machine skins
- robot cosmetics
- Research
- boosters
- titles
- emotes
- factory decorations

Use a free track plus an optional premium track.

## 9. Cosmetics

Long-term cosmetic categories:

- Factory themes
- Conveyor skins
- Machine skins
- Robot skins
- Production VFX
- Singularity animations
- Player trails
- Titles/nameplates
- Planet decorations
- Rocket skins

A late-game factory should be visually customizable enough that social visits create aspiration.

## 10. Contextual offers

Offers should connect to achievements.

Example after first Singularity:

```text
FIRST SINGULARITY COMPLETE

Starter Engineer Pack
• Exclusive Engineer cosmetic/robot
• Small permanent Research bonus
• Factory skin
```

Example after Mars unlock:

```text
MARS UNLOCKED

Mars Founder Pack
• Mars factory theme
• Production booster
• Exclusive title
```

Do not interrupt the first minute with monetization prompts.

## 11. Shop structure

Suggested shop categories:

- Recommended
- Passes
- Boosts
- Currency
- Cosmetics
- Subscription (later)

The default screen should not overwhelm the player with every SKU simultaneously.

## 12. Offer timing rules

Good triggers:

- First prestige completed
- New world unlocked
- Player voluntarily opens Shop
- Player reaches a clear progression milestone
- Return session after the player already understands the game

Avoid:

- immediate join popups,
- repeated modal prompts,
- prompts immediately after a loss/frustration wall,
- deceptive countdowns,
- UI designed to cause accidental purchase attempts.

## 13. Revenue model

Core operating model:

```text
DAU × payer conversion × average spend per payer = gross Robux revenue rate
```

Track revenue alongside:

- D1/D7/D30 retention
- session length
- progression depth
- payer conversion
- ARPPU/ARPDAU where available
- purchase mix
- refund/support issues
- acquisition spend

Never optimize payer conversion in isolation.

## 14. Monetization experiments

Potential controlled tests after sufficient traffic:

- price points,
- bundle composition,
- shop ordering,
- contextual-offer timing,
- cosmetic vs progression bundles,
- boost duration/value,
- pass descriptions/UI presentation.

Do not change multiple economy variables at once if it prevents interpretation of results.

## 15. Profitability framework

Commercial viability should eventually be modeled as:

```text
Earned revenue
- user acquisition
- contractors / art / audio
- tooling / services
- live-operations cost
= operating contribution
```

Do not assume a fixed cash conversion for every Robux. DevEx eligibility and rates can change and should be checked against current Roblox documentation when financial forecasts are made.

## 16. Monetization features deferred from V1

- Full season pass
- Subscription
- Large cosmetic catalogue
- Paid event systems
- Complex randomized monetization
- Trading-driven economy

V1 monetization should be deliberately simple so player behavior is understandable.

## 17. Definition of monetization readiness

Before scaling monetization:

- the first-session loop is understandable,
- free players can reach first prestige without excessive friction,
- retention data is available,
- purchase fulfillment is reliable,
- prices/benefits are configurable,
- analytics track shop views, prompts, purchase starts, and successful fulfillment,
- monetization UI works on mobile,
- paid multipliers do not break progression pacing.