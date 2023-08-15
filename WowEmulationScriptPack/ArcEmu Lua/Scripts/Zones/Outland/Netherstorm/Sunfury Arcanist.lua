--[[ Netherstorm -- Sunfury Arcanist.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Sunfury_Arcanist_OnCombat(Unit, Event)
Unit:RegisterEvent("Sunfury_Arcanist_Arcane_Missiles", 6000, 0)
Unit:RegisterEvent("Sunfury_Arcanist_Bloodcrystal_Surge", 10000, 0)
end

function Sunfury_Arcanist_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Sunfury_Arcanist_OnKillTarget(Unit, Event)
Unit:RemoveEvents()
end

function Sunfury_Arcanist_OnDeath(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(20134, 1, "Sunfury_Arcanist_OnCombat")
RegisterUnitEvent(20134, 2, "Sunfury_Arcanist_OnLeaveCombat")
RegisterUnitEvent(20134, 3, "Sunfury_Arcanist_OnKillTarget")
RegisterUnitEvent(20134, 4, "Sunfury_Arcanist_OnDeath")

function Sunfury_Arcanist_Arcane_Missiles(Unit, Event)
Unit:FullCastSpellOnTarget(34447,Unit:GetMainTank())
end

function Sunfury_Arcanist_Bloodcrystal_Surge(Unit, Event)
Unit:CastSpell(35778)
end
