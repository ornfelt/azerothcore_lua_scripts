-- Owned by: Didrik
-- GetRelativePoint kind of breaks this script. Server uses collision check so you can't TP through some objects. https://i.imgur.com/1YBrtWa.png

local ACCOUNT_LEVEL = 1 -- equal and above account levels can use this command.

local function XYWarpCommand(player,direction,amount)
    local playerX, playerY, playerZ, playerOrientation = player:GetLocation()
    local mapid = player:GetMapId()

    -- Radius relative to current orientation.
    if direction == "r" then
        warpOrientation = math.pi*1.5 -- I don't know why, but I have to change the values between right and left.
    elseif direction == "l" then
         warpOrientation = math.pi*0.5 -- I don't know why, but I have to change the values between right and left.
    elseif direction == "f" then
        warpOrientation = 0
    elseif direction == "b" then
        warpOrientation = math.pi
    end

    local relativeX, relativeY, relativeZ = player:GetRelativePoint( amount, warpOrientation )
    --player:SendBroadcastMessage("Current orientation: " .. playerOrientation .. " - Getting relative point for orientation: " .. warpOrientation)
    player:Teleport( mapid, relativeX, relativeY, playerZ, playerOrientation ) -- Can't use relativeZ here, since it'll teleport you to the ground.
    player:SendBroadcastMessage("RelativeZ: " .. relativeZ .. " - playerZ: " .. playerZ)

end

local function ZWarpCommand(player,direction,amount)
    local playerX, playerY, playerZ, playerOrientation = player:GetLocation()
    local mapid = player:GetMapId()

    if direction == "d" then -- Invert the value, we're going downwards after all!
        amount = amount*-1
    end
    --player:SendBroadcastMessage("Current orientation: " .. playerOrientation)
    player:Teleport( mapid, playerX, playerY, playerZ+amount, playerOrientation )

end


local function WarpCommandHandler(event, player, command)
    if (player:GetGMRank() < ACCOUNT_LEVEL) then
        return
    elseif (command:find("warp") ~= 1) then
        return
    else
        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        for parameter in string.gmatch(command, pattern) do -- Take the entire command and split it by spaces, put into a table.
            table.insert(parameters, parameter) 
        end
        if (parameters[3] == "") then
            player:SendBroadcastMessage("[WARP] You're missing a distance.")
            return false
        elseif (parameters[2] == "r" or parameters[2] == "l" or parameters[2] == "f" or parameters[2] == "b") then
            -- Right, left, front, back
            --player:SendBroadcastMessage("Running WARP. Direction: " .. parameters[2] .. " - Amount: " .. parameters[3])
            XYWarpCommand(player,parameters[2],parameters[3])
            return false

        elseif (parameters[2] == "u" or parameters[2] == "d") then
            -- Up, down
            --player:SendBroadcastMessage("Running WARP. Direction: " .. parameters[2] .. " - Amount: " .. parameters[3])
            ZWarpCommand(player,parameters[2],parameters[3])
            return false
        else
            player:SendBroadcastMessage("[WARP] wants two parameters: .warp direction (f,b,l,r,u,d) amount")
            return false
        end
    end
end




RegisterPlayerEvent(42, WarpCommandHandler)