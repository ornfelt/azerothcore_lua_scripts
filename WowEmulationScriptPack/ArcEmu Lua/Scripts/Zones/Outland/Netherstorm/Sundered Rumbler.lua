--[[ Netherstorm -- Sundered Rumbler.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 26th, 2008. ]]

function Sundered_Rumbler_OnCombat(Unit, Event)
Unit:RegisterEvent("Sundered_Rumbler_Summon_Sundered_Shard", 8000, 0)
end

function Sundered_Rumbler_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Sundered_Rumbler_OnKillTarget(Unit, Event)
Unit:RemoveEvents()
end

function Sundered_Rumbler_OnDeath(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(18881, 1, "Sundered_Rumbler_OnCombat")
RegisterUnitEvent(18881, 2, "Sundered_Rumbler_OnLeaveCombat")
RegisterUnitEvent(18881, 3, "Sundered_Rumbler_OnKillTarget")
RegisterUnitEvent(18881, 4, "Sundered_Rumbler_OnDeath")

function Sundered_Rumbler_Summon_Sundered_Shard(Unit, Event)
Unit:CastSpell(35310)
local X = Unit:GetX()
local Y = Unit:GetY()
local Z = Unit:GetZ()
local O = Unit:GetO()
Unit:SpawnCreature(20498, X, Y, Z, O, 35, 0)
end
