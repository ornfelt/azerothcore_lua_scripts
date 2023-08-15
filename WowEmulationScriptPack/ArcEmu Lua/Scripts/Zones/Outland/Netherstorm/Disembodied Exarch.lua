--[[ Netherstorm -- Disembodied Exarch.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Exarch_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Exarch_Fortitude",2000,0)
    Unit:RegisterEvent("Exarch_Devotion",1000,0)
end

function Exarch_Fortitude(Unit,Event)
    Unit:CastSpellOnTarget(36004,Unit:GetRandomFriend())
end

function Exarch_Devotion(Unit,Event)
    Unit:CastSpell(8258)
end

function Exarch_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Exarch_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21058, 1, "Exarch_OnEnterCombat")
RegisterUnitEvent (21058, 2, "Exarch_OnLeaveCombat")
RegisterUnitEvent (21058, 4, "Exarch_OnDied")