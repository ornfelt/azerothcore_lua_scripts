--[[ 
  World of Warcraft Teleportation NPC Script
  Created by: WoWEmuBot
  Script Function:
    This script adds functionality to a custom NPC that acts as a teleporter for players.
    It features a paginated gossip menu that displays different teleport destinations.
    Destinations can have optional level restrictions and be designated as faction-specific or shared.
  Script Capabilities:
    - Display a dynamic list of teleport locations including shared and faction-exclusive ones.
    - Implement level restrictions for certain teleport locations.
    - Provide a paginated menu to navigate through the list of locations if there are more than the displayed limit.
    - Utilize an integer-based ID system to represent shared (-1), Alliance (0), and Horde (1) factions.
--]]

-- Initialize Constants
local NPC_ID = 500000 -- Replace with your custom NPC entry ID
local MAX_OPTIONS_PER_PAGE = 10
local GOSSIP_PAGE_NEXT = 1000
local GOSSIP_PAGE_PREV = 1001

-- Initialize Teleport Locations with Level Restrictions (if any) and Faction
local teleports = {
    -- Format: {faction (-1 for all, 0 for Alliance, 1 for Horde), "Location Name", mapId, x, y, z, orientation, minimumLevel (optional)}
    {-1, "Dalaran", 571, 5809.55, 503.975, 657.526, 2.38338},
    {0, "Stormwind", 0, -8842.09, 625.358, 94.0867, 1},
    {1, "Orgrimmar", 1, 1570.24, -4413.66, 10, 0},
    -- Additional teleport locations...
}

-- Teleporter Handlers
local teleporter = {}

--[[
  Returns a table of teleport locations available to the player based on level and faction.
  Parameters:
      player - The player object.
  Returns:
      A table of teleport locations that the player has access to.
]]
function teleporter.GetAvailableTeleports(player)
    local playerLevel = player:GetLevel()
    local playerFaction = player:GetTeam()
    local availableTeleports = {}  -- Table to store available locations

    for _, v in ipairs(teleports) do
        local faction, name, mapId, x, y, z, orientation, minLevel = unpack(v)
        local isFactionCorrect = faction == -1 or faction == playerFaction
        local isLevelEnough = minLevel == nil or playerLevel >= minLevel

        if isFactionCorrect and isLevelEnough then
            table.insert(availableTeleports, v)
        end
    end

    return availableTeleports
end

--[[
  Calculates and returns pagination details for a given list size and page number.
  Parameters:
      listSize - The total number of items in the list.
      page - The current page number being displayed.
  Returns:
      The calculated maximum number of pages, start index, and end index of items for the current page.
]]
function teleporter.GetPageInformation(listSize, page)
    local maxPage = math.ceil(listSize / MAX_OPTIONS_PER_PAGE)
    local startIndex = (page - 1) * MAX_OPTIONS_PER_PAGE + 1
    local endIndex = math.min(startIndex + MAX_OPTIONS_PER_PAGE - 1, listSize)
    return maxPage, startIndex, endIndex
end

--[[
  Determines whether 'Previous' and 'Next' paging options should be shown based on the current page
  and total pages.
  Parameters:
      currentPage - The current page number in the pagination sequence.
      maxPage - The total number of pages available.
  Returns:
      Two boolean values indicating whether the 'Previous' and 'Next' options should be shown, respectively.
]]
function teleporter.ShouldShowPagingOptions(currentPage, maxPage)
    local showPrevious = currentPage > 1
    local showNext = currentPage < maxPage
    return showPrevious, showNext
end

--[[
  Displays a paginated gossip menu of teleport locations to the player.
  Parameters:
      player - The player for whom the gossip menu is being displayed.
      unit - The NPC unit that is the source of the gossip.
      currentPage - The current page number to display.
]]
function teleporter.ShowTeleportMenu(player, unit, currentPage)
    local availableTeleports = teleporter.GetAvailableTeleports(player)
    local maxPage, startIndex, endIndex = teleporter.GetPageInformation(#availableTeleports, currentPage)

    for i = startIndex, endIndex do
        local v = availableTeleports[i]
        player:GossipMenuAddItem(0, v[2], 0, i)  -- v[2] is the 'Location Name'
    end

    local showPrevious, showNext = teleporter.ShouldShowPagingOptions(currentPage, maxPage)
    if showPrevious then
        player:GossipMenuAddItem(7, "< Previous", currentPage - 1, GOSSIP_PAGE_PREV)
    end
    if showNext then
        player:GossipMenuAddItem(7, "Next >", currentPage + 1, GOSSIP_PAGE_NEXT)
    end

    player:GossipSendMenu(1, unit)
end

--[[
  Teleports the player based on their selected destination from the gossip menu.
  Parameters:
      player - The player to teleport.
      selection - The selected teleport destination index.
]]
function teleporter.TeleportPlayer(player, selection)
    local availableTeleports = teleporter.GetAvailableTeleports(player)
    local destination = availableTeleports[selection]
    local mapId, x, y, z, orientation = destination[3], destination[4], destination[5], destination[6], destination[7]
    player:Teleport(mapId, x, y, z, orientation)
end

-- Event Handlers and NPC Registration
function teleporter.OnGossipHello(event, player, unit)
    teleporter.ShowTeleportMenu(player, unit, 1) -- Start from page 1
end

function teleporter.OnGossipSelect(event, player, unit, sender, intid, code)
    if intid == GOSSIP_PAGE_NEXT or intid == GOSSIP_PAGE_PREV then
        teleporter.ShowTeleportMenu(player, unit, sender)  -- 'sender' is the new page number
    else
        teleporter.TeleportPlayer(player, intid)
    end
    player:GossipComplete()
end

RegisterCreatureGossipEvent(NPC_ID, 1, teleporter.OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, teleporter.OnGossipSelect)
