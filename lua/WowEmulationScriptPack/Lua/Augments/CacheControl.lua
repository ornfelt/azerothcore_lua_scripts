playerToSpellEffectCache = {}

function addSpellConnection(player,spellID,ProcChance,effectID,name,description,icon,Misc1,Misc2,Misc3,Misc4,Misc5,Misc6,Misc7,Misc8,Misc9,Misc10)
    if(playerToSpellEffectCache[player:GetGUIDLow()] == nil) then
        playerToSpellEffectCache[player:GetGUIDLow()] = {}
    end
    local count = 0
    for i,v in pairs(playerToSpellEffectCache[player:GetGUIDLow()]) do
        count = count + 1
    end
    if(count < 3) then
        player:SendBroadcastMessage(description)
        WorldDBQuery("INSERT INTO spell_gen_data VALUES ("  .. player:GetGUIDLow() .. ","  .. spellID .. ","  .. ProcChance .. ","  .. effectID .. ",'" .. name .. "','" .. description .. "','" .. icon .. "',"  .. Misc1 .. ","  .. Misc2 .. ","  .. Misc3 .. ","  .. Misc4 .. ","  .. Misc5 .. ","  .. Misc6 .. ","  .. Misc7 .. ","  .. Misc8 .. ","  .. Misc9 .. "," .. Misc10 .. ");")
        playerToSpellEffectCache[player:GetGUIDLow()][spellID] = {player:GetGUIDLow(),spellID,ProcChance,effectID,name,description,icon,Misc1,Misc2,Misc3,Misc4,Misc5,Misc6,Misc7,Misc8,Misc9,Misc10}
    else
        player:SendBroadcastMessage("TOO MANY AUGMENTS CUNT")
    end
end

function removeSpellConnection(player,spellID)
	WorldDBQuery("DELETE FROM spell_gen_data WHERE playerGUID = " .. player:GetGUIDLow() .. " AND spellID = " .. spellID .. ";")
	playerToSpellEffectCache[player:GetGUIDLow()][spellID] = nil
end

local function saveToDatabase()
	print("Saving to database...")
	WorldDBQuery("DELETE FROM spell_gen_data")
	for i,v in pairs(playerToSpellEffectCache) do
		for q,c in pairs(v) do
			local qryText = c[1] .. ","  .. c[2] .. ","  .. c[3] .. ","  .. c[4] .. ","  .. c[5] .. ","  .. c[6] .. ","  .. c[7] .. ","  .. c[8] .. ","  .. c[9] .. ","  .. c[10] .. ","  .. c[11] .. ","  .. c[12] .. ","  .. c[13] .. ","  .. c[14] .. ","  .. c[15] .. ","  .. c[16] .. ","  .. c[17]
			WorldDBQuery("INSERT INTO spell_gen_data VALUES ("  .. qryText .. ");")
		end
	end
	print("Saved to database.")
end

local function loadFromDatabase()
	print("Loading augments from database...")
	playerToSpellEffectCache = {}
	local Q = WorldDBQuery("SELECT * FROM spell_gen_data")
	if Q then
		repeat
			if(playerToSpellEffectCache[Q:GetUInt32(0)] == nil)then
				playerToSpellEffectCache[Q:GetUInt32(0)] = {}
			end
			playerToSpellEffectCache[Q:GetInt32(0)][Q:GetInt32(1)] = {Q:GetInt32(0),Q:GetInt32(1),Q:GetInt32(2),Q:GetInt32(3),Q:GetString(4),Q:GetString(5),Q:GetString(6),Q:GetInt32(7),Q:GetInt32(8),Q:GetInt32(9),Q:GetInt32(10),Q:GetInt32(11),Q:GetInt32(12),Q:GetInt32(13),Q:GetInt32(14),Q:GetInt32(15),Q:GetInt32(16)}
		until not Q:NextRow()
	end
	print("Loaded augments from database.")
end

loadFromDatabase()