--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SyreiantheBonecarver_OnCombat(Unit, Event)
Unit:RegisterEvent("SyreiantheBonecarver_FrostArrow", 7000, 0)
Unit:RegisterEvent("SyreiantheBonecarver_ImprovedWingClip", 13000, 0)
Unit:RegisterEvent("SyreiantheBonecarver_Shoot", 6000, 0)
end

function SyreiantheBonecarver_FrostArrow(Unit, Event) 
Unit:FullCastSpellOnTarget(38952, Unit:GetMainTank()) 
end

function SyreiantheBonecarver_ImprovedWingClip(Unit, Event) 
Unit:FullCastSpellOnTarget(47168, Unit:GetMainTank()) 
end

function SyreiantheBonecarver_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(50092, Unit:GetMainTank()) 
end

function SyreiantheBonecarver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SyreiantheBonecarver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SyreiantheBonecarver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32438, 1, "SyreiantheBonecarver_OnCombat")
RegisterUnitEvent(32438, 2, "SyreiantheBonecarver_OnLeaveCombat")
RegisterUnitEvent(32438, 3, "SyreiantheBonecarver_OnKilledTarget")
RegisterUnitEvent(32438, 4, "SyreiantheBonecarver_OnDied")