ACCOUNT_LEVEL = 3

local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035
local UNIT_FIELD_FLAGS2 = OBJECT_END + 0x0036
local UNIT_FIELD_BYTES_1 = OBJECT_END + 0x0044
local UNIT_FIELD_BYTES_2 = OBJECT_END + 0x0074
local UNIT_DYNAMIC_FLAGS = OBJECT_END + 0x0049
local SMSG_FORCE_DISPLAY_UPDATE = 1027
local SMSG_MIRRORIMAGE_DATA = 1026


local function SetDead(event, player, command)
        if (command:find("setdead") ~= 1) then
                return
        elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
                return false
        end

        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        local parameters = getCommandParameters(command)
        local target = player:GetSelection()
        local customizetype = tostring(parameters[2])

        if (customizetype == "") then
                player:SendBroadcastMessage("Invalid type. You can use: noname, name")
                return false
        end


        if (target == nil) then
                player:SendBroadcastMessage("You must have a target.")
                return false
        elseif (target:ToCreature() == nil) then
                player:SendBroadcastMessage("You must target a creature.")
                return false
        end



        if (customizetype == "noname") then
                target:SetFlag(UNIT_FIELD_BYTES_1, 7)
                target:SetFlag(UNIT_FIELD_FLAGS, 2+256+512+131072+262144+8192+33554432+536870912)
                target:SetFlag(UNIT_DYNAMIC_FLAGS, 32)
                local query1 = "UPDATE creature SET unit_flags = '570827522', dynamicflags = '32' WHERE guid = '" .. tostring(target:GetDBTableGUIDLow()) .. "';"
                local query2 = "INSERT INTO `creature_addon` (`guid`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (".. tostring(target:GetDBTableGUIDLow()) .. ", 7, 0, 0, NULL) ON DUPLICATE KEY UPDATE bytes1 = VALUES(bytes1);"
                WorldDBExecute(query1)
                WorldDBExecute(query2)
                player:SendBroadcastMessage("Set NPC in database to permadead, with no name visible. Do note it's visible if you're in GM mode.")
                return false
        elseif (customizetype == "name") then
                target:SetFlag(UNIT_FIELD_BYTES_1, 7)
                target:SetFlag(UNIT_FIELD_FLAGS, 2+256+512+131072+262144+8192)
                target:SetFlag(UNIT_DYNAMIC_FLAGS, 32)
                local query1 = "UPDATE creature SET unit_flags = '402178', dynamicflags = '32' WHERE guid = '" .. tostring(target:GetDBTableGUIDLow()) .. "';"
                local query2 = "INSERT INTO `creature_addon` (`guid`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (".. tostring(target:GetDBTableGUIDLow()) .. ", 7, 0, 0, NULL) ON DUPLICATE KEY UPDATE bytes1 = VALUES(bytes1);"
                WorldDBExecute(query1)
                WorldDBExecute(query2)
                player:SendBroadcastMessage("Set NPC in database to permadead, with name visible.")
                return false
        end


end


RegisterPlayerEvent(42, SetDead)