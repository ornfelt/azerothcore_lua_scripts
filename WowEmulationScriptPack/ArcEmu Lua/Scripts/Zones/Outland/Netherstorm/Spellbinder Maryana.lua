--[[ Netherstorm -- Spellbinder Maryana.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 01th, 2008. ]]

function Maryana_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Maryana_Blast",5000,0)
    Unit:RegisterEvent("Maryana_Fire",7000,0)
    Unit:RegisterEvent("Maryana_Intellect",1000,(1))
end

function Maryana_Blast(Unit,Event)
    Unit:CastSpell(37450)
end   

function Maryana_Fire(Unit,Event)
    Unit:CastSpell(15091)
end

function Maryana_Intellect(Unit,Event)
    Unit:CastSpell(35917)
end

function Maryana_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Maryana_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19593, 1, "Maryana_OnEnterCombat")
RegisterUnitEvent (19593, 2, "Maryana_OnLeaveCombat")
RegisterUnitEvent (19593, 4, "Maryana_OnDied")