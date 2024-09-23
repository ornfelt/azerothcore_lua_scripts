--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 28/02/2021
-- Time: 23:16
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module

-- Updated By: Ragundah
-- Date: 13/05/2021

--Players will receive rewards when their characters reach the levels in brackets. 
------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in this file
--               -  create a character who appears as sender of the mails with senderGUID
--               -  add this script to ../lua_scripts/
------------------------------------------------------------------------------------------------

local Config_Gold = {}
local Config_ItemId = {}
local Config_ItemAmount = {}
local LUR_playerCounter = {}

Config_Gold[10] = 10000       -- gold granted when reaching level [10] in copper. 10000 =  1 gold. Cost for spells 10-18 (mage): ~1g50s
Config_Gold[20] = 70000       --  Cost for spells 20-28 (mage): ~11g
Config_Gold[30] = 180000      --  Cost for spells 30-38 (mage): ~27g
Config_Gold[40] = 350000      --  Cost for spells 40-48 (mage): ~50g
Config_Gold[50] = 650000      --  Cost for spells 50-58 (mage): ~93g
Config_Gold[61] = 600000
Config_Gold[65] = 800000
Config_Gold[71] = 1000000
Config_Gold[75] = 1800000
Config_Gold[80] = 5000000

Config_ItemId[29] = 5740      -- item granted when reaching level [29] / 5740 is a cosmetic red rocket
Config_ItemAmount[29] = 5     -- amount of items to be granted when reaching level [29]. Missing amounts are automatically set to 1 if an ItemId is given
Config_ItemId[35] = 34412
Config_ItemAmount[35] = 10
Config_ItemId[39] = 9312
Config_ItemAmount[39] = 5
Config_ItemId[43] = 35563
Config_ItemAmount[43] = 10
Config_ItemId[46] = 35565
Config_ItemAmount[46] = 10
Config_ItemId[49] = 9313
Config_ItemAmount[49] = 5
Config_ItemId[59] = 9314
Config_ItemAmount[59] = 5
Config_ItemId[60] = 9315
Config_ItemAmount[60] = 5
Config_ItemId[64] = 9312
Config_ItemAmount[64] = 5
Config_ItemId[69] = 9313
Config_ItemAmount[69] = 5
Config_ItemId[70] = 9314
Config_ItemAmount[70] = 5

-- General Settings Config
local Config_mailText = 2           -- Which text to send in the mail to the player.
local Config_senderGUID = 10667     -- GUID/ID of the Player/Creature. If Config_preventReturn = true then you need to put Creature ID. If it's false Player GUID. 0 = No sender aka "From: Unknown".
local Config_mailStationery = 41    -- Stationary used in the mail sent to the player. (41 Normal Mail, 61 GM/Blizzard Support, 62 Auction, 64 Valentines, 65 Christmas) Note: Use 62, 64, and 65 At your own risk.
local Config_maxGMRank = 0          -- Checks the player's assigned GM rank. Anything above the assigned default will not receive mail/be counted for the player counter. Default 0 - Players Only. Max 3 - All GMS/Mods/Etc will receive as well.
local Config_preventReturn = true   -- Modify's the Mail database to prevent returning of rewards. Note: If you are experiencing server lag after installing this module please disable this option to see if it helps.

-- Config_mailText == 1 Config
local Config_mailSubject1 = "Chromies reward for You!"
local Config_mailText1 = "!\n\nYou've done well while advancing on ChromieCraft. Here is a small reward to celebrate your heroic deeds. Go forth!\n\nKind regards,\nChromie"
-- Config_mailText == 2 Config
local Config_mailSubject2 = "Chromies reward for You!"
local Config_mailText2A = " and congratulations! \n\nThe bronze Dragonflight would like to inform you that you were the "
local Config_mailText2B = " adventurer to reach the "
local Config_mailText2C = " level of mastery.\nYour adventures have made me take notice of you, take this small reward as a token of my appreciation.\nGo forth!\n\nKind regards,\nChromie"

-- Name of Eluna dB scheme
local Config_customDbName = 'ac_eluna';

------------------------------------------
-- NO ADJUSTMENTS REQUIRED BELOW THIS LINE
------------------------------------------

CharDBQuery('CREATE DATABASE IF NOT EXISTS `'..Config_customDbName..'`;');
CharDBQuery('CREATE TABLE IF NOT EXISTS `'..Config_customDbName..'`.`levelup_reward` (`level` INT NOT NULL, `counter` INT DEFAULT 0, PRIMARY KEY (`level`) );');

local n
for n = 2,80,1 do
    LUR_playerCounter[n] = 0
end

Data_SQL = CharDBQuery('SELECT `level`, `counter` FROM `'..Config_customDbName..'`.`levelup_reward`;');
if Data_SQL ~= nil then
    local levelRow
    repeat
        levelRow = Data_SQL:GetUInt32(0)
        LUR_playerCounter[levelRow] = Data_SQL:GetUInt32(1)
    until not Data_SQL:NextRow()
end


local PLAYER_EVENT_ON_LEVEL_CHANGE = 13

local function PreventReturn(playerGUID)
	if Config_preventReturn == true then
		CharDBExecute('UPDATE `mail` SET `messageType` = 3 WHERE `sender` = '..Config_senderGUID..' AND `receiver` = '..playerGUID..' AND `messageType` = 0;')
	end
