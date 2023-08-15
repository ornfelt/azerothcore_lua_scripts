--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarsongGrunt_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarsongGrunt_Cleave", 8000, 0)
	Unit:RegisterEvent("WarsongGrunt_ShieldBash", 6000, 0)
end

function WarsongGrunt_Cleave(pUnit, Event) 
	pUnit:CastSpell(15496) 
end

function WarsongGrunt_ShieldBash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11972, 	pUnit:GetMainTank()) 
end

function WarsongGrunt_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarsongGrunt_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11682, 1, "WarsongGrunt_OnCombat")
RegisterUnitEvent(11682, 2, "WarsongGrunt_OnLeaveCombat")
RegisterUnitEvent(11682, 4, "WarsongGrunt_OnDied")