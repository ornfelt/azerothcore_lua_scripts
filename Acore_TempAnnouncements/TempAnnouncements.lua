--
--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 15/07/2021
-- Time: 11:22
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module


-- This module spawns (custom) NPCs and grants them scripted combat abilities
------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in this file
--               -  add this script to ../lua_scripts/
------------------------------------------------------------------------------------------------
-- GM GUIDE:     -  Use .tannounce $min $amount $text to do repeated server wide announcements.
--               -  $min is the time between each repetition in minutes.
--               -  $amount is the amount of broadcasts. 0 means until server restart or reload eluna.
--               -  $text Is the exact text to broacast. No quotes required. Forbidden chars: []';
------------------------------------------------------------------------------------------------
local Config = {}                       --general config flags

-- Name of Eluna dB scheme
Config.customDbName = "ac_eluna"
-- Min GM rank to post an announcement
Config.GMRankForAnnouncements = 2
-- set to 1 to print error messages to the console. Any other value including nil turns it off.
Config.printErrorsToConsole = 1

------------------------------------------
-- NO ADJUSTMENTS REQUIRED BELOW THIS LINE
------------------------------------------
-- Constants:
local PLAYER_EVENT_ON_COMMAND = 42          -- (event, player, command) - player is nil if command used from console. Can return false
local GOSSIP_EVENT_ON_HELLO = 1             -- (event, player, object) - Object is the Creature/GameObject/Item. Can return false to do default action. For item gossip can return false to stop spell casting.
local GOSSIP_EVENT_ON_SELECT = 2            -- (event, player, object, sender, intid, code, menu_id)
local OPTION_ICON_CHAT = 0

-- Local variables:
local repetitionsLeft = {}                  -- amount of repetitions left for the announcements
local minutesBetween = {}                   -- time between two announcements with the same text in minutes
local announcementText = {}                 -- text for the announcements
local eventId = {}

local function tA_is_numeric(x)
    if tonumber(x) ~= nil then
        return true
    end
    return false
end

