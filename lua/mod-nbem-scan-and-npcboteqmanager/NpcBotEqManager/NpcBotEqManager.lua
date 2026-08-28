local ADDON = "NpcBotEqManager"
NBEM_DB = NBEM_DB or {}

local DEFAULTS = {
    scanCommand = ".nbem scan",
    equipCommand = ".nbem equip {slot} {bag} {bagslot}",
    unequipCommand = ".nbem unequip {slot}",
    minimapAngle = 225,
    bagVisible = true,
    profiles = {},
}

local SLOT_ORDER = {
    "HEAD", "NECK", "SHOULDER", "BACK",
    "CHEST", "WRIST",
    "HANDS", "WAIST", "LEGS", "FEET",
    "FINGER1", "FINGER2", "TRINKET1", "TRINKET2",
    "MAINHAND", "OFFHAND", "RANGED",
}
local SLOT_LAYOUT = {
    HEAD = { side = "LEFT", row = 1 },
    NECK = { side = "LEFT", row = 2 },
    SHOULDER = { side = "LEFT", row = 3 },
    BACK = { side = "LEFT", row = 4 },
    CHEST = { side = "LEFT", row = 5 },
    WRIST = { side = "LEFT", row = 6 },
    HANDS = { side = "LEFT", row = 7 },
    WAIST = { side = "LEFT", row = 8 },
    LEGS = { side = "LEFT", row = 9 },
    FEET = { side = "LEFT", row = 10 },
    FINGER1 = { side = "RIGHT", row = 1 },
    FINGER2 = { side = "RIGHT", row = 2 },
    TRINKET1 = { side = "RIGHT", row = 3 },
    TRINKET2 = { side = "RIGHT", row = 4 },
    MAINHAND = { side = "RIGHT", row = 5 },
    OFFHAND = { side = "RIGHT", row = 6 },
    RANGED = { side = "RIGHT", row = 7 },
}

local STAT_ORDER = {
    { key = "LEVEL", label = "Level" },
    { key = "CLASS", label = "Class" },
    { key = "HEALTH", label = "Health" },
    { key = "POWER", label = "Power" },
    { key = "ARMOR", label = "Armor" },
    { key = "STR", label = "Str" },
    { key = "AGI", label = "Agi" },
    { key = "STA", label = "Sta" },
    { key = "INT", label = "Int" },
    { key = "SPI", label = "Spi" },
    { key = "CRIT", label = "Crit" },
    { key = "HASTE", label = "Haste" },
    { key = "HIT", label = "Hit" },
    { key = "MP5", label = "MP5" },
    { key = "DMG", label = "Dmg" },
    { key = "HEAL", label = "Heal" },
    { key = "EXP", label = "Exp" },
    { key = "DODGE", label = "Dodge" },
    { key = "DEF", label = "Def" },
    { key = "BLOCK", label = "Block" },
    { key = "PARRY", label = "Parry" },
}
local SLOT_LABELS = {
    HEAD = "Head", NECK = "Neck", SHOULDER = "Shoulder", BACK = "Back",
    CHEST = "Chest", WRIST = "Wrist",
    HANDS = "Hands", WAIST = "Waist", LEGS = "Legs", FEET = "Feet",
    FINGER1 = "Finger 1", FINGER2 = "Finger 2", TRINKET1 = "Trinket 1", TRINKET2 = "Trinket 2",
    MAINHAND = "Main Hand", OFFHAND = "Off Hand", RANGED = "Ranged",
}

local SLOT_TEXTURES = {
    HEAD = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Head",
    NECK = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Neck",
    SHOULDER = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shoulder",
    BACK = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest",
    CHEST = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest",
    SHIRT = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shirt",
    TABARD = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Tabard",
    WRIST = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Wrists",
    HANDS = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Hands",
    WAIST = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Waist",
    LEGS = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Legs",
    FEET = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Feet",
    FINGER1 = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Finger",
    FINGER2 = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Finger",
    TRINKET1 = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket",
    TRINKET2 = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket",
    MAINHAND = "Interface\\PaperDoll\\UI-PaperDoll-Slot-MainHand",
    OFFHAND = "Interface\\PaperDoll\\UI-PaperDoll-Slot-SecondaryHand",
    RANGED = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Ranged",
}

local EQUIP_LOC_SLOT = {
    INVTYPE_HEAD = "HEAD",
    INVTYPE_NECK = "NECK",
    INVTYPE_SHOULDER = "SHOULDER",
    INVTYPE_CLOAK = "BACK",
    INVTYPE_CHEST = "CHEST",
    INVTYPE_ROBE = "CHEST",
    INVTYPE_WRIST = "WRIST",
    INVTYPE_HAND = "HANDS",
    INVTYPE_WAIST = "WAIST",
    INVTYPE_LEGS = "LEGS",
    INVTYPE_FEET = "FEET",
    INVTYPE_FINGER = "FINGER1",
    INVTYPE_TRINKET = "TRINKET1",
    INVTYPE_WEAPONMAINHAND = "MAINHAND",
    INVTYPE_2HWEAPON = "MAINHAND",
    INVTYPE_WEAPON = "MAINHAND",
    INVTYPE_WEAPONOFFHAND = "OFFHAND",
    INVTYPE_SHIELD = "OFFHAND",
    INVTYPE_HOLDABLE = "OFFHAND",
    INVTYPE_RANGED = "RANGED",
    INVTYPE_THROWN = "RANGED",
    INVTYPE_RANGEDRIGHT = "RANGED",
    INVTYPE_RELIC = "RANGED",
}

local SLOT_PATTERNS = {
    {"main%s*hand", "MAINHAND"}, {"mainhand", "MAINHAND"}, {"mhand", "MAINHAND"}, {"mh", "MAINHAND"}, {"weapon", "MAINHAND"}, {"off%s*hand", "OFFHAND"}, {"offhand", "OFFHAND"}, {"shield", "OFFHAND"}, {"oh", "OFFHAND"}, {"ranged", "RANGED"}, {"relic", "RANGED"}, {"libram", "RANGED"}, {"idol", "RANGED"}, {"totem", "RANGED"}, {"sigil", "RANGED"},
    {"head", "HEAD"}, {"neck", "NECK"}, {"should", "SHOULDER"}, {"back", "BACK"}, {"cloak", "BACK"},
    {"chest", "CHEST"}, {"robe", "CHEST"}, {"wrist", "WRIST"},
    {"hands", "HANDS"}, {"gloves", "HANDS"}, {"waist", "WAIST"}, {"belt", "WAIST"},
    {"legs", "LEGS"}, {"pants", "LEGS"}, {"feet", "FEET"}, {"boots", "FEET"},
    {"finger%s*2", "FINGER2"}, {"finger", "FINGER1"}, {"ring%s*2", "FINGER2"}, {"ring", "FINGER1"},
    {"trinket%s*2", "TRINKET2"}, {"trinket", "TRINKET1"},
}

