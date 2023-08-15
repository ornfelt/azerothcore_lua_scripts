--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WarlordKrellian_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarlordKrellian_DemoralizingRoar", 8000, 0)
	Unit:RegisterEvent("WarlordKrellian_Strike", 6000, 0)
end

function WarlordKrellian_DemoralizingRoar(pUnit, Event) 
	pUnit:CastSpell(10968) 
end

function WarlordKrellian_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function WarlordKrellian_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarlordKrellian_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8408, 1, "WarlordKrellian_OnCombat")
RegisterUnitEvent(8408, 2, "WarlordKrellian_OnLeaveCombat")
RegisterUnitEvent(8408, 4, "WarlordKrellian_OnDied")