local CONSTANT = {
    EVENT = {
        PLAYER = {
            [27] = "OnZoneEvent", -- OnZoneChange
            [28] = "OnMapEvent",  -- OnMapEvent
            [29] = "OnItemEvent", -- OnLootItem
            [32] = "OnItemEvent", -- OnEquipItem
            [47] = "OnAreaEvent", -- OnAreaItem
            [51] = "OnItemEvent", -- OnQuestRewardItem
            [52] = "OnItemEvent", -- OnCreateItem
            [53] = "OnItemEvent", -- OnStoreItem
            [56] = "OnItemEvent", -- OnRollRewardItem
            [58] = "OnAuraApply", -- OnAuraApply
        },
        NAME = "Spell_Bonus_Action_Verification_Event",
        DELAY = 5000,
    },
    DATA = "Spell_Bonus_Action_Data",
    CLIENT = {
        SHOW_FRAME = "ShowFrame",
        HIDE_FRAME = "HideFrame",
        ADDON_NAME = "Spell_Bonus_Action",
    }
}

local AIO = AIO or require("Library.Vendor.Rochet2.AIO")

local Client = AIO.AddHandlers(CONSTANT.CLIENT.ADDON_NAME, {})
local Entity = require("Spell_Bonus_Action.Entities.Spell_Bonus_Action_Entity")

local SOURCE_TYPE = {
    ["aura"] = function(player, value)
        return player:HasAura(value)
    end,

    ["item"] = function(player, value)
        return player:HasItem(value)
    end,

    ["item_equipped"] = function(player, value)
        local item = player:GetItemByEntry( value )
        return item and item:IsEquipped() or false
    end,

    ["map_id"] = function(player, value)
        return player:GetMap():GetMapId() == value
    end,

    ["zone_id"] = function(player, value)
        return player:GetZoneId() == value
    end,

    ["area_id"] = function(player, value)
        return player:GetAreaId() == value
    end,

    ["min_level"] = function(player, value)
        return player:GetLevel() >= value
    end,

    ["class"] = function(player, value)
        return player:GetClass() == value
    end,

    ["race"] = function(player, value)
        return player:GetRace() == value
    end,

    ["phase_mask"] = function(player, value)
        return player:GetPhaseMask() == value
    end,

    ["quest_rewarded"] = function(player, value)
        local questStatus = player:GetQuestStatus( value )
        return questStatus and questStatus == 6 or false
    end,

    ["quest_incomplete"] = function(player, value)
        local questStatus = player:GetQuestStatus( value )
        return questStatus and questStatus == 3 or false
    end,

    ["min_hp_pct"] = function(player, value)
        return player:GetHealthPct() >= value
    end,

    ["max_hp_pct"] = function(player, value)
        return player:GetHealthPct() <= value
    end,
}

local Spell_Bonus_Action = { }
function Spell_Bonus_Action.CheckConditions(player, conditions)
    for _, condition in ipairs(conditions) do
        local func = SOURCE_TYPE[condition.source_type]
        if func and not func(player, condition.source_id) then
            return false
        end
    end
    return true
end

function Spell_Bonus_Action.HandleEvent(player, data)
    local verification_event = player:GetData(CONSTANT.EVENT.NAME)
    local player_data = player:GetData(CONSTANT.DATA)

    if Spell_Bonus_Action.CheckConditions(player, data.conditions) then
        if (not verification_event) then
            local event_id = player:RegisterEvent(Spell_Bonus_Action.Verification_Event, CONSTANT.EVENT.DELAY, 0)
            player:SetData(CONSTANT.EVENT.NAME, event_id)
        end
        if (not player_data.frame_show) then
            AIO.Handle(player, CONSTANT.CLIENT.ADDON_NAME, CONSTANT.CLIENT.HIDE_FRAME)
            AIO.Handle(player, CONSTANT.CLIENT.ADDON_NAME, CONSTANT.CLIENT.SHOW_FRAME, data.texture, player_data.spell_id)
            player:SetData(CONSTANT.DATA, {
                spell_id = player_data.spell_id,
                frame_show = true,
            })
        end
    else
        if (verification_event) then
            AIO.Handle(player, CONSTANT.CLIENT.ADDON_NAME, CONSTANT.CLIENT.HIDE_FRAME)
            player:RemoveEventById(verification_event)
            player:SetData(CONSTANT.EVENT.NAME, nil)
            player:SetData(CONSTANT.DATA, {
                spell_id = player_data.spell_id,
                frame_show = false,
            })
        end
    end
end

function Spell_Bonus_Action.Verification_Event(event_id, delay, repeats, player)
    local player_data = player:GetData(CONSTANT.DATA)
    local data = Entity.spells[player_data.spell_id]

    Spell_Bonus_Action.HandleEvent(player, data)
end

function Spell_Bonus_Action.OnItemEvent(event, player, item, count)
    local item_id = item:GetItemTemplate():GetItemId()
    local spell_id = Entity.items[item_id]

    if spell_id then
        local data = Entity.spells[spell_id]

        player:SetData(CONSTANT.DATA, {
            spell_id = spell_id,
            frame_show = false,
        })
        Spell_Bonus_Action.HandleEvent(player, data)
    end
end

function Spell_Bonus_Action.OnMapEvent(event, player)
    local map_id = player:GetMap():GetMapId()
    local spell_id = Entity.maps[map_id]

    if spell_id then
        local data = Entity.spells[spell_id]
        player:SetData(CONSTANT.DATA, {
            spell_id = spell_id,
            frame_show = false,
        })
        Spell_Bonus_Action.HandleEvent(player, data)
    end
end

function Spell_Bonus_Action.OnZoneEvent(event, player, newZone, newArea)
    local spell_id = Entity.zones[newZone]

    if spell_id then
        local data = Entity.spells[spell_id]
        player:SetData(CONSTANT.DATA, {
            spell_id = spell_id,
            frame_show = false,
        })

        Spell_Bonus_Action.HandleEvent(player, data)
    end
end

function Spell_Bonus_Action.OnAuraApply(event, player, aura)
    local spell_id = Entity.auras[aura:GetAuraId()]
    if (spell_id) then
        local data = Entity.spells[spell_id]
        player:SetData(CONSTANT.DATA, {
            spell_id = spell_id,
            frame_show = false,
        })
        Spell_Bonus_Action.HandleEvent(player, data)
    end
end

function Spell_Bonus_Action.OnAreaEvent(event, player, oldArea, newArea)
    local spell_id = Entity.areas[newArea]

    if spell_id then
        local data = Entity.spells[spell_id]
        player:SetData(CONSTANT.DATA, {
            spell_id = spell_id,
            frame_show = false,
        })

        Spell_Bonus_Action.HandleEvent(player, data)
    end
end

for event_id, event_name in pairs(CONSTANT.EVENT.PLAYER) do
    RegisterPlayerEvent(event_id, Spell_Bonus_Action[event_name])
end

function Client.Cast(player, spellId)
    local player_data = player:GetData(CONSTANT.DATA)
    if (not player_data) then
        return
    end

    local spell = player_data.spell_id
    if (not spellId ~= spell) then
        player:CastSpell(player, spellId, false)
    end
end