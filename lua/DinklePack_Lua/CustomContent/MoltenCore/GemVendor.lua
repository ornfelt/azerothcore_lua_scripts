local npcid = 190016
local lavacore = 17011
local Red = {28458, 28459, 28461, 28462}
local Blue = {28464, 28465, 28466}
local Yellow = {28467, 28468, 28470}

local function PurchaseRedGem(event, player, creature, sender, intid, code, menu_id)
if (intid == 1) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Red[1], 1)
creature:SendUnitSay("Your +4 Strength Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 2) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Red[2], 1)
creature:SendUnitSay("Your +4 Agility Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 3) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Red[3], 1)
creature:SendUnitSay("Your +5 Spell Power Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 4) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Red[4], 1)
creature:SendUnitSay("Your +8 Attack Power Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
end

local function PurchaseBlueGem(event, player, creature, sender, intid, code, menu_id)
if (intid == 1) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Blue[1], 1)
creature:SendUnitSay("Your +6 Stamina Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 2) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Blue[2], 1)
creature:SendUnitSay("Your +4 Spirit Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 3) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Blue[3], 1)
creature:SendUnitSay("Your +2 Mp5 Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
end

local function PurchaseYellowGem(event, player, creature, sender, intid, code, menu_id)
if (intid == 1) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Yellow[1], 1)
creature:SendUnitSay("Your +4 Intellect Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 2) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Yellow[2], 1)
creature:SendUnitSay("Your +4 Crit Rating Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 3) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Yellow[3], 1)
creature:SendUnitSay("Your +4 Hit Rating Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
if (intid == 4) then
if (player:GetItemCount(lavacore) >= 3) then
player:RemoveItem(lavacore, 3)
player:AddItem(Yellow[4], 1)
creature:SendUnitSay("Your +4 Defense Rating Gem has been added to your inventory.", 0)
else
creature:SendUnitSay("You do not have enough Lava Cores.", 0)
end
end
end






local function OnGossipHello(event, player, creature)
creature:SendUnitSay("Greetings " .. player:GetName() .. ", For 3 Lava Cores you can have any gem of your choosing.", 0)
player:GossipMenuAddItem(1, "|TInterface\\Icons\\inv_misc_gem_ruby_03:50:50:-43:0|tPurchase Red Gems", 0, 1)
player:GossipMenuAddItem(1, "|TInterface\\Icons\\inv_misc_gem_crystal_03:50:50:-43:0|tPurchase Blue Gems", 0, 2)
player:GossipMenuAddItem(1, "|TInterface\\Icons\\inv_misc_gem_topaz_03:50:50:-43:0|tPurchase Yellow Gems", 0, 3)
player:GossipSendMenu(1, creature)
end

function OnGossipSelect(event, player, creature, sender, intid, code, menu_id)
if (intid == 1) then
player:GossipMenuAddItem(0, "+4 Strength Gem", 0, 11)
player:GossipMenuAddItem(0, "+4 Agility Gem", 0, 12)
player:GossipMenuAddItem(0, "+5 Spell Power Gem", 0, 13)
player:GossipMenuAddItem(0, "+8 Attack Power Gem", 0, 14)
player:GossipSendMenu(1, creature)
end
if (intid == 2) then
player:GossipMenuAddItem(0, "+6 Stamina Gem", 0, 21)
player:GossipMenuAddItem(0, "+4 Spirit Gem", 0, 22)
player:GossipMenuAddItem(0, "+2 Mp5 Gem", 0, 23)
player:GossipSendMenu(1, creature)
end
if (intid == 3) then
player:GossipMenuAddItem(0, "+4 Intellect Gem", 0, 31)
player:GossipMenuAddItem(0, "+4 Crit Rating Gem", 0, 32)
player:GossipMenuAddItem(0, "+4 Hit Rating Gem", 0, 33)
player:GossipMenuAddItem(0, "+4 Defense Rating Gem", 0, 34)
player:GossipSendMenu(1, creature)
end
if (intid == 11) then
PurchaseRedGem(event, player, creature, sender, 1, code, menu_id)
end
if (intid == 12) then
PurchaseRedGem(event, player, creature, sender, 2, code, menu_id)
end
if (intid == 13) then
PurchaseRedGem(event, player, creature, sender, 3, code, menu_id)
end
if (intid == 14) then
PurchaseRedGem(event, player, creature, sender, 4, code, menu_id)
end
if (intid == 21) then
PurchaseBlueGem(event, player, creature, sender, 1, code, menu_id)
end
if (intid == 22) then
PurchaseBlueGem(event, player, creature, sender, 2, code, menu_id)
end
if (intid == 23) then
PurchaseBlueGem(event, player, creature, sender, 3, code, menu_id)
end
if (intid == 31) then
PurchaseYellowGem(event, player, creature, sender, 1, code, menu_id)
end
if (intid == 32) then
PurchaseYellowGem(event, player, creature, sender, 2, code, menu_id)
end
if (intid == 33) then
PurchaseYellowGem(event, player, creature, sender, 3, code, menu_id)
end
if (intid == 34) then
PurchaseYellowGem(event, player, creature, sender, 4, code, menu_id)
end
end

RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)
