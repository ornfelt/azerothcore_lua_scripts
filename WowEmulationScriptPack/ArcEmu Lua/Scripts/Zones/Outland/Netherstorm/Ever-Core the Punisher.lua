--[[ Netherstorm -- Ever-Core the Punisher.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Punisher_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Punisher_Explosion",1500,0)
    Unit:RegisterEvent("Punisher_Suppression",3000,0)
end

function Punisher_Explosion(Unit,Event)
    Unit:FullCastSpellOnTarget(33860,Unit:GetClosestPlayer())
end

function Punisher_Suppression(Unit,Event)
    Unit:FullCastSpellOnTarget(35892,Unit:GetClosestPlayer())
end

function Punisher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Punisher_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18698, 1, "Punisher_OnEnterCombat")
RegisterUnitEvent (18698, 2, "Punisher_OnLeaveCombat")
RegisterUnitEvent (18698, 4, "Punisher_OnDied")