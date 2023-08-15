--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


-- Things to do : Add more Songs/sounds!!!!

function Music_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(100, player, 1)
pUnit:GossipMenuAddItem(0, "Power of the Horde!", 1, 0)
pUnit:GossipMenuAddItem(0, "Religious Music", 2, 0)
pUnit:GossipMenuAddItem(0, "War Drums", 3, 0)
pUnit:GossipMenuAddItem(0, "MURLOC!!!", 4, 0)
pUnit:GossipMenuAddItem(0, "Wooot? Illidan??", 5, 0)
pUnit:GossipMenuAddItem(0, "Lament of the highbourne", 6, 0)
pUnit:GossipSendMenu(player)
end


function Music_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:SendChatMessage(14, 0, "LETS ROCK!")
pUnit:PlaySoundToSet(11803)
pUnit:GossipComplete(player)
end

if (intid == 2) then
pUnit:SendChatMessage(12, 0, "Relax and listen...")
pUnit:PlaySoundToSet(11699)
pUnit:GossipComplete(player)
end

if (intid == 3) then
pUnit:SendChatMessage(12, 0, "Let the Drums began!")
pUnit:PlaySoundToSet(11704)
pUnit:GossipComplete(player)
end

if (intid == 4) then
pUnit:SendChatMessage(12, 0, "Rgrglrgrlgrl")
pUnit:PlaySoundToSet(11802)
pUnit:GossipComplete(player)
end

if (intid == 5) then
pUnit:SendChatMessage(14, 0, "You are not prepared!")
pUnit:PlaySoundToSet(11466)
pUnit:GossipComplete(player)
end

if (intid == 6) then
pUnit:SendChatMessage(12, 0, "Sylvanas sings for you.")
pUnit:PlaySoundToSet(11896)
pUnit:GossipComplete(player)
end
end

RegisterUnitGossipEvent(190004, 1, "Music_OnGossipTalk")
RegisterUnitGossipEvent(190004, 2, "Music_OnGossipSelect")
