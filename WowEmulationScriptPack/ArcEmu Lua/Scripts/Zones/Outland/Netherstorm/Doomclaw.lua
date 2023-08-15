--[[ Netherstorm -- Doomclaw.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 26th, 2008. ]]

function Doomclaw_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Doomclaw_Swipe",1000,0)
    Unit:RegisterEvent("Doomclaw_Claw",1100,0)
    Unit:RegisterEvent("Doomclaw_Slime",1000,0)
end

function Doomclaw_Swipe(Unit,Event)
    Unit:FullCastSpellOnTarget(36205,Unit:GetClosestPlayer())
end

function Doomclaw_Claw(Unit,Event)
    Unit:FullCastSpellOnTarget(36996,Unit:GetClosestPlayer())
end

function Doomclaw_Slime(Unit,Event)
    Unit:FullCastSpellOnTarget(34261,Unit:GetClosestPlayer())
end

function Doomclaw_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Doomclaw_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19738, 1, "Doomclaw_OnEnterCombat")
RegisterUnitEvent (19738, 2, "Doomclaw_OnLeaveCombat")
RegisterUnitEvent (19738, 4, "Doomclaw_OnDied")