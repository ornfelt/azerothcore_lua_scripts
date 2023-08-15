-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Lord Incendius says: I cannot be destroyed! By the will of Ragnaros, I shall be reborn!
----Spells-ID
Curse of the Elemental Lord-26977
Fiery Burst-13900
Fire Storm-13899
Mighty Blow-14099
]]--

function LICD_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(11, 0, "I cannot be destroyed! By the will of Ragnaros, I shall be reborn!")
	pUnit:RegisterEvent("LICD_CurseotEleLord", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("LICD_FireStorm", 30000, 0) --Time could be wrong
	pUnit:RegisterEvent("LICD_FieryBurst", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("LICD_MightyBlow", 25000, 0) --Time could be wrong
end

function LICD_CurseotEleLord(pUnit, Event)
	pUnit:CastSpellOnTarget(26977)
end

function LICD_MightyBlow(pUnit, Event)
	pUnit:FullCastSpellOnTarget(14099)
end

function LICD_FireStorm(pUnit, Event)
	pUnit:FullCastSpellonTarget(13899)
end

function LICD_FieryBurst(pUnit, Event)
	pUnit:FullCastSpellonTarget(13900)
end

function LICD_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function LICD_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9017, 1, "LICD_OnCombat")
RegisterUnitEvent(9017, 2, "LICD_OnLeaveCombat")
RegisterUnitEvent(9017, 4, "LICD_OnDeath")