--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DunemaulOgre_OnCombat(Unit, Event)
	Unit:RegisterEvent("DunemaulOgre_BattleStance", 1000, 1)
	Unit:RegisterEvent("DunemaulOgre_HeroicStrike", 4000, 0)
end

function DunemaulOgre_BattleStance(Unit, Event) 
	Unit:CastSpell(7165) 
end

function DunemaulOgre_HeroicStrike(Unit, Event) 
	Unit:FullCastSpellOnTarget(25710, 	Unit:GetMainTank()) 
end

function DunemaulOgre_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DunemaulOgre_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DunemaulOgre_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5471, 1, "DunemaulOgre_OnCombat")
RegisterUnitEvent(5471, 2, "DunemaulOgre_OnLeaveCombat")
RegisterUnitEvent(5471, 3, "DunemaulOgre_OnKilledTarget")
RegisterUnitEvent(5471, 4, "DunemaulOgre_OnDied")