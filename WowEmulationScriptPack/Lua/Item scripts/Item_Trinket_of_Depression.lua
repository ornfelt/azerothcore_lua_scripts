local trinketEntry1 = 111
local trinketEntry2 = 112
local Aura1 = 111
local Aura2 = 113
local Aura3 = 112


local itemSlot1 = 2
local itemSlot2 = 3
local function deperession(event, player, spell, skipCheck)
print(player:GetVictim())
    if(player:GetEquippedItemBySlot(itemSlot1):GetEntry() == trinketEntry1 or player:GetEquippedItemBySlot(itemSlot2):GetEntry() == trinketEntry1) then
        local chance = math.random(100)
        if(chance > 95) then
            player:AddAura(Aura1,player)
        elseif(chance > 90) then
            player:AddAura(Aura2,player)
        elseif(chance > 85) then
            player:AddAura(Aura3,player)
        elseif(chance == 1) then
            player:Kill(player)
            player:SendBroadcastMessage("Depression has taken another soul.")
        end
    end
    if(player:GetEquippedItemBySlot(itemSlot1):GetEntry() == trinketEntry2 or player:GetEquippedItemBySlot(itemSlot2):GetEntry() == trinketEntry2) then
        local chance = math.random(100)
        if(chance > 95) then
            player:AddAura(Aura1,player)
        elseif(chance > 90) then
            player:AddAura(Aura2,player)
        elseif(chance > 85) then
            player:AddAura(Aura3,player)
        elseif(chance == 1) then
            player:Kill(player)
            player:SendBroadcastMessage("Depression has taken another soul.")
        end
    end
end


RegisterPlayerEvent(5,depression)