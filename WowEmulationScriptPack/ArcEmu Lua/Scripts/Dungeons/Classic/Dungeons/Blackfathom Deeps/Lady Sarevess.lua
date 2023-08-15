-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Lady Sarevess yells: You should not be here! Slay them!
5799	A_Lady Serevess Aggro01
5801	A_Lady Sarevess Slay01
----Spells-ID
Forked Lightning-8435
Shoot-6660
Slow-246
]]--

function LadySarevess_OnCombat(pUnit, event)
	pUnit:SendChatMessage(12, 0, "You should not be here! Slay them!")
	pUnit:PlaySoundToSet(5801)
	pUnit:RegisterEvent("LadySarevess_ForkedLightning", 5000, 0)
	pUnit:RegisterEvent("LadySarevess_Shoot", 1, 0)
	pUnit:RegisterEvent("LadySarevess_Slow", 1000, 0)
end

function LadySarevess_ForkedLightning(pUnit, Event)
	pUnit:CastSpell(8435) 
end

function LadySarevess_Shoot(pUnit, Event)
 	pUnit:FullCastSpellOnTarget(6660, pUnit:GetRandomPlayer(0))
end

function LadySarevess_Slow(pUnit, Event)
  	pUnit:FullCastSpellOnTarget(246, pUnit:GetRandomPlayer(0))
end

function LadySarevess_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function LadySarevess_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(4831, 1, "LadySarevess_OnCombat")
RegisterUnitEvent(4831, 2, "LadySarevess_OnLeaveCombat")
RegisterUnitEvent(4831, 3, "LadySarevess_OnDeath")