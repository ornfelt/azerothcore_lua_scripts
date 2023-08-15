--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SunhawkReclaimer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SunhawkReclaimer_Fireball", 8000, 0)
	Unit:RegisterEvent("SunhawkReclaimer_FrostArmor", 2000, 1)
	Unit:RegisterEvent("SunhawkReclaimer_MarkoftheSunhawk", 7500, 0)
end

function SunhawkReclaimer_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(19816, 	pUnit:GetMainTank()) 
end

function SunhawkReclaimer_FrostArmor(pUnit, Event) 
	pUnit:CastSpell(12544) 
end

function SunhawkReclaimer_MarkoftheSunhawk(pUnit, Event) 
	pUnit:CastSpell(31734) 
end

function SunhawkReclaimer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SunhawkReclaimer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17606, 1, "SunhawkReclaimer_OnCombat")
RegisterUnitEvent(17606, 2, "SunhawkReclaimer_OnLeaveCombat")
RegisterUnitEvent(17606, 4, "SunhawkReclaimer_OnDied")