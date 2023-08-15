--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ChieftainOomooroo_OnCombat(Unit, Event)
	Unit:RegisterEvent("ChieftainOomooroo_Enrage", 10000, 1)
	Unit:RegisterEvent("ChieftainOomooroo_Strike", 6000, 0)
end

function ChieftainOomooroo_Enrage(pUnit, Event) 
	pUnit:CastSpell(18501) 
end

function ChieftainOomooroo_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13446, 	pUnit:GetMainTank()) 
end

function ChieftainOomooroo_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ChieftainOomooroo_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17448, 1, "ChieftainOomooroo_OnCombat")
RegisterUnitEvent(17448, 2, "ChieftainOomooroo_OnLeaveCombat")
RegisterUnitEvent(17448, 4, "ChieftainOomooroo_OnDied")