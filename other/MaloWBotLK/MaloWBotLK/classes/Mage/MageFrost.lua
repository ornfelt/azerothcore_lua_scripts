mb_Mage_Frost_FoFIceLance = false

function mb_Mage_Frost_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Mage_ReadyCheck)
    mb_EnableIWTDistanceClosing("Frostbolt")
end

function mb_Mage_Frost_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if not UnitBuff("player", "Molten Armor") then
        if mb_CastSpellWithoutTarget("Molten Armor") then
            return
        end
    end

    if mb_Mage_HandleManaGem("Mana Sapphire") then
        return
    end

    if mb_Mage_HandleFocusMagic() then
        return
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    mb_HandleAutomaticSalvationRequesting()

    if mb_UnitPowerPercentage("player") < 35 and mb_CanCastSpell("Evocation") then
        if mb_CastSpellWithoutTarget("Evocation") then
            return
        end
    end

    if mb_UnitPowerPercentage("player") < 65 and UnitAffectingCombat("player") then
        mb_UseItem("Mana Sapphire")
    end

    if mb_cleaveMode > 1 then
        local range = CheckInteractDistance("target", 2)
        if range then
            if mb_CastSpellWithoutTarget("Cone of Cold") then
                return
            elseif mb_CastSpellWithoutTarget("Arcane Explosion") then
                return
            end
        end
    end

    if mb_ShouldUseDpsCooldowns("Frostbolt") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Mirror Image") then
            return
        end

        if mb_CastSpellWithoutTarget("Summon Water Elemental") then
            return
        end
        mb_CastSpellWithoutTarget("Icy Veins")
    end

    if UnitBuff("player", "Fireball!") and mb_CastSpellOnTarget("Frostfire Bolt") then
        return
    end

    if mb_IsMoving() and UnitBuff("player", "Fingers of Frost") then
        if mb_CastSpellOnTarget("Ice Lance") then
            return
        end
    end

    if mb_CastSpellOnTarget("Frostbolt") then
        return
    end
end


-- Work in Progress to properly optimise Fingers of Frost usage.
function mb_Mage_Frost_handleFingersOfFrost()
    local _,_,_,count = UnitBuff("player", "Fingers of Frost")

    if count == 2 then
        if not mb_Mage_Frost_FoFIceLance then
            if mb_CastSpellOnTarget("Frostbolt") then
                mb_Mage_Frost_FoFIceLance = true
                return true
            end
        end
    end

    if count == 2 and mb_Mage_Frost_FoFIceLance then
        mb_Mage_Frost_handleIceLance()
    end

    return false
end

-- Work in Progress to properly optimise Fingers of Frost usage.
function mb_Mage_Frost_handleIceLance()
    if mb_Mage_Frost_FoFIceLance == true and mb_CastSpellOnTarget("Ice Lance") then
        mb_Mage_Frost_FoFIceLance = false
        return true
    end

    return false
end