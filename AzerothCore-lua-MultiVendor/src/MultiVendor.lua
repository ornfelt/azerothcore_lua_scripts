--[[Script done by Psychonautek(Krisande#5411 @ Discord)]]-- 

local EVENT_ONGOSSIPHELLO       = 1
local EVENT_ONGOSSIPSELECT      = 2

local NPC_MULTIVENDOR           = 200000
local VENDOR_ID1                = -- insert your vendor id from npc_vendor table here!
local VENDOR_ID2                = -- insert another vendor id from npc_vendor table here! 

-- in case you want to add more vendors just add them via local VENDOR_ID3, local VENDOR_ID4 and so on =)

local function MultiVendorOnGossipHello(event, player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(1, "Change the text here!", 1, 1)
    player:GossipMenuAddItem(1, "Change the text here!", 1, 2)
    -- to add more gossip items just copy a line up above and change the last value in there... so if you copy the line with 2 at the end... make the 2 a 3 and so on =)
    player:GossipMenuAddItem(1, "Close", 1, 100)
    player:GossipSendMenu(1, creature, 1)
end

local function MultiVendorOnGossipSelect(event, player, creature, sender, intid, code, menu_id)
    if (intid == 1) then
        player:SendListInventory(creature, VENDOR_ID1) 
    elseif (intid == 2) then
        player:SendListInventory(creature, VENDOR_ID2) 
        -- to add more selection options just copy the line up above, change the intid according to the last number value at the GossipMenuAddItem and change the vendorid =)
    
    elseif (intid == 100) then
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(NPC_MULTIVENDOR, EVENT_ONGOSSIPHELLO, MultiVendorOnGossipHello)
RegisterCreatureGossipEvent(NPC_MULTIVENDOR, EVENT_ONGOSSIPSELECT, MultiVendorOnGossipSelect)
