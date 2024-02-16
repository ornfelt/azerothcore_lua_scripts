NpcBotCommands = {}

local requireGMForItemCommands = true -- Require gm rank. This is only for items. Set to false to disable.

local bot_script_names = {
    "mage_bot", "shaman_bot", "priest_bot", "warrior_bot", "hunter_bot", "rogue_bot",
    "warlock_bot", "paladin_bot", "druid_bot", "dreadlord_bot",
    "sphynx_bot", "blademaster_bot", "spellbreaker_bot", "seawitch_bot", "necromancer_bot",
    "dreadlord_bot", "death_knight_bot"
}

local function isValidBotScriptName(scriptName)
    for _, validScriptName in ipairs(bot_script_names) do
        if scriptName == validScriptName then
            return true
        end
    end
    return false
end

function NpcBotCommands.OnCommandHandler(event, player, command, chatHandler)
    local target = player:GetSelection()
    local scriptName = nil  -- Initialize to nil

    -- Check if target exists and if GetScriptName is a callable method on target
    if target and type(target.GetScriptName) == "function" then
        scriptName = target:GetScriptName()
    end
    -- Handle .bot clear tmog command
    if command == "bot clear tmog" then
        if scriptName == nil or not isValidBotScriptName(scriptName) then
            player:SendBroadcastMessage("Invalid target for .bot clear tmog command. Make sure you have an NPC Bot targeted.")
            return false
        end

        local creatureId = target:GetEntry()
        local sqlQuery = string.format("DELETE FROM characters_npcbot_transmog WHERE entry = %d", creatureId)
        
        CharDBExecute(sqlQuery)
        
        player:SendBroadcastMessage("Transmog for NPC Bot has been cleared. Changes will take effect upon server reset.")
        return false
    end

    -- Handle .bot nameset command
    if command:find("bot nameset") then
        if scriptName == nil then
            player:SendBroadcastMessage("Invalid target for .bot nameset command. Make sure you have an NPC Bot targeted.")
            return false
        end

        if command:find("bot nameset (.+)") then
            if isValidBotScriptName(scriptName) then
                local _, _, name = string.find(command, "bot nameset (.+)")
                local creatureId = target:GetEntry()
                
                if #name > 15 then
                    player:SendBroadcastMessage("New name is too long. It must be 15 characters or fewer.")
                    return false
                end

                local sqlQuery1 = string.format("UPDATE creature_template SET name = '%s' WHERE entry = %d", name, creatureId)
                local sqlQuery2 = string.format("UPDATE creature_template_npcbot_appearance SET `name*` = '%s' WHERE entry = %d", name, creatureId)
                
                WorldDBExecute(sqlQuery1)
                WorldDBExecute(sqlQuery2)
                
                player:SendBroadcastMessage("Name for NPC Bot has been updated to " .. name .. ". Changes will take effect upon server reset.")
                return false
            else
                player:SendBroadcastMessage("Invalid target for .bot nameset command. Make sure you have an NPC Bot targeted.")
                return false
            end
        else
            player:SendBroadcastMessage("Usage: .bot nameset [new name]. Sets the name of a targeted NPC Bot. The name must be 15 characters or fewer.")
            return false
        end
    end
    
    return true
end

RegisterPlayerEvent(42, NpcBotCommands.OnCommandHandler)


