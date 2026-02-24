local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize namespace for GameObject field definitions
_G.GameObjectFieldDefs = _G.GameObjectFieldDefs or {}
local GameObjectFieldDefs = _G.GameObjectFieldDefs

-- GameObject type names for reference
local GAMEOBJECT_TYPES = {
    [0] = "Door",
    [1] = "Button",
    [2] = "Quest Giver",
    [3] = "Chest",
    [4] = "Binder",
    [5] = "Generic",
    [6] = "Trap",
    [7] = "Chair",
    [8] = "Spell Focus",
    [9] = "Text",
    [10] = "Goober",
    [11] = "Transport",
    [12] = "Area Damage",
    [13] = "Camera",
    [14] = "Map Object",
    [15] = "MO Transport",
    [16] = "Duel Arbiter",
    [17] = "Fishing Node",
    [18] = "Summoning Ritual",
    [19] = "Mailbox",
    [20] = "Auction House",
    [21] = "Guard Post",
    [22] = "Spellcaster",
    [23] = "Meeting Stone",
    [24] = "Flag Stand",
    [25] = "Fishing School",
    [26] = "Flag Drop",
    [27] = "Mini Game",
    [28] = "Lottery Kiosk",
    [29] = "Capture Point",
    [30] = "Aura Generator",
    [31] = "Dungeon Difficulty",
    [32] = "Barber Chair",
    [33] = "Destructible Building",
    [34] = "Guild Bank",
    [35] = "Trapdoor"
}

-- Data field meanings based on GameObject type
local TYPE_DATA_FIELDS = {
    [0] = { -- Door
        [0] = { name = "Start Open", type = "dropdown", options = {{value = 0, text = "Closed"}, {value = 1, text = "Open"}}, tooltip = "Initial state (0=closed, 1=open)" },
        [1] = { name = "Lock ID", type = "number", min = 0, tooltip = "Lock template ID" },
        [2] = { name = "Auto Close Time", type = "number", min = 0, tooltip = "Time in milliseconds before auto-closing (0=disabled)" },
        [3] = { name = "No Damage Immune", type = "dropdown", options = {{value = 0, text = "Normal"}, {value = 1, text = "No Damage Immune"}}, tooltip = "Damage immunity flag" },
        [4] = { name = "Open Text ID", type = "number", min = 0, tooltip = "Broadcast text ID when opening" },
        [5] = { name = "Close Text ID", type = "number", min = 0, tooltip = "Broadcast text ID when closing" },
    },
    [1] = { -- Button
        [0] = { name = "Start Open", type = "dropdown", options = {{value = 0, text = "Closed"}, {value = 1, text = "Open"}}, tooltip = "Initial state" },
        [1] = { name = "Lock ID", type = "number", min = 0, tooltip = "Lock template ID" },
        [2] = { name = "Auto Close Time", type = "number", min = 0, tooltip = "Auto-close time in milliseconds" },
        [3] = { name = "Linked Trap ID", type = "number", min = 0, tooltip = "GameObject entry of linked trap" },
        [4] = { name = "No Damage Immune", type = "dropdown", options = {{value = 0, text = "Normal"}, {value = 1, text = "No Damage Immune"}}, tooltip = "Damage immunity" },
        [5] = { name = "Large?", type = "dropdown", options = {{value = 0, text = "Normal"}, {value = 1, text = "Large"}}, tooltip = "Is button large?" },
        [6] = { name = "Open Text ID", type = "number", min = 0, tooltip = "Broadcast text ID when pressed" },
        [7] = { name = "Close Text ID", type = "number", min = 0, tooltip = "Broadcast text ID when released" },
        [8] = { name = "Los OK", type = "dropdown", options = {{value = 0, text = "No"}, {value = 1, text = "Yes"}}, tooltip = "Line of sight OK" },
    },
    [3] = { -- Chest
        [0] = { name = "Lock ID", type = "number", min = 0, tooltip = "Lock template ID" },
        [1] = { name = "Loot ID", type = "number", min = 0, tooltip = "Loot template ID" },
        [2] = { name = "Restock Time", type = "number", min = 0, tooltip = "Seconds before chest restocks" },
        [3] = { name = "Consumable", type = "dropdown", options = {{value = 0, text = "Multi-use"}, {value = 1, text = "Consumable"}}, tooltip = "Despawn after use?" },
        [4] = { name = "Min Success Opens", type = "number", min = 0, max = 100, tooltip = "Min successful opens for quest" },
        [5] = { name = "Max Success Opens", type = "number", min = 0, max = 100, tooltip = "Max successful opens for quest" },
        [6] = { name = "Event ID", type = "number", min = 0, tooltip = "Event triggered on open" },
        [7] = { name = "Linked Trap ID", type = "number", min = 0, tooltip = "GameObject entry of linked trap" },
        [8] = { name = "Quest ID", type = "number", min = 0, tooltip = "Quest required to open" },
        [9] = { name = "Level", type = "number", min = 0, max = 80, tooltip = "Minimum level to open" },
        [10] = { name = "Los OK", type = "dropdown", options = {{value = 0, text = "No"}, {value = 1, text = "Yes"}}, tooltip = "Line of sight OK" },
        [11] = { name = "Leave Loot", type = "dropdown", options = {{value = 0, text = "No"}, {value = 1, text = "Yes"}}, tooltip = "Leave loot when abandoned" },
        [12] = { name = "Not In Combat", type = "dropdown", options = {{value = 0, text = "No"}, {value = 1, text = "Yes"}}, tooltip = "Cannot open in combat" },
        [13] = { name = "Log Loot", type = "dropdown", options = {{value = 0, text = "No"}, {value = 1, text = "Yes"}}, tooltip = "Log loot to DB" },
        [14] = { name = "Open Text ID", type = "number", min = 0, tooltip = "Broadcast text ID when opened" },
        [15] = { name = "Group Loot Rules", type = "dropdown", options = {{value = 0, text = "Use group settings"}, {value = 1, text = "Free for all"}}, tooltip = "Group loot override" },
    },
    -- Default for unspecified types
    default = function(index)
        return { name = "Data " .. index, type = "number", min = 0, tooltip = "Data field " .. index }
    end
}

