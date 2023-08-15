--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MoonkinOracle_OnCombat(Unit, Event)
	Unit:RegisterEvent("MoonkinOracle_Moonfire", 9000, 0)
	Unit:RegisterEvent("MoonkinOracle_Regrowth", 12000, 0)
	Unit:RegisterEvent("MoonkinOracle_Wrath", 7000, 0)
end

function MoonkinOracle_Moonfire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15795, 	pUnit:GetMainTank()) 
end

function MoonkinOracle_Regrowth(pUnit, Event) 
	pUnit:CastSpell(16561) 
end

function MoonkinOracle_Wrath(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9739, 	pUnit:GetMainTank()) 
end

function MoonkinOracle_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MoonkinOracle_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10157, 1, "MoonkinOracle_OnCombat")
RegisterUnitEvent(10157, 2, "MoonkinOracle_OnLeaveCombat")
RegisterUnitEvent(10157, 4, "MoonkinOracle_OnDied")