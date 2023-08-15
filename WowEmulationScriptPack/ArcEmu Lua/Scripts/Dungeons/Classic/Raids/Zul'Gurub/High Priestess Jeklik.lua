--[[ HighPriestessJeklik.lua
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

--Jeklik begins the encounter in bat form. In this form she has an AoE silence that also damages. 
--She randomly charges people in the group, and summons 6-8 bloodseeker bats once per minute. (Added the 6-8 Spawns, Please correct the spawn part if wrong (Deathdude)
--When she drops below 50% HP, she reverts to priest form. 
--Here she casts Shadow Word: Pain, Mind Flay, Chain Mind Flay and Greater Heal. 
--She also summons bomb bats which drop fire bombs on the ground which AoE DoT those inside.
--Somewhere in the script (Need to watch a video to find out) she yells "I command you to rain fire down upon these invaders!" (Deathdude)

math.randomseed(os.time())

function JeklikBat_Summon(Unit, event)
     Unit:SpawnCreature(14965, -12291.9, -1380.18, 145.002, 2.28638, 14, 0)
     Unit:SpawnCreature(14965, -12291.7, -1380.16, 145.002, 2.28638, 14, 0)
     Unit:SpawnCreature(14965, -12291.5, -1380.14, 145.002, 2.28638, 14, 0)
     Unit:SpawnCreature(14965, -12291.3, -1380.12, 145.002, 2.28638, 14, 0)
     Unit:SpawnCreature(14965, -12291.1, -1380.10, 145.002, 2.28638, 14, 0)
     Unit:SpawnCreature(14965, -12290.9, -1380.08, 145.002, 2.28638, 14, 0)
end

function Jeklik_ShadowWordPain(Unit, event)
     Unit:FullCastSpellOnTarget(23952, Unit:GetRandomPlayer(0))
end

function Jeklik_MindFlay(Unit, event)
     Unit:FullCastSpellOnTarget(23953, Unit:GetRandomPlayer(0))
end

function Jeklik_GreatHeal(Unit, event)
     Unit:FullCastSpell(23954)
end

function Jeklik_MoveCheck(Unit, event)
     local args=getvars(Unit)
     Unit:WipeThreatList()
     Unit:ModifyRunSpeed(8)
     Unit:ModifyWalkSpeed(8)
     Unit:SetCombatTargetingCapable(0)
     Unit:ModThreat(args.chargetarget, 1000)
end

function Jeklik_Charge(Unit, event)
     setvars(Unit, {chargetarget=Unit:GetRandomPlayer(0)})
     local args=getvars(Unit)
     Unit:FullCastSpellOnTarget(22911, args.chargetarget)
     Unit:SetCombatTargetingCapable(1)
     Unit:ModifyRunSpeed(300)
     Unit:ModifyWalkSpeed(300)
     Unit:MoveTo(args.chargetarget:GetX(), args.chargetarget:GetY(), args.chargetarget:GetZ(), args.chargetarget:GetO())
     Unit:CastSpell(8281)
     Unit:RegisterEvent("Jeklik_MoveCheck", 1000, 1)
end

function Jeklik_Phase2(Unit, event)
     if Unit:GetHealthPct() < 51 then
     Unit:RemoveEvents()
     Unit:SetModel(15219)
     Unit:RegisterEvent("Jeklik_ShadowWordPain", 15000, 0)
     Unit:RegisterEvent("Jeklik_MindFlay", 22000, 0)
     Unit:RegisterEvent("Jeklik_GreatHeal", 46000, 0)
     end
end

function Jeklik_FearRepeat(Unit, event)
     Unit:CastSpell(6605)
     Unit:RegisterEvent("Jeklik_Fear", math.random(22000, 35000), 1)
end

function Jeklik_Fear(Unit, event)
     Unit:CastSpell(6605)
     Unit:RegisterEvent("Jeklik_FearRepeat", math.random(22000, 35000), 1)
end

function Jeklik_OnCombat(Unit, event)
     Unit:SendChatMessage(14, 0, "Lord Hir'eek, grant me wings of vengeance!")
     Unit:SetModel(15191)
     Unit:RegisterEvent("JeklikBat_Summon", 60000, 0)
     Unit:RegisterEvent("Jeklik_Phase2",1000,0)
     Unit:RegisterEvent("Jeklik_Fear", math.random(15000, 35000), 1)
     Unit:RegisterEvent("Jeklik_Charge", 28000, 0)
end

function Jeklik_OnLeaveCombat(Unit, event)
     if Unit:IsAlive() == true then
     Unit:RemoveEvents()
     Unit:SetModel(15191)
     else
     Unit:RemoveEvents()
     end
end

function Jeklik_OnDied(Unit)
     Unit:RemoveEvents()
     Unit:SendChatMessage(14, 0, "Finally...death! Curse you, Hakkar! Curse you! ")
end



RegisterUnitEvent(14517,1,"Jeklik_OnCombat")
RegisterUnitEvent(14517,2,"Jeklik_OnLeaveCombat")
RegisterUnitEvent(14517,4,"Jeklik_OnDied")

--Bloodseeker Bats move AI.
function BloodseekerBat_PositionCheck(pUnit, event)
     if pUnit:IsCreatureMoving() == true then
		local tbl = pUnit:GetInRangeFriends()
		for k,v in pairs(tbl) do
			if v:GetEntry() == 14517 then
				pUnit:MoveTo(v:GetX(), v:GetY(), v:GetZ(), v:GetO())
			else
				pUnit:RemoveEvents()
			end
		end
	end
end  

function BloodseekerBat_OnSpawn(pUnit, event)
     local tbl = pUnit:GetInRangeFriends()
     for k,v in pairs(tbl) do
		if v:GetEntry() == 14517 then
			pUnit:ModifyWalkSpeed(14)
			pUnit:MoveTo(v:GetX(), v:GetY(), v:GetZ(), v:GetO())
			pUnit:RegisterEvent("BloodseekerBat_PositionCheck", 2000, 0)
		end
	end
end

RegisterUnitEvent(14965, 18, "BloodseekerBat_OnSpawn")

function BloodseekerBat_OnWipe(pUnit, event)
     if pUnit:IsAlive() == true then
		pUnit:RemoveEvents()
		pUnit:Despawn(100, 0)
	 else
		pUnit:RemoveEvents()
     end
end

RegisterUnitEvent(14965, 2, "BloodseekerBat_OnWipe")