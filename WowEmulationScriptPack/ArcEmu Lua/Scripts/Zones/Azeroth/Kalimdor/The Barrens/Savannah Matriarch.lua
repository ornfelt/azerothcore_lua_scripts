--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SavannahMatriarch_OnCombat(Unit, Event)
	Unit:RegisterEvent("SavannahMatriarch_SavannahCubs", 4000, 1)
end

function SavannahMatriarch_SavannahCubs(Unit, Event) 
	Unit:CastSpell(8210) 
end

function SavannahMatriarch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SavannahMatriarch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SavannahMatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5865, 1, "SavannahMatriarch_OnCombat")
RegisterUnitEvent(5865, 2, "SavannahMatriarch_OnLeaveCombat")
RegisterUnitEvent(5865, 3, "SavannahMatriarch_OnKilledTarget")
RegisterUnitEvent(5865, 4, "SavannahMatriarch_OnDied")