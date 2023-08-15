--[[ Netherstorm -- Kaylaan the Lost.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Kaylannl_OnEnterCombat(Unit,Event)
    if Unit:GetHealthPct() == 99 then
    Unit:RegisterEvent("Kaylannl_Phase1",1000,0)
end
end
    
function Kaylannl_Phase1(Unit,Event)
    Unit:RegisterEvent("Kaylaanl_Ressurection",15000,0)
    Unit:RegisterEvent("Kaylaanl_Shield",18000,0)
    Unit:RegisterEvent("Kaylannl_Light",5000,0)
    Unit:RegisterEvent("Kaylannl_Power",6000,0)
    Unit:RegisterEvent("Kaylannl_Consecration",6000,0)
    Unit:RegisterEvent("Kaylannl_Shield2",25000,0)
    Unit:RegisterEvent("Kaylannl_Heal",7000,0)
    Unit:RegisterEvent("Kaylannl_Slam",7000,0)
    Unit:RegisterEvent("Kaylannl_Wrath",25000,0)
    Unit:RegisterEvent("Kaylannl_Despawn",1000,0)
end

function Kaylannl_Ressurection(Unit,Event)
    Unit:FullCastSpellOnTarget(35599,Unit:GetRandomFriend(0))
end

function Kaylannl_Shield(Unit,Event)
    Unit:FullCastSpellOnTarget(37554,Unit:GetRandomPlayer(0))
end

function Kaylannl_Light(Unit,Event)
    Unit:FullCastSpellOnTarget(37552,Unit:GetMainTank())
end

function Kaylannl_Power(Unit,Event)
    local plr = Unit:GetRandomPlayer(0)
		if plr ~= nil then
			Unit:ChannelSpell(plr:GetGUID(),35597)
    end
end

function Kaylannl_Consecration(Unit,Event)
    Unit:CastSpell(37553)
end

function Kaylannl_Shield2(Unit,Event)
    Unit:CastSpell(13874)
end

function Kaylannl_Heal(Unit,Event)
    Unit:CastSpellOnTarget(37569,Unit:GetRandomFriend(0))
end

function Kaylannl_Slam(Unit,Event)
    Unit:FullCastSpellOnTarget(37572,Unit:GetMainTank())
end

function Kaylannl_Wrath(Unit,Event)
    Unit:FullCastSpellOnTarget(35614,Unit:GetRandomPlayer(0))
end

function Kaylannl_Despawn(Unit,Event)
    if Unit:GetHealthPct() == 25 then
    Unit:Despawn(5000)
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:SpawnCreature(20132, x-1, y, z, o, 14, o)
end
end

function Kaylannl_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Kaylannl_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20794, 1, "Kaylannl_OnEnterCombat")
RegisterUnitEvent (20794, 2, "Kaylannl_OnLeaveCombat")
RegisterUnitEvent (20794, 4, "Kaylannl_OnDied")