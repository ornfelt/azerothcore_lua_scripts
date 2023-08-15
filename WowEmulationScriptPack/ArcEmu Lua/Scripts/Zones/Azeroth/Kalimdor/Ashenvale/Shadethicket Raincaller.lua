--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShadethicketRaincaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("ShadethicketRaincaller_LightningBolt", 8000, 0)
	Unit:RegisterEvent("ShadethicketRaincaller_LightningCloud", 10000, 0)
end

function ShadethicketRaincaller_LightningBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9532, 	pUnit:GetMainTank()) 
end

function ShadethicketRaincaller_LightningCloud(pUnit, Event) 
	pUnit:CastSpell(6535) 
end

function ShadethicketRaincaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ShadethicketRaincaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3783, 1, "ShadethicketRaincaller_OnCombat")
RegisterUnitEvent(3783, 2, "ShadethicketRaincaller_OnLeaveCombat")
RegisterUnitEvent(3783, 4, "ShadethicketRaincaller_OnDied")