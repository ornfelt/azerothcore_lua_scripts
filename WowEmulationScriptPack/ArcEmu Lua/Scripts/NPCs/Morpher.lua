--[[

     This Lua is brought to you by zdroid9770
     
     © Copyright 2011 - 2012
]]

-- Things to do: Add more morphs Options!!!

function Morph_Gossip(unit, event, player)
        unit:GossipCreateMenu(100, player, 0)
        unit:GossipMenuAddItem(0,"illidan", 0, 0)
        unit:GossipMenuAddItem(0,"Dragon", 1, 0)
        unit:GossipMenuAddItem(0,"Spider", 2, 0)
		unit:GossipMenuAddItem(0,"Onyxia", 3, 0)
		unit:GossipMenuAddItem(0,"Human", 4, 0)
		unit:GossipMenuAddItem(0,"Mechanical", 5, 0)
        unit:GossipSendMenu(player)
end

function Morph_Submenus(unit, event, player, id, intid, code)
     if(intid == 0) then
        player:SetModel(21135)
        player:GossipComplete()

    elseif(intid == 1) then
        player:SetModel(20510)
        player:GossipComplete()

    elseif(intid == 2) then
        player:SetModel(15928)
        player:GossipComplete()

    elseif(intid == 3) then
        player:SetModel(36837)
        player:GossipComplete()

    elseif(intid == 4) then
        player:SetModel(21419)
        player:GossipComplete()

    elseif(intid == 5) then
        player:SetModel(33432)
        player:GossipComplete()
     end
end

RegisterUnitGossipEvent(5600, 1, "Morph_Gossip")
RegisterUnitGossipEvent(5600, 2, "Morph_Submenus")