--[[
    Discord Notifier for AzerothCore & ElunaEngine
    Created by: 0xCiBeR(https://github.com/0xCiBeR)
]]--

--[[

    Config Flags Section -> EDIT TO YOUR LIKING!!

]]--

Config = {}
Config.hooks = {}
Config.eventOn = {}
-- By default, users are notified if any of the events are sent to Discord. Do you really want to disable this?
Config.privacyWarning = true 

-- This is the global Discord Webhook to use if other specific Webhooks are not defined. IMPORTANT: Must always be defined since its used as fallback
Config.hooks.globalWebook = "https://discord.com/api/webhooks/............."
-- Webhook to send OnChat events
Config.hooks.PLAYER_EVENT_ON_CHAT = nil
-- Webhook to send OnWhisperChat events
Config.hooks.PLAYER_EVENT_ON_WHISPER = nil
-- Webhook to send OnGroupChat events
Config.hooks.PLAYER_EVENT_ON_GROUP_CHAT = nil
-- Webhook to send OnGuildChat events
Config.hooks.PLAYER_EVENT_ON_GUILD_CHAT = nil

-- Feature Flag for enabiling each event
Config.eventOn.PLAYER_EVENT_ON_CHAT = true
Config.eventOn.PLAYER_EVENT_ON_WHISPER = true
Config.eventOn.PLAYER_EVENT_ON_GROUP_CHAT = true
Config.eventOn.PLAYER_EVENT_ON_GUILD_CHAT = true

--[[

    Event Mappings Section -- DO NOT TOUCH!!

]]--

local PLAYER_EVENT_ON_CHAT = 18
local PLAYER_EVENT_ON_WHISPER = 19
local PLAYER_EVENT_ON_GROUP_CHAT = 20
local PLAYER_EVENT_ON_GUILD_CHAT = 21

-- Misc
local PLAYER_EVENT_ON_LOGIN = 3

--[[

    Utility Function Section -- DO NOT TOUCH!!

]]--

local function sendToDiscord(event, msg)
    if msg and event then
        local webhook = Config.hooks[event] or Config.hooks.globalWebook
        HttpRequest("POST", webhook, '{"content": "'..msg..'"}', "application/json", 
        function(status, body, headers)
            if status ~= 200 then
                print("DiscordNotifier[Lua] Error when sending webhook to discord. Response body is: "..body)
            end
        end)
    end
end

--[[

    Events Section -- DO NOT TOUCH!!

]]--

-- OnChat
local function OnChat(event, player, msg, Type, lang)
    if Config.eventOn.PLAYER_EVENT_ON_CHAT then
        local name = player:GetName()
        local guid = player:GetGUIDLow()
        sendToDiscord("PLAYER_EVENT_ON_CHAT", '__CHAT__ -> **|'..guid..'| '..name..'**: '..msg)
    end
end

-- OnWhisperChat
local function OnWhisperChat(event, player, msg, Type, lang, receiver)
    if Config.eventOn.PLAYER_EVENT_ON_WHISPER then
        local sName = player:GetName()
        local sGuid = player:GetGUIDLow()
        local rName = receiver:GetName()
        local rGuid = receiver:GetGUIDLow()
        sendToDiscord("PLAYER_EVENT_ON_WHISPER", '__WHISPER__ -> **|'..sGuid..'| '..sName..' -> |'..rGuid..'| '..rName..'**: '..msg)
    end
end

-- OnGroupChat
local function OnGroupChat(event, player, msg, Type, lang, group)
    local name = player:GetName()
    local guid = player:GetGUIDLow()
    local leaderGuid = group:GetLeaderGUID()
    local leader = GetPlayerByGUID(leaderGuid)
    local lName = leader:GetName()
    local lGuidLow = leader:GetGUIDLow()
    sendToDiscord("PLAYER_EVENT_ON_GROUP_CHAT", '__GROUP CHAT__ -> **|'..guid..'| '..name..'**: '..msg..' **[LEADER -> '..lName..'('..lGuidLow..')]**')
end


-- OnGuildChat
local function OnGuildChat(event, player, msg, Type, lang, guild)
    local name = player:GetName()
    local guid = player:GetGUIDLow()
    local gName = guild:GetName()
    local gId = guild:GetId()
    sendToDiscord("PLAYER_EVENT_ON_GUILD_CHAT", '__GUILD__ -> **[ |'..gId..'| -> '..gName..'] |'..guid..'| '..name..'**: '..msg)
end

--[[

    Register Events Section -- DO NOT TOUCH!!

]]--
-- OnChat
RegisterPlayerEvent(PLAYER_EVENT_ON_CHAT, OnChat)
-- OnWhisperChat
RegisterPlayerEvent(PLAYER_EVENT_ON_WHISPER, OnWhisperChat)
-- OnGroupChat
RegisterPlayerEvent(PLAYER_EVENT_ON_GROUP_CHAT, OnGroupChat)
-- OnGuildChat
RegisterPlayerEvent(PLAYER_EVENT_ON_GUILD_CHAT, OnGuildChat)


--[[

    MISC -- DO NOT TOUCH!!

]]--

local function privacyAlert(event, player)
    if Config.privacyWarning then
        for i, v in pairs(Config.eventOn) do
            if v == true then
                player:SendBroadcastMessage("|cff00ff00[PRIVACY NOTICE] |cffff0000THIS SERVER IS CURRENTLY MONITORING AND FORWARDING TEXT MESSAGES SENT WITHIN THE SERVER TO DISCORD.")
                break
            end
        end
    end
end
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, privacyAlert)
