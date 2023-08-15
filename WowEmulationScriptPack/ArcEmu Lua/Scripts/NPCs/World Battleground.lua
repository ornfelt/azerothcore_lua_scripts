--Made by Laurea from wow-v.com!!
 
local MaxScore = 1000 --The score you need to win
local PerUpdate = 1 --How many points each team gets per flag and score update
local UpdateTimer = 5 --How often the score is updated in seconds (1-3600)
local Flag = 99000 --Entry id of the flag (if it doesnt exist the script automaticly creates it)
local WorldDB = "world" --Name of your world database
local StartMsg = "start bg" --Chat message you start the event with
 
--Do not edit anything beyond this point.
 
local Flags = {}
local AllianceScore = 0
local HordeScore = 0
local Started = false
 
function ScoreCounter_FlagTaken(go, event, player)
        if Started == true then
                if player:IsInCombat() then
                        player:SendBroadcastMessage("You cannot take a flag while in combat!")
                else
                        if Flags[go:GetSpawnId()] == nil then
                                Flags[go:GetSpawnId()] = 2
                        end
                        local team = player:GetTeam()
                        local owner = Flags[go:GetSpawnId()]
                        if team ~= owner then
                                local tmp
                                if team == 0 then
                                        tmp = "Alliance"
                                else
                                        tmp = "Horde"
                                end
                                SendWorldMessage(player:GetName().." has captured a flag for the "..tmp.."!", 1)
                                Flags[go:GetSpawnId()] = team
                        else
                                player:SendBroadcastMessage("Your team already owns this flag.")
                        end
                end
        end
end
 
function ScoreCounter_Create()
        if Started == true then
                ScoreCounter_Destroy()
        end
        local p = LuaPacket:CreatePacket(706, 18)
        p:WriteULong(1)
        p:WriteULong(1377)
        p:WriteULong(0)
        p:WriteUShort(1)
        p:WriteULong(0)
        p:WriteULong(1)
        SendPacketToWorld(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2317)
        p:WriteULong(MaxScore)
        SendPacketToWorld(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2313)
        p:WriteULong(AllianceScore)
        SendPacketToWorld(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2314)
        p:WriteULong(HordeScore)
        SendPacketToWorld(p)
        Started = true
        SendWorldMessage("World BG event has started.", 1)
end
function ScoreCounter_OnLogin(event, player)
        if Started == true then
                RegisterTimedEvent("ScoreCounter_CreateForPlayer", 100, 1, player)
        end
end
function ScoreCounter_CreateForPlayer(player)
        local p = LuaPacket:CreatePacket(706, 18)
        p:WriteULong(1)
        p:WriteULong(1377)
        p:WriteULong(0)
        p:WriteUShort(1)
        p:WriteULong(0)
        p:WriteULong(1)
        player:SendPacketToPlayer(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2317)
        p:WriteULong(MaxScore)
        player:SendPacketToPlayer(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2313)
        p:WriteULong(AllianceScore)
        player:SendPacketToPlayer(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2314)
        p:WriteULong(HordeScore)
        player:SendPacketToPlayer(p)
end
 
function ScoreCounter_Update()
        if Started == true then
                local Alliance = AllianceScore
                local Horde = HordeScore
                for k, v in pairs (Flags) do
                        if v == 0 then
                                Alliance = Alliance + PerUpdate
                        elseif v == 1 then
                                Horde = Horde + PerUpdate
                        end
                end
                if Alliance == AllianceScore and Horde == HordeScore then
                        return
                else
                        if Alliance >= MaxScore and Horde >= MaxScore then
                                ScoreCounter_Destroy()
                                SendWorldMessage("No side won the world BG event.", 1)
                                Started = false
                        elseif Alliance >= MaxScore then
                                ScoreCounter_Destroy()
                                SendWorldMessage("The Alliance has won the world BG event.", 1)
                                Started = false
                        elseif Horde >= MaxScore then
                                ScoreCounter_Destroy()
                                SendWorldMessage("The Horde has won the world BG event.", 1)
                                Started = false
                        else
                                AllianceScore = Alliance
                                HordeScore = Horde
                                local p = LuaPacket:CreatePacket(707, 8)
                                p:WriteULong(2313)
                                p:WriteULong(Alliance)
                                SendPacketToWorld(p)
                                p = LuaPacket:CreatePacket(707, 8)
                                p:WriteULong(2314)
                                p:WriteULong(Horde)
                                SendPacketToWorld(p)
                        end
                end
        end
