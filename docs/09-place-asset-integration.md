# Supplied Place & Asset Integration

## Inputs

The first playable prototype is based on two user-supplied Roblox Studio place files:

- `tycoon game.rbxl` — used as the physical base/map/plot source.
- `LowPolyMegaPack400.rbxl` — used as a visual asset library.

The original files are treated as source material and should remain unchanged. Generated prototypes must be separate files.

## Inspection summary

### Tycoon base

The supplied tycoon place contains approximately **84,454 instances**. Important existing structure includes:

- `Workspace/Map` — map/environment geometry.
- `Workspace/Tycoon` — eight tycoon plots plus legacy tycoon logic.
- `Workspace/Tycoon/Tycoon 1/tycoonThings` — useful prototype plot geometry, including the existing conveyor/spawn infrastructure.
- `Workspace/Tycoon/Tycoon 1/Buttons` — 125 legacy purchase buttons.
- `Workspace/Tycoon/Tycoon 1/Buildings` — 125 legacy building groups.
- legacy shop, rebirth, gear, cash, product, UI, and tycoon systems spread across services.

The place contains roughly 987 `Script` instances plus a large number of `LocalScript` and `ModuleScript` instances. The legacy runtime is therefore **not** the foundation for Idle Universe gameplay. It is retained only as source geometry/reference where useful.

### Low-poly pack

The supplied low-poly place contains approximately **5,795 instances** and roughly **396 Models**. The main library is under `Workspace/AssetPack`.

The pack includes simulator/environment-style assets such as currency meshes, rocks, trees, portals, leaderboards, chests, buildings, nature props, and other decorative models.

## Integration decision

For the prototype:

1. Use the tycoon place's map, first plot, spawn area, and conveyor/layout as the physical starting point.
2. Do not run the legacy tycoon economy/rebirth/shop/gear stack.
3. Archive/hide the unused plots and legacy purchase/building folders during prototype startup.
4. Use the new Idle Universe server-authoritative economy instead.
5. Reuse selected low-poly meshes directly by asset ID instead of copying the entire asset library into the live place. This avoids adding thousands of unnecessary instances.

## Selected low-poly assets

These IDs were extracted from the supplied `LowPolyMegaPack400.rbxl` and are also centralized in `src/shared/Config/Assets.luau`.

| Purpose | Source mesh | Asset ID |
|---|---|---|
| Credit / energy core | `Meshes/Currency_Mball.004` | `rbxassetid://12924671064` |
| Scrap / rock prop | `Rock` variant | `rbxassetid://7231644778` |
| World-gate visual | `Meshes/portal test_Cube.001` | `rbxassetid://12627520827` |
| Leaderboard visual element | `Meshes/Leaderboards2_Cylinder.003` | `rbxassetid://13221020310` |
| Low-poly tree trunk | `Meshes/Tree_Cylinder` | `rbxassetid://12660786696` |
| Low-poly tree canopy | `Meshes/Tree_Sphere.001` | `rbxassetid://12660786909` |

Additional assets can be promoted from the pack only when they serve an identified gameplay/world-art need.

## Generated prototype

The initial generated place is named:

`Idle Universe Prototype.rbxl`

Generation behavior:

- preserves the original tycoon place hierarchy/data as the base,
- disables all auto-running legacy `Script` and `LocalScript` instances,
- repurposes one existing server Script and one existing StarterPlayer LocalScript as the prototype Idle Universe runtime,
- leaves `ModuleScript` instances inert unless explicitly required,
- keeps `Tycoon 1` as the active prototype plot,
- moves unused tycoon plots and major legacy gameplay folders into a server-only archive at runtime,
- removes legacy StarterGui/StarterPack surfaces at runtime,
- creates the Earth Scrapyard greybox machines and HUD,
- uses selected low-poly asset IDs for scrap/core/world-gate visuals.

The generated file structurally validates as a Roblox binary place with the same **84,454 instances** as the supplied base file. Only two auto-running scripts are intentionally enabled in the generated prototype.

## Prototype loop

The embedded prototype implements:

**Process Scrap → reach 75 Credits → automate Scrap Recycler → earn passive Credits → upgrade Recycler → buy Industrial Smelter → increase Credits/sec**

Balance is based on the repository's V1 alpha configuration:

- Recycler automation: 75 Credits
- Recycler base level cost: 50 Credits
- Recycler cost growth: 1.14
- Recycler base output: 1 Credit/sec per level before milestone bonuses
- Industrial Smelter unlock: 500 Credits
- Smelter cost growth: 1.15
- Smelter base output: 12 Credits/sec per level before milestone bonuses

The prototype uses in-memory progress only. Persistence is deliberately deferred until the greybox loop is validated in Roblox Studio.

## Safety / maintenance rule

Do not re-enable the legacy tycoon scripts wholesale. Any legacy model, script, UI, monetization element, or gameplay mechanic must be reviewed before reuse. Production systems should continue to come from the config-driven/server-authoritative architecture documented in `docs/03-technical-architecture.md`.

## Next validation gate

Open `Idle Universe Prototype.rbxl` in Roblox Studio and verify:

1. the place opens without conversion errors,
2. only the new Idle Universe server/client bootstrap executes,
3. legacy tycoon/shop/rebirth UI does not appear,
4. the player spawns at the first tycoon plot,
5. the low-poly scrap/core/world-gate meshes load,
6. manual scrap earning works,
7. automation costs exactly 75 Credits,
8. passive Recycler income begins after automation,
9. Recycler upgrades use server-calculated prices,
10. the Smelter unlocks at 500 Credits,
11. Credits/sec matches machine state,
12. no legacy product prompts or gear scripts fire.

After this passes, replace the embedded prototype runtime with the repository's modular services and proceed to persistence/DataStore work.
