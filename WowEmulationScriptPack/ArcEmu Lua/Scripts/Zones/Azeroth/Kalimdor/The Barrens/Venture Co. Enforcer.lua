--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VentureCoEnforcer_OnCombat(Unit, Event)
	Unit:RegisterEvent("VentureCoEnforcer_BattleShout", 2000, 1)
	Unit:RegisterEvent("VentureCoEnforcer_Disarm", 10000, 0)
end

function VentureCoEnforcer_BattleShout(Unit, Event) 
	Unit:CastSpell(9128) 
end

function VentureCoEnforcer_Disarm(Unit, Event) 
	Unit:FullCastSpellOnTarget(6713, 	Unit:GetMainTank()) 
end

function VentureCoEnforcer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VentureCoEnforcer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function VentureCoEnforcer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3283, 1, "VentureCoEnforcer_OnCombat")
RegisterUnitEvent(3283, 2, "VentureCoEnforcer_OnLeaveCombat")
RegisterUnitEvent(3283, 3, "VentureCoEnforcer_OnKilledTarget")
RegisterUnitEvent(3283, 4, "VentureCoEnforcer_OnDied")