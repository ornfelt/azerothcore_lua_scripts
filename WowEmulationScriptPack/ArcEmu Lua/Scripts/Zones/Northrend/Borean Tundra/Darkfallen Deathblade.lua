--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]


function DarkfallenDeathblade_OnCombat(Unit, Event)
Unit:RegisterEvent("DarkfallenDeathblade_DeathCoil", 8000, 0)
Unit:RegisterEvent("DarkfallenDeathblade_IcyTouch", 10000, 0)
end

function DarkfallenDeathblade_DeathCoil(Unit, Event) 
Unit:FullCastSpellOnTarget(50668, Unit:GetMainTank()) 
end

function DarkfallenDeathblade_IcyTouch(Unit, Event) 
Unit:FullCastSpellOnTarget(50349, Unit:GetMainTank()) 
end

function DarkfallenDeathblade_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DarkfallenDeathblade_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DarkfallenDeathblade_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26103, 1, "DarkfallenDeathblade_OnCombat")
RegisterUnitEvent(26103, 2, "DarkfallenDeathblade_OnLeaveCombat")
RegisterUnitEvent(26103, 3, "DarkfallenDeathblade_OnKilledTarget")
RegisterUnitEvent(26103, 4, "DarkfallenDeathblade_OnDied")