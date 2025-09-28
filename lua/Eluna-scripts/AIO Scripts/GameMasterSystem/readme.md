# GameMasterUI - Quick Setup Guide (TLDR)

## What is GameMasterUI?

Just need the `GameMasterUI`

A comprehensive in-game admin panel for TrinityCore 3.3.5 that provides:
- NPC/Item/Spell management and spawning
- Player inventory editor with enchantment support
- Ban/kick/teleport player controls
- 3D model previewer
- Context menus for quick actions
- Mail sending system
- GM power management

## Quick Setup (5 minutes)

### 1. File Placement
```
lua_scripts/
└── AIO_Server/
    ├── 00_UIStyleLibrary/      ← REQUIRED: Get from [PLACEHOLDER_LINK]
    ├── AIO.lua                 ← REQUIRED: Core AIO framework
    └── GameMasterUI/           ← This addon (both Client/ and Server/ folders)
```

**IMPORTANT:** Both `Client/` and `Server/` folders MUST be inside `AIO_Server/GameMasterUI/`

### 2. Database Configuration

Edit `Server/Core/GameMasterUI_Config.lua` (lines 39-73) to match your database setup:

```lua
-- IMPORTANT: Include the dot (.) at the end of the prefix!
prefixes = {
    world = "",  -- World database prefix
    char = "",   -- Character database prefix
    auth = "",   -- Auth database prefix
},

-- Optional tables that won't cause errors if missing
optionalTables = {
    "gameobjectdisplayinfo",
    "spellvisualeffectname",
    "creature_template_model",
    "creature_equip_template",
    "creature_template_addon",
    "gameobject_template_addon",
    "item_enchantment_template",
    "item_loot_template"
},

-- Required tables that will show warnings if missing
requiredTables = {
    "creature_template",
    "gameobject_template",
    "item_template",
    "spell"
},
```

**Common Prefix Configurations:**
- **TrinityCore (default):** Leave all as `""`
- **AzerothCore:** Use `"acore_world."`, `"acore_characters."`, `"acore_auth."`
- **Custom:** Use your database names like `"myserver_world."`

**Note:** Always include the dot (.) at the end of prefixes!

### 3. Database Tables

The required and optional tables are already defined in the configuration above. The addon will:
- **Show warnings** if required tables are missing but continue working
- **Gracefully fallback** if optional tables don't exist
- **Check tables on startup** (configurable with `checkTablesOnStartup = true`)

### 4. GM Level Requirements

Default GM level required: **2** (configurable in Config file, line 6)

```lua
REQUIRED_GM_LEVEL = 2,  -- Change this to your desired GM level
```

### 5. Optional Settings

In `Server/Core/GameMasterUI_Config.lua`:

```lua
debug = false,              -- Set to true for troubleshooting
defaultPageSize = 100,      -- Items per page in searches
removeFromWorld = true,     -- Remove entities from world on delete
```

## Usage

### Opening the Interface
- Command: `/gm` or `/gamemaster`
- Requires GM level 2+ (configurable)

### Key Features
- **Right-click** anything for context menus
- **Search** NPCs, items, spells by name/ID
- **Model Preview** with 3D rotation
- **Player Inventory** editor with all slots
- **Ban System** with duration and reason

## Troubleshooting

### "You don't have permission"
- Check your GM level: `.account`
- Verify `REQUIRED_GM_LEVEL` in Config

### UI doesn't appear
1. Check AIO is working: `.aio`
2. Verify `00_UIStyleLibrary` folder exists
3. Check server console for Lua errors
4. Clear WoW cache: Delete `Cache` folder

### Database errors
- Verify your database prefixes in Config match your setup
- Check required tables exist: `creature_template`, `gameobject_template`, `item_template`, `spell`
- The `spell` table must be imported from DBC files for spell features
- Optional tables will fallback gracefully if missing (configured in Config lines 46-63)

### Missing UI elements
- Ensure `00_UIStyleLibrary` loads first (00_ prefix is critical)
- All files must be in `AIO_Server/` directory

## Required Dependencies

1. **UIStyleLibrary** - [GitHub Repository](https://github.com/Isidorsson/Eluna-scripts/tree/master/AIO%20Scripts/00_UIStyleLibrary)
   - Must be in `AIO_Server/00_UIStyleLibrary/`
   - Provides all UI components and styling

2. **AIO Framework** (usually included with Eluna)
   - `AIO.lua` in `AIO_Server/`

3. **Spell Database Table**
   - Required for spell management features
   - Usually imported from DBC files stoneharrys tool can sovle this

## Support

- Server console shows all Lua errors
- Enable debug mode in Config for detailed logging
- Contact Eluna Discord for framework issues
