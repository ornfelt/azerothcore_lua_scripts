local ScourgeEventsManager = {}

ScourgeEventsManager.Events = {17, 92}

function ScourgeEventsManager.OnGossipHello(event, player, item)
    player:GossipMenuAddItem(0, "|TInterface\\icons\\achievement_boss_lichking:45:45:-40|t|cff007d45Manage Scourge Events|r", 150, 0)
    player:GossipSendMenu(1, item)
end

function ScourgeEventsManager.OnGossipSelect(event, player, item, sender, intid)
    player:GossipClearMenu()

    if (sender == 150) then
        if player:GetLevel() > 14 then
            player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionhappy:45:45:-40|t|cff007d45Start Event for Bonus Lich Runes|r", 1, 100)
            player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionsad:45:45:-40|t|cffC41F3BStop Event but Suffer|r", 1, 101)
            player:GossipMenuAddItem(0, "Back", 999, 0)
            player:GossipSendMenu(1, item)
        else
            player:SendBroadcastMessage("You must be level 15 or higher to start or stop Scourge events.")
            player:GossipComplete()
        end
    elseif (sender == 1 and (intid == 100 or intid == 101)) then
        local isAnyEventActive = false
        for _, eventId in ipairs(ScourgeEventsManager.Events) do
            isAnyEventActive = isAnyEventActive or IsGameEventActive(eventId)
        end

        if intid == 100 then
            if isAnyEventActive then
                player:GossipMenuAddItem(0, "The Scourge event is already active.", 100, 0)
                player:GossipMenuAddItem(0, "Back", 150, 0)
                player:GossipSendMenu(1, item)
            else
                player:AddItem(43949, 2)
                for _, eventId in ipairs(ScourgeEventsManager.Events) do
                    StartGameEvent(eventId, true)
                end
                player:PlayDirectSound(14797)
                player:GossipComplete()
            end
        elseif intid == 101 then
            if not isAnyEventActive then
                player:GossipMenuAddItem(0, "The Scourge event is not currently active.", 101, 0)
                player:GossipMenuAddItem(0, "Back", 150, 0)
                player:GossipSendMenu(1, item)
            else
                for _, eventId in ipairs(ScourgeEventsManager.Events) do
                    StopGameEvent(eventId, true)
                end
                player:CastSpell(player, 15007, true)
                player:RemoveItem(43949, 2)
                player:SetLevel(player:GetLevel())
                player:SendBroadcastMessage("2 Lich Runes have been removed, you've been given Resurrection Sickness and have lost your current level's experience progress. So sad :(")
                player:PlayDirectSound(14776)
                player:GossipComplete()
            end
        end
    elseif (sender == 999) then
        ScourgeEventsManager.OnGossipHello(event, player, item)
    else
        player:GossipComplete()
    end
end

RegisterItemGossipEvent(65001, 1, ScourgeEventsManager.OnGossipHello)
RegisterItemGossipEvent(65001, 2, ScourgeEventsManager.OnGossipSelect)
