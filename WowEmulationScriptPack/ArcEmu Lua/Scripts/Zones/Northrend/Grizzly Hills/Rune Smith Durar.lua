--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RuneSmithDurar_OnCombat(Unit, Event)
Unit:RegisterEvent("RuneSmithDurar_LightningCharged", 4000, 1)
end

function RuneSmithDurar_LightningCharged(Unit, Event) 
Unit:CastSpell(52701) 
end

function RuneSmithDurar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RuneSmithDurar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RuneSmithDurar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26409, 1, "RuneSmithDurar_OnCombat")
RegisterUnitEvent(26409, 2, "RuneSmithDurar_OnLeaveCombat")
RegisterUnitEvent(26409, 3, "RuneSmithDurar_OnKilledTarget")
RegisterUnitEvent(26409, 4, "RuneSmithDurar_OnDied")