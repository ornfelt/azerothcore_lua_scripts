function mb_Warlock_OnLoad()
    if mb_GetMySpecName() == "Affliction" then
        mb_classSpecificRunFunction = mb_Warlock_Affliction_OnUpdate
        mb_Warlock_Affliction_OnLoad()
    elseif mb_GetMySpecName() == "Demonology" then
        mb_classSpecificRunFunction = mb_Warlock_Demonology_OnUpdate
        mb_Warlock_Demonology_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Warlock_Destruction_OnUpdate
        mb_Warlock_Destruction_OnLoad()
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)

end

function mb_Warlock_HandlePetSummon(spell)
    if not UnitAffectingCombat("player") and not PetHasActionBar() then
        local _, _, displayName = UnitCastingInfo("player")
        if displayName == spell then
            return false
        end
        if mb_CastSpellWithoutTarget(spell) then
            return true
        end
    end
end

function mb_Warlock_HandleStones(itemName)
    local hasMainHandEnchant = GetWeaponEnchantInfo()
    if not hasMainHandEnchant then
        if not UnitAffectingCombat("player") and mb_UseItem(itemName) then
            PickupInventoryItem(16)
            ReplaceEnchant()
            return true
        end

        if mb_GetItemLocation(itemName) == nil then
            if itemName == "Grand Spellstone" then
                if mb_CastSpellWithoutTarget("Create Spellstone") then
                    return true
                end
            end

            if itemName == "Grand Firestone" then
                if mb_CastSpellWithoutTarget("Create Firestone") then
                    return true
                end
            end
        end
    end
    return false
end

-- Rank 1 Life Tap out of combat to maintain spellpower buff.
function mb_Warlock_HandleLifeTap()
    if not UnitBuff("player", "Life Tap") and not UnitAffectingCombat("player") and mb_UnitPowerPercentage("player") > 95 then
        if mb_CastSpellWithoutTarget("Life Tap(Rank 1)") then
            return
        end
    end

    if mb_UnitPowerPercentage("player") < 95 and not UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") > 80 then
        if mb_CastSpellWithoutTarget("Life Tap") then
            return
        end
    end
end

function mb_Warlock_HandleImpAutoCasts(spell1, spell2, spell3, spell4)
    local _, autostate = GetSpellAutocast(spell1, "pet")
    local _, autostate2 = GetSpellAutocast(spell2, "pet")
    local _, autostate3 = GetSpellAutocast(spell3, "pet")
    local _, autostate4 = GetSpellAutocast(spell4, "pet")

    if autostate == 1 then
        TogglePetAutocast(4) -- Toggle Fire Shield Pact OFF
    end
    if autostate2 == nil then
        TogglePetAutocast(5) -- Toggle Blood Pact ON
    end
    if autostate3 == nil then
        TogglePetAutocast(6) -- Toggle Firebolt ON
    end
    if autostate4 == nil then
        TogglePetAutocast(7) -- Toggle Phase Shift ON
    end
end

function mb_Warlock_HandleFelhunterAutoCasts(spell1, spell2)
    local _, autostate = GetSpellAutocast(spell1, "pet")
    local _, autostate2 = GetSpellAutocast(spell2, "pet")
    if autostate == nil then
        TogglePetAutocast(4)  -- Toggle Fel Intelligence ON
    end
    if autostate2 == nil then
        TogglePetAutocast(6) -- Toggle Shadow Bite ON
    end
end

function mb_Warlock_HandleFelguardAutoCasts(spell1, spell2, spell3)
    local _, autostate = GetSpellAutocast(spell1, "pet")
    local _, autostate2 = GetSpellAutocast(spell2, "pet")
    local _, autostate3 = GetSpellAutocast(spell3, "pet")
    if autostate == nil then
        TogglePetAutocast(4) -- Toggle Intercept ON
    end
    if autostate2 == nil then
        TogglePetAutocast(5) -- Toggle Cleave ON
    end
    if autostate3 == 1 then
        TogglePetAutocast(6) -- Toggle Anguish OFF
    end
end

function mb_Warlock_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Fel Armor") < 540 then
        CancelUnitBuff("player", "Fel Armor")
        ready = false
    end

    local _, mainHandExpiration = GetWeaponEnchantInfo()
    if mainHandExpiration / 1000 < 540 then
        CancelItemTempEnchantment(1)
        ready = false
    end

    return ready
end