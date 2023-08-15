--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AxxarienTrickster_OnCombat(Unit, Event)
	Unit:RegisterEvent("AxxarienTrickster_Eviscerate", 10000, 0)
end

function AxxarienTrickster_Eviscerate(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15691, 	pUnit:GetMainTank()) 
end

function AxxarienTrickster_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AxxarienTrickster_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17341, 1, "AxxarienTrickster_OnCombat")
RegisterUnitEvent(17341, 2, "AxxarienTrickster_OnLeaveCombat")
RegisterUnitEvent(17341, 4, "AxxarienTrickster_OnDied")