-- Get data field definition for a specific type and index
function GameObjectFieldDefs.GetDataField(goType, dataIndex)
    local typeFields = TYPE_DATA_FIELDS[goType]
    if typeFields then
        if typeFields[dataIndex] then
            return typeFields[dataIndex]
        end
    end
    -- Return default if not specifically defined
    return TYPE_DATA_FIELDS.default(dataIndex)
end

-- Field definitions for each tab
GameObjectFieldDefs.FIELDS = {
    Basic = {
        { key = "name", label = "Name:", type = "text", tooltip = "GameObject display name" },
        { key = "type", label = "Type:", type = "dropdown", options = (function()
            local opts = {}
            for i = 0, 35 do
                table.insert(opts, {value = i, text = string.format("%d - %s", i, GAMEOBJECT_TYPES[i] or "Unknown")})
            end
            return opts
        end)(), tooltip = "GameObject type determines behavior" },
        { key = "displayId", label = "Display ID:", type = "number", min = 0, tooltip = "Visual model ID" },
        { key = "size", label = "Size:", type = "decimal", min = 0.01, max = 100, defaultValue = 1, step = 0.1, tooltip = "Scale multiplier" },
        { key = "IconName", label = "Icon Name:", type = "dropdown", options = {
            {value = "", text = "None"},
            {value = "Interact", text = "Interact (Gear)"},
            {value = "Speak", text = "Speak (Talk bubble)"},
            {value = "Attack", text = "Attack (Sword)"},
            {value = "Directions", text = "Directions (Arrow)"},
            {value = "Quest", text = "Quest (Exclamation)"},
            {value = "Taxi", text = "Taxi (Winged boot)"},
            {value = "Trainer", text = "Trainer (Book)"},
            {value = "Buy", text = "Buy (Brown bag)"},
            {value = "Repair", text = "Repair (Anvil)"},
            {value = "RepairNPC", text = "Repair NPC (Anvil+)"},
            {value = "Innkeeper", text = "Innkeeper (Home)"},
            {value = "Pickup", text = "Pickup (Open hand)"},
            {value = "Gunner", text = "Gunner (Crosshair)"},
            {value = "Mine", text = "Mine (Pick)"},
            {value = "LootAll", text = "Loot All (Multiple bags)"},
            {value = "Attack2", text = "Attack2 (Sword variant)"},
            {value = "PVP", text = "PVP (Crossed swords)"},
        }, tooltip = "Cursor icon when hovering" },
        { key = "castBarCaption", label = "Cast Bar Caption:", type = "text", tooltip = "Text shown in cast bar when using" },
        { key = "unk1", label = "Unknown String:", type = "text", tooltip = "Unknown field (usually empty)" },
    },
    Data1 = {
        { key = "Data0", label = "Data 0:", type = "number", min = 0, tooltip = "Data field 0" },
        { key = "Data1", label = "Data 1:", type = "number", min = -2147483648, max = 2147483647, tooltip = "Data field 1" },
        { key = "Data2", label = "Data 2:", type = "number", min = 0, tooltip = "Data field 2" },
        { key = "Data3", label = "Data 3:", type = "number", min = 0, tooltip = "Data field 3" },
        { key = "Data4", label = "Data 4:", type = "number", min = 0, tooltip = "Data field 4" },
        { key = "Data5", label = "Data 5:", type = "number", min = 0, tooltip = "Data field 5" },
        { key = "Data6", label = "Data 6:", type = "number", min = -2147483648, max = 2147483647, tooltip = "Data field 6" },
        { key = "Data7", label = "Data 7:", type = "number", min = 0, tooltip = "Data field 7" },
        { key = "Data8", label = "Data 8:", type = "number", min = 0, tooltip = "Data field 8" },
        { key = "Data9", label = "Data 9:", type = "number", min = 0, tooltip = "Data field 9" },
        { key = "Data10", label = "Data 10:", type = "number", min = 0, tooltip = "Data field 10" },
        { key = "Data11", label = "Data 11:", type = "number", min = 0, tooltip = "Data field 11" },
    },
    Data2 = {
        { key = "Data12", label = "Data 12:", type = "number", min = 0, tooltip = "Data field 12" },
        { key = "Data13", label = "Data 13:", type = "number", min = 0, tooltip = "Data field 13" },
        { key = "Data14", label = "Data 14:", type = "number", min = 0, tooltip = "Data field 14" },
        { key = "Data15", label = "Data 15:", type = "number", min = 0, tooltip = "Data field 15" },
        { key = "Data16", label = "Data 16:", type = "number", min = 0, tooltip = "Data field 16" },
        { key = "Data17", label = "Data 17:", type = "number", min = 0, tooltip = "Data field 17" },
        { key = "Data18", label = "Data 18:", type = "number", min = 0, tooltip = "Data field 18" },
        { key = "Data19", label = "Data 19:", type = "number", min = 0, tooltip = "Data field 19" },
        { key = "Data20", label = "Data 20:", type = "number", min = 0, tooltip = "Data field 20" },
        { key = "Data21", label = "Data 21:", type = "number", min = 0, tooltip = "Data field 21" },
        { key = "Data22", label = "Data 22:", type = "number", min = 0, tooltip = "Data field 22" },
        { key = "Data23", label = "Data 23:", type = "number", min = 0, tooltip = "Data field 23" },
    },
    Scripts = {
        { key = "AIName", label = "AI Name:", type = "text", tooltip = "AI script name (SmartGameObjectAI, etc.)" },
        { key = "ScriptName", label = "Script Name:", type = "text", tooltip = "C++ script name" },
        { key = "StringId", label = "String ID:", type = "text", tooltip = "String identifier for scripts" },
    },
    Addon = {
        { key = "faction", label = "Faction:", type = "number", min = 0, max = 65535, tooltip = "Faction template ID" },
        { key = "flags", label = "Flags:", type = "flags", tooltip = "GameObject flags" },
        { key = "mingold", label = "Min Gold:", type = "number", min = 0, tooltip = "Minimum gold drop (copper)" },
        { key = "maxgold", label = "Max Gold:", type = "number", min = 0, tooltip = "Maximum gold drop (copper)" },
        { key = "artkit0", label = "ArtKit 0:", type = "number", min = -2147483648, max = 2147483647, tooltip = "Art kit ID 0" },
        { key = "artkit1", label = "ArtKit 1:", type = "number", min = -2147483648, max = 2147483647, tooltip = "Art kit ID 1" },
        { key = "artkit2", label = "ArtKit 2:", type = "number", min = -2147483648, max = 2147483647, tooltip = "Art kit ID 2" },
        { key = "artkit3", label = "ArtKit 3:", type = "number", min = -2147483648, max = 2147483647, tooltip = "Art kit ID 3" },
    }
}

