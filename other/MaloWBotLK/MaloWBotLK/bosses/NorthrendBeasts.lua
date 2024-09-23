--mb_BossModule_NorthrendBeasts_Phase = 1
function mb_BossModule_NorthrendBeasts_PreOnUpdate()

    mb_BossModule_Icehowl_MassiveCrash()

    return false
end

mb_BossModule_NorthrendBeasts_crashTargetUnit = nil
mb_BossModule_NorthrendBeasts_lastDetectedCrash = 0
mb_BossModule_NorthrendBeasts_isMovingAfterCrash = false
mb_BossModule_NorthrendBeasts_Move_X = nil
mb_BossModule_NorthrendBeasts_Move_Y = nil
function mb_BossModule_Icehowl_MassiveCrash()
    local timeSinceCrash = mb_time - mb_BossModule_NorthrendBeasts_lastDetectedCrash
    if timeSinceCrash > 9.0 then
        mb_GoToPosition_Reset()
        mb_BossModule_NorthrendBeasts_crashTargetUnit = nil
        return
    end
    if mb_BossModule_NorthrendBeasts_crashTargetUnit == "player" then
        return
    end
    if timeSinceCrash < 6.5 and mb_BossModule_NorthrendBeasts_crashTargetUnit ~= "player" and mb_BossModule_NorthrendBeasts_crashTargetUnit ~= nil then
        mb_SayRaid(tostring(mb_BossModule_NorthrendBeasts_crashTargetUnit))
        local tX,tY = mb_GetMapPosition(mb_BossModule_NorthrendBeasts_crashTargetUnit)
        local pX,pY = mb_GetMapPosition("player")
        local dX,dY = pX - tX, pY - tY
        local dist = math.sqrt(dX*dX + dY*dY)
        local minSafeDistance = 0.05
        local destX,destY = pX + dX, pY + dY
        if UnitExists(mb_BossModule_NorthrendBeasts_crashTargetUnit) then
            if dist < minSafeDistance then
                mb_GoToPosition_SetDestination(destX, destY, 0.005)
                mb_GoToPosition_Update()
                mb_BossModule_NorthrendBeasts_isMovingAfterCrash = true
            end
            if dist > minSafeDistance then
                mb_BossModule_NorthrendBeasts_isMovingAfterCrash = false
            end
        end
    end
end

function mb_BossModule_NorthrendBeasts_CombatLogCallback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21)
   --[[ mb_Print("2:"..arg2) -- MESSAGE TYPE
    mb_Print("3:"..arg3) -- MESSAGE STRING
    mb_Print("4:"..arg4) -- SOURCE
    mb_Print("7:"..arg7) -- TARGET OF CHAT_MSG_RAID_BOSS_EMOTE ]]--
    if arg6 == "Icehowl" and arg4 == "SPELL_CAST_START" and arg12 == "Massive Crash" then
        mb_Say("Crash: ")
        mb_BossModule_NorthrendBeasts_lastDetectedCrash = mb_time
    end

    if arg6 == "Icehowl" and arg4 == "SPELL_CAST_SUCCESS" and arg12 == "Arctic Breath" then
        mb_Say("Breath: ")
    end

    if arg2 == "CHAT_MSG_RAID_BOSS_EMOTE" and arg7 ~= "" then
        local target = mb_GetUnitForPlayerName(tostring(arg7))
        mb_BossModule_NorthrendBeasts_crashTargetUnit = target
        if arg7 == UnitName("player") then
            mb_Say("He targeted me!")
        else
            if mb_IsUnitWithinRange(target, 1) then
                mb_Say("I'm running from "..arg7)
            end
        end

    end
end

function mb_BossModule_test_CombatLogCallback(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21)
    mb_Say("Loaded up mah module")
end


function mb_BossModule_NorthrendBeasts_Unload()
    mb_CombatLogModule_Disable()
end

function mb_BossModule_NorthrendBeasts_OnLoad()
    mb_BossModule_PreOnUpdate = mb_BossModule_NorthrendBeasts_PreOnUpdate
    mb_CombatLogModule_Enable()
    mb_CombatLogModule_SetCallback(mb_BossModule_NorthrendBeasts_CombatLogCallback)
    mb_BossModule_unloadFunction = mb_BossModule_NorthrendBeasts_Unload
end

mb_BossModule_RegisterModule("north", mb_BossModule_NorthrendBeasts_OnLoad)



--[[
function mb_BossModule_Gormok_Tank_OnUpdate()
    if UnitName("target") ~= "Gormok the Impaler" or mb_BossModule_NorthrendBeasts_Phase ~= 1 then
        return false
    end

    if not UnitIsUnit("player", "targettarget") then
        if not UnitDebuff("player", "Impale") then
            if mb_GetClass("player") == "PALADIN" then
                if mb_CastSpellOnTarget("Hand of Reckoning") then
                    return true
                end
            elseif mb_GetClass("player") == "DRUID" then
                if mb_CastSpellOnTarget("Growl") then
                    return true
                end
            end
        end
    end

    return false
end

function mb_BossModule_Gormok_Caster_OnUpdate()
    if mb_BossModule_NorthrendBeasts_Phase ~= 1 then
        return false
    end
    -- Grab gormok by assist, set focus to watch for staggering stomp
    TargetUnit("Gormok the Impaler")
    if UnitName("target") == "Gormok the Impaler" then
        FocusUnit("target")
    end

    -- Boss spell cast
    local spell, _, _, _, _, endTime = UnitCastingInfo("focus")
    -- Our spell cast
    local myspell, _, _, _, _, myEnd = UnitCastingInfo("player")
    if spell ~= nil and myspell ~= nil then
        if spell == "Staggering Stomp" and myEnd > endTime then
            mb_Say("Enemy cast ends at: " .. myEnd)
            mb_Say("My cast ends at: " .. endTime)
            mb_SayRaid("Stopping Casting!")
            mb_StopCast()
            return true
        end
    end

    if not mb_IsHealer() then
        TargetUnit("Snobold Vassal")
        if UnitName("target") == "Snobold Vassal" and not UnitIsDead("target") then
            return false
        else
            TargetUnit("Gormok the Impaler")
            return false
        end
    end
    TargetUnit("Gormok the Impaler")
    return false
end

function mb_BossModule_Dreadscale_Tank_OnUpdate()
   return false
end
]]--