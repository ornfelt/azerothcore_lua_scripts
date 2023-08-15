--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VileFamiliar_OnCombat(Unit, Event)
	Unit:RegisterEvent("VileFamiliar_Fireball", 8000, 0)
end

function VileFamiliar_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(11921, 	Unit:GetMainTank()) 
end

function VileFamiliar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VileFamiliar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function VileFamiliar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3101, 1, "VileFamiliar_OnCombat")
RegisterUnitEvent(3101, 2, "VileFamiliar_OnLeaveCombat")
RegisterUnitEvent(3101, 3, "VileFamiliar_OnKilledTarget")
RegisterUnitEvent(3101, 4, "VileFamiliar_OnDied")