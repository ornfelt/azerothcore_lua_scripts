--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function KarentheCuller_OnCombat(Unit, Event)
Unit:RegisterEvent("KarentheCuller_Cleave", 6000, 0)
Unit:RegisterEvent("KarentheCuller_Intercept", 1000, 1)
Unit:RegisterEvent("KarentheCuller_Whirlwind", 9000, 0)
end

function KarentheCuller_Cleave(Unit, Event) 
Unit:CastSpell(42724) 
end

function KarentheCuller_Intercept(Unit, Event) 
Unit:FullCastSpellOnTarget(27577, Unit:GetMainTank()) 
end

function KarentheCuller_Whirlwind(Unit, Event) 
Unit:CastSpell(48281) 
end

function KarentheCuller_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KarentheCuller_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KarentheCuller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25803, 1, "KarentheCuller_OnCombat")
RegisterUnitEvent(25803, 2, "KarentheCuller_OnLeaveCombat")
RegisterUnitEvent(25803, 3, "KarentheCuller_OnKilledTarget")
RegisterUnitEvent(25803, 4, "KarentheCuller_OnDied")