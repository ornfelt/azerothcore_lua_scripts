--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NaxxramasShade_OnCombat(Unit, Event)
Unit:RegisterEvent("NaxxramasShade_BlinkStrike", 6000, 0)
Unit:RegisterEvent("NaxxramasShade_DarkStrike", 5500, 0)
end

function NaxxramasShade_BlinkStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(49961, Unit:GetMainTank()) 
end

function NaxxramasShade_DarkStrike(Unit, Event) 
Unit:CastSpell(38926) 
end

function NaxxramasShade_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NaxxramasShade_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NaxxramasShade_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27824, 1, "NaxxramasShade_OnCombat")
RegisterUnitEvent(27824, 2, "NaxxramasShade_OnLeaveCombat")
RegisterUnitEvent(27824, 3, "NaxxramasShade_OnKilledTarget")
RegisterUnitEvent(27824, 4, "NaxxramasShade_OnDied")