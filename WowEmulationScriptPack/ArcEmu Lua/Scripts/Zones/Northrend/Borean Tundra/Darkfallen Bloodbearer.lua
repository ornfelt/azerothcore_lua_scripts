--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]


function DarkfallenBloodbearer_OnCombat(Unit, Event)
Unit:RegisterEvent("DarkfallenBloodbearer_DeathCoil", 8000, 0)
Unit:RegisterEvent("DarkfallenBloodbearer_IcyTouch", 10000, 0)
end

function DarkfallenBloodbearer_DeathCoil(Unit, Event) 
Unit:FullCastSpellOnTarget(50668, Unit:GetMainTank()) 
end

function DarkfallenBloodbearer_IcyTouch(Unit, Event) 
Unit:FullCastSpellOnTarget(50349, Unit:GetMainTank()) 
end

function DarkfallenBloodbearer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DarkfallenBloodbearer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DarkfallenBloodbearer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26115, 1, "DarkfallenBloodbearer_OnCombat")
RegisterUnitEvent(26115, 2, "DarkfallenBloodbearer_OnLeaveCombat")
RegisterUnitEvent(26115, 3, "DarkfallenBloodbearer_OnKilledTarget")
RegisterUnitEvent(26115, 4, "DarkfallenBloodbearer_OnDied")