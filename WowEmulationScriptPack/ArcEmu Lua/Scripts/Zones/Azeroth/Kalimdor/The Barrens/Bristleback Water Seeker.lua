--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BristlebackWaterSeeker_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristlebackWaterSeeker_FrostNova", 8000, 0)
end

function BristlebackWaterSeeker_FrostNova(Unit, Event) 
	Unit:CastSpell(12748) 
end

function BristlebackWaterSeeker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BristlebackWaterSeeker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BristlebackWaterSeeker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3260, 1, "BristlebackWaterSeeker_OnCombat")
RegisterUnitEvent(3260, 2, "BristlebackWaterSeeker_OnLeaveCombat")
RegisterUnitEvent(3260, 3, "BristlebackWaterSeeker_OnKilledTarget")
RegisterUnitEvent(3260, 4, "BristlebackWaterSeeker_OnDied")