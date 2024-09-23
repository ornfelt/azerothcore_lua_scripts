-- TODO:
-- Lay on Hands on someone really low in the raid
-- Divine Protection pre-taking damage, probably through a "use personals" macro
-- Hammer of Justice targets, both as interrupt and as stun
-- Hand of Freedom when someone or self is slowed
-- Hand of Protection on a friendly who has aggro who shouldn't have aggro
-- Hand of Reckoning if the tank is almost undead, maybe as the prot in waiting, equipping a shield and using SotR and a personal CD
-- Use Every Man For Himself on loss of control

mb_Paladin_Retribution_saveProcsForHeals = false

function mb_Paladin_Retribution_OnLoad()
    mb_EnableIWTDistanceClosing("Crusader Strike")
    mb_RegisterDesiredBuff(BUFF_MIGHT)
    mb_RegisterClassSpecificReadyCheckFunction(mb_Paladin_Retribution_ReadyCheck)

    if mb_config.enableConsumablesWatch then
        mb_CheckReagentAmount("Flask of Endless Rage", 3)
        mb_CheckReagentAmount("Potion of Speed", 15)
    end
end

function mb_Paladin_Retribution_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if UnitBuff("player", "Righteous Fury") then
        CancelUnitBuff("player", "Righteous Fury")
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Redemption") then
        return
    end

    if UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") < 30 and mb_CastSpellWithoutTarget("Divine Shield") then
        return
    end

    if UnitBuff("player", "Divine Shield") and mb_UnitHealthPercentage("player") > 80 then
        CancelUnitBuff("player", "Divine Shield")
        return
    end

    if UnitBuff("player", "The Art of War") and not UnitBuff("player", "Divine Plea") then
        if mb_RaidHeal("Flash of Light", 0.3) then
            return
        end
    end

    if mb_Paladin_CastAura() then
        return
    end

    if mb_Paladin_Retribution_CastSeal() then
        return
    end

    if mb_CleanseRaid("Cleanse", "Magic", "Poison", "Disease") then
        return
    end

    if mb_UnitPowerPercentage("player") < 60 and mb_CastSpellWithoutTarget("Divine Plea") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        if not UnitBuff("player", "Divine Plea") and mb_UnitPowerPercentage("player") > 30 then
            if mb_RaidHeal("Flash of Light", 0.3) then
                return
            end
        end
        if not UnitBuff("player", "Sacred Shield") and mb_CastSpellOnUnit("Sacred Shield", "player") then
            return
        end
        return
    end

    mb_HandleAutomaticSalvationRequesting()

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if mb_ShouldUseDpsCooldowns("Crusader Strike") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Avenging Wrath") then
            return
        end
    end

    if mb_CastSpellOnTarget("Judgement of Wisdom") then
        return
    end

    if mb_CastSpellOnTarget("Crusader Strike") then
        return
    end

    if mb_UnitHealthPercentage("target") < 20 then
        if mb_CastSpellOnTarget("Hammer of Wrath") then
            return
        end
    end

    if mb_IsSpellInRange("Crusader Strike", "target") and mb_CastSpellWithoutTarget("Divine Storm") then
        return
    end

    if mb_IsSpellInRange("Crusader Strike", "target") and mb_UnitPowerPercentage("player") > 20 then
        if mb_CastSpellWithoutTarget("Consecration") then
            return
        end
    end

    if mb_cleaveMode > 0 and UnitCreatureType("target") == "Undead" and mb_IsSpellInRange("Crusader Strike", "target") then
        if mb_CastSpellWithoutTarget("Holy Wrath") then
            return
        end
    end

    if not mb_Paladin_Retribution_saveProcsForHeals and UnitBuff("player", "The Art of War") and mb_CastSpellOnTarget("Exorcism") then
        return
    end

    if not UnitBuff("player", "Sacred Shield") and mb_CastSpellOnUnit("Sacred Shield", "player") then
        return
    end

    if mb_UnitPowerPercentage("player") > 30 and not mb_IsSpellInRange("Crusader Strike", "target") then
        if not UnitBuff("player", "Divine Plea") and mb_RaidHeal("Flash of Light", 0.5) then
            return
        end
        if not mb_Paladin_Retribution_saveProcsForHeals and mb_CastSpellOnTarget("Exorcism") then
            return
        end
    end

    if UnitCreatureType("target") == "Undead" and mb_IsSpellInRange("Crusader Strike", "target") then
        if mb_CastSpellWithoutTarget("Holy Wrath") then
            return
        end
    end
end

function mb_Paladin_Retribution_CastSeal()
    local spell = "Seal of Vengeance"
    if mb_cleaveMode > 0 then
        spell = "Seal of Command"
    end
    if not UnitBuff("player", spell) then
        return mb_CastSpellWithoutTarget(spell)
    end
    return false
end

function mb_Paladin_Retribution_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Seal of Vengeance") < 540 and mb_GetBuffTimeRemaining("player", "Seal of Command") < 540 then
        CancelUnitBuff("player", "Seal of Vengeance")
        CancelUnitBuff("player", "Seal of Command")
        ready = false
    end
    return ready
end

