--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NecrolordHorus_OnCombat(Unit, Event)
Unit:RegisterEvent("NecrolordHorus_CurseofImpotence", 4000, 1)
Unit:RegisterEvent("NecrolordHorus_ShadowBolt", 7000, 0)
end

function NecrolordHorus_CurseofImpotence(Unit, Event) 
Unit:FullCastSpellOnTarget(51340, Unit:GetMainTank()) 
end

function NecrolordHorus_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(20298, Unit:GetMainTank()) 
end

function NecrolordHorus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NecrolordHorus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NecrolordHorus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27805, 1, "NecrolordHorus_OnCombat")
RegisterUnitEvent(27805, 2, "NecrolordHorus_OnLeaveCombat")
RegisterUnitEvent(27805, 3, "NecrolordHorus_OnKilledTarget")
RegisterUnitEvent(27805, 4, "NecrolordHorus_OnDied")