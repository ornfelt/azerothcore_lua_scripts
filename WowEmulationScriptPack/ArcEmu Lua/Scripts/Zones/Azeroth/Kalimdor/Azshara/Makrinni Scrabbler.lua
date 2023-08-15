--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MakrinniScrabbler_OnCombat(Unit, Event)
	Unit:RegisterEvent("MakrinniScrabbler_Frostbolt", 8000, 0)
	Unit:RegisterEvent("MakrinniScrabbler_Heal", 14000, 0)
end

function MakrinniScrabbler_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20822, 	pUnit:GetMainTank()) 
end

function MakrinniScrabbler_Heal(pUnit, Event) 
	pUnit:CastSpell(11642) 
end

function MakrinniScrabbler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MakrinniScrabbler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6370, 1, "MakrinniScrabbler_OnCombat")
RegisterUnitEvent(6370, 2, "MakrinniScrabbler_OnLeaveCombat")
RegisterUnitEvent(6370, 4, "MakrinniScrabbler_OnDied")