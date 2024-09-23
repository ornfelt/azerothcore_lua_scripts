local AIO = AIO or require("AIO")
local ToolBarHandlers = AIO.AddHandlers("ToolBar3", {})

local function SendToolBar(event, player)
	AIO.Handle(player, "ToolBar3", "ShowToolBar")
end

-- this resends the toolbar 60 seconds after eluna reload to all players
local function Resend_UI(eventid, delay, repeats, player)
	if player ~= nil then
		AIO.Handle(player, "ToolBar3", "ShowToolBar")
	end
end


local function Lua_Open(event)
	local players_in_world = GetPlayersInWorld(2)
	for m=1,#players_in_world,1 do
		players_in_world[m]:RegisterEvent( Resend_UI, 60000, 0 )
	end
end

RegisterPlayerEvent(3, SendToolBar)
RegisterServerEvent( 33, Lua_Open )