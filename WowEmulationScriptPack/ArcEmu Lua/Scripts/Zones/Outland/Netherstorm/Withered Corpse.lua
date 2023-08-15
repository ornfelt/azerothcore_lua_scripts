--[[ Netherstorm -- Withered Corpse.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Corpse_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Corpse_Rend",15000,0)
    Unit:RegisterEvent("Corpse_Parasite_Spell",6000,0)
    Unit:RegisterEvent("Corpse_Parasite_Spawn",36000,0)
end

function Corpse_Rend(Unit,Event)
    Unit:FullCastSpellOnTarget(13443,Unit:GetMainTank())
end

function Corpse_Parasite_Spell(Unit,Event)
    Unit:FullCastSpellOnTarget(36469,Unit:GetRandomPlayer(0))
end

function Corpse_Parasite_Spawn(Unit,Event)
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:CastSpell(36468)
    Unit:SpawnCreature(21265, x-1, y, z, o, 14, o)
end

function Corpse_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function Corpse_OnKilledTarget(Unit,Event)
    Unit:RemoveEvents()
end

function Corpse_OnDied(Unit,Event)
    Unit:RemoveEvents()
end

RegisterUnitEvent(20561,1,"Corpse_OnEnterCombat")
RegisterUnitEvent(20561,2,"Corpse_OnLeaveCombat")
RegisterUnitEvent(20561,3,"Corpse_OnKilledTarget")
RegisterUnitEvent(20561,4,"Corpse_OnDied")