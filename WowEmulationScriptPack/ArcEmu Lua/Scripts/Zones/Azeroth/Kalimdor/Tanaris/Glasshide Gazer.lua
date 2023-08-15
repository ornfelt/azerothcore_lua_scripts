--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GlasshideGazer_OnCombat(Unit, Event)
	Unit:RegisterEvent("GlasshideGazer_CrystalGaze", 10000, 0)
end

function GlasshideGazer_CrystalGaze(Unit, Event) 
	Unit:FullCastSpellOnTarget(3635, 	Unit:GetMainTank()) 
end

function GlasshideGazer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GlasshideGazer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GlasshideGazer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5420, 1, "GlasshideGazer_OnCombat")
RegisterUnitEvent(5420, 2, "GlasshideGazer_OnLeaveCombat")
RegisterUnitEvent(5420, 3, "GlasshideGazer_OnKilledTarget")
RegisterUnitEvent(5420, 4, "GlasshideGazer_OnDied")