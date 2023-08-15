--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Sironas_OnCombat(Unit, Event)
	Unit:RegisterEvent("Sironas_CurseofBlood", 2000, 1)
	Unit:RegisterEvent("Sironas_CurseofTongues", 10000, 0)
	Unit:RegisterEvent("Sironas_Immolate", 6000, 1)
	Unit:RegisterEvent("Sironas_ShadowCleave", 9000, 0)
	Unit:RegisterEvent("Sironas_Uppercut", 7500, 0)
end

function Sironas_CurseofBlood(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8282, 	pUnit:GetMainTank()) 
end

function Sironas_CurseofTongues(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13338, 	pUnit:GetMainTank()) 
end

function Sironas_Immolate(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12742, 	pUnit:GetMainTank()) 
end

function Sironas_ShadowCleave(pUnit, Event) 
	pUnit:CastSpell(31629) 
end

function Sironas_Uppercut(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10966, 	pUnit:GetMainTank()) 
end

function Sironas_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Sironas_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17678, 1, "Sironas_OnCombat")
RegisterUnitEvent(17678, 2, "Sironas_OnLeaveCombat")
RegisterUnitEvent(17678, 4, "Sironas_OnDied")