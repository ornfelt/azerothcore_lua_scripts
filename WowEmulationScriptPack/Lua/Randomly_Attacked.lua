local enabled = false
local spawnslist = {2260,14281,14221,2244,2261} -- npcid's
local hpmultiplier = 0.85 -- Spawned npc hp will be multiplied by players hp.
local despawntime = 25 --seconds before npc despawns
local rnumb = false --output rolled number for testing purposes


local function SpawnEnemy(event, player, killed)

		local x = player:GetX()
		local y = player:GetY()
		local z = player:GetZ()
		local o = player:GetO()
		local map = player:GetMap()
		local mapID = map:GetMapId()
		local areaId = map:GetAreaId( x, y, z )
		local faction = player:GetFaction()
		local Target = player:GetSelection()
		local playername = player:GetName()
		local isDungeon = map:IsDungeon()
		local playerHP = player:GetMaxHealth()
		local spawnedCreature
		
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

		local chosen = spawnslist[math.random(1, #spawnslist)]
	local healammount = playerHP * hpmultiplier
	local r = math.random(1,45)
	local level = player:GetLevel()
	if r == 25 and not isDungeon then
	local EnemyNear = player:GetNearestCreature( 80, chosen )
	if EnemyNear == nil then
	spawnedCreature = player:SpawnCreature( chosen, x-5, y, z, o, 3, despawntime  )
	spawnedCreature:SetLevel(level)
	spawnedCreature:SetMaxHealth(playerHP * hpmultiplier)
	spawnedCreature:DealHeal( spawnedCreature, 39334, healammount )
	spawnedCreature:SendUnitSay(Taunts[math.random(1, #Taunts)], 0)
	spawnedCreature:AttackStart(player)
	end
	end
	
	if rnumb then
	player:SendBroadcastMessage("|cff3399FF (Randomly Attacked script) number: |cff00cc00"..r.."|cff3399FF")
	end
	
end

if enabled then
RegisterPlayerEvent(7, SpawnEnemy)
end