--Copyright (C) 2022  https://github.com/55Honey
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU Affero General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU Affero General Public License for more details.
--
--You should have received a copy of the GNU Affero General Public License
--along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--
--
--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 10/08/2022
-- Time: 16:07
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module


--[[ This script starts a hide and seek event. It announces what and where the players need to look for
    and posts hints in the chat after a while.
--]]

-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in hideAndSeekConf.lua
--               -  minimum conf per event:
--                  - haS.Conf = {
--                      Entry[id],
--                      X[id],
--                      Y[id],
--                      Z[id],
--                      O[id],
--                      MapId[id],
--                      Scale[id],
--                      Hint[id][n],
--                      HintDelay[id][n]
--                      }
--               -  add this script to ../lua_scripts/
------------------------------------------------------------------------------------------------
-- GM GUIDE:     -  start a hide and seek event by typing '.hideandseek $id'. $id is random without a value given.
--               -  stop a hide and seek event by typing '.hideandseek stop'. Or wait until it's over.
------------------------------------------------------------------------------------------------
local GOSSIP_EVENT_ON_HELLO = 1     -- (event, player, object) - Object is the Creature/GameObject/Item. Can return false to do default action. For item gossip can return false to stop spell casting.
local ELUNA_EVENT_ON_LUA_STATE_CLOSE = 16
local PLAYER_EVENT_ON_COMMAND = 42  -- (event, player, command, chatHandler) - player is nil if command used from console. Can return false

haS = {}
haS.Conf = {
    Entry = {},
    X = {},
    Y = {},
    Z = {},
    O = {},
    MapId = {},
    Scale = {},
    Hint = {},
    HintDelay = {},
    CopperReward = {},
    ItemReward = {}
}

-- default conf for non-prepared hide-and-seek events
haS.Conf.Entry[0] = 611001
haS.Conf.CopperReward[0] = nil
haS.Conf.ItemReward[0] = 34425  -- Clockwork Rocket Bot

require "hideAndSeekConf"

function haS.SplitString(inputstr, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..seperator.."]+)") do
        table.insert(t, str)
    end
    return t
end

haS.fireworkspells = {}
haS.fireworkspells[1] = 66400
haS.fireworkspells[2] = 66402
haS.fireworkspells[3] = 46847
haS.fireworkspells[4] = 46829
haS.fireworkspells[5] = 46830
haS.fireworkspells[6] = 62074
haS.fireworkspells[7] = 62075
haS.fireworkspells[8] = 62077
haS.fireworkspells[9] = 55420

