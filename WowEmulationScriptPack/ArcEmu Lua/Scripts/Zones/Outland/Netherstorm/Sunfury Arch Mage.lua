--[[ Netherstorm -- Sunfury Arch Mage.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Sunfury_Arch_Mage_OnCombat(Unit, Event)
Unit:RegisterEvent("Sunfury_Arch_Mage_Nova", 10000, 0)
Unit:RegisterEvent("Sunfury_Arch_Mage_Fiery_Intellect", 1000, (1))
Unit:RegisterEvent("Sunfury_Arch_Mage_Fireball", 4000, 0)
end

function Sunfury_Arch_Mage_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Sunfury_Arch_Mage_OnKillTarget(Unit, Event)
Unit:RemoveEvents()
end

function Sunfury_Arch_Mage_OnDeath(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(20135, 1, "Sunfury_Arch_Mage_OnCombat")
RegisterUnitEvent(20135, 2, "Sunfury_Arch_Mage_OnLeaveCombat")
RegisterUnitEvent(20135, 3, "Sunfury_Arch_Mage_OnKillTarget")
RegisterUnitEvent(20135, 4, "Sunfury_Arch_Mage_OnDeath")

function Sunfury_Arch_Mage_Nova(Unit, Event)
Unit:CastSpell(11831)
end

function Sunfury_Arch_Mage_Fiery_Intellect(Unit, Event)
Unit:CastSpell(35917)
end

function Sunfury_Arch_Mage_Fireball(Unit, Event)
Unit:FullCastSpellOnTarget(20823,Unit:GetMainTank())
end
