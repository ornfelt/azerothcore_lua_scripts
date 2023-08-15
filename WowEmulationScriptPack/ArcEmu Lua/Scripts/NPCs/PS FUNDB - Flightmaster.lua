function Flightmaster_menu(pUnit, player)

    if (player:IsInCombat() == true) then
    player:SendAreaTriggerMessage("You are in combat!")
    else                          
    pUnit:GossipCreateMenu(100, player, 0)
    pUnit:GossipMenuAddItem(4, "I wish to reach the skies!", 2, 0)
    pUnit:GossipMenuAddItem(4, "I feel queezy, please get me down...", 3, 0)
    pUnit:GossipSendMenu(player)
    end
end
function OnSelect(pUnit, event, player, id, intid, code)

    if (intid == 2) then
    Player:SetFlying()
    Player:ModifyRunSpeed(21)
    player:SetModel(22841)
    end
    if (intid == 3) then
    player:SetMovementType(256)
    player:ModifyRunSpeed(7.5)
    player:SetModel(0)
    end
end
 
RegisterUnitGossipEvent(184515,1,"Flightmaster_menu")
RegisterUnitGossipEvent(184515,2,"OnSelect")