end
 
function ScoreCounter_Destroy()
        AllianceScore = 0
        HordeScore = 0
        for k, v in pairs (Flags) do
                Flags[k] = 2
        end
        local p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2317)
        p:WriteULong(0)
        SendPacketToWorld(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2313)
        p:WriteULong(0)
        SendPacketToWorld(p)
        p = LuaPacket:CreatePacket(707, 8)
        p:WriteULong(2314)
        p:WriteULong(0)
        SendPacketToWorld(p)
        p = LuaPacket:CreatePacket(706, 18)
        p:WriteULong(0)
        p:WriteULong(0)
        SendPacketToWorld(p)
        Started = false
end
 
local RegisterCheck = true
 
assert(type(Flag) == "number", "Value of Flag is invalid. If you want the score counter to work please use a valid value next time.")
if RegisterCheck == true and WorldDBQuery("SELECT `entry` FROM `"..WorldDB.."`.`gameobject_names` WHERE `entry`="..Flag) == nil then
        WorldDBQuery("INSERT INTO `gameobject_names` (`entry`, `Type`, `DisplayID`, `Name`, `Category`, `CastBarText`, `UnkStr`, `spellfocus`, `sound1`, `sound2`, `sound3`, `sound4`, `sound5`, `sound6`, `sound7`, `sound8`, `sound9`, `unknown1`, `unknown2`, `unknown3`, `unknown4`, `unknown5`, `unknown6`, `unknown7`, `unknown8`, `unknown9`, `unknown10`, `unknown11`, `unknown12`, `unknown13`, `unknown14`, `Size`, `QuestItem1`, `QuestItem2`, `QuestItem3`, `QuestItem4`, `QuestItem5`, `QuestItem6`) VALUES ("..Flag..", 10, 6663, 'Flag', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);")
        print ("A gameobject with entry "..Flag.." does not exist. Creating one now.")
        RegisterCheck = false
elseif RegisterCheck == true and WorldDBQuery("SELECT `Name` FROM `"..WorldDB.."`.`gameobject_names` WHERE `entry`="..Flag):GetColumn(0):GetString() ~= "Flag" then
        print ("Gameobject with entry "..Flag.." does not meet the requirements of the score counter. If you want the score counter to work please change the value of Flag or delete the go from your database.")
        RegisterCheck = false
end
if WorldDB == nil then
        WorldDB = "world"
        print ("WorldDB was nil. Setting it back to \"world\", but its not sure its correct.")
end
if type(MaxScore) ~= "number" then
        MaxScore = 1000
        print ("MaxScore was not a number and got set back to 1000.")
end
if type(PerUpdate) ~= "number" then
        PerUpdate = 1
        print ("PerUpdate was not a number and got set back to 1.")
end
if type(UpdateTimer) ~= "number" then
        UpdateTimer = 5
        print ("UpdateTimer was not a number and got set back to 5.")
elseif UpdateTimer < 1 then
        UpdateTimer = 1
        print ("UpdateTimer was less than 1 and got set to 1.")
elseif UpdateTimer > 3600 then
        UpdateTimer = 3600
        print ("UpdateTimer was more than 3600 and got set back to 3600.")
end
if Flags == nil or AllianceScore ~= 0 or HordeScore ~= 0 or Started ~= false then
        RegisterCheck = false
        print ("Didnt I tell you not to touch anything beyond that point? Now reset anything you did or the script wont run.")
end
 
function ScoreCounter_Start(event, player, message)
        if message == StartMsg and player:IsGm() then
                if Started == false then
                        ScoreCounter_Create()
                else
                        player:SendAreaTriggerMessage("World BG event is already on.")
                end
                return 0
        end
end
 
if RegisterCheck == true then
        RegisterGameObjectEvent(Flag, 4, "ScoreCounter_FlagTaken")
        RegisterServerHook(19, "ScoreCounter_OnLogin")
        RegisterTimedEvent("ScoreCounter_Update", UpdateTimer*1000, 0)
        RegisterServerHook(16, "ScoreCounter_Start")
end