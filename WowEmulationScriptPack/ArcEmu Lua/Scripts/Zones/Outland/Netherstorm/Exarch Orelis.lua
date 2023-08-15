--[[ Netherstorm -- Exarch Orelis.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Orelis_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Orelis_Shout",1000,0)
    Unit:RegisterEvent("Orelis_Strike",1000,0)
    Unit:RegisterEvent("Orelis_Rend",1000,0)
end

function Orelis_Shout(Unit,Event)
    Unit:FullCastSpellOnTarget(13730,Unit:GetClosestPlayer())
end

function Orelis_Strike(Unit,Event)
    Unit:FullCastSpellOnTarget(29426,Unit:GetClosestPlayer())
end

function Orelis_Rend(Unit,Event)
    Unit:FullCastSpellOnTarget(16509,Unit:GetClosestPlayer())
end

function Orelis_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Orelis_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19466, 1, "Orelis_OnEnterCombat")
RegisterUnitEvent (19466, 2, "Orelis_OnLeaveCombat")
RegisterUnitEvent (19466, 4, "Orelis_OnDied")
