-- Trivia System CONFIG by Aldori
-- Hosted on GitHub:  https://github.com/Aldori15/azerothcore-trivia-system

------- START CONFIG -------

local ENABLE_TRIVIA_SYSTEM = false

local triviaDays = {1, 2, 3, 4, 5, 6, 7}  -- Sun(1), Mon(2), Tues(3), Wed(4), Thurs(5), Fri(6), Sat(7)
local triviaTimes = {"00:30", "02:15", "04:00", "05:45", "07:15", "08:30", "10:00", "12:00", "14:30", "17:00", "19:15", "22:45"}  -- Trivia session times

local questionsPerSession = 10 -- Total number of questions per Trivia session
local questionDuration = 25  -- Time in seconds before question expires
local voteTimer = 45  -- Time in seconds for voting duration

local streakBonusThreshold = {4, 6, 10}  -- Number of correct answers in a row to be eligible for a streak bonus

local ENABLE_MONEY_REWARD = false  -- Toggle to give a gold reward for correct answers
local ENABLE_MAIL_ITEM_REWARD = false  -- Toggle to mail an item reward for correct answers
local mailItemRewardID = 37711  -- Reward Points Currency (replace with your ID if ENABLE_MAIL_ITEM_REWARD is enabled)

------- END CONFIG -------
-- Do not edit below this line unless you know what you are doing

if not ENABLE_TRIVIA_SYSTEM then return end

local difficultyLevels = {"easy", "medium", "hard"}
local categories = {"Boss", "City", "Class", "Dungeon", "Event", "Faction", "Items", "Lore", "Mounts", "Pets", "Professions", "Quests", "Race", "Raid", "Zone"}
local voteOptions = {"easy", "medium", "hard"}

local commonWords = {["the"] = true, ["a"] = true, ["an"] = true, ["of"] = true, ["in"] = true}

-- Trivia System Object
TriviaSystem = {
    activeQuestion = nil,
    basePoints = 0,
    currentPoints = 0,
    questionTimer = nil,
    questionStartTime = nil,
    answered = false,
    playersAnswered = {},
    votedPlayers = {},
    streaks = {},
    streakReset = {},
    sessionParticipants = {},
    votes = {difficulty = {easy = 0, medium = 0, hard = 0}, category = {}},
    voteInProgress = false,
    voteEndTimer = nil,
    questionsAsked = 0,
    currentDifficulty = nil,
    currentCategory = nil,
    previousHint = {},
    hintCounters = {},
    totalHintCounters = {}
}

function table.contains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- Function to remove special characters and make case-insensitive
function TriviaSystem:NormalizeString(str)
    return str:lower():gsub("%W", "")
end

-- Extract significant keywords from the given answer, ignoring common words
function TriviaSystem:ExtractSignificantKeywords(answer)
    local keywords = {}
    for word in answer:gmatch("%w+") do
        if not commonWords[word:lower()] then
            table.insert(keywords, word:lower())
        end
    end
    return keywords
end

-- Function to update the player's score and streak in the leaderboard
function TriviaSystem:UpdatePlayerScore(playerName, points)
    local bonusPoints = 0
    local currentStreak = self.streaks[playerName] or 0

    currentStreak = currentStreak + 1
    self.streaks[playerName] = currentStreak

    -- Check for streak bonus
    for _, threshold in ipairs(streakBonusThreshold) do
        if currentStreak == threshold then
            local bonusPercentage = threshold * 10  -- Calculate bonus dynamically
            bonusPoints = math.floor(points * (bonusPercentage / 100))
            SendWorldMessage(string.format("|cffe522e5Trivia:|r %s has reached a streak of %d and earned a bonus of %d points (%d%% bonus)!", playerName, currentStreak, bonusPoints, bonusPercentage))
            break
        end
    end

    -- Update points in the database
    local query = CharDBQuery(string.format("SELECT points FROM trivia_leaderboard WHERE name = '%s'", playerName))
    local newPoints = points + bonusPoints
    if query then
        newPoints = query:GetInt32(0) + points + bonusPoints
        CharDBExecute(string.format("UPDATE trivia_leaderboard SET points = %d WHERE name = '%s'", newPoints, playerName))
    else
        -- Player's first time participating, insert a new row into the leaderboard
        CharDBExecute(string.format("INSERT INTO trivia_leaderboard (name, points, streak) VALUES ('%s', %d, 0)", playerName, newPoints))
    end
end

-- Function to schedule the next trivia event
function TriviaSystem:ScheduleNextTriviaEvent()
    local currentDay = tonumber(os.date("%w")) + 1  -- Lua returns Sunday as 0, add 1 to make it 1-based.
    local currentTime = os.date("%H:%M")
    
    local nextEventTime = nil
    local nextEventDay = nil

    -- Find the next event day and time
    for _, day in ipairs(triviaDays) do
        for _, time in ipairs(triviaTimes) do
            if (day > currentDay) or (day == currentDay and time > currentTime) then
                nextEventTime = time
                nextEventDay = day
                break
            end
        end
        if nextEventDay then break end
    end

    -- If no future event today or in the week, schedule the first event for next week
    if not nextEventDay then
        nextEventDay = triviaDays[1]
        nextEventTime = triviaTimes[1]
    end

    -- Calculate time remaining until the next trivia event
    local nextEventDate = os.time({
        year = os.date("*t").year,
        month = os.date("*t").month,
        day = os.date("*t").day + (nextEventDay - currentDay),
        hour = tonumber(string.sub(nextEventTime, 1, 2)),
        min = tonumber(string.sub(nextEventTime, 4, 5)),
        sec = 0
    })

    local timeUntilNextEvent = math.max(0, nextEventDate - os.time()) * 1000 -- Convert to milliseconds
    SendWorldMessage("|cffe522e5Trivia:|r The next trivia event will start in " .. math.floor(timeUntilNextEvent / 60000) .. " minutes.")

    CreateLuaEvent(function() self:StartTriviaSession() end, timeUntilNextEvent, 1)
end

