--eluna set time - testtextt
--Made by Didrik with the help of:
--https://pastebin.com/UG45ivpT
--https://elunaluaengine.github.io/Player/SendPacket.html
--https://elunaluaengine.github.io/WorldPacket/index.html
--https://miro.medium.com/max/2472/1*nxvDj8VA-qtQ_ILoZQgaCg.jpeg
--Player:SendPacket

local ACCOUNT_LEVEL = 3 -- equal and above account levels can use this command.
local SMSG_LOGIN_SETTIMESPEED = 66

local function SetTimeScaleCommandHandler(event, player, command)
    --[[if (player:GetGMRank() < ACCOUNT_LEVEL) then
        return
    ]]
	-- syntax .gmtimesetspeed
    if (command:find("timespeed") ~= 1) then
            return
    else
        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        local parameters = getCommandParameters(command)

        local time = GetGameTime()
        local timestring = tostring(time)
        local timeint = tonumber(timestring)
        local timescale = tonumber(parameters[2])
        print(timeint)
        print(type(timeint))
        print(parameters[2])
        print(type(parameters[2]))
        setTimePacket = CreatePacket(SMSG_LOGIN_SETTIMESPEED, 4+4+4)
        setTimePacket:WriteULong(timeint)
        setTimePacket:WriteFloat(timescale)
        setTimePacket:WriteULong(0)
        player:SendPacket(setTimePacket)
        player:SendBroadcastMessage("Time set for your player!")
        return false
    end
end

RegisterPlayerEvent(42, SetTimeScaleCommandHandler)