local ItemBox = {
    ["boxId"] = 32551,
    ["dataCache"] = {},
    ["classList"] = {
        [1] = { -- Warrior
            {9, 18,41,28,61,36,42,27,62,72, 46,66,78,81, 87},            -- Arms
            {9, 18,41,28,61,36,42,27,62,72, 46,66,78,81, 87},            -- Fury
            {10, 17, 64,60,55,76,43,44, 49,78,81,89,90,91, 102}          -- Protection
        },
        [2] = { -- Paladin
            {5, 14,15, 32,54,22,38,93,33, 47,67,75,78, 97},              -- Holy
            {10, 17, 64,76,44, 49,78,81,89,90,91, 98},                   -- Protection
            {9, 18, 41,42,27, 46,78,81, 68}                              -- Retribution
        },
        [3] = { -- Hunter
            {2,12,64,28,61,36,25,26,62,46,66,78,82},                     -- Beast Mastery
            {2,12,64,28,61,36,25,26,62,46,66,78,82},                     -- Marksmanship
            {2,12,64,28,61,36,25,26,62,46,66,78,82}                      -- Survival
        },
        [4] = { -- Rogue
            {1,12, 61,28,20,72, 46,66,87,81,85},                         -- Assassination
            {1,12, 77,61,28,24,72, 46,66,87,81,85},                      -- Combat
            {1,12, 61,28,20,72, 46,66,87,81,85}                          -- Subtlety
        },
        [5] = { -- Priest
            {6, 14,16, 29,54,56,39,80,40,79,92,93, 47,48,67,78, 84},     -- Discipline 
            {6, 14,16, 29,54,56,39,80,40,79,92,93, 47,48,67,78, 84},     -- Holy 
            {3, 13,14, 29,30,54,56,34,80,35,79, 47,65,78, 99}            -- Shadow 
        },
        [6] = { -- Death Knight
            {10, 17, 41,42,24,27, 49,78,81,90,91, 94},                   -- Blood
            {10, 17, 77,23,24, 49,78,81,90,91, 94},                      -- Frost - Tank
            {9, 18, 77,23,24, 46,66,78,81, 69},                          -- Frost - DPS
            {9, 18, 41,42,27, 46,66,78,81, 94},                          -- Unholy
        },
        [7] = { -- Shaman
            {4, 13,14, 29,30,74,54,56,34,80,33, 47,65,78, 100},          -- Elemental
            {2, 12, 77,21,23, 46,78, 70},                                -- Enhancement
            {8, 14,15, 29,59,74,32,54,80,73,33,93, 47,67,75,78, 101}     -- Restoration
        },
        [8] = { -- Mage
            {3,13,14,29,30,34,80,35,79,47,65,78,83},                     -- Arcane
            {3,13,14,29,30,34,80,35,79,47,65,78,83},                     -- Fire
            {3,13,14,29,30,34,80,35,79,47,65,78,83}                      -- Frost
        },
        [9] = { -- Warlock
            {3,13,14,29,30,34,80,22,57,35,79,47,65,78,86},               -- Affliction
            {3,13,14,29,30,34,80,22,57,35,79,47,65,78,86},               -- Demonology
            {3,13,14,29,30,34,80,22,57,35,79,47,65,78,86}                -- Destruction
        },
        [11] = { -- Druid
            {11, 13,14, 29,30,54,56,34,80, 47,65,78, 95},                -- Balance
            {1, 17, 25,26,45, 49,78, 71},                                -- Feral - Tank
            {1, 12, 25,26,45, 46,66,78, 71},                             -- Feral - DPS
            {7, 14,16, 29,58,54,92,93,39,80, 47,48,67,78, 96}            -- Restoration
        }
    },
    ["raidAchievements"] = {
        576,         -- Naxx 10
        577,         -- Naxx 25 
        2894,        -- Ulduar 10 
        2895,        -- Ulduar 25 
        3917,        -- TotC 10  
        3916,        -- TotC 25
        3918,        -- TotGC 10 
        3812,        -- TotGC 25 
        4532,        -- Lich King 10 
        4608,        -- Lich King 25
        4636,        -- Lich King 10 heroic
        4637,        -- Lich King 25 heroic
    },
}

