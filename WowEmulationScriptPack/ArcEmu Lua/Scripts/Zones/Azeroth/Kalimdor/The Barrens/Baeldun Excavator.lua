--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function BaeldunExcavator_OnCombat(Unit, Event)
	Unit:RegisterEvent("BaeldunExcavator_DefensiveStance", 1000, 1)
	Unit:RegisterEvent("BaeldunExcavator_SunderArmor", 5000, 0)
end

function BaeldunExcavator_DefensiveStance(Unit, Event) 
	Unit:CastSpell(7164) 
end

function BaeldunExcavator_SunderArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(21081, 	Unit:GetMainTank()) 
end

function BaeldunExcavator_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BaeldunExcavator_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BaeldunExcavator_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3374, 1, "BaeldunExcavator_OnCombat")
RegisterUnitEvent(3374, 2, "BaeldunExcavator_OnLeaveCombat")
RegisterUnitEvent(3374, 3, "BaeldunExcavator_OnKilledTarget")
RegisterUnitEvent(3374, 4, "BaeldunExcavator_OnDied")