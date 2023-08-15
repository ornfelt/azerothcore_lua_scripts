--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InduleFisherman_OnCombat(Unit, Event)
Unit:RegisterEvent("InduleFisherman_ElectrifiedNet", 10000, 0)
end

function InduleFisherman_ElectrifiedNet(Unit, Event) 
Unit:FullCastSpellOnTarget(11820, Unit:GetMainTank()) 
end

function InduleFisherman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InduleFisherman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InduleFisherman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26343, 1, "InduleFisherman_OnCombat")
RegisterUnitEvent(26343, 2, "InduleFisherman_OnLeaveCombat")
RegisterUnitEvent(26343, 3, "InduleFisherman_OnKilledTarget")
RegisterUnitEvent(26343, 4, "InduleFisherman_OnDied")