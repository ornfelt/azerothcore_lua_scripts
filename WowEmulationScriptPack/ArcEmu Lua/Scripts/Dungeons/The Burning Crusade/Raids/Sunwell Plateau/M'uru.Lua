--[[ Boss - Muru.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, August 24, 2008. ]]

function Muru_OnEnterCombat(Unit, Event)
	Unit:SetCombatMeleeCapable(1) 
	Unit:RegisterEvent("Muru_NegativeEnergy",2000,0)
	Unit:RegisterEvent("Muru_Darkness",45000,0)
	Unit:RegisterEvent("Muru_VoidSentinel",30000,0)
	Unit:RegisterEvent("Muru_Summonset",60000,0)
	Unit:RegisterEvent("Muru_Enrage",6000000,0)
	Unit:StopMovement()
end

function Muru_NegativeEnergy(Unit, event)
   Unit:CastSpellOnTarget(46008, Unit:GetRandomPlayer(0))
end

function Muru_Darkness(Unit, event)
   Unit:CastSpell(45996)
end

function Muru_Enrage(Unit, Event)
    Unit:CastSpell(26662)
end

function Muru_Summonset(Unit, Event)
Choice=math.random(1, 2)
	if Choice==1 then
		Unit:SpawnCreature(25798, 1781.98, 665.4370, 71.2, 5.23, 16,0)
        Unit:SpawnCreature(25798, 1777.76, 662.8, 71.2, 5.21, 16,0)
        Unit:SpawnCreature(25799, 1848.0813, 598.78, 71.3143, 2.4368, 16,0)
end   
	if Choice==2 then
        Unit:SpawnCreature(25799, 1781.98, 665.4370, 71.2, 5.23, 16,0)
        Unit:SpawnCreature(25798, 1849.64, 595.196, 71.3143, 2.4886, 16,0)
        Unit:SpawnCreature(25798, 1848.0813, 598.78, 71.3143, 2.4368, 16,0)
	end
end

function Muru_VoidSentinel(Unit, Event)
Choice=math.random(1, 2)
if Choice==1 then
         Unit:SpawnCreature(25772, 1796.94 ,605.072, 71.203, 0.67, 16,0)
end   
if Choice==2 then
         Unit:SpawnCreature(25772, 1838.32 ,650.789, 71.243, 4.26, 16,0)
end
end

function Muru_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Muru_OnDied(Unit, Event)
	Unit:CastSpell(46217)
	Unit:RemoveFromWorld()
	Unit:RemoveEvents()
end

RegisterUnitEvent(25741, 1, "Muru_OnEnterCombat")
RegisterUnitEvent(25741, 2, "Muru_OnLeaveCombat")
RegisterUnitEvent(25741, 4, "Muru_OnDied")


--Entropius
function Entropius_OnEnterCombat(Unit, Event)
Unit:RegisterEvent("Entropius_NegativeEnergy",4000,0)
Unit:RegisterEvent("Entropius_Darkness",45000,0)
Unit:RegisterEvent("Entropius_BlackHole",150000,0)
Unit:RegisterEvent("Entropius_Enrage",6000000,0)
end

function Entropius_NegativeEnergy(Unit, event)
   Unit:CastSpellOnTarget(46289, Unit:GetRandomPlayer(0))
   Unit:CastSpellOnTarget(46289, Unit:GetRandomPlayer(0))
   Unit:CastSpellOnTarget(46289, Unit:GetRandomPlayer(0))
   Unit:CastSpellOnTarget(46289, Unit:GetRandomPlayer(0))
   Unit:CastSpellOnTarget(46289, Unit:GetRandomPlayer(0))
end

function Entropius_Enrage(Unit, Event)
        Unit:CastSpell(26662)
end

function Entropius_Darkness(Unit, Event)
        Unit:FullCastSpellOnTarget (45141, Unit:GetRandomPlayer(0))   
end

function Entropius_BlackHole(Unit, Event)
   x = Unit:GetX ()
   y = Unit:GetY ()
   z = Unit:GetZ ()
   o = Unit:GetO ()
   Unit:SpawnCreature(25855, x-1, y, z, o, 16, o)
   Unit:SpawnCreature(25855, x+1, y, z, o, 16, o)
   Unit:CastSpellOnTarget(45996, Unit:GetRandomPlayer(0))
end