local frame, bagFrame, minimapButton
local CreateUI, RefreshBags, AutoScanTarget, CreateMinimapButton
local BAG_PAGE_SIZE = 10
local bagPage = 1
local bagItems = {}
local slotButtons = {}
local statButtons = {}
local bagButtons = {}
local pendingLinks = {}
local cursorBagItem = nil
local scanPending = false
local lastAutoScanGuid = nil
local lastAutoScanAt = 0
local autoScanQueued = false
local autoScanForce = false
local autoScanDelay = 0
local activeName = "Unknown"
local autoGossip = false
local autoGossipSteps = 0
local BAD_COMMANDS = {
    [".npcbot"] = true,
    [".npcbot info"] = true,
    [".npcbot equip {link}"] = true,
    [".npcbot unequip {slot}"] = true,
}

local function NormalizeCommand(command)
    return string.lower(string.gsub(command or "", "^%s*(.-)%s*$", "%1"))
end

local function IsBlockedCommand(command)
    local normalized = NormalizeCommand(command)
    if normalized == "" then return false end
    if BAD_COMMANDS[normalized] then return true end
    if string.find(normalized, "^%.npcbot%s*$") then return true end
    if string.find(normalized, "^%.npcbot%s+") then return true end
    return false
end

local function CopyDefaults()
    for k, v in pairs(DEFAULTS) do
        if NBEM_DB[k] == nil then
            if type(v) == "table" then NBEM_DB[k] = {} else NBEM_DB[k] = v end
        end
    end

    NBEM_DB.version = NBEM_DB.version or 0
    for _, key in ipairs({ "scanCommand", "equipCommand", "unequipCommand" }) do
        local command = NBEM_DB[key] or ""
        if IsBlockedCommand(command) then
            NBEM_DB[key] = ""
        end
    end
    if not NBEM_DB.scanCommand or NBEM_DB.scanCommand == "" then
        NBEM_DB.scanCommand = DEFAULTS.scanCommand
    end
    if not NBEM_DB.equipCommand or NBEM_DB.equipCommand == "" then
        NBEM_DB.equipCommand = DEFAULTS.equipCommand
    end
    if not NBEM_DB.unequipCommand or NBEM_DB.unequipCommand == "" then
        NBEM_DB.unequipCommand = DEFAULTS.unequipCommand
    end
    NBEM_DB.version = 4
end

local function Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cff74c0fcNBEM:|r " .. tostring(msg))
end

local function GetActiveName()
    local name = UnitName("target")
    if name and name ~= "" then
        activeName = name
    end
    return activeName
end

local function HasTarget()
    return UnitExists("target")
end

local function IsPlayerTarget()
    if not UnitExists("target") then return false end
    if type(UnitGUID) == "function" then
        local guid = UnitGUID("target")
        if guid then
            if string.sub(guid, 1, 3) == "0x0" then return true end
            if string.sub(guid, 1, 3) == "0xF" then return false end
        end
    end
    return UnitIsPlayer("target")
end

local function CanSendBotCommand(action)
    if not HasTarget() then
        Print("select one of your NPCBots first")
        return false
    end
    if IsPlayerTarget() then
        Print(action .. " only works on NPCBots")
        return false
    end
    return true
end

local function GetProfile(name)
    name = name or GetActiveName()
    NBEM_DB.profiles[name] = NBEM_DB.profiles[name] or { slots = {}, stats = {} }
    NBEM_DB.profiles[name].slots = NBEM_DB.profiles[name].slots or {}
    NBEM_DB.profiles[name].stats = NBEM_DB.profiles[name].stats or {}
    return NBEM_DB.profiles[name]
end
local function GetBotClassName()
    local profile = GetProfile()
    local entry = profile.stats and profile.stats.CLASS
    return entry and entry.value or ""
end

local function UsesRelicSlot()
    local class = GetBotClassName()
    return class == "Paladin" or class == "Druid" or class == "Shaman" or class == "Death Knight"
end

local function SlotLabel(slot)
    if slot == "RANGED" and UsesRelicSlot() then return "Relic" end
    return SLOT_LABELS[slot] or slot
end

local function FirstOpenTwin(slot, profile)
    if slot == "FINGER1" and profile.slots.FINGER1 and not profile.slots.FINGER2 then return "FINGER2" end
    if slot == "TRINKET1" and profile.slots.TRINKET1 and not profile.slots.TRINKET2 then return "TRINKET2" end
    return slot
end

local function InferSlotFromText(text)
    local lower = string.lower(text or "")
    local bestPos, bestSlot
    for i = 1, table.getn(SLOT_PATTERNS) do
        local pattern = SLOT_PATTERNS[i][1]
        local searchFrom = 1
        while true do
            local pos = string.find(lower, pattern, searchFrom)
            if not pos then break end
            if not bestPos or pos >= bestPos then
                bestPos = pos
                bestSlot = SLOT_PATTERNS[i][2]
            end
            searchFrom = pos + 1
        end
    end
    return bestSlot
end

local function InferSlotNearLink(text, linkStart)
    local prefix = string.sub(text or "", math.max(1, linkStart - 96), linkStart - 1)
    return InferSlotFromText(prefix)
end

