local BossIDMap555 = 18708
local BossIDMap556 = 18473
local BossIDMap557 = 18344
local BossIDMap558 = 18373

--item ID, Spell ID, chest cost value(possibly can be negative?)
affixes = { 
["Fortified  	Level 1  	(10% Health)"] 				  = {197030,707011,1},
["Maniac  		Level 1  	(10% Damage)"] 				  = {197040,707012,1},
["Chaotic  		Level 5  	(Random Enchants)"]			  = {197050,707013,5},
["Revival  		Level -1  	(-10% Health)"] 			  = {197060,707014,-1},
["Survival  	Level -1  	(-10% Health)"] 			  = {197070,707015,-1},
["Tyrannical  	Level 1  	(10% Attack Speed)"] 		  = {197080,707021,1},
["Singulatiry  	Level 1  	(10% Movement Speed)"] 	  	  = {197090,707022,1},
["Tuskarr 	 	Level 0  	(Cosmetic - Tuskarr)"] 		  = {197110,707023,1},
--["affix9"] = {197100,707025,1},
["Hysteria  	Level 5  	(Random Shazzian Behemoths)"] = {197120,707029,5},
["Inferno	  	Level 5  	(Aoe Damage and Knockbacks)"] = {197130,707030,5},
["Bursting	  	Level 5  	(Deal 3% max hp/sec for 4s)"] = {197140,707031,5},
["Destruction	Level 5  	(Attacks AOE Cleave fire)  "] = {197150,66725,5},
["Fortified  	Level 2  	(20% Health)"] 				  = {198030,707111,2},
["Maniac  		Level 2  	(20% Damage)"] 				  = {198040,707112,2},
["Revival  		Level -2  	(-20% Health)"] 			  = {198060,707114,-2},
["Survival  	Level -2  	(-20% Health)"] 			  = {198070,707115,-2},
["Tyrannical  	Level 2  	(20% Attack Speed)"] 		  = {198080,707116,2},
["Singulatiry  	Level 2  	(20% Movement Speed)"] 	  	  = {198090,707117,2},
["Fortified  	Level 3  	(30% Health)"] 				  = {199030,707211,3},
["Maniac  		Level 3  	(30% Damage)"] 				  = {199040,707212,3},
["Revival  		Level -3  	(-30% Health)"] 			  = {199060,707214,-3},
["Survival  	Level -3  	(-30% Health)"] 			  = {199070,707215,-3},
["Tyrannical  	Level 3  	(30% Attack Speed)"] 		  = {199080,707216,3},
["Singulatiry  	Level 3  	(30% Movement Speed)"] 	  	  = {199090,707217,3},
["Fortified  	Level 4  	(40% Health)"] 				  = {200030,707311,4},
["Maniac  		Level 4  	(40% Damage)"] 				  = {200040,707312,4},
["Revival  		Level -4  	(-40% Health)"] 			  = {200060,707314,-4},
["Survival  	Level -4  	(-40% Health)"] 			  = {200070,707315,-4},
["Tyrannical  	Level 4  	(40% Attack Speed)"] 		  = {200080,707316,4},
["Singulatiry  	Level 4  	(40% Movement Speed)"] 	  	  = {200090,707317,4},
["Fortified  	Level 5  	(50% Health)"] 				  = {201130,707411,5},
["Maniac  		Level 5  	(50% Damage)"] 				  = {201140,707412,5},
["Revival  		Level -5  	(-50% Health)"] 			  = {201160,707414,-5},
["Survival  	Level -5  	(-50% Health)"] 			  = {201170,707415,-5},
["Tyrannical  	Level 5  	(50% Attack Speed)"] 		  = {201080,707416,5},
["Singulatiry  	Level 5  	(50% Movement Speed)"] 	  	  = {201090,707417,5}
}