function Entropius_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Entropius_OnDied(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(25840, 1, "Entropius_OnEnterCombat")
RegisterUnitEvent(25840, 2, "Entropius_OnLeaveCombat")
RegisterUnitEvent(25840, 4, "Entropius_OnDied")


------------------------Summon
--Summonmove
function Summonmove(Unit)   
   Unit:MoveTo(1815.3, 625.193, 69.6075, 2.3)
end

RegisterUnitEvent(25798,6,"Summonmove")
RegisterUnitEvent(25799,6,"Summonmove")

--VoidSentinel 25772

function VoidSentinel1_OnEnterCombat(Unit, Event)
Unit:RegisterEvent("VoidSentinel1_ShadowPulsePeriodic",7000,0)
Unit:RegisterEvent("VoidSentinel1_VoidBlast",3000,0)
Unit:Despawn(60000, 0)
end

function VoidSentinel1_ShadowPulsePeriodic(Unit, Event)
        Unit:CastSpellOnTarget (46086,Unit:GetRandomPlayer(0))
end

function VoidSentinel1_VoidBlast(Unit, Event)
        Unit:FullCastSpellOnTarget (46161,Unit:GetRandomPlayer(1))
end

function VoidSentinel1_OnDied(Unit, Event)
   x = Unit:GetX ()
   y = Unit:GetY ()
   z = Unit:GetZ ()
   o = Unit:GetO ()
   Unit:SpawnCreature(25782, x-1, y, z, o, 16, o)
   Unit:SpawnCreature(25782, x+1, y, z, o, 16, o)
   Unit:SpawnCreature(25782, x, y-1, z, o, 16, o)
   Unit:SpawnCreature(25782, x, y+1, z, o, 16, o)
   Unit:SpawnCreature(25782, x-3, y, z, o, 16, o)
   Unit:SpawnCreature(25782, x+5, y, z, o, 16, o)
end

function VoidSentinel1_spawndisplay(Unit, Event)
Unit:SetModel(22742)
end

function VoidSentinel1_moveset(Unit)   
        Unit:RegisterEvent("VoidSentinel1_spawndisplay",1000,1)
   Unit:RegisterEvent("VoidSentinel1_move",4000,0)
end

function VoidSentinel1_move(Unit, Event)
   Unit:MoveTo(1815.3, 625.193, 69.6075, 2.3)
        Unit:SetModel(23372)
end

RegisterUnitEvent(25772, 1, "VoidSentinel1_OnEnterCombat")
RegisterUnitEvent(25772, 4, "VoidSentinel1_OnDied")
RegisterUnitEvent(25772, 6, "VoidSentinel1_moveset")

--VoidSentinel2 summon

function VoidSentinel2_OnEnterCombat(Unit, Event)
Unit:RegisterEvent("VoidSentinel2_ShadowBoltVolley",5000,0)
Unit:Despawn(30000, 0)
end

function VoidSentinel2_ShadowBoltVolley(Unit, Event)
        Unit:FullCastSpellOnTarget (46082,Unit:GetRandomPlayer(1))
end

function VoidSentinel2_OnDied(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(25782, 1, "VoidSentinel2_OnEnterCombat")
RegisterUnitEvent(25782, 4, "VoidSentinel2_OnDied")

--Summon shadow FuryMage

function SummonFuryMage_OnEnterCombat(Unit, Event)
Unit:RegisterEvent("SummonFuryMage_FelFireball",5000,0)
Unit:RegisterEvent("SummonFuryMage_SpellFury",5000,0)
end

function SummonFuryMage_FelFireball(Unit, Event)
        Unit:FullCastSpellOnTarget (46101,Unit:GetRandomPlayer(1))
end

function SummonFuryMage_SpellFury(Unit, Event)
        Unit:FullCastSpellOnTarget (46102,Unit:GetRandomPlayer(1))
end


function SummonFuryMage_OnDied(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(25798, 1, "SummonFuryMage_OnEnterCombat")
RegisterUnitEvent(25798, 4, "SummonFuryMage_OnDied")

--Summon shadow Berserk

function SummonBerserk_OnEnterCombat(Unit, event)
Unit:RegisterEvent("SummonBerserk_Flurry", math.random(25000, 30000),0)
end

function SummonBerserk_Flurry(Unit, event)
   pUnit:CastSpell(46160)
end

function SummonBerserk_OnDied(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(25798, 1, "SummonBerserk_OnEnterCombat")
RegisterUnitEvent(25798, 4, "SummonBerserk_OnDied")