-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Cleave-15284
Conflagration-16805
Flamestrike-16419
Pierce Armor-6016
Rage-16789
]]--

function Drakkisath_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Drakkisath_Spells", 100, 0)
end

function Drakkisath_Spells(pUnit, Event)
	pUnit:RegisterEvent("Cleave", 1000, 0)
	pUnit:RegisterEvent("Conflagration", 2000, 0)
	pUnit:RegisterEvent("Flamestrike", 3000, 0)
	pUnit:RegisterEvent("Pierce_Armor", 4000, 0)
	pUnit:RegisterEvent("Rage", 5000, 0)
end

function Cleave(pUnit, Event)
	pUnit:CastSpellOnTarget(15284)
end

function Conflagration(pUnit, Event)
	pUnit:CastSpellOnTarget(16805)
end

function Flamestrike(pUnit, Event)
	pUnit:FullCastSpellOnTarget(16419)
end

function Pierce_Armor(pUnit, Event)
	pUnit:CastSpellOnTarget(6016, pUnit:GetRandomPlayer())
end

function Rage(pUnit, Event)
	pUnit:CastSpell(16789)
end

function Drakkisath_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Drakkisath_OnDeath(pUnit, Event)
	pUnit:removeEvents()
end

RegisterUnitEvent(10584, 1, "Drakkisath_OnCombat")
RegisterUnitEvent(10584, 2, "Drakkisath_OnLeaveCombat")
RegisterUnitEvent(10584, 4, "Drakkisath_OnDeath")