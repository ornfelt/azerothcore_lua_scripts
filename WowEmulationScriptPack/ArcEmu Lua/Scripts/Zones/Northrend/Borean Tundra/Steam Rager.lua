--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SteamRager_OnCombat(Unit, Event)
Unit:RegisterEvent("SteamRager_SteamBlast", 8000, 0)
end

function SteamRager_SteamBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(50375, Unit:GetMainTank()) 
end

function SteamRager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SteamRager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SteamRager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24601, 1, "SteamRager_OnCombat")
RegisterUnitEvent(24601, 2, "SteamRager_OnLeaveCombat")
RegisterUnitEvent(24601, 3, "SteamRager_OnKilledTarget")
RegisterUnitEvent(24601, 4, "SteamRager_OnDied")