chest555 = { --cost,chest ID,x,y,z,o
["Level 1 Chest"] = {1,1970300,-164.209,-507.101,17.077,1.57},
["Level 5 Chest"] = {5,1970400,-158.209,-507.101,17.077,1.57},
["Level 10 Chest"] = {10,1970500,-170.209,-507.101,17.077,1.57},
["Level 25 Chest"] = {25,1972300,-164.209,-507.101,17.077,1.57},
["Level 50 Chest"] = {50,1972400,-149.209,-507.101,17.077,1.57},
["Level 75 Chest"] = {75,1972500,-179.209,-507.101,17.077,1.57},
}
chest556 = { --cost,chest ID,x,y,z,o
["Level 1 Chest"] = {1,1970600,67.662,286.57,25.05,3.1},
["Level 5 Chest"] = {5,1970700,67.662,280.57,25.05,3.1},
["Level 10 Chest"] = {10,1970800,67.662,292.83,25.05,3.1},
["Level 25 Chest"] = {25,1972600,44.68,309.99,25.05,4.7},
["Level 50 Chest"] = {50,1972700,50.60,309.99,25.05,4.7},
["Level 75 Chest"] = {75,1972800,38.90,309.99,25.05,4.7},
}
chest557 = { --cost,chest ID,x,y,z,o
["Level 1 Chest"] = {1,1970900,-177.0938,9.217,16.759,3.1},
["Level 5 Chest"] = {5,1971000,-177.0938,3.217,16.759,3.17},
["Level 10 Chest"] = {10,1971100,-177.0938,15.217,16.759,3.1},
["Level 25 Chest"] = {25,1972900,-171.0938,9.217,16.759,3.1},
["Level 50 Chest"] = {50,1973000,-171.0938,3.217,16.759,3.17},
["Level 75 Chest"] = {75,1973100,-171.0938,15.217,16.759,3.1},
}
chest558 = { --cost,chest ID,x,y,z,o
["Level 1 Chest"] = {1,1971200,77.23,-387.925,26.59,3.1},
["Level 5 Chest"] = {5,1971300,77.23,-381.925,26.59,3.1},
["Level 10 Chest"] = {10,1971400,77.23,-393.925,26.59,3.1},
["Level 25 Chest"] = {25,1973200,77.23,-387.925,26.59,3.1},
["Level 50 Chest"] = {50,1973300,77.23,-372.925,26.59,3.1},
["Level 75 Chest"] = {75,1973400,77.23,-393.925,26.59,3.1},
}

cloaks = { --item ID, Spell ID
["cloak1"] = {995656,707019},
["cloak2"] = {995661,707020},
["cloak3"] = {995662,707016},
["cloak4"] = {995663,707017},
["cloak5"] = {995664,707018},
["cloak6"] = {995665,707463}
}

local function OnMapChange(event, player)
	local playerMap = player:GetMap():GetMapId()
    player:UnbindAllInstances()
	
	for e in pairs(cloaks) do
        player:RemoveAura(cloaks[e][2])
    end
	
	if playerMap == 555 then
        if(player:HasItem(652358)) then
            player:RemoveItem(652358,1)
        end
    elseif playerMap == 556 then
        if(player:HasItem(505059)) then
            player:RemoveItem(505059,1)
        end
    elseif playerMap == 557 then
        if(player:HasItem(505060)) then
            player:RemoveItem(505060,1)
        end
    elseif playerMap == 558 then
        if(player:HasItem(505061)) then
            player:RemoveItem(505061,1)
        end
    end
	
end
local function testreset(event, instance_data, map, diff)
    runner(map)
end

local function itemEquip(event, player, item, bag, slot)
    for e in pairs(cloaks) do
        player:RemoveAura(cloaks[e][2])
    end
end

