--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SkadirMistweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirMistweaver_MistofStrangulation", 8000, 0)
end

function SkadirMistweaver_MistofStrangulation(Unit, Event) 
Unit:FullCastSpellOnTarget(49816, Unit:GetMainTank()) 
end

function SkadirMistweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirMistweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirMistweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25613, 1, "SkadirMistweaver_OnCombat")
RegisterUnitEvent(25613, 2, "SkadirMistweaver_OnLeaveCombat")
RegisterUnitEvent(25613, 3, "SkadirMistweaver_OnKilledTarget")
RegisterUnitEvent(25613, 4, "SkadirMistweaver_OnDied")