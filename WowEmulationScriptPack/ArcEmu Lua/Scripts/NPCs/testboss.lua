local bossid = 930009
local fight_state = 0
-- This script ia simple boss script, his skills depend on group size aggroing him.
-- Dif 1 2 3 = 5 10 25 man

function Boss_OnCombat(pUnit, event)
	pUnit:RemoveEvents()
	-- Getting Information and getting to another spot.

	
		local player = pUnit:GetClosestPlayer()
		local group = player:GetGroupPlayers()

	pUnit:SendChatMessage(14, 0, "So much hate...")
		for k,v in pairs(player:GetGroupPlayers()) do
		--	v:Teleport(0, -5271.742, -1601.499, 498)
			pUnit:RegisterEvent("NPC_Phase1", 1, 0)
		end
end


function NPC_Phase1(pUnit, Event)
		
		--  Basing boss on Playeramount.
		--	pUnit:SpawnCreature(6827, -5256.742, 1515, 498, 3, 14, 0)()
			pUnit:RemoveEvents()
			pUnit:SetScale(3)
			local plc = pUnit:GetInRangePlayersCount()
			local pln = pUnit:GetInRangePlayers()
			local player = pUnit:GetClosestPlayer()
			pUnit:SetMaxHealth( 10000 * 1.20 * plc * plc)
			pUnit:SetHealth( 10000 * 1.20 * plc * plc)
		-- Damage
			local mindmg = 400 * plc - (plc*100)
			local maxdmg = 450 * plc - (plc*80)
			local atk = 2000 + plc*25
			
			pUnit:SpawnGameObject(70092, -11112.8, -1505.96, 32.8887, 1.57943, 1200000, 1)
			pUnit:SpawnGameObject(70092, -11050.4, -1503.62, 36.0835, 1.48833, 1200000, 1)
			pUnit:SpawnGameObject(70092, -11081.4, -1504.79, 32.9791, 1.56114, 1200000, 1)
			pUnit:SpawnGameObject(70092, -11018.1, -1503.92, 33.3915, 1.5518, 1200000, 1)
			local fight_state1 = 1
			
			pUnit: SetUInt32Value(UNIT_FIELD_MINDAMAGE, mindmg)
			pUnit: SetUInt32Value(UNIT_FIELD_MAXDAMAGE, maxdmg) 
		--  pUnit: setUInt32Value(UNIT_FIELD_BASEATTACKTIME, atk)
			
		for k,v in pairs(player:GetGroupPlayers()) do	
		if (plc <= 5) then	
			v:SendAreaTriggerMessage("Difficulty has been set to ##Group (5 man)##")
			local diff = 1
		end
		if (plc >= 5) and (plc <=10) then	
			v:SendAreaTriggerMessage("Difficulty has been set to ##Raid Group (10 man)##")
			local diff = 2
		end
	
		if (plc >= 10) then	
			v:SendAreaTriggerMessage("Difficulty has been set to ##Raid Group (25 man)##")
			local diff = 3
		end
		end

		pUnit:RegisterEvent("NPC_Phase1_2", 1000, 0)
		
end
function NPC_Phase1_2(pUnit, Event)
		local player = pUnit:GetClosestPlayer()
		
		if (pUnit:GetHealthPct() <= 95) then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(14, 0, "I will be the host for tonight, let's see what you're capable of...")
			for k,v in pairs(player:GetGroupPlayers()) do	
				v:SetPhase(2)
			end
			pUnit:SetPhase(2)
			pUnit:SendChatMessage(14, 0, "Check1")
			crea_x = pUnit:GetX()
			crea_y = pUnit:GetY()
			crea_z = pUnit:GetZ()
			
			pUnit:TeleportCreature(crea_x, crea_y, crea_z +1)
			pUnit:RegisterEvent("NPC_Phase1_3", 1, 0)
		end		
end


function NPC_Phase1_3(pUnit, Event)	
		if (pUnit:GetHealthPct() <= 90) then
			pUnit:RemoveEvents()
			pUnit:SendChatMessage(14, 0, "Let's do this my way!")
			pUnit:RegisterEvent("NPC_Phase2", 3000, 0)
		end
		
end


-- People are phased, but it's a boring place, let's make it a little more interesting!

function NPC_Phase2(pUnit, Event)
		pUnit:SpawnGameObject(3523, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 4000, 1)
		pUnit:SpawnGameObject(176746, -11114.316406, -1477.026978, 27.451891, 5.452373, 600000, 1)
		pUnit:SpawnGameObject(176746, -11073.503906, -1501.126587, 28.669634, 1.332952, 600000, 1)
		pUnit:SpawnGameObject(176746, -11016.575195, -1469.585571, 27.971876, 3.446460, 600000, 1)
		pUnit:SpawnGameObject(176746, -11030.684570, -1502.704712, 28.240330, 2.757666, 600000, 1)
		local fight_state2 = 1
		pUnit:SendChatMessage(14, 0, "Burn, baby, burn!")
end	


		
-- Making sure the group will all be returned save. : )		
		
function Boss_OnLeaveCombat(pUnit, event, player)
		local player = pUnit:GetClosestPlayer()
		
		if (fight_state2 == 1) then
			pUnit:GetGameObjectNearestCoords(-11114.316406, -1477.026978, 27.451891, 176746):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11073.503906, -1501.126587, 28.669634, 176746):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11016.575195, -1469.585571, 27.971876, 176746):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11030.684570, -1502.704712, 28.240330, 176746):Despawn(1,0)
		end
		
		for k,v in pairs(player:GetGroupPlayers()) do
			v:SetPhase(1)
			pUnit:SetPhase(1)
		end
			
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("NPC_remove", 3000, 1)
		
end



function Boss_OnDeath(pUnit, event, player)
		local player = pUnit:GetClosestPlayer()
		
		if (fight_state2 == 1) then
			pUnit:GetGameObjectNearestCoords(-11114.316406, -1477.026978, 27.451891, 176746):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11073.503906, -1501.126587, 28.669634, 176746):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11016.575195, -1469.585571, 27.971876, 176746):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11030.684570, -1502.704712, 28.240330, 176746):Despawn(1,0)
		end
		
		for k,v in pairs(player:GetGroupPlayers()) do
			v:SetPhase(1)
			pUnit:SetPhase(1)
		end
			
			pUnit:RemoveEvents()
			pUnit:RegisterEvent("NPC_remove", 3000, 1)
end

-- Removing any events done in the bossfight
function NPC_remove(pUnit, Event)
		
		
		if (fight_state1 == 1) then
			pUnit:GetGameObjectNearestCoords(-11050.4, -1503.62, 36.0835, 70092):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11081.4, -1504.79, 32.9791, 70092):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11018.1, -1503.92, 33.3915, 70092):Despawn(1,0)
			pUnit:GetGameObjectNearestCoords(-11112.8, -1505.96, 32.8887, 70092):Despawn(1,0)
		end

		
end		
		


RegisterUnitEvent(bossid, 1, "Boss_OnCombat")
RegisterUnitEvent(bossid, 2, "Boss_OnLeaveCombat")
RegisterUnitEvent(bossid, 4, "Boss_OnDeath")
















