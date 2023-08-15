local enabled = false
local gaintame = 1 --level to learn Tame Beast and Beast Training spells

local removehunterspells = {136, 3111, 3661, 3662, 13542, 13543, 13544, 27046, 48989, 48990, 1515, 883, 2641, 6991, 982, 1462, 19577, 34026, 62757, 19574}

local spells = {
		[gaintame] = {1515, 883, 2641, 6991, 982, 1462},
        [12] = {136},
        [20] = {3111},
        [28] = {3661},
		[30] = {19577},
        [36] = {3662},
		[40] = {19574},
        [44] = {13542},
        [52] = {13543},
        [60] = {13544},
		[66] = {34026},
        [68] = {27046},
        [74] = {48989},
        [80] = {48990, 62757}
    }

local firstlogin = false

 local function SKULY(eventid, delay, repeats, player)
	player:SendBroadcastMessage("|cff3399FF All Classes can use Hunter pets. Tame Beast spell is learned at level |cff00cc00"..gaintame.."|cff3399FF")
	player:SendBroadcastMessage("|cff3399FF If you are level "..gaintame.." it should be in your Spellbook|cff3399FF")
end


local function OnFirstLogin(event, player)
local level = player:GetLevel()
if event == 30 and enabled then
	firstlogin = true
	if gaintame == 1 then
		for i = tonumber(level), 1, -1 do 
			local Skills = spells[i] or {}
			for k, v in pairs(Skills) do player:LearnSpell(v) end
		end
	end
	else
	firstlogin = false
	end
player:RegisterEvent(SKULY, 25000, 1, player)
end


local function OnLogin(event, player)
	local class = player:GetClass()
	local level = player:GetLevel()
	if not firstlogin and enabled then
	if level >= gaintame then
		for i = tonumber(level), 1, -1 do 
			local Skills = spells[i] or {}
			for k, v in pairs(Skills) do player:LearnSpell(v) end
		end
		player:RegisterEvent(SKULY, 25000, 1, player)
	end
	else
	firstlogin = false
	end
	
	if not enabled then
	if class ~= 3 then
	for k,v in pairs(removehunterspells) do
	player:RemoveSpell( v )
	end
	end
	end
	
end

function AutoLearn(player, oldlevel)
    local level = player:GetLevel()
	local class = player:GetClass()
    
    if (level > 80) then
        level = 80
    end
	
    
    --local Skills = spells[level] or {}
	
	
	
	
    if enabled then
    --for k, v in pairs(Skills) do
       -- player:LearnSpell(v)
    --end
   for i = tonumber(level), 1, -1 do 
   local Skills = spells[i] or {}
   for k, v in pairs(Skills) do player:LearnSpell(v) end
   end

   if oldlevel > level and class ~= 3 then
	for i = 80, tonumber(level+1), -1 do 
   local Skills = spells[i] or {}
   for k, v in pairs(Skills) do player:RemoveSpell( v ) end
   end
   end

	else
	if class ~= 3 then
	for k,v in pairs(removehunterspells) do
	player:RemoveSpell( v )
	end
	end
	end
	
	
	
end

local function PlayerLevelUp(event, player, oldlevel)
    AutoLearn(player, oldlevel)
end


RegisterPlayerEvent(30, OnFirstLogin)
RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(13, PlayerLevelUp)