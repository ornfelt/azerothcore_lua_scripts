--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function LightningHide_OnCombat(Unit, Event)
	Unit:RegisterEvent("LightningHide_LizardBolt", 5000, 0)
end

function LightningHide_LizardBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(5401, 	Unit:GetMainTank()) 
end

function LightningHide_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LightningHide_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function LightningHide_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3131, 1, "LightningHide_OnCombat")
RegisterUnitEvent(3131, 2, "LightningHide_OnLeaveCombat")
RegisterUnitEvent(3131, 3, "LightningHide_OnKilledTarget")
RegisterUnitEvent(3131, 4, "LightningHide_OnDied")