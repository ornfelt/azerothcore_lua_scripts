--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThunderheadSkystormer_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderheadSkystormer_Shock", 6000, 0)
	Unit:RegisterEvent("ThunderheadSkystormer_LightningCloud", 10000, 0)
end

function ThunderheadSkystormer_Shock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12553, 	pUnit:GetMainTank()) 
end

function ThunderheadSkystormer_LightningCloud(pUnit, Event) 
	pUnit:CastSpell(6535) 
end

function ThunderheadSkystormer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderheadSkystormer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6378, 1, "ThunderheadSkystormer_OnCombat")
RegisterUnitEvent(6378, 2, "ThunderheadSkystormer_OnLeaveCombat")
RegisterUnitEvent(6378, 4, "ThunderheadSkystormer_OnDied")