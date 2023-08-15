--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DeathsHeadCultist_OnCombat(Unit, Event)
	UnitRegisterEvent("DeathsHeadCultist_DeathDecay", 15000, 0)
	UnitRegisterEvent("DeathsHeadCultist_ShadowBolt", 8000, 0)
end

function DeathsHeadCultist_DeathDecay(Unit, Event) 
	UnitCastSpell(11433) 
end

function DeathsHeadCultist_ShadowBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(9613, 	UnitGetMainTank()) 
end

function DeathsHeadCultist_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DeathsHeadCultist_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DeathsHeadCultist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7872, 1, "DeathsHeadCultist_OnCombat")
RegisterUnitEvent(7872, 2, "DeathsHeadCultist_OnLeaveCombat")
RegisterUnitEvent(7872, 3, "DeathsHeadCultist_OnKilledTarget")
RegisterUnitEvent(7872, 4, "DeathsHeadCultist_OnDied")