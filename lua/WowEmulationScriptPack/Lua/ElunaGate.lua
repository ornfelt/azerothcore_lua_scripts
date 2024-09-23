-- Thanks to Kenuvis for his great work on Gate.
-- For more info on the original code, 
-- see the text file supplied with this code.

if (MapMgr == nil) then --Serverstart 
	if GetLuaEngine() == "ElunaEngine" then
		print("[ElunaGate]: Loaded Server Side Framework!")
	else
		print("[Gate]: Unknown and unsupported LuaEngine")
		return;
	end
end

-- Definitions

-- These definitions should be identical to the client definitions.
local Gate = {
	Prefix = "ElunaGate",
	Version = "8",
	StreamStart = "\129", --"§",
	BlockStart = "\130", --"#",
	BlockIdent = "\131", --"!",
	StreamBlock = "\132", --"~",
	StreamBlockEnd = "\133", --"!",
	True = "\134", --"%",
	False = "\135", --"&",
	
	-- For New-Life
	Insert = "\140",
	EventInsert = "\141",
	
	AllowNamelessObjects = false}

-- Shortforms of parameter. Every parameter listed here become a command and only if a parameter is listed here, it would send. Any other parameter stay at the server.
Gate.shortKeys = {
	["Text"] = "t",
	["Width"] = "w",
	["Height"] = "h",
	["Name"] = "n",
	["Parent"] = "p",
	["XOffset"] = "x",
	["YOffset"] = "y",
	["Offset"] = "o",
	["StatusLink"] = "l",
	["Event"] = "e",
	["Tooltip"] = "tt",
	["Hidden"] = "hi",
	["FadeIn"] ="fi",
	["FadeOut"] = "fo",
	["Red"] = "r",
	["Green"] = "g",
	["Blue"] = "b",
	["Alpha"] = "a",
	["Style"] = "s",
	["Cursor"] = "c",

	-- Only for Frames
	["CantClose"] = "cc",
	["CantMove"] = "cm",
	["InfoText"] = "in", -- also for Editbox and StatusBar !
	["Front"] = "f",
	["Tabbed"] = "tf",
	["LeaveOpen"] = "lo",
	["Texture"] = "tex",
	-- Only for TabbedFrames
	["Tab"] = "tab", 
	["SelectedTab"] = "st",
	-- Only for Panels
	["Border"] = "br",
	["Background"] = "bg",
	-- Only for Buttons
	["Texture"] = "tex",
	-- Only for EditBoxes
	["MultiLine"] = "ml",
	["MinValue"] = "min",
	["MaxValue"] = "max",
	-- Only for Check/Radiobuttons
	["Checked"] = "ch",
	-- Only for Yes/No-Frame
	["Yes"] = "yes",
	["No"] = "no",
	-- Only for StaticPopUp
	["Arg1"] = "1",
	["Arg2"] = "2",
	-- Only for Statusbar/Slider
	["MinValue"] = "min",
	["MaxValue"] = "max",
	["ValueStep"] = "stp", 
	["Value"] = "val",
	["Countdown"] = "cd",
	["LowText"] = "lt",
	["HighText"] = "ht",
	["AutoReset"] = "ar",
	["Flow"] = "fl",
	["RunBack"] = "rb",
	["Vertical"] = "ve",
	-- Only for LinkExsits
	["Version"] = "v",
	["Component"] = "cmd",
	-- Only for Minimapbuttons
	["Texture"] = "tex",
	["Degree"] = "deg",
	-- Only for GetStatus
	["GetType"] = "gt",
	-- Only for DropDownMenus
	["DropDownItem"] = "ddi",
	["SelectedItem"] = "si",
	-- Only for ListBox
	["ListBoxItem"] = "lbi",
	-- Only for InputFrames
	["ButtonText"] = "bt",
	["FrameText"] = "ft",
	["DontCloseAfterSend"] = "dc",
	-- Only for TextBoxes
	["TextHeight"] = "th",
	-- Only for Keybind
	["Key"] = "ky"}

