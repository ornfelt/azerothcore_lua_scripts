--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BatteredDrakkariBerserker_OnCombat(Unit, Event)
Unit:RegisterEvent("BatteredDrakkariBerserker_Enrage", 10000, 1)
Unit:RegisterEvent("BatteredDrakkariBerserker_Knockdown", 6000, 0)
end

function BatteredDrakkariBerserker_Enrage(Unit, Event) 
Unit:CastSpell(50420) 
end

function BatteredDrakkariBerserker_Knockdown(Unit, Event) 
Unit:FullCastSpellOnTarget(37592, Unit:GetMainTank()) 
end

function BatteredDrakkariBerserker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BatteredDrakkariBerserker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BatteredDrakkariBerserker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26943, 1, "BatteredDrakkariBerserker_OnCombat")
RegisterUnitEvent(26943, 2, "BatteredDrakkariBerserker_OnLeaveCombat")
RegisterUnitEvent(26943, 3, "BatteredDrakkariBerserker_OnKilledTarget")
RegisterUnitEvent(26943, 4, "BatteredDrakkariBerserker_OnDied")