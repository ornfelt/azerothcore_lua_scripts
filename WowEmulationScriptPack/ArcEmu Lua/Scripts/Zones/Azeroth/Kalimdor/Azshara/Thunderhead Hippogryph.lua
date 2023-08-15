--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThunderheadHippogryph_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderheadHippogryph_Shock", 6000, 0)
end

function ThunderheadHippogryph_Shock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12553, 	pUnit:GetMainTank()) 
end

function ThunderheadHippogryph_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderheadHippogryph_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6375, 1, "ThunderheadHippogryph_OnCombat")
RegisterUnitEvent(6375, 2, "ThunderheadHippogryph_OnLeaveCombat")
RegisterUnitEvent(6375, 4, "ThunderheadHippogryph_OnDied")