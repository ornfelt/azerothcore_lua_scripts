-- TODO:
-- Every man for Himself on CC
-- Tricks of the Trade with requests
-- Eviscerate, delay 4 CP cast to 5 CP for alignment (see comment at the very bottom)
-- Pool energy and use it when trinkets and stuff procs

--mb_Rogue_noSnd = 0
--mb_Rogue_Snd = 0
function mb_Rogue_Combat_OnUpdate()
    --if mb_GetBuffTimeRemaining("player", "Slice and Dice") > 0 then
    --    mb_Rogue_Snd = mb_Rogue_Snd + 1
    --else
    --    mb_Rogue_noSnd = mb_Rogue_noSnd + 1
    --end

    if mb_IsSpellInRange("Sinister Strike", "target") and mb_IsValidOffensiveUnit("target", true) then
        if mb_Rogue_HandleTricksOfTheTrade() then
            return
        end
    end

    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Rogue_ApplyPoisons() then
        return
    end

    if UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") < 30 then
        if mb_CastSpellWithoutTarget("Evasion") then
            return
        end
        if mb_CastSpellWithoutTarget("Cloak of Shadows") then
            return
        end
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if not UnitAffectingCombat("player") then
        return
    end

    if mb_GetMyThreatPercentage("target") > 85 then
        if mb_CastSpellWithoutTarget("Vanish") then
            return
        end
    end

    mb_HandleAutomaticSalvationRequesting()

    local comboPoints = mb_GetComboPoints()
    local sndDuration = mb_GetBuffTimeRemaining("player", "Slice and Dice")
    local energy = UnitPower("player")
    if sndDuration < 2.5 then
        if comboPoints == 0 then
            mb_CastSpellOnTarget("Sinister Strike")
            return
        end
        if sndDuration < 0.1 or energy >= 99 then
            if mb_CastSpellWithoutTarget("Slice and Dice") then
                -- mb_SayRaid("Casting " .. tostring(mb_GetComboPoints()) .. "p Slice and Dice")
            end
            return
        end
        -- Delay SnD and cast another SS if we have enough energy to cast SS this global and SnD next
        if comboPoints < 4 and energy + sndDuration * 10 >= 65 then
            mb_CastSpellOnTarget("Sinister Strike")
            return
        end
        -- We wanna make sure we reserve enough energy to re-cast SnD when needed
        if energy + sndDuration * 10 < 65 then
            return
        end
        -- If there's less than 1 sec left on SnD we don't wanna global ourselves, wait until it's cast
        if sndDuration < 1.0 then
            return
        end
    end

    if mb_ShouldUseDpsCooldowns("Sinister Strike") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Blade Flurry") then
            return
        end
        if energy < 60 and not mb_disabledAutomaticMovement and mb_GetBuffTimeRemaining("player", "Adrenaline Rush") == 0 then
            -- Make sure SnD won't run out while we Killing Spree
            if sndDuration > 3.5 or (comboPoints > 0 and sndDuration > 2.5) then
                if mb_CastSpellWithoutTarget("Killing Spree") then
                    return
                end
            end
        end
        if mb_GetRemainingSpellCooldown("Killing Spree") > 1.0 and mb_CastSpellWithoutTarget("Adrenaline Rush") then
            return
        end
    end

    if mb_cleaveMode > 1 then
        mb_CastSpellWithoutTarget("Fan of Knives")
        return
    end

    -- Eviscerate early at 3 CP if it aligns the next SnD or Rupture better
    local ruptureDuration = mb_GetMyDebuffTimeRemaining("target", "Rupture")
    local predictedEnergyBeforeNextFinisher = mb_Rogue_GetPredictedEnergyIn(math.min(sndDuration, ruptureDuration))
    if comboPoints == 3 then
        -- If it looks like we're able to get between 3 and 4 SS in after casting Eviscerate before the next finisher needs to be cast we Eviscerate early
        if predictedEnergyBeforeNextFinisher <= 195 and predictedEnergyBeforeNextFinisher >= 155 then
            if mb_CastSpellOnTarget("Eviscerate") then
                -- mb_SayRaid("Casting " .. tostring(mb_GetComboPoints()) .. "p Eviscerate")
            end
            return
        end
    end

    if comboPoints < 4 then
        mb_CastSpellOnTarget("Sinister Strike")
        return
    end

    local predictedEnergyBeforeNextSnd = mb_Rogue_GetPredictedEnergyIn(sndDuration)
    if predictedEnergyBeforeNextSnd < 100 then
        return
    elseif comboPoints == 4 and predictedEnergyBeforeNextSnd - 40 < 100 then
        mb_CastSpellOnTarget("Sinister Strike")
        return
    end

    if ruptureDuration == 0 then
        if mb_CastSpellOnTarget("Rupture") then
            -- mb_SayRaid("Casting " .. tostring(mb_GetComboPoints()) .. "p Rupture")
        end
        return
    end

    local predictedEnergyBeforeNextRupture = mb_Rogue_GetPredictedEnergyIn(ruptureDuration)
    if predictedEnergyBeforeNextRupture < 100 then
        return
    elseif comboPoints == 4 and predictedEnergyBeforeNextRupture - 40 < 100 then
        mb_CastSpellOnTarget("Sinister Strike")
        return
    end

    -- If we're at 4 combo points and going to 5 would align better for next SnD/Rupture then cast 1 more SS first?
    if mb_CastSpellOnTarget("Eviscerate") then
        -- mb_SayRaid("Casting " .. tostring(mb_GetComboPoints()) .. "p Eviscerate")
    end
end