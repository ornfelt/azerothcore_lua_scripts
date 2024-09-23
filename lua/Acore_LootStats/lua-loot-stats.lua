-- lua-loot-stats
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
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 20/06/2022
-- Time: 22:54
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module

------------------------------------------------------------------------------------------------
-- This script serves to log amounts dropped of certain items listed in 'lootlist'
------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  - Run this query manually once:
-- CREATE TABLE IF NOT EXISTS `ac_eluna`.`lootcounter` (`timestamp_start` INT NOT NULL, `timestamp_end` INT NOT NULL, `item` VARCHAR(50), `amount` INT DEFAULT 0, PRIMARY KEY (`timestamp_start`, `item`) );
------------------------------------------------------------------------------------------------

local PLAYER_EVENT_ON_LOOT_ITEM = 32        -- (event, player, item, count)
local ELUNA_EVENT_ON_LUA_STATE_CLOSE = 16   -- (event) - triggers just before shutting down eluna (on shutdown and restart)

local function returnIndex (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return index
        end
    end
    return false
end

local lootlist = {
    [1] = 'Linen Cloth',
    [2] = 'Wool Cloth',
    [3] = 'Silk Cloth',
    [4] = 'Mageweave Cloth',
    [5] = 'Light Leather',
    [6] = 'Medium Leather',
    [7] = 'Heavy Leather',
    [8] = 'Thick Leather',
    [9] = 'Purple Lotus',
    [10] = 'Raw Spotted Yellowtail',
    [11] = 'Runecloth',
    [12] = 'Rugged Leather'
}

local lootcounter = {}
local starttime = tonumber( tostring( GetGameTime() ) )

local function OnLootItem( event, player, item, count )
    if item then
        local index = returnIndex( lootlist, item:GetName() )
        if index ~= false then
            lootcounter[index] =  lootcounter[index] + count
        end
    end
end

local function SaveLootAmounts()
    local time = tonumber( tostring(GetGameTime()) )
    for n = 1, #lootlist do
        CharDBExecute('INSERT INTO `ac_eluna`.`lootcounter` VALUES (' .. starttime .. ', ' .. time .. ', \'' .. lootlist[n] .. '\', ' .. lootcounter[n] .. ');')
    end
end

RegisterPlayerEvent( PLAYER_EVENT_ON_LOOT_ITEM, OnLootItem )
RegisterServerEvent( ELUNA_EVENT_ON_LUA_STATE_CLOSE, SaveLootAmounts )

--initialize the counters at 0
for n = 1,#lootlist do
    lootcounter[n] = 0
end
