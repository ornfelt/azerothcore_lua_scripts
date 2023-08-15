--[[ Netherstorm -- Ethereum Relay.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Relay_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Relay_Shadowform",1000,0)
end

function Relay_Shadowform(Unit,Event)
    Unit:CastSpell(16592)
end

function Relay_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Relay_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20619, 1, "Relay_OnEnterCombat")
RegisterUnitEvent (20619, 2, "Relay_OnLeaveCombat")
RegisterUnitEvent (20619, 4, "Relay_OnDied")