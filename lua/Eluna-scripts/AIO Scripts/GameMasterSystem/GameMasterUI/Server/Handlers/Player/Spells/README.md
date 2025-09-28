# Player Spell Handlers Sub-Modules

This directory contains the modularized player spell management handlers for the GameMasterUI system.

## Overview

The original `GameMasterUI_PlayerSpellHandlers.lua` file (969 lines) has been split into smaller, focused sub-modules to improve maintainability and comply with file size guidelines.

## Module Structure

```
Spells/
├── SpellDataHandlers.lua              (~250 lines) - Spell data queries
├── SpellEntityHandlers.lua            (~280 lines) - Target spell operations
├── PlayerSpellManagementHandlers.lua  (~270 lines) - Player spell management
├── PlayerSpellAuraHandlers.lua        (~120 lines) - Aura and cooldown operations
└── README.md                          - This file
```

## Module Descriptions

### SpellDataHandlers.lua
Handles all spell data query and search operations:
- `getSpellData` - Get spell data with pagination
- `searchSpellData` - Search spell data by name/ID
- `getSpellVisualData` - Get spell visual effect data
- `searchSpellVisualData` - Search spell visual data
- `searchSpells` - General spell search from database

### SpellEntityHandlers.lua
Manages spell operations on the current target:
- `learnSpellEntity` - Teach spell to target
- `deleteSpellEntity` - Remove spell from target
- `castSelfSpellEntity` - Cast spell on self
- `castOnTargetSpellEntity` - Cast spell on target
- `castTargetSpellEntity` - Make target cast on player
- Aura management:
  - `applyAuraToSelf` - Apply aura to self
  - `applyAuraToTarget` - Apply aura to target
  - `applyAuraWithDuration` - Apply aura with custom duration
  - `removeSpecificAura` - Remove specific aura
  - `getAuraInfo` - Get detailed aura information
- Cooldown management:
  - `resetSpellCooldown` - Reset specific spell cooldown
  - `resetAllCooldowns` - Reset all cooldowns
  - `checkCooldownStatus` - Check cooldown status

### PlayerSpellManagementHandlers.lua
Handles spell management for specific players:
- `getPlayerSpells` - Retrieve player's spells from database
- `submitPlayerSpellbook` - Receive spellbook data from client
- `playerSpellLearn` - Teach spell to specific player
- `playerSpellUnlearn` - Remove spell from specific player
- Cast operations:
  - `playerSpellCastOnSelf` - Make player cast on themselves
  - `playerSpellCastOnTarget` - Make player cast on their target
  - `playerSpellCastFromPlayer` - Make player cast on GM

### PlayerSpellAuraHandlers.lua
Manages auras and cooldowns for specific players:
- `playerSpellApplyAura` - Apply aura to specific player
- `playerSpellRemoveAura` - Remove aura from specific player
- `playerSpellResetCooldown` - Reset spell cooldown for player
- `playerSpellCheckCooldown` - Check cooldown status for player
- `playerResetAllCooldowns` - Reset all cooldowns for player

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

## Database Queries

### Spell Data Queries
The modules query multiple databases:
- **World database** (`spell` table) - Spell definitions and properties
- **Character database** (`character_spell`, `character_talent`) - Player spell data

### Query Structure Example
```sql
-- Get player spells
SELECT 
    cs.spell as spell_id,
    cs.active,
    cs.disabled,
    'spell' as spell_type
FROM character_spell cs
WHERE cs.guid = ?
UNION ALL
SELECT 
    ct.spell as spell_id,
    1 as active,
    0 as disabled,
    'talent' as spell_type
FROM character_talent ct
WHERE ct.guid = ?
```

## Handler Categories

### Target-Based Operations
Operations that work on the GM's current target (self or selected unit):
- Learn/unlearn spells
- Cast spells
- Apply/remove auras
- Reset cooldowns

### Player-Specific Operations
Operations that work on specific players by name:
- View player spellbook
- Teach/remove spells from players
- Force players to cast spells
- Apply/remove auras on players
- Reset player cooldowns

## Permission Requirements

All handlers include GM rank validation:
- Minimum GM rank 2 required for all operations
- Permission checks are performed at the start of each handler

## Error Handling

All handlers include comprehensive error handling:
- Permission validation
- Null checks for targets and players
- Database query error handling
- User-friendly error messages
- Success/failure feedback

## Performance Considerations

### Pagination
All data query handlers support pagination:
- Configurable page size (default from Config)
- Offset-based navigation
- Total count calculation for UI display

### Database Optimization
- Indexed lookups where possible
- UNION queries for combined data
- Limit clauses to prevent excessive data transfer

## Testing

To test the modularized handlers:
1. Ensure the server loads without Lua errors
2. Test spell data queries and searches
3. Test learning/unlearning spells on targets
4. Test casting spells in various modes
5. Test aura application and removal
6. Test cooldown reset functionality
7. Test player-specific operations
8. Verify pagination works correctly
9. Check error messages for invalid operations

## Troubleshooting

### Common Issues

1. **Handlers not found**: Ensure all sub-modules are in the Spells/ directory
2. **Module loading errors**: Check require() paths in coordinator
3. **Spell not found**: Verify spell ID exists in database
4. **Player not found**: Check player name spelling and online status
5. **Permission denied**: Ensure GM rank is sufficient

### Debug Output

Enable debug output by setting `Config.debug = true` in GameMasterUI_Config.lua

## Future Improvements

Potential enhancements:
- Spell category filtering
- Batch spell operations
- Spell learning prerequisites check
- Cooldown tracking persistence
- Spell macro generation
- Custom spell creation interface