function TriviaSystem:GetTopPlayers()
    -- SQL to get top 10 players (a buffer to filter by session participants)
    local sql = "SELECT name, points FROM trivia_leaderboard ORDER BY points DESC LIMIT 10"
    local query = CharDBQuery(sql)

    local players = {}
    if query then
        repeat
            local name = query:GetString(0)
            local points = query:GetInt32(1)
            local streak = self.streaks[name] or 0

            -- Only include players who participated in the current session
            for playerGUID, _ in pairs(self.sessionParticipants) do
                local player = GetPlayerByGUID(playerGUID)
                if player and player:GetName() == name then
                    table.insert(players, {name = name, points = points, streak = streak})
                    break
                end
            end
        until not query:NextRow()
        -- Sort players by points in descending order and return the top 3
        table.sort(players, function(a, b) return a.points > b.points end)
    end
    return {players[1], players[2], players[3]}
end

function TriviaSystem:EndTriviaSession()
    SendWorldMessage(" ")
    SendWorldMessage("|cffe522e5Trivia:|r |cff00ff00Trivia session has ended! Thanks for participating.|r")

    for playerName, streak in pairs(self.streaks) do
        if streak > 0 then
            CharDBExecute(string.format("UPDATE trivia_leaderboard SET streak = %d WHERE name = '%s'", streak, playerName))
        end
    end

    for playerGUID, _ in pairs(self.streakReset) do
        self.streakReset[playerGUID] = nil
    end

    local topPlayers = self:GetTopPlayers()
    if #topPlayers == 0 then return end
    local firstPlacePlayer = topPlayers[1]

    -- Iterate through session participants and track progress
    for playerGUID, _ in pairs(self.sessionParticipants) do
        local player = GetPlayerByGUID(playerGUID)
        if player then
            self:TrackTriviaAchievementProgress(player, nil, "session")
            self:TrackTriviaAchievementProgress(player, nil, "perfectSession")

            -- Check if this player is the 1st place player and if they used no hints
            if firstPlacePlayer and player:GetName() == firstPlacePlayer.name and (self.totalHintCounters[player:GetGUIDLow()] or 0) == 0 then
                -- No hints used by the 1st place player, award achievement progress
                self:TrackTriviaAchievementProgress(player, nil, "minimalHint")
            end
        end
    end
    
    -- Build the summary message
    local summary = "|cffe522e5Trivia Session Summary:|r\n"
    for i, player in ipairs(topPlayers) do
        local rankColor = "|cffffff00"  -- Default color for ranks
        if i == 1 then
            rankColor = "|cffFFD700"  -- Gold for rank 1
        elseif i == 2 then
            rankColor = "|cffC0C0C0"  -- Silver for rank 2
        elseif i == 3 then
            rankColor = "|cffCD7F32"  -- Bronze for rank 3
        end

        summary = summary .. string.format("%s%d. %s - %d points, Streak: %d|r\n", rankColor, i, player.name, player.points, player.streak)
    end

    SendWorldMessage(summary)
end

function TriviaSystem:AskQuestion(category)
    if self.questionsAsked >= questionsPerSession then
        self:EndTriviaSession()
        return
    end

    local questionFound = false
    local attemptedCategories = {}
    local attemptedDifficulties = {}

    while not questionFound do
        -- Dynamically load the next question based on category and difficulty
        local query = CharDBQuery(string.format("SELECT id, question, answer, points FROM trivia_questions WHERE difficulty = '%s' AND category = '%s' ORDER BY RAND() LIMIT 1", self.currentDifficulty, category))
        if query then
            local id = query:GetUInt32(0)
            local question = query:GetString(1)
            local originalAnswer = query:GetString(2)
            local points = query:GetInt32(3)

            -- Initialize active question
            self.activeQuestion = question
            self.originalAnswer = originalAnswer
            self.basePoints = points or 0
            self.currentPoints = self.basePoints
            self.answered = false
            self.playersAnswered = {}
            self.questionStartTime = os.time()
            self.questionsAsked = self.questionsAsked + 1
            self.hintCounters = {}
            self.currentCategory = category
            questionFound = true

            -- Announce the question
            SendWorldMessage(" ")
            SendWorldMessage("|cffe522e5Trivia:|r |cfff99b09" .. self.activeQuestion .. "|r")
            self.questionTimer = CreateLuaEvent(function() self:ExpireQuestion() end, questionDuration * 1000, 1)
        else
            -- No question found, fallback to another category or difficulty
            table.insert(attemptedCategories, category)
            table.insert(attemptedDifficulties, self.currentDifficulty)

            -- Try another category first
            for _, cat in ipairs(categories) do
                if not table.contains(attemptedCategories, cat) then
                    category = cat
                    break
                end
            end

            -- If all categories have been attempted, switch to a different difficulty
            if #attemptedCategories == #categories then
                for _, diff in ipairs(difficultyLevels) do
                    if not table.contains(attemptedDifficulties, diff) then
                        self.currentDifficulty = diff
                        attemptedCategories = {}
                        break
                    end
                end
            end

            -- If no fallback available, end the session
            if #attemptedDifficulties == #difficultyLevels then
                SendWorldMessage("|cffe522e5Trivia:|r No questions available for any combination of category and difficulty.")
                self:EndTriviaSession()
                return
            end
        end
    end
end

-- Function to start a trivia session
function TriviaSystem:StartTriviaSession()
    SendWorldMessage(" ")
    SendWorldMessage("|cffe522e5Trivia:|r |cfff99b09A trivia session will be starting in 1 minute!|r")

    -- Reset streaks, points, and session-specific variables
    CharDBExecute("UPDATE trivia_leaderboard SET streak = 0, points = 0")
    CharDBExecute("UPDATE trivia_achievement_progress SET perfect_session_questions = 0")
    self.streaks = {}
    self.totalHintCounters = {}
    self.sessionParticipants = {}

    CreateLuaEvent(function()
        -- Start the trivia session
        SendWorldMessage("|cffe522e5Trivia:|r |cffffcc00The trivia session is starting now! Type |cff00ff00#answer <your_answer>|r to participate.")
        SendWorldMessage("|cffe522e5Trivia:|r Type |cff00ff00#trivia|r to see a list of available commands.")
        SendWorldMessage("|cffe522e5Trivia:|r Preparing the first question (1/" .. questionsPerSession .. "). Get ready!")

        self.questionsAsked = 0
        self:AskQuestion()
    end, 60000, 1)
