--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function initiand_gossipMenu (pUnit, Event, pPlayer)
  pUnit:GossipCreateMenu (100, pPlayer, 0)
  pUnit:GossipMenuAddItem (9, "I urge you to fight!", 1, 0)
  pUnit:GossipMenuAddItem (0, "Just want to say hello. *smile*", 2, 0)
  pUnit:GossipSendMenu (pPlayer)
end

function initiand_gossipMenu_Selection (pUnit, Event, pPlayer, ID, intID)
  if (intID == 2) then
        pPlayer:GossipComplete ()
        pUnit:SendChatMessage (8, 0, "*smile*")
  end

  if (intID == 1) then
        pUnit:SetFaction (14)
        pUnit:SendChatMessage (5, 0, "As you wish. Fight me! C'mon!")
  end
end

function initiand_getsAngry (pUnit, Event, pPlayer)
  pUnit:SetFaction (14)
end

function initiand_coolsDown (pUnit, Event, pPlayer)
  pUnit:SetFaction(2084)
end

RegisterUnitGossipEvent (28390, 1, "initiand_gossipMenu")
RegisterUnitGossipEvent (28390, 2, "initiand_gossipMenu_Selection")
RegisterUnitEvent (28390, 18, "initiand_coolsDown")
RegisterUnitEvent (28390, 2, "initiand_coolsDown")
RegisterUnitEvent (28390, 3, "initiand_coolsDown")
RegisterUnitEvent (28390, 4, "initiand_coolsDown")

RegisterUnitGossipEvent (28391, 1, "initiand_gossipMenu")
RegisterUnitGossipEvent (28391, 2, "initiand_gossipMenu_Selection")
RegisterUnitEvent (28391, 18, "initiand_coolsDown")
RegisterUnitEvent (28391, 2, "initiand_coolsDown")
RegisterUnitEvent (28391, 3, "initiand_coolsDown")
RegisterUnitEvent (28391, 4, "initiand_coolsDown")

RegisterUnitGossipEvent (28392, 1, "initiand_gossipMenu")
RegisterUnitGossipEvent (28392, 2, "initiand_gossipMenu_Selection")
RegisterUnitEvent (28392, 18, "initiand_coolsDown")
RegisterUnitEvent (28392, 2, "initiand_coolsDown")
RegisterUnitEvent (28392, 3, "initiand_coolsDown")
RegisterUnitEvent (28392, 4, "initiand_coolsDown")

RegisterUnitGossipEvent (28393, 1, "initiand_gossipMenu")
RegisterUnitGossipEvent (28393, 2, "initiand_gossipMenu_Selection")
RegisterUnitEvent (28393, 18, "initiand_coolsDown")
RegisterUnitEvent (28393, 2, "initiand_coolsDown")
RegisterUnitEvent (28393, 3, "initiand_coolsDown")
RegisterUnitEvent (28393, 4, "initiand_coolsDown")

RegisterUnitGossipEvent (28394, 1, "initiand_gossipMenu")
RegisterUnitGossipEvent (28394, 2, "initiand_gossipMenu_Selection")
RegisterUnitEvent (28394, 18, "initiand_coolsDown")
RegisterUnitEvent (28394, 2, "initiand_coolsDown")
RegisterUnitEvent (28394, 3, "initiand_coolsDown")
RegisterUnitEvent (28394, 4, "initiand_coolsDown")

RegisterUnitGossipEvent (28406, 1, "initiand_gossipMenu")
RegisterUnitGossipEvent (28406, 2, "initiand_gossipMenu_Selection")
RegisterUnitEvent (28406, 18, "initiand_coolsDown")
RegisterUnitEvent (28406, 2, "initiand_coolsDown")
RegisterUnitEvent (28406, 3, "initiand_coolsDown")
RegisterUnitEvent (28406, 4, "initiand_coolsDown")