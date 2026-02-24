# Player Inventory Handlers Sub-Modules

This directory contains the modularized player inventory management functionality for the GameMaster UI system.

## Module Structure

The inventory system has been split into three focused sub-modules:

### 1. PlayerInventoryDataHandlers.lua (~450 lines)
Handles all inventory data queries and bag mapping:
- `queryAndSendInventory` - Main query function that sends inventory data to client
- `getBagMapping` - Maps bag GUIDs to their configuration
- `getInventoryData` - Retrieves all items from character_inventory
- `getEquipmentData` - Retrieves equipped items (online/offline support)
- `getBagSizes` - Calculates bag sizes for all containers
- `createBagConfiguration` - Builds configuration for client-side display

### 2. PlayerInventoryEquipHandlers.lua (~150 lines)
Manages item equip/unequip operations:
- `unequipPlayerItem` - Removes item from equipment slot to inventory
- `equipPlayerItem` - Equips item from inventory to appropriate slot
- Handles special cases for rings and trinkets (dual slots)
- Validates equipment requirements and permissions

### 3. PlayerInventoryRefreshHandlers.lua (~100 lines)
Coordinates refresh and save operations:
- `getPlayerInventory` - Public interface for inventory queries
- `refreshPlayerInventory` - Forces inventory data refresh
- `saveOnlinePlayerData` - Ensures online player data is saved before queries

## Coordinator Module

The main `GameMasterUI_PlayerInventoryHandlers.lua` file (~60 lines) acts as a coordinator that:
1. Loads all sub-modules
2. Registers their handlers with the GameMaster system
3. Manages sub-module references
4. Provides a clean interface to other modules

## Data Flow

```
Client Request
    ↓
GameMasterUIServer.lua
    ↓
PlayerInventoryHandlers (Coordinator)
    ↓
┌─────────────┬──────────────┬──────────────┐
│   Refresh   │     Data     │    Equip     │
│  Handlers   │   Handlers   │   Handlers   │
└─────────────┴──────────────┴──────────────┘
```

## Handler Registration

All handlers are registered through the coordinator module which is loaded by `GameMasterUIServer.lua`:

```lua
-- In GameMasterUIServer.lua
local PlayerInventoryHandlers = require("GameMasterUI.Server.Handlers.Player.GameMasterUI_PlayerInventoryHandlers")
PlayerInventoryHandlers.RegisterHandlers(GameMasterSystem, Config, Utils, Database, DatabaseHelper, PlayerHandlers)
```

## Key Features

### Online/Offline Player Support
- Automatically detects if player is online
- Uses direct API calls for online players (more accurate)
- Falls back to database queries for offline players
- Saves online player data before queries to ensure consistency

### Bag Mapping
- Supports regular bags (slots 19-22)
- Supports bank bags (slots 67-73)
- Handles non-standard bag IDs from custom servers
- Maps bag GUIDs to their configuration

### Equipment Management
- Full equipment slot support (0-18)
- Enchantment data preservation
- Automatic slot selection for rings/trinkets
- Item requirement validation

## Database Tables Used

- `characters.character_inventory` - Item locations
- `characters.item_instance` - Item details and enchantments
- `world.item_template` - Item definitions and properties

## Testing

To test the inventory system:
1. Use the GM UI to view a player's inventory
2. Try equipping/unequipping items
3. Test with both online and offline players
4. Verify bag mapping works correctly
5. Check enchantment data is preserved

## Troubleshooting

### Common Issues

1. **Handlers not found**: Ensure all sub-modules are in the Inventory/ directory
2. **Module loading errors**: Check require() paths in coordinator
3. **Data not refreshing**: Verify saveOnlinePlayerData delay is sufficient
4. **Bag mapping issues**: Check for non-standard bag IDs in your server

### Debug Output

Enable debug output by setting `Config.debug = true` in GameMasterUI_Config.lua

## Future Improvements

- Add bank operations sub-module when needed
- Implement item movement between bags
- Add bulk operations support
- Create item filter/search functionality