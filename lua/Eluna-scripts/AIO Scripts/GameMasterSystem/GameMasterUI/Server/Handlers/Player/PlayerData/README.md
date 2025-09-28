# PlayerData Sub-Modules

This directory contains the modularized player data management handlers for the GameMasterUI system.

## Overview

The original `GameMasterUI_PlayerHandlers.lua` file (960 lines) has been split into smaller, focused sub-modules to improve maintainability and comply with file size guidelines.

## Module Structure

```
PlayerData/
├── PlayerDataQueryHandlers.lua   (~400 lines) - Player data queries
├── PlayerActionHandlers.lua      (~230 lines) - Player actions
├── PlayerSearchHandlers.lua      (~180 lines) - Search & refresh
└── README.md                      - This file
```

## Module Descriptions

### PlayerDataQueryHandlers.lua
Handles all player data query operations:
- `getPlayerData` - Get online players with pagination
- `getOfflinePlayerData` - Query offline players from database
- `getAllPlayerData` - Get combined online and offline players
- Helper functions:
  - `checkBanStatus` - Check if player/account is banned
  - `getZoneName` - Resolve zone/area names

### PlayerActionHandlers.lua
Manages player-related actions:
- `givePlayerGold` - Grant gold to players
- `teleportToPlayer` - Teleport GM to player location
- `summonPlayer` - Summon player to GM location
- `kickPlayer` - Kick single player from server
- `batchKick` - Kick multiple players at once
- `batchSummon` - Summon multiple players (online immediately, offline on next login)

### PlayerSearchHandlers.lua
Handles search and refresh operations:
- `searchPlayerData` - Search players by name with pagination
- `refreshPlayerData` - Force refresh of player data
- Includes helper functions for ban checking and zone resolution

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

## Cross-Module Communication

The coordinator module (`GameMasterUI_PlayerHandlers.lua`) manages cross-references:

```lua
-- In coordinator after loading modules
PlayerSearchHandlers.SetQueryHandlers(PlayerDataQueryHandlers)
```

This allows the search module to call query handlers for refresh operations.

## Database Queries

### Player Data Query Structure
```sql
SELECT 
    c.guid,
    c.name,
    c.race,
    c.class,
    c.level,
    c.zone,
    c.logout_time,
    c.account,
    c.money,
    g.name as guild_name
FROM characters c
LEFT JOIN guild_member gm ON c.guid = gm.guid
LEFT JOIN guild g ON gm.guildid = g.guildid
```

### Ban Checking
The modules check both account and character bans across multiple databases:
- `account_banned` table in auth database
- `character_banned` table in both char and auth databases

## Helper Functions

### Shared Helpers
Some helper functions are duplicated across modules to maintain module independence:
- `checkBanStatus(accountId, charGuid)` - Returns ban status and type
- `getZoneName(areaId)` - Resolves area ID to zone name

### Pagination
All query handlers use the centralized pagination utilities from `Utils`:
- `Utils.validatePageSize(pageSize)`
- `Utils.validateSortOrder(sortOrder)`
- `Utils.calculatePaginationInfo(totalCount, offset, pageSize)`

## Performance Considerations

### Batch Operations
Batch operations (kick, summon) are optimized to:
- Process online players immediately
- Update offline player positions in database for next login
- Provide detailed feedback on success/failure counts

### Query Optimization
- Online player queries use in-memory data from `GetPlayersInWorld()`
- Offline queries use indexed database lookups with JOIN optimization
- Pagination limits result sets to prevent memory issues

## Error Handling

All handlers include error handling:
- Permission checks (GM rank validation)
- Input validation (nil checks, type validation)
- Database query error handling with pcall
- Detailed error messages sent to GM

## Testing

To test the modularized handlers:
1. Ensure the server loads without errors
2. Test each handler function through the UI:
   - View online players
   - View offline players
   - View all players
   - Search for specific players
   - Give gold to players
   - Teleport to/summon players
   - Kick single and multiple players
3. Verify pagination works correctly
4. Check ban status display
5. Test batch operations with mixed online/offline players

## Future Improvements

Potential enhancements:
- Lazy loading of sub-modules
- Caching layer for frequently accessed data
- Additional search filters (by level, class, zone)
- More batch operations (mass mail, mass gold)
- Performance metrics and monitoring