-- The Masterobject
-- Its funny, because its only a metatable, which simulate existing commands. Every Get/Set/Change/Create command is here! Easy and usefull.
local GateObject = {}
local GateObject_MT = {__index = 
	function (Obj, Type) 
		-- we parse and see, what we have to give it in the right way
		local oType = string.match(Type, "Create(%w+)")
		if oType then
			return function (_, Name, Parameter) 
					Parameter = Parameter or {}
					Parameter.Parent = Obj.Name
					
					return CreateObject(oType, Name, Parameter, 3)
				end
		end
		
		oType = string.match(Type, "Get(%w+)")
		if oType then
			local newoType, status = string.gsub(oType, "FromPlayer", "")
			return function (func, ...) 
					if status > 0 and Gate.shortKeys[newoType] then
						Reg_Gate_Event("Get"..newoType.."from"..Obj.Name, 
							function(event, Player, Message)
								func(Obj, Player, Message[1])
								-- I know, the memory ...
								--Del_Gate_Event("Get"..newoType.."from"..Obj.Name)	
							end)
							
						local Stream = Gate:CreateNewGateStream("getstatus")
						Stream:AddParameter("Name", Obj.Name)
						Stream:AddParameter("GetType", newoType)
						Stream:Send(...)
						Stream:Clear()
					else
						return Obj[newoType]
					end
				end
		end
		
		oType = string.match(Type, "Set(%w+)") 
		if oType then
			return function (_, Value)
					if type(Value) == "table" then
						Value = Value.Name
					end
					
					if type(Value) == "string" then
						if string.find(Value, Gate.StreamStart) then
							error(Gate.Prefix..": Invalid character in "..Type.." "..Gate.StreamStart, 2)
						elseif string.find(Value, Gate.BlockStart) then
							error(Gate.Prefix..": Invalid character in "..Type.." "..Gate.BlockStart, 2)
						elseif string.find(Value, Gate.BlockIdent) then
							error(Gate.Prefix..": Invalid character in "..Type.." "..Gate.BlockIdent, 2)
						elseif string.find(Value, Gate.StreamBlock) then
							error(Gate.Prefix..": Invalid character in "..Type.." "..Gate.StreamBlock, 2)
						elseif string.find(Value, Gate.StreamBlockEnd) then
							error(Gate.Prefix..": Invalid character in "..Type.." "..Gate.StreamBlockEnd, 2)
						elseif string.find(Value, Gate.True) then
							error(Gate.Prefix..": Invalid character in "..Type.." "..Gate.True, 2)
						elseif string.find(Value, Gate.False) then
							error(Gate.Prefix..": Invalid character in "..Type.." "..Gate.False, 2)
						end
					end					
					
					-- Objectchange to Changeset
					if Obj._ChangeSet then
						table.insert(Obj._ChangeSet.Changes, {Object = Obj, Key = oType, Value = Value})
						--Obj._ChangeSet = nil
					else
						Obj[oType] = Value
					end
					return Obj
				end
		end
		return nil --function() error(Gate.Prefix..": Invalid command "..Type, 2) end
	end}

-- Every Object have to save, so an event can dedicated to an object an start the action
Gate.SavedObjects = {}

-- Allowed Events and Objects with some parameter
Gate.specialEvent = {}
Gate.Events = {
	["NoEvents"] = {id = 0},
	["OnClick"] = {id = 10},
	["OnDoubleClick"] = {id = 11},
	["OnHide"] = {id = 12},
	["OnEnter"] = {id = 13},
	["OnEnterPressed"] = {id = 14},
	["OnKeyDown"] = {id = 15}}

