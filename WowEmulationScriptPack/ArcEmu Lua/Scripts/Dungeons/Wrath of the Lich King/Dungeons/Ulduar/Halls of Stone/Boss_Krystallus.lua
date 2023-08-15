--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

local Krystallus = 27977

function Krystallus_OnCombat(punit, event)
   punit:SendChatMessage(14, 0, "Crash....")
    punit:RegisterEvent("Krystallus_BoulderToss", 10000, 0)
	punit:RegisterEvent("Krystallus_Stomp", 35000, 0)
	punit:RegisterEvent("Krystallus_GroundSlam", 22000, 0)
end

function Krystallus_BoulderToss(punit, event)
   local plr = punit:GetRandomPlayer(0)
     punit:FullCastSpellOnTarget(50843, plr)
end

function Krystallus_Stomp(punit, event)
   punit:CastSpell(50868)
end

function Krystallus_GroundSlam(punit, event)
   local plr = punit:GetAITargets()
    punit:FullCastSpellOnTarget(50827, plr)
	punit:RegisterEvent("Krystallus_Shatter", 5000, 1)
end

function Krystallus_Shatter(punit, event)
   local plr = punit:GetAITargets()
    punit:FullCastSpellOnTarget(50810, plr)
end

RegisterUnitEvent(Krystallus, 1, "Krystallus_OnCombat")