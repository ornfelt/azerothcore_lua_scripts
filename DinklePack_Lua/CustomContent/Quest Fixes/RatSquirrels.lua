local PlayerKillRatSquirrel = {}

PlayerKillRatSquirrel.CREATURE_IDS = {
    CREATURE1 = 1412,
    CREATURE2 = 4075
}

PlayerKillRatSquirrel.ITEM_IDS = {
    ITEM1 = 800071,
    ITEM2 = 800072
}

function PlayerKillRatSquirrel.OnPlayerKillCreature(event, killer, killed)
    if (killed:GetEntry() == PlayerKillRatSquirrel.CREATURE_IDS.CREATURE1) then
        killer:AddItem(PlayerKillRatSquirrel.ITEM_IDS.ITEM1, 1)
    elseif (killed:GetEntry() == PlayerKillRatSquirrel.CREATURE_IDS.CREATURE2) then
        killer:AddItem(PlayerKillRatSquirrel.ITEM_IDS.ITEM2, 1)
    end
end

RegisterPlayerEvent(7, PlayerKillRatSquirrel.OnPlayerKillCreature)
