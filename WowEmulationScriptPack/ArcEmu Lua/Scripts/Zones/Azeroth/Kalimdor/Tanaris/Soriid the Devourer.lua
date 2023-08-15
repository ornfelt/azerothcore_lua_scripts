--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SoriidtheDevourer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SoriidtheDevourer_PierceArmor", 25000, 0)
	Unit:RegisterEvent("SoriidtheDevourer_Rend", 20000, 0)
end

function SoriidtheDevourer_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(12097, 	Unit:GetMainTank()) 
end

function SoriidtheDevourer_Rend(Unit, Event) 
	Unit:FullCastSpellOnTarget(13445, 	Unit:GetMainTank()) 
end

function SoriidtheDevourer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SoriidtheDevourer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SoriidtheDevourer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8204, 1, "SoriidtheDevourer_OnCombat")
RegisterUnitEvent(8204, 2, "SoriidtheDevourer_OnLeaveCombat")
RegisterUnitEvent(8204, 3, "SoriidtheDevourer_OnKilledTarget")
RegisterUnitEvent(8204, 4, "SoriidtheDevourer_OnDied")