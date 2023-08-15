--[[ Netherstorm -- Boom Bot.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 23th, 2008. ]]

function Bot_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Bot_Suicide",4000,1)
end

function Bot_Suicide(Unit,Event)
	Unit:FullCastSpellOnTarget(7,Unit:GetClosestPlayer())
	Unit:CastSpell(7)
end

function Bot_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Bot_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19692, 1, "Bot_OnEnterCombat")
RegisterUnitEvent (19692, 2, "Bot_OnLeaveCombat")
RegisterUnitEvent (19692, 4, "Bot_OnDied")