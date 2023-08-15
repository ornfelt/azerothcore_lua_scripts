--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MalginBarleybrew_OnCombat(Unit, Event)
	Unit:RegisterEvent("MalginBarleybrew_BladeFlurry", 4000, 1)
	Unit:RegisterEvent("MalginBarleybrew_BattleShout", 6000, 1)
end

function MalginBarleybrew_BladeFlurry(Unit, Event) 
	Unit:CastSpell(3631) 
end

function MalginBarleybrew_BattleShout(Unit, Event) 
	Unit:CastSpell(5242) 
end

function MalginBarleybrew_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MalginBarleybrew_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function MalginBarleybrew_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5848, 1, "MalginBarleybrew_OnCombat")
RegisterUnitEvent(5848, 2, "MalginBarleybrew_OnLeaveCombat")
RegisterUnitEvent(5848, 3, "MalginBarleybrew_OnKilledTarget")
RegisterUnitEvent(5848, 4, "MalginBarleybrew_OnDied")