-- Configuration constants
GameObjectFieldDefs.CONFIG = {
    WINDOW_WIDTH = 700,
    WINDOW_HEIGHT = 550,
    TAB_HEIGHT = 32,
    FIELD_HEIGHT = 35,
    LABEL_WIDTH = 180,
    INPUT_WIDTH = 250,
    PADDING = 10,
    TABS = {
        "Basic",
        "Data1",
        "Data2",
        "Scripts",
        "Addon"
    }
}

-- Update data fields based on GameObject type
function GameObjectFieldDefs.UpdateDataFields(goType)
    -- Update Data1 tab fields
    for i = 0, 11 do
        local fieldDef = GameObjectFieldDefs.GetDataField(goType, i)
        local key = "Data" .. i
        
        -- Find and update the field in Data1 tab
        for j, field in ipairs(GameObjectFieldDefs.FIELDS.Data1) do
            if field.key == key then
                GameObjectFieldDefs.FIELDS.Data1[j] = {
                    key = key,
                    label = fieldDef.name .. ":",
                    type = fieldDef.type,
                    min = fieldDef.min,
                    max = fieldDef.max,
                    options = fieldDef.options,
                    tooltip = fieldDef.tooltip,
                    defaultValue = fieldDef.defaultValue,
                    step = fieldDef.step
                }
                break
            end
        end
    end
    
    -- Data2 tab fields don't usually have special meanings, but we can still update tooltips
    for i = 12, 23 do
        local fieldDef = GameObjectFieldDefs.GetDataField(goType, i)
        local key = "Data" .. i
        
        for j, field in ipairs(GameObjectFieldDefs.FIELDS.Data2) do
            if field.key == key then
                GameObjectFieldDefs.FIELDS.Data2[j].tooltip = fieldDef.tooltip
                break
            end
        end
    end
end

-- print("|cFF00FF00[GameObjectFieldDefs] Module loaded|r")