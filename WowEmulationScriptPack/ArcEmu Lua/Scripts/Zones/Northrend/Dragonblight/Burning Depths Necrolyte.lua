--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningDepthsNecrolyte_OnCombat(Unit, Event)
Unit:RegisterEvent("BurningDepthsNecrolyte_DestructiveStrike", 6000, 0)
Unit:RegisterEvent("BurningDepthsNecrolyte_ObsidianEssence", 2000, 1)
end

function BurningDepthsNecrolyte_DestructiveStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(51430, Unit:GetMainTank()) 
end

function BurningDepthsNecrolyte_ObsidianEssence(Unit, Event) 
Unit:CastSpell(48616) 
end

function BurningDepthsNecrolyte_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BurningDepthsNecrolyte_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BurningDepthsNecrolyte_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27356, 1, "BurningDepthsNecrolyte_OnCombat")
RegisterUnitEvent(27356, 2, "BurningDepthsNecrolyte_OnLeaveCombat")
RegisterUnitEvent(27356, 3, "BurningDepthsNecrolyte_OnKilledTarget")
RegisterUnitEvent(27356, 4, "BurningDepthsNecrolyte_OnDied")