local CLASS_ARMOR = {
    WARRIOR = { plate = true, shield = true },
    PALADIN = { plate = true, shield = true, libram = true },
    HUNTER = { mail = true },
    ROGUE = { leather = true },
    PRIEST = { cloth = true },
    DEATHKNIGHT = { plate = true, sigil = true },
    SHAMAN = { mail = true, shield = true, totem = true },
    MAGE = { cloth = true },
    WARLOCK = { cloth = true },
    DRUID = { leather = true, idol = true },
}
local CLASS_DRAG_ARMOR = {
    WARRIOR = { cloth = true, leather = true, mail = true, plate = true, shield = true },
    PALADIN = { cloth = true, leather = true, mail = true, plate = true, shield = true, libram = true },
    HUNTER = { cloth = true, leather = true, mail = true },
    ROGUE = { cloth = true, leather = true },
    PRIEST = { cloth = true },
    DEATHKNIGHT = { cloth = true, leather = true, mail = true, plate = true, sigil = true },
    SHAMAN = { cloth = true, leather = true, mail = true, shield = true, totem = true },
    MAGE = { cloth = true },
    WARLOCK = { cloth = true },
    DRUID = { cloth = true, leather = true, idol = true },
}
local CLASS_WEAPONS = {
    WARRIOR = { axe = true, axe2 = true, bow = true, crossbow = true, dagger = true, fist = true, gun = true, mace = true, mace2 = true, polearm = true, staff = true, sword = true, sword2 = true, thrown = true },
    PALADIN = { axe = true, axe2 = true, mace = true, mace2 = true, polearm = true, sword = true, sword2 = true },
    HUNTER = { axe = true, axe2 = true, bow = true, crossbow = true, dagger = true, fist = true, gun = true, polearm = true, staff = true, sword = true, sword2 = true, thrown = true },
    ROGUE = { axe = true, bow = true, crossbow = true, dagger = true, fist = true, gun = true, mace = true, sword = true, thrown = true },
    PRIEST = { dagger = true, mace = true, staff = true, wand = true },
    DEATHKNIGHT = { axe = true, axe2 = true, mace = true, mace2 = true, polearm = true, sword = true, sword2 = true },
    SHAMAN = { axe = true, axe2 = true, dagger = true, fist = true, mace = true, mace2 = true, staff = true },
    MAGE = { dagger = true, staff = true, sword = true, wand = true },
    WARLOCK = { dagger = true, staff = true, sword = true, wand = true },
    DRUID = { dagger = true, fist = true, mace = true, mace2 = true, polearm = true, staff = true },
}

local function GetTargetClassToken()
    local className, classToken = UnitClass("target")
    classToken = classToken or className
    if not classToken then return nil end
    classToken = string.upper(string.gsub(classToken, "%s+", ""))
    if classToken == "DEATHKNIGHT" then return "DEATHKNIGHT" end
    return classToken
end

local function NormalizedItemSubType(itemSubType, equipLoc)
    local text = string.lower(itemSubType or "")
    if equipLoc == "INVTYPE_2HWEAPON" then
        if string.find(text, "axe") then return "axe2" end
        if string.find(text, "mace") then return "mace2" end
        if string.find(text, "sword") then return "sword2" end
    end
    if string.find(text, "cloth") then return "cloth" end
    if string.find(text, "leather") then return "leather" end
    if string.find(text, "mail") then return "mail" end
    if string.find(text, "plate") then return "plate" end
    if string.find(text, "shield") then return "shield" end
    if string.find(text, "libram") then return "libram" end
    if string.find(text, "idol") then return "idol" end
    if string.find(text, "totem") then return "totem" end
    if string.find(text, "sigil") then return "sigil" end
    if string.find(text, "crossbow") then return "crossbow" end
    if string.find(text, "bow") then return "bow" end
    if string.find(text, "gun") then return "gun" end
    if string.find(text, "dagger") then return "dagger" end
    if string.find(text, "fist") then return "fist" end
    if string.find(text, "polearm") then return "polearm" end
    if string.find(text, "staff") or string.find(text, "staves") then return "staff" end
    if string.find(text, "wand") then return "wand" end
    if string.find(text, "thrown") then return "thrown" end
    if string.find(text, "axe") then return "axe" end
    if string.find(text, "mace") then return "mace" end
    if string.find(text, "sword") then return "sword" end
    return nil
end


local function IsBotHighEnoughForItem(link)
    local _, _, _, _, itemMinLevel = GetItemInfo(link)
    if not itemMinLevel or itemMinLevel <= 0 then return true end

    local botLevel = UnitLevel("target")
    if not botLevel or botLevel <= 0 then return true end

    return botLevel >= itemMinLevel
end
local function IsBotUsableItem(link, slotKey, allowDowngradeArmor)
    if not IsBotHighEnoughForItem(link) then return false end

    local classToken = GetTargetClassToken()
    if not classToken then return true end

    local _, _, _, _, _, _, itemSubType, _, equipLoc = GetItemInfo(link)
    if not equipLoc or not slotKey then return false end

    if slotKey == "NECK" or slotKey == "BACK" or slotKey == "FINGER1" or slotKey == "FINGER2" or slotKey == "TRINKET1" or slotKey == "TRINKET2" then
        return true
    end

    local subtype = NormalizedItemSubType(itemSubType, equipLoc)
    if not subtype then return false end

    local armor = allowDowngradeArmor and CLASS_DRAG_ARMOR[classToken] or CLASS_ARMOR[classToken]
    if armor and armor[subtype] then return true end

    local weapons = CLASS_WEAPONS[classToken]
    if weapons and weapons[subtype] then return true end

    return false
end
local function ItemIdFromLink(link)
    local itemId = link and string.match(link, "item:(%d+)")
    return itemId and tonumber(itemId) or nil
end

local function InferSlotFromItem(link)
    local _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(link)
    return equipLoc and EQUIP_LOC_SLOT[equipLoc]
end

local function SlotAcceptsItem(slotKey, inferredSlot)
    if not slotKey or not inferredSlot then return false end
    if slotKey == inferredSlot then return true end
    if inferredSlot == "FINGER1" and (slotKey == "FINGER1" or slotKey == "FINGER2") then return true end
    if inferredSlot == "TRINKET1" and (slotKey == "TRINKET1" or slotKey == "TRINKET2") then return true end
    return false
end

local function TrackCursorBagItem(bag, slot)
    if bag == nil or slot == nil then return end
    local cursorType, _, cursorLink = GetCursorInfo()
    local link = cursorLink or GetContainerItemLink(bag, slot)
    if cursorType == "item" and link then
        cursorBagItem = { bag = bag, bagSlot = slot, link = link }
    end
end

local function HookBagPickupTracking()
    if hooksecurefunc then
        hooksecurefunc("PickupContainerItem", TrackCursorBagItem)
    end
end

