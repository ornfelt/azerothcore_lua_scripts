--[[ Netherstorm -- Anchorite Karja.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 21th, 2008. ]]

function Anchorite_OnEnterCombat(Unit, Event)
    Unit:RegisterEvent("Anchorite_Heal", 3500, 0)
    Unit:RegisterEvent("Anchorite_Fire", 5000, 0)
    Unit:RegisterEvent("Anchorite_Smite", 2500, 0)
end

function Anchorite_Heal(Unit, Event)
    Unit:CastSpell(35096)
end

function Anchorite_Fire(Unit, Event)
    Unit:FullCastSpellOnTarget(17141, Unit:GetClosestPlayer())
end

function Anchorite_Smite(Unit, Event)
    Unit:FullCastSpellOnTarget(9734, Unit:GetClosestPlayer())
end

function Anchorite_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Anchorite_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19467, 1, "Anchorite_OnEnterCombat")
RegisterUnitEvent (19467, 2, "Anchorite_OnLeaveCombat")
RegisterUnitEvent (19467, 4, "Anchorite_OnDied")