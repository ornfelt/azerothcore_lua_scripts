--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BaeldunOfficer_OnCombat(Unit, Event)
	Unit:RegisterEvent("BaeldunOfficer_NimbleReflexes", 10000, 0)
	Unit:RegisterEvent("BaeldunOfficer_Thrash", 5000, 0)
end

function BaeldunOfficer_NimbleReflexes(Unit, Event) 
	Unit:CastSpell(6264) 
end

function BaeldunOfficer_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function BaeldunOfficer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BaeldunOfficer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BaeldunOfficer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3378, 1, "BaeldunOfficer_OnCombat")
RegisterUnitEvent(3378, 2, "BaeldunOfficer_OnLeaveCombat")
RegisterUnitEvent(3378, 3, "BaeldunOfficer_OnKilledTarget")
RegisterUnitEvent(3378, 4, "BaeldunOfficer_OnDied")