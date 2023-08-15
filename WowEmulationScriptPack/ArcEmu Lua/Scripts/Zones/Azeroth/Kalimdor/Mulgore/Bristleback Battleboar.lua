--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BristlebackBattleboar_OnCombat(Unit, Event)
Unit:RegisterEvent("BristlebackBattleboar_BoarCharge", 8000, 0)
end

function BristlebackBattleboar_BoarCharge(pUnit, Event) 
pUnit:CastSpell(3385) 
end

function BristlebackBattleboar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BristlebackBattleboar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BristlebackBattleboar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2954, 1, "BristlebackBattleboar_OnCombat")
RegisterUnitEvent(2954, 2, "BristlebackBattleboar_OnLeaveCombat")
RegisterUnitEvent(2954, 3, "BristlebackBattleboar_OnKilledTarget")
RegisterUnitEvent(2954, 4, "BristlebackBattleboar_OnDied")