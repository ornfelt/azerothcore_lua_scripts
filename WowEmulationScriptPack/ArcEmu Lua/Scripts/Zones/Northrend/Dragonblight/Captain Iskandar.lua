--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CaptainIskandar_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainIskandar_Cleave", 6000, 0)
Unit:RegisterEvent("CaptainIskandar_MortalStrike", 8000, 0)
Unit:RegisterEvent("CaptainIskandar_Whirlwind", 7000, 0)
end

function CaptainIskandar_Cleave(Unit, Event) 
Unit:CastSpell(42724) 
end

function CaptainIskandar_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(15708, Unit:GetMainTank()) 
end

function CaptainIskandar_Whirlwind(Unit, Event) 
Unit:CastSpell(38619) 
end

function CaptainIskandar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainIskandar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainIskandar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27657, 1, "CaptainIskandar_OnCombat")
RegisterUnitEvent(27657, 2, "CaptainIskandar_OnLeaveCombat")
RegisterUnitEvent(27657, 3, "CaptainIskandar_OnKilledTarget")
RegisterUnitEvent(27657, 4, "CaptainIskandar_OnDied")