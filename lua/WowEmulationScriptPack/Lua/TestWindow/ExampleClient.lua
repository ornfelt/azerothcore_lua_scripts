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
This file is a client file and it handles all client side code. It is added on server
side to a list of files to send to the client when the client reloads UI or logs in.
This means that the file is run on server side and then on client side.
This file should be placed somewhere in the lua_scripts folder so Eluna can load it.
You can of course design your own addons and codes in some other way.

Few tips:
Size matters. The final compressed and obfuscated code will be sent to the client and
if it is very large, it will take more messages and more work to send.
Obfuscation will be done on startup so it will not slow down the sending process.
AIO has a cache system that avoids unnecessary resending of unchanged addons
between relogging. You can reset all client side saved information with /aio reset
Type /aio help to see all other commands.

Message compression and obfuscation should be turned on in AIO.lua files on server
and client. If you want to debug your code and need to see the correct line numbers
on error messages, disable obfuscation.
Use locals! local variables will be shortened by obfuscation, so you should prefer
local variables over global and you should try make functions, methods and variables local.
Make functions out of repetitive code to make the code smaller.
Obfuscation removes comments so you can have as much comments as you want in your code
to keep it clear.

After getting some base understanding of how things work, it is suggested to read all the AIO files.
They contain a lot of new functions and information and everything has comments about what it does.
]]


-- Note that getting AIO is done like this since AIO is defined on client
-- side by default when running addons and on server side it may need to be
-- required depending on the load order.
local AIO = AIO or require("AIO")

-- This will add this file to the server side list of addons to send to players.
-- The function is coded to get the path and file name automatically,
-- but you can also provide them yourself. AIO.AddAddon will return true if the
-- addon was added to the list of loaded addons, this means that if the
-- function returns true the file is being executed on server side and we
-- return since this is a client file. On client side the file will be executed
-- entirely.
if AIO.AddAddon() then
    return
end

-- AIO.AddHandlers adds a new table of functions as handlers for a name and returns the table.
-- This is used to add functions for a specific "channel name" that trigger on specific messages.
-- At this point the table is empty, but MyHandlers table will be filled soon.
local MyHandlers = AIO.AddHandlers("AIOExample", {})
-- You can also call this after filling the table. like so:
--  local MyHandlers = {}; ..fill MyHandlers table.. AIO.AddHandlers("AIOExample", MyHandlers)

-- Lets create some UI frames for the client.
-- Note that this code is executed on addon side - you can use any addon API function etc.

-- Create the base frame.
FrameTest = CreateFrame("Frame", "FrameTest", UIParent, "UIPanelDialogTemplate")
local frame = FrameTest

-- Some basic method usage..
-- Read the wow addon widget API for what each function does:
-- http://wowwiki.wikia.com/Widget_API
	frame:SetSize(300, 350)
	frame:RegisterForDrag("LeftButton")
	frame:SetPoint("CENTER")
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
-- Enable dragging of frame
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnHide", frame.StopMovingOrSizing)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:Hide()
-- This enables saving of the position of the frame over reload of the UI or restarting game
AIO.SavePosition(frame)

-- A handler triggered by using AIO.Handle(player, "AIOExample", "ShowFrame")
-- on server side.

-- Handle toggling the window.
function MyHandlers.ShowFrame(player)
	if(frame:IsShown())then
      frame:Hide()
    else
      frame:Show()
	  
    end
end
-- Closes the window when escape is pressed
tinsert(UISpecialFrames, frame:GetName())

-- Button hooked to the friends frame
local containClk = CreateFrame("Frame", containClk, FriendsFrame)
	containClk:SetSize(55,55)
	containClk:RegisterForDrag("LeftButton")
	containClk:SetPoint("TOP", 181, -32)
	containClk:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile= "Interface/Tooltips/UI-Tooltip-Border",
		edgeSize = 20,
		insets = {left=5,right=5,top=5,bottom=5}

	})
	containClk:SetFrameLevel(5)
	containClk:SetMovable(false)
	
containClkBorder = CreateFrame("Button", containClkBorder, containClk)
  containClkBorder:SetSize(50, 50)
  containClkBorder:SetNormalTexture("Interface/Icons/Ability_Defend")
  containClkBorder:SetHighlightTexture("Interface/Icons/Ability_Defend")
  containClkBorder:SetPushedTexture("Interface/Icons/Ability_Devour")
  containClkBorder:SetPoint("CENTER", 0, 0)
  containClkBorder:EnableMouseWheel(1)
  containClkBorder:SetFrameLevel(1000)
  containClkBorder:SetFrameLevel(7)
