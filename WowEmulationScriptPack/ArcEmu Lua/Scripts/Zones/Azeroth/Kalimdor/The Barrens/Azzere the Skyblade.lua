--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AzzeretheSkyblade_OnCombat(Unit, Event)
	Unit:RegisterEvent("AzzeretheSkyblade_Fireball", 8000, 0)
	Unit:RegisterEvent("AzzeretheSkyblade_FlameSpike", 9000, 0)
end

function AzzeretheSkyblade_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(13375, 	Unit:GetMainTank()) 
end

function AzzeretheSkyblade_FlameSpike(Unit, Event) 
	Unit:CastSpell(6725) 
end

function AzzeretheSkyblade_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AzzeretheSkyblade_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function AzzeretheSkyblade_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5834, 1, "AzzeretheSkyblade_OnCombat")
RegisterUnitEvent(5834, 2, "AzzeretheSkyblade_OnLeaveCombat")
RegisterUnitEvent(5834, 3, "AzzeretheSkyblade_OnKilledTarget")
RegisterUnitEvent(5834, 4, "AzzeretheSkyblade_OnDied")