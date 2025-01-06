# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

# Trivia System Using Eluna
This script is designed for Azerothcore using Eluna to send trivia questions that the player can answer by typing "#answer" or "#trivia", followed by their answer.  Example: "#trivia this is my answer".

[![TriviaNoResponse.png](https://i.postimg.cc/JhHgxf96/Screenshot-2024-06-17-163826.png)](https://postimg.cc/bG83NBYk)

[![TriviaCorrectResponse.png](https://i.postimg.cc/Pq8XDFKh/trivia2.png)](https://postimg.cc/PLTnsyBF)

## Configuration

The script is easily configurable with simple variables:

```lua
local ENABLE_TRIVIA_SYSTEM = false

local questionInterval = 600  -- How often (in seconds) to send Trivia Questions
local questionDuration = 25   -- How long (in seconds) to answer the question before time is up
local questionAlertTime = 15  -- How many seconds before the question to alert the user of an upcoming question

local rewardItem = 37711      -- This is the Item ID to add to the player when answering correctly

local chatCommands = { "#answer", "#trivia" }
```

## Setup / Installation
- Copy the "TriviaSystem" folder into the lua_scripts folder on your server.  Ensure that both "TriviaSystem.lua" and "TriviaQuestions.lua" files are in the same folder location.
- Open "TriviaSystem.lua" and adjust the config to your liking.
- Start up the server.
