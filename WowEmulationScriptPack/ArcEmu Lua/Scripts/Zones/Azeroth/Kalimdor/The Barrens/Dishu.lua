--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Dishu_OnCombat(Unit, Event)
	Unit:RegisterEvent("Dishu_SavannahCubs", 4000, 1)
end

function Dishu_SavannahCubs(Unit, Event) 
	Unit:CastSpell(8210) 
end

function Dishu_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Dishu_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Dishu_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5865, 1, "Dishu_OnCombat")
RegisterUnitEvent(5865, 2, "Dishu_OnLeaveCombat")
RegisterUnitEvent(5865, 3, "Dishu_OnKilledTarget")
RegisterUnitEvent(5865, 4, "Dishu_OnDied")