local function TextureFor(link, slot)
    if link then
        local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(link)
        if texture then return texture end

        local itemId = ItemIdFromLink(link)
        if itemId and GetItemIcon then
            texture = GetItemIcon(itemId)
            if texture then return texture end
        end
    end
    return SLOT_TEXTURES[slot] or "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function HideCompareTooltips()
    if ShoppingTooltip1 then ShoppingTooltip1:Hide() end
    if ShoppingTooltip2 then ShoppingTooltip2:Hide() end
end

local function ShowBotCompareTooltip(owner, candidateLink, slotKey)
    HideCompareTooltips()
    if not candidateLink then return end

    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink(candidateLink)
    GameTooltip:Show()

    local compare = ShoppingTooltip1
    if not compare then return end

    local profile = GetProfile()
    local currentLink = profile.slots[slotKey]
    compare:SetOwner(owner, "ANCHOR_NONE")
    compare:ClearAllPoints()
    compare:SetPoint("TOPRIGHT", owner, "TOPLEFT", -8, 0)
    if currentLink then
        compare:SetHyperlink(currentLink)
    else
        compare:SetText(SlotLabel(slotKey) .. ": Empty")
    end
    compare:Show()
end

local function ShortValue(value)
    if value == nil or value == "" then return "-" end
    return tostring(value)
end

local function UnitStatValue(index)
    if type(UnitStat) ~= "function" or not HasTarget() then return "-" end
    local _, effective = UnitStat("target", index)
    return ShortValue(effective)
end

local function StatEntry(key)
    local profile = GetProfile()
    return profile.stats and profile.stats[key] or nil
end

local function ShortPowerValue(value)
    local n = tonumber(value)
    if not n then return tostring(value or "-") end
    if n >= 1000000 then return string.format("%.1fm", n / 1000000) end
    if n >= 10000 then return string.format("%.1fk", n / 1000) end
    return tostring(math.floor(n + 0.5))
end

local function StatLabel(stat)
    local entry = StatEntry(stat.key)
    local label = (entry and entry.label) or stat.label
    if stat.key == "POWER" and label == "Runic Power" then return "Runic" end
    return label
end

local function StatValue(key)
    local entry = StatEntry(key)
    if entry and entry.value ~= nil and entry.value ~= "" then
        if key == "POWER" then
            local current, maximum = string.match(entry.value, "^(%d+)/(%d+)$")
            if current and maximum then
                local label = entry.label or ""
                if label == "Mana" then return ShortPowerValue(maximum) end
                return ShortPowerValue(current) .. "/" .. ShortPowerValue(maximum)
            end
        end
        return entry.value
    end

    if not HasTarget() then return "-" end
    if key == "LEVEL" then return ShortValue(UnitLevel("target")) end
    if key == "HEALTH" then
        if type(UnitHealthMax) == "function" then return ShortValue(UnitHealthMax("target")) end
        return "-"
    end
    return "-"
end

local function FrameBotModel(model)
    if not model then return end
    if model.SetRotation then model:SetRotation(0) end
    if model.SetPortraitZoom then model:SetPortraitZoom(0) end
    if model.SetCamDistanceScale then model:SetCamDistanceScale(1.22) end
    if model.SetPosition then model:SetPosition(0, 0, -0.22) end
end
local function UpdateModelAndStats()
    if not frame then return end

    if frame.model and HasTarget() and frame.model.SetUnit then
        frame.model:SetUnit("target")
        FrameBotModel(frame.model)
    end

    for i = 1, table.getn(STAT_ORDER) do
        local stat = STAT_ORDER[i]
        local box = statButtons[stat.key]
        if box then
            box.label:SetText(StatLabel(stat))
            box.value:SetText(StatValue(stat.key))
        end
    end
end
local function RefreshSlots()
    if not frame then return end
    local profile = GetProfile()
    frame.title:SetText("NpcBot Equipment: " .. GetActiveName())
    frame.scan:SetText("Scan")
    for _, slot in ipairs(SLOT_ORDER) do
        local button = slotButtons[slot]
        local link = profile.slots[slot]
        button.icon:SetTexture(TextureFor(link, slot))
        button.label:SetText(SlotLabel(slot))
        button.item:SetText("")
        button.itemLink = link
    end
    UpdateModelAndStats()
end

local function ApplyTemplate(template, link, slot, bag, bagSlot)
    local cmd = template or ""
    cmd = string.gsub(cmd, "{link}", link or "")
    cmd = string.gsub(cmd, "{slot}", slot or "")
    cmd = string.gsub(cmd, "{name}", GetActiveName() or "")
    cmd = string.gsub(cmd, "{bag}", tostring(bag or ""))
    cmd = string.gsub(cmd, "{bagslot}", tostring(bagSlot or ""))
    return cmd
end

local function SendCommand(cmd)
    if not cmd or cmd == "" then return end
    if IsBlockedCommand(cmd) then
        Print("blocked NPCBot chat command; Trickerer equipment is gossip-based")
        return
    end
    SendChatMessage(cmd, "SAY")
end

local function ScanTarget()
    GetActiveName()
    if not CanSendBotCommand("scan") then return end
    if not frame then CreateUI() end
    GetProfile().slots = {}
    GetProfile().stats = {}
    pendingLinks = {}
    scanPending = true
    RefreshSlots()
    RefreshBags()
    frame:Show()
    if NBEM_DB.scanCommand and NBEM_DB.scanCommand ~= "" then
        if IsBlockedCommand(NBEM_DB.scanCommand) then
            NBEM_DB.scanCommand = ""
            Print("cleared invalid .npcbot scan command")
        else
            SendCommand(NBEM_DB.scanCommand)
            return
        end
    end
    Print("scan command is not configured. Install mod-nbem-scan or run /nbem scancmd .nbem scan")
end

local function EquipLink(link, slot, bag, bagSlot)
    if not link then return end
    if not CanSendBotCommand("equip") then return end
    if not NBEM_DB.equipCommand or NBEM_DB.equipCommand == "" then
        NBEM_DB.equipCommand = DEFAULTS.equipCommand
    end
    SendCommand(ApplyTemplate(NBEM_DB.equipCommand, link, slot, bag, bagSlot))
    AutoScanTarget(true, 0.65)
