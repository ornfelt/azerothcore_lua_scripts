--[[ Netherstorm -- Ethereum Nexus-Stalker.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Stalker_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Stalker_Shadowsurge",1000,0)
    Unit:RegisterEvent("Stalker_Shadowtouched",1000,0)
end

function Stalker_Shadowsurge(Unit,Event)
    Unit:FullCastSpellOnTarget(36517,Unit:GetClosestPlayer())
end

function Stalker_Shadowtouched(Unit,Event)
    Unit:CastSpell(36515)
end

function Stalker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Stalker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20474, 1, "Stalker_OnEnterCombat")
RegisterUnitEvent (20474, 2, "Stalker_OnEnterCombat")
RegisterUnitEvent (20474, 4, "Stalker_OnEnterCombat")