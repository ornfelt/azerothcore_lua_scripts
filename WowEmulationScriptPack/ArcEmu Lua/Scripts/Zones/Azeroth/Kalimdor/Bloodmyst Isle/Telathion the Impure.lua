--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TelathiontheImpure_OnCombat(Unit, Event)
	Unit:RegisterEvent("TelathiontheImpure_ArcaneMissiles", 11000, 0)
	Unit:RegisterEvent("TelathiontheImpure_FireBlast", 10000, 0)
	Unit:RegisterEvent("TelathiontheImpure_FrostNova", 9000, 0)
	Unit:RegisterEvent("TelathiontheImpure_Frostbolt", 8000, 0)
end

function TelathiontheImpure_ArcaneMissiles(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15736, 	pUnit:GetMainTank()) 
end

function TelathiontheImpure_FireBlast(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13339, 	pUnit:GetMainTank()) 
end

function TelathiontheImpure_FrostNova(pUnit, Event) 
	pUnit:CastSpell(11831) 
end

function TelathiontheImpure_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, 	pUnit:GetMainTank()) 
end

function TelathiontheImpure_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TelathiontheImpure_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17359, 1, "TelathiontheImpure_OnCombat")
RegisterUnitEvent(17359, 2, "TelathiontheImpure_OnLeaveCombat")
RegisterUnitEvent(17359, 4, "TelathiontheImpure_OnDied")