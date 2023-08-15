--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Boahn_OnCombat(Unit, Event)
	Unit:RegisterEvent("Boahn_LightningBolt", 8000, 0)
end

function Boahn_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9532, 	Unit:GetMainTank()) 
end

function Boahn_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Boahn_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Boahn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3672, 1, "Boahn_OnCombat")
RegisterUnitEvent(3672, 2, "Boahn_OnLeaveCombat")
RegisterUnitEvent(3672, 3, "Boahn_OnKilledTarget")
RegisterUnitEvent(3672, 4, "Boahn_OnDied")