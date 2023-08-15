--[[ Netherstorm -- Gan'arg Engineer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Engineer_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Engineer_Dynamite",1000,0)
end

function Engineer_Dynamite(Unit,Event)
    Unit:FullCastSpellOnTarget(7978,Unit:GetClosestPlayer())
end

function Engineer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Engineer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (16948, 1, "Engineer_OnEnterCombat")
RegisterUnitEvent (16948, 2, "Engineer_OnLeaveCombat")
RegisterUnitEvent (16948, 4, "Engineer_OnDied")