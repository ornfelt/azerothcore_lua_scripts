--[[ Netherstorm -- Stormspire Nexus-Guard.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 26th, 2008. ]]

function Guard_OnCombat(Unit, Event)
Unit:RegisterEvent("Guard_Cleave", 5000, 0)
Unit:RegisterEvent("Guard_Hamstring", 6000, 0)
Unit:RegisterEvent("Guard_Mortal_Strike", 7000, 0)
end

function Guard_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Guard_OnKillTarget(Unit, Event)
Unit:RemoveEvents()
end

function Guard_OnDeath(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(19529, 1, "Guard_OnCombat")
RegisterUnitEvent(19529, 2, "Guard_OnLeaveCombat")
RegisterUnitEvent(19529, 3, "Guard_OnKillTarget")
RegisterUnitEvent(19529, 4, "Guard_OnDeath")

function Guard_Cleave(Unit, Event)
Unit:FullCastSpellOnTarget(15284, GetMainTank())
end

function Guard_Hamstring(Unit, Event)
Unit:FullCastSpellOnTarget(9080, GetMainTank())
end

function Guard_Mortal_Strike(Unit, Event)
Unit:FullCastSpellOnTarget(16856, GetMainTank())
end
