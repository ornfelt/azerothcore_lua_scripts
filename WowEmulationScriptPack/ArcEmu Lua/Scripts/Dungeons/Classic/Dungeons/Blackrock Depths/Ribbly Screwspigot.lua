-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Ribbly Screwspigot says: No! Get away from me! Help!!
----Spells-ID
Gouge-12540
Hamstring-9080
]]--

function RScrewp_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(11, 0, "No! Get away from me! Help!!")
	pUnit:RegisterEvent("RScrewp_Hamstring", 20000, 0)
	pUnit:RegisterEvent("RScrewp_Gouge", 5000, 0)
end

function RScrewp_Hamstring(pUnit, Event)
	pUnit:CastSpellOnTarget(9080)
end

function RScrewp_Gouge(pUnit, Event)
	pUnit:CastSpellonTarget(12540)
end

function RScrewp_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function RScrewp_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9543, 1, "RScrewp_OnCombat")
RegisterUnitEvent(9543, 2, "RScrewp_OnLeaveCombat")
RegisterUnitEvent(9543, 4, "RScrewp_OnDeath")