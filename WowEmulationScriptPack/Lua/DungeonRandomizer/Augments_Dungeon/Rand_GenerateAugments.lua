--[[
current table playerGUID,LinkSpellID,ProcChance,effectID,name,description,icon,Misc1,Misc2,Misc3,Misc4,Misc5,Misc6,Misc7,Misc8,Misc9,Misc10
NOTE sign is based on 1 being >, 0 being <
ProcChance = % Chance to execute effect

effect 1 = if target %hp (sign Misc1) (Misc2)amount, trigger spell(Misc3)
effect 2 = if player %power (sign Misc1) (Misc2), trigger spell(Misc3)
effect 3 = cast spell(Misc1)
effect 4 = heal target amount(Misc1)[can be negative] with range bonus(Misc2)
effect 5 = summon creature(Misc1) for time(Misc2) in ms (faction value in Misc3)
effect 6 = divide current target's power by (Misc1)--check this is wrong
effect 7 = cast spell randomly (Misc1 through Misc10)(all unused must be 0)
effect 8 = REMOVED
effect 9 = damage target amount(Misc1) with range bonus (Misc2) with damage school (Misc3)
effect 10 = if target distance(sign Misc1) yards(Misc2) trigger spell(Misc3)
effect 11 = reset player all cooldowns
--do some AoE damage thing
--restore power
--steal power
]]

randDungClassSpellIDCache = {{},{},{},{},{},{},{},{},{},{},{}}
randDungPossibleSpellAugmentChoice = {{},{},{},{},{},{},{},{},{},{},{}}
randDungCreatureIDCache = {}

local function setupCacheTablesRandDung()	
	Q = WorldDBQuery("SELECT * FROM rand_dung_augment_spell_info")
	if Q then
		repeat
			table.insert(randDungClassSpellIDCache[Q:GetUInt32(0)],Q:GetUInt32(1))
		until not Q:NextRow()
	end
	
	Q = WorldDBQuery("SELECT * FROM rand_dung_augment_spell_choice_info")
	if Q then
		repeat
			table.insert(randDungPossibleSpellAugmentChoice[Q:GetUInt32(0)],Q:GetUInt32(1))
		until not Q:NextRow()
	end
	
	Q = WorldDBQuery("SELECT * FROM rand_dung_augment_creature_info")
	if Q then
		repeat
			table.insert(randDungCreatureIDCache,Q:GetUInt32(0))
		until not Q:NextRow()
	end
end

