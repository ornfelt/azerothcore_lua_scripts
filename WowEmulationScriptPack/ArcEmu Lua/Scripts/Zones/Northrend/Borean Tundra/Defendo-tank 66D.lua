--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]


function Defendotank66D_OnCombat(Unit, Event)
Unit:RegisterEvent("Defendotank66D_MachineGun", 8000, 0)
Unit:RegisterEvent("Defendotank66D_Shoot", 6000, 0)
end

function Defendotank66D_MachineGun(Unit, Event) 
Unit:FullCastSpellOnTarget(49981, Unit:GetMainTank()) 
end

function Defendotank66D_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(49987, Unit:GetMainTank()) 
end

function Defendotank66D_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Defendotank66D_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Defendotank66D_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25758, 1, "Defendotank66D_OnCombat")
RegisterUnitEvent(25758, 2, "Defendotank66D_OnLeaveCombat")
RegisterUnitEvent(25758, 3, "Defendotank66D_OnKilledTarget")
RegisterUnitEvent(25758, 4, "Defendotank66D_OnDied")