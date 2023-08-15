--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EmeraldSkytalon_OnCombat(Unit, Event)
Unit:RegisterEvent("EmeraldSkytalon_Swoop", 8000, 0)
Unit:RegisterEvent("EmeraldSkytalon_TalonStrike", 6000, 0)
end

function EmeraldSkytalon_Swoop(Unit, Event) 
Unit:CastSpell(51919) 
end

function EmeraldSkytalon_TalonStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(32909, Unit:GetMainTank()) 
end

function EmeraldSkytalon_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmeraldSkytalon_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmeraldSkytalon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27244, 1, "EmeraldSkytalon_OnCombat")
RegisterUnitEvent(27244, 2, "EmeraldSkytalon_OnLeaveCombat")
RegisterUnitEvent(27244, 3, "EmeraldSkytalon_OnKilledTarget")
RegisterUnitEvent(27244, 4, "EmeraldSkytalon_OnDied")