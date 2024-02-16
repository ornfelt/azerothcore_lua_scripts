local ItemCreation = {}

ItemCreation.AURA_ID = 80081 

function ItemCreation.OnPlayerCreateItem(event, player, item, count)
    if player:HasAura(ItemCreation.AURA_ID) then
        local itemEntry = item:GetEntry()
        player:AddItem(itemEntry, count)
    end
end

RegisterPlayerEvent(52, ItemCreation.OnPlayerCreateItem) 