Gate.Objects = {
	["Frame"] = {Type = "frame"},
	["BlindFrame"] = {Type = "bf", CantChange = true},
	["TabbedFrame"] = {Type = "tf"}, 
	["Button"] = {Type = "btn"},
	["CheckBox"] = {Type = "cb"},
	["CheckButton"] = {Type = "cb"},
	["RadioButton"] = {Type = "rb"},
	["RadioBox"] = {Type = "rb"},
	["EditBox"] = {Type = "eb"},
	["InputBox"] = {Type = "eb"},
	["TextBox"] = {Type = "tb"},
	["StatusBar"] = {Type = "sb"},
	["Slider"] = {Type = "sl"},
	["Panel"] = {Type = "pl"},
	["ListBox"] = {Type = "lb", CantParent = true, CantChange = true},
	["DropDownMenu"] = {Type = "ddm", CantParent = true, CantChange = true},
	["CursorKeys"] = {Type = "ck", CantParent = true, CantChange = true},
	["DialogFrame"] = {Type = "df", CantParent = true, CantChild = true, CantChange = true},
	["InputFrame"] = {Type = "if", CantParent = true, CantChild = true, CantChange = true},
	["EditFrame"] = {Type = "if", CantParent = true, CantChild = true, CantChange = true},
	["OkFrame"] = {Type = "of", CantParent = true, CantChild = true, CantChange = true},
	["YesNoFrame"] = {Type = "yn", CantParent = true, CantChild = true, CantChange = true},
	["StaticPopup"] = {Type = "sb", CantParent = true, CantChild = true, CantChange = true},
	["StaticFrame"] = {Type = "sf", CantParent = true, CantChange = true},
	["MinimapButton"] = {Type = "mmb", CantParent = true, CantChild = true, CantChange = true},
	["SlashCommand"] = {Type = "slash", CantParent = true, CantChild = true, CantChange = true},
	["Action"] = {Type = "action", CantParent = true, CantChild = true, CantChange = true},
	["KeyBind"] = {Type = "kb", CantParent = true, CantChild = true, CantChange = true},
	["Event"] = {Type = "ev", CantParent = true, CantChild = true, CantChange = true}}

-- Every Object get his own Createcommand without a parent object
for Type,Obj in pairs(Gate.Objects) do
	_G["Create"..Type] = function (Name, Parameter) return CreateObject(Type, Name, Parameter, 3) end
end

-- a simple way to combinate two tables
table.combine = function(master,slave)
	slave = slave or {}
	master = master or {}
	if type(slave) ~= "table" or type(master) ~= "table" then return master end
	for k,v in pairs(slave) do
		master[k] = master[k] or v
	end
	return master
end

-- [[Outsource]]

-- Here, with this 3 commands, you can create your own objects/moduls
-- If you understood Gate, I should explain this.

function Reg_Gate_Object(Name, ident, CantChild, CantParent)
	Gate.Objects[Name] = {Type = ident, CantChild = CantChild, CantParent = CantParent}
	_G["Create"..Name] = function (ObjName, Parameter) return CreateObject(Name, ObjName, Parameter, 3) end
	return Gate
end

function Reg_Gate_shortKeys(Key, Short)
	Gate.shortKeys[Key] = Short
end

function Reg_Gate_Event(ident, func)
	Gate.specialEvent[ident] = func
end

function Del_Get_Event(ident)
	Gate.specialEvent[ident] = nil
end	

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------- Changeset-handle -----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

function CreateChangeSet()
	local ChangeSet = {}

	ChangeSet.Changes = {}	
	function ChangeSet:Send(...)		
			local msg = ""
			for _,Change in ipairs(self.Changes) do
				if Change then
					local Stream = Gate:CreateNewGateStream(Change.Object.Type)
					Stream:AddParameter("Name", Change.Object.Name)
					Stream:AddParameter(Change.Key, Change.Value)
					msg = msg..Stream.msg
					Stream:Clear()
					Change.Object._ChangeSet = nil
				end
			end
			Gate:Send(msg, ...)
		end
	function ChangeSet:Clear() 
			self.Changes = {}
		end
	function ChangeSet:RemoveChange(Name, Key)
			for index,Change in ipairs(self.Changes) do
				if Change.Name == Name and ((Key and Key == Change.Key) or not Key) then
					self.Changes[index] = nil
				end
			end
		end
		
	function ChangeSet:AddObject(...)
		local a = 1
		local Objects = {}
		while select(a, ...) do
			local Object = GetObject(select(a, ...))
			if Object.CantChange then 
				print(Gate.Prefix..": "..Object.Type.." cannot be part of a changeset!")
				Object = nil
			end
			if Object then
				Object._ChangeSet = self
			end
			Objects[a] = Object
			a = a + 1
		end
		
		return unpack(Objects)
	end
		
	return ChangeSet
end	

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------- Object-handle --------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

