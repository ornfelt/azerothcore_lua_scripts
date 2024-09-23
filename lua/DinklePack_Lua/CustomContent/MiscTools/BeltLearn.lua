local function BELTY_OnEquip(event, player, item, bag, slot)
    local beltSlot = player:GetEquippedItemBySlot(5)

    if (beltSlot and beltSlot:GetEntry() == item:GetEntry()) then
        for i=500000, 502613 do
            if player:HasAura(i) then
                player:LearnSpell(i)                
            end
        end
    end
end

RegisterPlayerEvent(29, BELTY_OnEquip)

