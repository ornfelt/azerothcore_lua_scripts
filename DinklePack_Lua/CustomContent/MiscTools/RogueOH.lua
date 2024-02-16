--[[
local RogueEquip = {}

RogueEquip.CLASS_ROGUE = 4
RogueEquip.ITEM_DAGGER = 20982

function RogueEquip.EquipDaggerOnRogue(event, player)
    if player:GetClass() == RogueEquip.CLASS_ROGUE then
        player:EquipItem(RogueEquip.ITEM_DAGGER, 16)
    end
end

RegisterPlayerEvent(1, RogueEquip.EquipDaggerOnRogue)
]]