-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Rend-13738
Thrash-3391
]]--

function Halycon_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Rend", 1000, 0)
	pUnit:RegisterEvent("Thrash", 2000, 0)
end

function Rend(pUnit, Event)
	pUnit:CastSpellOnTarget(13738)
end

function Thrash(pUnit, Event)
	pUnit:CastSpell(3391)
end

function Halycon_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Halycon_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9736, 1, "Halycon_OnCombat")
RegisterUnitEvent(9736, 2, "Halycon_OnLeaveCombat")
RegisterUnitEvent(9736, 4, "Halycon_OnDied")