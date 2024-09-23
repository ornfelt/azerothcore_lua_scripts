--[[
Copyright (C) 2014-  Rochet2 <https://github.com/Rochet2>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]

--[[
This file is a server file. It is loaded on server side and handles all server side code.
This file should be placed somewhere in the lua_scripts folder so Eluna can load it.
You can of course design your own addons and codes in some other way.

Few tips:
On server side the code size does not matter, however safety does!
On client side safety is not needed, but server safety will avoid nasty behavior and errors.
The client may send ANY data. Be cautious and make sure the data you receive is indeed the type you
expect it to be.

Message compression and obfuscation should be turned on in AIO.lua files on server
and client. If you want to debug your code and need to see the correct line numbers
on error messages, disable obfuscation.

After getting some base understanding of how things work, it is suggested to read all the AIO files.
They contain a lot of new functions and information and everything has comments about what it does.
]]


-- Note that getting AIO is done like this since AIO is defined on client
-- side by default when running addons and on server side it may need to be
-- required depending on the load order. On server only files the require
-- would be enough, but lets just keep it like this for the sake of consistency
local AIO = AIO or require("AIO")

-- AIO.AddHandlers adds a new table of functions as handlers for a name and returns the table.
-- This is used to add functions for a specific "channel name" that trigger on specific messages.
-- At this point the table is empty, but MyHandlers table will be filled soon.
local MyHandlers = AIO.AddHandlers("AIOExample", {})
-- You can also call this after filling the table. like so:
--  local MyHandlers = {}; ..fill MyHandlers table.. AIO.AddHandlers("AIOExample", MyHandlers)

-- An example handler.
-- This prints all the values the client sends with the command
--  AIO.Handle("AIOExample", "print")
function MyHandlers.Update(player)
    MyHandlers.setStr(player)
end

function MyHandlers.AddToDB(player, clickedbtn, typed, slider)
	guid =player:GetGUID()
	sendtype =typed
	-- player:SendBroadcastMessage("Button pressed")
	-- Sends what ever the player types in into the database MAX 100 characters
	local query = "UPDATE custom_dwrath_character_stats SET typed = '"..tostring(sendtype).."' WHERE GUID = "..tostring(guid)-- Strings in an SQL query need '' surrounding them
	CharDBExecute(query)
end

function MyHandlers.GrabFromDB(msg)
	local query = "SELECT `typed`, `GUID` FROM `custom_dwrath_character_stats` WHERE LENGTH(typed) > 1 ORDER BY RAND() LIMIT 5"
	qresults = CharDBQuery(query)
	if (qresults == nil) then return end
	rowcount = qresults:GetRowCount()
	sendstring = ""
	for i = 0, rowcount
	do
		if (i >= rowcount)then
			break
		end
		
		guid = qresults:GetUInt32(1)
		plnmres = CharDBQuery("SELECT `name` FROM `characters` WHERE GUID ="..guid)
		playernm = plnmres:GetString(0)
		pltyped = qresults:GetString(0)
		sendstring = tostring("|cffFFC125"..playernm.. "|r says '|cffFFC125"..pltyped .."|r'\n"..sendstring)
		qresults:NextRow()
	end

	-- print(sendstring)
	-- Message calls SetString function in the client, passes this sendstring var from here to the client
	return msg:Add("AIOExample", "SetString", sendstring)
end
AIO.AddOnInit(MyHandlers.GrabFromDB)

-- When this is called, updates sendstring by calling GrabFromDB and sending it as a message to the client
function MyHandlers.setStr(player)
	MyHandlers.GrabFromDB(AIO.Msg()):Send(player)
end

-- When a player uses command .test, show the UI to player
-- The showing is done by sending a message to the client that then does whatever
-- we have coded to be done when receiving the message
local function OnCommand(event, player, command)
    if(command == "notme") then
        -- Note that AIO.Handle has two different definitions:
        -- On client side you don't pass the player argument
        AIO.Handle(player, "AIOExample", "ShowFrame")
		-- Calls setStr in here. Calls if opened or closed. Need a cleaner solution probably.
		MyHandlers.setStr(player)
		-- player:SendBroadcastMessage("Testframe toggled.")
        return false
    end
end

RegisterPlayerEvent(42, OnCommand)

