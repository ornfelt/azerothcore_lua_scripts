--[[ Boss -- Slad'ran.lua

This script was written and is protected
by the GPL v2. This script was released
by Bapes of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Bapes, November 03, 2008. ]]

-- Adds:  http://wotlk.wowhead.com/?npc=29713 & http://wotlk.wowhead.com/?npc=29680
--local Slad'ranConstrictor = 29713
--local Slad'ranViper = 29680
-- 99% Blizzlike, just need exact times for spells.

function Sladran_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Drakkari gonna kill anybody who trespass on these lands!")
pUnit:RegisterEvent("Sladran_PoisonNova", math.random(15000, 17000), 0)
pUnit:RegisterEvent("Sladran_PowerfulBite", math.random(22000, 24000), 0)
pUnit:RegisterEvent("Sladran_VenomBolt", math.random(29000, 34000), 0)
end

function Sladran_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Sladran_OnKillTarget(pUnit, Event)
-- Around 80% chance to use text.
local Text = math.random(1, 4)
if Text == 1 then
pUnit:SendChatMessage(14, 0, "Ye not breathin'! Good.")
elseif Text == 2 then
pUnit:SendChatMessage(14, 0, "You scared now?")
elseif Text == 3 then
pUnit:SendChatMessage(14, 0, "I'll eat you next, mon!")
end
end

function Sladran_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "I see now... Scourge was not our greatest enemy.")
end

RegisterUnitEvent(29304, 1, "Sladran_OnCombat")
RegisterUnitEvent(29304, 2, "Sladran_OnLeaveCombat")
RegisterUnitEvent(29304, 3, "Sladran_OnKillTarget")
RegisterUnitEvent(29304, 4, "Sladran_OnDeath")

function Sladran_PhaseTwo(pUnit, Event)
if pUnit:GetHealthPct() <= 30 then
pUnit:RegisterEvent("Sladran_SummonAdds", math.random(40000, 42000), 0)
pUnit:RegisterEvent("Sladran_PoisonNova", math.random(15000, 17000), 0)
pUnit:RegisterEvent("Sladran_PowerfulBite", math.random(22000, 24000), 0)
pUnit:RegisterEvent("Sladran_VenomBolt", math.random(29000, 34000), 0)
end
end

function Sladran_SummonAdds(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Minions of the scale, heed my call!")
	local x,y,z,o = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO()
	pUnit:SpawnCreature(29713, x, y, z, o, 14, 0)
	pUnit:SpawnCreature(29713, x, y, z, o, 14, 0)
	pUnit:SpawnCreature(29680, x, y, z, o, 14, 0)
	pUnit:SpawnCreature(29680, x, y, z, o, 14, 0)
end

function Sladran_PoisonNova(pUnit, Event) --  http://wotlk.wowhead.com/?spell=55081
pUnit:FullCastSpell(55081)
end

function Sladran_PowerfulBite(pUnit, Event) --  http://wotlk.wowhead.com/?spell=48287
pUnit:FullCastSpellOnTarget(48287, pUnit:GetMainTank())
end

function Sladran_VenomBolt(pUnit, Event) --  http://wotlk.wowhead.com/?spell=54970
pUnit:FullCastSpellOnTarget(54970, pUnit:GetRandomPlayer(0))
end