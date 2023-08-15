--[==[
    NOTE: need to insert character_rules.sql in your characters database
]==]

-- Include sc_default
require "base/sc_default"


local RulesSystem = {}

-- Rules Settings
RulesSystem.Settings = {
    Name = "|cffff0000[Rules System]|r",
    Cooldown = 30,
    Spell = 9454,
};

-- Rules Texts
RulesSystem.Texts = {
    [0] = "|CFFFF0303Server Rules!|r",
    [1] = "|CFFFFFF01Welcome on CoronaCore Server|r",
    [2] = "TEXT TEXT TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT",
    [3] = "|CFFFF0303Server Infos!|r",
    [4] = "TEXT TEXT TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT",
    [5] = "|CFFFFFF01http://your-server.com|r",
};

-- Commands for Rules
RulesSystem.Commands = {
    [0] = "#rules",                                                     -- Show rules
    [1] = "#rules reset",                                               -- Reset Rules for all Player (Only GameMaster can use it)
    [2] = "#rules send all",                                            -- Send Rules Window to all Online Players
    [3] = "#rules send player",                                         -- Send Rules Window to player %s
};

if (RulesSystem.Commands[3]:sub(-1) ~= " ") then
    RulesSystem.Commands[3] = RulesSystem.Commands[3].." ";
end

function RulesSystem.OnChat(event, player, msg, _, lang)                -- Use "#rules" for sending rules
    if (msg == RulesSystem.Commands[0]) then
        RulesSystem.OnGossipHello(event, player)
        return false;
    elseif (msg == RulesSystem.Commands[1]) and player:IsGM() == true then
        CharDBQuery("UPDATE character_rules SET active = 1")
        player:SendBroadcastMessage(string.format("%s Rules update please accept again!", RulesSystem.Settings.Name))
        return false;
    elseif (msg == RulesSystem.Commands[2]) and player:IsGM() == true then
        for _, p in ipairs(GetPlayersInWorld()) do
            RulesSystem.OnGossipHello(event, p)
        end
        return false;
    elseif (msg:sub(1, RulesSystem.Commands[3]:len()) == RulesSystem.Commands[3]) and player:IsGM() == true then
        if GetPlayerByName(msg:sub(RulesSystem.Commands[3]:len()+1)) then
            RulesSystem.OnGossipHello(event, GetPlayerByName(msg:sub(RulesSystem.Commands[3]:len()+1)))
        else
            player:SendBroadcastMessage(string.format("%s No player found with name %s", RulesSystem.Settings.Name, msg:sub(RulesSystem.Commands[3]:len()+1)))
        end
        return false;
    end
end

function RulesSystem.OnCharCreate(event, player)                         -- Insert guid into character_rules on new character create
    CharDBQuery(string.format("INSERT INTO character_rules (`guid`) VALUES (%s)", player:GetGUIDLow()))
end

function RulesSystem.OnCharDelete(event, player)                         -- Delete guid from character_rules on character delete
    CharDBQuery(string.format("DELETE FROM character_rules WHERE guid = (%s)", player))
end

function RulesSystem.OnLogin(event, player)
    local RulesActive = CharDBQuery(string.format("SELECT * FROM character_rules WHERE active = 1 and guid = (%s)", player:GetGUIDLow()))
    local PlayerName = player:GetName()

    if RulesActive then                                                   -- Check Rules Active on Login
        player:AddAura(RulesSystem.Settings.Spell, player)                -- AddAura frozen to Player
        player:PlayDirectSound(1509, player)
        player:SendBroadcastMessage(string.format("%s Welcome %s please read the rules and accept it, use #rules to watch the rules again!", RulesSystem.Settings.Name, PlayerName, RulesCommand))
        player:SetLuaCooldown(RulesSystem.Settings.Cooldown, 2)
        player:RegisterEvent(RulesSystem.CooldownCheck, 1000, player:GetLuaCooldown(2))
    end
end

function RulesSystem.OnGossipHello(event, player)                          -- Show Rules
    player:GossipClearMenu()
    player:GossipMenuAddItem(4, "", 0, 1, false, string.format("%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n", RulesSystem.Texts[0], RulesSystem.Texts[1], RulesSystem.Texts[2], RulesSystem.Texts[3], RulesSystem.Texts[4], RulesSystem.Texts[5], RulesSystem.Texts[5]))
    player:GossipSendMenu(0x7FFFFFFF, player, 100)
end
 
function RulesSystem.OnGossipSelect(event, player, _, sender, intid, code)
    local PlayerName = player:GetName()

    if (intid == 1) and player:GetLuaCooldown(2) == 0 then
        player:RemoveAura(RulesSystem.Settings.Spell)                      -- Remove Aura
        CharDBQuery(string.format("UPDATE character_rules SET active = 0 WHERE guid = (%s)", player:GetGUIDLow()))
        player:SendBroadcastMessage(string.format("%s Thank you %s that they have read the rules and accepted!", RulesSystem.Settings.Name, PlayerName))
        player:PlayDirectSound(888, player)
        player:GossipComplete()                                            -- Close the Gossip
    end
end

function RulesSystem.CooldownCheck(event, delay, repeats, player)
    local PlayerName = player:GetName()

    if player:GetLuaCooldown(2) > 0 then
        player:GossipClearMenu()
        player:GossipMenuAddItem(4, "", 0, 1, false, string.format("%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n|cffff0000You can accept in |CFFFFFF01%s|r |cffff0000seconds|r\n\n", RulesSystem.Texts[0], RulesSystem.Texts[1], RulesSystem.Texts[2], RulesSystem.Texts[3], RulesSystem.Texts[4], RulesSystem.Texts[5], math.ceil(player:GetLuaCooldown(2))))
        player:GossipSendMenu(0x7FFFFFFF, player, 100)
    else
        RulesSystem.OnGossipHello(event, player)
        player:PlayDirectSound(1150, player)
        player:RemoveEvents()
    end
end

RegisterPlayerEvent(1, RulesSystem.OnCharCreate)                            -- Register Evenet On Character Create
RegisterPlayerEvent(2, RulesSystem.OnCharDelete)                            -- Register Evenet On Character Create
RegisterPlayerEvent(3, RulesSystem.OnLogin)                                 -- Register Event On Login
RegisterPlayerGossipEvent(100, 2, RulesSystem.OnGossipSelect)               -- Register Event for Gossip Select
RegisterPlayerEvent(18, RulesSystem.OnChat)                                 -- Register Evenet on Chat Command use
