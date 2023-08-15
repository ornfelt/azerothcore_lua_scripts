--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Gesharahan_OnCombat(Unit, Event)
	Unit:RegisterEvent("Gesharahan_DeadlyPoison", 6000, 1)
end

function Gesharahan_DeadlyPoison(Unit, Event) 
	Unit:FullCastSpellOnTarget(3583, 	Unit:GetMainTank()) 
end

function Gesharahan_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Gesharahan_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Gesharahan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3398, 1, "Gesharahan_OnCombat")
RegisterUnitEvent(3398, 2, "Gesharahan_OnLeaveCombat")
RegisterUnitEvent(3398, 3, "Gesharahan_OnKilledTarget")
RegisterUnitEvent(3398, 4, "Gesharahan_OnDied")