function BarrettRamseyPartTwo_OnGossipTalk(Unit, Event, Player)
local race=Player:GetPlayerRace()

  if race==1 or race==3 or race==4 or race==7 or race==11 then		--alliance
    Unit:GossipCreateMenu(100, Player, 0)
    Unit:GossipMenuAddItem(0, "We are ready for Wilfred's challenge.", 1, 0)
    Unit:GossipSendMenu(Player)

  elseif race==2 or race==5 or race==6 or race==8 or race==10 then	--horde
    Unit:GossipCreateMenu(100, Player, 0)
    Unit:GossipMenuAddItem(0, "We are ready for Wilfred's challenge.", 2, 0)
    Unit:GossipSendMenu(Player)
end
end




function BarrettRamseyPartTwo_OnGossipSelect(Unit, Event, Player, MenuId, id, Code)

if (id == 1) then
    Unit:SpawnCreature(360956, 563, 78, 419, 4.4070, 35, 0)	--spawn the one with alliance drops
    Unit:Despawn(1, 0)
    Unit:GossipComplete(Player)

elseif (id == 2) then
    Unit:SpawnCreature(560956, 563, 78, 419, 4.4070, 35, 0)	--spawn the one with horde drops
    Unit:Despawn(1, 0)
    Unit:GossipComplete(Player)
end
end

RegisterUnitGossipEvent(35035, 1, "BarrettRamseyPartTwo_OnGossipTalk")
RegisterUnitGossipEvent(35035, 2, "BarrettRamseyPartTwo_OnGossipSelect")