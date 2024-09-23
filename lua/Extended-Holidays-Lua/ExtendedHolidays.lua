-- ========================================================
-- Holiday Event Control Script for AzerothCore with Eluna
-- ========================================================
-- This script allows server administrators to enable or disable 
-- specific in-game holidays. To use this script, update the 
-- HolidayStatus table to mark which holidays should be active 
-- (true) or inactive (false). The script will automatically 
-- start these events on server startup.
local HolidayEventControl = {}

-- Status of each holiday event (true = enabled, false = disabled)
HolidayEventControl.HolidayStatus = {
    Brewfest = false,
    ChildrensWeek = false,
    DarkmoonFaireElwynnForest = false,
    DarkmoonFaireMulgore = false,
    DarkmoonFaireTerokkarForest = false,
    DayOfTheDead = false,
    ElementalInvasions = false,
    GurubashiArenaBootyRun = false,
    HallowsEnd = false,
    HarvestFestival = false,
    L70ETCConcert = false,
    LoveIsInTheAir = false,
    LunarFestival = false,
    MidsummerFireFestival = false,
    NewYearsEve = false,
    Noblegarden = false,
    PilgrimsBounty = false,
    PiratesDay = false,
    PyrewoodVillage = false,
    WinterVeil = false,
    WinterVeilGifts = false,
    AQWarEffort = false -- Probably not working as intended
}


HolidayEventControl.HolidayEvents = {
    Brewfest = 24,
    ChildrensWeek = 10,
    DarkmoonFaireElwynnForest = 4,
    DarkmoonFaireMulgore = 5,
    DarkmoonFaireTerokkarForest = 3,
    DayOfTheDead = 51,
    ElementalInvasions = 13,
    GurubashiArenaBootyRun = 16,
    HallowsEnd = 12,
    HarvestFestival = 11,
    L70ETCConcert = 32,
    LoveIsInTheAir = 8,
    LunarFestival = 7,
    MidsummerFireFestival = 1,
    NewYearsEve = 6,
    Noblegarden = 9,
    PilgrimsBounty = 26,
    PiratesDay = 50,
    PyrewoodVillage = 25,
    WinterVeil = 2,
    WinterVeilGifts = 52,
    AQWarEffort = 22
}

local function EnableDisableHolidays()
    for holiday, eventId in pairs(HolidayEventControl.HolidayEvents) do
        if HolidayEventControl.HolidayStatus[holiday] then
            StartGameEvent(eventId, true)  
            print("Holiday Event Enabled: " .. holiday)  
        else
        end
    end
end

RegisterServerEvent(14, EnableDisableHolidays)
