--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AxxarienShadowstalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("AxxarienShadowstalker_Corruption", 8000, 0)
end

function AxxarienShadowstalker_Corruption(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(21068, 	pUnit:GetMainTank()) 
end

function AxxarienShadowstalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AxxarienShadowstalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17340, 1, "AxxarienShadowstalker_OnCombat")
RegisterUnitEvent(17340, 2, "AxxarienShadowstalker_OnLeaveCombat")
RegisterUnitEvent(17340, 4, "AxxarienShadowstalker_OnDied")