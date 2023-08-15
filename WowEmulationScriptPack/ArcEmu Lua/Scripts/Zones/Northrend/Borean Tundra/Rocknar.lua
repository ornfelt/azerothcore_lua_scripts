--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Rocknar_OnCombat(Unit, Event)
Unit:RegisterEvent("Rocknar_HardenSkin", 2000, 1)
Unit:RegisterEvent("Rocknar_IceSpike", 8000, 0)
end

function Rocknar_HardenSkin(Unit, Event) 
Unit:CastSpell(22693) 
end

function Rocknar_IceSpike(Unit, Event) 
Unit:FullCastSpellOnTarget(50094, Unit:GetMainTank()) 
end

function Rocknar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Rocknar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Rocknar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25514, 1, "Rocknar_OnCombat")
RegisterUnitEvent(25514, 2, "Rocknar_OnLeaveCombat")
RegisterUnitEvent(25514, 3, "Rocknar_OnKilledTarget")
RegisterUnitEvent(25514, 4, "Rocknar_OnDied")