end

-- Function to load questions from the database based on voted difficulty
function TriviaSystem:LoadQuestionsFromDatabase(count)
    self.questionList = {}

    local chosenDifficulty = self.currentDifficulty
    local query = CharDBQuery(string.format("SELECT id, question, answer, points FROM trivia_questions WHERE difficulty = '%s' ORDER BY RAND() LIMIT %d", chosenDifficulty, count))
    if query then
        repeat
            local id = query:GetUInt32(0)
            local question = query:GetString(1)
            local answer = query:GetString(2)
            local points = query:GetInt32(3)

            if answer and #answer > 0 then
                table.insert(self.questionList, {
                    id = id,
                    question = question,
                    answer = self:NormalizeString(answer),
                    points = points,
                    difficulty = chosenDifficulty
                })
            end
        until not query:NextRow()
    else
        SendWorldMessage("|cffe522e5Trivia:|r No questions available for '" .. chosenDifficulty .. "'. Trying another difficulty.")
        self.currentDifficulty = difficultyLevels[math.random(#difficultyLevels)]
        self:LoadQuestionsFromDatabase(count)
    end
end

local function IsVowel(c)
    return c:match("[aeiouAEIOU]")
end

-- Identify positions where letters should be revealed
local function GetPrioritizedHintPositions(hint, answer)
    local priorityPositions = {}
    local fallbackPositions = {}

    for i = 1, #answer do
        if hint[i] == "_" then
            local char = answer:sub(i, i)
            if IsVowel(char) then
                table.insert(priorityPositions, i)  -- Prioritize revealing vowels
            else
                table.insert(fallbackPositions, i)  -- Backup option for consonants
            end
        end
    end

    -- Prefer vowels first, then fallback to any remaining positions
    return #priorityPositions > 0 and priorityPositions or fallbackPositions
end

local function RevealStrategicLetter(hint, answer)
    local positions = GetPrioritizedHintPositions(hint, answer)
    if #positions > 0 then
        local chosenPos
        repeat
            chosenPos = positions[math.random(#positions)]  -- Randomly pick a position
        until hint[chosenPos] == "_"  -- Ensure only unrevealed letters are chosen

        hint[chosenPos] = answer:sub(chosenPos, chosenPos)  -- Reveal the letter
    end
end

function TriviaSystem:ProvideHint(player)
    local playerGUID = player:GetGUIDLow()
    self.hintCounters[playerGUID] = self.hintCounters[playerGUID] or 0
    self.totalHintCounters[playerGUID] = self.totalHintCounters[playerGUID] or 0
    self.previousHint[playerGUID] = self.previousHint[playerGUID] or {}

    if not self.activeQuestion then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r There is no active trivia question right now.")
        return
    end

    if self.answered then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r The question has already been answered.")
        return
    end

    if self.hintCounters[playerGUID] >= 3 then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r No more hints are available for this question.")
        return
    end

    self:MarkPlayerParticipation(playerGUID)

    local answer = self.originalAnswer

    -- On the first hint, reveal the first letter and special characters
    if #self.previousHint[playerGUID] == 0 then
        for i = 1, #answer do
            local char = answer:sub(i, i)
            -- Automatically reveal special characters, spaces, and punctuation
            if i == 1 or char:match("[%s%p]") then
                self.previousHint[playerGUID][i] = char
            else
                self.previousHint[playerGUID][i] = "_"
            end
        end
        -- Reveal an additional strategic letter for the first hint
        RevealStrategicLetter(self.previousHint[playerGUID], answer)
    elseif self.hintCounters[playerGUID] < 3 then
        -- Reveal an additional letter for subsequent hints
        RevealStrategicLetter(self.previousHint[playerGUID], answer)
    end

    -- Display the current hint to the player
    local currentHintNumber = self.hintCounters[playerGUID] + 1
    local hintString = table.concat(self.previousHint[playerGUID]):gsub(" ", "  ")
    player:SendBroadcastMessage(string.format("|cffe522e5Trivia:|r |cffffcc00Hint %d/3:|r %s", currentHintNumber, hintString))

    -- Dynamic hint penalties
    local hintPenalties = {
        easy = {0.80, 0.60, 0.40},
        medium = {0.75, 0.50, 0.25},
        hard = {0.50, 0.30, 0.10}
    }
    local difficulty = self.currentDifficulty or "medium"
    local penaltyIndex = math.min(currentHintNumber, 3)  -- Safety net to avoid out of range index errors
    self.currentPoints = math.max(1, math.floor(self.basePoints * hintPenalties[difficulty][penaltyIndex]))

    -- Update hint counters
    self.hintCounters[playerGUID] = currentHintNumber
    self.totalHintCounters[playerGUID] = self.totalHintCounters[playerGUID] + 1

    -- Track the hint request for achievements
    self:TrackTriviaAchievementProgress(player, nil, "hint")
end

-- Function to initiate a vote for the next question's difficulty
function TriviaSystem:StartVote()
    if self.voteInProgress then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r A vote is already in progress!")
        return
    end

    self.votes = {difficulty = {easy = 0, medium = 0, hard = 0}, category = {}}
    self.votedPlayers = {}
    self.voteInProgress = true

    for _, category in ipairs(categories) do
        self.votes.category[category] = 0
    end

    SendWorldMessage(" ")
    SendWorldMessage("|cffe522e5Trivia:|r Vote for the next question's difficulty and category!")
    SendWorldMessage("|cffe522e5Difficulty Options:|r Type |cff00ff00#vote easy|r, |cff00ff00#vote medium|r, or |cff00ff00#vote hard|r.")

    -- Build the category message
    local categoryMessage = "|cffe522e5Category Options:|r Type "
    for i, category in ipairs(categories) do
        if i > 1 then
            categoryMessage = categoryMessage .. ", "
        end
        if i == #categories then
            categoryMessage = categoryMessage .. "or "
        end
        categoryMessage = categoryMessage .. "|cff00ff00#vote " .. category:lower() .. "|r"
    end
    categoryMessage = categoryMessage .. "."
    SendWorldMessage(categoryMessage)

    self.voteEndTimer = CreateLuaEvent(function() self:EndVote() end, voteTimer * 1000, 1)
end

-- Expire the active question if no answer is provided
function TriviaSystem:ExpireQuestion()
    if self.activeQuestion then
        if not self.answered then
            SendWorldMessage("|cffe522e5Trivia:|r |cff22e522Time's up! The correct answer was: |cffffcc00" .. self.originalAnswer .. "|r")
        end

        self.activeQuestion = nil
        self.originalAnswer = nil
        self.questionTimer = nil

        -- Only proceed to vote if questions remain
        if self.questionsAsked < questionsPerSession then
            self:StartVote()
        else
            self:EndTriviaSession()
        end
    end
end

function TriviaSystem:HandleVote(player, voteOption)
    local playerGUID = player:GetGUIDLow()
    voteOption = voteOption:lower()

    if not self.voteInProgress then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r No vote is currently in progress.")
        return
    end

    if not self.votedPlayers[playerGUID] then
        self.votedPlayers[playerGUID] = {difficulty = false, category = false}
    end

    self:MarkPlayerParticipation(playerGUID)

    -- Handle difficulty votes
    if table.contains(voteOptions, voteOption) then
        if self.votedPlayers[playerGUID].difficulty then
            player:SendBroadcastMessage("|cffe522e5Trivia:|r You have already voted for the difficulty.")
            return
        end

        -- Register the difficulty vote
        self.votes.difficulty[voteOption] = self.votes.difficulty[voteOption] + 1
        self.votedPlayers[playerGUID].difficulty = true
        player:SendBroadcastMessage(string.format("|cffe522e5Trivia:|r You successfully voted for '%s' difficulty for the next question.", voteOption))
        
        -- Track difficulty vote achievement progress
        self:TrackTriviaAchievementProgress(player, nil, "difficulty")
        return
    end

    -- Handle category votes
    local matchedCategory = nil
    for _, category in ipairs(categories) do
        if voteOption == category:lower() then
            matchedCategory = category
            break
        end
    end

    if matchedCategory then
        -- Check if player has already voted for category
        if self.votedPlayers[playerGUID].category then
            player:SendBroadcastMessage("|cffe522e5Trivia:|r You have already voted for the category.")
            return
        end

        -- Register the category vote
        self.votes.category[matchedCategory] = self.votes.category[matchedCategory] + 1
        self.votedPlayers[playerGUID].category = true  -- Mark category vote as done
        player:SendBroadcastMessage(string.format("|cffe522e5Trivia:|r You successfully voted for the '%s' category for the next question.", matchedCategory:lower()))
        
        -- Track category vote progress
        self:TrackTriviaAchievementProgress(player, nil, "category")

    else
        player:SendBroadcastMessage("|cffe522e5Trivia:|r Invalid vote option. Please choose a valid difficulty or category.")
    end
end

function TriviaSystem:EndVote()
    self.voteInProgress = false
    RemoveEventById(self.voteEndTimer)
    self.voteEndTimer = nil

    local maxDifficultyVotes = 0
    local selectedDifficulty = nil
    -- If votes exist, pick the difficulty with the most votes
    for difficulty, count in pairs(self.votes.difficulty) do
        if count > maxDifficultyVotes then
            maxDifficultyVotes = count
            selectedDifficulty = difficulty
        end
    end

    -- Randomly select difficulty if no votes were cast
    if maxDifficultyVotes == 0 then
        selectedDifficulty = difficultyLevels[math.random(#difficultyLevels)]
        SendWorldMessage("|cffe522e5Trivia:|r No votes were cast for difficulty. Randomly selecting '" .. selectedDifficulty .. "' difficulty.")
    end

    self.currentDifficulty = selectedDifficulty

    local maxCategoryVotes = 0
    local selectedCategory = nil
    -- Check category votes and select the one with the most votes
    for category, count in pairs(self.votes.category) do
        if count > maxCategoryVotes then
            maxCategoryVotes = count
            selectedCategory = category
        end
    end

    -- Randomly select category if no votes were cast
    if maxCategoryVotes == 0 then
        selectedCategory = categories[math.random(#categories)]
        SendWorldMessage("|cffe522e5Trivia:|r No votes were cast for category. Randomly selecting the '" .. selectedCategory:lower() .. "' category.")
    end

    SendWorldMessage(" ")
    SendWorldMessage("|cffe522e5Trivia:|r The next question will be from the '" .. selectedCategory:lower() .. "' category with '" .. self.currentDifficulty .. "' difficulty.")

    local nextQuestionNumber = self.questionsAsked + 1
    if nextQuestionNumber == questionsPerSession then
        SendWorldMessage("|cffe522e5Trivia:|r Preparing the final question (" .. nextQuestionNumber .. "/" .. questionsPerSession .. "). Get ready!")
    else
        SendWorldMessage("|cffe522e5Trivia:|r Preparing the next question (" .. nextQuestionNumber .. "/" .. questionsPerSession .. "). Get ready!")
    end

    -- 10-second delay before asking the next question
    CreateLuaEvent(function()
        self:AskQuestion(selectedCategory)
    end, 10000, 1)
end

-- Function to reward the first player who answers correctly
function TriviaSystem:MailReward(player, points)
    local mailSubject = "Trivia Reward"
    local mailBody = "Congratulations! You've earned a reward from the Trivia event!"

    local playerGUIDLow = player:GetGUIDLow()
    local senderGUIDLow = 0  -- Unknown system sender (GUID 0)
    local stationeryType = 41  -- MAIL_STATIONERY_DEFAULT

    local minReward = 1
    local rewardMultiplier = 2
    local itemID = mailItemRewardID
    local itemCount = math.max(minReward, points * rewardMultiplier)

    -- Sending mail with item reward
    SendMail(mailSubject, mailBody, playerGUIDLow, senderGUIDLow, stationeryType, 0, 0, 0, itemID, itemCount)
end

-- Function to calculate the money reward based on player level
function TriviaSystem:GetMoneyReward(player)
    local level = player:GetLevel()
    local minMoney, maxMoney, currencyUnit

    if level <= 10 then
        minMoney, maxMoney, currencyUnit = 1, 5, 100  -- Silver conversion
    elseif level <= 20 then
        minMoney, maxMoney, currencyUnit = 1, 10, 100  -- Silver conversion
    elseif level <= 30 then
        minMoney, maxMoney, currencyUnit = 5, 20, 100  -- Silver conversion
    elseif level <= 40 then
        minMoney, maxMoney, currencyUnit = 10, 50, 100  -- Silver conversion
    elseif level <= 50 then
        minMoney, maxMoney, currencyUnit = 1, 5, 10000  -- Gold conversion
    elseif level <= 60 then
        minMoney, maxMoney, currencyUnit = 5, 10, 10000  -- Gold conversion
    elseif level <= 70 then
        minMoney, maxMoney, currencyUnit = 10, 20, 10000  -- Gold conversion
    else
        minMoney, maxMoney, currencyUnit = 20, 50, 10000  -- Gold conversion
    end

    -- Convert to copper using the currency unit
    local minCopper = minMoney * currencyUnit
    local maxCopper = maxMoney * currencyUnit
    return math.random(minCopper, maxCopper)
end

function TriviaSystem:MarkPlayerParticipation(playerGUID)
    self.sessionParticipants[playerGUID] = true
end

-- Function to check the player's answer
function TriviaSystem:CheckAnswer(player, answer)
    if self.activeQuestion == nil then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r |cff00ff00No active trivia question.|r")
        return
    end

    if self.answered then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r |cff00ff00The question has already been answered! Wait for the next one.|r")
        return
    end

    local playerGUID = player:GetGUIDLow()
    self:MarkPlayerParticipation(playerGUID)

    -- Normalize both player's answer and the correct answer to avoid case or special character issues
    local normalizedAnswer = self:NormalizeString(answer)
    local significantKeywords = self:ExtractSignificantKeywords(self.originalAnswer)

    local allKeywordsMatched = true
    -- Check if the player's answer matches any significant keyword
    for _, keyword in ipairs(significantKeywords) do
        if not normalizedAnswer:find(self:NormalizeString(keyword)) then
            allKeywordsMatched = false
            break
        end

        if allKeywordsMatched then
            self.answered = true

            local playerName = player:GetName()
            SendWorldMessage("|cffe522e5Trivia:|r |cff00ff00" .. playerName .. " got it! The correct answer was: |cffffcc00" .. self.originalAnswer .. "|r")

            -- Apply dynamic point calculation based on time and hints
            local timeTaken = os.time() - self.questionStartTime
            local timeLeftPercentage = math.max(0, (questionDuration - timeTaken) / questionDuration)
            local pointsAwarded = math.ceil(self.currentPoints * (0.5 + timeLeftPercentage))  -- Minimum 50% of current points

            self:UpdatePlayerScore(playerName, pointsAwarded)
            self:TrackTriviaAchievementProgress(player, timeTaken, "correctAnswer")

            -- Check if mail item rewards are enabled
            if ENABLE_MAIL_ITEM_REWARD then
                self:MailReward(player, pointsAwarded)
            end
            -- Check if money rewards are enabled
            if ENABLE_MONEY_REWARD then
                local moneyReward = self:GetMoneyReward(player)
                player:ModifyMoney(moneyReward)
                player:SendBroadcastMessage(string.format("|cffe522e5Trivia:|r You've earned %s as a reward!", self:FormatMoneyString(moneyReward)))
            end

            -- Cancel timers and move to vote stage
            if self.questionTimer then RemoveEventById(self.questionTimer) end

            -- Only proceed to the next vote if there are remaining questions
            if self.questionsAsked < questionsPerSession then
                self:StartVote()
            else
                self:EndTriviaSession()
            end
            return
        end
    end

    -- Player answered incorrectly, reset their streak
    local playerName = player:GetName()
    self.streaks[playerName] = 0
    player:SendBroadcastMessage("|cffe522e5Trivia:|r Incorrect answer. Your streak has been reset. Try again!")

    -- Track streak reset for comeback checks
    self:TrackTriviaAchievementProgress(player, nil, "wrongAnswer")

    self.playersAnswered[playerGUID] = true
end

function TriviaSystem:FormatMoneyString(copper)
    local gold = math.floor(copper / 10000)
    local silver = math.floor((copper % 10000) / 100)
    local copperRemainder = copper % 100

    local result = {}

    if gold > 0 then
        table.insert(result, string.format("|cffffd700%d gold|r", gold))  -- Gold color
    end
    if silver > 0 then
        table.insert(result, string.format("|cffc7c7cf%d silver|r", silver))  -- Silver color
    end
    if copperRemainder > 0 or #result == 0 then
        table.insert(result, string.format("|cffeda55f%d copper|r", copperRemainder))  -- Bronze/copper color
    end

    return table.concat(result, ", ")
end

function TriviaSystem:TrackTriviaAchievementProgress(player, timeTaken, eventType)
    local playerGUID = player:GetGUIDLow()
    local correctAnswers, speedCorrectAnswers, categoryVotes, difficultyVotes, hintRequests, sessionParticipation, nightSessions, morningSessions, categoriesCorrect, minimalHintSessions, currentStreak, perfectSessionQuestions, comebackStreak = 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 0, 0, 0

    if not self.sessionParticipants[playerGUID] then
        return  -- Skip progress tracking if player didn’t participate
    end    

    local query = CharDBQuery(string.format(
        "SELECT correct_answers, speed_correct_answers, category_votes, difficulty_votes, hint_requests, session_participation, night_sessions, morning_sessions, categories_correct, minimal_hint_sessions, current_streak, perfect_session_questions, comeback_streak FROM trivia_achievement_progress WHERE player_guid = %d",
        playerGUID
    ))

    -- If no existing row, insert a new one with default values
    if not query then
        CharDBExecute(string.format(
            "INSERT INTO trivia_achievement_progress (player_guid, correct_answers, speed_correct_answers, category_votes, difficulty_votes, hint_requests, session_participation, night_sessions, morning_sessions, categories_correct, minimal_hint_sessions, current_streak, perfect_session_questions, comeback_streak) VALUES (%d, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, 0)",
            playerGUID
        ))
    else
        -- Load existing values from the database
        correctAnswers = query:GetInt32(0)
        speedCorrectAnswers = query:GetInt32(1)
        categoryVotes = query:GetInt32(2)
        difficultyVotes = query:GetInt32(3)
        hintRequests = query:GetInt32(4)
        sessionParticipation = query:GetInt32(5)
        nightSessions = query:GetInt32(6)
        morningSessions = query:GetInt32(7)
        categoriesCorrect = query:GetString(8) or ""
        minimalHintSessions = query:GetInt32(9)
        currentStreak = query:GetInt32(10)
        perfectSessionQuestions = query:GetInt32(11)
        comebackStreak = query:GetInt32(12)
    end

    -- Increment respective achievement progress based on the event type
    if eventType == "correctAnswer" then
        correctAnswers = correctAnswers + 1
        currentStreak = currentStreak + 1
        perfectSessionQuestions = perfectSessionQuestions + 1

        if timeTaken and timeTaken <= 10 then
            speedCorrectAnswers = speedCorrectAnswers + 1
        end

        if currentStreak == 25 and not player:HasAchieved(9019) then
            player:SetAchievement(9019)
        end

        if self.streakReset[playerGUID] and currentStreak >= 5 then
            player:SetAchievement(9017)
            comebackStreak = comebackStreak + 1
            self.streakReset[playerGUID] = false
        end

        if not categoriesCorrect:find(self.currentCategory) then
            categoriesCorrect = categoriesCorrect .. self.currentCategory .. ";"
        end

    elseif eventType == "wrongAnswer" then
        perfectSessionQuestions = 0
        currentStreak = 0
        self.streakReset[playerGUID] = true

        CharDBExecute(string.format(
            "UPDATE trivia_achievement_progress SET current_streak = %d, perfect_session_questions = %d WHERE player_guid = %d",
            currentStreak, perfectSessionQuestions, playerGUID
        ))

    elseif eventType == "category" then
        categoryVotes = categoryVotes + 1

    elseif eventType == "difficulty" then
        difficultyVotes = difficultyVotes + 1

    elseif eventType == "hint" then
        hintRequests = hintRequests + 1

    elseif eventType == "session" then
        sessionParticipation = sessionParticipation + 1

        CharDBExecute(string.format(
            "UPDATE trivia_achievement_progress SET session_participation = %d WHERE player_guid = %d",
            sessionParticipation, playerGUID
        ))

        -- Track session times
        local hour = tonumber(os.date("%H"))
        if hour >= 0 and hour < 6 then
            nightSessions = nightSessions + 1

            CharDBExecute(string.format(
                "UPDATE trivia_achievement_progress SET night_sessions = %d WHERE player_guid = %d",
                nightSessions, playerGUID
            ))

        elseif hour >= 6 and hour < 10 then
            morningSessions = morningSessions + 1

            CharDBExecute(string.format(
                "UPDATE trivia_achievement_progress SET morning_sessions = %d WHERE player_guid = %d",
                morningSessions, playerGUID
            ))

        end

    elseif eventType == "minimalHint" then
        minimalHintSessions = minimalHintSessions + 1

        CharDBExecute(string.format(
            "UPDATE trivia_achievement_progress SET minimal_hint_sessions = %d WHERE player_guid = %d",
            minimalHintSessions, playerGUID
        ))

        local minimalHintMilestones = {
            {count = 1, id = 9023}
        }

        for _, minimalAch in ipairs(minimalHintMilestones) do
            if minimalHintSessions >= minimalAch.count and not player:HasAchieved(minimalAch.id) then
                print("Granting minimal hint achievement")
                player:SetAchievement(minimalAch.id)
            end
        end

    elseif eventType == "perfectSession" then
        if perfectSessionQuestions == questionsPerSession and not player:HasAchieved(9016) then
            player:SetAchievement(9016)
        end
    end

    -- Update the database with the new progress
    CharDBExecute(string.format(
        "UPDATE trivia_achievement_progress SET correct_answers = %d, speed_correct_answers = %d, category_votes = %d, difficulty_votes = %d, hint_requests = %d, categories_correct = '%s', minimal_hint_sessions = %d, current_streak = %d, perfect_session_questions = %d, comeback_streak = %d WHERE player_guid = %d",
        correctAnswers, speedCorrectAnswers, categoryVotes, difficultyVotes, hintRequests, categoriesCorrect, minimalHintSessions, currentStreak, perfectSessionQuestions, comebackStreak, playerGUID
    ))
    
    local correctAnswerMilestones = {
        {count = 1, id = 9001},
        {count = 10, id = 9002},
        {count = 50, id = 9003},
        {count = 100, id = 9004},
        {count = 500, id = 9005},
        {count = 1000, id = 9006},
        {count = 2000, id = 9007}
    }

    local speedAnswerMilestones = {
        {count = 10, id = 9008},
        {count = 50, id = 9009}
    }

    local categoryVoteMilestones = {
        {count = 10, id = 9010},
        {count = 50, id = 9011}
    }

    local difficultyVoteMilestones = {
        {count = 10, id = 9012},
        {count = 50, id = 9013}
    }

    local hintMilestones = {
        {count = 10, id = 9014},
        {count = 50, id = 9015}
    }

    local sessionMilestones = {
        {count = 10, id = 9020, progress = nightSessions},
        {count = 10, id = 9021, progress = morningSessions},
        {count = 50, id = 9022, progress = sessionParticipation}
    }

    local uniqueCategories = {}
    for category in categoriesCorrect:gmatch("([^;]+)") do
        uniqueCategories[category] = true
    end

    local categoryCount = 0
    for _ in pairs(uniqueCategories) do
        categoryCount = categoryCount + 1
    end

    if categoryCount >= 10 and not player:HasAchieved(9018) then
        player:SetAchievement(9018)
        categoriesCorrect = ""  -- Clear the string after achievement is granted to optimize storage.
    end

    -- Grant achievements for correct answers
    for _, achievement in ipairs(correctAnswerMilestones) do
        if correctAnswers >= achievement.count and not player:HasAchieved(achievement.id) then
            player:SetAchievement(achievement.id)
        end
    end

    -- Grant achievements for speed answers
    for _, speedAch in ipairs(speedAnswerMilestones) do
        if speedCorrectAnswers >= speedAch.count and not player:HasAchieved(speedAch.id) then
            player:SetAchievement(speedAch.id)
        end
    end

    -- Grant achievements for category votes
    for _, categoryAch in ipairs(categoryVoteMilestones) do
        if categoryVotes >= categoryAch.count and not player:HasAchieved(categoryAch.id) then
            player:SetAchievement(categoryAch.id)
        end
    end

    -- Grant achievements for difficulty votes
    for _, difficultyAch in ipairs(difficultyVoteMilestones) do
        if difficultyVotes >= difficultyAch.count and not player:HasAchieved(difficultyAch.id) then
            player:SetAchievement(difficultyAch.id)
        end
    end

    -- Grant achievements for hint requests
    for _, hintAch in ipairs(hintMilestones) do
        if hintRequests >= hintAch.count and not player:HasAchieved(hintAch.id) then
            player:SetAchievement(hintAch.id)
        end
    end

    -- Grant session-based achievements
    for _, sessionAch in ipairs(sessionMilestones) do
        if sessionAch.progress >= sessionAch.count and not player:HasAchieved(sessionAch.id) then
            player:SetAchievement(sessionAch.id)
        end
    end
end


-- Handle the chat commands for players to answer the question, vote, and view the leaderboard
RegisterPlayerEvent(18, function(event, player, msg, Type, lang)
    local command, arg = msg:lower():match("^(#%w+)%s*(.*)")
    local playerGUID = player:GetGUIDLow()

    CreateLuaEvent(function()
        local delayedPlayer = GetPlayerByGUID(playerGUID) -- Need to retrieve the playerGUID again due to the CreateLuaEvent delay so it doesn't become invalidated
        if not delayedPlayer then return end

        if command == "#hint" then
            TriviaSystem:ProvideHint(delayedPlayer)

        elseif command == "#vote" then
            if arg and arg ~= "" then
                TriviaSystem:HandleVote(delayedPlayer, arg)
            else
                delayedPlayer:SendBroadcastMessage("|cffe522e5Trivia:|r Please vote using '#vote easy', '#vote medium', or '#vote hard'.")
            end

        elseif command == "#answer" or command == "#ans" then
            if arg and arg ~= "" then
                TriviaSystem:CheckAnswer(delayedPlayer, arg)
            else
                delayedPlayer:SendBroadcastMessage("|cffe522e5Trivia:|r Please provide an answer using '#answer <your_answer>'.")
            end

        elseif command == "#leaderboard" then
            TriviaSystem:ShowLeaderboardUI(delayedPlayer)

        elseif command == "#trivia" then
            TriviaSystem:ShowAvailableCommands(delayedPlayer)

        elseif command == "#mystats" then
            TriviaSystem:ShowPlayerStats(delayedPlayer)        
        end
    end, 50, 1)  -- Slight delay of 50 milliseconds before processing the command to ensure the in-game chat message is displayed first
end)

-- Gossip UI to display leaderboard to the player
function TriviaSystem:ShowLeaderboardUI(player)
    local leaderboardQuery = "SELECT name, points, streak FROM trivia_leaderboard ORDER BY points DESC LIMIT 10"
    local query = CharDBQuery(leaderboardQuery)
    
    if query then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "=== Trivia Leaderboard ===", 1, 1)
        local rank = 1
        repeat
            local name = query:GetString(0)
            local points = query:GetInt32(1)
            local streak = query:GetInt32(2)

            -- Highlight the top player in gold, second in silver, and third in bronze
            if rank == 1 then
                player:GossipMenuAddItem(0, string.format("|cffFFD700%d. %s: %d points, Streak: %d|r", rank, name, points, streak), 1, rank + 1)
            elseif rank == 2 then
                player:GossipMenuAddItem(0, string.format("|cffC0C0C0%d. %s: %d points, Streak: %d|r", rank, name, points, streak), 1, rank + 1)
            elseif rank == 3 then
                player:GossipMenuAddItem(0, string.format("|cffCD7F32%d. %s: %d points, Streak: %d|r", rank, name, points, streak), 1, rank + 1)
            else
                player:GossipMenuAddItem(0, string.format("%d. %s: %d points, Streak: %d", rank, name, points, streak), 1, rank + 1)
            end

            rank = rank + 1
        until not query:NextRow()
        
        player:GossipSendMenu(1, player, 1)
    else
        player:SendBroadcastMessage("|cffe522e5Trivia:|r Trivia Leaderboard is currently empty.")
    end
end

function TriviaSystem:ShowPlayerStats(player)
    local playerGUID = player:GetGUIDLow()
    local query = CharDBQuery(string.format(
        "SELECT correct_answers, speed_correct_answers, session_participation, night_sessions, morning_sessions, current_streak, hint_requests, category_votes, difficulty_votes FROM trivia_achievement_progress WHERE player_guid = %d",
        playerGUID
    ))

    if query then
        local correctAnswers = query:GetInt32(0)
        local speedAnswers = query:GetInt32(1)
        local sessions = query:GetInt32(2)
        local nightSessions = query:GetInt32(3)
        local morningSessions = query:GetInt32(4)
        local currentStreak = query:GetInt32(5)
        local hintsRequested = query:GetInt32(6)
        local categoryVotes = query:GetInt32(7)
        local difficultyVotes = query:GetInt32(8)

        player:SendBroadcastMessage(string.format(
            "|cffe522e5=== Your Trivia Stats ===|r\n" ..
            "|cffffd700- Correct Answers:|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Speed Answers (<10s):|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Total Sessions Participated:|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Night Sessions:|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Morning Sessions:|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Current Streak:|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Hints Requested:|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Category Votes:|r  |cff00ff00%d|r\n" ..
            "|cffffd700- Difficulty Votes:|r  |cff00ff00%d|r",

            correctAnswers, speedAnswers, sessions, nightSessions, morningSessions, currentStreak, hintsRequested, categoryVotes, difficultyVotes
        ))
        player:SendBroadcastMessage(" ")
    else
        player:SendBroadcastMessage("|cffe522e5Trivia:|r You don't have any available stats yet.")
    end
end

function TriviaSystem:ShowAvailableCommands(player)
    local message = [[
    |cffe522e5=== Available Trivia Commands ===|r
    |cfff99b09Participate in trivia, earn points, and climb the leaderboard!|r
        1. |cff00ff00#hint|r - Request a hint for the current trivia question. Each hint will reduce the amount of points you earn.
        2. |cff00ff00#answer <your_answer>|r - Submit your answer to the current trivia question.
        3. |cff00ff00#vote <difficulty>|r - Vote for the difficulty of the next question. Options: easy, medium, hard.
        4. |cff00ff00#vote <category>|r - Vote for the category of the next question. Options: boss, city, class, dungeon, event, faction, items, lore, mounts, pets, professions, quests, race, raid, zone.
        5. |cff00ff00#leaderboard|r - View the top players on the trivia leaderboard for the most recent session.  This will be reset at the start of each new trivia session.
        6. |cff00ff00#trivia|r - View this list of available Trivia commands.
        7. |cff00ff00#mystats|r - View your personal statistics and accomplishments.
    ]]

    player:SendBroadcastMessage(message)
end


-- Schedule Trivia Events
TriviaSystem:ScheduleNextTriviaEvent()


-- ############################################################################################
-- TITLES AND RELATED ACHIEVEMENTS

-- Titles:
-- [194],  -- %s, the Lightning Mind (ach 9008)
-- [195],  -- %s, the Master of Momentum (ach 9009)
-- [196],  -- %s, the Grandmaster of Trivia (ach 9005)
-- [197],  -- %s, the Blazing Mind (ach 9002)
-- [198],  -- %s, the Eternal Scholar (ach 9007)
-- [199],  -- %s, the Curious Thinker (ach 9003)
-- [200],  -- %s, the Quizzer (ach 9001)
-- [202],  -- %s, the Trivia Legend (ach 9006)
-- [203],  -- %s, the All-Knowing (ach 9004)
-- [204],  -- %s, the Hint Hunter (ach 9014)
-- [205],  -- %s, the Hint Whisperer (ach 9015)
-- [206],  -- Perfectionist %s (ach 9016)
-- [207],  -- Comeback King %s (ach 9017)
-- [208],  -- %s, the Jack of All Categories (ach 9018)
-- [209],  -- %s, the Unstoppable Genius (ach 9019)
-- [210],  -- %s, the Night Owl (ach 9020)
-- [211],  -- %s, the Early Bird (ach 9021)
-- [212],  -- Trivia Marathoner %s (ach 9022)
-- [213],  -- %s, the Minimalist (ach 9023)


-- Achievements:
-- [9001]
--      Title: First of Many
--      Description: You’ve taken your first step into the world of trivia by answering your first question correctly!

-- [9002]
--      Title: Trivia Apprentice
--      Description: You’re getting the hang of this! Keep going—you’ve answered 10 questions correctly!

-- [9003]
--      Title: Trivia Enthusiast
--      Description: Your knowledge is growing! You've answered 50 questions correctly. Time to aim even higher!

-- [9004]
--      Title: Trivia Master
--      Description: You’ve mastered the basics and are on your way to becoming a trivia champion. 100 questions answered correctly!

-- [9005]
--      Title: Grandmaster of Knowledge
--      Description: Your brain must be massive! 500 trivia questions answered correctly. A true fountain of knowledge.

-- [9006]
--      Title: The Trivia Legend
--      Description: Legends are made, not born. By answering 1000 questions correctly, you’ve cemented your place in trivia history.

-- [9007]
--      Title: The Eternal Scholar
--      Description: Knowledge knows no bounds. Answering 2000 trivia questions correctly proves you are a true eternal seeker of knowledge.

-- [9008]
--      Title: Lightning Reflexes
--      Description: You’ve proven your quick thinking by correctly answering 10 questions within 10 seconds.

-- [9009]
--      Title: Master of Speed
--      Description: With lightning-fast reactions, you’ve answered 50 questions correctly within 10 seconds.

-- [9010]
--      Title: Voting Specialist (Categories)
--      Description: Vote for a question category 10 times.

-- [9011]
--      Title: Category Expert
--      Description: Vote for a question category 50 times.

-- [9012]
--      Title: Voting Specialist (Difficulties)
--      Description: Vote for a question difficulty 10 times.

-- [9013]
--      Title: Difficulty Strategist
--      Description: Vote for a question difficulty 50 times.

-- [9014]
--      Title: Hint Seeker
--      Description: Request hints 10 times during trivia sessions.

-- [9015]
--      Title: Hint Master
--      Description: Master the art of deduction by requesting 50 hints.

-- [9016]
--      Title: Perfectionist
--      Description: Answer all questions correctly in a single trivia session.

-- [9017]
--      Title: Comeback King
--      Description: Achieve a streak of 5 or more correct answers after a streak reset.

-- [9018]
--      Title: Diverse Knowledge
--      Description: Correctly answer at least one question from 10 different categories.

-- [9019]
--      Title: Legendary Streak
--      Description: Achieve a streak of 25 correct answers in a row across sessions.

-- [9020]
--      Title: Night Owl
--      Description: Participate in 10 trivia sessions between midnight and 6 AM.

-- [9021]
--      Title: Early Bird
--      Description: Participate in 10 trivia sessions between 6 AM and 10 AM.

-- [9022]
--      Title: Trivia Marathon
--      Description: Participate in 50 trivia sessions.

-- [9023]
--      Title: Minimalist
--      Description: Achieve 1st place in a trivia session without using any hints.