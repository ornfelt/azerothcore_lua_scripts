--------------------------------------------------
-------- Dalaran Sewer Guide Script V.1.0 --------
--  Created by Knaur@2008 Norwegian Elite Team  --
--     Our Web: http://www.chronos-wow.com      --
-- Made for ncdb, linked to Dalaran sewer guids --
--                                              --
--   Modifying is allowed as long as original   --
--    credits are not removed from this lua.    --
--------------------------------------------------
--------------------------------------------------

function On_GuideSewer(unit, event, player)
unit:GossipCreateMenu(1, player, 0)
unit:GossipMenuAddItem(0, "Arena", 2, 0)
unit:GossipMenuAddItem(0, "Bank", 3, 0)
unit:GossipMenuAddItem(0, "Inn", 4,  0)
unit:GossipMenuAddItem(0, "Sewer Exits", 5,  0)
unit:GossipMenuAddItem(0, "Vendors", 6, 0)
unit:GossipSendMenu(player)
end

function GuideSewer_Submenu(unit, event, player, id, intid, code)
if(intid == 1) then
unit:GossipCreateMenu(16, player, 0)
unit:GossipMenuAddItem(0, "Arena", 2, 0)
unit:GossipMenuAddItem(0, "Bank", 3, 0)
unit:GossipMenuAddItem(0, "Inn", 4,  0)
unit:GossipMenuAddItem(0, "Sewer Exits", 5,  0)
unit:GossipMenuAddItem(0, "Vendors", 6, 0)
unit:GossipSendMenu(player)
end

--arena
if(intid == 2) then
player:Teleport(571, 5774.95, 620.42, 565.40)
end

--Bank
if(intid == 3) then
player:Teleport(571, 5766.31, 731.66, 618.58)
end

--Inn
if(intid == 4) then
player:Teleport(571, 5761.06, 714.45, 618.54)
end

--sewer exits
if(intid == 5) then
unit:GossipCreateMenu(7, player, 0)
unit:GossipMenuAddItem(3, "There are three ways out of the Underbelly: Ramps leading up to the east and west, and the tunnel that drops out of the bottom of dalaran.", 5, 0)
unit:GossipMenuAddItem(3, "       ", 5, 0)
unit:GossipMenuAddItem(3, "Be sure you can fly before you take that tunnel, of course.", 5, 0)
unit:GossipMenuAddItem(3, "       ", 5, 0)
unit:GossipMenuAddItem(0, "Eastern Sewer Entrance", 8, 0)
unit:GossipMenuAddItem(0, "Western Sewer Entrance", 9, 0)
unit:GossipMenuAddItem(0, "Sewer Tunnel", 10, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

--vendors
if(intid == 6) then
player:Teleport(571, 5922.34, 567.34, 609.86)
end

--eastern sewer entrance
if(intid == 8) then
player:Teleport(571, 5801.77, 551.07, 649.27)
end

--western sewer entrance
if(intid == 9) then
player:Teleport(571, 5815.21, 762.65, 640.30)
end

-- sewer tunnel
if(intid == 10) then
player:Teleport(571, 5673.50, 838.33, 583.68)
end
end

RegisterUnitGossipEvent(32726, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32726, 1, "On_GuideSewer")
RegisterUnitGossipEvent(32727, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32727, 1, "On_GuideSewer")
RegisterUnitGossipEvent(32728, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32728, 1, "On_GuideSewer")
RegisterUnitGossipEvent(32729, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32729, 1, "On_GuideSewer")
RegisterUnitGossipEvent(32730, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32730, 1, "On_GuideSewer")
RegisterUnitGossipEvent(32731, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32731, 1, "On_GuideSewer")
RegisterUnitGossipEvent(32732, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32732, 1, "On_GuideSewer")
RegisterUnitGossipEvent(32733, 2, "GuideSewer_Submenu")
RegisterUnitGossipEvent(32733, 1, "On_GuideSewer")