end

local function GrantReward(event, player, oldLevel)
    if oldLevel ~= nil and player:GetGMRank() <= Config_maxGMRank then
        if Config_mailText == 1 then
            if Config_ItemId[oldLevel + 1] ~= nil then
                local playerName = player:GetName()
                local playerGUID = tostring(player:GetGUID())
                local itemAmount
                if Config_ItemAmount[oldLevel + 1] ~= nil then
                    itemAmount = Config_ItemAmount[oldLevel + 1]
                else
                    itemAmount = 1
                end
                if Config_Gold[oldLevel + 1] == nil then
                    Config_Gold[oldLevel + 1] = 0
                end
                SendMail(Config_mailSubject1, "Hello "..playerName..Config_mailText1, playerGUID, Config_senderGUID, Config_mailStationery, 0, Config_Gold[oldLevel + 1],0,Config_ItemId[oldLevel + 1], itemAmount)
                print("LevelUpReward has granted "..Config_Gold[oldLevel + 1].." copper and "..itemAmount.." of item "..Config_ItemId[oldLevel + 1].." to character "..playerName.." with guid "..playerGUID..".")
                PreventReturn(playerGUID)
                playerName = nil
                playerGUID = nil
                return false
            elseif Config_Gold[oldLevel + 1] ~= nil then
                local playerName = player:GetName()
                local playerGUID = tostring(player:GetGUID())
                SendMail(Config_mailSubject1, "Hello "..playerName..Config_mailText1, playerGUID, Config_senderGUID, Config_mailStationery, 0, Config_Gold[oldLevel + 1])
                print("LevelUpReward has granted "..Config_Gold[oldLevel + 1].." copper to character "..playerName.." with guid "..playerGUID..".")
                PreventReturn(playerGUID)
                playerName = nil
                playerGUID = nil
                return false
            end
        end

        local playerCounterStr
        local currentLevelStr
        local currentLevel = oldLevel + 1
        LUR_playerCounter[currentLevel] = LUR_playerCounter[currentLevel] + 1
        CharDBExecute('REPLACE INTO `'..Config_customDbName..'`.`levelup_reward` VALUES ('..currentLevel..', '..LUR_playerCounter[currentLevel]..');');
        playerCounterStr = tostring(LUR_playerCounter[currentLevel])
        if string.sub(playerCounterStr, -1) == "1" then
            playerCounterStr = playerCounterStr.."st"
        elseif string.sub(playerCounterStr, -1) == "2" then
            playerCounterStr = playerCounterStr.."nd"
        elseif string.sub(playerCounterStr, -1) == "3" then
            playerCounterStr = playerCounterStr.."rd"
        else
            playerCounterStr = playerCounterStr.."th"
        end

        currentLevelStr = tostring(currentLevel)
        if string.sub(currentLevelStr, -1) == "1" then
            currentLevelStr = currentLevelStr.."st"
        elseif string.sub(currentLevelStr, -1) == "2" then
            currentLevelStr = currentLevelStr.."nd"
        elseif string.sub(currentLevelStr, -1) == "3" then
            currentLevelStr = currentLevelStr.."rd"
        else
            currentLevelStr = currentLevelStr.."th"
        end

        if Config_mailText == 2 then
            if Config_ItemId[oldLevel + 1] ~= nil and Config_mailText == 2 then
                local playerName = player:GetName()
                local playerGUID = tostring(player:GetGUID())
                local itemAmount
                if Config_ItemAmount[oldLevel + 1] ~= nil then
                    itemAmount = Config_ItemAmount[oldLevel + 1]
                else
                    itemAmount = 1
                end
                if Config_Gold[oldLevel + 1] == nil then
                    Config_Gold[oldLevel + 1] = 0
                end
                SendMail(Config_mailSubject2, "Hello "..playerName..Config_mailText2A..playerCounterStr..Config_mailText2B..currentLevelStr..Config_mailText2C, playerGUID, Config_senderGUID, Config_mailStationery, 0, Config_Gold[oldLevel + 1],0,Config_ItemId[oldLevel + 1], itemAmount)
                print("LevelUpReward has granted "..Config_Gold[oldLevel + 1].." copper and "..itemAmount.." of item "..Config_ItemId[oldLevel + 1].." to character "..playerName.." with guid "..playerGUID..".")
                PreventReturn(playerGUID)
                playerName = nil
                playerGUID = nil
                return false
            elseif Config_Gold[oldLevel + 1] ~= nil and Config_mailText == 2 then
                local playerName = player:GetName()
                local playerGUID = tostring(player:GetGUID())
                SendMail(Config_mailSubject2, "Hello "..playerName..Config_mailText2A..playerCounterStr..Config_mailText2B..currentLevelStr..Config_mailText2C, playerGUID, Config_senderGUID, Config_mailStationery, 0, Config_Gold[oldLevel + 1])
                print("LevelUpReward has granted "..Config_Gold[oldLevel + 1].." copper to character "..playerName.." with guid "..playerGUID..".")
                PreventReturn(playerGUID)
                playerName = nil
                playerGUID = nil
                return false
            end
        end
    end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LEVEL_CHANGE, GrantReward)

