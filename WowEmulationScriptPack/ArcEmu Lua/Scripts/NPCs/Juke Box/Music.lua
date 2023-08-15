            --[[******************************                              
                *                            *
                *   The FrostTeam Project    *                 
                *                            *
                ******************************                        
                

        FrostTeam SVN consists of the latest WotLK
        scripts, both Lua and C++. Some will be our own,
        some will be others with credits attatched. Our
        Svn includes all scripts that you may need
        to help make your server a more fun environment.--

---------------------------//----------------------------------------------

function Music_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(100, player, 1)
pUnit:GossipMenuAddItem(0, "Power of the Horde!", 1, 0)
pUnit:GossipMenuAddItem(0, "Religious Music", 2, 0)
pUnit:GossipMenuAddItem(0, "War Drums", 3, 0)
pUnit:GossipMenuAddItem(0, "MURLOC!!!", 4, 0)
pUnit:GossipMenuAddItem(0, "Wooot? Illidan??", 5, 0)
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
end

RegisterUnitGossipEvent(*NPC ID*, 1, "Music_OnGossipTalk")
RegisterUnitGossipEvent(*NPC ID*, 2, "Music_OnGossipSelect")