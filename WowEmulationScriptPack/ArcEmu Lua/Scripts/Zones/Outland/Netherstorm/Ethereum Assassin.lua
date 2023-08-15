--[[ Netherstorm -- Ethereum Assassin.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 26th, 2008. ]]

function Assassin_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Assassin_Kick",1000,0)
    Unit:RegisterEvent("Assassin_Warp",1000,0)
end

function Assassin_Kick(Unit,Event)
    Unit:FullCastSpellOnTarget(34802,Unit:GetClosestPlayer())
end

function Assassin_Warp(Unit,Event)
    Unit:FullCastSpellOnTarget(32920,Unit:GetClosestPlayer())
end

function Assassin_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Assassin_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20452, 1, "Assassin_OnEnterCombat")
RegisterUnitEvent (20452, 2, "Assassin_OnEnterCombat")
RegisterUnitEvent (20452, 4, "Assassin_OnEnterCombat")