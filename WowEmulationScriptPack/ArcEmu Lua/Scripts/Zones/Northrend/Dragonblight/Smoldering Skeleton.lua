--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SmolderingSkeleton_OnCombat(Unit, Event)
Unit:RegisterEvent("SmolderingSkeleton_SmolderingBones", 8000, 0)
end

function SmolderingSkeleton_SmolderingBones(Unit, Event) 
Unit:CastSpell(51437) 
end

function SmolderingSkeleton_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SmolderingSkeleton_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SmolderingSkeleton_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27360, 1, "SmolderingSkeleton_OnCombat")
RegisterUnitEvent(27360, 2, "SmolderingSkeleton_OnLeaveCombat")
RegisterUnitEvent(27360, 3, "SmolderingSkeleton_OnKilledTarget")
RegisterUnitEvent(27360, 4, "SmolderingSkeleton_OnDied")