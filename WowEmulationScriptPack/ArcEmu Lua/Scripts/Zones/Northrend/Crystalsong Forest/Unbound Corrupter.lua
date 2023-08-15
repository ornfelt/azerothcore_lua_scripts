--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UnboundCorrupter_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundCorrupter_ArcaneBolt", 6000, 0)
Unit:RegisterEvent("UnboundCorrupter_LeyCurse", 5000, 1)
Unit:RegisterEvent("UnboundCorrupter_TransferredPower", 4000, 1)
end

function UnboundCorrupter_ArcaneBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(38204, Unit:GetMainTank()) 
end

function UnboundCorrupter_LeyCurse(Unit, Event) 
Unit:FullCastSpellOnTarget(58667, Unit:GetMainTank()) 
end

function UnboundCorrupter_TransferredPower(Unit, Event) 
Unit:CastSpell(58270) 
end

function UnboundCorrupter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundCorrupter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundCorrupter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30868, 1, "UnboundCorrupter_OnCombat")
RegisterUnitEvent(30868, 2, "UnboundCorrupter_OnLeaveCombat")
RegisterUnitEvent(30868, 3, "UnboundCorrupter_OnKilledTarget")
RegisterUnitEvent(30868, 4, "UnboundCorrupter_OnDied")