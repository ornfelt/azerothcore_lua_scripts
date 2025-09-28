# Item Handlers Module Structure

## Overview

The Item handlers have been modularized from a single 1,981-line file into 6 focused modules:

## Modules

### 1. ItemDataHandlers.lua (~175 lines)
**Purpose**: Item data queries and search operations
- `getItemData` - Fetch paginated item data
- `searchItemData` - Search items by query
- `getItemIcon` - Get item icon from display ID
- `getItemTypeName` - Get item type name from class/subclass

### 2. ItemManagementHandlers.lua (~200 lines)
**Purpose**: Basic item management operations
- `addItemEntity` - Add item to target or player
- `addItemEntityMax` - Add maximum stack of item
- `givePlayerItem` - Give item to specific player
- `addItemToPlayer` - Alias for givePlayerItem

### 3. ItemEnchantmentHandlers.lua (~500 lines)
**Purpose**: Item enchantment and repair operations
- `enchantPlayerItem` - Apply enchantments to items
- `removeItemEnchant` - Remove all enchantments
- `repairPlayerItem` - Repair items or all equipment

### 4. ItemInventoryHandlers.lua (~400 lines)
**Purpose**: Inventory-specific operations
- `duplicatePlayerItem` - Duplicate items
- `splitItemStack` - Split item stacks
- `modifyItemStack` - Change stack counts
- `deleteInventoryItem` - Remove items from inventory
- `deleteEquippedItem` - Remove equipped items

### 5. ItemSearchHandlers.lua (~450 lines)
**Purpose**: Advanced search and placement
- `requestModalItems` - Request items for modal UI
- `searchItemsForModal` - Search items for modal
- `searchItems` - Advanced item search with filters
- `addItemToSpecificSlot` - Add item to specific bag/slot
- `equipItemById` - Equip item directly to slot

### 6. ItemUtilities.lua (~280 lines)
**Purpose**: Shared utility functions
- `getBagSize` - Get bag size safely
- `isValidInventoryPosition` - Validate inventory positions
- `findInventoryItem` - Find items using multiple methods

## Module Dependencies

```lua
ItemHandlers (coordinator)
├── ItemDataHandlers
├── ItemManagementHandlers
├── ItemEnchantmentHandlers (uses ItemUtilities)
├── ItemInventoryHandlers
├── ItemSearchHandlers (uses ItemDataHandlers)
└── ItemUtilities (shared utilities)
```

## Registration Flow

1. Main server file loads `GameMasterUI_ItemHandlers.lua`
2. Coordinator module loads all sub-modules
3. Each sub-module registers its handlers
4. Cross-references are set up after loading
5. Utilities are initialized with config

## Custom Bag Support

The modules include special handling for custom bags (ID >= 1500):
- GUID-based item lookup for custom 64-slot bags
- Direct database updates for enchantments
- Alternative bag ID mappings for compatibility

## Usage Example

```lua
-- In GameMasterUIServer.lua
local ItemHandlers = require("GameMasterUI_ItemHandlers")
ItemHandlers.RegisterHandlers(GameMasterSystem, Config, Utils, Database, DatabaseHelper)
ItemHandlers.SetPlayerHandlers(PlayerHandlers)
```

## File Size Summary

- **Original**: 1,981 lines (single file)
- **After Split**: 6 files, average ~335 lines each
- **Largest Module**: ItemEnchantmentHandlers (~500 lines)
- **Smallest Module**: ItemDataHandlers (~175 lines)

## Benefits

1. **Maintainability**: Each module has a clear, focused purpose
2. **Readability**: Smaller files are easier to understand
3. **Performance**: Faster parsing and loading
4. **Scalability**: Easy to add new item-related functionality
5. **Debugging**: Issues are easier to isolate