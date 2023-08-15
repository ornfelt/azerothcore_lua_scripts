
-- This script is part of many, they all belong to CNA WoW - www.cna-wow.com - wowcna@hotmail.com - marijnz.




-- Teleport coords
local team_map = 169
local team_x = -3367.274
local team_y = -2678.413
local team_z = 92.01
local start_score = 9



function Battleground1_OnGossipTalk(pUnit, event, player, pMisc)
	if (player:IsInCombat() == true) then
		player:SendAreaTriggerMessage("You can't join when in Combat!")
		else
			pUnit:GossipCreateMenu(3544, player, 0)
			pUnit:GossipMenuAddItem(2, "I would like to join.", 5, 0)
			pUnit:GossipMenuAddItem(2, "Tell me more about this battleground", 7, 0)			
			pUnit:GossipMenuAddItem(2, "RESERVED, bitch.", 1337, 0)
			pUnit:GossipMenuAddItem(2, "Nevermind", 2, 0)
			pUnit:GossipSendMenu(player)
	end
end

function Battleground1_OnGossipSelect(pUnit, event, player, id, intid, code)
	if(intid == 1337) then
		local p = LuaPacket:CreatePacket(0x2E4, 18)
		p:WriteWoWGuid(pUnit:GetGUID())
		p:WriteULong(30)
		player:SendPacketToPlayer(p)
	end
	if(intid == 5) then
	local Team1Towers = CharDBQuery("SELECT t1towers FROM zbg_data"):GetColumn(0):GetString()
	local Team2Towers = CharDBQuery("SELECT t2towers FROM zbg_data"):GetColumn(0):GetString()
	-- Create the Controlled Tower Stats	.
		local p = LuaPacket:CreatePacket(706,18); 
		p:WriteULong(0)
		p:WriteULong(139)
		p:WriteULong(0)
		p:WriteUShort(1)
		p:WriteULong(0)
		p:WriteULong(1)
		player:SendPacketToPlayer(p)
		local p = LuaPacket:CreatePacket(707,18)
			p:WriteULong(2328)
			p:WriteULong(Team1Towers)		-- team 1 red score
		player:SendPacketToPlayer(p)
		p = LuaPacket:CreatePacket(707,8)
			p:WriteULong(2327) 
			p:WriteULong(Team2Towers)		-- team 2 blue Score
		player:SendPacketToPlayer(p)
		player:PlaySoundToPlayer(11704) 
		player:Teleport(team_map, team_x, team_y, team_z)
	end
	if(intid == 7) then
		player:SendBroadcastMessage("You can join one of the teams, and fight against the other team, for a full explanation, look at the Documentation page at our website.") 
		player:GossipComplete()
	end
	if(intid == 2) then
		player:GossipComplete()
	end
end




RegisterUnitGossipEvent(970001, 1, "Battleground1_OnGossipTalk")
RegisterUnitGossipEvent(970001, 2, "Battleground1_OnGossipSelect")