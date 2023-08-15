--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CentipaarSandreaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("CentipaarSandreaver_ArcingSmash", 5000, 0)
	Unit:RegisterEvent("CentipaarSandreaver_Thrash", 6000, 0)
end

function CentipaarSandreaver_ArcingSmash(Unit, Event) 
	Unit:CastSpell(8374) 
end

function CentipaarSandreaver_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function CentipaarSandreaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CentipaarSandreaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CentipaarSandreaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5460, 1, "CentipaarSandreaver_OnCombat")
RegisterUnitEvent(5460, 2, "CentipaarSandreaver_OnLeaveCombat")
RegisterUnitEvent(5460, 3, "CentipaarSandreaver_OnKilledTarget")
RegisterUnitEvent(5460, 4, "CentipaarSandreaver_OnDied")