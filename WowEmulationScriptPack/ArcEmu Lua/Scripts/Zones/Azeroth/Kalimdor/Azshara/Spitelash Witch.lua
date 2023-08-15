--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SpitelashWitch_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashWitch_ForkedLightning", 5000, 0)
	Unit:RegisterEvent("SpitelashWitch_LightningShield", 9000, 0)
	Unit:RegisterEvent("SpitelashWitch_Frostbolt", 7000, 0)
end

function SpitelashWitch_ForkedLightning(pUnit, Event) 
	pUnit:CastSpell(20299) 
end

function SpitelashWitch_LightningShield(pUnit, Event) 
	pUnit:CastSpell(12550) 
end

function SpitelashWitch_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20297, 	pUnit:GetMainTank()) 
end

function SpitelashWitch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashWitch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12205, 1, "SpitelashWitch_OnCombat")
RegisterUnitEvent(12205, 2, "SpitelashWitch_OnLeaveCombat")
RegisterUnitEvent(12205, 4, "SpitelashWitch_OnDied")