local CasterItems = {
    [10] = {10657, 10553, 10820, 10047, 6191, 15452, 4767, 1449, 28303, 7739, 6505},
    [15] = {21934, 34107, 14150, 11936, 10048, 6191, 14148, 10654, 1449, 28303, 6632, 22980, 27403},
    [20] = {30419, 34107, 6324, 6908, 2954, 4320, 14148, 5195, 20426, 20431, 45626, 2271, 27403},
    [25] = {7048, 20830, 6685, 2231, 6908, 6903, 4320, 14148, 5195, 20426, 20431, 45626, 2549, 27403},
    [30] = {2721, 44215, 6685, 7058, 20099, 7709, 15104, 13106, 6744, 20958, 19521, 45626, 4134, 7513},
    [35] = {2721, 44215, 7712, 7054, 4329, 7709, 15104, 13106, 1659, 20958, 29157, 9149, 21748, 4327, 873, 27403},
    [40] = {9429, 10769, 19507, 10021, 45629, 7709, 15104, 19597, 10019, 1980, 19520, 9149, 21748, 4327, 873, 23177},
    [45] = {9470, 10769, 10038, 10021, 45629, 9484, 10629, 19597, 21318, 21753, 1980, 19120, 9149, 19121, 873, 34418},
    [50] = {3075, 20037, 11624, 12462, 11662, 9484, 17748, 19596, 10808, 12543, 12545, 45631, 17759, 10843, 873, 11748},
    [55] = {3075, 23125, 11782, 12462, 11662, 13170, 11822, 19596, 13253, 16058, 13001, 45631, 12930, 10843, 23124, 18338},
    [60] = {3075, 23125, 11782, 12462, 11662, 13170, 11822, 19596, 13253, 16058, 13001, 45631, 12930, 10843, 23124, 18338},
    [65] = {32494, 31692, 25925, 29341, 24395, 24083, 27411, 21186, 24450, 21709, 23031, 19379, 23046, 23050, 22799, 22821},
    [70] = {34340, 34359, 34210, 34364, 30038, 34181, 32239, 30870, 34344, 33995, 34362, 32483, 44073, 34242, 34182, 34347},
    [75] = {42553, 42339, 35612, 35632, 43164, 43375, 43171, 39791, 35646, 43177, 38746, 44322, 42395, 41608, 41821, 38206},
    ["80_rare"] = {41984, 45155, 37673, 43401, 45156, 37369, 37730, 37725, 43287, 43253, 37651, 44322, 37873, 37291, 37384, 37177},
    ["80_epic"] = {51837, 50658, 50643, 50629, 50613, 50694, 50699, 54582, 50663, 33995, 50714, 54589, 50366, 54583, 50731, 50684},
}


local PhysicalItems = {
    [10] = {22987, 5355, 1436, 11853, 28147, 5299, 1449, 8350, 1355},
    [15] = {25438, 5254, 2041, 5355, 1310, 10653, 1306, 10413, 5351, 1449, 14149},
    [20] = {20442, 5404, 2041, 10403, 10410, 1121, 12999, 7348, 1491, 20429, 2953},
    [25] = {4724, 20442, 2264, 2041, 16659, 9624, 1121, 6902, 7348, 13097, 1491, 2953},
    [30] = {33243, 44213, 2278, 7374, 16659, 9624, 1121, 6902, 7756, 7686, 19513, 14593},
    [35] = {9375, 44213, 2278, 10583, 4264, 9624, 2276, 6902, 10760, 2951, 7686, 9149, 5257},
    [40] = {9375, 44213, 9647, 11193, 13117, 9652, 6431, 19590, 34417, 9533, 19512, 9149, 21758, 5257},
    [45] = {8348, 13089, 9647, 11193, 17778, 29964, 12470, 19590, 34417, 9533, 19512, 19120, 9149, 9512},
    [50] = {19984, 13089, 11685, 17742, 11686, 29964, 12470, 19589, 21278, 17713, 19511, 45631, 19120, 19982},
    [55] = {13404, 15411, 13257, 15825, 16713, 29964, 12470, 19589, 16712, 17713, 22255, 34423, 45631, 19982},
	[60] = {13404, 15411, 13257, 15825, 16713, 29964, 12470, 19589, 16712, 17713, 22255, 34423, 45631, 19982},
    [65] = {32478, 32508, 24398, 24396, 24063, 24466, 22480, 22483, 24365, 22961, 23038, 23041, 19406, 28032},
    [70] = {34244, 34358, 34195, 34369, 30106, 34188, 33222, 32324, 34370, 34361, 32497, 33831, 35702, 34241},
    [75] = {42550, 34358, 34195, 34369, 30106, 34188, 43172, 32324, 34370, 34361, 43178, 44324, 42395, 34241},
    ["80_rare"] = {37293, 45153, 37139, 37219, 37714, 44179, 37666, 37366, 37846, 37685, 37624, 37166, 44014, 36947},
    ["80_epic"] = {50713, 50633, 50646, 50656, 50707, 50697, 50607, 54580, 50675, 54576, 50604, 47734, 54588, 50653},
}

