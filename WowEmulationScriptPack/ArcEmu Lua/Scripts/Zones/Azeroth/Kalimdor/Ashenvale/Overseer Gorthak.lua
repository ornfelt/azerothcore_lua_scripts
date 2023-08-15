--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OverseerGorthak_OnCombat(Unit, Event)
	Unit:RegisterEvent("OverseerGorthak_Cleave", 8000, 0)
	Unit:RegisterEvent("OverseerGorthak_ShieldBash", 6000, 0)
end

function OverseerGorthak_Cleave(pUnit, Event) 
	pUnit:CastSpell(15496) 
end

function OverseerGorthak_ShieldBash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11972, 	pUnit:GetMainTank()) 
end

function OverseerGorthak_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function OverseerGorthak_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17304, 1, "OverseerGorthak_OnCombat")
RegisterUnitEvent(17304, 2, "OverseerGorthak_OnLeaveCombat")
RegisterUnitEvent(17304, 4, "OverseerGorthak_OnDied")