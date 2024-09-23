local function RexxarHello(event, player, creature)
	if (player:GetClass() ~= 3) then
		player:GossipMenuAddItem(0, "Nevermind", 65015, 0)
	else
		player:GossipMenuAddItem(0, "Show me a beast", 65015, 1, true, "Enter the creature ID you would like to see by using command `.lo creature <name>`")
		player:GossipMenuAddItem(0, "Show me a random beast!", 65015, 2)
		player:GossipMenuAddItem(0, "Tame this beast", 65015, 3)
	end
	player:GossipSendMenu(65015, creature, MenuId)
end


-- this script grabs a list of creatures using below queries, changing modelid where appropriate while targeting a dummy called 'Beastmaster's Training Dummy'
local function RexxarSelect(event, player, creature, sender, intid, code)
	local RexxarDummy = creature:GetCreaturesInRange(50, 1000020)
	if (intid == 1) then
		local Rexxar_Query1 = WorldDBQuery("SELECT `modelid1` FROM `creature_template` WHERE `entry` = '" ..code.. "' AND `family` != 0 AND `type` = 1;")
		if (tonumber(code) == nil) then
			player:SendBroadcastMessage("You must input a number.")
		elseif (Rexxar_Query1 == nil) then
			player:SendBroadcastMessage("You must enter a valid beast's entry ID.")
		else
			RexxarDummy[1]:SetDisplayId(Rexxar_Query1:GetInt32(0))
			RexxarDummy[1]:CastSpell(RexxarDummy[1], 60034, true)
			RexxarDummy[1]:Emote(35)
		end
	elseif (intid == 2) then
		local Rexxar_Query2 = WorldDBQuery("SELECT `modelid1` FROM `creature_template` WHERE `family` != 0 AND `type` = 1;")
		if (Rexxar_Query2 == nil) then
			PrintInfo("[RexxarBeastmaster.lua]: There was an error in processing the random beast function. Your creature_template table is missing any beast entry.")
		else
			local rando = (math.random(1,Rexxar_Query2:GetRowCount()) + 1)
			for x=1,rando,1 do
				if (x == (rando - 1)) then
					RexxarDummy[1]:SetDisplayId(Rexxar_Query2:GetInt32(0))
					RexxarDummy[1]:CastSpell(RexxarDummy[1], 60034, true)
					RexxarDummy[1]:Emote(35)
				else
					Rexxar_Query2:NextRow()
				end
			end
		end
	elseif (intid == 3) then
		if (tostring(player:GetPetGUID()) == "0") then -- tostring has to be used because tonumber isn't available on "userdata" types, the kind that eluna returns for GUID.
			local Rexxar_Query3 = WorldDBQuery("SELECT `entry` FROM `creature_template` WHERE `modelid1` = " ..RexxarDummy[1]:GetDisplayId().. " AND `family` != 0 AND `type` = 1;")
			PerformIngameSpawn(1, Rexxar_Query3:GetInt32(0), player:GetMapId(), 0, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 3)
			local newpet = creature:GetCreaturesInRange(3, Rexxar_Query3:GetInt32(0))
			player:CastSpell(newpet[1], 2650, true) 
		else
			player:SendBroadcastMessage("Please abandon your current pet first.")
		end
	end
	player:GossipClearMenu()
	player:GossipComplete()	
end

RegisterCreatureGossipEvent(1000021, 1, RexxarHello)
RegisterCreatureGossipEvent(1000021, 2, RexxarSelect)