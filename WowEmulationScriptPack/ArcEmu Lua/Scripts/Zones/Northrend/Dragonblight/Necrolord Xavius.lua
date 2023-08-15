--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NecrolordXavius_OnCombat(Unit, Event)
Unit:RegisterEvent("NecrolordXavius_ShadowBolt", 7000, 0)
Unit:RegisterEvent("NecrolordXavius_Shadowflame", 6000, 0)
end

function NecrolordXavius_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(20298, Unit:GetMainTank()) 
end

function NecrolordXavius_Shadowflame(Unit, Event) 
Unit:CastSpell(51337) 
end

function NecrolordXavius_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NecrolordXavius_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NecrolordXavius_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27826, 1, "NecrolordXavius_OnCombat")
RegisterUnitEvent(27826, 2, "NecrolordXavius_OnLeaveCombat")
RegisterUnitEvent(27826, 3, "NecrolordXavius_OnKilledTarget")
RegisterUnitEvent(27826, 4, "NecrolordXavius_OnDied")