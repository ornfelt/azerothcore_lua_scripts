--[[ Netherstorm -- Dancing Flames.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Flames_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Flames_Dance",1000,0)
    Unit:RegisterEvent("Flames_Seduction",180000,0)
    Unit:RegisterEvent("Flames_Summon",1000,(1))
end

function Flames_Dance(Unit,Event)
    Unit:CastSpell(45427)
end

function Flames_Seduction(Unit,Event)
    Unit:FullCastSpellOnTarget(47057, Unit:GetClosestPlayer())
end

function Flames_Summon(Unit,Event)
    Unit:CastSpell(45423)
end

function Flames_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Flames_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (25305, 1, "Flames_OnEnterCombat")
RegisterUnitEvent (25305, 2, "Flames_OnLeaveCombat")
RegisterUnitEvent (25305, 4, "Flames_OnDied")