local TankItems = {
    [10] = {6189, 6180, 5355, 15451, 10658, 15453, 5299, 3235, 22979, 3582, 6504, 5357},
    [15] = {25438, 5254, 2041, 5355, 6087, 10658, 14147, 1448, 1319, 3235, 5444, 935, 5443},
    [20] = {1282, 20442, 3231, 6907, 6468, 15470, 6459, 5943, 12994, 6414, 12985, 6340, 2194, 6223},
    [25] = {1282, 20442, 13131, 1717, 6742, 9625, 7754, 5943, 4253, 2039, 6414, 6340, 6804, 6746},
    [30] = {13127, 10711, 13131, 7688, 6742, 9625, 10332, 4745, 9445, 34227, 9538, 18427, 6802, 4129},
    [35] = {4078, 10711, 7755, 3844, 6742, 9625, 10332, 4745, 9445, 4549, 29158, 4130, 9149, 18427, 9240, 4129},
    [40] = {10749, 19536, 19037, 9650, 6742, 7921, 14549, 19581, 7919, 9533, 4549, 4130, 9149, 18427, 8708, 10686},
    [45] = {10749, 19159, 9476, 21322, 14793, 7921, 14549, 18712, 14551, 9533, 1447, 4130, 9149, 16341, 809, 1979},
    [50] = {17734, 19535, 14552, 10845, 11703, 11910, 14549, 18712, 23078, 12544, 15855, 30696, 45631, 12465, 810, 1979},
    [55] = {17734, 13177, 14552, 15413, 11703, 11927, 14549, 17014, 13072, 12544, 22680, 17904, 17909, 12551, 11684, 1168},
	[60] = {17734, 13177, 14552, 15413, 11703, 11927, 14549, 17014, 13072, 12544, 22680, 17904, 17909, 12551, 11684, 1168},    [65] = {32473, 32508, 24463, 30074, 25922, 24456, 24064, 20616, 24387, 21601, 27830, 19431, 23040, 24379, 23577, 23043},
    [70] = {34401, 34178, 34192, 34394, 32342, 34382, 33191, 28502, 34352, 34213, 29296, 29387, 38289, 29385, 34164, 34185},
    [75] = {34401, 39655, 34192, 34394, 32342, 34382, 33191, 28502, 34352, 34213, 29296, 44323, 44063, 29385, 44735, 35642},
    ["80_rare"] = {37135, 37646, 37635, 44198, 37379, 37292, 37082, 37175, 37862, 37186, 37257, 44323, 37220, 37197, 37260, 37162},
    ["80_epic"] = {50640, 50627, 50660, 50968, 50691, 50612, 54579, 51901, 50978, 50622, 50642, 50356, 50364, 50718, 50738, 50729},
}

local MailDamage = {
	[10] = {22987, 5355, 1436, 11853, 28147, 5299, 1449, 8350, 1355},
	[15] = {25438, 5254, 2041, 5355, 1310, 10653, 1306, 10413, 5351, 1449, 14149},
	[20] = {20442, 5404, 2041, 10403, 10410, 1121, 12999, 7348, 1491, 20429, 2953},
	[25] = {4724, 20442, 2264, 2041, 16659, 9624, 1121, 6902, 7348, 13097, 1491, 2953},
	[30] = {33243, 44213, 2278, 7374, 16659, 9624, 1121, 6902, 7756, 7686, 19513, 14593},
	[35] = {9375, 44213, 2278, 10583, 4264, 9624, 2276, 6902, 10760, 2951, 7686, 9149, 5257},
	[40] = {9375, 6723, 9411, 9650, 4264, 9652, 6423, 19590, 34417, 19512, 19515, 9149, 21758, 5257},
	[45] = {9479, 13089, 9411, 9650, 4264, 29964, 12470, 19590, 14551, 19512, 19515, 19120, 9149, 5257},
	[50] = {17767, 13089, 17749, 9650, 11686, 30070, 12470, 19583, 13126, 17713, 19511, 19120, 45631, 11626},
	[55] = {17767, 11933, 15051, 15050, 12634, 15052, 16675, 16681, 16712, 17713, 22255, 34423, 19120, 11626},
	[60] = {17767, 11933, 15051, 15050, 12634, 15052, 16675, 16681, 16712, 17713, 22255, 34423, 19120, 11626},
	[65] = {32478, 32508, 24366, 24396, 24063, 24022, 22480, 24451, 24365, 22961, 31527, 23041, 19406},
	[70] = {34244, 34358, 34194, 34369, 30106, 34188, 32366, 32324, 34234, 33995, 34361, 33831, 34428, 34241},
	[75] = {42550, 35610, 39836, 34369, 30106, 34188, 32366, 32324, 34234, 43178, 43247, 33831, 42418, 38221},
	["80_rare"] = {43309, 37593, 43476, 37714, 44179, 45159, 40490, 44397, 37624, 36979, 44014, 37166, 37840},
	["80_epic"] = {51866, 50633, 54566, 50656, 50995, 50645, 50607, 54580, 50675, 51900, 50678, 47464, 54590, 51933},
}

