--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]


function DenVermin_OnCombat(Unit, Event)
Unit:RegisterEvent("DenVermin_Thrash", 6000, 0)
end

function DenVermin_Thrash(Unit, Event) 
Unit:FullCastSpellOnTarget(3391, Unit:GetMainTank()) 
end

function DenVermin_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DenVermin_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DenVermin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24567, 1, "DenVermin_OnCombat")
RegisterUnitEvent(24567, 2, "DenVermin_OnLeaveCombat")
RegisterUnitEvent(24567, 3, "DenVermin_OnKilledTarget")
RegisterUnitEvent(24567, 4, "DenVermin_OnDied")