local DeathKnightTrinket = {}

DeathKnightTrinket.EQUIPPED_ITEM = 80344
DeathKnightTrinket.SPELLS_TO_LISTEN_FOR = {49924, 49998, 49999, 45463, 49923, 47541, 49892, 49893, 49894, 49895}
DeathKnightTrinket.SPELL_TO_CAST = 80038
DeathKnightTrinket.CHANCE_TO_CAST = 10

DeathKnightTrinket.EQUIPMENT_SLOT_TRINKET1 = 12
DeathKnightTrinket.EQUIPMENT_SLOT_TRINKET2 = 13
DeathKnightTrinket.DEATH_KNIGHT_CLASS = 6

function DeathKnightTrinket.IsItemEquipped(player, itemID)
    local trinket1 = player:GetEquippedItemBySlot(DeathKnightTrinket.EQUIPMENT_SLOT_TRINKET1)
    local trinket2 = player:GetEquippedItemBySlot(DeathKnightTrinket.EQUIPMENT_SLOT_TRINKET2)
    
    if trinket1 and trinket1:GetEntry() == itemID and trinket1:IsEquipped() then
        return true
    end
    
    if trinket2 and trinket2:GetEntry() == itemID and trinket2:IsEquipped() then
        return true
    end
    
    return false
end

function DeathKnightTrinket.OnCast(event, player, spell, skipCheck)
    if (player:GetClass() == DeathKnightTrinket.DEATH_KNIGHT_CLASS) then
        if (DeathKnightTrinket.IsItemEquipped(player, DeathKnightTrinket.EQUIPPED_ITEM)) then
            local spellEntry = spell:GetEntry()
            for _, spellID in ipairs(DeathKnightTrinket.SPELLS_TO_LISTEN_FOR) do
                if (spellEntry == spellID) then
                    if (math.random(1, 100) <= DeathKnightTrinket.CHANCE_TO_CAST and not player:HasAura(DeathKnightTrinket.SPELL_TO_CAST)) then
                        player:CastSpell(player, DeathKnightTrinket.SPELL_TO_CAST, true)
                    end
                    break
                end
            end
        end
    end
end

RegisterPlayerEvent(5, DeathKnightTrinket.OnCast)
