--[[********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, March 26, 2008. ]]
function Venoxis_HolyNovaRepeat(pUnit, event)
     pUnit:CastSpell(23858)
     pUnit:RegisterEvent("Venoxis_HolyNova", math.random(26000, 31000), 1)
end

function Venoxis_HolyNova(pUnit, event)
     pUnit:CastSpell(23858)
     pUnit:RegisterEvent("Venoxis_HolyNovaRepeat", math.random(26000, 31000), 1)
end

function Venoxis_HolyFireRepeat(pUnit, event)
     pUnit:FullCastSpellOnTarget(23860, pUnit:GetMainTank())
     pUnit:RegisterEvent("Venoxis_HolyFire", math.random(18000, 22000), 1)
end

function Venoxis_HolyFire(pUnit, event)
     pUnit:FullCastSpellOnTarget(23860, pUnit:GetMainTank())
     pUnit:RegisterEvent("Venoxis_HolyFireRepeat", math.random(18000, 22000), 1)
end

function Venoxis_Serpent(pUnit, event)
     local serpenttarget=pUnit:GetRandomPlayer(0);
     pUnit:SpawnCreature(14884, serpenttarget:GetX(), serpenttarget:GetY(), serpenttarget:GetZ(), serpenttarget:GetO(), 14, 0)
end

function Venoxis_Renew(pUnit, event)
     pUnit:CastSpell(23895)
end

function Venoxis_PoisonCloud(pUnit, event)
     pUnit:CastSpell(23861)
end

function Venoxis_VenomSpitRepeat(pUnit, event)
     pUnit:FullCastSpellOnTarget(23862, pUnit:GetRandomPlayer(0))
     pUnit:RegisterEvent("Venoxis_VenomSpit", math.random(14000, 18000), 1)
end

function Venoxis_VenomSpit(pUnit, event)
     pUnit:FullCastSpellOnTarget(23862, pUnit:GetRandomPlayer(0))
     pUnit:RegisterEvent("Venoxis_VenomSpitRepeat", math.random(14000, 18000), 1)
end

function Venoxis_Phasetwo(pUnit, event)
     if pUnit:GetHealthPct() < 51 then
	     pUnit:RemoveEvents()
	     pUnit:SendChatMessage(14, 0, "Let the coils of hate unfurl!")
	     pUnit:SetModel(9134)
	     pUnit:CastSpell(23849)
	     pUnit:CastSpell(23861)
	     pUnit:RegisterEvent("Venoxis_PoisonCloud", 22000, 0)
	     pUnit:RegisterEvent("Venoxis_VenomSpit", math.random(14000, 18000), 1)
     end
end

function Venoxis_OnEnterCombat(pUnit, event)
     pUnit:RegisterEvent("Venoxis_HolyNova", math.random(26000, 31000), 1)
     pUnit:RegisterEvent("Venoxis_HolyFire", math.random(18000, 22000), 1)
     pUnit:RegisterEvent("Venoxis_Serpent", 45000, 0)
     pUnit:RegisterEvent("Venoxis_Renew", 50000, 0)
     pUnit:RegisterEvent("Venoxis_Phasetwo", 1000, 0)
end

RegisterUnitEvent(14507, 1, "Venoxis_OnEnterCombat")

function Venoxis_OnWipe(pUnit, event)
     if pUnit:IsAlive() == true then
	     pUnit:SetModel(15217)
	     pUnit:RemoveEvents()
     else
     	pUnit:SendChatMessage(14, 0, "Ssserenity..at lassst!")
     end
end

RegisterUnitEvent(14507, 2, "Venoxis_OnWipe")

function Venoxis_OnDie(pUnit, event)
     pUnit:RemoveEvents()
end

RegisterUnitEvent(14507, 4, "Venoxis_OnDie")

--Parasitic Serpent AI
function Serpent_OneTimeBite(pUnit, event)
     pUnit:FullCastSpellOnTarget(23865, pUnit:GetClosestPlayer())
end

function Serpent_Bite(pUnit, event)
     pUnit:FullCastSpellOnTarget(23865, pUnit:GetClosestPlayer())
end

function Serpent_OnEnterCombat(pUnit, event)
     pUnit:RegisterEvent("Serpent_OneTimeBite", 2000, 1)
     pUnit:RegisterEvent("Serpent_Bite", 14000, 0)
end

RegisterUnitEvent(14884, 1, "Serpent_OnEnterCombat")

function Serpent_OnWipe(pUnit, event)
     pUnit:RemoveEvents()
end

RegisterUnitEvent(14884, 2, "Serpent_OnWipe")

function Serpent_OnDie(pUnit, event)
     pUnit:RemoveEvents()
end

RegisterUnitEvent(14884, 4, "Serpent_OnDie")