function ItemBox.OnUse(event, player, item, target)
    local tier = 1 -- Default to Naxx 10 if player has no achievements, noob

    -- Determine the players gear tier
    for i, v in ipairs(ItemBox["raidAchievements"]) do
        if(player:HasAchieved(v)) then 
            tier = i+2
        end
    end
    
    -- Small chance to upgrade gear tier to a higher level
    local upgradeChance = math.random(1, 1000)
    
    if(upgradeChance <= 5) then -- .5% chance for tier +2
        tier = tier+2
    elseif(upgradeChance <= 50) then -- 5% chance for tier +1
        tier = tier+1
    end
    
    -- Get the item list for the selected tier 
    local itemlist = ItemBox.GetItemList(player, tier) 
    if(#itemlist > 0) then
        local rand = math.random(1, #itemlist)
        local itemEntry = itemlist[rand]
        
        print("ITEMBOX DEBUG:")
        print("Player: "..player:GetName().." Spec: "..player:GetPlayerSpec().." Tier: "..tier.." Pool size: "..#itemlist.." Pool position: "..rand.." Entry: "..itemEntry)
        
        player:CastSpell(player, 47292, true)
        -- Remove the box from the player, ensuring they have a slot for the item
        player:RemoveItem(ItemBox["boxId"], 1)
        -- Add random item selected to player
        player:AddItem(itemlist[rand], 1)
    else
        player:SendBroadcastMessage("Could not determine talent spec! Please respec or change primary talent tree!")
    end

    return false
end

function ItemBox.CacheData()
    -- Do DB caching to data struct here
    local tmpData = {}
    
    local dbDataQuery = WorldDBQuery("SELECT tier, list, entry, faction FROM itembox_template;");
    if(dbDataQuery)then
        repeat
            local dbTier, list, entry, faction = dbDataQuery:GetUInt32(0), dbDataQuery:GetUInt32(1), dbDataQuery:GetUInt32(2), dbDataQuery:GetInt32(3)
            
            if not(tmpData[dbTier]) then -- If tier struct does not exist, create it
                tmpData[dbTier] = {}
            end
            
            if not(tmpData[dbTier][list]) then -- If list structure does not exist, create it
                tmpData[dbTier][list] = {}
            end
            
            if not(tmpData[dbTier][list][faction]) then -- If faction structure does not exist, create it
                tmpData[dbTier][list][faction] = {}
            end
            
            table.insert(tmpData[dbTier][list][faction], entry) -- Push entry to relevant temporary Lua table
        until not dbDataQuery:NextRow()
    end
    
    for tier, tierTable in pairs(tmpData) do
        if not (ItemBox["dataCache"][tier]) then -- If tier table does not exist, construct it
            ItemBox["dataCache"][tier] = {}
        end
        
        
        for classListKey, classListValTable in pairs(ItemBox["classList"]) do
            for i = 1, #classListValTable do
                if not(ItemBox["dataCache"][tier][classListKey]) then -- If tier class subtable does not exist, construct it
                    ItemBox["dataCache"][tier][classListKey] = {}
                end
                
                if not(ItemBox["dataCache"][tier][classListKey][i]) then
                    ItemBox["dataCache"][tier][classListKey][i] = {}
                    ItemBox["dataCache"][tier][classListKey][i][0] = {} -- Horde item list
                    ItemBox["dataCache"][tier][classListKey][i][1] = {} -- Alliance item list
                end
                
                for _, classListVal in pairs(classListValTable[i]) do
                    if(tmpData[tier][classListVal]) then
                        for itemListKey, itemListValTable in pairs(tmpData[tier][classListVal]) do
                            for _, itemListVal in pairs(itemListValTable) do
                                if(itemListKey == -1) then -- Check whether the item is a universal item or a faction item
                                    table.insert(ItemBox["dataCache"][tier][classListKey][i][0], itemListVal) -- If universal, add to both alliance and horde list
                                    table.insert(ItemBox["dataCache"][tier][classListKey][i][1], itemListVal)
                                else
                                    table.insert(ItemBox["dataCache"][tier][classListKey][i][itemListKey], itemListVal) -- If faction specific, only add to that faction list
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    local tmpData = nil; -- Clear out our temporary data table whenever we are finished reading from it
end

function ItemBox.GetItemList(player, tier)
    local faction, class, spec = player:GetTeam(), player:GetClass(), player:GetPlayerSpec()
    local t = {}
    
    if(ItemBox["dataCache"] and spec > 0) then
        if(tier > #ItemBox["dataCache"]) then -- If tier is higher than max size of tiers, set tier to max
            tier = #ItemBox["dataCache"]
        end
        
        if (ItemBox["dataCache"][tier]) then -- Sanity checking loot box structure
            if (ItemBox["dataCache"][tier][class]) then
                if(ItemBox["dataCache"][tier][class][spec]) then
                    if(ItemBox["dataCache"][tier][class][spec][faction]) then
                        return ItemBox["dataCache"][tier][class][spec][faction];
                    end
                end
            end
        end
    end
    
    return t;
end

ItemBox.CacheData() -- Call cache on script load
RegisterItemEvent(ItemBox["boxId"], 2, ItemBox.OnUse)
