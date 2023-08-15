--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DesertRager_OnCombat(Unit, Event)
	Unit:RegisterEvent("DesertRager_EarthShock", 8000, 0)
	Unit:RegisterEvent("DesertRager_Enrage", 12000, 1)
end

function DesertRager_EarthShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(13728, 	Unit:GetMainTank()) 
end

function DesertRager_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function DesertRager_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DesertRager_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DesertRager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11747, 1, "DesertRager_OnCombat")
RegisterUnitEvent(11747, 2, "DesertRager_OnLeaveCombat")
RegisterUnitEvent(11747, 3, "DesertRager_OnKilledTarget")
RegisterUnitEvent(11747, 4, "DesertRager_OnDied")