function haS.Fireworks( _, _, _, worldobject )
    worldobject:CastSpell( player, haS.fireworkspells[ math.random(1, #haS.fireworkspells) ] )
end

function haS.OnHello( _, player, _ )
    if haS.ActiveId == nil then
        return
    end

    if haS.Conf.CopperReward[haS.ActiveId] ~= nil and haS.Conf.ItemReward[haS.ActiveId] ~= nil then
        SendMail( 'Winner of the Hide and Seek Event', 'Congratulations, you\'ve won a fabulous prize!', player:GetGUIDLow(), 0, 61, 5, haS.Conf.CopperReward[haS.ActiveId], 0, haS.Conf.ItemReward[ haS.ActiveId ], 1 )
    elseif haS.Conf.CopperReward[haS.ActiveId] ~= nil and haS.Conf.ItemReward[haS.ActiveId] == nil then
        SendMail( 'Winner of the Hide and Seek Event', 'Congratulations, you\'ve won a fabulous prize!', player:GetGUIDLow(), 0, 61, 5, haS.Conf.CopperReward[haS.ActiveId], 0 )
    elseif haS.Conf.CopperReward[haS.ActiveId] == nil and haS.Conf.ItemReward[haS.ActiveId] ~= nil then
        SendMail( 'Winner of the Hide and Seek Event', 'Congratulations, you\'ve won a fabulous prize!', player:GetGUIDLow(), 0, 61, 5, 0, 0, haS.Conf.ItemReward[ haS.ActiveId ], 1 )
    end

    player:RegisterEvent( haS.Fireworks, 500, 40)

    player:GossipComplete()
    haS.AnnounceWinner( player )
    haS.StopEvent()
end

function haS.SendHints( _, _, _ )
    if haS.ActiveId == nil then
        return
    end

    haS.CurrentHint = haS.CurrentHint + 1
    if #haS.Conf.Hint[haS.ActiveId] < haS.CurrentHint then
        SendWorldMessage( 'Unfortunately, nobody was able to find the target of the Hide and Seek in time. Better luck next time!' )
        haS.StopEvent()
    else
        SendWorldMessage( haS.Conf.Hint[haS.ActiveId][haS.CurrentHint] )
        local delay = haS.Conf.HintDelay[haS.ActiveId][haS.CurrentHint] * 1000
        CreateLuaEvent( haS.SendHints, delay, 1 )
    end
end

function haS.AnnounceWinner( player )
    SendWorldMessage( 'Congratulations, ' .. player:GetName() .. '! You\'ve won the Hide and Seek Event!' )
end

function haS.StartEvent( Id, player )
    if Id == 0 then
        if player == nil then
            chatHandler:SendSysMessage( 'Id 0 requires a character to choose coordinates from. You can\'t use this from the console.')
            return false
        end

        local Object = PerformIngameSpawn( 2, haS.Conf.Entry[0], player:GetMapId(), 0, player:GetX(), player:GetY(), player:GetZ(), player:GetO() )
        haS.ObjectGuid = Object:GetGUID()
        haS.ActiveMapId = player:GetMapId()

        RegisterGameObjectGossipEvent( haS.Conf.Entry[0], GOSSIP_EVENT_ON_HELLO, haS.OnHello )
        haS.ActiveId = 0
        haS.CurrentHint = 0

        return true

    elseif haS.Conf.Entry[Id] ~= nil and
            haS.Conf.X[Id] ~= nil and
            haS.Conf.Entry[Id] ~= nil and
            haS.Conf.Y[Id] ~= nil and
            haS.Conf.Z[Id] ~= nil and
            haS.Conf.O[Id] ~= nil and
            haS.Conf.MapId[Id] ~= nil and
            haS.Conf.Scale[Id] ~= nil and
            haS.Conf.Hint[Id][1] ~= nil and
            haS.Conf.HintDelay[Id][1] ~= nil then
        local Object = PerformIngameSpawn(2, haS.Conf.Entry[Id], haS.Conf.MapId[Id], 0, haS.Conf.X[Id], haS.Conf.Y[Id], haS.Conf.Z[Id], haS.Conf.O[Id])
        haS.ObjectGuid = Object:GetGUID()
        if Object then
            Object:SetScale( haS.Conf.Scale[Id] )
        end

        RegisterGameObjectGossipEvent( haS.Conf.Entry[Id], GOSSIP_EVENT_ON_HELLO, haS.OnHello )
        haS.ActiveId = Id
        haS.CurrentHint = 0

        haS.SendHints()

        return true
    end
    return false
end

function haS.StopEvent()

    if haS.ObjectGuid ~= nil then
        local map

        if haS.ActiveId == nil then
            return
        end

        if haS.ActiveId == 0 then
            map = GetMapById(haS.ActiveMapId)
        else
            map = GetMapById( haS.Conf.MapId[ haS.ActiveId ] )
        end

        local Object = map:GetWorldObject( haS.ObjectGuid )
        if haS.ObjectGuid ~= nil then
            Object:RemoveFromWorld(false)
            haS.ObjectGuid = nil
        end
    end
    haS.ActiveId = nil

end

function haS.OnCommand(_, player, command, chatHandler)
    local commandArray = {}

    --prevent players from using this, GM rank 2 is required.
    if not chatHandler:IsAvailable( 2 ) then
        return
    end

    -- split the command variable into several strings which can be compared individually
    commandArray = haS.SplitString(command)

    if commandArray[1] ~= 'hideandseek' then
        return
    end

    if commandArray[2] ~= nil then
        commandArray[2] = commandArray[2]:gsub("[';\\, ]", "")
    end

    if commandArray[2] == 'stop' then
        if haS.ActiveId ~= nil then
            chatHandler:SendSysMessage( 'Hide and Seek event ' .. haS.ActiveId .. 'stopped.' )
            haS.StopEvent()
        else
            chatHandler:SendSysMessage( 'There is no Hide and Seek event in progress.' )
        end
        return false
    end

    if commandArray[2] and type( tonumber(commandArray[2]) ) == 'number' then
        if haS.StartEvent( tonumber(commandArray[2]), player ) == true then
            chatHandler:SendSysMessage( 'Hide and Seek event ' .. commandArray[2] .. ' started.' )
        else
            chatHandler:SendSysMessage( 'Hide and Seek event ' .. commandArray[2] .. ' could not be started.' )
        end
        return false
    end

    return
end

function haS.CloseLua( _ )
    haS.StopEvent()
end
--------------------------------------------------------------------------------
-- Startup:
--------------------------------------------------------------------------------
haS.ObjectGuid = nil
haS.ActiveId = nil

RegisterPlayerEvent( PLAYER_EVENT_ON_COMMAND, haS.OnCommand )
RegisterServerEvent( ELUNA_EVENT_ON_LUA_STATE_CLOSE, haS.CloseLua, 0 )
