--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 18/02/2021
-- Time: 23:28
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module

------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in this file
--               -  add this script to ../lua_scripts/
--               -  grant account related tickets in the `carboncopy` table
-- PLAYER USAGE: 1) create a new character with same class/race as the one to copy in the same account. Do NOT log it in
--               2) log in with the source character
--               3) .carboncopy newToonsName
------------------------------------------------------------------------------------------------

local Config = {};
local cc_maps = {};
local ticket_Cost = {};

-- Name of Eluna dB scheme
Config.customDbName = 'ac_eluna';
-- Min GM Level to use the .carboncopy command. Set to 0 for all players.
Config.minGMRankForCopy = 0;
-- Min GM Level to add tickets to an account.
Config.minGMRankForTickets = 2;
-- The amount of free tickets to grant when .carboncopy is executed for the first time on that account
Config.freeTickets = 1;
-- This text is added to the mail which the new character receives alongside their copied items
Config.mailText = ",\n \n here you are your gear. Have fun with the new twink!\n \n- Sincerely,\n the team of ChromieCraft!";
-- Maximum level to allow copying a character.
Config.maxLevel = 49;
-- Whether the ticket amount withdrawn for a copy is always 1 (set it to "single") or depends on the level (set this to "level")
Config.ticketCost = "level";
-- Here you can adjust the cost in tickets if Config.ticketCost is set to "level"
ticket_Cost[19] = 1		--it costs 1 ticket to copy a character up to level 19
ticket_Cost[29] = 2
ticket_Cost[39] = 3
ticket_Cost[49] = 5
ticket_Cost[59] = 8
ticket_Cost[69] = 12
ticket_Cost[79] = 18
ticket_Cost[80] = 25	--it costs 25 tickets to copy a character at level 80

-- The maps below specify legal locations to use the .carboncopy command.
-- This is used to prevent dungeon specific gear to be copied e.g. the legendaries from the Kael'thas encounter.
-- Eastern kingdoms
table.insert(cc_maps, 0)
-- Kalimdor
table.insert(cc_maps, 1)
-- Outland
table.insert(cc_maps, 530)
-- Northrend
table.insert(cc_maps, 571)


------------------------------------------
-- NO ADJUSTMENTS REQUIRED BELOW THIS LINE
------------------------------------------

--Globals (see cleanup function for non-arrays)
cc_oldItemGuids = {}
cc_newItemGuids = {}
cc_scriptIsBusy = 0

-- If module runs for the first time, create the db specified in Config.dbName and add the "carboncopy" table to it.
CharDBQuery('CREATE DATABASE IF NOT EXISTS `'..Config.customDbName..'`;');
CharDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.customDbName..'`.`carboncopy` (`account_id` INT(11) NOT NULL, `tickets` INT(11) DEFAULT 0, `allow_copy_from_id` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`) );');

