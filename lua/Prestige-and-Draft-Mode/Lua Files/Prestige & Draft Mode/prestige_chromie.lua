dofile("lua_scripts/prestige_and_spell_choice_config.lua")
local NPC_ID = CONFIG.NPC_ID
local MAX_LEVEL = CONFIG.MAX_LEVEL
local DRAFT_MODE_REROLLS = CONFIG.DRAFT_MODE_REROLLS 
local DRAFT_MODE_SPELLS = CONFIG.DRAFT_MODE_SPELLS
local DRAFT_BANS_START = CONFIG.DRAFT_BANS_START
local DRAFT_REROLLS_GAINED_PER_PRESTIGE_LEVEL = CONFIG.DRAFT_REROLLS_GAINED_PER_PRESTIGE_LEVEL
local prestigeDescription = CONFIG.prestigeDescription
local prestigeBlockedMessage = CONFIG.prestigeBlockedMessage
local prestigeLossList = CONFIG.prestigeLossList
local CHROMIE_SAYINGS = {
    "Didn't expect to see you so soon, $n.",
    "Ah, $n... back already? Time is strange like that.",
    "I had a feeling you'd be looping back around.",
    "You again, $n? That was quicker than last time.",
    "Back again, $n? I must’ve blinked.",
    "You're becoming quite the regular, $n."
}

local LOGOUT_TIMER = 10 -- time in seconds to wait after sending back to start before logging out to finish process.
local LOGOUT_AFTER_PRESTIGE_TIMER = LOGOUT_TIMER * 1000
local EQUIP_SLOT_START = 0
local EQUIP_SLOT_END = 18
local MAIL_SUBJECT = "Your Returned Gear [Prestige]"
local MAIL_BODY = "Your equipped gear has been returned to you after prestiging."
local RED = "|cffff0000"
local YELLOW = "|cffffff00"
local WHITE = "|cffffffff"
local startingGear = CONFIG.startingGear

local function OnDraftAddonWhisper(event, player, msg, msgType, lang, receiver)
    if msg == "DRAFT_READY" and receiver == player:GetName() then
        draftAddonReady[player:GetGUIDLow()] = true
        print("[DraftMode] Addon detected from " .. player:GetName())
        return false
    end
end

local function GetStoredClass(player)
    local guid = player:GetGUIDLow()
    local result = CharDBQuery("SELECT stored_class FROM prestige_stats WHERE player_id = " .. guid)
    if result then
        local storedClass = result:GetUInt8(0)
        return storedClass
    else
        return nil -- not found
    end
end

local function GiveStartingGear(player)
    local race = player:GetRace()
    local class = GetStoredClass(player)

    local raceNames = {
        [1] = "HUMAN",
        [2] = "ORC",
        [3] = "DWARF",
        [4] = "NIGHTELF",
        [5] = "UNDEAD",
        [6] = "TAUREN",
        [7] = "GNOME",
        [8] = "TROLL",
        [10] = "BLOODELF",
        [11] = "DRAENEI",
    }

    local classNames = {
        [1]  = "WARRIOR",
        [2]  = "PALADIN",
        [3]  = "HUNTER",
        [4]  = "ROGUE",
        [5]  = "PRIEST",
        [6]  = "DEATHKNIGHT",
        [7]  = "SHAMAN",
        [8]  = "MAGE",
        [9]  = "WARLOCK",
        [11] = "DRUID",
    }

    local key
    if class == 6 then -- Death Knight
        key = "DEATHKNIGHT"
    else
        key = raceNames[race] .. "_" .. classNames[class]
    end

    local items = startingGear[key]
    if not items then
        player:SendBroadcastMessage("Starting gear not found for your race and class.")
        return
    end

    for slotID, itemID in pairs(items) do
        local count = 1
        if itemID == 2512 or itemID == 2516 then
            count = 200
        end

        local item = player:AddItem(itemID, count)
        if item and count == 1 then
            player:EquipItem(itemID, slotID)
        end
    end
    player:SendBroadcastMessage("Your starting gear has been equipped.")
