--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AchelliostheBanished_OnCombat(Unit, Event)
	UnitRegisterEvent("AchelliostheBanished_BattleShout", 1000, 1)
end

function AchelliostheBanished_BattleShout(Unit, Event) 
	UnitCastSpell(6192) 
end

function AchelliostheBanished_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function AchelliostheBanished_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function AchelliostheBanished_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5933, 1, "AchelliostheBanished_OnCombat")
RegisterUnitEvent(5933, 2, "AchelliostheBanished_OnLeaveCombat")
RegisterUnitEvent(5933, 3, "AchelliostheBanished_OnKilledTarget")
RegisterUnitEvent(5933, 4, "AchelliostheBanished_OnDied")