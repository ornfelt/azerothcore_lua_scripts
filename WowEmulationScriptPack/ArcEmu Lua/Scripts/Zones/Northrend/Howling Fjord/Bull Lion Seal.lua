--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BullLionSeal_OnCombat(Unit, Event)
Unit:RegisterEvent("BullLionSeal_FlipperThwack", 6000, 0)
end

function BullLionSeal_FlipperThwack(Unit, Event) 
Unit:FullCastSpellOnTarget(50169, Unit:GetMainTank()) 
end

function BullLionSeal_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BullLionSeal_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BullLionSeal_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26866, 1, "BullLionSeal_OnCombat")
RegisterUnitEvent(26866, 2, "BullLionSeal_OnLeaveCombat")
RegisterUnitEvent(26866, 3, "BullLionSeal_OnKilledTarget")
RegisterUnitEvent(26866, 4, "BullLionSeal_OnDied")