local SocketEnchant = 37430 -- Socket Enchant Item ID
local RequiredItem = 17010 -- Fiery Cores ID. Can set this to whatever Item ID.
local RequiredAmount = 10 -- Example required Item amount
local ExchangeCount = 0 -- Keep track of the number of successful exchanges

local function OnGossipHello(event, player, creature)
player:GossipMenuAddItem(0, "|TInterface\\Icons\\inv_misc_gem_variety_01:50:50:-43:0|tPurchase gem sockets for your gear?", 0, 1) --can change "Fiery Cores" to whatever if you change requireditemid. Same with the dialogue below.
player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menuid)
if (intid == 1) then
local requiredAmount = RequiredAmount
creature:SendUnitSay("Exchanging " .. requiredAmount .. " Fiery Cores for a socket enchant. Are you sure, " .. player:GetName() .. "?", 0)
player:GossipMenuAddItem(0, "Yes", 0, 2)
player:GossipMenuAddItem(0, "No", 0, 3)
player:GossipSendMenu(1, creature)
elseif (intid == 2) then
if (player:GetItemCount(RequiredItem) >= RequiredAmount) then
player:RemoveItem(RequiredItem, RequiredAmount)
player:AddItem(SocketEnchant, 1)
creature:SendUnitSay("The socket enchant has been added to your inventory.", 0)
ExchangeCount = ExchangeCount + 1 -- Increase the number of successful exchanges
if (ExchangeCount >= 3) then -- If the number of successful exchanges is 3 or more
creature:SendUnitSay("Thanks a bunch! See you next week!", 0)
creature:DespawnOrUnsummon(1000) -- Despawn the creature with a 1 second delay
end
player:GossipComplete()
else
creature:SendUnitSay("You do not have enough Fiery Cores.", 0)
player:GossipComplete()
end
elseif (intid == 3) then
player:GossipComplete()
end
end

RegisterCreatureGossipEvent(190015, 1, OnGossipHello)
RegisterCreatureGossipEvent(190015, 2, OnGossipSelect)