function runner (map)
    local mapPlayers = map:GetPlayers()
	local isPlayer = false
	for i,v in ipairs(mapPlayers) do
		for q,m in ipairs(v:GetCreaturesInRange(150)) do
			isPlayer = false
			for z,x in ipairs(mapPlayers) do
				if x:GetGUID() == m:GetGUID() or x:GetPetGUID() == m:GetGUID() then
					isPlayer = true	
					break;					
				end
			end
			if isPlayer ~= true then
				for e in pairs(affixes) do
					if v:HasItem(affixes[e][1]) then
						if not m:HasAura(affixes[e][2]) then
							m:CastSpell(m,affixes[e][2],true)
						end
					end
				end
			end
		end
		for e in pairs(cloaks) do
			if(v:GetEquippedItemBySlot(14) ~= nil) then
				if v:GetEquippedItemBySlot(14):GetEntry() == cloaks[e][1] then
					if not v:HasAura(cloaks[e][2]) then
						v:CastSpell(v,cloaks[e][2],true)
					end
				end
			end
		end
	end
end

local function checkBoss555(event, creature, killer)
	local count = 0;
	local mapPlayers = creature:GetMap():GetPlayers()
	if creature:GetEntry() == BossIDMap555 then
		for i,v in ipairs(mapPlayers) do
			for e in pairs(affixes) do
				if v:HasItem(affixes[e][1]) then
					v:RemoveItem(affixes[e][1],1)
					count = count+affixes[e][3]			
				end
			end
		end		
		for e in pairs(chest555) do
			if(count >= chest555[e][1]) then
				killer:SummonGameObject(chest555[e][2],chest555[e][3],chest555[e][4],chest555[e][5],chest555[e][6],300)
			end
		end
	end
end

local function checkBoss556(event, creature, killer)
	local count = 0;
	local mapPlayers = creature:GetMap():GetPlayers()
	if creature:GetEntry() == BossIDMap556 then
		for i,v in ipairs(mapPlayers) do
			for e in pairs(affixes) do
				if v:HasItem(affixes[e][1]) then
					v:RemoveItem(affixes[e][1],1)
					count = count+affixes[e][3]
				end
			end
		end		
		for e in pairs(chest556) do
			if(count >= chest556[e][1]) then
				killer:SummonGameObject(chest556[e][2],chest556[e][3],chest556[e][4],chest556[e][5],chest556[e][6],300)
			end
		end
	end
end

local function checkBoss557(event, creature, killer)
	local count = 0;
	local mapPlayers = creature:GetMap():GetPlayers()
	if creature:GetEntry() == BossIDMap557 then
		for i,v in ipairs(mapPlayers) do
			for e in pairs(affixes) do
				if v:HasItem(affixes[e][1]) then
					v:RemoveItem(affixes[e][1],1)
					count = count+affixes[e][3]		
				end
			end
		end		
		for e in pairs(chest557) do
			if(count >= chest557[e][1]) then
				killer:SummonGameObject(chest557[e][2],chest557[e][3],chest557[e][4],chest557[e][5],chest557[e][6],300)
			end
		end
	end
end

local function checkBoss558(event, creature, killer)
	local count = 0;
	local mapPlayers = creature:GetMap():GetPlayers()
	if creature:GetEntry() == BossIDMap558 then
		for i,v in ipairs(mapPlayers) do
			for e in pairs(affixes) do
				if v:HasItem(affixes[e][1]) then
					v:RemoveItem(affixes[e][1],1)
					count = count+affixes[e][3]	
				end
			end
		end		
		for e in pairs(chest558) do
			if(count >= chest558[e][1]) then
				killer:SummonGameObject(chest558[e][2],chest558[e][3],chest558[e][4],chest558[e][5],chest558[e][6],300)
			end
		end
	end
end


RegisterPlayerEvent(28, OnMapChange)
RegisterPlayerEvent(29,itemEquip)
RegisterMapEvent(555,3,testreset)
RegisterMapEvent(556,3,testreset)
RegisterMapEvent(557,3,testreset)
RegisterMapEvent(558,3,testreset)
RegisterCreatureEvent(BossIDMap555,4,checkBoss555)
RegisterCreatureEvent(BossIDMap556,4,checkBoss556)
RegisterCreatureEvent(BossIDMap557,4,checkBoss557)
RegisterCreatureEvent(BossIDMap558,4,checkBoss558)