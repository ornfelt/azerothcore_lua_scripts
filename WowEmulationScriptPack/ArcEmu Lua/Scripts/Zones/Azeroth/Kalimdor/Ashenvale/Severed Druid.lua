--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SeveredDruid_OnCombat(Unit, Event)
	Unit:RegisterEvent("SeveredDruid_Wrath", 6000, 0)
	Unit:RegisterEvent("SeveredDruid_Rejuvenation", 13000, 0)
end

function SeveredDruid_Wrath(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9739, 	pUnit:GetMainTank()) 
end

function SeveredDruid_Rejuvenation(pUnit, Event) 
	pUnit:CastSpell(1430) 
end

function SeveredDruid_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SeveredDruid_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3799, 1, "SeveredDruid_OnCombat")
RegisterUnitEvent(3799, 2, "SeveredDruid_OnLeaveCombat")
RegisterUnitEvent(3799, 4, "SeveredDruid_OnDied")