--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GlasshidePetrifier_OnCombat(Unit, Event)
	Unit:RegisterEvent("GlasshidePetrifier_CrystalGaze", 15000, 0)
end

function GlasshidePetrifier_CrystalGaze(Unit, Event) 
	Unit:FullCastSpellOnTarget(11020, 	Unit:GetMainTank()) 
end

function GlasshidePetrifier_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GlasshidePetrifier_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GlasshidePetrifier_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5421, 1, "GlasshidePetrifier_OnCombat")
RegisterUnitEvent(5421, 2, "GlasshidePetrifier_OnLeaveCombat")
RegisterUnitEvent(5421, 3, "GlasshidePetrifier_OnKilledTarget")
RegisterUnitEvent(5421, 4, "GlasshidePetrifier_OnDied")