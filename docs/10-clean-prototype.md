# Clean Prototype Build

## Purpose

`Idle_Universe_Clean_Prototype.rbxl` is a sanitized version of the first generated prototype. It exists to reduce Roblox Studio output noise and remove dormant legacy code inherited from the supplied tycoon template while preserving the Idle Universe greybox runtime.

## Cleanup performed

The clean build was generated from `Idle_Universe_Prototype.rbxl` without modifying the original user-supplied place files.

Cleanup actions:

- Cleared **467 serialized `Sound.SoundId` values** inherited from the legacy tycoon/template content. This prevents Studio from attempting to load those unauthorized legacy audio assets during deserialization.
- Cleared the source of **1,166 legacy `Script` and `LocalScript` entries**.
- Preserved the only two intended runtime scripts by name: `IdleUniverseServer` and `IdleUniverseClient`.
- Preserved the map/plot/conveyor geometry and selected low-poly visual asset references used by the prototype.
- Preserved the existing runtime behavior that hides/archives unused tycoon plots and legacy gameplay surfaces during startup.
- Did not add persistence, monetization, or production services; this remains a greybox validation build.

## Structural validation

The cleaned file was re-parsed as a Roblox binary place after modification.

Validation result:

- Roblox binary signature: valid
- Class count: 133
- Serialized instance count: 84,454
- Chunk stream terminator: valid
- Runtime scripts preserved: `IdleUniverseServer`, `IdleUniverseClient`
- Output size: approximately 873 KB
- SHA-256: `6f1eff1cdab47b2155cca7f6b6ef4868d2a434a7b8419fcdd8eb31320f0f79bf`

The lower file size comes primarily from stripping dormant legacy script source and clearing legacy serialized audio references.

## Expected Studio behavior

The legacy unauthorized sound errors shown by the first prototype should no longer be emitted by the serialized `Sound` objects because their `SoundId` fields are empty.

A separate Roblox Studio plugin message such as:

`[roblostudio-mcp] /ready failed ... localhost ...`

is not stored in the place and is unrelated to Idle Universe. That message comes from an installed Studio plugin attempting to contact its local companion process and must be handled by enabling its companion service or disabling that plugin.

## Validation checklist

Open `Idle_Universe_Clean_Prototype.rbxl` and press Play. Verify:

1. no unauthorized legacy sound-load errors appear,
2. the Idle Universe HUD appears,
3. Process Scrap increases Credits,
4. Recycler automation costs 75 Credits,
5. passive production begins after automation,
6. Recycler upgrades work,
7. the Industrial Smelter can be purchased at 500 Credits,
8. no legacy tycoon shop/rebirth/gear behavior activates,
9. no unexpected legacy UI appears,
10. the selected low-poly meshes still load correctly.

If this gate passes, the next engineering step is to stop depending on the embedded greybox runtime and move the tested loop onto the repository's modular server-authoritative services and persistence layer.
