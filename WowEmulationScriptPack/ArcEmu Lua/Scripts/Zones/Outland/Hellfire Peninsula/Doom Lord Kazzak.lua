--[[ Doomlord Kazzak.lua
********************************
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
math.randomseed(os.time())

-- Doom Lord Kazzak script by Ikillonyxia.
function DoomlordKazzak_ShadowboltVolleyRepeat(Unit, event)
    	Unit:CastSpell(29924)
    	Unit:RegisterEvent("DoomlordKazzak_ShadowboltVolley", math.random(18000, 20000), 1)
end

function DoomlordKazzak_ShadowboltVolley(Unit, event)
    	Unit:CastSpell(29924)
    	Unit:RegisterEvent("DoomlordKazzak_ShadowboltVolleyRepeat", math.random(18000, 20000), 1)
end

function DoomlordKazzak_TwistedReflectionCheck(Unit, event)
     if ( twistedreflectplayer:GetHealthPct() < playercurrenthp ) and ( twistedreflectplayer:HasAura(21063) == true ) and ( twistedreflectplayer:IsAlive() ) then
     	Unit:CastSpell(21064)
     	twistedreflectplayer:RemoveAura(21063)
     end
end

function DoomlordKazzak_TwistedReflection(Unit, event)
     twistedreflectplayer=Unit:GetRandomPlayer(0);
     playercurrenthp=twistedreflectplayer:GetHealthPct();
    	Unit:FullCastSpellOnTarget(21063, twistedreflectplayer)
    	Unit:RegisterEvent("DoomlordKazzak_TwistedReflectionCheck", 1000, 45)
end    

function DoomlordKazzak_Thunderclap(Unit, event)
    	Unit:FullCastSpell(36706)
end

function DoomlordKazzak_Cleave(Unit, event)
    	Unit:FullCastSpellOnTarget(31043,	Unit:GetMainTank())
end

function DoomlordKazzak_Enrage(Unit, event)
    	Unit:FullCastSpell(32964)
end

function DoomlordKazzak_MarkOfKazzakVarCheck(Unit, event)
     if explode == 1 then
     	explode=nil;
     end
end

function DoomlordKazzak_MarkOfKazzakExplodeCheck(Unit, event)
     if markofkazzaktarget:GetManaPct() < 1 and explode == nil then
     	explode=1;
     	Unit:SpawnCreature(70099, markofkazzaktarget:GetX(), markofkazzaktarget:GetY(), markofkazzaktarget:GetZ(), 90, 14, 0)
     end
end     

function DoomlordKazzak_MarkOfKazzakDrain(Unit, event)
     local a=markofkazzaktarget:GetMaxMana() / (20)
     if markofkazzaktarget:GetManaPct() < 6 then
     	markofkazzaktarget:SetMana(markofkazzaktarget:GetMana() - markofkazzaktarget:GetMana())
     else
     	markofkazzaktarget:SetMana(markofkazzaktarget:GetMana() - a)
     end
end

function DoomlordKazzak_MarkOfKazzak(Unit, event)
	markofkazzaktarget=Unit:GetRandomPlayer(4);
       	Unit:FullCastSpellOnTarget(32960, markofkazzaktarget)
	Unit:RegisterEvent("DoomlordKazzak_MarkOfKazzakDrain", 1000, 10)
	Unit:RegisterEvent("DoomlordKazzak_MarkOfKazzakExplodeCheck", 1001, 10)
	Unit:RegisterEvent("DoomlordKazzak_MarkOfKazzakVarCheck", 10200, 1)
end

function DoomlordKazzak_Voidbolt(Unit, event)
     if	Unit:GetDistance(Unit:GetClosestPlayer()) > 10 then
     	Unit:FullCastSpellOnTarget(21066,	Unit:GetRandomPlayer(0))
     end
end

function DoomlordKazzak_OnEnterCombat(Unit, event)
    	Unit:RegisterEvent("DoomlordKazzak_ShadowboltVolley", math.random(18000, 20000), 1)
    	Unit:RegisterEvent("DoomlordKazzak_TwistedReflection", 25000, 0)
    	Unit:RegisterEvent("DoomlordKazzak_Thunderclap", 14800, 0)
    	Unit:RegisterEvent("DoomlordKazzak_Cleave", 9000, 0)
    	Unit:RegisterEvent("DoomlordKazzak_Enrage", 54000, 0)
    	Unit:RegisterEvent("DoomlordKazzak_MarkOfKazzak", 29000, 0)
    	Unit:RegisterEvent("DoomlordKazzak_Voidbolt", 2000, 0)
     if math.random(1, 2) == 1 then
     	Unit:SendChatMessage(14, 0, "All mortals will perish!")
     	Unit:PlaySoundToSet(11334)
     else
    	Unit:SendChatMessage(14, 0, "The Legion will conquer all!")
     	Unit:PlaySoundToSet(11333)
     end
end

RegisterUnitEvent(18728, 1, "DoomlordKazzak_OnEnterCombat")

function DoomlordKazzak_Wipe(Unit, event)
    	Unit:RemoveEvents()
end

RegisterUnitEvent(18728, 2, "DoomlordKazzak_Wipe")

function DoomlordKazzak_KillsPlayer(Unit, event, pMisc)
    	Unit:SendChatMessage(14,0,"Your own strength feeds me, "..pMisc:GetName().."!")
    	Unit:FullCastSpell(32966)
end

RegisterUnitEvent(18728, 3, "DoomlordKazzak_KillsPlayer")

function DoomlordKazzak_Dies(Unit, event)
    	Unit:RemoveEvents()
    	Unit:SendChatMessage(14, 0, "The Legion... will never... fall.")
    	Unit:PlaySoundToSet(11340)
end

RegisterUnitEvent(18728, 4, "DoomlordKazzak_Dies")

function DoomlordKazzak_Spawn(Unit, event)
    	Unit:SendChatMessage(14, 0, "I remember well the sting of defeat at the conclusion of the Third War. I have waited far too long for my revenge. Now the shadow of the Legion falls over this world. It is only a matter of time until all of your failed creation... is undone.")
    	Unit:PlaySoundToSet(11332)
end

RegisterUnitEvent(18728, 18, "DoomlordKazzak_Spawn")

-- Mark of Kazzak explosion AI
function MarkOfKazzakExplosion_OnSpawn(Unit, event)
    	Unit:SetCombatMeleeCapable(1)
    	Unit:SetCombatTargetingCapable(1)
		Unit:DisableRespawn(1)
    	Unit:FullCastSpell(32961)
    	Unit:Despawn(100, 0)
end

RegisterUnitEvent(70099, 18, "MarkOfKazzakExplosion_OnSpawn")