function generateRandomAugmentRandDung(player,spellID,ProcValue)
	local name = ""
	local description = ""
	local Misc1 = 0
	local Misc2 = 0
	local Misc3 = 0
	local Misc4 = 0
	local Misc5 = 0
	local Misc6 = 0
	local Misc7 = 0
	local Misc8 = 0
	local Misc9 = 0
	local Misc10 = 0	
	local effectID = math.random(11)
	local ProcChance = ProcValue
	local icon = iconPathCache[math.random(#iconPathCache)]
	
	local randomClass = math.random(11)
	if(randomClass == 10) then
		randomClass = 1
	end
	local curClassCache = randDungClassSpellIDCache[randomClass]
	
	if(effectID == 1) then
		Misc1 = math.random(2)-1
		Misc2 = math.random(100)
		Misc3 = curClassCache[math.random(#curClassCache)]
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		local sign = ""
		if(Misc1 == 0) then
			sign = "less than "
		else
			sign = "greater than "
		end
		description = "If targets percent health is " .. sign .. Misc2 .. "% there is a " .. ProcChance .. "% chance to trigger ".. spellIDToNameCache[Misc3] .. " when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 2) then
		Misc1 = math.random(2)-1 
		Misc2 = math.random(100)
		Misc3 = curClassCache[math.random(#curClassCache)]
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		local sign = ""
		if(Misc1 == 0) then
			sign = "less than "
		else
			sign = "greater than "
		end
		description = "If targets percent resource is " .. sign .. Misc2 .. "% there is a " .. ProcChance .. "% chance to trigger ".. spellIDToNameCache[Misc3] .. " when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 3) then
		Misc1 = curClassCache[math.random(#curClassCache)]
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		description = "There is a " .. ProcChance .. "% chance to trigger " .. spellIDToNameCache[Misc1] .. " when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 4) then
		Misc1 = math.random(player:GetLevel()*160)-(player:GetLevel()*70)
		Misc2 = math.random(player:GetLevel()*30)
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		description = "There is a " .. ProcChance .. "% chance to heal the target for " .. Misc1 .. " with a rolling bonus of " .. Misc2 .. " when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 5) then
		Misc1 = randDungCreatureIDCache[math.random(#randDungCreatureIDCache)]
		Misc2 = math.random(40000)
		if(player:IsAlliance())then
			Misc3 = 1
		end
		local QryName = WorldDBQuery("SELECT name FROM creature_template WHERE `entry` = " .. Misc1)
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		description = "There is a " .. ProcChance .. "% chance to summon " .. QryName:GetString(0) .. " for " .. (Misc2/1000) .. " seconds when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 6) then
		Misc1 = math.random(4)+1
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		description = "There is a " .. ProcChance .. "% chance to divide current targets resource by " .. Misc1 .. " when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 7 or effectID == 8) then
		effectID = 7
		local amountOfSpells = math.random(10)
		local spelltable = {0,0,0,0,0,0,0,0,0,0}
		local index = 1
		local allSpellIDs = " "
		for i=amountOfSpells,0,-1 do			
			local classValue = math.random(11)
			if(classValue == 10) then
				classValue = 11
			end
			local spellIDNew = randDungClassSpellIDCache[classValue][math.random(#randDungClassSpellIDCache[classValue])]
			spelltable[index] = spellIDNew
			local name = spellIDToNameCache[spellIDNew]
			allSpellIDs =  name .. ", " .. allSpellIDs
			index = index+1
		end
		Misc1 = spelltable[1]
		Misc2 = spelltable[2]
		Misc3 = spelltable[3]
		Misc4 = spelltable[4]
		Misc5 = spelltable[5]
		Misc6 = spelltable[6]
		Misc7 = spelltable[7]
		Misc8 = spelltable[8]
		Misc9 = spelltable[9]
		Misc10 = spelltable[10]		
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		description = "There is a " .. ProcChance .. "% chance to cast a random spell from this list [" .. allSpellIDs .. "] when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 9) then
		Misc1 = math.random(player:GetLevel()*160)-player:GetLevel()*70
		Misc2 = math.random(player:GetLevel()*30)
		Misc3 = math.random(7)-1
		local school = spellSchoolNameCache[Misc3+1]
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		description = "There is a " .. ProcChance .. "% chance to deal " .. school .. " damage the target for " .. Misc1 .. " with a rolling bonus of " .. Misc2 .. " when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 10) then
		Misc1 = math.random(2)-1 
		Misc2 = math.random(30)
		Misc3 = curClassCache[math.random(#curClassCache)]
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		local sign = ""
		if(Misc1 == 0) then
			sign = "less than "
		else
			sign = "greater than "
		end
		description = "If target is " .. sign .. Misc2 .. " yards from you there is a " .. ProcChance .. "% chance to trigger ".. spellIDToNameCache[Misc3].. " when casting " .. spellIDToNameCache[spellID] .. ".|r"
	elseif(effectID == 11) then
		name = player:GetName() .. "s Augmented " .. spellIDToNameCache[spellID]
		description = "There is a " .. ProcChance .. "% chance to reset all your spell cooldowns when casting " .. spellIDToNameCache[spellID] .. ".|r"
	end
	addSpellConnectionRandDung(player,spellID,ProcChance,effectID,name,description,icon,Misc1,Misc2,Misc3,Misc4,Misc5,Misc6,Misc7,Misc8,Misc9,Misc10)
end

setupCacheTablesRandDung()