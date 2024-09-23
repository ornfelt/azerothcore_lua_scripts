RacialChangeNamespace = {}

RacialChangeNamespace.NPC_ENTRY = 98888 -- NPC Trainer ID

RacialChangeNamespace.RacialSpellsCombined = {
    [1] = {20864, 58985, 20597, 20598}, -- human
    [2] = {20594, 20595, 20596, 59224}, -- dwarf
    [3] = {21009, 20583, 20585, 58984, 20582}, -- NightElf
    [4] = {20593, 20589, 20591, 20592}, -- gnome
    [5] = {28875, 59548, 28878, 59541}, -- draenei
    [6] = {68976, 68992, 68978}, -- worgen 97709 for two forms spell but change to human
    [7] = {10253, 10254, 10255, 10256}, -- LightForged Draenei
    [9] = {255661, 255663, 255664, 255665, 255667}, -- highelf
    [10] = {100207, 100258, 10001002}, -- DemonHunter_ally
    [11] = {20572, 21563, 20573}, -- Orc
    [12] = {20577, 7744, 20579}, -- Undead
    [13] = {20552, 20550, 20551, 20549}, -- Tauren
    [14] = {20557, 26297, 58943, 20555, 20558}, -- Troll
    [15] = {28877, 80025, 822}, -- Blood Elf
    [16] = {107074, 100257, 28875, 100260, 80099, 100271}, -- Manari Draenei
    [17] = {312411, 312198, 312370, 312215, 312372},  -- Vulpera
    [18] = {312411, 312198, 312370, 312215, 312372},  -- Troll Zandalari (??) using Vulpera for now
    [19] = {69045, 69044, 69046, 69041, 69070, 69042} -- Goblin
    
}

RacialChangeNamespace.RacesCombined = {
    [1] = "Human",
    [2] = "Dwarf",
    [3] = "NightElf",
    [4] = "Gnome",
    [5] = "Draenei",
    [6] = "Worgen",
    [7] = "Lightforged Draenei",
    [9] = "High Elf",
    [10] = "Demon Hunter",
    [11] = "Orc",
    [12] = "Undead",
    [13] = "Tauren",
    [14] = "Troll",
    [15] = "Blood Elf",
    [16] = "Manari Eredar",
    [17] = "Vulpera",
    [18] = "Zandalari Troll",
    [19] = "Goblin"
    
}

local function Swao_OnHello(event, player, unit)
    if unit:GetEntry() == RacialChangeNamespace.NPC_ENTRY then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "Change Racial Abilities", 0, 1)
        player:GossipSendMenu(1, unit)
    end
end

local function getCostForPlayer(player)
    local playerLevel = player:GetLevel()
    if playerLevel <= 10 then
        return 0 -- Free for level 10 or lower
    elseif playerLevel > 10 and playerLevel <= 60 then
        return 500000 -- 50 gold
    elseif playerLevel > 60 and playerLevel <= 70 then
        return 1000000 -- 100 gold
    elseif playerLevel > 70 and playerLevel <= 80 then
        return 5000000 -- 500 gold
    end
end

local function Swao_OnGossipSelect(event, player, unit, sender, intid, code)
    if unit:GetEntry() == RacialChangeNamespace.NPC_ENTRY then
        if intid == 1 then
            player:GossipClearMenu()
            player:GossipMenuAddItem(0, "Cancel", 0, 2)

            local cost = getCostForPlayer(player)

            -- Add options to select a new race
            for raceID, raceName in pairs(RacialChangeNamespace.RacesCombined) do
                local confirmText = "This will cost you "..tostring(cost/10000).." gold. Do you wish to proceed?"
                if cost == 0 then -- Free for level 10 or lower
                    confirmText = "This feature is free until level 11. Do you wish to proceed?"
                end
                player:GossipMenuAddItem(0, raceName, 0, raceID + 10, false, confirmText, cost)
            end

            player:GossipSendMenu(1, unit)
        elseif intid >= 11 and intid <= 30 then
            local cost = getCostForPlayer(player)
            
            -- Check if player has enough gold
            if cost > 0 and player:GetCoinage() < cost then
                player:SendBroadcastMessage("You do not have enough gold to change your racial abilities.")
                player:GossipComplete()
                return
            end

            local selectedRaceID = intid - 10
            local selectedRaceSpells = RacialChangeNamespace.RacialSpellsCombined[selectedRaceID]

            -- Remove all current racial abilities
            for _, spellList in pairs(RacialChangeNamespace.RacialSpellsCombined) do
                for _, spellID in ipairs(spellList) do
                    player:RemoveSpell(spellID)
                end
            end

            -- Deduct gold from player, if necessary
            if cost > 0 then
                player:ModifyMoney(-cost)
            end

            -- Learn new racial abilities
            for _, spellID in ipairs(selectedRaceSpells) do
                player:LearnSpell(spellID)
            end

            player:SendBroadcastMessage("You have changed your racial abilities to: " .. RacialChangeNamespace.RacesCombined[selectedRaceID] .. ".")
            player:GossipComplete()
        else
            player:GossipComplete()
        end
    end
end

RegisterCreatureGossipEvent(RacialChangeNamespace.NPC_ENTRY, 1, Swao_OnHello)
RegisterCreatureGossipEvent(RacialChangeNamespace.NPC_ENTRY, 2, Swao_OnGossipSelect)
