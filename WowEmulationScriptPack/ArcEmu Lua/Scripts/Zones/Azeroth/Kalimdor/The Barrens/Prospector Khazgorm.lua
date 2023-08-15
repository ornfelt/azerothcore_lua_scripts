--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ProspectorKhazgorm_OnCombat(Unit, Event)
	Unit:RegisterEvent("ProspectorKhazgorm_Backhand", 8000, 0)
end

function ProspectorKhazgorm_Backhand(Unit, Event) 
	Unit:FullCastSpellOnTarget(6253, 	Unit:GetMainTank()) 
end

function ProspectorKhazgorm_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ProspectorKhazgorm_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ProspectorKhazgorm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5849, 1, "ProspectorKhazgorm_OnCombat")
RegisterUnitEvent(5849, 2, "ProspectorKhazgorm_OnLeaveCombat")
RegisterUnitEvent(5849, 3, "ProspectorKhazgorm_OnKilledTarget")
RegisterUnitEvent(5849, 4, "ProspectorKhazgorm_OnDied")