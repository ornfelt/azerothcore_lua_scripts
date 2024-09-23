function sendAddonMessage(plr, msg, packet)
	local splitLength = 240
	local splits = math.ceil(msg:len() / splitLength)
	local send
	local counter = 1
	for i=1, msg:len(), splitLength do
		send = string.format("%03d", packet)
		send = send .. string.format("%02d", counter)
		send = send .. string.format("%02d", splits)
		if ((i + splitLength) > msg:len()) then
			send = send .. msg:sub(i, msg:len())
		else
			send = send .. msg:sub(i, i + splitLength)
		end
		counter = counter + 1

		if _DEBUG then print("[SENT] " .. send) end
		plr:SendAddonMessage(send, "", 7, plr)
	end
end

local function PLAYER_EVENT_ON_REPOP(event, player)
	player:SendBroadcastMessage("Repop")
	player:ResurrectPlayer()
	player:Teleport(13, 0.0, 0.0, 0.0, 0.0, 0.0)
	player:SetData("GAME", nil)
	sendAddonMessage(player, "RESET", 3)
end

RegisterPlayerEvent(35, PLAYER_EVENT_ON_REPOP)

local function PLAYER_EVENT_ON_LOGIN(event, player)
	local map = player:GetMap()
	if map and map:GetMapId() ~= 13 then
		player:ResurrectPlayer()
		player:Teleport(13, 0.0, 0.0, 0.0, 0.0)
	end
end

RegisterPlayerEvent(3, PLAYER_EVENT_ON_LOGIN)


