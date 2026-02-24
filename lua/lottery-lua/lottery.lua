-- Configuration
local LOTTERY_COST = 1                    -- Cost in Emblems of Frost
local EMBLEM_OF_FROST_ID = 49426          -- Item ID for entry cost
local REGISTRATION_TIME_SECONDS = 60       -- 1 minute for lottery registration
local CLAIM_TIMEOUT_SECONDS = 120         -- 2 minutes for prize claim
local PRIZE_ITEM_ID = 49623              -- Prize item ID
local NPC_ID = 500000                    -- Lottery NPC ID

-- State Variables
local participationTimes = {}             -- Tracks last participation time per player
local participants = {}                   -- Current lottery participants
local nextDrawTime = 0                    -- Time of next lottery draw
local winnerName = nil                    -- Current winner's name
local claimEndTime = 0                    -- Prize claim deadline
local isWaitingForClaim = false           -- Prize claim status
local prizeItemName = GetItemLink(PRIZE_ITEM_ID) or "Unknown Prize"

-- Utility Functions
local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

local function canPlayerEnterLottery(player)
    if isWaitingForClaim then return false end
    
    local playerId = player:GetGUIDLow()
    if not participationTimes[playerId] then return true end
    
    local currentTime = os.time()
    local lastParticipationTime = participationTimes[playerId]
    return (currentTime - lastParticipationTime) >= REGISTRATION_TIME_SECONDS
end

-- Core Lottery Functions
local function addParticipant(player)
    local playerName = player:GetName()
    table.insert(participants, playerName)
    participationTimes[player:GetGUIDLow()] = os.time()
    player:SendBroadcastMessage("You have entered the lottery. Good luck!")
end

local function performLotteryDraw()
    if #participants == 0 then
        SendWorldMessage("No participants in the lottery this time. Better luck next time!")
        nextDrawTime = os.time() + REGISTRATION_TIME_SECONDS
        return
    end

    local winningIndex = math.random(1, #participants)
    winnerName = participants[winningIndex]
    claimEndTime = os.time() + CLAIM_TIMEOUT_SECONDS
    isWaitingForClaim = true
    
    SendWorldMessage(string.format("%s has won the lottery! They have %d minutes to claim their prize!", 
        winnerName, CLAIM_TIMEOUT_SECONDS / 60))
    
    participants = {} -- Clear for next round
end

local function awardPrize(player)
    if not player or not player:IsInWorld() then return false end
    
    player:AddItem(PRIZE_ITEM_ID, 1)
    SendWorldMessage(string.format("Congratulations to %s for winning %s!", 
        player:GetName(), prizeItemName))
    
    -- Reset lottery state
    winnerName = nil
    isWaitingForClaim = false
    nextDrawTime = os.time() + REGISTRATION_TIME_SECONDS
    return true
end

local function checkPrizeClaim()
    if not isWaitingForClaim or not winnerName then return end
    
    local currentTime = os.time()
    if currentTime >= claimEndTime then
        SendWorldMessage(string.format("Prize not claimed by %s. Starting new lottery!", winnerName))
        winnerName = nil
        isWaitingForClaim = false
        nextDrawTime = currentTime + REGISTRATION_TIME_SECONDS
    end
end

-- NPC Interaction Handlers
local function onGossipHello(event, player, object)
    player:GossipClearMenu()
    
    if not isWaitingForClaim then
        player:GossipMenuAddItem(0, "Enter lottery (" .. LOTTERY_COST .. " Emblem of Frost)", 1, 1)
    end
    
    if winnerName and player:GetName() == winnerName then
        player:GossipMenuAddItem(0, "Claim Prize", 1, 2)
    end
    
    player:GossipMenuAddItem(0, "View Participants", 1, 3)
    player:GossipMenuAddItem(0, "View Timer", 1, 4)
    player:GossipMenuAddItem(0, "Rules", 1, 5)
    player:GossipSendMenu(1, object)
end

local function onGossipSelect(event, player, object, sender, intid, code)
    if intid == 1 then -- Enter Lottery
        if canPlayerEnterLottery(player) then
            if player:HasItem(EMBLEM_OF_FROST_ID, LOTTERY_COST) then
                player:RemoveItem(EMBLEM_OF_FROST_ID, LOTTERY_COST)
                addParticipant(player)
            else
                player:SendBroadcastMessage("You need " .. LOTTERY_COST .. " Emblem of Frost to enter!")
            end
        else
            player:SendBroadcastMessage("You cannot enter the lottery at this time.")
        end
    elseif intid == 2 then -- Claim Prize
        if winnerName and player:GetName() == winnerName then
            awardPrize(player)
        end
    elseif intid == 3 then -- View Participants
        player:SendBroadcastMessage("Current participants:")
        for i, name in ipairs(participants) do
            player:SendBroadcastMessage(i .. ". " .. name)
        end
    elseif intid == 4 then -- View Timer
        local currentTime = os.time()
        if isWaitingForClaim then
            local timeLeft = math.max(0, claimEndTime - currentTime)
            player:SendBroadcastMessage("Time left to claim prize: " .. formatTime(timeLeft))
        else
            local timeLeft = math.max(0, nextDrawTime - currentTime)
            player:SendBroadcastMessage("Time until next draw: " .. formatTime(timeLeft))
        end
    elseif intid == 5 then -- Rules
        player:SendBroadcastMessage("=== Lottery System Rules ===")
        player:SendBroadcastMessage("Entry Requirements:")
        player:SendBroadcastMessage("• Cost: " .. LOTTERY_COST .. " Emblem of Frost per ticket")
        player:SendBroadcastMessage("• You can only enter once per lottery round")
        player:SendBroadcastMessage("")
        player:SendBroadcastMessage("Lottery Schedule:")
        player:SendBroadcastMessage("• New draw every " .. (REGISTRATION_TIME_SECONDS/60) .. " minutes")
        player:SendBroadcastMessage("• Winners are announced server-wide")
        player:SendBroadcastMessage("")
        player:SendBroadcastMessage("Claiming Prizes:")
        player:SendBroadcastMessage("• Winners have " .. (CLAIM_TIMEOUT_SECONDS/60) .. " minutes to claim")
        player:SendBroadcastMessage("• Must be online to claim your prize")
        player:SendBroadcastMessage("• Unclaimed prizes are forfeited")
        player:SendBroadcastMessage("")
        player:SendBroadcastMessage("Prize Information:")
        player:SendBroadcastMessage("• Current Prize: " .. prizeItemName)
        player:SendBroadcastMessage("• Prize is delivered instantly upon claim")
        player:SendBroadcastMessage("")
        player:SendBroadcastMessage("Good luck to all participants!")
    end
    
    player:GossipComplete()
end

-- Event Registration
RegisterCreatureGossipEvent(NPC_ID, 1, onGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, onGossipSelect)

-- Timer Events
CreateLuaEvent(function()
    if not isWaitingForClaim and os.time() >= nextDrawTime then
        performLotteryDraw()
    end
end, 1000, 0)

CreateLuaEvent(checkPrizeClaim, 1000, 0)

-- Initialize next draw time
nextDrawTime = os.time() + REGISTRATION_TIME_SECONDS

print("Lottery System loaded successfully!")