end






local function GetLossListText()
    return "The following will be removed when you prestige:\n\n" .. table.concat(prestigeLossList, "\n")
end

local EQUIPPED_SLOTS = {
    0,  -- HEAD
    1,  -- NECK
    2,  -- SHOULDERS
    3,  -- BODY (shirt)
    4,  -- CHEST
    5,  -- WAIST
    6,  -- LEGS
    7,  -- FEET
    8,  -- WRISTS
    9,  -- HANDS
    10, -- FINGER1
    11, -- FINGER2
    12, -- TRINKET1
    13, -- TRINKET2
    14, -- BACK
    15, -- MAIN HAND
    16, -- OFF HAND
    17, -- RANGED/RELIC
    18, -- TABARD
}

local function RemoveAndMailEquippedItems(player)
    local itemsSent = false
    local receiverGuid = player:GetGUIDLow()
    local senderGuid = player:GetGUIDLow()

    for _, slot in ipairs(EQUIPPED_SLOTS) do
        local item = player:GetEquippedItemBySlot(slot)
        if item then
            local entry = item:GetEntry()
            local count = item:GetCount()
            if type(SendMail) == "function" then
                SendMail(MAIL_SUBJECT, MAIL_BODY, senderGuid, receiverGuid, 61, 0, 0, 0, entry, count)
            else
                --print("[Prestige] ERROR: Global SendMail function not found!")
            end
            player:RemoveItem(entry, count)
            itemsSent = true
        end
    end

    if itemsSent then
        player:SendBroadcastMessage("Your equipped items have been mailed to you.")
    end
end