function cc_CopyCharacter(event, player, command, chatHandler)

    local commandArray = cc_splitString(command)
    if commandArray[2] ~= nil then
        commandArray[2] = commandArray[2]:gsub("[';\\, ]", "")
        if commandArray[3] ~= nil then
            commandArray[3] = commandArray[3]:gsub("[';\\, ]", "")
        end
    end

    if commandArray[1] ~= "carboncopy" and commandArray[1] ~= "addcctickets" and commandArray[1] ~= "CCACCOUNTTICKETS" then
        return
    end

    if cc_scriptIsBusy ~= 0 then
        chatHandler:SendSysMessage("The server is currently busy. Please try again in a few seconds.")
        PrintInfo("CarbonCopy user request failed because the script has a scheduled task.")
        return false
    end

    if commandArray[1] == "carboncopy" then
        if player == nil then
            chatHandler:SendSysMessage("This command can not be run from the console, but only from the character to copy.")
            chatHandler:SendSysMessage("Expected syntax: .addcctickets $CharacterName $Amount")
            return false
        end
        -- make sure the player is properly ranked
        if player:GetGMRank() < Config.minGMRankForCopy then
            chatHandler:SendSysMessage("You lack permisisions to execute this command.")
            cc_resetVariables()
            return false
        end

        -- provide syntax help 
        if commandArray[2] == "help" then
            chatHandler:SendSysMessage("Syntax: .carboncopy $NewCharacterName")
            cc_resetVariables()
            return false
        end

        -- print the available tickets
        local accountId = player:GetAccountId()
        if commandArray[2] == nil then
            local Data_SQL
            Data_SQL = CharDBQuery('SELECT `tickets` FROM `'..Config.customDbName..'`.`carboncopy` WHERE `account_id` = '..accountId..' LIMIT 1;');
            if Data_SQL  ~= nil then
                oldTickets = Data_SQL:GetUInt32(0)
            else
                oldTickets = Config.freeTickets
                CharDBExecute('REPLACE INTO `'..Config.customDbName..'`.`carboncopy` VALUES ('..accountId..', '..Config.freeTickets..', 0) ;')
            end
            chatHandler:SendSysMessage("You currently have "..oldTickets.." tickets available for CarbonCopy.")
            cc_resetVariables()
            return false
        end
        -- check maxLevel
        if player:GetLevel() > Config.maxLevel then
            chatHandler:SendSysMessage("The character you want to copy from is too high level. Max level is "..Config.maxLevel..". Aborting.")
            cc_resetVariables()
            return false
        end

        cc_playerGUID = tostring(player:GetGUID())
        cc_playerGUID = tonumber(cc_playerGUID)
        local targetName = commandArray[2]:gsub("^%l", string.upper)
    
        --check for target character to be on same account
        local Data_SQL = CharDBQuery('SELECT `account` FROM `characters` WHERE `name` = "'..targetName..'" LIMIT 1;');
        if Data_SQL == nil then
            chatHandler:SendSysMessage("Name not found. Check spelling. Aborting.")
            cc_resetVariables()
            return false
        end
        local targetAccountId = Data_SQL:GetUInt32(0)
        Data_SQL = nil
        if targetAccountId ~= accountId then
            chatHandler:SendSysMessage("The requested character is not on the same account. Aborting.")
            cc_resetVariables()
            return false
        end

        local Data_SQL = CharDBQuery('SELECT `guid` FROM `characters` WHERE `name` = "'..targetName..'" LIMIT 1;');
        local newCharacter
        if Data_SQL ~= nil then
            newCharacter = Data_SQL:GetUInt32(0)
       	else
            chatHandler:SendSysMessage("Name not found. Check spelling. Aborting.")
            cc_resetVariables()
            return false
        end
        Data_SQL = nil

        --check for available tickets
        local Data_SQL = CharDBQuery('SELECT `tickets` FROM `'..Config.customDbName..'`.`carboncopy` WHERE `account_id` = '..accountId..';');
        local availableTickets
        local requiredTickets
        if Data_SQL ~= nil then
            availableTickets = Data_SQL:GetUInt32(0)
            Data_SQL = nil
        else
            CharDBExecute('REPLACE INTO `'..Config.customDbName..'`.`carboncopy` VALUES ('..accountId..', '..Config.freeTickets..', 0) ;')
            availableTickets = Config.freeTickets
        end

        if Config.ticketCost == "single" then
            if availableTickets ~= nil and availableTickets <= 0 then
                chatHandler:SendSysMessage("You do not have enough Carbon Copy tickets to execute this command. Aborting.")
                cc_resetVariables()
                return false
            end
            requiredTickets = 1
        elseif Config.ticketCost == "level" then
            local Data_SQL = CharDBQuery('SELECT `level` FROM `characters` WHERE `guid` = '..cc_playerGUID..' LIMIT 1;');
            local n = Data_SQL:GetUInt8(0) - 1
            repeat
                n = n + 1
            until ticket_Cost[n] ~= nil
            requiredTickets = ticket_Cost[n]
            if availableTickets ~= nil and availableTickets <= 0 then
                chatHandler:SendSysMessage("You do not have enough Carbon Copy tickets to execute this command. Aborting.")
                cc_resetVariables()
                return false
            end
            if availableTickets < requiredTickets then
                chatHandler:SendSysMessage("You do not have enough Carbon Copy tickets to execute this command. Aborting.")
                cc_resetVariables()
                return false
            end
            Data_SQL = nil
        else
            PrintError("Unhandled exception in CarbonCopy. Config.ticketCost is neither set to \"single\" nor \"level\".")
        end

        --check for target character to be same class/race
        local Data_SQL = CharDBQuery('SELECT `race`, `class` FROM `characters` WHERE `guid` = '..cc_playerGUID..' LIMIT 1;');
        local sourceRace = Data_SQL:GetUInt8(0)
        local sourceClass = Data_SQL:GetUInt8(1)
        Data_SQL = nil

        local Data_SQL = CharDBQuery('SELECT `race`, `class` FROM `characters` WHERE `guid` = '..newCharacter..' LIMIT 1;');
        local targetRace = Data_SQL:GetUInt8(0)
        local targetClass = Data_SQL:GetUInt8(1)
        Data_SQL = nil

        if sourceRace ~= targetRace then
            chatHandler:SendSysMessage("The requested character is not the same race as this character. Aborting.")
            cc_resetVariables()
            return false
        end
        if sourceClass ~= targetClass then
            chatHandler:SendSysMessage("The requested character is not the same class as this character. Aborting.")
            cc_resetVariables()
            return false
        end

        -- check if target character wasn't logged in
        local cc_cinematic
        local Data_SQL = CharDBQuery('SELECT cinematic FROM characters WHERE guid = '..newCharacter..';');
        if Data_SQL ~= nil then
            cc_cinematic = Data_SQL:GetUInt16(0)
            if cc_cinematic == 1 then
                chatHandler:SendSysMessage("The requested character has been logged in already. Aborting.")
                cc_cinematic = nil
                cc_resetVariables()
                return false
            end
        else
            PrintError("Unhandled exception in CarbonCopy. Could not read characters.cinematic from cc_playerGUID "..newCharacter..".")
        end

        -- check if target character is logged in currently in case cinematic wasnt already written to db
        local cc_online
        local Data_SQL = CharDBQuery('SELECT online FROM characters WHERE guid = '..newCharacter..';');
        if Data_SQL ~= nil then
            cc_online = Data_SQL:GetUInt16(0)
            if cc_online == 1 then
                chatHandler:SendSysMessage("The requested character has been logged in already. Aborting.")
                cc_online = nil
                cc_resetVariables()
                return false
            end
        else
            PrintError("Unhandled exception in CarbonCopy. Could not read characters.online from cc_playerGUID "..newCharacter..".")
        end

        -- check source characters location
        local cc_mapId
        cc_mapId = player:GetMapId()
        if not cc_has_value(cc_maps, cc_mapId) then
            chatHandler:SendSysMessage("You are not in an allowed map. Try again outside/not in a dungeon.")
            cc_resetVariables()
            return false
        end

        -------------- COPY SCRIPT STARTS HERE ---------------------
        --set Global variable to prevent simultaneous action and lock the target for 15 seconds
        Ban(1, targetName, 15, "CarbonCopy", "CarbonCopy" )
        cc_scriptIsBusy = 1
        cc_newCharacter = newCharacter
        
        -- save the source character to db to prevent recent changes from being not applied
        player:SaveToDB()

        --fetch all required variables before 1st yield
        cc_playerString = player:GetClassAsString(0)
        PrintInfo("1) The player with GUID "..cc_playerGUID.." has succesfully initiated the .carboncopy command. Target character: "..cc_newCharacter);
        chatHandler:SendSysMessage("Copy started. You have been charged "..requiredTickets.." ticket(s) for this action. There are "..availableTickets - requiredTickets.." ticket()s left.")
        chatHandler:SendSysMessage("STAY logged in for one minute!")
        chatHandler:SendSysMessage("RIMANENTE connessi per un minuto!")
        chatHandler:SendSysMessage("MANTENTE conectado por un minuto!")
        chatHandler:SendSysMessage("BLEIB eingeloggt für eine Minute!")

        cc_eventId = CreateLuaEvent(cc_resumeSubRoutine, 1000, 10)

        cc_subRoutine = coroutine.create(function ()

        -- deduct tickets
        if Config.ticketCost == "single" then
            local Data_SQL = CharDBQuery('UPDATE `'..Config.customDbName..'`.`carboncopy` SET tickets = tickets -1 WHERE `account_id` = '..accountId..';');
            Data_SQL = nil
        elseif Config.ticketCost == "level" then
            local Data_SQL = CharDBQuery('UPDATE `'..Config.customDbName..'`.`carboncopy` SET tickets = tickets -'..requiredTickets..' WHERE `account_id` = '..accountId..';');
            Data_SQL = nil
        end

        -- delete TempTables
        cc_deleteTempTables(cc_playerGUID)

        -- Copy characters table
        local QueryString
        QueryString = 'UPDATE `characters` AS t1 '
        QueryString = QueryString..'INNER JOIN `characters` AS t2 ON t2.guid = '..cc_playerGUID..' '
        QueryString = QueryString..'SET t1.level = t2.level, t1.xp = t2.xp, t1.taximask = t2.taximask, t1.totaltime = t2.totaltime, '
        QueryString = QueryString..'t1.leveltime = t2.leveltime, t1.stable_slots = t2.stable_slots, t1.health = t2.health, '
        QueryString = QueryString..'t1.power1 = t2.power1, t1.power2 = t2.power2, t1.power3 = t2.power3, t1.power4 = t2.power4, '
        QueryString = QueryString..'t1.power5 = t2.power5, t1.power6 = t2.power6, t1.power7 = t2.power7, t1.talentGroupsCount = t2.talentGroupsCount, '
        QueryString = QueryString..'t1.exploredZones = t2.exploredZones WHERE t1.guid = '..cc_newCharacter..';'
        local Data_SQL = CharDBQuery(QueryString);
        QueryString = nil
        Data_SQL = nil
        local Data_SQL = CharDBQuery('UPDATE characters SET cinematic = 1 WHERE guid = '..cc_newCharacter..';');

        coroutine.yield()
        -- Copy character_homebind
        local Data_SQL = CharDBQuery('DELETE FROM character_homebind WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_homebind VALUES ('..cc_newCharacter..' ,0,0,0,0,0);')
        QueryString = 'UPDATE character_homebind AS t1 INNER JOIN character_homebind AS t2 ON t2.guid = '..cc_playerGUID..' '
        QueryString = QueryString..'SET t1.mapId = t2.mapId, t1.zoneId = t2.zoneId, t1.posX = t2.posX, t1.posY = t2.posY, t1.posZ = t2.posZ '
        QueryString = QueryString..'WHERE t1.guid = '..cc_newCharacter..';'
        local Data_SQL = CharDBQuery(QueryString);
        QueryString = nil
        Data_SQL = nil

        -- Copy character_pet and totems
        if cc_playerString == "Hunter" then
            local Data_SQL = CharDBQuery('SELECT id FROM character_pet WHERE owner = '..cc_playerGUID..' LIMIT 1;');
            if Data_SQL ~= nil then
                cc_playerPetId = Data_SQL:GetUInt32(0)
                Data_SQL = nil

                local Data_SQL = CharDBQuery('SELECT MAX(id) FROM character_pet;');
                local cc_targetPetId = Data_SQL:GetUInt32(0) + 1
                Data_SQL = nil

                local Data_SQL = CharDBQuery('DELETE FROM character_pet WHERE owner = '..cc_newCharacter..';')
                local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempPet'..cc_playerGUID..' LIKE character_pet;')
                local Data_SQL = CharDBQuery('INSERT INTO tempPet'..cc_playerGUID..' SELECT * FROM character_pet WHERE id = '..cc_playerPetId..';')
                local Data_SQL = CharDBQuery('UPDATE tempPet'..cc_playerGUID..' SET id = '..cc_targetPetId..', slot = 0, owner = '..cc_newCharacter..';')
                local Data_SQL = CharDBQuery('INSERT INTO character_pet SELECT * FROM tempPet'..cc_playerGUID..';')
                local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempPet'..cc_playerGUID..';')

                QueryString = nil
                Data_SQL = nil

                local Data_SQL = CharDBQuery('DELETE FROM pet_spell WHERE guid = '..cc_targetPetId..';')
                local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempPet_spell'..cc_playerGUID..' LIKE pet_spell;')
                local Data_SQL = CharDBQuery('INSERT INTO tempPet_spell'..cc_playerGUID..' SELECT * FROM pet_spell WHERE guid = '..cc_playerPetId..';')
                local Data_SQL = CharDBQuery('UPDATE tempPet_spell'..cc_playerGUID..' SET guid = '..cc_targetPetId..' WHERE guid = '..cc_playerPetId..';')
                local Data_SQL = CharDBQuery('INSERT INTO pet_spell SELECT * FROM tempPet_spell'..cc_playerGUID..';')
                local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempPet_spell'..cc_playerGUID..';')
                QueryString = nil
                Data_SQL = nil
            end
        elseif cc_playerString == "Shaman" then
            local totemItem = {}
            totemItem[1] = 38
            totemItem[2] = 38
            totemItem[3] = 38
            totemItem[4] = 38
            local totemsDone = 0
            local Data_SQL
            Data_SQL = CharDBQuery('SELECT itemEntry FROM item_instance WHERE owner_guid = '..cc_playerGUID..' AND itemEntry = 5178 LIMIT 1;')
            if Data_SQL ~= nil then
                if Data_SQL:GetUInt16(0) == 5178 then
                    totemItem[4] = 5178
                end
            end
            Data_SQL = nil

            local Data_SQL
            Data_SQL = CharDBQuery('SELECT itemEntry FROM item_instance WHERE owner_guid = '..cc_playerGUID..' AND itemEntry = 5177 LIMIT 1;')
            if Data_SQL ~= nil then
                if Data_SQL:GetUInt16(0) == 5177 then
                    totemItem[3] = 5177
                end
            end
            Data_SQL = nil

            local Data_SQL
            Data_SQL = CharDBQuery('SELECT itemEntry FROM item_instance WHERE owner_guid = '..cc_playerGUID..' AND itemEntry = 5176 LIMIT 1;')
            if Data_SQL ~= nil then
                if Data_SQL:GetUInt16(0) == 5176 then
                    totemItem[2] = 5176
                end
            end
            Data_SQL = nil

            local Data_SQL
            Data_SQL = CharDBQuery('SELECT itemEntry FROM item_instance WHERE owner_guid = '..cc_playerGUID..' AND itemEntry = 5175 LIMIT 1;')
            if Data_SQL ~= nil then
                if Data_SQL:GetUInt16(0) == 5175 then
                    totemItem[1] = 5175
                end
            end
            Data_SQL = nil

            SendMail("Copied items", "Hello "..targetName..Config.mailText, cc_newCharacter, 0, 61, 0, 0, 0, totemItem[1], 1, totemItem[2], 1, totemItem[3], 1, totemItem[4], 1)

            Data_SQL = nil
            totemsDone = nil
        end

        coroutine.yield()
        --Copy quests
        local Data_SQL = CharDBQuery('DELETE FROM character_queststatus_rewarded WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempQuest'..cc_playerGUID..' LIKE character_queststatus_rewarded;')
        local Data_SQL = CharDBQuery('INSERT INTO tempQuest'..cc_playerGUID..' SELECT * FROM character_queststatus_rewarded WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('UPDATE tempQuest'..cc_playerGUID..' SET guid = '..cc_newCharacter..' WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_queststatus_rewarded SELECT * FROM tempQuest'..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempQuest'..cc_playerGUID..';')
        Data_SQL = nil

        coroutine.yield()
        --Copy reputation
        local Data_SQL = CharDBQuery('DELETE FROM character_reputation WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempReputation'..cc_playerGUID..' LIKE character_reputation;')
        local Data_SQL = CharDBQuery('INSERT INTO tempReputation'..cc_playerGUID..' SELECT * FROM character_reputation WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('UPDATE tempReputation'..cc_playerGUID..' SET guid = '..cc_newCharacter..' WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_reputation SELECT * FROM tempReputation'..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempReputation'..cc_playerGUID..';')
        Data_SQL = nil

        coroutine.yield()
        --Copy skills
        local Data_SQL = CharDBQuery('DELETE FROM character_skills WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempSkills'..cc_playerGUID..' LIKE character_skills;')
        local Data_SQL = CharDBQuery('INSERT INTO tempSkills'..cc_playerGUID..' SELECT * FROM character_skills WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('UPDATE tempSkills'..cc_playerGUID..' SET guid = '..cc_newCharacter..' WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_skills SELECT * FROM tempSkills'..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempSkills'..cc_playerGUID..';')
        Data_SQL = nil

        coroutine.yield()
        --Copy spells
        local Data_SQL = CharDBQuery('DELETE FROM character_spell WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempSpell'..cc_playerGUID..' LIKE character_spell;')
        local Data_SQL = CharDBQuery('INSERT INTO tempSpell'..cc_playerGUID..' SELECT * FROM character_spell WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('UPDATE tempSpell'..cc_playerGUID..' SET guid = '..cc_newCharacter..' WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_spell SELECT * FROM tempSpell'..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempSpell'..cc_playerGUID..';')
        Data_SQL = nil

        coroutine.yield()
        --Copy talents
        local Data_SQL = CharDBQuery('DELETE FROM character_talent WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempTalent'..cc_playerGUID..' LIKE character_talent;')
        local Data_SQL = CharDBQuery('INSERT INTO tempTalent'..cc_playerGUID..' SELECT * FROM character_talent WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('UPDATE tempTalent'..cc_playerGUID..' SET guid = '..cc_newCharacter..' WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_talent SELECT * FROM tempTalent'..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempTalent'..cc_playerGUID..';')
        Data_SQL = nil

        coroutine.yield()
        --Copy glyphs
        local Data_SQL = CharDBQuery('DELETE FROM character_glyphs WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempGlyphs'..cc_playerGUID..' LIKE character_glyphs;')
        local Data_SQL = CharDBQuery('INSERT INTO tempGlyphs'..cc_playerGUID..' SELECT * FROM character_glyphs WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('UPDATE tempGlyphs'..cc_playerGUID..' SET guid = '..cc_newCharacter..' WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_glyphs SELECT * FROM tempGlyphs'..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempGlyphs'..cc_playerGUID..';')
        Data_SQL = nil

        coroutine.yield()
        --Copy actions
        local Data_SQL = CharDBQuery('DELETE FROM character_action WHERE guid = '..cc_newCharacter..';')
        local Data_SQL = CharDBQuery('CREATE TEMPORARY TABLE tempAction'..cc_playerGUID..' LIKE character_action;')
        local Data_SQL = CharDBQuery('INSERT INTO tempAction'..cc_playerGUID..' SELECT * FROM character_action WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('UPDATE tempAction'..cc_playerGUID..' SET guid = '..cc_newCharacter..' WHERE guid = '..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('INSERT INTO character_action SELECT * FROM tempAction'..cc_playerGUID..';')
        local Data_SQL = CharDBQuery('DROP TABLE IF EXISTS tempAction'..cc_playerGUID..';')
        Data_SQL = nil

        coroutine.yield()
        --Copy items
        local homeStone
        local Data_SQL = CharDBQuery('DELETE FROM item_instance WHERE owner_guid = '..cc_newCharacter..' AND itemEntry != 6948;')
        local Data_SQL = CharDBQuery('SELECT guid FROM item_instance WHERE owner_guid = '..cc_newCharacter..' AND itemEntry = 6948 LIMIT 1;')
        homeStone = Data_SQL:GetUInt32(0)
        local Data_SQL = CharDBQuery('DELETE FROM character_inventory WHERE guid = '..cc_newCharacter..' AND item != '..homeStone..';')
        Data_SQL = nil

        local Data_SQL = CharDBQuery('SELECT item FROM character_inventory WHERE guid = '..cc_playerGUID..' AND bag = 0 AND slot <= 18 LIMIT 18;')
        local ItemCounter = 1
        local item_id = {}
        local item_amount = {}
        local i
        if Data_SQL ~= nil then
            repeat
                cc_oldItemGuids[ItemCounter] = Data_SQL:GetUInt32(0)
                local Data_SQL2 = CharDBQuery('SELECT itemEntry FROM item_instance WHERE guid = '..cc_oldItemGuids[ItemCounter]..' LIMIT 1;')
                item_id[ItemCounter] = Data_SQL2:GetUInt16(0)
                ItemCounter = ItemCounter + 1
            until not Data_SQL:NextRow()

            -- set amounts to 1 or nil
            for i = 1,18,1 do
                if item_id[i] ~= nil then
                    item_amount[i] = 1
                else
                    item_amount[i] = 1
                    item_id[i] = 38
                end
            end

            cc_newItemGuids[1], cc_newItemGuids[2], cc_newItemGuids[3], cc_newItemGuids[4], cc_newItemGuids[5], cc_newItemGuids[6], cc_newItemGuids[7], cc_newItemGuids[8], cc_newItemGuids[9], cc_newItemGuids[10], cc_newItemGuids[11], cc_newItemGuids[12] = SendMail("Copied items", "Hello "..targetName..Config.mailText, cc_newCharacter, 0, 61, 0, 0, 0, item_id[1], 1, item_id[2], 1, item_id[3], 1, item_id[4], 1, item_id[5], 1, item_id[6], 1, item_id[7], 1, item_id[8], 1, item_id[9], 1, item_id[10], 1, item_id[11], 1, item_id[12], 1)
            if cc_oldItemGuids[13] ~= nil then
                cc_newItemGuids[13], cc_newItemGuids[14], cc_newItemGuids[15], cc_newItemGuids[16], cc_newItemGuids[17], cc_newItemGuids[18] = SendMail("Copied items", "Hello "..targetName..Config.mailText, cc_newCharacter, 0, 61, 0, 0, 0, item_id[13], 1, item_id[14], 1, item_id[15], 1, item_id[16], 1, item_id[17], 1, item_id[18], 1)
            end
        end
        CreateLuaEvent(cc_fixItems, 3000) -- do it after 3 seconds
        cc_deleteTempTables(cc_playerGUID)
        cc_resetVariables()

        return false
        end)

    elseif commandArray[1] == "addcctickets" then
        -- make sure the player is properly ranked
        local accountId
        local oldTickets
        local Data_SQL
        if player ~= nil then
            if player:GetGMRank() < Config.minGMRankForTickets then
                cc_resetVariables()
                return false
            end
            if commandArray[2] == "help" then
                chatHandler:SendSysMessage("Syntax: .addcctickets $CharacterName $Amount")
                cc_resetVariables()
                return false
            end
            if commandArray[2] == nil or commandArray[3] == nil then
                chatHandler:SendSysMessage("Expected syntax: .addcctickets $CharacterName $Amount")
                cc_resetVariables()
                return false
            end

            if tonumber(commandArray[3]) > 1000 or tonumber(commandArray[3]) < 0 then
                chatHandler:SendSysMessage("Too large or negative amount chosen for .addcctickets: "..commandArray[3]..". Max allowed is +1000.")
                cc_resetVariables()
                return false
            end

            Data_SQL = CharDBQuery("SELECT `account` FROM `characters` WHERE `name` = '"..tostring(commandArray[2]).."' LIMIT 1;");
            if Data_SQL ~= nil then
                accountId = Data_SQL:GetUInt32(0)
            else
                chatHandler:SendSysMessage("Player name not found. Expected syntax: .addcctickets [CharacterName] [Amount]")
                cc_resetVariables()
                return false
            end
            Data_SQL = nil
            local Data_SQL
            Data_SQL = CharDBQuery('SELECT `tickets` FROM `'..Config.customDbName..'`.`carboncopy` WHERE `account_id` = '..accountId..' LIMIT 1;');
            if Data_SQL  ~= nil then
                oldTickets = Data_SQL:GetUInt32(0)
            else
                oldTickets = 0
            end
            Data_SQL = nil

            if oldTickets >= 1000 or oldTickets < 0 then
                chatHandler:SendSysMessage("Too large total amount tickets: "..commandArray[3]..". Max allowed total is +1000. Current value: "..oldTickets)
                cc_resetVariables()
                return false
            end

            -- the `allow_copy_from_id` column is hardcoded to 0 for now. Only copies to the same account are possible.
            local Data_SQL
            Data_SQL = CharDBQuery('DELETE FROM `'..Config.customDbName..'`.`carboncopy` WHERE `account_id` = '..accountId..';');
            Data_SQL = CharDBQuery('INSERT INTO `'..Config.customDbName..'`.`carboncopy` VALUES ('..accountId..', '..commandArray[3] + oldTickets..', 0);');
            Data_SQL = nil
            chatHandler:SendSysMessage("GM "..player:GetName().. " has sucessfully used the .addcctickets command, adding "..commandArray[3].." tickets to the account "..accountId.." which belongs to player "..commandArray[2]..".")
            cc_resetVariables()
            return false
        else
            --player is nil, must be the console. no need to check gm rank and print to console only. not chat
            if commandArray[2] == "help" then
                chatHandler:SendSysMessage("Syntax: .addcctickets $CharacterName $Amount")
                cc_resetVariables()
                return false
            end
            if commandArray[2] == nil or commandArray[3] == nil then
                chatHandler:SendSysMessage("Expected syntax: .addcctickets $CharacterName $Amount")
                cc_resetVariables()
                return false
            end

            if tonumber(commandArray[3]) > 1000 or tonumber(commandArray[3]) < 0 then
                chatHandler:SendSysMessage("Too large or negative amount chosen for .addcctickets: "..commandArray[3]..". Max allowed is +1000.")
                cc_resetVariables()
                return false
            end

            Data_SQL = CharDBQuery("SELECT `account` FROM `characters` WHERE `name` = '"..tostring(commandArray[2]).."' LIMIT 1;");
            if Data_SQL ~= nil then
                accountId = Data_SQL:GetUInt32(0)
            else
                chatHandler:SendSysMessage("Player name not found. Expected syntax: .addcctickets [CharacterName] [Amount]")
                cc_resetVariables()
                return false
            end
            Data_SQL = nil
            local Data_SQL
            Data_SQL = CharDBQuery('SELECT `tickets` FROM `'..Config.customDbName..'`.`carboncopy` WHERE `account_id` = '..accountId..' LIMIT 1;');
            if Data_SQL  ~= nil then
                oldTickets = Data_SQL:GetUInt32(0)
            else
                oldTickets = 0
            end
            Data_SQL = nil

            if oldTickets >= 1000 or oldTickets < 0 then
                chatHandler:SendSysMessage("Too large total amount tickets: "..commandArray[3]..". Max allowed total is +1000. Current value: "..oldTickets)
                cc_resetVariables()
                return false
            end

            -- the `allow_copy_from_id` column is hardcoded to 0 for now. Only copies to the same account are possible.
            local Data_SQL
            Data_SQL = CharDBQuery('DELETE FROM `'..Config.customDbName..'`.`carboncopy` WHERE `account_id` = '..accountId..';');
            Data_SQL = CharDBQuery('INSERT INTO `'..Config.customDbName..'`.`carboncopy` VALUES ('..accountId..', '..commandArray[3] + oldTickets..', 0);');
            Data_SQL = nil
            chatHandler:SendSysMessage("The console has sucessfully used the .addcctickets command, adding "..commandArray[3].." tickets to the account "..accountId.." which belongs to player "..commandArray[2]..".")
            cc_resetVariables()
            return false
        end
    -- command for SOAP interface to send to worldserver console, granting tickets. Syntax: CCACCOUNTTICKETS $accountName $amount
    elseif commandArray[1] == "CCACCOUNTTICKETS" and commandArray[2] ~= nil and commandArray[3] ~= nil and player == nil then
        local Data_SQL
        Data_SQL = AuthDBQuery('SELECT `id` FROM `account` WHERE `username` = "'..commandArray[2]..'";')
        if Data_SQL == nil then
            PrintError("CCACCOUNTTICKETS to "..commandArray[2].." has failed.")
            cc_resetVariables()
            return false
        else
            accountId = Data_SQL:GetUInt32(0)
        end

        if tonumber(commandArray[3]) > 1000 or tonumber(commandArray[3]) < 0 then
            chatHandler:SendSysMessage("Too large or negative amount chosen for .CCACCOUNTTICKETS: "..commandArray[3]..". Max allowed is +1000.")
            cc_resetVariables()
            return false
        end

        Data_SQL = CharDBQuery('SELECT `tickets` FROM `'..Config.customDbName..'`.`carboncopy` WHERE `account_id` = '..accountId..' LIMIT 1;');
        if Data_SQL  ~= nil then
            oldTickets = Data_SQL:GetUInt32(0)
        else
            oldTickets = 0
        end

        if oldTickets >= 1000 or oldTickets < 0 then
            chatHandler:SendSysMessage("Too large total amount of tickets: "..commandArray[3]..". Max allowed total is +1000. Current value: "..oldTickets)
            cc_resetVariables()
            return false
        end

        CharDBExecute('REPLACE INTO `'..Config.customDbName..'`.`carboncopy` VALUES ('..accountId..', '..commandArray[3] + oldTickets..', 0) ;')
        cc_resetVariables()
        return false
    elseif player ~= nil then
        chatHandler:SendSysMessage("'CCACCOUNTTICKETS $accountName $amount' only works against SOAP / the console.")
        return false
    else
        chatHandler:SendSysMessage("Expected Syntax: CCACCOUNTTICKETS $accountName $amount")
        return false
    end
end

function cc_fixItems()
    local n
    local Data_SQL
    for n,_ in ipairs(cc_oldItemGuids) do
        QueryString = 'UPDATE `item_instance` AS t1 '
        QueryString = QueryString..'INNER JOIN `item_instance` AS t2 ON t2.guid = '..cc_oldItemGuids[n]..' '
        QueryString = QueryString..'SET t1.owner_guid = '..cc_newCharacter..', t1.creatorGuid = t2.creatorGuid, '
        QueryString = QueryString..'t1.duration = t2.duration, t1.charges = t2.charges, t1.flags = 1, '
        QueryString = QueryString..'t1.enchantments = t2.enchantments, t1.randomPropertyId = t2.randomPropertyId '
        QueryString = QueryString..'WHERE t1.guid = '..cc_newItemGuids[n]..';'
        Data_SQL = CharDBQuery(QueryString);
    end

    GetPlayerByGUID(cc_playerGUID):SendBroadcastMessage("Character copy done. You can log out now.")
    PrintInfo("2) Item enchants/gems copied for new character with GUID "..cc_newCharacter);
    cc_newCharacter = 0
    cc_oldItemGuids = {}
    cc_newItemGuids = {}
    cc_scriptIsBusy = 0
    cc_playerGUID = nil
end

function cc_resetVariables()
    Data_SQL = nil
    Data_SQL2 = nil
    ItemCounter = nil
    targetName = nil
    QueryString = nil
    cc_playerPetId = nil
    cc_targetPetId = nil
    item_id = nil
    homeStone = nil
    cc_playerString = nil
    cc_cinematic = nil
    commandArray = nil
    availableTickets = nil
    newItemGuid = nil
end

function cc_deleteTempTables(cc_GUID)
    CharDBQuery('DROP TABLE IF EXISTS tempQuest'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempPet'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempPet_spell'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempReputation'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempSkills'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempSpell'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempTalent'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempGlyphs'..cc_GUID..';')
    CharDBQuery('DROP TABLE IF EXISTS tempAction'..cc_GUID..';')
end

function cc_splitString(inputstr, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..seperator.."]+)") do
        table.insert(t, str)
    end
    return t
end

function cc_has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function cc_resumeSubRoutine(eventId, delay, repeats)
    coroutine.resume(cc_subRoutine)
end

local PLAYER_EVENT_ON_COMMAND = 42
-- function to be called when the command hook fires
RegisterPlayerEvent(PLAYER_EVENT_ON_COMMAND, cc_CopyCharacter)
