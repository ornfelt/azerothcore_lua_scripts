--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Magmothregar_OnCombat(Unit, Event)
Unit:RegisterEvent("Magmothregar_Fervor", 10000, 0)
Unit:RegisterEvent("Magmothregar_MagnataurCharge", 8000, 0)
end

function Magmothregar_Fervor(Unit, Event) 
Unit:CastSpell(50822) 
end

function Magmothregar_MagnataurCharge(Unit, Event) 
Unit:CastSpell(50413) 
end

function Magmothregar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Magmothregar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Magmothregar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25430, 1, "Magmothregar_OnCombat")
RegisterUnitEvent(25430, 2, "Magmothregar_OnLeaveCombat")
RegisterUnitEvent(25430, 3, "Magmothregar_OnKilledTarget")
RegisterUnitEvent(25430, 4, "Magmothregar_OnDied")