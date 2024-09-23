-- TODO:
-- Use Every Man For Himself on loss of control
-- Interrupt with pummel
-- Recklessness on pre-pull
-- Detect bleed immunity to avoid getting stuck on spemming rend.

function mb_Warrior_Arms_OnLoad()
    mb_EnableIWTDistanceClosing("Mortal Strike")
    mb_CombatLogModule_Enable()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Warrior_Arms_ReadyCheck)

    if mb_config.enableConsumablesWatch then
        mb_CheckReagentAmount("Flask of Endless Rage", 3)
        mb_CheckReagentAmount("Potion of Speed", 15)
    end
end

function mb_Warrior_Arms_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if GetShapeshiftForm() ~= 1 then
        mb_CastSpellWithoutTarget("Battle Stance")
    end

    if UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") < 30 then
        if UnitPower("player") >= 15 and mb_CastSpellWithoutTarget("Enraged Regeneration") then
            return
        end
    end

    if mb_Warrior_CommandingShout() then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    mb_HandleAutomaticSalvationRequesting()

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if mb_commanderUnit == nil and mb_followMode ~= "strict" and mb_IsUnitWithinRange("target", 2) then
        if mb_CastSpellOnTarget("Charge") then
            return
        end
    end

    if not UnitAffectingCombat("player") then
        return
    end

    mb_CastSpellWithoutTarget("Bloodrage")

    if UnitPower("player") >= 75 then
        if mb_cleaveMode > 0 then
            mb_CastSpellOnTarget("Cleave")
        else
            mb_CastSpellOnTarget("Heroic Strike")
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Rend") == 0 then
        mb_CastSpellOnTarget("Rend")
        return
    end

    if mb_GetDebuffStackCount("target", "Sunder Armor") < 5 or mb_GetDebuffTimeRemaining("target", "Sunder Armor") < 5 then
        mb_CastSpellOnTarget("Sunder Armor")
        return
    end

    if UnitBuff("player", "Sudden Death") then
        mb_CastSpellOnTarget("Execute")
        return
    end

    if mb_IsSpellInRange("Mortal Strike", "target") then
        if not UnitDebuff("target", "Demoralizing Shout") and not UnitDebuff("target", "Demoralizing Roar") then
            mb_CastSpellWithoutTarget("Demoralizing Shout")
            return
        end
    end

    if mb_CastSpellOnTarget("Overpower") then
        return
    end

    if mb_ShouldUseDpsCooldowns("Mortal Strike") then
        mb_UseItemCooldowns()
        if UnitPower("player") >= 25 and mb_UnitHealthPercentage("target") < 20 then
            if mb_IsSpellInRange("Mortal Strike", "target") and mb_CastSpellOnTarget("Shattering Throw") then
                return
            end
        end
    end

    if mb_cleaveMode > 0 and mb_IsSpellInRange("Mortal Strike", "target") then
        if mb_GetRemainingSpellCooldown("Sweeping Strikes") == 0 then
            mb_CastSpellWithoutTarget("Sweeping Strikes")
            return
        end
        if mb_GetRemainingSpellCooldown("Bladestorm") == 0 then
            mb_CastSpellWithoutTarget("Bladestorm")
            return
        end
        if mb_cleaveMode > 1 and mb_GetRemainingSpellCooldown("Thunder Clap") == 0 then
            mb_CastSpellWithoutTarget("Thunder Clap")
            return
        end
    end

    if mb_UnitHealthPercentage("target") < 20 then
        mb_CastSpellOnTarget("Execute")
        return
    end

    local timeRemainingUntilNextSwing = (mb_CombatLogModule_GetLastSwingTime() + UnitAttackSpeed("player")) - mb_time
    if timeRemainingUntilNextSwing > 0.6 then
        mb_CastSpellOnTarget("Slam")
        return
    end

    if mb_CastSpellOnTarget("Mortal Strike") then
        return
    end

    if mb_CastSpellOnTarget("Victory Rush") then
        return
    end

    if mb_CastSpellWithoutTarget("Berserker Rage") then
        return
    end

    if mb_CastSpellOnTarget("Heroic Throw") then
        return
    end
end

function mb_Warrior_Arms_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Commanding Shout") < 60 then
        CancelUnitBuff("player", "Commanding Shout")
        ready = false
    end
    return ready
end