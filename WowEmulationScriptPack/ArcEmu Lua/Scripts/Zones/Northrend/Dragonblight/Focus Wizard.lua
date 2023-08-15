--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FocusWizard_OnCombat(Unit, Event)
Unit:RegisterEvent("FocusWizard_ArcaneFocus", 1000, 1)
Unit:RegisterEvent("FocusWizard_FrostfireBolt", 5000, 1)
Unit:RegisterEvent("FocusWizard_LightningBolt", 8000, 0)
end

function FocusWizard_ArcaneFocus(Unit, Event) 
Unit:CastSpell(51777) 
end

function FocusWizard_FrostfireBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(51779, Unit:GetMainTank()) 
end

function FocusWizard_LightningBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(49418, Unit:GetMainTank()) 
end

function FocusWizard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FocusWizard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FocusWizard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26816, 1, "FocusWizard_OnCombat")
RegisterUnitEvent(26816, 2, "FocusWizard_OnLeaveCombat")
RegisterUnitEvent(26816, 3, "FocusWizard_OnKilledTarget")
RegisterUnitEvent(26816, 4, "FocusWizard_OnDied")