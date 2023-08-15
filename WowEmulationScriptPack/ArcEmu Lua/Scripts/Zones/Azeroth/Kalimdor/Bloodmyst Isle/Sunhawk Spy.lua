--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SunhawkSpy_OnCombat(Unit, Event)
	Unit:RegisterEvent("SunhawkSpy_DemoralizingShout", 2000, 0)
	Unit:RegisterEvent("SunhawkSpy_HeroicStrike", 6000, 0)
	Unit:RegisterEvent("SunhawkSpy_MarkoftheSunhawk", 7500, 0)
end

function SunhawkSpy_DemoralizingShout(pUnit, Event) 
	pUnit:CastSpell(13730) 
end

function SunhawkSpy_HeroicStrike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31827, 	pUnit:GetMainTank()) 
end

function SunhawkSpy_MarkoftheSunhawk(pUnit, Event) 
	pUnit:CastSpell(31734) 
end

function SunhawkSpy_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SunhawkSpy_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17604, 1, "SunhawkSpy_OnCombat")
RegisterUnitEvent(17604, 2, "SunhawkSpy_OnLeaveCombat")
RegisterUnitEvent(17604, 4, "SunhawkSpy_OnDied")