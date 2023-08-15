--[[ Boss -- Vexallus.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, August 27, 2008. ]]

-- Boss -- Vexallus

function Vex_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("Vex_Arcane", 34000, 0)
	pUnit:RegisterEvent("Vex_Spell", 7000, 0)
	pUnit:RegisterEvent("Vex_Adds", 1000, 0)
	pUnit:RegisterEvent("Vex_CastOverload", 1000, 0)
	pUnit:SendChatMessage(14, 0, "Drain... life...")
	pUnit:PlaySoundToSet(12389)
end

function Vex_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Vex_OnKill(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Con...sume.")
	pUnit:PlaySoundToSet(12393)
end

function Vex_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function Vex_Spell(pUnit, Event)
	pUnit:FullCastSpellOnTarget(44318,pUnit:GetClosestPlayer())
end

function Vex_Arcane(pUnit, Event)
	pUnit:FullCastSpellOnTarget(44319,pUnit:GetClosestPlayer())
	pUnit:SendChatMessage(14, 0, "Un...con...tainable.")
	pUnit:PlaySoundToSet(12392)
end

function Vex_CastOverload(pUnit,Event)
 if pUnit:GetHealthPct() == 10 then
	pUnit:RegisterEvent("Vex_Overload", math.random(2000,3000), 0)
end
end

function Vex_Overload(pUnit, Event)
	pUnit:FullCastSpellOnTarget(44353, pUnit:GetClosestPlayer())
	pUnit:SendChatMessage(14, 0, "Un...leash...")
	pUnit:PlaySoundToSet(12390)
end

function Vex_Adds(pUnit,Event)
if pUnit:GetHealthPct() == 85 then
	pUnit:SpawnCreature(24745, 231, -207, 6, 0, 16, 60000)
	pUnit:RegisterEvent("Vex_Adds70", 000, 1)
end
end

function Vex_Adds70(pUnit,Event)
if pUnit:GetHealthPct() == 70 then
	pUnit:SpawnCreature(24745, 231, -207, 6, 0, 16, 60000)
	pUnit:RegisterEvent("Vex_Adds55", 000, 1)
end
end

function Vex_Adds55(pUnit,Event)
if pUnit:GetHealthPct() == 55 then
	pUnit:SpawnCreature(24745, 231, -207, 6, 0, 16, 60000)
	pUnit:RegisterEvent("Vex_Adds40", 000, 1)
end
end

function Vex_Adds40(pUnit,Event)
if pUnit:GetHealthPct() == 40 then
	pUnit:SpawnCreature(24745, 231, -207, 6, 0, 16, 60000)
	pUnit:RegisterEvent("Vex_Adds25", 000, 1)
end
end

function Vex_Adds25(pUnit,Event)
if pUnit:GetHealthPct() == 25 then
	pUnit:SpawnCreature(24745, 231, -207, 6, 0, 16, 60000)
end
end

RegisterUnitEvent(24744, 1, "Vex_OnEnterCombat")
RegisterUnitEvent(24744, 2, "Vex_OnLeaveCombat")
RegisterUnitEvent(24744, 3, "Vex_OnKill")
RegisterUnitEvent(24744, 4, "Vex_OnDied")



------------------------------------------------------------------------------------------------------------------------------------------------
-------- PureEnergy, The little lighning bolts. --------
------------------------------------------------------------------------------------------------------------------------------------------------

function PureEnergy_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("VexAdds_Spell", 26000, 0)
end

function PureEnergy_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(44342,pUnit:GetClosestPlayer())
end

function PureEnergy_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:FullCastSpellOnTarget(44335,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(24745, 1, "PureEnergy_OnEnterCombat")
RegisterUnitEvent(24745, 4, "PureEnergy_OnDied")