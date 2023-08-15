--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SpitelashSiren_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashSiren_Shoot", 6000, 0)
	Unit:RegisterEvent("SpitelashSiren_Renew", 10000, 0)
	Unit:RegisterEvent("SpitelashSiren_FrostNova", 8000, 0)
	Unit:RegisterEvent("SpitelashSiren_FrostShot", 9000, 0)
end

function SpitelashSiren_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function SpitelashSiren_Renew(pUnit, Event) 
	pUnit:CastSpell(11640) 
end

function SpitelashSiren_FrostNova(pUnit, Event) 
	pUnit:CastSpell(11831) 
end

function SpitelashSiren_FrostShot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12551, 	pUnit:GetMainTank()) 
end

function SpitelashSiren_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashSiren_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6195, 1, "SpitelashSiren_OnCombat")
RegisterUnitEvent(6195, 2, "SpitelashSiren_OnLeaveCombat")
RegisterUnitEvent(6195, 4, "SpitelashSiren_OnDied")