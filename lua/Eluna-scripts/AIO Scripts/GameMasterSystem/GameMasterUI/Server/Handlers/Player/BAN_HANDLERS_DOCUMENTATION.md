# GameMasterUI Ban Handlers Documentation

## Overview
The `GameMasterUI_BanHandlers.lua` module provides comprehensive ban management functionality for TrinityCore/AzerothCore servers through the GameMaster UI system. It implements account, character, and IP bans with automatic fallback mechanisms for servers with non-standard configurations.

## Module Structure

### Dependencies
- **GameMasterSystem**: Core AIO handler system
- **Config**: Configuration constants
- **Utils**: Utility functions for messaging
- **Database**: Database query functions

### Ban Types
```lua
local BAN_TYPE = {
    ACCOUNT = 0,    -- Bans all characters on account
    CHARACTER = 1,  -- Bans specific character only
    IP = 2          -- Bans IP address
}
```

## Handler Functions

### `banPlayer(player, targetName, duration, reason, banType)`
Main ban handler that processes all ban requests.

**Parameters:**
- `player`: GM executing the ban
- `targetName`: Character name to ban
- `duration`: Ban duration in minutes (0 = permanent)
- `reason`: Ban reason text
- `banType`: Type of ban (0=Account, 1=Character, 2=IP)

**Process Flow:**
1. Validates GM permissions (requires rank 2+)
2. Converts duration from minutes to seconds
3. Routes to appropriate ban logic based on type
4. Executes ban and kicks player if online
5. Sends success/error message to GM

**Special Handling:**
- Account bans retrieve username from account table
- Character bans use direct SQL (Eluna Ban() function workaround)
- IP bans require player to be online

### `unbanPlayer(player, targetName, banType)`
Removes existing bans.

**Parameters:**
- `player`: GM executing the unban
- `targetName`: Character name to unban
- `banType`: Type of ban to remove

**Requirements:**
- GM rank 3+ required
- Automatically finds correct ban record
- Handles both auth and character database locations

### `getBanInfo(player, targetName)`
Retrieves current ban status for a character.

**Returns:**
- Account ban details (if exists)
- Character ban details (if exists)
- IP ban information (if available)

### `checkServerCapabilities(player)`
Detects server configuration and ban support.

**Checks:**
- Character ban table existence
- Database location (auth vs characters)
- Server version information

**Sends to Client:**
```lua
{
    supportsCharacterBan = true/false,
    characterBanLocation = "AUTH"/"CHARACTERS",
    serverVersion = "TrinityCore x.x.x"
}
```

## Database Operations

### `executeSQLBan(banType, accountId, charGuid, ipAddress, duration, reason, gmName)`
Fallback SQL implementation for direct database bans.

**Features:**
- Automatic database detection
- Handles missing 'active' column
- Uses ON DUPLICATE KEY UPDATE for existing bans
- Returns success based on execution (no verification due to transaction isolation)

**Database Tables Used:**
- `account_banned` (auth database)
- `character_banned` (auth or characters database)
- `ip_banned` (auth database)

## Implementation Details

### Transaction Isolation Workaround
The module uses `pcall` to execute SQL queries and trusts successful execution rather than immediate verification. This avoids issues with:
- Database transaction isolation levels
- Connection pooling visibility delays
- Commit timing in different server configurations

### Error Handling
- All database operations wrapped in pcall
- Comprehensive error messages sent to GM
- Detailed console logging for debugging
- Graceful fallbacks for missing features

### Security Features
- SQL injection prevention via string formatting
- Permission checks at every level
- Reason text sanitization
- GM name tracking for accountability

## Usage Examples

### Ban a Character
```lua
-- From client UI
AIO.Handle("GameMasterSystem", "banPlayer", "PlayerName", 60, "Cheating", 1)
-- Bans character "PlayerName" for 60 minutes
```

### Check Ban Status
```lua
-- Server-side check
GameMasterSystem.getBanInfo(gmPlayer, "PlayerName")
-- Returns ban information to client UI
```

### Server Capability Check
```lua
-- Automatically called on GM login
GameMasterSystem.checkServerCapabilities(player)
-- Updates UI with server-specific features
```

## Known Issues & Workarounds

### Eluna Ban() Function
Some servers have a broken Ban() function that ignores the banType parameter. The module detects this and uses direct SQL for character bans.

### Database Location Variations
The `character_banned` table may exist in either:
- `characters` database (standard)
- `auth` database (non-standard)

The module automatically detects and adapts to both configurations.

### Transaction Visibility
Database writes may not be immediately visible for verification due to:
- Transaction isolation levels
- Connection pooling
- Pending commits

Solution: Trust successful execute rather than verify immediately.

## Integration Points

### Client UI Integration
The ban handlers integrate with the GameMasterUI client through AIO messages:
- `banPlayer`: Executes ban
- `unbanPlayer`: Removes ban
- `getBanInfo`: Queries ban status
- `receiveServerCapabilities`: Updates UI features

### Server Events
- Registers capability check on player login
- Automatic player kick on successful ban
- Ban status included in player data queries

## Debugging

### Console Output
Enable detailed logging by monitoring server console:
```
[GameMasterSystem] Using direct SQL for character ban
[GameMasterSystem] Using CHARACTERS database for character ban
[GameMasterSystem] ✓ Character ban query executed successfully
[GameMasterSystem] Ban executed - Type: Character, Target: PlayerName
```

### Common Issues
1. **"Failed to ban" but ban works**: Usually transaction visibility
2. **"Character bans not supported"**: Missing character_banned table
3. **"Player not found"**: Character name typo or offline for IP ban

## Future Enhancements
- Ban history tracking
- Temporary ban expiration jobs
- Ban appeal system integration
- Cross-realm ban synchronization
- Ban notification system