end
local function FindCursorBagItem(cursorLink)
    if cursorBagItem and cursorBagItem.bag and cursorBagItem.bagSlot then
        if not cursorLink or not cursorBagItem.link or cursorBagItem.link == cursorLink then
            return cursorBagItem
        end
    end

    if cursorLink then
        for bag = 0, NUM_BAG_SLOTS do
            for slot = 1, GetContainerNumSlots(bag) do
                local link = GetContainerItemLink(bag, slot)
                if link == cursorLink then
                    return { bag = bag, bagSlot = slot, link = link }
                end
            end
        end
    end

    return nil
end

local function EquipCursorItem(slotKey)
    local cursorType, _, cursorLink = GetCursorInfo()
    if cursorType ~= "item" then return end

    local dragged = FindCursorBagItem(cursorLink)
    if not dragged or not dragged.bag or not dragged.bagSlot then
        Print("drag items from your bags onto a slot")
        return
    end

    local link = cursorLink or dragged.link or GetContainerItemLink(dragged.bag, dragged.bagSlot)
    local inferred = link and InferSlotFromItem(link)
    if not SlotAcceptsItem(slotKey, inferred) then
        Print("that item does not belong in " .. SlotLabel(slotKey))
        return
    end

    if not IsBotUsableItem(link, slotKey, true) then
        Print("bot cannot use that item")
        return
    end

    EquipLink(link, slotKey, dragged.bag, dragged.bagSlot)
    ClearCursor()
    cursorBagItem = nil
end

local function UnequipSlot(slot)
    if not slot then return end
    if not CanSendBotCommand("unequip") then return end
    if not NBEM_DB.unequipCommand or NBEM_DB.unequipCommand == "" then
        NBEM_DB.unequipCommand = DEFAULTS.unequipCommand
    end
    SendCommand(ApplyTemplate(NBEM_DB.unequipCommand, nil, slot))
    AutoScanTarget(true, 0.65)
end

local function StoreItem(slot, link, explicitSlot)
    if not slot or not link then return end
    local profile = GetProfile()
    if not explicitSlot then
        slot = FirstOpenTwin(slot, profile)
    end
    profile.slots[slot] = link
    RefreshSlots()
end

local function ClearSlot(slot)
    if not slot then return end
    GetProfile().slots[slot] = nil
    RefreshSlots()
end

local function QueuePendingLink(link)
    if link then pendingLinks[link] = true end
end

local function RetryPendingLinks()
    local updated = false
    for link in pairs(pendingLinks) do
        local slot = InferSlotFromItem(link)
        if slot then
            pendingLinks[link] = nil
            StoreItem(slot, link, false)
            updated = true
        end
    end
    if updated then RefreshSlots() end
end

local function ScrapeLine(text)
    if not text or text == "" then return end

    if string.find(text, "^NBEM_ERROR") then
        scanPending = false
        return
    end

    local scanName = string.match(text, "^NBEM_SCAN_BEGIN%s+(.+)$")
    if scanName then
        activeName = scanName
        GetProfile(scanName).slots = {}
        GetProfile(scanName).stats = {}
        pendingLinks = {}
        scanPending = true
        RefreshSlots()
        return
    end

    local statKey, statLabel, statValue = string.match(text, "^NBEM_STAT%s+(%S+)%s+(.+):%s+(.+)$")
    if statKey and statValue then
        local profile = GetProfile()
        profile.stats = profile.stats or {}
        profile.stats[statKey] = { label = statLabel, value = statValue }
        RefreshSlots()
        return
    end
    local slotKey, payload = string.match(text, "^NBEM_SLOT%s+(%S+)%s+.-:%s+(.+)$")
    if slotKey and SLOT_LABELS[slotKey] then
        if payload == "NONE" then
            ClearSlot(slotKey)
        else
            local link = string.match(payload, "(|c%x+|Hitem:[^|]+|h%[[^%]]+%]|h|r)")
            if link then StoreItem(slotKey, link, true) end
        end
        return
    end

    local endName = string.match(text, "^NBEM_SCAN_END%s+(.+)$")
    if endName then
        activeName = endName
        scanPending = false
        RefreshSlots()
        return
    end

    local found = false
    local searchStart = 1
    while true do
        local linkStart, linkEnd, link = string.find(text, "(|c%x+|Hitem:[^|]+|h%[[^%]]+%]|h|r)", searchStart)
        if not linkStart then break end
        local explicitSlot = InferSlotNearLink(text, linkStart)
        local slot = explicitSlot or InferSlotFromItem(link)
        if slot then
            StoreItem(slot, link, explicitSlot ~= nil)
            found = true
        else
            QueuePendingLink(link)
        end
        searchStart = linkEnd + 1
    end
end

local function CleanGossipText(text)
    text = text or ""
    text = string.gsub(text, "|c%x%x%x%x%x%x%x%x", "")
    text = string.gsub(text, "|r", "")
    return string.lower(text)
end

local function ScrapeRegionText(region)
    if region and region:IsShown() and region.GetText then
        local text = region:GetText()
        if text and text ~= "" then ScrapeLine(text) end
    end
end

local function ScrapeFrameText(widget)
    if not widget or not widget:IsShown() then return end
    ScrapeRegionText(widget)
    if widget.GetRegions then
        local regions = { widget:GetRegions() }
        for i = 1, table.getn(regions) do ScrapeRegionText(regions[i]) end
    end
    if widget.GetChildren then
        local children = { widget:GetChildren() }
        for i = 1, table.getn(children) do ScrapeFrameText(children[i]) end
    end
end

local function ScrapeGossipFrame()
    if not GossipFrame or not GossipFrame:IsShown() then return end
    for i = 1, 32 do
        local button = getglobal("GossipTitleButton" .. i)
        if button and button:IsShown() then
            local text = button:GetText()
            if text and text ~= "" then ScrapeLine(text) end
        end
    end
    ScrapeFrameText(GossipFrame)
    if scanPending then
        scanPending = false
        RefreshSlots()
    end
end

