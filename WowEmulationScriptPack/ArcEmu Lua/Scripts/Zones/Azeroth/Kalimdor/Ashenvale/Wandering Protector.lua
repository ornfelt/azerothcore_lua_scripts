--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WanderingProtector_OnCombat(Unit, Event)
	Unit:RegisterEvent("WanderingProtector_EntanglingRoots", 10000, 0)
	Unit:RegisterEvent("WanderingProtector_WarStomp", 6000, 0)
end

function WanderingProtector_EntanglingRoots(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11922, 	pUnit:GetMainTank()) 
end

function WanderingProtector_WarStomp(pUnit, Event) 
	pUnit:CastSpell(45) 
end

function WanderingProtector_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WanderingProtector_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12836, 1, "WanderingProtector_OnCombat")
RegisterUnitEvent(12836, 2, "WanderingProtector_OnLeaveCombat")
RegisterUnitEvent(12836, 4, "WanderingProtector_OnDied")