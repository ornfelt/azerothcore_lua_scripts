--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HighPriestTaletKha_OnCombat(Unit, Event)
Unit:RegisterEvent("HighPriestTaletKha_MindBlast", 6000, 0)
Unit:RegisterEvent("HighPriestTaletKha_Renew", 13000, 0)
end

function HighPriestTaletKha_MindBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(15587, Unit:GetMainTank()) 
end

function HighPriestTaletKha_Renew(Unit, Event) 
Unit:CastSpell(11640) 
end

function HighPriestTaletKha_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighPriestTaletKha_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighPriestTaletKha_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26073, 1, "HighPriestTaletKha_OnCombat")
RegisterUnitEvent(26073, 2, "HighPriestTaletKha_OnLeaveCombat")
RegisterUnitEvent(26073, 3, "HighPriestTaletKha_OnKilledTarget")
RegisterUnitEvent(26073, 4, "HighPriestTaletKha_OnDied")