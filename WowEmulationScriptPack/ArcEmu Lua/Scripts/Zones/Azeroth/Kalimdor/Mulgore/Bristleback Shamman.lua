--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BristlebackShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("BristlebackShaman_LightningBolt", 5000, 0)
end

function BristlebackShaman_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9532, pUnit:GetClosestPlayer()) 
end

function BristlebackShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BristlebackShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BristlebackShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2953, 1, "BristlebackShaman_OnCombat")
RegisterUnitEvent(2953, 2, "BristlebackShaman_OnLeaveCombat")
RegisterUnitEvent(2953, 3, "BristlebackShaman_OnKilledTarget")
RegisterUnitEvent(2953, 4, "BristlebackShaman_OnDied")
