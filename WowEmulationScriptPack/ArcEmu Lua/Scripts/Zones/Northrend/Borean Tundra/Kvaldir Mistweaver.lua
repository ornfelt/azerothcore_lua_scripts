--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function KvaldirMistweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("KvaldirMistweaver_MistofStrangulation", 8000, 0)
end

function KvaldirMistweaver_MistofStrangulation(Unit, Event) 
Unit:FullCastSpellOnTarget(49816, Unit:GetMainTank()) 
end

function KvaldirMistweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KvaldirMistweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KvaldirMistweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25479, 1, "KvaldirMistweaver_OnCombat")
RegisterUnitEvent(25479, 2, "KvaldirMistweaver_OnLeaveCombat")
RegisterUnitEvent(25479, 3, "KvaldirMistweaver_OnKilledTarget")
RegisterUnitEvent(25479, 4, "KvaldirMistweaver_OnDied")