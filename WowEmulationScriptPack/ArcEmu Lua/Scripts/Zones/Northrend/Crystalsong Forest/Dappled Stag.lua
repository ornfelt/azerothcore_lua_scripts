--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DappledStag_OnCombat(Unit, Event)
Unit:RegisterEvent("DappledStag_Butt", 8000, 0)
end

function DappledStag_Butt(Unit, Event) 
Unit:FullCastSpellOnTarget(59110, Unit:GetMainTank()) 
end

function DappledStag_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DappledStag_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DappledStag_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31236, 1, "DappledStag_OnCombat")
RegisterUnitEvent(31236, 2, "DappledStag_OnLeaveCombat")
RegisterUnitEvent(31236, 3, "DappledStag_OnKilledTarget")
RegisterUnitEvent(31236, 4, "DappledStag_OnDied")