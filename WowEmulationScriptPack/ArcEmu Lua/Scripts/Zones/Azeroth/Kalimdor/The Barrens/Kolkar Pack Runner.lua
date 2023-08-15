--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarPackRunner_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarPackRunner_BattleShout", 4000, 1)
end

function KolkarPackRunner_BattleShout(Unit, Event) 
	Unit:CastSpell(9128) 
end

function KolkarPackRunner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarPackRunner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarPackRunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3274, 1, "KolkarPackRunner_OnCombat")
RegisterUnitEvent(3274, 2, "KolkarPackRunner_OnLeaveCombat")
RegisterUnitEvent(3274, 3, "KolkarPackRunner_OnKilledTarget")
RegisterUnitEvent(3274, 4, "KolkarPackRunner_OnDied")