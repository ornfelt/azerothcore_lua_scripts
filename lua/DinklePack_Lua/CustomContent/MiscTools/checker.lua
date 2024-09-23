--[[

local PlayerDetails = {}
PlayerDetails.ENABLE_SCRIPT = false -- Set this to true to enable the script, false to disable
PlayerDetails.EVENT_ID = 3 -- ID for the Player Login event

local function OnPlayerLogin(event, player)
    -- Get race mask, class mask, team, and faction for the player
    local raceMask = player:GetRaceMask()
    local classMask = player:GetClassMask()
    local team = player:GetTeam()
    local faction = player:GetFaction()
    local class = player:GetClass() -- Added class variable
    local race = player:GetRace() -- Added race variable

    -- Print the results to the World Server console
    print("Player " .. player:GetName() .. " logged in with the following details:")
    print("Race Mask: " .. raceMask)
    print("Class Mask: " .. classMask)
    print("Team ID: " .. team .. " (" .. (team == 0 and "Alliance" or "Horde") .. ")")
    print("Faction ID: " .. faction)
    print("Class ID: " .. class) -- Added print for class
    print("Race ID: " .. race) -- Added print for race

    -- Check and print the player's skills from 1 to 900
    for skill_id = 1, 900 do
        local skill_value = player:GetSkillValue(skill_id)
        if skill_value > 0 then
            print("Skill ID " .. skill_id .. " Value: " .. skill_value)
        end
    end

    -- Check and print the player's items from 1 to 10,000
    for entry_id = 1, 10000 do
        local item = player:GetItemByEntry(entry_id)
        if item then
            local item_name = item:GetName()
            print("Item ID " .. entry_id .. " Name: " .. item_name .. " Count: " .. item:GetCount())
        end
    end

    -- Check and print the player's equipped items for all equipment slots
    for slot = 0, 18 do
        local equippedItem = player:GetEquippedItemBySlot(slot)
        if equippedItem then
            print("Equipped Item at Slot " .. slot .. ": ID " .. equippedItem:GetEntry() .. " Name: " .. equippedItem:GetName())
        end
    end

    -- Check and print the player's spells with spell IDs from 1 to 80,000
    for spell_id = 1, 80000 do
        if player:HasSpell(spell_id) then
            print("Spell ID " .. spell_id)
        end
    end
end

if PlayerDetails.ENABLE_SCRIPT then
    RegisterPlayerEvent(PlayerDetails.EVENT_ID, OnPlayerLogin)
end

]]
