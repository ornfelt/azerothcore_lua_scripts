_DEBUG = true

-- Prototypes
local functionLookup
local talentLoopup = { --in order from the LoadOut.lua(spell IDs) -- should add a requirements check.
101,
102,
103,
104,
105,
106,
107,
108,
109,
110,
111,
112,
113,
114,
115,
116,
117,
118,
119,
120,
121,
122,
123,
124
}


-- Handle addon messages
local function onReceiveAddonMsg(event, plr, Type, prefix, msg, receiver)
	if receiver ~= plr then return end
	if not msg or not prefix or not plr then return end
	if _DEBUG then print("[GOT] " .. prefix .. " | " .. msg) end
	local func = functionLookup[prefix]
	if func then
		func(plr, msg)
	end
end

RegisterServerEvent(30, onReceiveAddonMsg)

-- Handle selecting talents
function SelectTalents(plr, msg)
	if msg:len() < 8 then return end
	local talents = {}
	table.insert(talents, msg:sub(1, 2))
	table.insert(talents, msg:sub(3, 4))
	table.insert(talents, msg:sub(5, 6))
	table.insert(talents, msg:sub(7, 8))
	for i=1,4 do
		talents[i] = tonumber(talents[i])
		if not talents[i] then return end
	end
	
	
	local Q = CharDBQuery("SELECT perk1, perk2, perk3, perk4 FROM character_perks WHERE GUID = " .. tostring(plr:GetGUIDLow()))
	if(Q) then --remove past perks
		local perk1, perk2, perk3, perk4 = Q:GetUInt32(0),Q:GetUInt32(1),Q:GetUInt32(2),Q:GetUInt32(3)
		if(perk1 ~= nil and perk1 ~= 0) then
			plr:RemoveSpell(perk1)
		end
		if(perk2 ~= nil and perk2 ~= 0) then
		plr:RemoveSpell(perk2)
		end
		if(perk3 ~= nil and perk3 ~= 0) then
		plr:RemoveSpell(perk3)
		end
		if(perk4 ~= nil and perk4 ~= 0) then
		plr:RemoveSpell(perk4)
		end
	end
	--learn new perks
	local i = 1
	while i < 5 do
		if(talentLoopup[talents[i]] ~= nil and talentLoopup[talents[i]] ~= 0) then
			plr:LearnSpell(talentLoopup[talents[i]])
		end
		i = i + 1
	end
	-- Will probably need some sort of verification to see if the player can use this talent
	CharDBQuery("REPLACE INTO `character_perks` VALUES (\'".. 
		tostring(plr:GetGUIDLow()) .."\', \'" ..
		tostring(talentLoopup[talents[1]]) .. "\', \'" .. tostring(talentLoopup[talents[2]]) ..
		"\', \'" .. tostring(talentLoopup[talents[3]]) .. "\', \'" ..
		tostring(talentLoopup[talents[4]]) .. "\')")
end
functionLookup = {
	["MAINMENU"] = GetTheGamesAvailable,
	["CREATEGAME"] = CREATEGAME,
	["PLRSLB"] = PLRSLB,
	["JoinGame"] = JoinGame,
	["SelectTalents"] = SelectTalents,
	["LEAVEGAME"] = leaveGame
}