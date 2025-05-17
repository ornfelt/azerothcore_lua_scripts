# Custom Racial UI System for TrinityCore

A customizable racial abilities system for TrinityCore servers using Eluna and AIO. This system allows players to learn and unlearn various racial abilities, spells, and professions through an intuitive user interface.

## Features

- **Dynamic UI System**: Clean and user-friendly interface for managing racial abilities
- **Category System**: Organize racial abilities into customizable categories
- **Cost Management**:
  - Configurable costs for removing abilities (Gold, Items, or Spells)
  - Support for both individual costs per ability and unified costs for bulk removal
  - Visual feedback for cost requirements
- **Flexible Learning System**:
  - Learn/unlearn spells, professions, and items
  - Category-based limits on active abilities
  - Real-time counters for active abilities
- **Multiple Access Methods**:
  - NPC interaction can be enabled/disabled
  - Chat commands (/rui, /racialui) can be enabled/disabled
  - Movable world icon can be enabled/disabled
  - **Client-side Access**: Requires client-side files for full functionality

## Requirements

- TrinityCore server
- [Eluna Engine](https://github.com/ElunaLuaEngine/Eluna)
- [AIO (AddOn In-game Organizer)](https://github.com/Rochet2/AIO)

## Installation

1. Copy the content inside `server` folder to your `lua_scripts/AIO_Server` directory
2. Copy the content inside `client` folder to your `interface/AddOns` directory. This is optional but recommended for full functionality. Most users will need to apply a patch.

   - **Note**: The client-side files are required for server-side functionality. You can choose to ignore them if you only want the server-side features. You will need to edit the code to make it work without client-side files.
3. Import the included SQL files into your world database:   [racial_tables.sql](racial_tables.sql) to get all the database tables and data. or go to Database Structure and create the tables manually. with that.

4. Configure the settings in `racialServer.lua`:

   ```lua
   local IsNpc = true -- Enable/disable NPC interaction
   local npcEntry = 1 -- NPC entry ID for UI access

   local useUnifiedCost = true -- Use single cost for all resets
   local unifiedCostType = "gold" -- Cost type: "gold", "item", or "spell"
   local unifiedCostAmount = 100000 -- Cost amount (10g in copper) Also use for item, spell costs
   ```

## Database Structure

### custom_racial_tabs

Defines categories for racial abilities.

```sql
CREATE TABLE custom_racial_tabs (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    maxActiveSpells INT,
    icon VARCHAR(255)
);
```

### custom_racial_spells

Stores individual racial abilities and their properties.

```sql
CREATE TABLE custom_racial_spells (
    id INT PRIMARY KEY,
    category INT,
    name VARCHAR(255),
    itemType VARCHAR(50),
    costType VARCHAR(50),
    cost INT
);
```

## Usage

### As a Player

1. Access the UI through:
   - Speaking with the configured NPC
   - Using `/rui` or `/racialui` commands
   - Clicking the world icon
2. Browse categories and select abilities
3. Left-click to learn, right-click to unlearn abilities
4. Use the reset button to remove all active abilities at once

### As an Admin

1. Add new racial abilities through the database
2. Configure costs and requirements
3. Customize categories and limits
4. Adjust UI settings and access methods
5. Reload on the fly with  `.rui update` command

## Features in Detail

### Cost System

- Individual Costs: Set specific costs per ability
- Unified Costs: Single cost for bulk removal
- Cost Types:
  - Gold: Copper amount
  - Items: Item ID and count
  - Spells: Required spell ID

### Category Management

- Create custom categories
- Set maximum active abilities per category
- Custom icons for each category
- Real-time counters

### UI Elements

- Category tabs
- Spell/ability buttons with tooltips
- Cost information display
- Active ability counters
- Reset all button with confirmation

## Contributing

Feel free to submit issues and enhancement requests!
