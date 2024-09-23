local IronmanChallenge = {}

IronmanChallenge.SPELL_ID = 80007
IronmanChallenge.IRONMAN_QUALITY_THRESHOLD = 2
IronmanChallenge.ITEM_ID = 800049
IronmanChallenge.BROADCAST_DELAY = 1 -- Delay in seconds
IronmanChallenge.FAILURE_SPELL_ID = 80090 

function IronmanChallenge.RemoveItemAndBroadcast(eventId, delay, repeats, player)
    player:RemoveItem(IronmanChallenge.ITEM_ID, 1) -- Remove the item from the player's inventory

    SendWorldMessage("|cFFFF0000" .. player:GetName() .. " has failed the Ironman challenge.|r")
    print(player:GetName() .. " has failed the Ironman challenge.")
    player:PlayDirectSound(183253)
    player:CastSpell(player, IronmanChallenge.FAILURE_SPELL_ID, true) 
end

function IronmanChallenge.OnEquip(event, player, item, bag, slot)
    if item:GetQuality() >= IronmanChallenge.IRONMAN_QUALITY_THRESHOLD and player:HasItem(IronmanChallenge.ITEM_ID) then
        player:RegisterEvent(IronmanChallenge.RemoveItemAndBroadcast, IronmanChallenge.BROADCAST_DELAY * 1000, 1, player) 
    end
end

RegisterPlayerEvent(29, IronmanChallenge.OnEquip)
