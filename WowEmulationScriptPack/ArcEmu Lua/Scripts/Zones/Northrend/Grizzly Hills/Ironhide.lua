--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Ironhide_OnCombat(Unit, Event)
Unit:RegisterEvent("Ironhide_Charge", 10000, 0)
Unit:RegisterEvent("Ironhide_Maul", 6000, 0)
Unit:RegisterEvent("Ironhide_Swipe", 5000, 0)
end

function Ironhide_Charge(Unit, Event) 
Unit:FullCastSpellOnTarget(32323, Unit:GetMainTank()) 
end

function Ironhide_Maul(Unit, Event) 
Unit:FullCastSpellOnTarget(34298, Unit:GetMainTank()) 
end

function Ironhide_Swipe(Unit, Event) 
Unit:FullCastSpellOnTarget(31279, Unit:GetMainTank()) 
end

function Ironhide_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Ironhide_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Ironhide_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27715, 1, "Ironhide_OnCombat")
RegisterUnitEvent(27715, 2, "Ironhide_OnLeaveCombat")
RegisterUnitEvent(27715, 3, "Ironhide_OnKilledTarget")
RegisterUnitEvent(27715, 4, "Ironhide_OnDied")