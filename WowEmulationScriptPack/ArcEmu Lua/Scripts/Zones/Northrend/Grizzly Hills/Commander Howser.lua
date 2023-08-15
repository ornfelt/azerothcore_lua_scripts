--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CommanderHowser_OnCombat(Unit, Event)
Unit:RegisterEvent("CommanderHowser_BerserkerCharge", 6000, 0)
Unit:RegisterEvent("CommanderHowser_Whirlwind", 8000, 0)
end

function CommanderHowser_BerserkerCharge(Unit, Event) 
Unit:FullCastSpellOnTarget(16636, Unit:GetMainTank()) 
end

function CommanderHowser_Whirlwind(Unit, Event) 
Unit:CastSpell(15589) 
end

function CommanderHowser_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CommanderHowser_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CommanderHowser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27759, 1, "CommanderHowser_OnCombat")
RegisterUnitEvent(27759, 2, "CommanderHowser_OnLeaveCombat")
RegisterUnitEvent(27759, 3, "CommanderHowser_OnKilledTarget")
RegisterUnitEvent(27759, 4, "CommanderHowser_OnDied")