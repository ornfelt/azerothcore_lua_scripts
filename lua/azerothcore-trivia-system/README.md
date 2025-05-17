# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

# Trivia System Using Eluna
This Trivia System is designed for Azerothcore using Eluna where players can participate by typing "#answer" or "#ans", followed by the answer.  Example: "#ans this is my answer".

**Example of a question being asked, but nobody answers correctly in time:**
![QuestionExpired](https://github.com/user-attachments/assets/fc15239c-e467-4bb8-816f-a82dc503dd7e)

**Example of a question being asked and the player answers correctly:**
![CorrectResponse](https://github.com/user-attachments/assets/3d0bc4ae-57e8-4463-86fa-6951c8dc36c9)

**Players can vote for the next question's difficulty and category.  Majority vote wins.  If no votes are placed for either difficulty or category, then the system will pick at random:**
![Votes](https://github.com/user-attachments/assets/5a8ee379-fde5-4fad-8108-189abc131658)

**Type "#trivia" in-game to see a full list of useable Trivia commands:**
![AvailableCommands](https://github.com/user-attachments/assets/0f4f08c4-2246-4914-a879-d2952b98329d)

**23 brand new achievements made specifically for Trivia, along with some titles that can also be earned:**
![Achievements](https://github.com/user-attachments/assets/189d39d5-1695-4072-9c0d-871c90d373e6)


## Configuration

The script is easily configurable with simple variables:

```lua
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
```

## Setup / Installation
- Run the `"trivia.sql"` file on your database to create the necessary database tables.
- Copy the `"Achievement.dbc"`, `"Achievement_Category.dbc"` and `"CharTitles.dbc"` files to the `Data > dbc` folder on your server.
- Also copy the same `"Achievement.dbc"`, `"Achievement_Category.dbc"` and `"CharTitles.dbc"` files to the `DBFilesClient` folder inside your client's MPQ patch.
- Copy the `"Trivia.lua"` file into the lua_scripts folder on your server.
- Open `"Trivia.lua"` and adjust the config to your liking.
- Start up the server.
