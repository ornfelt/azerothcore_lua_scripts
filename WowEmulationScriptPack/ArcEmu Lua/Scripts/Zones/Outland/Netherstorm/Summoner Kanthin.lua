--[[ Netherstorm -- Summoner Kanthin.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 26th, 2008. ]]

function Summoner_Kanthin_OnCombat(Unit, Event)
Unit:RegisterEvent("Summoner_Kanthin_Fireball", 4000, 0)
Unit:RegisterEvent("Summoner_Kanthin_Nova", 10000, 0)
Unit:RegisterEvent("Summoner_Kanthin_Pyroblast", 7000, 0)
end

function Summoner_Kanthin_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Summoner_Kanthin_OnKillTarget(Unit, Event)
Unit:RemoveEvents()
end

function Summoner_Kanthin_OnDeath(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(19657, 1, "Summoner_Kanthin_OnCombat")
RegisterUnitEvent(19657, 2, "Summoner_Kanthin_OnLeaveCombat")
RegisterUnitEvent(19657, 3, "Summoner_Kanthin_OnKillTarget")
RegisterUnitEvent(19657, 4, "Summoner_Kanthin_OnDeath")

function Summoner_Kanthin_Fireball(Unit, Event)
Unit:FullCastSpellOnTarget(19816,Unit:GetClosestPlayer())
end

function Summoner_Kanthin_Nova(Unit, Event)
Unit:FullCastSpellOnTarget(19657,Unit:GetMainTank())
end

function Summoner_Kanthin_Pyroblast(Unit, Event)
Unit:FullCastSpellOnTarget(17273,Unit:GetClosestPlayer())
end
