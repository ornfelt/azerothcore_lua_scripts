local enabled = true --disable script
local xp1 = 290 -- 1-19
local xp2 = 395 -- 20-29
local xp3 = 478 -- 30-39
local xp4 = 652 -- 40-49
local xp5 = 825 -- 50-59
local xp6 = 1500 -- 60-69
local xp7 = 2000 -- 70-79


--function OnCreatureKill(event, player, victim)
function OnGiveXP(event, player, amount, victim)
local plevel = player:GetLevel()
if victim ~= nil then
local creatureentry = victim:GetEntry()
local creaturename = victim:GetName()
local gold = 10000
local Map = player:GetMap()
local inDungeon = Map:IsDungeon()
local name = player:GetName()



local number = math.random(1, 20)
if not inDungeon then
	local x = victim:GetX()
	local y = victim:GetY()
	local z = victim:GetZ()
	local o = victim:GetO()
	local spawnedCreature
	
	local spawnlevel = plevel+1
	
	if number == 4 then
	spawnedCreature = victim:SpawnCreature( creatureentry, x+1, y+1, z+0.5, o-3.5, 1, 60  )
	spawnedCreature:SetLevel( spawnlevel )
	end
	if number == 7 then
	spawnedCreature = victim:SpawnCreature( creatureentry, x+1, y+1, z+0.5, o-3.5, 1, 60  )
	spawnedCreature:SetLevel( spawnlevel )
	spawnedCreature = victim:SpawnCreature( creatureentry, x+2, y+2, z+0.5, o-3.5, 1, 60  )
	spawnedCreature:SetLevel( spawnlevel )

	end
	if number == 9 then
	spawnedCreature = victim:SpawnCreature( creatureentry, x+1, y+1, z+0.5, o-3.5, 1, 60  )
	spawnedCreature:SetLevel( spawnlevel )
	spawnedCreature = victim:SpawnCreature( creatureentry, x+2, y+2, z+0.5, o-3.5, 1, 60  )
	spawnedCreature:SetLevel( spawnlevel )
	spawnedCreature = victim:SpawnCreature( creatureentry, x+3, y+3, z+0.5, o-3.5, 1, 60  )
	spawnedCreature:SetLevel( spawnlevel )
	end
	

if number == 2 or number == 15 or number == 14 or number == 1 then
player:ModifyMoney( gold*1 )
player:SendBroadcastMessage("|cff5af304You recieved an extra 1 gold from killing " ..creaturename.."|r")
end

if number == 6 then
player:ModifyMoney( gold*2 )
player:SendBroadcastMessage("|cff5af304You recieved an extra 2 gold from killing " ..creaturename.."|r")
end


if number == 8 then
player:ModifyMoney( gold*3 )
player:SendBroadcastMessage("|cff5af304You recieved an extra 3 gold from killing " ..creaturename.."|r")
end

if number == 16 then
player:ModifyMoney( gold*10 )
player:SendBroadcastMessage("|cff5af304You recieved an extra 3 gold from killing " ..creaturename.."|r")
end

if number == 3 then
	 if amount ~= nil then
	local bonus = amount*10
	player:GiveXP( bonus )
	player:SendBroadcastMessage("|cff5af304You recieved an extra " ..bonus..  "xp from killing " ..creaturename.."|r")
	end
	
end

if number == 12 then
player:ModifyMoney( -gold*5 )
player:SendBroadcastMessage("|cff5af304You lost 5 gold.|r")
end


if number == 17 then
spawnedCreature = victim:SpawnCreature( 14273, x+3, y+3, z+0.5, o-3.5, 1, 60  )
spawnedCreature:SetLevel( plevel )
end


end

   
	

end
end




if enabled then
--RegisterPlayerEvent(7, OnCreatureKill)
RegisterPlayerEvent(12, OnGiveXP)
end