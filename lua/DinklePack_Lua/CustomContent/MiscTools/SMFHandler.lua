local TitanGrip = {}

TitanGrip.SPELL_ID = 100265 -- The SMF Spell
TitanGrip.REQUIRED_AURA_ID = 49152 -- The TG aura
TitanGrip.EQUIPMENT_SLOT_MAINHAND = 15
TitanGrip.EQUIPMENT_SLOT_OFFHAND = 16

function TitanGrip.PlayerUsingOneHandedSword(player)
    local mainHand = player:GetEquippedItemBySlot(TitanGrip.EQUIPMENT_SLOT_MAINHAND)
    local offHand = player:GetEquippedItemBySlot(TitanGrip.EQUIPMENT_SLOT_OFFHAND)

    if not mainHand or not offHand then
        return false
    end

    local mainHandType = mainHand:GetClass()
    local mainHandSubType = mainHand:GetSubClass()
    local offHandType = offHand:GetClass()
    local offHandSubType = offHand:GetSubClass()

    return (mainHandType == 2 and mainHandSubType == 7) and (offHandType == 2 and offHandSubType == 7)
end

function TitanGrip.OnItemEquip(event, player, item, bag, slot)
    if player:GetClass() ~= 1 then -- Exit the function if the player is not a warrior
        return
    end

    if player:HasAura(TitanGrip.REQUIRED_AURA_ID) then
        if TitanGrip.PlayerUsingOneHandedSword(player) then
            if not player:HasSpell(TitanGrip.SPELL_ID) then
                player:LearnSpell(TitanGrip.SPELL_ID)
            end
        else
            if player:HasSpell(TitanGrip.SPELL_ID) then
                player:RemoveSpell(TitanGrip.SPELL_ID)
            end
        end
    else
        -- Player does not have the required aura
    end
end

RegisterPlayerEvent(29, TitanGrip.OnItemEquip)
