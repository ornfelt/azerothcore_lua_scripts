--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]


function CuratorInsivius_OnCombat(Unit, Event)
Unit:RegisterEvent("CuratorInsivius_Charge", 1000, 1)
Unit:RegisterEvent("CuratorInsivius_FrostNova", 10000, 0)
Unit:RegisterEvent("CuratorInsivius_MortalStrike", 8000, 0)
end

function CuratorInsivius_Charge(Unit, Event) 
Unit:FullCastSpellOnTarget(22120, Unit:GetMainTank()) 
end

function CuratorInsivius_FrostNova(Unit, Event) 
Unit:CastSpell(11831) 
end

function CuratorInsivius_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(39171, Unit:GetMainTank()) 
end

function CuratorInsivius_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CuratorInsivius_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CuratorInsivius_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25448, 1, "CuratorInsivius_OnCombat")
RegisterUnitEvent(25448, 2, "CuratorInsivius_OnLeaveCombat")
RegisterUnitEvent(25448, 3, "CuratorInsivius_OnKilledTarget")
RegisterUnitEvent(25448, 4, "CuratorInsivius_OnDied")