--[[ Netherstorm -- Socrethar.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 01th, 2008. ]]

function Socrethar_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Socrethar_Shield",10000,0)
    Unit:RegisterEvent("Socrethar_Backslash",5000,0)
    Unit:RegisterEvent("Socrethar_Cleave",6000,0)
    Unit:RegisterEvent("Socrethar_Barrage",10000,0)
    Unit:RegisterEvent("Socrethar_Protection",1000,(1))
    Unit:RegisterEvent("Socrethar_Bolt",3000,0)
end

function Socrethar_Shield(Unit,Event)
    Unit:CastSpell(37538)
end

function Socrethar_Backslash(Unit,Event)
    Unit:FullCastSpellOnTarget(37537,Unit:GetRandomPlayer(0))
end

function Socrethar_Cleave(Unit,Event)
    Unit:FullCastSpellOnTarget(15496,Unit:GetMainTank())
end

function Socrethar_Barrage(Unit,Event)
    Unit:CastSpell(37541)
    local plr = Unit:GetRandomPlayer()
    if plr ~= nil then
    Unit:ChannelSpell(plr:GetGUID(),37540)
end
end

function Socrethar_Protection(Unit,Event)
    Unit:CastSpell(37539)
end

function Socrethar_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(28448,Unit:GetRandomPlayer(0))
end

function Socrethar_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Socrethar_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20132, 1, "Socrethar_OnEnterCombat")
RegisterUnitEvent (20132, 2, "Socrethar_OnLeaveCombat")
RegisterUnitEvent (20132, 4, "Socrethar_OnDied")