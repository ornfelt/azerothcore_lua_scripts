--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CaptainDrayzen_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainDrayzen_Cleave", 6000, 0)
Unit:RegisterEvent("CaptainDrayzen_MortalStrike", 8000, 0)
Unit:RegisterEvent("CaptainDrayzen_Whirlwind", 7000, 0)
end

function CaptainDrayzen_Cleave(Unit, Event) 
Unit:CastSpell(42724) 
end

function CaptainDrayzen_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(15708, Unit:GetMainTank()) 
end

function CaptainDrayzen_Whirlwind(Unit, Event) 
Unit:CastSpell(38619) 
end

function CaptainDrayzen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainDrayzen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainDrayzen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27751, 1, "CaptainDrayzen_OnCombat")
RegisterUnitEvent(27751, 2, "CaptainDrayzen_OnLeaveCombat")
RegisterUnitEvent(27751, 3, "CaptainDrayzen_OnKilledTarget")
RegisterUnitEvent(27751, 4, "CaptainDrayzen_OnDied")