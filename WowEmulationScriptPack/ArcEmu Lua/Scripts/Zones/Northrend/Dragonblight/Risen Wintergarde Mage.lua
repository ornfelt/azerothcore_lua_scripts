--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RisenWintergardeMage_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenWintergardeMage_FireBlast", 6000, 0)
Unit:RegisterEvent("RisenWintergardeMage_Frostbolt", 7000, 0)
end

function RisenWintergardeMage_FireBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(13339, Unit:GetMainTank()) 
end

function RisenWintergardeMage_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9672, Unit:GetMainTank()) 
end

function RisenWintergardeMage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenWintergardeMage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenWintergardeMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27283, 1, "RisenWintergardeMage_OnCombat")
RegisterUnitEvent(27283, 2, "RisenWintergardeMage_OnLeaveCombat")
RegisterUnitEvent(27283, 3, "RisenWintergardeMage_OnKilledTarget")
RegisterUnitEvent(27283, 4, "RisenWintergardeMage_OnDied")