-- Menus
local function ShowMainMenu(player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_QuestionMark:20|t |cffffff00What is Prestige?", 1, 1)
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\Achievement_BG_winAB:20|t |cff3399ffI would like to Prestige!", 1, 2)
    local guid = player:GetGUIDLow()
    local result = CharDBQuery("SELECT draft_state FROM prestige_stats WHERE player_id = " .. guid)
    if result and result:GetUInt32(0) == 1 then
        player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_Gear_01:20|t |cff66ff66Show My Draft Stats", 1, 300)
        player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_Head_Human_01:20|t " .. RED .. "I want to QUIT DRAFT", 1, 200)
    end

    -- Exit
    player:GossipMenuAddItem(0, "Goodbye", 1, 999)

    player:GossipSendMenu(1, creature)
end

local function ShowPrestigeInfo(player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, prestigeDescription, 1, 998)
    player:GossipMenuAddItem(0, "Back", 1, 0)
    player:GossipSendMenu(1, creature)
end

local function ShowPrestigeOptions(player, creature)
    player:GossipClearMenu()
    local guid = player:GetGUIDLow()
    if player:GetLevel() < MAX_LEVEL then
        player:GossipMenuAddItem(0, prestigeBlockedMessage, 1, 998)
    else
        player:GossipMenuAddItem(4, GetLossListText(), 1, 998)
        player:GossipMenuAddItem(9, RED .. "Prestige", 1, 3)
        player:GossipMenuAddItem(9, RED .. "Prestige into Draft Mode", 1, 4)
        --player:GossipMenuAddItem(9, RED .. "Prestige into Taskmaster Mode", 1, 6)
    end
    player:GossipMenuAddItem(0, "Back", 1, 0)
    player:GossipSendMenu(1, creature)
end
local function ShowTaskmasterConfirmation(player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_Bag_10:20|t Prestige requires 10 free inventory slots", 1, 998)
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\Ability_Hunter_BeastCall:20|t Prestige requires no active pet. Dismiss your pet if you have one", 1, 998)
    player:GossipMenuAddItem(0, "", 1, 998)
    --player:GossipMenuAddItem(9, RED .. "I am sure I want to Prestige into Taskmaster Mode!", 1, 103)
    player:GossipMenuAddItem(0, "Back", 1, 2)
    player:GossipSendMenu(1, creature)
end
local function ShowConfirmation(player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_Bag_10:20|t Prestige requires 10 free inventory slots", 1, 998)
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\Ability_Hunter_BeastCall:20|t Prestige requires no active pet. Dismiss your pet if you have one", 1, 998)

    player:GossipMenuAddItem(0, "", 1, 998) -- Spacer
    player:GossipMenuAddItem(9, RED .. "I am sure I want to Prestige!", 1, 100)
    player:GossipMenuAddItem(0, "Back", 1, 2)
    player:GossipSendMenu(1, creature)
end
local function ShowDraftConfirmation(player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_Bag_10:20|t Prestige requires 10 free inventory slots", 1, 998)
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\Ability_Hunter_BeastCall:20|t Prestige requires no active pet. Dismiss your pet if you have one", 1, 998)
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Scroll_11:20|t Prestige Draft requires the Patch-P and Prestige&Draft Addon", 1, 998)
    player:GossipMenuAddItem(0, "", 1, 998) -- Spacer
    player:GossipMenuAddItem(9, RED .. "I am sure I want to Prestige into Draft Mode!", 1, 101)
    player:GossipMenuAddItem(0, "Back", 1, 2)
    player:GossipSendMenu(1, creature)
end
local function ShowEndDraftConfirmation(player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_QuestionMark:20|t This will reset your character as if you prestiged, but without increasing your prestige level.", 1, 998)
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\Ability_Hunter_BeastCall:20|t This Process requires no active pet. Dismiss your pet if you have one", 1, 998)
    player:GossipMenuAddItem(0, "", 1, 998) -- Spacer
    player:GossipMenuAddItem(9, RED .. "I am sure I want to end Drafting.", 1, 201)
    player:GossipMenuAddItem(0, "Back", 1, 0)
    player:GossipSendMenu(1, creature)
end
-- Gossip handler
local function OnGossipHello(event, player, creature)
    ShowMainMenu(player, creature)
end

local function DeleteAllPlayerPets(playerGUID)
    local petResults = CharDBQuery("SELECT id FROM character_pet WHERE owner = " .. playerGUID)
    if not petResults then
        return
    end

    repeat
        local petGuid = petResults:GetUInt32(0)
        CharDBExecute("DELETE FROM pet_spell WHERE guid = " .. petGuid)
        CharDBExecute("DELETE FROM character_pet WHERE id = " .. petGuid)
        CharDBExecute("DELETE FROM pet_aura WHERE guid = " .. petGuid)
        CharDBExecute("DELETE FROM pet_spell_cooldown WHERE guid = " .. petGuid)
    until not petResults:NextRow()
end


local function DoPrestige(player, draftMode, isTaskmaster)
    local guid = player:GetGUIDLow()
    local requiredSlots = 10
    local freeSlots = 0
    local foundEnough = false
    --print("[Prestige] Starting inventory check for player: " .. player:GetName())

            for bag = 0, 4 do
                local bagSize = 16
                local skipBag = false
                local container = 255  -- Use 255 for virtual inventory (backpack, equipment, etc.)

                if bag == 0 then
                    -- Backpack occupies slot 23–38 in container 255
                    bagSize = 16
                    --print("[Prestige] Checking backpack (bag 0) with size " .. bagSize)
                else
                    local bagItem = player:GetItemByPos(255, 18 + bag)
                    if not bagItem then
                        --print("[Prestige] Skipping bag " .. bag .. ": no item equipped")
                        skipBag = true
                    else
                        local entry = bagItem:GetEntry()
                        local result = WorldDBQuery("SELECT class, subclass FROM item_template WHERE entry = " .. entry)
                        if not result then
                            --print("[Prestige] Skipping bag " .. bag .. ": item entry not found in DB (entry: " .. entry .. ")")
                            skipBag = true
                        else
                            local class = result:GetUInt8(0)
                            local subclass = result:GetUInt8(1)
                            --print("[Debug] Bag " .. bag .. " class = " .. class .. ", subclass = " .. subclass)

                            if (class == 1 and (subclass == 2 or subclass == 3)) or class == 11 then
                                --print("[Prestige] Skipping bag " .. bag .. ": quiver or ammo pouch")
                                skipBag = true
                            else
                                bagSize = bagItem:GetBagSize()
                                container = 18 + bag  -- Use slot index, NOT GUID
                                --print("[Prestige] Checking bag " .. bag .. " with size " .. bagSize)
                            end
                        end
                    end
                end

                if not skipBag then
                    for slot = 0, bagSize - 1 do
                        local item

                        if bag == 0 then
                            -- Backpack check: actual slots are 23–38
                            item = player:GetItemByPos(255, 23 + slot)
                        else
                            -- Normal bag check
                            item = player:GetItemByPos(container, slot)
                        end

                        --print(item)

                        if not item then
                            freeSlots = freeSlots + 1
                            --print("[Prestige] Bag " .. bag .. ", slot " .. slot .. ": empty (freeSlots = " .. freeSlots .. ")")
                            if freeSlots >= requiredSlots then
                                foundEnough = true
                                --print("[Prestige] Found enough free slots (" .. freeSlots .. ") — exiting early")
                                break
                            end
                        end
                    end
                end

                if foundEnough then break end
            end

            -- Final evaluation
            if freeSlots >= requiredSlots then
                --print("[Prestige] Free slot check passed: " .. freeSlots .. "/" .. requiredSlots)
            else
                --print("[Prestige] Not enough free slots: " .. freeSlots .. "/" .. requiredSlots)
                player:SendBroadcastMessage("You need at least " .. requiredSlots .. " free bag slots to Prestige.")
                return
            end
        if freeSlots < requiredSlots then
            player:SendBroadcastMessage("You need at least " .. requiredSlots .. " free bag slots to Prestige.")
            return
        end


    -- Draft mode only:
    if draftMode then
        player:SendBroadcastMessage("Draft Mode: Enabled for next run.")
        --print("[DraftMode] Draft mode enabled for player: " .. player:GetName() .. " (" .. guid .. ")")

        -- Recalculate current prestige level after increment (safe fallback)
        local prestigeLevel = 1
        local q = CharDBQuery("SELECT prestige_level FROM prestige_stats WHERE player_id = " .. guid)
        if q then
            prestigeLevel = q:GetUInt32(0)
        end

        local bonusRerolls = DRAFT_MODE_REROLLS + (DRAFT_REROLLS_GAINED_PER_PRESTIGE_LEVEL * (prestigeLevel))

        -- Determine original class safely
        local storedClass = player:GetClass()
        local storedQuery = CharDBQuery("SELECT stored_class FROM prestige_stats WHERE player_id = " .. guid)
        if storedQuery and storedQuery:GetUInt8(0) > 0 then
            storedClass = storedQuery:GetUInt8(0)  -- Keep existing non-zero value
        end

        local updateStatsQuery = string.format([[
            UPDATE prestige_stats
            SET draft_state = 1,
                successful_drafts = 0,
                total_expected_drafts = %d,
                rerolls = %d,
                stored_class = %d,
                bans = %d,
                offered_spell_1 = 0,
                offered_spell_2 = 0,
                offered_spell_3 = 0
            WHERE player_id = %d
        ]], DRAFT_MODE_SPELLS, bonusRerolls, storedClass, DRAFT_BANS_START, guid)

        CharDBExecute(updateStatsQuery)
        --print("[DraftMode] Updated prestige_stats for " .. guid .. " with " .. bonusRerolls .. " rerolls")
        player:SendBroadcastMessage("Draft rerolls granted: " .. bonusRerolls)
    end
    RemoveAndMailEquippedItems(player)
    player:SetLevel(player:GetClass() == 6 and 55 or 1)
    GiveStartingGear(player)

    local name = player:GetName()
    local newPrestige = 1
    local q = CharDBQuery("SELECT prestige_level FROM prestige_stats WHERE player_id = " .. guid)
    if q then
        local currentPrestige = q:GetUInt32(0)
        newPrestige = currentPrestige + 1
        CharDBExecute("UPDATE prestige_stats SET prestige_level = " .. newPrestige .. " WHERE player_id = " .. guid)
    else
        CharDBExecute("INSERT INTO prestige_stats (player_id, prestige_level) VALUES (" .. guid .. ", 1)")
    end

    SendWorldMessage("|cffff8800[Prestige]|r Player |cffffff00" .. name .. "|r has prestiged! New Prestige Level: |cff00ff00" .. newPrestige .. "|r")
    player:SendBroadcastMessage("|cffff0000You have prestiged!|r Your level has been reset to 1.")
    player:SendBroadcastMessage("You will be logged out in " .. LOGOUT_TIMER ..  " seconds to complete the prestige process.")
    player:GossipComplete()

    -- Actionbar, spell, quest wipes
    CharDBExecute("DELETE FROM character_action WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_spell WHERE guid = " .. guid)
    local result = CharDBQuery("SELECT spell_id FROM drafted_spells WHERE player_guid = " .. guid)
    -- if result then
    --     repeat
    --         local spellId = result:GetUInt32(0)
    --         player:RemoveSpell(spellId)
    --     until not result:NextRow()
    -- end
    CharDBExecute("DELETE FROM drafted_spells WHERE player_guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM draft_bans WHERE player_id = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_rewarded WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_daily WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_weekly WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_seasonal WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_monthly WHERE guid = " .. guid)
    DeleteAllPlayerPets(guid)

    -- Teleport and logout
    CreateLuaEvent(function()
        local plr = GetPlayerByGUID(guid)
        if not plr then return end

        local raceStartLocations = {
            [1]  = {map = 0,   x = -8949.95,  y = -132.493, z = 83.5312,   o = 3.142},
            [2]  = {map = 1,   x = -618.518,  y = -4251.67, z = 38.718,    o = 6.2},
            [3]  = {map = 0,   x = -6240.32,  y = 331.033,  z = 382.757,   o = 5.2},
            [4]  = {map = 1,   x = 10311.3,   y = 832.463,  z = 1326.41,   o = 5.7},
            [5]  = {map = 0,   x = 1676.35,   y = 1678.68,  z = 121.67,    o = 1.6},
            [6]  = {map = 1,   x = -2917.58,  y = -257.98,  z = 52.9968,   o = 0.0},
            [7]  = {map = 0,   x = -6240.95,  y = 331.493, z = 382.5312,   o = 5.2},
            [8]  = {map = 1,   x = -618.518,  y = -4251.67, z = 38.718,    o = 6.2},
            [10] = {map = 530, x = 10349.6,   y = -6357.29, z = 33.4026,   o = 5.3},
            [11] = {map = 530, x = -3961.64,  y = -13931.2, z = 100.615,   o = 2.08},
        }

        local dkStart = {map = 609, x = 2352.47, y = -5665.831, z = 426.02786, o = 1.44}
        local loc
        if isTaskmaster then
            CharDBExecute("UPDATE prestige_stats SET taskmaster_state = 1 WHERE player_id = " .. guid)
        end
        if isTaskmaster then
            loc = {map = 0, x = -4818.3784, y = -973.5159, z = 464.709, o = 3.8585422} -- your custom Taskmaster hub
        else
            loc = (plr:GetClass() == 6) and dkStart or raceStartLocations[plr:GetRace()]
        end

        if loc then
            plr:Teleport(loc.map, loc.x, loc.y, loc.z, loc.o)
        else
            plr:SendBroadcastMessage("Unknown race/class start location.")
        end
        if isTaskmaster then
            plr:SetBindPoint(loc.x, loc.y, loc.z, loc.map, 0)  
            plr:SendBroadcastMessage("Your hearthstone has been bound to the Taskmaster Hub.")
        end
        -- Always schedule delayed logout if not drafting
        if not draftMode then
            CreateLuaEvent(function()
                local p = GetPlayerByGUID(guid)
                if p then p:LogoutPlayer(true) end
            end, LOGOUT_AFTER_PRESTIGE_TIMER, 1)
        end
        -- If draftMode, immediately kick and schedule class change
        if draftMode then
            local guidLow = plr:GetGUIDLow()  -- Cache the GUID before logout
            plr:AddItem(46978,1) -- All in one totem
            plr:KickPlayer()
            CreateLuaEvent(function()
                CharDBExecute("UPDATE characters SET class = 8 WHERE guid = " .. guidLow)
                --print("[DraftMode] Updated class to Mage (8) for " .. guidLow)
            end, 1000, 1)
        end
    end, 500, 1)
end
local function DoDraftEnd(player)
    local guid = player:GetGUIDLow()

    -- Fetch stored class
    local q = CharDBQuery("SELECT stored_class FROM prestige_stats WHERE player_id = " .. guid)
    if not q then
        player:SendBroadcastMessage("Could not end Draft Mode: missing stored_class.")
        return
    end

    local originalClass = q:GetUInt8(0)
    if not originalClass or originalClass == 0 then
        player:SendBroadcastMessage("Stored class is invalid.")
        return
    end

    -- Reset draft state
    if player:GetLevel() >= CONFIG.MAX_LEVEL then
        CharDBExecute("UPDATE prestige_stats SET draft_state = 0, prestige_level = prestige_level + 1 WHERE player_id = " .. guid)
    else
        CharDBExecute("UPDATE prestige_stats SET draft_state = 0 WHERE player_id = " .. guid)
    end

    RemoveAndMailEquippedItems(player)
    player:SetLevel(originalClass == 6 and 55 or 1)
    GiveStartingGear(player)

    player:SendBroadcastMessage("|cffff0000You have exited Draft Mode.|r Your class will be restored.")
    player:SendBroadcastMessage("You will be kicked to finalize your class change.")
    player:GossipComplete()
    local draftedSpellsQuery = CharDBQuery("SELECT spell_id FROM drafted_spells WHERE player_guid = " .. guid)
    if draftedSpellsQuery then
        repeat
            local spellId = draftedSpellsQuery:GetUInt32(0)
            if player:HasSpell(spellId) then
                player:RemoveSpell(spellId)
            end
        until not draftedSpellsQuery:NextRow()
    end
    -- Clean up data
    CharDBExecute("DELETE FROM character_action WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_spell WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM draft_bans WHERE player_id = " .. guid)
    CharDBExecute("DELETE FROM drafted_spells WHERE player_guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_rewarded WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_daily WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_weekly WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_seasonal WHERE guid = " .. guid)
    CharDBExecute("DELETE FROM character_queststatus_monthly WHERE guid = " .. guid)
    DeleteAllPlayerPets(guid)

    -- Teleport, then logout and restore original class
    CreateLuaEvent(function()
        local plr = GetPlayerByGUID(guid)
        if not plr then return end

        local raceStartLocations = {
            [1]  = {map = 0,   x = -8949.95,  y = -132.493, z = 83.5312,   o = 3.142},
            [2]  = {map = 1,   x = -618.518,  y = -4251.67, z = 38.718,    o = 6.2},
            [3]  = {map = 0,   x = -6240.32,  y = 331.033,  z = 382.757,   o = 5.2},
            [4]  = {map = 1,   x = 10311.3,   y = 832.463,  z = 1326.41,   o = 5.7},
            [5]  = {map = 0,   x = 1676.35,   y = 1678.68,  z = 121.67,    o = 1.6},
            [6]  = {map = 1,   x = -2917.58,  y = -257.98,  z = 52.9968,   o = 0.0},
            [7]  = {map = 0,   x = -6240.95,  y = 331.493,  z = 382.5312,  o = 5.2},
            [8]  = {map = 1,   x = -618.518,  y = -4251.67, z = 38.718,    o = 6.2},
            [10] = {map = 530, x = 10349.6,   y = -6357.29, z = 33.4026,   o = 5.3},
            [11] = {map = 530, x = -3961.64,  y = -13931.2, z = 100.615,   o = 2.08},
        }

        local dkStart = {map = 609, x = 2352.47, y = -5665.831, z = 426.02786, o = 1.44}
        local loc = (plr:GetClass() == 6) and dkStart or raceStartLocations[plr:GetRace()]
        if loc then
            plr:Teleport(loc.map, loc.x, loc.y, loc.z, loc.o)
        end

        -- Schedule logout + class restore
        local guidLow = plr:GetGUIDLow()
        plr:KickPlayer()

        CreateLuaEvent(function()
            CharDBExecute("UPDATE characters SET class = " .. originalClass .. " WHERE guid = " .. guidLow)
            --print("[DraftMode] Restored class to " .. originalClass .. " for player " .. guidLow)
        end, 1000, 1)
    end, 500, 1)
end

local function HasActivePetBlockPrestige(player)
    local petGUID = tostring(player:GetPetGUID())
    if not petGUID or petGUID == "0" or petGUID == nil then
        return false
    end
    player:SendBroadcastMessage("You must dismiss your pet before prestiging!")
    player:SendBroadcastMessage("Also make sure you've got 10 free inven. slots!")
    return true
end


local function OnGossipSelect(event, player, creature, sender, intid)
    local guid = player:GetGUIDLow()

    if intid == 0 then
        ShowMainMenu(player, creature)
    elseif intid == 1 then
        ShowPrestigeInfo(player, creature)
    elseif intid == 2 then
        ShowPrestigeOptions(player, creature)
    elseif intid == 3 then
        ShowConfirmation(player, creature)
    elseif intid == 998 then
        player:GossipComplete()
    elseif intid == 999 then
        player:GossipComplete()
    elseif intid == 4 then
        ShowDraftConfirmation(player, creature)
    elseif intid == 100 then
        if HasActivePetBlockPrestige(player) then return end
    local q = CharDBQuery("SELECT draft_state, stored_class FROM prestige_stats WHERE player_id = " .. guid)
        if q then
            local draftState = q:GetUInt32(0)
            if draftState == 1 then
                DoDraftEnd(player)
                return
            end
        end
      DoPrestige(player, false, false)
    elseif intid == 101 then
        if HasActivePetBlockPrestige(player) then return end
        DoPrestige(player, true, false)
    elseif intid == 200 then
        ShowEndDraftConfirmation(player, creature) 
    elseif intid == 201 then
        if HasActivePetBlockPrestige(player) then return end
        DoDraftEnd(player) 
    elseif intid == 6 then
        ShowTaskmasterConfirmation(player, creature)
    elseif intid == 103 then
        if HasActivePetBlockPrestige(player) then return end
        DoPrestige(player, false, true)  -- false = not draft, true = taskmaster
    elseif intid == 300 then
        player:GossipClearMenu()
        player:GossipMenuAddItem(5, "|TInterface\\Icons\\Spell_Holy_SurgeOfLight:20|t Show My Drafted Spells", 1, 301)
        player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Scroll_03:20|t Show My Banned Spells", 1, 302)

        -- Show reroll count
        local statsQuery = CharDBQuery("SELECT rerolls FROM prestige_stats WHERE player_id = " .. guid)
        local rerolls = statsQuery and statsQuery:GetUInt32(0) or 0
        player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_CoinBag_01:16|t |cff000000Rerolls Remaining:|r " .. rerolls, 1, 998)

        -- Show ban count
        local bansQuery = CharDBQuery("SELECT bans FROM prestige_stats WHERE player_id = " .. guid)
        local banCount = bansQuery and bansQuery:GetUInt32(0) or 0
        player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Misc_Gear_01:16|t |cff000000Bans Remaining:|r " .. banCount, 1, 998)

        player:GossipMenuAddItem(0, "Back", 1, 0)
        player:GossipSendMenu(1, creature)

    elseif intid == 301 then
        local q = CharDBQuery("SELECT spell_id FROM drafted_spells WHERE player_guid = " .. guid)
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "|cff000000Your Drafted Spells:|r", 1, 998)
        local seenNames = {}

        if q then
            repeat
                local spellId = q:GetUInt32(0)
                local nameResult = WorldDBQuery("SELECT Name_Lang_enUS FROM dbc_spells WHERE ID = " .. spellId)
                local name = nameResult and nameResult:GetString(0) or ("Unknown Spell [" .. spellId .. "]")

                if not seenNames[name] then
                    seenNames[name] = true
                    player:GossipMenuAddItem(5, name, 1, 998)
                end
            until not q:NextRow()
        else
            player:GossipMenuAddItem(0, "No drafted spells found.", 1, 998)
        end

        player:GossipMenuAddItem(0, "Back", 1, 300)
        player:GossipSendMenu(1, creature)

    elseif intid == 302 then

        local q = CharDBQuery("SELECT spell_id FROM draft_bans WHERE player_id = " .. guid)
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "|cff3366ccClicking on a spell here will remove it from your ban list|r", 1, 998)
        player:GossipMenuAddItem(0, "|cff000000Your Banned Spells:|r", 1, 998)

        if q then
            repeat
                local spellId = q:GetUInt32(0)
                local nameResult = WorldDBQuery("SELECT Name_Lang_enUS FROM dbc_spells WHERE ID = " .. spellId)
                local name = nameResult and nameResult:GetString(0) or ("Unknown Spell [" .. spellId .. "]")

                player:GossipMenuAddItem(5, name .. " (" .. spellId .. ")", 1, 100000 + spellId)
            until not q:NextRow()
        else
            player:GossipMenuAddItem(0, "No banned spells found.", 1, 998)
        end
        player:GossipMenuAddItem(0, "Back", 1, 300)
        player:GossipSendMenu(1, creature) 
  elseif intid >= 100000 then
    local spellId = intid - 100000
    CharDBExecute("DELETE FROM draft_bans WHERE player_id = " .. guid .. " AND spell_id = " .. spellId)
    player:SendBroadcastMessage("Removed banned spell ID: " .. spellId)

    -- Go back to the Draft Stats submenu (intid 300)
    player:GossipClearMenu()
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\Spell_Holy_SurgeOfLight:20|t Show My Drafted Spells", 1, 301)
    player:GossipMenuAddItem(5, "|TInterface\\Icons\\INV_Scroll_03:20|t Show My Banned Spells", 1, 302)
    player:GossipMenuAddItem(0, "Back", 1, 0)
    player:GossipSendMenu(1, creature)


    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)

-- Setup for seen players table
local seen_players = {}

-- Reset seen_players every 2 minutes
CreateLuaEvent(function()
    seen_players = {}
end, 120000, 0)

-- Distance in yards
local DETECTION_RADIUS = 10

-- Periodic check for nearby players with taskmaster_state = 1
local function CheckNearbyPlayers(_, _, _, creature)
    if not creature or not creature:IsInWorld() then return end
    local players = creature:GetPlayersInRange(DETECTION_RADIUS)
    if not players or #players == 0 then return end

    for _, player in ipairs(players) do
        if player:IsPlayer() then
            local guid = player:GetGUIDLow()

            if not seen_players[guid] then
                local query = CharDBQuery("SELECT taskmaster_state FROM prestige_stats WHERE player_id = " .. guid)
                if query and query:GetUInt8(0) == 1 then
                    local line = CHROMIE_SAYINGS[math.random(1, #CHROMIE_SAYINGS)]
                    line = string.gsub(line, "$n", player:GetName())
                    creature:SendUnitSay(line, 0)
                    seen_players[guid] = true
                end
            end
        end
    end
end

-- When Chromie spawns, start scanning
local function OnChromieSpawn(event, creature)
    creature:RegisterEvent(CheckNearbyPlayers, 3000, 0) -- every 3 seconds
end

-- Hook to Chromie's NPC ID
RegisterCreatureEvent(NPC_ID, 5, OnChromieSpawn)  -- ON_SPAWN
