--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Tukemuth_OnCombat(Unit, Event)
Unit:RegisterEvent("Tukemuth_Trample", 10000, 0)
Unit:RegisterEvent("Tukemuth_TuskStrike", 8000, 0)
end

function Tukemuth_Trample(Unit, Event) 
Unit:CastSpell(57066) 
end

function Tukemuth_TuskStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50410, Unit:GetMainTank()) 
end

function Tukemuth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tukemuth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tukemuth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32400, 1, "Tukemuth_OnCombat")
RegisterUnitEvent(32400, 2, "Tukemuth_OnLeaveCombat")
RegisterUnitEvent(32400, 3, "Tukemuth_OnKilledTarget")
RegisterUnitEvent(32400, 4, "Tukemuth_OnDied")