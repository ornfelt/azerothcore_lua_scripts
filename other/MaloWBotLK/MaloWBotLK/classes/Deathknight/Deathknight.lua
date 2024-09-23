mb_Deathknight_HasHysteria = false
function mb_Deathknight_OnLoad()
    if mb_GetMySpecName() == "Blood" then
        mb_classSpecificRunFunction = mb_Deathknight_Blood_OnUpdate
        mb_Deathknight_Blood_OnLoad()
    elseif mb_GetMySpecName() == "Frost" then
        mb_classSpecificRunFunction = mb_Deathknight_Frost_OnUpdate
        mb_Deathknight_Frost_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Deathknight_Unholy_OnUpdate
        mb_Deathknight_Unholy_OnLoad()
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_MIGHT)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
    mb_RegisterDesiredBuff(BUFF_MOTW)

    mb_RegisterInterruptSpell("Mind Freeze")
end

function mb_Deathknight_HandleGhoulAutoCasts(spell1, spell2, spell3)
    local _, autostate = GetSpellAutocast(spell1, "pet")
    local _, autostate2 = GetSpellAutocast(spell2, "pet")
    local _, autostate3 = GetSpellAutocast(spell3, "pet")
    if autostate == nil then
        TogglePetAutocast(5)  -- Toggle Gnaw ON
    end
    if autostate2 == nil then
        TogglePetAutocast(6) -- Toggle Claw ON
    end
    if autostate3 == nil then
        TogglePetAutocast(7) -- Toggle Leap ON
    end
end

function mb_Deathknight_SummonGhoul()
    if mb_GetRemainingSpellCooldown("Raise Dead") == 0 and mb_CastSpellWithoutTarget("Raise Dead") then
        return true
    end
    return false
end

function mb_Deathknight_ReadyCheck()
    local ready = true

    return ready
end

-- Thanks to Honey55 for the rune management code
function mb_Deathknight_NextUnholyOrDeathRune() -- returns time in seconds until next Unholy or Death Rune becomes available. 0 if one will be available already after a cast of Scourgestrike
    local WaitTime
    local UnholyAndDeathRunes
    local RuneCooldownTime = {}
    WaitTime = 10
    UnholyAndDeathRunes = 0
    UnholyAndDeathRunes = mb_UnholyRuneCD() + mb_DeathRuneCD()

    if mb_FrostRuneCD() >= 1 and UnholyAndDeathRunes >= 2 then
        WaitTime = 0
        return WaitTime
    elseif mb_FrostRuneCD() >= 1 and UnholyAndDeathRunes == 1 then
        for i=1, 6 do
            RuneCooldownTime[i], _, _ = mb_time - GetRuneCooldown(i)
            if RuneCooldownTime[i] < 0 then
                RuneCooldownTime[i] = 0
            end
            if RuneCooldownTime[i] ~= 0 and RuneCooldownTime[i] < WaitTime and GetRuneType(i) == 4 then
                WaitTime = RuneCooldownTime[i]
            elseif RuneCooldownTime[i] ~= 0 and RuneCooldownTime[i] < WaitTime and GetRuneType(i) == 3 then
                WaitTime = RuneCooldownTime[i]
            end
        end
    end

    return WaitTime
end

function mb_Deathknight_NextBloodRune() -- returns time in seconds until next Blood Rune becomes available. 0 if both available already
    local BloodStart1, _, _ = GetRuneCooldown(1)
    local BloodStart2, _, _ = GetRuneCooldown(2)
    local WaitTime = 0
    if mb_time - BloodStart1 <= 0 and mb_time - BloodStart2 <= 0 then
        WaitTime = 0
    elseif mb_time - BloodStart1 <= 0 then
        WaitTime = mb_time - BloodStart2
    elseif mb_time - BloodStart2 <= 0 then
        WaitTime = mb_time - BloodStart1
    elseif mb_time - BloodStart2 > mb_time - BloodStart1 then
        WaitTime = mb_time - BloodStart1
    elseif mb_time - BloodStart1 >= mb_time - BloodStart2 then
        WaitTime = mb_time - BloodStart2
    end
    return WaitTime
end

function mb_Deathknight_NextFrostRune() -- returns time in seconds until next Frost Rune becomes available. 0 if both available already
    local FrostStart1, _, _ = GetRuneCooldown(3)
    local FrostStart2, _, _ = GetRuneCooldown(4)
    local WaitTime = 0
    if mb_time - FrostStart1 <= 0 and mb_time - FrostStart2 <= 0 then
        WaitTime = 0
    elseif mb_time - FrostStart1 <= 0 then
        WaitTime = mb_time - FrostStart2
    elseif mb_time - FrostStart2 <= 0 then
        WaitTime = mb_time - FrostStart1
    elseif mb_time - FrostStart2 > mb_time - FrostStart1 then
        WaitTime = mb_time - FrostStart1
    elseif mb_time - FrostStart1 >= mb_time - FrostStart2 then
        WaitTime = mb_time - FrostStart2
    end
    return WaitTime
end


-- Death Runes
function mb_DeathRuneCD()
    local DRunesOnCD = 0
    local DRunesOffCD = 0
    for i=1, 6 do
        if GetRuneType(i) == 4 and select(3, GetRuneCooldown(i)) == false then
            DRunesOnCD = DRunesOnCD + 1
        elseif GetRuneType(i) == 4 and select(3, GetRuneCooldown(i)) == true then
            DRunesOffCD = DRunesOffCD + 1
        end
    end

    return DRunesOffCD
end

-- Frost Runes
function mb_FrostRuneCD()
    local FRunesOnCD = 0
    local FRunesOffCD = 0
    for i=1, 6 do
        if GetRuneType(i) == 2 and select(3, GetRuneCooldown(i)) == false then
            FRunesOnCD = FRunesOnCD + 1
        elseif GetRuneType(i) == 2 and select(3, GetRuneCooldown(i)) == true then
            FRunesOffCD = FRunesOffCD + 1
        end
    end

    return FRunesOffCD
end

-- Unholy Runes
function mb_UnholyRuneCD()
    local URunesOnCD = 0
    local URunesOffCD = 0
    for i=1, 6 do
        if GetRuneType(i) == 3 and select(3, GetRuneCooldown(i)) == false then
            URunesOnCD = URunesOnCD + 1
        elseif GetRuneType(i) == 3 and select(3, GetRuneCooldown(i)) == true then
            URunesOffCD = URunesOffCD + 1
        end
    end

    return URunesOffCD
end

-- Blood Runes
function mb_BloodRuneCD()
    local BRunesOnCD = 0
    local BRunesOffCD = 0
    for i=1, 6 do
        if GetRuneType(i) == 1 and select(3, GetRuneCooldown(i)) == false then
            BRunesOnCD = BRunesOnCD + 1
        elseif GetRuneType(i) == 1 and select(3, GetRuneCooldown(i)) == true then
            BRunesOffCD = BRunesOffCD + 1
        end
    end

    return BRunesOffCD
end
