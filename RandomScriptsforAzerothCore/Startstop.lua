--DO NOT DELETE ME! FIXES AN ANNOYING AF BUG

local holidayEventIds = {17, 91}

local function OnPlayerLogin(event, player)
    if not player:IsInWorld() then
        return
    end

    for _, eventId in ipairs(holidayEventIds) do
        local isHolidayActive = IsGameEventActive(eventId)

        if isHolidayActive then
            StopGameEvent(eventId)
            StartGameEvent(eventId)
        end
    end
end

RegisterPlayerEvent(3, OnPlayerLogin)
