require 'zbg_functions'

--[[ Unused Tables!
local ST = {
		[1]= {
			[1] = {x = "xcoord", y = "ycoord", "zcoord"},
			[2] = {x = "xcoord", y = "ycoord", "zcoord"},
			[3] = {x = "xcoord", y = "ycoord", "zcoord"},
			[4] = {x = "xcoord", y = "ycoord", "zcoord"},
			[5] = {x = "xcoord", y = "ycoord", "zcoord"},
			[6] = {x = "xcoord", y = "ycoord", "zcoord"}
			},
		[2]= {
			[1] = {970100,-3504,786,92,1,35,0},
			[2] = {970100,-3504,786,92,1,35,0},
			[3] = {970100,-3504,786,92,1,35,0},
			[4] = {970100,-3504,786,92,1,35,0},
			[5] = {970100,-3504,786,92,1,35,0},
			[6] = {970100,-3504,786,92,1,35,0},	
			}	
	
		}
]]


------------
--[Script]--
------------




function Verdant_Gossip(item, event, player)

local PlayerName = player:GetName()
local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
-- local PlayerCoins = CharDBQuery("SELECT coins FROM zbg_players WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
local GmRank = CharDBQuery("SELECT gm FROM accounts WHERE acct = '"..GetPlayerGUID.."'"):GetColumn(0):GetString()
	item:GossipCreateMenu(50, player, 0)
	item:GossipMenuAddItem(0, "Exectute Verdant Command.", 1, 1)
	item:GossipMenuAddItem(0, "Test1", 2, 0)
	item:GossipMenuAddItem(0, "Test3", 3, 0)
	item:GossipMenuAddItem(0, "Test4", 4, 0)
	item:GossipMenuAddItem(0, "EXIT", 5, 0)
	item:GossipSendMenu(player)
end

function Verdant_OnGossipSelect(item, Event, player, id, intid, code)
	if (intid == 1) then
		c = {   [0]={"game_stop","ForceGameEnd"}, 
			[1]={"game_cleandata","ForceCleanData"},
			[2]={"towers_spawn","TowerSpawns"},
			[3]={"towers_delete","TowerRemoved"},
			[4]={"game_forcestart","ForceStart"}
			}
		if (code ~= nil) and (code ~= "") then
			tb = 0 valid = "false"
			while (tb <= #c) do			
				if (code == c[tb][1]) then
					player:SendBroadcastMessage("You have executed the following command:"..c[tb][1]);			
					RegisterTimedEvent(c[tb][2], 1000, 1)
					valid = "true"	
				end
			tb = tb+1			
			end
			if valid ~= "true" then
				tb = 0
				player:SendBroadcastMessage("No valid command given, the commands:")
				while (tb <= #c) do
					player:SendBroadcastMessage(c[tb][1].."   -   "..c[tb][2])
					tb = tb+1	
				end
			end
		else
			player:SendBroadcastMessage("Please enter a valid command.")
		end
		player:GossipComplete()
	end
	if (intid == 2) then
		RegisterTimedEvent("RegisterStuffTimer", 1000, 0)
	end
if (intid == 4) then
	GameAnnouncer(DuelCountdown);
end
	if (intid == 3) then
		player:SendBroadcastMessage(os.difftime(os.time(), t1))
	end
end

function RegisterStuffTimer(item,event)
	RegisterStuff(30, player, item)
end
i = 0
function RegisterStuff(howoften, player, misc)
	max = howoften * howoften divide = howoften 	

		y = math.floor(math.sin(i*math.pi/divide) * 10^8 + 0.5) / 10^8
		if  y == 0 then
			-- do stuff here ---------
			GameAnnouncer(i.."  -  "..max);
			--------------------------				
		end
		i = i+1
end

RegisterItemGossipEvent(90014, 1, "Verdant_Gossip")
RegisterItemGossipEvent(90014, 2, "Verdant_OnGossipSelect")