local PlateDamage = {
	[10] = {3283, 5609, 2978, 5320, 28148, 3314, 8350, 22979, 1355},
	[15] = {25438, 5254, 2041, 5425, 6087, 10653, 2854, 10413, 1189, 1449, 14149},
	[20] = {1282, 20442, 5404, 6627, 6460, 10410, 1121, 12999, 10413, 20429, 20439, 14149},
	[25] = {4724, 20442, 2264, 2870, 6460, 9624, 3482, 13012, 6906, 13097, 6321, 14149},
	[30] = {6686, 2278, 6773, 9405, 6690, 4464, 6902, 7756, 7686, 14593},
	[35] = {6686, 45627, 2278, 10583, 9405, 6690, 4109, 6040, 29158, 7686, 9149, 5257},
	[40] = {9375, 10769, 9647, 11195, 13117, 9652, 9637, 19581, 867, 19512, 19515, 9149, 21758, 5257},
	[45] = {9479, 13089, 9476, 12405, 12406, 9652, 12470, 19581, 14551, 19512, 19515, 19120, 9149, 5257},
	[50] = {22223, 13089, 11685, 11633, 11686, 9652, 22270, 19580, 14551, 17713, 19511, 11905, 12065, 11626},
	[55] = {12410, 15411, 16733, 16736, 16734, 16735, 16730, 16737, 16731, 16732, 17713, 38147, 11905, 45631, 11626},
	[60] = {12410, 15411, 16733, 16736, 16734, 16735, 16730, 16737, 16731, 16732, 17713, 38147, 11905, 45631, 11626},
	[65] = {27408, 32508, 24463, 29337, 24091, 24456, 24064, 21618, 24387, 23038, 31527, 23041, 19406, 28031},
	[70] = {32373, 34358, 34388, 34377, 30032, 34180, 32345, 30057, 34378, 33995, 32497, 40354, 40492, 34241},
	[75] = {42550, 34358, 34392, 34369, 43168, 35637, 35614, 30057, 34343, 43178, 43247, 44324, 42395, 39858},
	["80_rare"] = {37849, 43309, 44195, 37722, 45160, 37263, 43402, 41355, 37874, 43251, 37685, 37166, 44324, 37840},
	["80_epic"] = {50712, 54557, 50674, 50606, 47002, 51854, 54578, 50659, 51892, 50678, 50657, 47734, 45263, 51933},
}

local TwoHanders = {
	[10] = {15424, 11854, 6205},
	[15] = {5423, 5614, 4778},
	[20] = {3191, 6641, 7230},
	[25] = {1976, 9490, 6679},
	[30] = {9459, 9449},
	[35] = {870, 6830, 9449},
	[40] = {44218, 9416},
	[45] = {10652, 9480},
	[50] = {10652, 9372, 9480},
	[55] = {13167, 1263, 20660},
	[60] = {13167, 20660},
	[65] = {25762, 29329},
	[70] = {34891, 34247, 34198},
	[75] = {41181, 41816, 34198},
	["80_rare"] = {37733, 44244, 37848},
	["80_epic"] = {51389, 50730, 34198},
}

local OneHanders = {
	[10] = {1009, 15335, 5344, 6504},
	[15] = {3154, 5757, 23410, 12976, 22984},
	[20] = {1481, 6323, 1482, 6220, 1292},
	[25] = {2878, 13024, 1727, 6804, 2044},
	[30] = {2044, 7687, 16886, 23168, 6802},
	[35] = {1602, 7736, 9392, 9240, 10823},
	[40] = {9401, 9359, 9465, 9684, 9651},
	[45] = {2815, 9639, 17054, 9684, 809},
	[50] = {11702, 1721, 8190, 15800, 10837},
	[55] = {18498, 18671, 14576, 2244, 15806},
	[60] = {18498, 18671, 14576, 2244, 15806},
	[65] = {31153, 31139, 30077, 25763, 25764},
	[70] = {27872, 32661, 34672, 34197, 34165},
	[75] = {41243, 35630, 41182, 41825, 41824},
	["80_rare"] = {37871, 43407, 44250, 37235, 44193},
	["80_epic"] = {50672, 51893, 50737, 51941, 50710},
}

