--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarsongShaman_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarsongShaman_Bloodlust", 2000, 2)
	Unit:RegisterEvent("WarsongShaman_LightningBolt", 13000, 0)
end

function WarsongShaman_Bloodlust(pUnit, Event) 
	pUnit:CastSpell(6742) 
end

function WarsongShaman_LightningBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20805, 	pUnit:GetMainTank()) 
end

function WarsongShaman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarsongShaman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11683, 1, "WarsongShaman_OnCombat")
RegisterUnitEvent(11683, 2, "WarsongShaman_OnLeaveCombat")
RegisterUnitEvent(11683, 4, "WarsongShaman_OnDied")