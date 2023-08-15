function BarrettRamseyPartOne_OnGossipTalk(Unit, Event, Player)
local race=Player:GetPlayerRace()

  if race==1 or race==3 or race==4 or race==7 or race==11 then		--alliance
    Unit:GossipCreateMenu(100, Player, 0)
    Unit:GossipMenuAddItem(0, "We are ready.", 1, 0)
    Unit:GossipSendMenu(Player)

  elseif race==2 or race==5 or race==6 or race==8 or race==10 then	--horde
    Unit:GossipCreateMenu(100, Player, 0)
    Unit:GossipMenuAddItem(0, "We are ready.", 2, 0)
    Unit:GossipSendMenu(Player)
end
end




function BarrettRamseyPartOne_OnGossipSelect(Unit, Event, Player, MenuId, id, Code)

if (id == 1) then
    Unit:SpawnCreature(34796, 563, 173, 395, 4.710035, 16, 0)
    Unit:SpawnCreature(360951, 563, 78, 419, 4.4070, 35, 0)	--spawn the one with alliance drops
    Unit:Despawn(1, 0)
    Unit:GossipComplete(Player)

elseif (id == 2) then
    Unit:SpawnCreature(54796, 563, 173, 395, 4.710035, 16, 0)
    Unit:SpawnCreature(360951, 563, 78, 419, 4.4070, 35, 0)	--spawn the one with horde drops
    Unit:Despawn(1, 0)
    Unit:GossipComplete(Player)
end
end

RegisterUnitGossipEvent(34816, 1, "BarrettRamseyPartOne_OnGossipTalk")
RegisterUnitGossipEvent(34816, 2, "BarrettRamseyPartOne_OnGossipSelect")