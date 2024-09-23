local function hasItem90000(player)
return player:GetItemCount(90000) > 0
end

-- Remove custom starter items
local function removeItems(player)
local removed = false
local items = {60002, 10594, 65000}
for _, entry in ipairs(items) do
local itemCount = player:GetItemCount(entry)
if itemCount > 0 then
for i = 0, itemCount - 1 do
player:RemoveItem(entry, 1)
end
removed = true
end
end
return removed
end

-- Remove Murky
local function removeSpell(player)
	player:RemoveSpell(24939)
    player:RemoveSpell(100117)
    player:RemoveSpell(100118)
	player:RemoveSpell(100105)
end

-- Script body
local function onLogin(event, player)
if hasItem90000(player) then
if removeItems(player) then
player:SendBroadcastMessage("Welcome to Hardcore Mode. Please watch your step!")
end
removeSpell(player)
end
end

-- Register the script to be triggered on player login
RegisterPlayerEvent(3, onLogin)