-- No need to explain
function Gate:SaveObject(Name, Object)
--[[	if Gate.SavedObjects[Name] then
		print(Gate.Prefix..": Object ["..Name.."] was overwrite!")
	end]]
	Gate.SavedObjects[Name] = Object
end

function GetObject(Name)
	if type(Name) == "table" then
		return Name
	else
		return Gate.SavedObjects[Name]
	end
end

function NewFrame(Stream) -- Stream have to come from the Builder
	local SObject = {} -- StreamObject
	SObject.ToSend = ""
	
	for byte in string.gfind(Stream, "(%w%w)") do
		SObject.ToSend = SObject.ToSend..string.char(tonumber("0x"..byte))
	end

	function SObject:Send(...) 
		if string.find(self.ToSend, Gate.EventInsert) then
			error(Gate.Prefix..": There is an unhandled Event in the NewFrame and this cannot be send!", 2)
		end
		Gate:Send(self.ToSend, ...) 
	end
	
	for name in string.gfind(SObject.ToSend, Gate.Insert.."(%w+)"..Gate.Insert) do
		SObject[name] = function(self,Value) self.ToSend = string.gsub(self.ToSend, Gate.Insert..name..Gate.Insert, Value) end
	end
	
	for Event, Object, Eventfunc in string.gfind(SObject.ToSend, Gate.EventInsert.."(%w+)%s(%w+)%s(%w+)"..Gate.EventInsert) do
		assert(Gate.Events[Event], Gate.Prefix..": Invalid "..Event.." Event in NewFrame for "..Object)
	
		local NewObject = GetObject(Object) or {}
		if not NewObject.Events then NewObject.Events = {} end
		NewObject.Events[Event] = Eventfunc
		Gate:SaveObject(Object, NewObject)
		
		SObject.ToSend = string.gsub(SObject.ToSend, Gate.EventInsert..Event.." "..Object.." "..Eventfunc..Gate.EventInsert, Gate.Events[Event].id)
	end
	
	return SObject
end	

-- Every Object would created here. If you know, what you do, you dont need the CreateFrame commands, only this!
function CreateObject(Type, Name, Parameter, ErrLevel)
	local func
	if type(Parameter) == "function" then
		func = Parameter
		Parameter = {}
	end
	
	Parameter = Parameter or {}
	Parameter.Name = Parameter.Name or Name
	
	-- Some rules and errors
	if not Type or not Gate.Objects[Type] then
		error(Gate.Prefix..": Invalid ObjectType", ErrLevel)
	elseif not Name then
		if not Gate.AllowNamelessObjects then
			error(Gate.Prefix..":Cannot create a nameless "..Type..". Usage: Create"..Type.."(\"Name\", [{Parameter}])", ErrLevel)
		else
			Parameter.Name = Type..tostring(os.time())
		end
	elseif Parameter.Parent then
		if Gate.Objects[Type].CantChild then
			error(Gate.Prefix..": "..Parameter.Name.." cannot get a parent", ErrLevel)
		elseif not Gate.SavedObjects[Parameter.Parent] then
			error(Gate.Prefix..": "..Parameter.Parent.." as parent for "..Parameter.Name.." not found", ErrLevel)
		elseif Gate.SavedObjects[Parameter.Parent].CantParent then
			error(Gate.Prefix..":The parent of "..Parameter.Name.." cannot be "..Parameter.Parent, ErrLevel)
		else
			table.insert(Gate.SavedObjects[Parameter.Parent].Childs, Parameter.Name)
		end
	end	
	
	-- Now we create, save and return the object for handling
	local Object = {}
	
	Object = table.combine(Object, GateObject)
	Object = table.combine(Object, Gate.Objects[Type])
	Object = table.combine(Object, Parameter)	
	
	Object.Childs = {}
	Object.Event = {}
	Object.Events = {}
	Object.StatusLink = {}
	
	-- Standard Events for special Objects
	if Type == "SlashCommand" then
		Object.Events["Slash"] = func
		Object.Text = Parameter.Name
	elseif Type == "MinimapButton" then
		Object.Events["OnClick"] = func
	elseif Type == "Event" then
		Gate.specialEvent[Name] = func
	end
	
	setmetatable(Object, GateObject_MT)
	Gate:SaveObject(Parameter.Name, Object)
	
	return Object
