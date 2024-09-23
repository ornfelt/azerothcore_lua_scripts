mb_Hunter_spendPhase = false
mb_Hunter_regenPhase = false
mb_Hunter_shouldReposition = false

function mb_Hunter_OnLoad()
    if mb_GetMySpecName() == "Beast Mastery" then
        mb_classSpecificRunFunction = mb_Hunter_BeastMastery_OnUpdate
        mb_Hunter_BeastMastery_OnLoad()
    elseif mb_GetMySpecName() == "Marksmanship" then
        mb_classSpecificRunFunction = mb_Hunter_Marksmanship_OnUpdate
        mb_Hunter_Marksmanship_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Hunter_Survival_OnUpdate
        mb_Hunter_Survival_OnLoad()
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_MIGHT)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
end

function mb_Hunter_ReadyCheck()
    local ready = true

    return ready
end

function mb_Hunter_HandleAspect()
    if not UnitAffectingCombat("player") then
        mb_Hunter_regenPhase = true
        mb_Hunter_spendPhase = false
    end

    if UnitAffectingCombat("player") and mb_UnitPowerPercentage("player") > 70 then
        mb_Hunter_spendPhase = true
        mb_Hunter_regenPhase = false
    elseif UnitAffectingCombat("player") and mb_UnitPowerPercentage("player") < 5 then
        mb_Hunter_spendPhase = false
        mb_Hunter_regenPhase = true
    end

    mb_Hunter_SetAspect(mb_Hunter_regenPhase, mb_Hunter_spendPhase)
end

function mb_Hunter_SetAspect(regen, spend)
    if regen and not UnitBuff("player", "Aspect of the Viper") then
        mb_CastSpellWithoutTarget("Aspect of the Viper")
    end

    if spend and not UnitBuff("player", "Aspect of the Dragonhawk") and not UnitBuff("player", "Aspect of the Hawk") then
        if mb_CastSpellWithoutTarget("Aspect of the Dragonhawk") then

        else
            mb_CastSpellWithoutTarget("Aspect of the Hawk")
        end
    end

end

function mb_Hunter_HandlePet()
    if not PetHasActionBar() then
        local _,_, displayName = UnitCastingInfo("player")
        if displayName == "Revive Pet" then
            return false
        end
        if mb_CastSpellWithoutTarget("Call Pet") then
            return true
        elseif mb_CastSpellWithoutTarget("Revive Pet") then
            return true
        end
    end

    return false
end

-- Specify up to 5 spells that you wish your pet to have auto-cast
function mb_Hunter_HandlePetAutoCasts(spell1, spell2, spell3, spell4, spell5)
    if spell1 then
        EnableSpellAutocast(spell1)
    end
    if spell2 then
        EnableSpellAutocast(spell2)
    end
    if spell3 then
        EnableSpellAutocast(spell3)
    end
    if spell4 then
        EnableSpellAutocast(spell4)
    end
    if spell5 then
        EnableSpellAutocast(spell5)
    end
end

-- Work in progress
function mb_Hunter_AspectTwist(spell)
    if mb_Hunter_spendPhase then
        if mb_CastSpellOnTarget(spell) then
            mb_Print("Not Twisted!")
            return true
        end

    elseif mb_Hunter_regenPhase then
        mb_CastSpellWithoutTarget("Aspect of the Dragonhawk")
        if mb_CastSpellOnTarget(spell) then
            mb_Print("Twisted!")
            return true
        end
    end

    return false
end

function mb_GetCurrentTank(unit)
    if not UnitCanAttack("player", unit) then
        return false
    end

    local currTank = UnitName(unit.."target")
    if not currTank then
        return false
    end

    mb_Hunter_CurrentlyTanking = currTank

    --mb_Print(UnitName("player").." "..mb_Hunter_CurrentlyTanking)
end

function mb_Hunter_IsPetTanking()
    if not UnitAffectingCombat("player") then
        return false
    end
    local isTanking = mb_IsTanking("pet")
    if isTanking then
        mb_Hunter_CurrentlyTanking = UnitName("pet")
        --mb_Print(UnitName("player")..mb_Hunter_CurrentlyTankingPet)
        return true
    end

    return false
end

function mb_Hunter_HandleMelee()
    if not UnitAffectingCombat("player") then
        return false
    end

    mb_CastSpellOnTarget("Raptor Strike") -- Does not trigger GCD
    if mb_CastSpellOnTarget("Mongoose Bite") then
        return true
    end
end

function mb_Hunter_HandleReposition()
    if not UnitAffectingCombat("player") then
        return false
    end

    if mb_IsSpellInRange("Mongoose Bite", "target") and mb_followMode == "lenient" then
        mb_Hunter_shouldReposition = true
    end

    if not mb_IsSpellInRange("Mongoose Bite", "target") then
        mb_Hunter_shouldReposition = false
        MoveBackwardStop()
    end

    if mb_Hunter_shouldReposition then
        MoveBackwardStart()
        return true
    end
end