-- This file contains information about checking professions when a player tries to learn profession via book
-- author: grimreapaa

-- book entries to register ItemEvents for
local book_items = {
	1999927,
	1999928,
	1999929,
	1999930,
	1999931,
	1999932,
	1999933,
	1999934,
	1999935,
}

-- profession skill IDs to check if a player knows
local profession_skills = {
	701,
	702,
	703,
	704,
	705,
	706,
	707,
	708,
	709,
}

local function Recipe_Check(event, player, item, target)
	player_has_profession = false
	
	for x=1,#profession_skills,1 do
		if player:HasSkill(profession_skills[x]) == true then
			player_has_profession = true
		end
	end
	
	if player_has_profession == true then
		player:SendBroadcastMessage("You already have one profession known.")
		return false
	end
end

local function Register_Recipe_Events(event)
	for m=1,#book_items,1 do
		RegisterItemEvent(book_items[m], 2, Recipe_Check)
	end
end

RegisterServerEvent(33, Register_Recipe_Events)
