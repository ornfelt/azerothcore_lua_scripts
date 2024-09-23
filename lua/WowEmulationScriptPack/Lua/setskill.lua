--[[
you can type .skill alchemy # to set a profession skill to the value you entered.
If you don't have the skill already the rank Apprentice will be learned and then skill set to the vaulue entered.

You can type .spawn # to spawn an NPC but it must be an NPC that can attack you, not a friendly NPC.
--]]
local enabled = false
local gmonly = true
local hpmultiplier = 0.85 -- Spawned npc hp will be multiplied by players hp.

local proffession = {["mining"] = 186, ["tailoring"] = 197, ["blacksmithing"] = 164, ["herbalism"] = 182, ["alchemy"] = 171, ["engineering"] = 202, ["leatherworking"] = 165, ["inscription"] = 773, ["jewelcrafting"] = 755, ["enchanting"] = 333, ["skinning"] = 393, ["cooking"] = 185, ["firstaid"] = 129, ["fishing"] = 356,}

local spells = {[171] = 2259, [164] = 2018, [182] = 2366, [333] = 7411, [202] = 4036, [773] = 45357, [755] = 25229, [165] = 2108, [186] = 2575, [393] = 8613, [197] = 3908, [185] = 2550, [129] = 3273, [356] = 7620}

local function PlrMenu(event, player, message, Type, lang)
	
	local text = message:lower()
	local x = player:GetX()
	local y = player:GetY()
	local z = player:GetZ()
	local o = player:GetO()
	local level = player:GetLevel()
	local playername = player:GetName()
	local playerHP = player:GetMaxHealth()
	local healammount = playerHP * hpmultiplier
	
	local Taunts = {
		"Hey "..playername.." u r so uglaaaay!!!! LMAO",
		"You killed my Brother so prepare to Die "..playername.."!!!",
		"Hey "..playername.." Fight me you coward!",
		"Hey "..playername.." I will be the one to... take you down.",
		"Hey "..playername.." You can't defeat me!",
		"Hey "..playername.." Victory will be mine!",
		"Hey "..playername.."! It's game over for you!",
		"Hey "..playername.." What's up now!?",
		"Hey "..playername.." Ready when you are!",
		"Hey "..playername.." You'll get no sympathy from me!",
		"Victory or Death!!!",
		""..playername.." is about to cry like a baby.",
		"Run "..playername.." run!",
		"Hey "..playername.." whats that on ur head? oh yea my weapon.",
		"Hey "..playername.." why don't apple jacks taste like apples?"
		}
	
	local commandskill = "^skill.*"
	local commandspawn = "^spawn.*"
	

	local get = string.sub(text,7,65)
	local strip = get:gsub("%s+", "")
	local extractedskill = tostring(get:gsub("%s+%d+", ""))
	local extractedskillvalue = tostring(string.match(message, "%d+"))
	local mingmrank = 3
	

if (gmonly and player:GetGMRank() < mingmrank) then
	player:SendBroadcastMessage("|cff5af304You must be a GM to use this command.|r")
	return false
	else
	if text:find(commandskill) ~= nil then

	for k,v in pairs(proffession) do 
		if extractedskill == k then

			if player:HasSkill( tonumber(v) ) then
				local maxval = extractedskillvalue
				local skillvalue = tonumber(extractedskillvalue)
				
				if skillvalue < 75 then
				maxval = 75
				end
				
				if skillvalue > 75 and skillvalue < 150 then
				maxval = 150
				end
				
				if skillvalue > 150 and skillvalue < 225 then
				maxval = 225
				end
				
				if skillvalue > 225 and skillvalue < 300 then
				maxval = 300
				end
				
				if skillvalue > 300 and skillvalue < 375 then
				maxval = 350
				end
				
				if skillvalue > 350 and skillvalue < 450 then
				maxval = 450
				end
				
				if skillvalue > 450 then
				maxval = 450
				end
				
				local curval = player:GetSkillValue( v )

				if skillvalue > curval then
				player:SetSkill(tonumber(v), extractedskillvalue, extractedskillvalue, maxval)
				else
				player:SendBroadcastMessage("|cff5af304You can't lower "..k.."only raise it. You entered "..skillvalue.." and your "..k.."is already at "..curval.."|r")
				end
				else
				

				for p,s in pairs(spells) do 
				if v == p then
				player:LearnSpell( s )
				PlrMenu(event, player, message, Type, lang)
				end
				end
				end
				
		end
	end
	
	return false
	end
	
	
	
	if text:find(commandspawn) ~= nil then

	local stripspawn = string.match(text, "[^spawn ].*")
	local extractedspawn = string.match(stripspawn, "%d+")
	
	
	spawnedCreature = player:SpawnCreature( extractedspawn, x+1, y+1, z+0.6, o-3.5, 1, 60  )
	if spawnedCreature:CanStartAttack(player) then
	spawnedCreature:SetLevel( level )
	spawnedCreature:SetMaxHealth(playerHP * hpmultiplier)
	spawnedCreature:DealHeal( spawnedCreature, 39334, healammount )
	spawnedCreature:SendUnitSay(Taunts[math.random(1, #Taunts)], 0)
	spawnedCreature:AttackStart(player)
	else
	spawnedCreature:DespawnOrUnsummon( 1 )
	player:SendBroadcastMessage("|cff5af304NPC must be hostile towards you.|r")
	end
	
	return false
	end
	
end
	
end

if enabled then
RegisterPlayerEvent(42, PlrMenu)
end