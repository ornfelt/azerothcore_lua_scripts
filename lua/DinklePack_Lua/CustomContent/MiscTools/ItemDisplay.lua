local PlayerInfo = {}

PlayerInfo.ITEM_EQUIPMENT_SLOTS = {
    [0]  = "HEAD",
    [1]  = "NECK",
    [2]  = "SHOULDERS",
    [3]  = "BODY",
    [4]  = "CHEST",
    [5]  = "WAIST",
    [6]  = "LEGS",
    [7]  = "FEET",
    [8]  = "WRISTS",
    [9]  = "HANDS",
    [10] = "FINGER1",
    [11] = "FINGER2",
    [12] = "TRINKET1",
    [13] = "TRINKET2",
    [14] = "BACK",
    [15] = "MAINHAND",
    [16] = "OFFHAND",
    [17] = "RANGED",
    [18] = "TABARD"
}

function PlayerInfo.ShowPlayerInfo(event, player, command)
    if command == "items" then
        for slot, slotName in pairs(PlayerInfo.ITEM_EQUIPMENT_SLOTS) do
            local item = player:GetEquippedItemBySlot(slot)
            if item then
                local itemId = item:GetEntry()
                local displayId = item:GetDisplayId()
                local message = "Slot " .. slotName .. " (" .. slot .. "): Item ID " .. itemId .. ", Display ID " .. displayId
                player:SendBroadcastMessage(message)
                print(message) -- Log to server console
            end
        end
        return false -- prevent command from being parsed as a normal server command
    elseif command == "race" then
        local raceId = player:GetRace()
        local raceMask = player:GetRaceMask() -- Use GetRaceMask method
        local message = "Race ID: " .. raceId .. ", Race Mask: " .. raceMask
        player:SendBroadcastMessage(message)
        print(message) -- Log to server console
        return false -- prevent command from being parsed as a normal server command
    elseif command == "class" then
        local classId = player:GetClass()
        local classMask = player:GetClassMask() -- Use GetClassMask method
        local message = "Class ID: " .. classId .. ", Class Mask: " .. classMask
        player:SendBroadcastMessage(message)
        print(message) -- Log to server console
        return false -- prevent command from being parsed as a normal server command
    end
end

RegisterPlayerEvent(42, PlayerInfo.ShowPlayerInfo)
