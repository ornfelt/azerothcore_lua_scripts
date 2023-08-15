--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CampWinterhoofBrave_OnCombat(Unit, Event)
Unit:RegisterEvent("CampWinterhoofBrave_Cleave", 9000, 0)
Unit:RegisterEvent("CampWinterhoofBrave_Shoot", 6000, 0)
end

function CampWinterhoofBrave_Cleave(Unit, Event) 
Unit:CastSpell(40505) 
end

function CampWinterhoofBrave_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(23337, Unit:GetMainTank()) 
end

function CampWinterhoofBrave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CampWinterhoofBrave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CampWinterhoofBrave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24031, 1, "CampWinterhoofBrave_OnCombat")
RegisterUnitEvent(24031, 2, "CampWinterhoofBrave_OnLeaveCombat")
RegisterUnitEvent(24031, 3, "CampWinterhoofBrave_OnKilledTarget")
RegisterUnitEvent(24031, 4, "CampWinterhoofBrave_OnDied")