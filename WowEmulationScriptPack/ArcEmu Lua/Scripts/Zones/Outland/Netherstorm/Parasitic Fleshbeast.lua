--[[ Netherstorm -- Parasitic Fleshbeast.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 29th, 2008. ]]

function Beast_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Beast_Rend",15000,0)
    Unit:RegisterEvent("Beast_Parasite_Spell",6000,0)
    Unit:RegisterEvent("Beast_Parasite_Spawn",36000,0)
end

function Beast_Rend(Unit,Event)
    Unit:FullCastSpellOnTarget(13443,Unit:GetMainTank())
end

function Beast_Parasite_Spell(Unit,Event)
    Unit:FullCastSpellOnTarget(36469,Unit:GetRandomPlayer(0))
end

function Beast_Parasite_Spawn(Unit,Event)
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:CastSpell(36468)
    Unit:SpawnCreature(21265, x-1, y, z, o, 14, o)
end

function Beast_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function Beast_OnDied(Unit,Event)
    Unit:RemoveEvents()
end

RegisterUnitEvent(20335,1,"Beast_OnEnterCombat")
RegisterUnitEvent(20335,2,"Beast_OnLeaveCombat")
RegisterUnitEvent(20335,4,"Beast_OnDied")