containClkBorder:SetScript("OnLeave", function (self, button, down)
    GameTooltip:Hide()
  end)

containClkBorder:SetScript("OnMouseUp", function (self, button, down)
	if(frame:IsShown())then
		frame:Hide()
    else
		AIO.Handle("AIOExample", "Update")
		frame:Show()
	end
  end)

						-- Type.	--MacroName --?? --??
local bindbtn=CreateFrame("Button","openWindow",nil,"SecureActionButtonTemplate");
bindbtn:RegisterForClicks("AnyUp");--   Respond to all buttons
bindbtn:SetAttribute("type","macro");-- Set type to "macro"
bindbtn:SetAttribute("macrotext",".notme");-- Set our macro text
SetBindingClick("]", "openWindow") -- This binds the macro to the key

local title = frame:CreateFontString("title")
title:SetFont("Fonts\\FRIZQT__.TTF", 13)
--title:SetSize("190,5")
title:SetPoint("CENTER", frame, "CENTER", 0, 160)
title:SetText("|cffFFC125Status|r")

local t1text = frame:CreateFontString("t1text")
t1text:SetFont("Fonts\\FRIZQT__.TTF", 13)
t1text:SetPoint("CENTER", frame, "CENTER", 5, 125)
t1text:SetSize(270,40) -- Sets word wrapping based on parent frame size
t1text:SetFormattedText("Send your status fucko.\nWhat if I put in a lot of words hmmmm?? suck my nuts maybe?? hmm")

local t2text = frame:CreateFontString("t2text")
t2text:SetFont("Fonts\\FRIZQT__.TTF", 13)
t2text:SetPoint("CENTER", frame, "CENTER", 5, 85)
t2text:SetSize(270,40) -- Sets word wrapping based on parent frame size
-- ']' with colour code
t2text:SetFormattedText("Hit '|cffFFC125]|r' to open/close this window.")

-- Frame containing messages from sentstring
local innerframe = CreateFrame("Frame", "innerframe", frame)
	innerframe:SetSize(290,100)
	innerframe:SetPoint("CENTER", frame, "CENTER", 2, -30)
	innerframe:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 16, edgeSize = 10, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	innerframe:SetBackdropColor(0,0,0,1);

local sentstring = innerframe:CreateFontString("sentstring")
sentstring:SetFont("Fonts\\FRIZQT__.TTF", 13)
sentstring:SetPoint("CENTER", frame, "CENTER", 5, -30)
sentstring:SetJustifyH("LEFT")
sentstring:SetSize(270,80) -- Sets word wrapping based on parent frame size
sentstring:SetNonSpaceWrap(truncated)
-- Gets called from the server, recieves the sendstring var and creates a textblock containing it
function MyHandlers.SetString(player, sendstring)
	sentstring:SetFormattedText(sendstring)
end

-- Creating an input:
local input = CreateFrame("EditBox", "InputTest", frame, "InputBoxTemplate")
input:SetSize(100, 30)
input:SetAutoFocus(false)
input:SetPoint("CENTER", frame, "CENTER", -70, 40)
input:SetMaxLetters(30)
input:SetScript("OnEnterPressed", input.ClearFocus)
input:SetScript("OnEscapePressed", input.ClearFocus)
input.tooltipText = 'Say something dumb'

-- Creating a child, a button:
local button = CreateFrame("Button", "ClickedBtn", frame, "UIPanelButtonTemplate")
button:SetSize(120, 30)
button:SetPoint("CENTER", frame, "CENTER", 70, 40)
button:EnableMouse(true)
-- Small script to clear the focus from input on click
button:SetScript("OnMouseUp", function() input:ClearFocus() end)

local fontstring = button:CreateFontString("FontTest")
fontstring:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE, MONOCHROME")
fontstring:SetShadowOffset(1, -1)
button:SetFontString(fontstring)
button:SetText("Send Status")

-- You can do a lot of things on client side events.
-- You can find all events for different frame types here: http://wowwiki.wikia.com/Widget_handlers
-- Here I send a message to the server that executes the print handler
-- See the ExampleServer.lua file for the server side print handler.
local function OnClickButton(btn)
    --AIO.Handle("AIOExample", "Print", btn:GetName(), input:GetText())
	AIO.Handle("AIOExample", "AddToDB", btn:GetName(), input:GetText())
	AIO.Handle("AIOExample", "Update")
end
button:SetScript("OnClick", OnClickButton)