local function BuildBagItems()
    bagItems = {}
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local link = GetContainerItemLink(bag, slot)
            local inferred = link and InferSlotFromItem(link)
            if link and inferred and IsBotUsableItem(link, inferred) then
                if inferred == "FINGER1" then
                    table.insert(bagItems, { link = link, slotKey = "FINGER1", bag = bag, bagSlot = slot })
                    table.insert(bagItems, { link = link, slotKey = "FINGER2", bag = bag, bagSlot = slot })
                elseif inferred == "TRINKET1" then
                    table.insert(bagItems, { link = link, slotKey = "TRINKET1", bag = bag, bagSlot = slot })
                    table.insert(bagItems, { link = link, slotKey = "TRINKET2", bag = bag, bagSlot = slot })
                else
                    table.insert(bagItems, { link = link, slotKey = inferred, bag = bag, bagSlot = slot })
                end
            end
        end
    end
end

function RefreshBags()
    if not bagFrame then return end
    for i = 1, table.getn(bagButtons) do bagButtons[i]:Hide() end

    BuildBagItems()

    local total = table.getn(bagItems)
    local maxPage = math.max(1, math.ceil(total / BAG_PAGE_SIZE))
    if bagPage > maxPage then bagPage = maxPage end
    if bagPage < 1 then bagPage = 1 end

    local first = ((bagPage - 1) * BAG_PAGE_SIZE) + 1
    local last = math.min(total, first + BAG_PAGE_SIZE - 1)
    local visible = 1

    for itemIndex = first, last do
        local item = bagItems[itemIndex]
        local btn = bagButtons[visible]
        if not btn then
            btn = CreateFrame("Button", nil, bagFrame, "UIPanelButtonTemplate")
            btn:SetWidth(220)
            btn:SetHeight(34)
            btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            btn.text:SetPoint("LEFT", 10, 0)
            btn.text:SetWidth(198)
            btn.text:SetHeight(28)
            btn.text:SetJustifyH("LEFT")
            btn.text:SetJustifyV("MIDDLE")
            bagButtons[visible] = btn
        end
        btn:SetPoint("TOPLEFT", 8, -8 - ((visible - 1) * 36))
        btn.text:ClearAllPoints()
        btn.text:SetPoint("LEFT", 10, 0)
        btn.text:SetHeight(28)
        btn.text:SetJustifyV("MIDDLE")
        btn.link = item.link
        btn.slotKey = item.slotKey
        btn.bag = item.bag
        btn.bagSlot = item.bagSlot
        btn.text:SetText(SlotLabel(item.slotKey) .. ": " .. item.link)
        btn:SetScript("OnClick", function(self) EquipLink(self.link, self.slotKey, self.bag, self.bagSlot) end)
        btn:SetScript("OnEnter", function(self)
            ShowBotCompareTooltip(self, self.link, self.slotKey)
        end)
        btn:SetScript("OnLeave", function()
            GameTooltip:Hide()
            HideCompareTooltips()
        end)
        btn:Show()
        visible = visible + 1
    end

    if bagFrame.pageText then
        bagFrame.pageText:SetText("Page " .. bagPage .. "/" .. maxPage .. "  (" .. total .. " items)")
    end
    if bagFrame.prev then
        if bagPage <= 1 then bagFrame.prev:Disable() else bagFrame.prev:Enable() end
    end
    if bagFrame.next then
        if bagPage >= maxPage then bagFrame.next:Disable() else bagFrame.next:Enable() end
    end
end

local function RunAutoScan(force)
    if not frame or not frame:IsShown() then return end
    if not HasTarget() or IsPlayerTarget() then return end
    if scanPending and not force then return end

    local guid = GetActiveName()
    if type(UnitGUID) == "function" then
        guid = UnitGUID("target") or guid
    end

    local now = GetTime()
    if not force and guid == lastAutoScanGuid and (now - lastAutoScanAt) < 1.0 then return end

    lastAutoScanGuid = guid
    lastAutoScanAt = now
    ScanTarget()
end

function AutoScanTarget(force, delay)
    if not frame or not frame:IsShown() then return end
    GetActiveName()
    RefreshSlots()
    RefreshBags()

    autoScanQueued = true
    autoScanForce = autoScanForce or force
    autoScanDelay = delay or 0.15
end

local function SetBagPanelVisible(show)
    NBEM_DB.bagVisible = show and true or false
    if bagFrame then
        if NBEM_DB.bagVisible then
            bagFrame:Show()
            RefreshBags()
        else
            bagFrame:Hide()
        end
    end
    if frame and frame.bagToggle then
        frame.bagToggle:SetText(NBEM_DB.bagVisible and "Hide Bags" or "Show Bags")
    end
end

