--[[ Netherstorm -- Sundered Thunderer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Sundered_Thunderer_OnCombat(Unit, Event)
Unit:RegisterEvent("Sundered_Thunderer_Summon_Sundered_Shard", 8000, 0)
Unit:RegisterEvent("Sundered_Thunderer_Thunder_Clap", 6000, 0)
end

function Sundered_Thunderer_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Sundered_Thunderer_OnKillTarget(Unit, Event)
Unit:RemoveEvents()
end

function Sundered_Thunderer_OnDeath(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(18882, 1, "Sundered_Thunderer_OnCombat")
RegisterUnitEvent(18882, 2, "Sundered_Thunderer_OnLeaveCombat")
RegisterUnitEvent(18882, 3, "Sundered_Thunderer_OnKillTarget")
RegisterUnitEvent(18882, 4, "Sundered_Thunderer_OnDeath")

function Sundered_Thunderer_Thunder_Clap(Unit, Event)
Unit:FullCastSpellOnTarget(6000,Unit:GetMainTank())
end

function Sundered_Thunderer_Summon_Sundered_Shard(Unit, Event)
Unit:CastSpell(35007)
local X = Unit:GetX()
local Y = Unit:GetY()
local Z = Unit:GetZ()
local O = Unit:GetO()
Unit:SpawnCreature(20498, X, Y, Z, O, 35, 0)
end