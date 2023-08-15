--[[ Netherstorm -- Abjurist Belmara.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 21th, 2008. ]]

function Abjurist_OnEnterCombat(Unit, Event)
    Unit:RegisterEvent("Abjurist_Armor", 10000, 0)
    Unit:RegisterEvent("Abjurist_Missiles", 1000,0)
end
    
function Abjurist_Armor(Unit, Event)
    Unit:CastSpell(12544)
end

function Abjurist_Missiles(Unit, Event)
    Unit:FullCastSpellOnTarget(34447,Unit:GetClosestPlayer())
end

function Abjurist_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Abjurist_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19546, 1, "Abjurist_OnEnterCombat")
RegisterUnitEvent (19546, 2, "Abjurist_OnLeaveCombat")
RegisterUnitEvent (19546, 4, "Abjurist_OnDied")