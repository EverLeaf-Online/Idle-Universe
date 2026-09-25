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

## Clean Prototype v2 runtime fix

Studio testing of the first clean build exposed a server runtime error at `IdleUniverseServer:157`:

`The current thread cannot write 'MeshId' (lacking capability NotAccessible)`

Cause: the embedded greybox helper created a `MeshPart` and attempted to assign `MeshPart.MeshId` while the server was running. Roblox does not permit that property write from this runtime context.

`Idle_Universe_Clean_Prototype_v2.rbxl` replaces the runtime mesh helper with `Part + SpecialMesh`:

- no runtime `MeshPart.MeshId` assignments remain,
- `SpecialMesh.MeshId` is used for the supplied low-poly mesh references,
- the collision/anchoring properties remain on the parent `Part`,
- the rest of the prototype economy and UI code is unchanged.

v2 structural validation:

- Roblox binary chunk stream: valid
- Chunk count: 2,592
- Embedded `Instance.new("MeshPart")` occurrences: 0
- Embedded `Instance.new("SpecialMesh")` occurrences in the Idle Universe server runtime: present
- Output size: approximately 873 KB
- SHA-256: `7765b419c237acd49416b4d4283bff96af227a354afd35d4a61ba3586c398e15`

## Expected Studio behavior

The legacy unauthorized sound errors shown by the first prototype should no longer be emitted by the serialized `Sound` objects because their `SoundId` fields are empty.

A separate Roblox Studio plugin message such as:

`[roblostudio-mcp] /ready failed ... localhost ...`

is not stored in the place and is unrelated to Idle Universe. That message comes from an installed Studio plugin attempting to contact its local companion process and must be handled by enabling its companion service or disabling that plugin.

## Validation checklist

Open `Idle_Universe_Clean_Prototype_v2.rbxl` and press Play. Verify:

1. the previous `MeshPart.MeshId` capability error does not appear,
2. no unauthorized legacy sound-load errors appear,
3. the Idle Universe HUD appears,
4. Process Scrap increases Credits,
5. Recycler automation costs 75 Credits,
6. passive production begins after automation,
7. Recycler upgrades work,
8. the Industrial Smelter can be purchased at 500 Credits,
9. no legacy tycoon shop/rebirth/gear behavior activates,
10. no unexpected legacy UI appears,
11. the selected low-poly meshes load or, if a mesh asset has a separate permission problem, gameplay continues without a server-script crash.

If this gate passes, the next engineering step is to stop depending on the embedded greybox runtime and move the tested loop onto the repository's modular server-authoritative services and persistence layer.
