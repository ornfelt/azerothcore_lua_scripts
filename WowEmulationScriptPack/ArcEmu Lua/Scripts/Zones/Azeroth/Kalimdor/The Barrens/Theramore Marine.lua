--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TheramoreMarine_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheramoreMarine_DefensiveStance", 2000, 1)
	Unit:RegisterEvent("TheramoreMarine_Disarm", 6000, 0)
	Unit:RegisterEvent("TheramoreMarine_ShieldBash", 8000, 0)
end

function TheramoreMarine_DefensiveStance(Unit, Event) 
	Unit:CastSpell(7164) 
end

function TheramoreMarine_Disarm(Unit, Event) 
	Unit:FullCastSpellOnTarget(6713, 	Unit:GetMainTank()) 
end

function TheramoreMarine_ShieldBash(Unit, Event) 
	Unit:FullCastSpellOnTarget(72, 	Unit:GetMainTank()) 
end

function TheramoreMarine_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheramoreMarine_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TheramoreMarine_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3385, 1, "TheramoreMarine_OnCombat")
RegisterUnitEvent(3385, 2, "TheramoreMarine_OnLeaveCombat")
RegisterUnitEvent(3385, 3, "TheramoreMarine_OnKilledTarget")
RegisterUnitEvent(3385, 4, "TheramoreMarine_OnDied")