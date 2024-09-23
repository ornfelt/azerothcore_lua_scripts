-- Outdated, unusable as of 29/06/2020
function mb_Mage_Fire_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Mage_ReadyCheck)
    mb_EnableIWTDistanceClosing("Fireball")
end

function mb_Mage_Fire_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if not UnitBuff("player", "Molten Armor") then
        mb_CastSpellWithoutTarget("Molten Armor")
        return
    end

    if mb_Mage_HandleManaGem("Mana Sapphire") then
        return
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_ShouldUseDpsCooldowns("Fireball") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        mb_UseItem("Mana Sapphire")
        mb_CastSpellWithoutTarget("Combustion")
        if mb_CastSpellWithoutTarget("Mirror Image") then
            return
        end
    end

    if mb_UnitPowerPercentage("player") < 35 and mb_CanCastSpell("Evocation") then
        if mb_CastSpellWithoutTarget("Evocation") then
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Living Bomb") == 0 then
        if mb_CastSpellOnTarget("Living Bomb") then
            return
        end
    end

    if UnitBuff("player", "Hot Streak") then
        if mb_CastSpellOnTarget("Pyroblast") then
            return
        end
    end

    if mb_IsMoving() and mb_CastSpellOnTarget("Fire Blast") then
        return
    end

    if mb_CastSpellOnTarget("Fireball") then
        return
    end
end