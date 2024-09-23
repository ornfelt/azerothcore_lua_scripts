local EventFixer = {}
EventFixer.holidayEventIds = {17, 91, 92}

-- add a boolean flag
EventFixer.hasScriptRun = false

local function FixEvents(eventId, delay, repeats, player)
    -- check the flag
    if EventFixer.hasScriptRun then
        print("Event Fix Script has already run, skipping...")
        return
    end

    if not player:IsInWorld() then
        return
    end

    print("Running Event Fix Script for the first time...")

    for _, eventId in ipairs(EventFixer.holidayEventIds) do
        local isHolidayActive = IsGameEventActive(eventId)

        if isHolidayActive then
            StopGameEvent(eventId)
            StartGameEvent(eventId)
        end
    end
    
    -- set the flag to true after the first run
    EventFixer.hasScriptRun = true
    print("Event Fix Script run complete, will not run again until server restart")
end

local function FixItOnPlayerLogin(event, player)
    player:RegisterEvent(FixEvents, 2000, 1) -- 2 seconds delay
end

RegisterPlayerEvent(3, FixItOnPlayerLogin)
