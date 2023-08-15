--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TheramorePreserver_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheramorePreserver_Smite", 8000, 0)
	Unit:RegisterEvent("TheramorePreserver_LesserHeal", 12000, 0)
	Unit:RegisterEvent("TheramorePreserver_Renew", 5000, 1)
end

function TheramorePreserver_Smite(Unit, Event) 
	Unit:FullCastSpellOnTarget(9734, 	Unit:GetMainTank()) 
end

function TheramorePreserver_LesserHeal(Unit, Event) 
	Unit:CastSpell(2052) 
end

function TheramorePreserver_Renew(Unit, Event) 
	Unit:CastSpell(6074) 
end

function TheramorePreserver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheramorePreserver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TheramorePreserver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3386, 1, "TheramorePreserver_OnCombat")
RegisterUnitEvent(3386, 2, "TheramorePreserver_OnLeaveCombat")
RegisterUnitEvent(3386, 3, "TheramorePreserver_OnKilledTarget")
RegisterUnitEvent(3386, 4, "TheramorePreserver_OnDied")