-- -----------------------------------------------------------------------------------
-- Trivia System CONFIG 
--
-- Hosted by Aldori on Github: https://github.com/Aldori15/azerothcore-trivia-system
-- -----------------------------------------------------------------------------------

local ENABLE_TRIVIA_SYSTEM = false

local questionInterval = 600  -- How often (in seconds) to send Trivia Questions
local questionDuration = 25   -- How long (in seconds) to answer the question before time is up
local questionAlertTime = 15  -- How many seconds before the question to alert the user of an upcoming question

local rewardItem = 37711      -- Reward Points Currency

local chatCommands = { "#answer", "#trivia" }

-- -- -------------------------------------------------------------------------------
-- END CONFIG
-- -- -------------------------------------------------------------------------------

if not ENABLE_TRIVIA_SYSTEM then return end

-- Ensures the TriviaQuestions file is loaded
local triviaQuestionsFile = require("TriviaQuestions")
-- Access the list of triviaQuestions
local triviaQuestions = triviaQuestionsFile.triviaQuestions

TriviaSystem = {
    activeQuestion = nil,
    activeAnswer = nil,
    activePoints = 0,
    questionTimer = nil,
    questionAlertTimer = nil
}

-- Set a timer to ask trivia questions after questionInterval seconds
CreateLuaEvent(function() TriviaSystem:AlertQuestion() end, questionInterval * 1000, 0)

-- Function to alert the user about an upcoming trivia question
function TriviaSystem:AlertQuestion()
    SendWorldMessage("|cffe522e5Trivia:|r |cfff99b09A trivia question is coming up in " .. questionAlertTime .. " seconds!  Get ready to type " .. chatCommands[1] .. " or " .. chatCommands[2] .. " to submit your answer.|r")
    
    -- Set a timer to ask the question after questionAlertTime seconds
    self.questionAlertTimer = CreateLuaEvent(function() self:AskQuestion() end, questionAlertTime * 1000, 1)
end

-- Function to ask a random trivia question
function TriviaSystem:AskQuestion()
    local questionIndex = math.random(1, #triviaQuestions)
    local trivia = triviaQuestions[questionIndex]
    
    self.activeQuestion = trivia.question
    self.activeAnswer = trivia.answer
    self.activePoints = trivia.points
    
    SendWorldMessage("|cffe522e5Trivia:|r " .. self.activeQuestion)
    
    -- Set a timer to expire the question after questionDuration seconds
    self.questionTimer = CreateLuaEvent(function() self:ExpireQuestion() end, questionDuration * 1000, 1)
end

-- Function to expire the active question
function TriviaSystem:ExpireQuestion()
    if self.activeQuestion then
        SendWorldMessage("|cffe522e5Trivia:|r |cff22e522Time's up! The correct answer was: " .. self.activeAnswer[1] .. "|r")
        self.activeQuestion = nil
        self.activeAnswer = nil
        self.activePoints = 0
        self.questionTimer = nil
    end
end

-- Function to check the player's answer
function TriviaSystem:CheckAnswer(player, answer)
    if self.activeQuestion == nil then
        player:SendBroadcastMessage("|cffe522e5Trivia:|r |cff00ff00No active trivia question.|r")
        return
    end

    for _, validAnswer in ipairs(self.activeAnswer) do
        if string.lower(answer) == string.lower(validAnswer) then
            player:AddItem(rewardItem, self.activePoints)
            player:SendBroadcastMessage("|cffe522e5Trivia:|r |cff00ff00Correct! You've been awarded " .. self.activePoints .. " points.|r")
            
            -- Cancel the question timer
            if self.questionTimer then
                RemoveEventById(self.questionTimer)
                self.questionTimer = nil
            end

            self.activeQuestion = nil
            self.activeAnswer = nil
            self.activePoints = 0
            return -- Exit the function once a correct answer is found
        end
    end

    player:SendBroadcastMessage("|cffe522e5Trivia:|r |cff00ff00Incorrect answer. Try again!|r")
end

-- Register the chat commands for players to answer the question
RegisterPlayerEvent(18, function(event, player, msg, Type, lang)
    for _, command in ipairs(chatCommands) do
        if msg:lower():sub(1, #command) == command then
            local spaceIndex = msg:find(" ")
            if spaceIndex then
                local answer = msg:sub(spaceIndex + 1)
                TriviaSystem:CheckAnswer(player, answer)
            else
                -- Optionally send a message or just do nothing
                player:SendBroadcastMessage("|cffe522e5Trivia:|r |cff00ff00Please provide an answer after the command.|r")
            end
            return
        end
    end
end)
