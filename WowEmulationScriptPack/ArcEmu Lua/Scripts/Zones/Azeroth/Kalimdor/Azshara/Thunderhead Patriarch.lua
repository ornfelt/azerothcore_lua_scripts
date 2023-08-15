--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThunderheadPatriarch_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderheadPatriarch_Shock", 6000, 0)
	Unit:RegisterEvent("ThunderheadPatriarch_RushingCharge", 8000, 0)
end

function ThunderheadPatriarch_Shock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12553, 	pUnit:GetMainTank()) 
end

function ThunderheadPatriarch_RushingCharge(pUnit, Event) 
	pUnit:CastSpell(6268) 
end

function ThunderheadPatriarch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderheadPatriarch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6379, 1, "ThunderheadPatriarch_OnCombat")
RegisterUnitEvent(6379, 2, "ThunderheadPatriarch_OnLeaveCombat")
RegisterUnitEvent(6379, 4, "ThunderheadPatriarch_OnDied")