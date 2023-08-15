--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SaltFlatsVulture_OnCombat(Unit, Event)
	UnitRegisterEvent("SaltFlatsVulture_Execute", 6000, 0)
end

function SaltFlatsVulture_Execute(Unit, Event) 
if 	UnitGetHealthEnemy() < 20 then
	UnitFullCastSpellOnTarget(7160, 	UnitGetMainTank()) 
end
end

function SaltFlatsVulture_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SaltFlatsVulture_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SaltFlatsVulture_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4158, 1, "SaltFlatsVulture_OnCombat")
RegisterUnitEvent(4158, 2, "SaltFlatsVulture_OnLeaveCombat")
RegisterUnitEvent(4158, 3, "SaltFlatsVulture_OnKilledTarget")
RegisterUnitEvent(4158, 4, "SaltFlatsVulture_OnDied")