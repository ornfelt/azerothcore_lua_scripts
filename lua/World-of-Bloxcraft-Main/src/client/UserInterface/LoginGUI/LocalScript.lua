local UI = script.Parent
local Opcodes = require(workspace.Opcodes)

local UI = UI.Frame
local CF = UI.CreateFolder
local SF = UI.SelectFolder;

local createFrame = SF.CreateFrame
local CreateChar = createFrame.CreateChar
local DeleteChar = createFrame.DeleteChar
local CharList = SF.CharList
local MageImage = CF.MageImage
local CharName = CF.CharName
local Accept = CF.Accept
local Back = CF.Back
local Randomize = CF.Randomize
local NameLabel = CF.NameLabel

local selectedClass = nil
local charNameText = nil;

function CreateCharacter()
	if selectedClass ~= nil then
		local data, packet = {}, Opcodes.FindServerPacket("CMSG_CREATE_CHAR")
		data.Class = selectedClass
		data.Name = CharName.Text
		packet:FireServer(data)
		for _,v in next, CF:GetChildren() do
			v.Visible = false
		end
		for _,v in next,SF:GetChildren() do
			v.Visible = true
		end
	end
end

CreateChar.MouseButton1Down:connect(function()
	for _,v in next,SF:GetChildren() do
		v.Visible = false
	end
	
	for _,v in next,CF:GetChildren() do
		v.Visible = true
	end
end)

Accept.MouseButton1Down:connect(function()
	CreateCharacter()
end)

MageImage.MouseButton1Down:connect(function()
	selectedClass = "mage"
	MageImage.UIStroke.Color = Color3.new(0.819608, 0.72549, 0)
end)

