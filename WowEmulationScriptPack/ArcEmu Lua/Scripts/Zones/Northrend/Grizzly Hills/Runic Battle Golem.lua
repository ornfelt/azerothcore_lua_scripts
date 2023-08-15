--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RunicBattleGolem_OnCombat(Unit, Event)
Unit:RegisterEvent("RunicBattleGolem_BattleRunes", 7000, 0)
end

function RunicBattleGolem_BattleRunes(Unit, Event) 
Unit:CastSpell(52630) 
end

function RunicBattleGolem_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunicBattleGolem_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunicBattleGolem_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26284, 1, "RunicBattleGolem_OnCombat")
RegisterUnitEvent(26284, 2, "RunicBattleGolem_OnLeaveCombat")
RegisterUnitEvent(26284, 3, "RunicBattleGolem_OnKilledTarget")
RegisterUnitEvent(26284, 4, "RunicBattleGolem_OnDied")