local function tA_splitString(inputstr, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..seperator.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function tA_returnIndex (tab, val)
    for index, value in pairs(tab) do
        if value == val then
            return index
        end
    end
    return false
end

local function tA_getTimeSince(time)
    local dt = GetTimeDiff(time)
    return dt
end

local function tA_getFreeId()
    local n = 1
    while repetitionsLeft[n] ~= nil do
        n = n + 1
    end
    return n
end

local function tA_listAnnouncements(chatHandler)
    local returnBool
    for n = 1,255 do
        if repetitionsLeft[n] ~= nil then
            returnBool = true
            if repetitionsLeft[n] == 0 then
                chatHandler:SendSysMessage('ID:'..n..' delay: '..minutesBetween[n]..'min, shots left: until restart/reload, Text: '..announcementText[n])
            else
                chatHandler:SendSysMessage('ID:'..n..' delay: '..minutesBetween[n]..'min, shots left: '..repetitionsLeft[n]..', Text: '..announcementText[n])
            end
        end
    end

    if returnBool ~= true then
        chatHandler:SendSysMessage("No announcements scheduled.")
    end
end

local function tA_deleteAnnouncement(id)
    if minutesBetween[id] ~= nil then
        repetitionsLeft[id] = nil
        minutesBetween[id] = nil
        announcementText[id] = nil
        eventId[id] = nil
        CharDBExecute('DELETE FROM `'..Config.customDbName..'`.`temporary_announcements` WHERE `id` = '..id..';')
    end
    return id
end

local function tA_doAnnouncement(id, delay, repeats)
    local index = tA_returnIndex(eventId, id)
    if announcementText[index] ~= nil then
        SendWorldMessage(announcementText[index])
        if repetitionsLeft[index] == 1 then
            tA_deleteAnnouncement(index)
        else
            if repetitionsLeft[index] ~= 0 then
                repetitionsLeft[index] = repetitionsLeft[index] - 1
            end
            CharDBExecute('UPDATE `'..Config.customDbName..'`.`temporary_announcements` SET repetitions_left = '..repetitionsLeft[index]..' WHERE `id` = '..index..';')
        end
    end
end

local function tA_createAnnouncement(delayMin, repeats, text, store, index)
    if index == nil then
        index = tA_getFreeId()
    end
    if index >= 100 then
        return "Too many active announcements"
    end
    local delayMs = delayMin * 60000
    repetitionsLeft[index] = repeats
    minutesBetween[index] = delayMin
    announcementText[index] = text
    eventId[index] = CreateLuaEvent(tA_doAnnouncement, delayMs, repeats)
    if store == true and repetitionsLeft[index] ~= 0 then
        CharDBExecute('REPLACE INTO `'..Config.customDbName..'`.`temporary_announcements` (`id`, `repetitions_left`, `minutes_between`, `announcement_text`) VALUES ('..index..', '..repetitionsLeft[index]..', '..minutesBetween[index]..', "'..announcementText[index]..'");')
    end
    return index
end

local function tA_command(event, player, command, chatHandler)
    --prevent players from using this
    if player ~= nil then
        if player:GetGMRank() < Config.GMRankForAnnouncements then
            return
        end
    end

    local commandArray = {}

    -- split the command variable into several strings which can be compared individually
    commandArray = tA_splitString(command)

    if commandArray[1] ~= "tannounce" then
        return
    end

    if commandArray[2] ~= nil then
        commandArray[2] = commandArray[2]:gsub("[';\\, ]", "")
        if commandArray[3] ~= nil then
            commandArray[3] = commandArray[3]:gsub("[';\\, ]", "")
        end
    end

    if commandArray[1] == "tannounce" then
        if commandArray[2] == "list" then
            tA_listAnnouncements(chatHandler)
            return false
        elseif commandArray[2] == "delete" then
            if commandArray[3] ~= nil then
                commandArray[3] = tonumber(commandArray[3])
                if minutesBetween[commandArray[3]] == nil then
                    chatHandler:SendSysMessage("There is no announcement with id: "..commandArray[3])
                    return false
                end
                chatHandler:SendSysMessage("Deleting announcement with id: "..tA_deleteAnnouncement(commandArray[3]))
            else
                chatHandler:SendSysMessage("Invalid syntax. Expected: tannounce delete $id")
            end
            return false
        elseif commandArray[2] == nil or commandArray[3] == nil or commandArray[4] == nil or tA_is_numeric(commandArray[2]) == false or tA_is_numeric(commandArray[3]) == false then
            chatHandler:SendSysMessage("Invalid syntax. Expected: tannounce $delay $repetitions $text")
            return false
        end

        local text = ""
        for index,value in ipairs(commandArray) do
            if index >= 4 then
                text = text..commandArray[index].." "
            end
        end

        commandArray[2] = tonumber(commandArray[2])
        commandArray[3] = tonumber(commandArray[3])
        text = text:gsub("[\";]", "")

        chatHandler:SendSysMessage("Creating event with id: "..tA_createAnnouncement(commandArray[2],commandArray[3],text,true))
        return false
    end
end

--on ReloadEluna / Startup
RegisterPlayerEvent(PLAYER_EVENT_ON_COMMAND, tA_command)

CharDBQuery('CREATE DATABASE IF NOT EXISTS `'..Config.customDbName..'`;');
CharDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.customDbName..'`.`temporary_announcements` (`id` INT NOT NULL, `repetitions_left` INT DEFAULT 0, `minutes_between` INT Default 60, `announcement_text` varchar(255), PRIMARY KEY (`id`));');

local Data_SQL = CharDBQuery('SELECT * FROM `'..Config.customDbName..'`.`temporary_announcements`;')
if Data_SQL ~= nil then
    local row
    repeat
        row = Data_SQL:GetRow()
        tA_createAnnouncement(row.minutes_between, row.repetitions_left, row.announcement_text, false, row.id)
    until not Data_SQL:NextRow()
end