function CreateUI()
    frame = CreateFrame("Frame", "NBEM_MainFrame", UIParent)
    frame:SetWidth(640)
    frame:SetHeight(575)
    frame:SetPoint("CENTER")
    frame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 } })
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    frame:Hide()

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOPLEFT", 18, -16)
    frame.title:SetText("NpcBot Equipment")

    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -8, -8)

    frame.scan = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.scan:SetWidth(74)
    frame.scan:SetHeight(24)
    frame.scan:SetPoint("TOPRIGHT", -48, -18)
    frame.scan:SetText("Scan")
    frame.scan:SetScript("OnClick", ScanTarget)

    local refresh = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    refresh:SetWidth(92)
    refresh:SetHeight(24)
    refresh:SetPoint("RIGHT", frame.scan, "LEFT", -6, 0)
    refresh:SetText("Refresh Bags")
    refresh:SetScript("OnClick", RefreshBags)

    frame.bagToggle = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.bagToggle:SetWidth(82)
    frame.bagToggle:SetHeight(24)
    frame.bagToggle:SetPoint("RIGHT", refresh, "LEFT", -6, 0)
    frame.bagToggle:SetText("Hide Bags")
    frame.bagToggle:SetScript("OnClick", function() SetBagPanelVisible(not NBEM_DB.bagVisible) end)

    frame.modelBox = CreateFrame("Frame", nil, frame)
    frame.modelBox:SetWidth(356)
    frame.modelBox:SetHeight(292)
    frame.modelBox:SetPoint("TOPLEFT", 142, -58)
    frame.modelBox:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
    frame.modelBox:SetBackdropColor(0.02, 0.02, 0.02, 0.88)

    frame.model = CreateFrame("PlayerModel", nil, frame.modelBox)
    frame.model:SetPoint("TOPLEFT", 6, -8)
    frame.model:SetPoint("BOTTOMRIGHT", -6, 2)
    FrameBotModel(frame.model)

    for i = 1, table.getn(STAT_ORDER) do
        local stat = STAT_ORDER[i]
        local box = CreateFrame("Frame", nil, frame)
        box:SetWidth(118)
        box:SetHeight(24)
        local col = (i - 1) % 3
        local row = math.floor((i - 1) / 3)
        box:SetPoint("TOPLEFT", 142 + (col * 119), -354 - (row * 26))
        box:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 10, insets = { left = 2, right = 2, top = 2, bottom = 2 } })
        box:SetBackdropColor(0.04, 0.04, 0.04, 0.86)
        box.label = box:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        box.label:SetPoint("LEFT", 6, 0)
        box.label:SetWidth(42)
        box.label:SetJustifyH("LEFT")
        if box.label.SetNonSpaceWrap then box.label:SetNonSpaceWrap(false) end
        box.label:SetText(stat.label)
        box.value = box:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        box.value:SetPoint("LEFT", box.label, "RIGHT", 2, 0)
        box.value:SetPoint("RIGHT", -5, 0)
        box.value:SetJustifyH("RIGHT")
        if box.value.SetNonSpaceWrap then box.value:SetNonSpaceWrap(false) end
        box.value:SetText("-")
        statButtons[stat.key] = box
    end

    for i, slot in ipairs(SLOT_ORDER) do
        local layout = SLOT_LAYOUT[slot] or { side = "LEFT", row = i }
        local b = CreateFrame("Button", nil, frame)
        b:SetWidth(112)
        b:SetHeight(40)
        local x = layout.side == "RIGHT" and 510 or 18
        local y = -58 - ((layout.row - 1) * 42)
        b:SetPoint("TOPLEFT", x, y)
        b.slotKey = slot
        b:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
        b:SetBackdropColor(0.05, 0.05, 0.05, 0.85)
        b.icon = b:CreateTexture(nil, "ARTWORK")
        b.icon:SetWidth(30)
        b.icon:SetHeight(30)
        b.icon:SetPoint("LEFT", 7, 0)
        b.label = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        b.label:SetPoint("LEFT", b.icon, "RIGHT", 6, 0)
        b.label:SetText(SlotLabel(slot))
        b.item = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        b.item:SetPoint("TOPLEFT", b.label, "BOTTOMLEFT", 0, -2)
        b.item:SetWidth(62)
        b.item:SetHeight(1)
        b.item:SetJustifyH("LEFT")
        b.item:SetJustifyV("TOP")
        b.item:Hide()
        b:SetScript("OnClick", function(self, button)
            local cursorType = GetCursorInfo()
            if button == "LeftButton" and cursorType == "item" then
                EquipCursorItem(self.slotKey)
            elseif button == "RightButton" then
                UnequipSlot(self.slotKey)
            end
        end)
        b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        b:RegisterForDrag("LeftButton")
        b:SetScript("OnMouseUp", function(self, button)
            local cursorType = GetCursorInfo()
            if button == "LeftButton" and cursorType == "item" then
                EquipCursorItem(self.slotKey)
            end
        end)
        b:SetScript("OnReceiveDrag", function(self)
            EquipCursorItem(self.slotKey)
        end)
        b:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if self.itemLink then GameTooltip:SetHyperlink(self.itemLink) else GameTooltip:SetText(SlotLabel(self.slotKey)) end
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function()
            GameTooltip:Hide()
            HideCompareTooltips()
        end)
        slotButtons[slot] = b
    end

    bagFrame = CreateFrame("Frame", nil, frame)
    bagFrame:SetWidth(240)
    bagFrame:SetHeight(405)
    bagFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 8, -16)
    bagFrame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
    bagFrame.title = bagFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bagFrame.title:SetPoint("BOTTOMLEFT", bagFrame, "TOPLEFT", 4, 2)
    bagFrame.title:SetText("Equippable bag items")

    bagFrame.prev = CreateFrame("Button", nil, bagFrame, "UIPanelButtonTemplate")
    bagFrame.prev:SetWidth(54)
    bagFrame.prev:SetHeight(22)
    bagFrame.prev:SetPoint("BOTTOMLEFT", 8, 8)
    bagFrame.prev:SetText("Prev")
    bagFrame.prev:SetScript("OnClick", function()
        if bagPage > 1 then
            bagPage = bagPage - 1
            RefreshBags()
        end
    end)

    bagFrame.next = CreateFrame("Button", nil, bagFrame, "UIPanelButtonTemplate")
    bagFrame.next:SetWidth(54)
    bagFrame.next:SetHeight(22)
    bagFrame.next:SetPoint("BOTTOMRIGHT", -8, 8)
    bagFrame.next:SetText("Next")
    bagFrame.next:SetScript("OnClick", function()
        bagPage = bagPage + 1
        RefreshBags()
    end)

    bagFrame.pageText = bagFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    bagFrame.pageText:SetPoint("BOTTOM", 0, 13)
    bagFrame.pageText:SetText("Page 1/1")

    if NBEM_DB.bagVisible == nil then NBEM_DB.bagVisible = true end
    SetBagPanelVisible(NBEM_DB.bagVisible)
end
local function ToggleUI()
    if not frame then CreateUI() end
    if frame:IsShown() then
        frame:Hide()
    else
        GetActiveName()
        RefreshSlots()
        RefreshBags()
        frame:Show()
        AutoScanTarget(true)
    end
end

local function NbemAtan2(y, x)
    if x > 0 then return math.atan(y / x) end
    if x < 0 and y >= 0 then return math.atan(y / x) + math.pi end
    if x < 0 and y < 0 then return math.atan(y / x) - math.pi end
    if x == 0 and y > 0 then return math.pi / 2 end
    if x == 0 and y < 0 then return -math.pi / 2 end
    return 0
end

local function UpdateMinimapButtonPosition(angle)
    if not minimapButton then return end
    angle = angle or NBEM_DB.minimapAngle or DEFAULTS.minimapAngle
    local radians = math.rad(angle)
    local radius = 82
    minimapButton:ClearAllPoints()
    minimapButton:SetPoint("CENTER", Minimap, "CENTER", math.cos(radians) * radius, math.sin(radians) * radius)
end

local function UpdateMinimapButtonDrag()
    local mx, my = Minimap:GetCenter()
    local scale = UIParent:GetEffectiveScale()
    local x, y = GetCursorPosition()
    x = x / scale
    y = y / scale
    NBEM_DB.minimapAngle = math.deg(NbemAtan2(y - my, x - mx))
    UpdateMinimapButtonPosition(NBEM_DB.minimapAngle)
