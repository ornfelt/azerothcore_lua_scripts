-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Summon Spire Spiderling-16103
Mother's Milk-16468
Crystallize-16104
]]--

function MSW_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("MSW_Spells", 100, 0)
end

function MSW_Spells(pUnit, Event)
	pUnit:RegisterEvent("MSW_Crystallize", 1100, 0)
	pUnit:RegisterEvent("MSW_MothersMilk", 2100, 0)
	pUnit:RegisterEvent("MSW_Summon", 3100, 0)
end

function MSW_Crystallize(pUnit, Event)
	pUnit:CastSpellOnTarget(16104)
end

function MSW_MothersMilk(pUnit, Event)
	pUnit:FullCastSpellOnTarget(16468)
end

function MSW_Summon(pUnit, Event)
	pUnit:CastSpell(16103)
end

function MSW_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function MSW_OnDeath(pUnit, Event)
	pUnit:removeEvents()
end

RegisterUnitEvent(10596, 1, "MSW_OnCombat")
RegisterUnitEvent(10596, 2, "MSW_OnLeaveCombat")
RegisterUnitEvent(10596, 4, "MSW_OnDeath")