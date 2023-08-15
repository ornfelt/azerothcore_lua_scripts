require 'zbg_functions'

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end


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
	item:GossipMenuAddItem(0, "Math area stuff", 2, 0)
	item:GossipMenuAddItem(0, "Showcoords", 3, 0)
	item:GossipMenuAddItem(0, "ResetCoords", 4, 0)
	item:GossipMenuAddItem(0, "UnitCheck", 5, 0)
	item:GossipMenuAddItem(0, "Calculate", 6, 0)
	item:GossipMenuAddItem(0, "EXIT", 5, 0)
	item:GossipSendMenu(player)
end

function Verdant_OnGossipSelect(item, Event, player, id, intid, code)


	if (intid == 1) then
		c = {   [0]={"game_stop","ForceGameEnd"}, 
			[1]={"game_cleandata","ForceCleanData"},
			[2]={"towers_spawn","TowerSpawns"},
			[3]={"towers_delete","TowerRemoved"},
			[4]={"game_forcestart","ForceStart"},
			[5]={"duel_start","DuelStarted"}
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
		
		t_coords = t_coords or {}
		x,y,z,o = player:GetLocation()
		c_coords = {x,y,z,o}
		coord_number = #t_coords + 1
		t_coords[coord_number] = {}
		
		i = 1
		while (i <= #c_coords) do
			table.insert(t_coords[coord_number], c_coords[i])
			--player:SendBroadcastMessage(c_coords[i])
			i = i +1
		end		
	end







if (intid == 3) then
	i = 1
	while i <= coord_number do
		for k,v in pairs(t_coords[i]) do print(k,v) end
		i = i +1
	end
end





	if (intid == 4) then
				t_coords = {}
	end

	if (intid == 5) then




	
		local tbl = player:GetInRangeObjects()
		for k,v in pairs(tbl) do


			unit_x, unit_y, unit_z, unit_o = v:GetLocation()
			

			if unit_x > x1 and unit_x < x2 and unit_y > y1 and unit_y < y2 then
			
				v:Despawn(0,0)
				player:SendBroadcastMessage("The object at "..unit_x..", "..unit_y.." has been deleted.")


			end	

	
		end






	end



	if (intid == 6) then

		
		-- Getting the lowest and highest coords of the outer area
	
		--function Outer_Extremes(v1, v2, v3, v4)
					
		--end


		x1 = round(t_coords[1][1])
		x2 = round(t_coords[1][1])
		y1 = round(t_coords[1][2])
		y2 = round(t_coords[1][2])
		player:SendBroadcastMessage(x1..", "..x2..", "..y1..", "..y2)
	
		i = 1
		while ( i <= #c_coords) do
			if (x1 > round(t_coords[i][1])) then
				x1 = round(t_coords[i][1])
			end
			i=i+1
		end

		i = 1
		while ( i <= #c_coords) do
			if (y1 > round(t_coords[i][2])) then
				y1 = round(t_coords[i][2])
			end
			i=i+1
		end
		
		i = 1
		while ( i <= #c_coords) do
			if (x2 < round(t_coords[i][1])) then
				x2 = round(t_coords[i][1])
			end
			i=i+1
		end

		i = 1
		while ( i <= #c_coords) do
			if (y2 < round(t_coords[i][2])) then
				y2 = round(t_coords[i][2])
			end
			i=i+1
		end



		player:SendBroadcastMessage("x1= "..x1.."x2= "..x2.."y1= "..y1.."y2= "..y2)

		-- Getting lengths of area lines

		function Pyth(v1, v2, v3, v4)
			return round(math.sqrt((math.abs(t_coords[v1][1] - t_coords[v2][1]))^2 + (math.abs(t_coords[v1][2] - t_coords[v2][2]))^2))		
		end
		AB = Pyth(1,2)
		BC = Pyth(2,3)
		CD = Pyth(3,4)
		DA = Pyth(4,1)	
		opp = (AB * BC + CD * DA) /2

		player:SendBroadcastMessage(AB.." - "..BC.." - "..CD.." - "..DA.." - "..opp)

		



		--[[	
		--ACD


		side1 = 2[x] - 1[x]
		side2 = 3[y] - 2[y]
		side3 = 3[x] - 4[x]
		side4 = 4[x] - 1[x]
		i = 1[x]
		while i<= side1 do
			i = i +1
			player:SendBroadcastMessage(i)
		end
			


		xy1 = math.sqrt(x^2 + y^2)
		player:SendBroadcastMessage(xy1)]]
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


















