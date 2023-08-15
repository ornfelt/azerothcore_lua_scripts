--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodfeatherSorceress_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodfeatherSorceress_FrostArmor", 2000, 2)
	Unit:RegisterEvent("BloodfeatherSorceress_Fireball", 8000, 0)
end

function BloodfeatherSorceress_FrostArmor(Unit, Event) 
	Unit:CastSpell(12544) 
end

function BloodfeatherSorceress_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(20793, 	Unit:GetMainTank()) 
end

function BloodfeatherSorceress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodfeatherSorceress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BloodfeatherSorceress_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2018, 1, "BloodfeatherSorceress_OnCombat")
RegisterUnitEvent(2018, 2, "BloodfeatherSorceress_OnLeaveCombat")
RegisterUnitEvent(2018, 3, "BloodfeatherSorceress_OnKilledTarget")
RegisterUnitEvent(2018, 4, "BloodfeatherSorceress_OnDied")