local Ranged = {
	[10] = {23409},
	[15] = {22982},
	[20] = {3021},
	[25] = {9487},
	[30] = {17686},
	[35] = {13038},
	[40] = {9412},
	[45] = {2100},
	[50] = {2824},
	[55] = {22656},
	[60] = {22656},
	[65] = {25639},
	[70] = {34334},
	[75] = {35645},
	["80_rare"] = {43284},
	["80_epic"] = {50733},
}

local Arrows = {
	[10] = {2515},
	[15] = {2515},
	[20] = {2515},
	[25] = {3030},
	[30] = {3030},
	[35] = {3464},
	[40] = {10579},
	[45] = {10579},
	[50] = {10579},
	[55] = {28053},
	[60] = {28053},
	[65] = {33803},
	[70] = {31737},
	[75] = {41165},
	["80_rare"] = {41165},
	["80_epic"] = {52021},
}

local Bullets = {
	[10] = {2519},
	[15] = {8068},
	[20] = {8068},
	[25] = {3033},
	[30] = {3465},
	[35] = {3465},
	[40] = {3465},
	[45] = {10513},
	[50] = {11630},
	[55] = {28060},
	[60] = {28060},
	[65] = {23773},
	[70] = {31735},
	[75] = {41164},
	["80_rare"] = {41164},
	["80_epic"] = {52020},
}


local function OnBotCommandHandlerTwo(event, player, command)
    local args = {}
    for word in command:gmatch("%w+") do table.insert(args, word) end
    if args[1] ~= "bot" or args[2] ~= "items" then
        return true
    end
    
    -- Check player's GM rank
    local gmRank = player:GetGMRank()

    if requireGMForItemCommands == true and gmRank == 0 then
        player:SendBroadcastMessage("You do not have permission to use this command.")
        return false
    end

    local playerLevel = player:GetLevel()
    local level = math.floor(playerLevel / 10) * 10
    if level < 10 then level = 10 end  

    local role = args[3]
    local rarity = args[4] or ""

    if playerLevel == 80 then
        if rarity ~= "epic" and rarity ~= "rare" then
            player:SendBroadcastMessage("At level 80, you must specify either 'epic' or 'rare'. Usage: .bot items [role] [rarity]. Valid roles are 'caster', 'leatherdps', 'tank', 'maildps', 'platedps', 'twohanders', 'onehanders', 'ranged', 'arrows', 'bullets'.")
            return false
        end
        level = "80_"..rarity
    end

    local itemList = nil

    if role == "caster" then
        itemList = CasterItems[level]
    elseif role == "leatherdps" then
        itemList = PhysicalItems[level]
    elseif role == "tank" then
        itemList = TankItems[level]
    elseif role == "maildps" then
        itemList = MailDamage[level]
    elseif role == "platedps" then
        itemList = PlateDamage[level]
    elseif role == "twohanders" then
        itemList = TwoHanders[level]
    elseif role == "onehanders" then
        itemList = OneHanders[level]
    elseif role == "ranged" then
        itemList = Ranged[level]
    elseif role == "arrows" then
        itemList = Arrows[level]
    elseif role == "bullets" then
        itemList = Bullets[level]
    else
        player:SendBroadcastMessage("Invalid role specified. Usage: .bot items [role]. Valid roles are 'caster', 'leatherdps', 'tank', 'maildps', 'platedps', 'twohanders', 'onehanders', 'ranged', 'arrows', 'bullets'.")
        return false
    end

    if not itemList then
        player:SendBroadcastMessage("No items found for the given criteria. Usage: .bot items [role].")
        return false
    end

    for _, itemID in ipairs(itemList) do
        local itemCount = 1  -- default item count

        if role == "arrows" or role == "bullets" then
            itemCount = 2000
        end

        player:AddItem(itemID, itemCount)
    end

    player:SendBroadcastMessage("Items successfully added.")
    return false
end

RegisterPlayerEvent(42, OnBotCommandHandlerTwo)