end

-- how a command work, is easy. 
function SendSystemMessage(Message, ...)
	-- Frist, we should Create a new Stream (because it's a new Command for the Client)
	-- Here, we need the identificator for the Client, which should know, what to do
	local Stream = Gate:CreateNewGateStream("sys")
	-- Now we add as many paramenter as we want and need f¨¹r this command
	Stream:AddParameter("Text", Message)
	-- Finally, we should send it ^^
	Stream:Send(...)
	Stream:Clear()
end

-- Same like "function SendSystemMessage"
function ShowStaticPopup(Name, arg1, arg2, ...)
	local Stream = Gate:CreateNewGateStream("sp")
	Stream:AddParameter("Name", Name)
	if arg1 then Stream:AddParameter("Arg1", arg1) end
	if arg2 then Stream:AddParameter("Arg2", arg2) end	
	Stream:Send(...)
	Stream:Clear()
end

-- Here, we compare the version and if the object, the user asked, is handled by the client
Gate.LinkCheck = {}
function LinkExists(Link, func, ...)
	assert(Gate.Objects[Link], Link.." is not handled by the Server")
	
	local Stream = Gate:CreateNewGateStream("version")	
	Stream:AddParameter("Version", Gate.Version)
	Stream:AddParameter("Component", Gate.Objects[Link].Type)
	Stream:Send(...)
	Stream:Clear()
	
	-- This command should trigger a returnmessage, so we handle it like a event
	Gate.LinkCheck[string.lower(Link)] = func	
end

-- If the user only want to know, if gate is running on the player, we use the LinkExists command and ask for frame, because 
-- its a basic object and this have to supported in gate since the first version
function GateExists(func, ...)
	return LinkExists("Frame", func, ...)
end

Reg_Gate_Event("version", function(event, Player, Message) Gate.LinkCheck[Message[1]](event, Player, Message[2], Message[3]) end)

-- A Event is easy, when we store it at the right place
function GateObject:SetEvent(Event, EventFunc)
	if Event == "NoEvents" then
		self.Event = {}
	elseif not Gate.Events[Event] then
		error(Gate.Prefix..": "..Event.." is and invalid Event for "..self.Name, 2)
	else
		if type(EventFunc) == "string" then EventFunc = _G[EventFunc] end
		-- For Send
		table.insert(self.Event, Gate.Events[Event].id)
		-- For Receive
		self.Events[Event] = EventFunc
	end
end

function GateObject:SetStatusLink(...)
    local a = 1
    while select(a, ...) do
        local NameOrObject = select(a, ...)
        if type(NameOrObject) == "table" then
            NameOrObject = NameOrObject.Name
        end
        
        if type(NameOrObject) == "nil" then
            self.StatusLink = {}
        else
            table.insert(self.StatusLink, NameOrObject)
        end	
	
	a = a + 1
    end
end

function GateObject:SetColor(r,g,b)
	self.Red = r
	self.Green = g
	self.Blue = b
end

function GateObject:SetTab(...)
	local resultTable = {}
	if self.Tab then
		for k,v in ipairs({...}) do
			table.insert(self.Tab, v)
			table.insert(resultTable, v)
		end
	else
		self.Tab = {...}
		resultTable = {...}
	end
	
	for k,v in ipairs(resultTable) do
		local index
		for i,name in ipairs(self.Tab) do
			if name == v then
				index = i
				break
			end
		end
		
		if index then
			resultTable[k] = self:CreateBlindFrame(self.Name.."TabFrame"..index)
		else
			error(Gate.Prefix..": Unexpected error while creating a TabFrame!", 2)
		end
	end
	
	return unpack(resultTable)
end

function GateObject:SetSelectedTab(selectedTab)
	for k,v in ipairs(self.Tab) do
		if v == selectedTab then
			self.SelectedTab = k
			break
		end
	end
end

function GateObject:SetDropDownItem(Item, IconOrFunc, func)
	if not self.DropDownItem then self.DropDownItem = {} end
	if not self.SpecialDropDownItem then self.SpecialDropDownItem = {} end
	
	local icon
	if type(IconOrFunc) == "number" then
		icon = (IconOrFunc < 10 and "0"..IconOrFunc) or tostring(IconOrFunc)
	else
		icon = "00"
		func = IconOrFunc
	end
	
	if type(func) == "string" then func = _G[func] end	
	if func then
		local id 
		for k,v in ipairs(self.SpecialDropDownItem) do
			if v == func then id = k break end
		end
		if not id then
			id = #self.SpecialDropDownItem+1
			if id == 100 then error(Gate.Prefix..": DropDownMenu cannot handle more than 99 Itemfunctions", 2) end
			table.insert(self.SpecialDropDownItem, func)
		end
		if id < 10 then id = "0"..id else id = tostring(id) end
		table.insert(self.DropDownItem, id..icon..Item)	
	else
		-- the first two entries in the ItemString are the ID.
		table.insert(self.DropDownItem, "00"..icon..Item)	
	end
end

function GateObject:SetDropDownItems(...)
	local a = 1
	while select(a, ...) do
		self:SetDropDownItem(select(a, ...))
		a = a + 1
	end
end

function GateObject:SetSelectedItem(Item)
	for k,v in ipairs(self.DropDownItem) do
		if v == Item then 
			self.SelectedItem = k
			break
		end
	end
end	

function GateObject:SetListBoxItem(Item)
	if not self.ListBoxItem then self.ListBoxItem = {} end
	table.insert(self.ListBoxItem, Item)
end	

function GateObject:SetListBoxItems(...)
	local a = 1
	while select(a, ...) do
		self:SetListBoxItem(select(a, ...))
		a = a + 1
	end
end	

-- all is self explain
function GateObject:SetOffset(XOffset, YOffset)
	self.XOffset = XOffset
	self.YOffset = YOffset
end

function GateObject:Hide(...)
	local Stream = Gate:CreateNewGateStream(self.Type)
	Stream:AddParameter("Name", self.Name)
	Stream:AddParameter("Hidden", true)
	Stream:Send(...)
	Stream:Clear()
end

function HideAll(Status, ...)
	local Stream
	if Status then
		Stream = Gate:CreateNewGateStream("ha")
	else
		Stream = Gate:CreateNewGateStream("sa")
	end
	Stream:AddParameter("Name", "Hideall")
	Stream:Send(...)
	Stream:Clear()
end

function GateObject:Show(...)
	local Stream = Gate:CreateNewGateStream(self.Type)
	Stream:AddParameter("Name", self.Name)
	Stream:AddParameter("Hidden", false)
	Stream:Send(...)
	Stream:Clear()
end

function GateObject:GetStatus(func, ...)
	if Object.Type == "cb" then
		self:GetCheckedFromPlayer(func, ...)
	elseif Object.Type == "eb" then
		self:GetTextFromPlayer(func, ...)
	elseif Object.Type == "sb" then
		self:GetValueFromPlayer(func, ...)
	else
		self:GetHiddenFromPlayer(func, ...)
	end
end


	
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------- Send & Receive ----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

-- Dont working, dont know why, but this isnt important
-- RegisterServerHook(19, function(_,Ply) Ply:SendBroadcastMessage("Server support Lua Gate Project Build "..Gate.Version.." by Kenuvis") end)

function Gate_ChatHook(Event, Player, Type, Prefix, Message, Target)
	if Prefix == "C"..Gate.Prefix then
		Gate:IncomingStream(Message, Player)
		print(1)
		return 0
	end
end

-- RegisterPlayerEvent(18, Gate_ChatHook)
RegisterServerEvent(30, Gate_ChatHook)
-- For Streams which are over 255 letters long
Gate.Stream = {}	

function Gate:IncomingStream(Stream, Player)
	-- If a message is over 255 letters long and the limit reached, it cuts in blocks 
	-- StreamBlock Stream1
	-- StreamBlock Stream2
	-- StreamBlock StreamBlockEnd Stream3  --> Stream1 Stream2 Stream3
	if string.find(Stream, Gate.StreamBlock) == 1 then
		if string.find(Stream, Gate.StreamBlockEnd) == 2 then
			Gate.Stream[Player] = Gate.Stream[Player]..string.sub(Stream, 3)
			Gate:IncomingStream(Gate.Stream[Player], Player)
			Gate.Stream[Player] = nil
		else
			if not Gate.Stream[Player] then Gate.Stream[Player] = "" end
			Gate.Stream[Player] = Gate.Stream[Player]..string.sub(Stream, 2)
		end
		return
	end
	
	-- Easy parse of all little incoming events
	for a in string.gmatch(Stream, "%"..Gate.StreamStart.."(.[^"..Gate.StreamStart.."]+)") do
		Gate:IncomingMessage(a, Player)
	end
end

function Gate:IncomingMessage(Text, Player)
	-- splitt the message and put it in a table to work better with it
	local Message = {}
	for a in string.gmatch(Text, "%"..Gate.BlockStart.."(.[^"..Gate.BlockStart.."]*)") do
		if a == "+" then a = true elseif a == "-" then a = false end
		table.insert(Message, a)
	end

	-- The first parameter is always that one, the show, what is it
	local event = Message[1]
	table.remove(Message, 1)

	if not event then return end
	
	-- lets have a look, what is it
	if event == "e" then --Event
		Gate:IncomingEvent(Message, Player)
	elseif event == "dde" then --dropdown event
		Gate:IncomingDropDownEvent(Message, Player)
	elseif Gate.specialEvent[event] then
		Gate.specialEvent[event](event, Player, Message)
	end
end

function Gate:IncomingEvent(Message, Player)
	local ObjectName = Message[1]
	table.remove(Message, 1)
	
	local Event = Message[1]
	table.remove(Message, 1)
	
	if not GetObject(ObjectName) then
		print(Gate.Prefix..": Incoming Event from "..Player:GetName().." for not valid Object "..ObjectName)
	elseif not GetObject(ObjectName).Events[Event] then
		print(Gate.Prefix..": Incoming invalid "..Event.." Event from "..Player:GetName().." for "..ObjectName)
	else		
		local EventFunc = GetObject(ObjectName).Events[Event]
		if type(EventFunc) == "string" then EventFunc = _G[EventFunc] end
		
		-- EventFunction(Object, Event, Player, Arg-Table)
		EventFunc(GetObject(ObjectName), Event, Player, Message)
	end
end

function Gate:IncomingDropDownEvent(Message, Player)
	local ObjectName = Message[1]
	table.remove(Message, 1)
	
	local Event = Message[1]
	table.remove(Message, 1)
	
	local ID = tonumber(Message[1])
	table.remove(Message, 1)
	
	if not GetObject(ObjectName) then
		print(Gate.Prefix..": Incoming Event from "..Player:GetName().." for not valid Object "..ObjectName)
	elseif not GetObject(ObjectName).SpecialDropDownItem or not GetObject(ObjectName).SpecialDropDownItem[ID] then
		print(Gate.Prefix..": Incoming invalid Event from "..Player:GetName().." for "..ObjectName)
	else
		-- EventFunction(Object, Event, Player, Arg-Table)
		GetObject(ObjectName).SpecialDropDownItem[ID](GetObject(ObjectName), Event, Player, Message)
	end
end

function Gate:CreateNewGateStream(ident)
	local Stream = {}
	
	Stream.msg = Gate.StreamStart..ident
	function Stream:AddObject(newObject)
			newObject = GetObject(newObject)
			if newObject.Type ~= "bf" then -- Blindframes are blind, because, they do not send
				Stream:IntroSubStream(newObject.Type)
			end
			Stream:AddParameter(nil, newObject)
		end
	function Stream:AddParameter(Key, Parameter, Disband)
			local _type = type(Parameter)
			if _type == "string" or _type == "number" then
				if Gate.shortKeys[Key] then 
					Stream.msg = Stream.msg..Gate.BlockStart..Gate.shortKeys[Key]..Gate.BlockIdent..tostring(Parameter)
				end
			elseif _type == "boolean" then
				if Gate.shortKeys[Key] then 
					Stream.msg = Stream.msg..Gate.BlockStart..Gate.shortKeys[Key]..Gate.BlockIdent..((Parameter and Gate.True) or Gate.False)
				end
			elseif _type == "table" then
				if Parameter.Type ~= "bf" then -- Blindframes are blind, because, they do not send
					for k,v in pairs(Parameter) do
						if type(k) == "number" then
							Stream:AddParameter(Disband, v) -- 2D Tables
						elseif Gate.shortKeys[k] then 
							Stream:AddParameter(k, v, k)
						end
					end
				end
				if Parameter.Type then -- if it is a object
					-- check the Childs
					for _,Child in ipairs(Parameter.Childs) do
						Stream:AddObject(Child)
					end
				end
			elseif _type == "nil" or _type == "function" then
				-- do nothing and ignore it
			else
				error("Unknown type of parameter to add to stream")
			end
		end
	function Stream:Clear()
			Stream = nil
		end
	function Stream:IntroSubStream(_ident)
			Stream.msg = Stream.msg..Gate.StreamStart.._ident
		end
	function Stream:Send(...)
			Gate:Send(Stream.msg, ...)
		end	
		
	return Stream
end

CreateNewGateStream = Gate.CreateNewGateStream

function Gate:Send(ToSend, ...)
	if not ToSend then return end
	if not ... then return end
	
	-- Add the Prefix for Addonmessages to the Buffer and then go to every Player it should go
	Prefix = "S"..Gate.Prefix
	Message = ToSend
	
	local a = 1
	while select(a, ...) do
		if GetLuaEngine() == "ElunaEngine" then
			select(a, ...):SendAddonMessage(Prefix, Message, 7, select(a, ...))
		else
			error("Unknown LuaEngine")
		end
		a = a + 1
	end
end

-- Only Objects would send with this function
function GateObject:Send(...)
	local Stream = Gate:CreateNewGateStream(self.Type)
	Stream:AddParameter(nil, self)
	Stream:Send(...)
	Stream:Clear()
end

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------- Static-Frame-handle -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

-- Static Frame represent a methode to record something and trigger it at another moment, without doing 
-- all things (create, set..., and so on) again

Reg_Gate_Event("sf", function(_, Player, Message) Gate:SendSF(Message[1], Player) end)

Gate.SF = {}
function Gate:SendSF(Name, ...)
	if not Gate.SF[Name] then
		return
	end
	
	local Stream = Gate:CreateNewGateStream("sfstart")
	Stream:AddParameter("Name", Name)
	Stream:AddObject(Gate.SF[Name])
	Stream:IntroSubStream("sfstop")
	Stream:AddParameter("Name", Name)
	Stream:Send(...)
end

function GateObject:SetAsStaticFrame(Name)
	if Gate.SF[Name] then
		print(Gate.Prefix..": StaticFrame ["..Name.."] was overwrite!")
	end
	
	Gate.SF[Name] = {}	
	for k,v in pairs(self) do
		Gate.SF[Name][k] = v
	end
	
	Gate.SF[Name].Childs = {}
	for _,name in pairs(self.Childs) do
		-- I just create a copy, because static frames shouldnt change
		local NewObject = {}
		for k,v in pairs(GetObject(name)) do
			NewObject[k] = v
		end
		
		table.insert(Gate.SF[Name].Childs, NewObject)
	end
end

function SendStaticFrame(Name, ...)
	local Stream = Gate:CreateNewGateStream("sf") 
	Stream:AddParameter("Name", Name)
	Stream:Send(...)
end

function ResendStaticFrame(Name, ...)
	Gate:SendSF(Name, ...)
end

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------- MasterObject-handle --------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

function CreateMaster(Name, Parameter)
	local Object = {}
	
	Object = table.combine(Object, GateObject)
	Object = table.combine(Object, Parameter)
	
	Object.Name = nil
	
	setmetatable(Object, GateObject_MT)
	Gate:SaveObject(Name, Object)
	
	return Object
end

function GetMasterObject(Name)
	return GetObject(Name)
end

function GateObject:SetMaster(MasterObject, overwrite)
	if type(MasterObject) == "string" then
		MasterObject = GetMasterObject(MasterObject)
	end
	
	for k,v in pairs(MasterObject) do
		self[k] = (not overwrite and self[k]) or v
	end
	
	return self
end

function GateObject:SetAsMaster(Name)
	return CreateMaster(Name, self)
end