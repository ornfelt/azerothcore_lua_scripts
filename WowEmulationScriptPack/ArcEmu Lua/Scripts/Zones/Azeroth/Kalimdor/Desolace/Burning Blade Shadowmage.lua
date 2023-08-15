--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningBladeShadowmage_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeShadowmage_ShadowBolt", 8000, 0)
	Unit:RegisterEvent("BurningBladeShadowmage_ShadowShell", 10000, 0)
end

function BurningBladeShadowmage_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20816, 	Unit:GetMainTank()) 
end

function BurningBladeShadowmage_ShadowShell(Unit, Event) 
	Unit:CastSpell(9657) 
end

function BurningBladeShadowmage_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeShadowmage_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4667, 1, "BurningBladeShadowmage_OnCombat")
RegisterUnitEvent(4667, 2, "BurningBladeShadowmage_OnLeaveCombat")
RegisterUnitEvent(4667, 4, "BurningBladeShadowmage_OnDied")