--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DragonblightMageHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonblightMageHunter_ArcaneReflection", 9000, 1)
Unit:RegisterEvent("DragonblightMageHunter_FireReflection", 8000, 1)
Unit:RegisterEvent("DragonblightMageHunter_FrostReflection", 7000, 1)
Unit:RegisterEvent("DragonblightMageHunter_ShadowReflection", 6000, 1)
end

function DragonblightMageHunter_ArcaneReflection(Unit, Event) 
Unit:CastSpell(51766) 
end

function DragonblightMageHunter_FireReflection(Unit, Event) 
Unit:CastSpell(51758) 
end

function DragonblightMageHunter_FrostReflection(Unit, Event) 
Unit:CastSpell(51763) 
end

function DragonblightMageHunter_ShadowReflection(Unit, Event) 
Unit:CastSpell(51764) 
end

function DragonblightMageHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonblightMageHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonblightMageHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26280, 1, "DragonblightMageHunter_OnCombat")
RegisterUnitEvent(26280, 2, "DragonblightMageHunter_OnLeaveCombat")
RegisterUnitEvent(26280, 3, "DragonblightMageHunter_OnKilledTarget")
RegisterUnitEvent(26280, 4, "DragonblightMageHunter_OnDied")