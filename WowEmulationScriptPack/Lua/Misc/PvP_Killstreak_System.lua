KILL = {}

TokenID = 100001

MaxKillPerStreak = 3				-- How many times a player will be rewarded killing the same other player. For example 3
--amount of token given per amount
ZeroToTenAmount = 1 --0->9
TenAmount = 5 --10
TenToTwentyAmount = 5 --11->19
TwentyAmount = 10--20
TwentyToThirtyAmount = 5--21->29
ThirtyAmount = 15--30
ThirtyToFourtyAmount = 10--31->39
FourtyAmount = 20--40
FourtyToFiftyAmount = 10--41->49
FiftyAmount = 25--50
FiftyPlusAmount = 15--51+
 
function OnPlayerKillCheck(event, player, victim)
	local map = player:GetMap():GetMapId()
	if(player ~= victim) then
		if(map ~= 30 and  map ~= 489 and map ~= 529 and map ~= 466 and map ~= 607 and map ~= 628) then
			--Killstreak
			if (KILL[player:GetName()] == nil) then
				KILL[player:GetName()] = {}
				KILL[player:GetName()].killstreak = 1
				KILL[victim:GetName()] = {}
				KILL[victim:GetName()].killstreak = 0
				player:SendBroadcastMessage("You have killed player: |cFF90EE90"..victim:GetName().."")
				player:SendBroadcastMessage("Killstreak: |cFF90EE90"..KILL[player:GetName()].killstreak.."")
				victim:SendBroadcastMessage("You have been killed by: |cFF90EE90"..player:GetName().."")
				player:AddItem(TokenID, ZeroToTenAmount)
				player:CastSpell(player,707475,true)--spawnchest
			elseif (KILL[player:GetName()].killstreak == nil) then
				KILL[player:GetName()].killstreak = 1
				KILL[victim:GetName()] = {}
				KILL[victim:GetName()].killstreak = 0
				player:SendBroadcastMessage("You have killed player: |cFF90EE90"..victim:GetName().."")
				player:SendBroadcastMessage("Killstreak: |cFF90EE90"..KILL[player:GetName()].killstreak.."")
				victim:SendBroadcastMessage("You have been killed by: |cFF90EE90"..player:GetName().."")
				player:AddItem(TokenID, ZeroToTenAmount)
				player:CastSpell(player,707475,true)--spawnchest
			else
				if (PlayerCampCheck(player, victim) == true) then
					player:CastSpell(player,707475,true)--spawnchest
					KILL[player:GetName()].killstreak = KILL[player:GetName()].killstreak + 1
					KILL[victim:GetName()] = {}
					KILL[victim:GetName()].killstreak = 0
					player:SendBroadcastMessage("You have killed player: |cFF90EE90"..victim:GetName().."")
					player:SendBroadcastMessage("Killstreak: |cFF90EE90"..KILL[player:GetName()].killstreak.."")
					victim:SendBroadcastMessage("You have been killed by: |cFF90EE90"..player:GetName().."")
					if (KILL[player:GetName()].killstreak < 10 or KILL[victim:GetName()].killstreak < 10) then
						player:AddItem(TokenID, ZeroToTenAmount)
					elseif (KILL[player:GetName()].killstreak == 10 or KILL[victim:GetName()].killstreak == 10) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02GOOD "..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end	
						player:AddItem(TokenID, TenAmount)
					elseif (KILL[player:GetName()].killstreak < 20 or KILL[victim:GetName()].killstreak < 20) then
						player:AddItem(TokenID, TenToTwentyAmount)		
					elseif (KILL[player:GetName()].killstreak == 20 or KILL[victim:GetName()].killstreak == 20) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02GREAT |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						 end
						 player:AddItem(TokenID, TwentyAmount)	
					elseif (KILL[player:GetName()].killstreak < 30 or KILL[victim:GetName()].killstreak < 30) then
						player:AddItem(TokenID, TwentyToThirtyAmount)		
					elseif (KILL[player:GetName()].killstreak == 30 or KILL[victim:GetName()].killstreak == 30) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on an |cff076C02AWESOME |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end
						player:AddItem(TokenID, ThirtyAmount)
					elseif (KILL[player:GetName()].killstreak < 40 or KILL[victim:GetName()].killstreak < 40) then
						player:AddItem(TokenID, ThirtyToFourtyAmount)		
					elseif (KILL[player:GetName()].killstreak == 40 or KILL[victim:GetName()].killstreak == 40) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02RUTHLESS |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end
						player:AddItem(TokenID, FourtyAmount)	
					elseif (KILL[player:GetName()].killstreak < 50 or KILL[victim:GetName()].killstreak < 50) then
						player:AddItem(TokenID, FourtyToFiftyAmount)		
					elseif (KILL[player:GetName()].killstreak == 50 or KILL[victim:GetName()].killstreak == 50) then
						local plrs = GetPlayersInWorld()
							for k, v in pairs(plrs) do
								v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02BRUTAL |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
							end
							player:AddItem(TokenID, FiftyAmount)
					elseif (KILL[player:GetName()].killstreak < 60 or KILL[victim:GetName()].killstreak < 60) then
						player:AddItem(TokenID, FiftyPlusAmount)		
					elseif (KILL[player:GetName()].killstreak == 60 or KILL[victim:GetName()].killstreak == 60) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02RUTHLESS |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end
						player:AddItem(TokenID, FiftyPlusAmount)		
					elseif (KILL[player:GetName()].killstreak < 70 or KILL[victim:GetName()].killstreak < 70) then
						player:AddItem(TokenID, FiftyPlusAmount)		
					elseif (KILL[player:GetName()].killstreak == 70 or KILL[victim:GetName()].killstreak == 70) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02RUTHLESS |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end
						player:AddItem(TokenID, FiftyPlusAmount)		
					elseif (KILL[player:GetName()].killstreak < 80 or KILL[victim:GetName()].killstreak < 80) then
						player:AddItem(TokenID, FiftyPlusAmount)		
					elseif (KILL[player:GetName()].killstreak == 80 or KILL[victim:GetName()].killstreak == 80) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02RUTHLESS |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end
						player:AddItem(TokenID, FiftyPlusAmount)
					elseif (KILL[player:GetName()].killstreak < 90 or KILL[victim:GetName()].killstreak < 90) then
						player:AddItem(TokenID, FiftyPlusAmount)	
					elseif (KILL[player:GetName()].killstreak == 90 or KILL[victim:GetName()].killstreak == 90) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02RUTHLESS |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end
					elseif (KILL[player:GetName()].killstreak < 100 or KILL[victim:GetName()].killstreak < 100) then
						player:AddItem(TokenID, FiftyPlusAmount)
					elseif (KILL[player:GetName()].killstreak == 100 or KILL[victim:GetName()].killstreak == 100) then
						local plrs = GetPlayersInWorld()
						for k, v in pairs(plrs) do
							v:SendAreaTriggerMessage("|cFFff0000"..player:GetName().."|cffFFCD00 is on a |cff076C02RUTHLESS |cffff0000"..KILL[player:GetName()].killstreak.."|cffFFCD00 kill streak.")
						end
						player:AddItem(TokenID, FiftyPlusAmount)
						player:AddItem(5509000,3)--give 3 paragon
						player:AddItem(159901,1)--gladiator key
					end
				else
					victim:SendBroadcastMessage("You have been killed by: |cFF90EE90"..player:GetName().."")
				end
			end
		end
	end
end	

 
function PlayerCampCheck(player, victim)
	if (KILL[player:GetName()].target == victim:GetName()) then
		KILL[player:GetName()].killcount = KILL[player:GetName()].killcount + 1
		if (KILL[player:GetName()].killcount >= MaxKillPerStreak) then
			return false
		else
			return true
		end	
		else
			KILL[player:GetName()].target = victim:GetName()
			KILL[player:GetName()].killcount = 1
			return true
	end
end	
 
RegisterPlayerEvent(6, OnPlayerKillCheck)