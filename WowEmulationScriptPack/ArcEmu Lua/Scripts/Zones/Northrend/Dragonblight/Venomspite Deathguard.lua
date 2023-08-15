--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function VenomspiteDeathguard_OnCombat(Unit, Event)
Unit:RegisterEvent("VenomspiteDeathguard_Revenge", 5000, 0)
Unit:RegisterEvent("VenomspiteDeathguard_ShieldBlock", 6000, 0)
end

function VenomspiteDeathguard_Revenge(Unit, Event) 
Unit:FullCastSpellOnTarget(12170, Unit:GetMainTank()) 
end

function VenomspiteDeathguard_ShieldBlock(Unit, Event) 
Unit:CastSpell(12169) 
end

function VenomspiteDeathguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VenomspiteDeathguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VenomspiteDeathguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27035, 1, "VenomspiteDeathguard_OnCombat")
RegisterUnitEvent(27035, 2, "VenomspiteDeathguard_OnLeaveCombat")
RegisterUnitEvent(27035, 3, "VenomspiteDeathguard_OnKilledTarget")
RegisterUnitEvent(27035, 4, "VenomspiteDeathguard_OnDied")