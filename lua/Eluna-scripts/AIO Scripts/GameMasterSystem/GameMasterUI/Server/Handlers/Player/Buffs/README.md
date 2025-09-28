# Buff/Aura Handler Sub-Modules

This directory contains the modularized buff and aura management handlers for the GameMasterUI system.

## Overview

The original `GameMasterUI_PlayerBuffHandlers.lua` file (311 lines) has been split into smaller, focused sub-modules for better organization and maintainability.

## Module Structure

```
Buffs/
├── BuffApplicationHandlers.lua   (~145 lines) - Buff/aura application
├── BuffRemovalHandlers.lua       (~85 lines)  - Aura removal & healing
├── SpellCastingHandlers.lua      (~110 lines) - Spell casting operations
└── README.md                      - This file
```

## Module Descriptions

### BuffApplicationHandlers.lua
Handles buff and aura application operations:
- `applyBuffToPlayer` - Apply single buff/aura to player
- `playerApplyAuraWithDuration` - Apply aura with custom duration (permanent, timed, or default)
- `playerGetAuraInfo` - Get detailed aura information (duration, stacks, caster)

### BuffRemovalHandlers.lua
Manages aura removal and restoration:
- `removePlayerAuras` - Remove all auras from a player
- `healAndRestorePlayer` - Full heal, restore power, and remove common debuffs

### SpellCastingHandlers.lua
Controls spell casting operations:
- `makePlayerCastOnSelf` - Force player to cast spell on themselves
- `makePlayerCastOnTarget` - Force player to cast spell on their current target
- `castSpellOnPlayer` - GM directly casts spell on target player

## Registration Pattern

Each sub-module follows the standard registration pattern:

```lua
local ModuleName = {}

function ModuleName.RegisterHandlers(gms, config, utils, database, dbHelper)
    -- Store dependencies
    -- Register handlers with GameMasterSystem
end

-- Handler implementations
function ModuleName.handlerName(player, ...)
    -- Implementation
end

return ModuleName
```

## Coordinator Module

The main `GameMasterUI_PlayerBuffHandlers.lua` now acts as a coordinator:
- Loads all sub-modules using `require()`
- Delegates registration to each sub-module
- Maintains backward compatibility with existing code

## Handler Details

### Buff Application
- **Apply Buff**: Applies any spell ID as a buff to target player
- **Custom Duration**: Supports permanent (-1), timed (milliseconds), or default durations
- **Aura Info**: Retrieves current duration, stacks, and caster information

### Buff Removal & Healing
- **Remove All Auras**: Clears all buffs and debuffs from player
- **Full Restore**: Heals to max health, restores power, removes common debuffs
  - Preserves beneficial buffs while removing debuffs
  - Uses `Utils.commonDebuffs` list for targeted removal

### Spell Casting
- **Self-Cast**: Makes player cast on themselves (useful for buffs/heals)
- **Target Cast**: Makes player cast on their selected target
- **GM Cast**: GM directly casts spell on player (shows GM as caster)

## Permission Requirements

All handlers require GM rank 2 or higher:
```lua
if player:GetGMRank() < 2 then
    Utils.sendMessage(player, "error", "You do not have permission to use this command.")
    return
end
```

## Error Handling

All handlers include comprehensive error handling:
- Permission validation
- Spell ID validation (must be positive number)
- Target player existence checks
- Target selection validation (for cast-on-target)
- Detailed error messages sent to GM

## Usage Examples

### Apply Temporary Buff
```lua
-- Apply 1-hour buff (3600000 milliseconds)
GameMasterSystem.playerApplyAuraWithDuration(gm, "PlayerName", 12345, 3600000)
```

### Apply Permanent Buff
```lua
-- Apply permanent buff (until death/removal)
GameMasterSystem.playerApplyAuraWithDuration(gm, "PlayerName", 12345, -1)
```

### Full Heal and Restore
```lua
-- Heal player and remove debuffs
GameMasterSystem.healAndRestorePlayer(gm, "PlayerName")
```

### Force Player Cast
```lua
-- Make player cast spell on themselves
GameMasterSystem.makePlayerCastOnSelf(gm, "PlayerName", 12345)

-- Make player cast on their target
GameMasterSystem.makePlayerCastOnTarget(gm, "PlayerName", 12345)
```

## Integration with Client

The client-side handlers in the GameMasterUI system call these server handlers through AIO:
- Player card context menus
- Buff/debuff management interface
- Quick action buttons

## Performance Considerations

- Aura operations are direct Eluna API calls (minimal overhead)
- No database queries required for buff operations
- Healing operations check specific debuff list rather than iterating all auras

## Future Improvements

Potential enhancements:
- Batch buff application (multiple buffs at once)
- Buff presets (common buff combinations)
- Scheduled buff removal
- Buff history tracking
- Custom debuff lists per GM rank