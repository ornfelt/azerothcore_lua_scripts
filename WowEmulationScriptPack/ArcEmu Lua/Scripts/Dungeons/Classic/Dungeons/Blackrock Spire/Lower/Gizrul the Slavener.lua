-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Fatal Bite-16495
Frenzy-8269
Infected Bite-16128
]]--

function Gizrul_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Fatal_Bite", 1000, 0)
	pUnit:RegisterEvent("Frenzy", 2000, 0)
	pUnit:RegisterEvent("Infected_Bite", 3000, 0)
end

function Fatal_Bite(pUnit, Event)
	pUnit:CastSpellOnTarget(16495)
end

function Frenzy(pUnit, Event)
	pUnit:CastSpell(8269)
end

function Infected_Bite(pUnit, Event)
	pUnit:CastSpellOnTarget(16128)
end

function Gizrul_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Gizrul_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9736, 1, "Gizrul_OnCombat")
RegisterUnitEvent(9736, 2, "Gizrul_OnLeaveCombat")
RegisterUnitEvent(9736, 4, "Gizrul_OnDied")