end

function CreateMinimapButton()
    if minimapButton then return end

    minimapButton = CreateFrame("Button", "NBEM_MinimapButton", Minimap)
    minimapButton:SetWidth(32)
    minimapButton:SetHeight(32)
    minimapButton:SetFrameStrata("MEDIUM")
    minimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    minimapButton:RegisterForClicks("LeftButtonUp")
    minimapButton:RegisterForDrag("LeftButton")

    minimapButton.icon = minimapButton:CreateTexture(nil, "BACKGROUND")
    minimapButton.icon:SetWidth(20)
    minimapButton.icon:SetHeight(20)
    minimapButton.icon:SetPoint("CENTER", 0, 0)
    minimapButton.icon:SetTexture("Interface\\Icons\\INV_Misc_Gear_01")

    minimapButton.border = minimapButton:CreateTexture(nil, "OVERLAY")
    minimapButton.border:SetWidth(54)
    minimapButton.border:SetHeight(54)
    minimapButton.border:SetPoint("TOPLEFT", 0, 0)
    minimapButton.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    minimapButton:SetScript("OnClick", function(self)
        if self.wasDragged then
            self.wasDragged = false
            return
        end
        ToggleUI()
    end)
    minimapButton:SetScript("OnDragStart", function(self)
        self.dragging = true
        self.wasDragged = true
        self:SetScript("OnUpdate", UpdateMinimapButtonDrag)
    end)
    minimapButton:SetScript("OnDragStop", function(self)
        self.dragging = false
        self:SetScript("OnUpdate", nil)
        UpdateMinimapButtonPosition(NBEM_DB.minimapAngle)
    end)
    minimapButton:SetScript("OnMouseUp", function(self)
        if self.dragging then
            self.dragging = false
            self:SetScript("OnUpdate", nil)
            UpdateMinimapButtonPosition(NBEM_DB.minimapAngle)
        end
    end)
    minimapButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("NpcBot Equipment Manager")
        GameTooltip:AddLine("Click to open or close", 1, 1, 1)
        GameTooltip:AddLine("Drag to move", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    minimapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

    UpdateMinimapButtonPosition(NBEM_DB.minimapAngle)
end
local function Trim(value)
    value = value or ""
    return string.gsub(value, "^%s*(.-)%s*$", "%1")
end

local function SlashHandler(msg)
    msg = Trim(msg)
    local lower = string.lower(msg)
    if lower == "" then ToggleUI(); return end
    if lower == "scan" or lower == "inspect" or lower == "gear" then ScanTarget(); return end
    if lower == "clear" then GetProfile().slots = {}
    GetProfile().stats = {}; RefreshSlots(); Print("cleared current profile"); return end
    if lower == "resetcmd" then NBEM_DB.scanCommand = ""; NBEM_DB.equipCommand = ""; NBEM_DB.unequipCommand = ""; Print("cleared scan/equip/unequip command templates"); return end
    if string.sub(lower, 1, 7) == "scancmd" then
        NBEM_DB.scanCommand = string.match(msg, "^%S+%s+(.+)$") or NBEM_DB.scanCommand
        Print("scan command: " .. NBEM_DB.scanCommand)
        return
    end
    if string.sub(lower, 1, 8) == "equipcmd" then
        NBEM_DB.equipCommand = string.match(msg, "^%S+%s+(.+)$") or NBEM_DB.equipCommand
        Print("equip command: " .. NBEM_DB.equipCommand)
        return
    end
    if string.sub(lower, 1, 10) == "unequipcmd" then
        NBEM_DB.unequipCommand = string.match(msg, "^%S+%s+(.+)$") or NBEM_DB.unequipCommand
        Print("unequip command: " .. NBEM_DB.unequipCommand)
        return
    end
    Print("/nbem, /nbem scan, /nbem resetcmd, /nbem clear")
end

local function HideNbemProtocol(self, event, msg)
    if type(msg) ~= "string" then return false end
    if string.find(msg, "^NBEM_SCAN_BEGIN") or string.find(msg, "^NBEM_STAT") or string.find(msg, "^NBEM_SLOT") or string.find(msg, "^NBEM_SCAN_END") then
        return true
    end
    if string.find(msg, "^%.nbem%s") or msg == ".nbem" then
        return true
    end
    return false
end
local events = CreateFrame("Frame")
events:Show()
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_TARGET_CHANGED")
events:RegisterEvent("CHAT_MSG_SYSTEM")
events:RegisterEvent("CHAT_MSG_SAY")
events:RegisterEvent("CHAT_MSG_WHISPER")
events:RegisterEvent("CHAT_MSG_MONSTER_SAY")
events:RegisterEvent("CHAT_MSG_MONSTER_WHISPER")
events:RegisterEvent("BAG_UPDATE")
events:RegisterEvent("GOSSIP_SHOW")
events:RegisterEvent("GET_ITEM_INFO_RECEIVED")
events:SetScript("OnUpdate", function(self, elapsed)
    if not autoScanQueued then return end
    autoScanDelay = autoScanDelay - elapsed
    if autoScanDelay > 0 then return end

    local force = autoScanForce
    autoScanQueued = false
    autoScanForce = false
    RunAutoScan(force)
end)

events:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON then
        CopyDefaults()
        HookBagPickupTracking()
        if type(ChatFrame_AddMessageEventFilter) == "function" then
            ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", HideNbemProtocol)
            ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", HideNbemProtocol)
        end
        SLASH_NBEM1 = "/nbem"
        SLASH_NBEM2 = "/npcboteq"
        SlashCmdList.NBEM = SlashHandler
        CreateMinimapButton()
        Print("By Torrozin loaded. Use /nbem")
        return
    end
    if event == "PLAYER_TARGET_CHANGED" then
        GetActiveName()
        AutoScanTarget(false)
        return
    end
    if event == "BAG_UPDATE" then
        RefreshBags()
        return
    end
    if event == "GET_ITEM_INFO_RECEIVED" then
        RetryPendingLinks()
        RefreshSlots()
        RefreshBags()
        return
    end
    if event == "GOSSIP_SHOW" then
        GetActiveName()
        ScrapeGossipFrame()
        RefreshSlots()
        return
    end
    ScrapeLine(arg1)
    RetryPendingLinks()
end)












