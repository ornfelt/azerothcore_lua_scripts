--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function KvaldirMistLord_OnCombat(Unit, Event)
Unit:RegisterEvent("KvaldirMistLord_WaveCrash", 8000, 0)
end

function KvaldirMistLord_WaveCrash(Unit, Event) 
Unit:FullCastSpellOnTarget(49922, Unit:GetMainTank()) 
end

function KvaldirMistLord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KvaldirMistLord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KvaldirMistLord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25496, 1, "KvaldirMistLord_OnCombat")
RegisterUnitEvent(25496, 2, "KvaldirMistLord_OnLeaveCombat")
RegisterUnitEvent(25496, 3, "KvaldirMistLord_OnKilledTarget")
RegisterUnitEvent(25496, 4, "KvaldirMistLord_OnDied")