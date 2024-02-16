local Elathalis = {}

Elathalis.NPC_ID = 1500017

function Elathalis.GossipHello(event, player, creature)
	player:GossipClearMenu()
	player:GossipAddQuests(creature)
    player:GossipMenuAddItem(0, "Who are you?", 0, 1)
    player:GossipSendMenu(1, creature)
end

function Elathalis.GossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        creature:SendUnitSay("My name is Elathalis Shadowcloud, a Void Elf priest, and a proud member of the Order of the Empyrean Void. I was once a student in Quel'Thalas, but after the fall of Silvermoon, I sought refuge in the Void.", 0)
        player:GossipMenuAddItem(0, "What is the Order of the Empyrean Void?", 0, 2)
    elseif intid == 2 then
        creature:SendUnitSay("The Order of the Empyrean Void is an organization created by High Priestess Aquila Empyrean. Our mission is to preserve the High Elven culture and values, while also exploring the mysteries of the Void. We believe in maintaining balance between the Light and Shadow, and strive to protect Azeroth from any threat that emerges.", 0)
        player:GossipMenuAddItem(0, "How did you join the Order?", 0, 3)
    elseif intid == 3 then
        creature:SendUnitSay("After being exiled from Quel'Thalas, I wandered Azeroth, seeking a new purpose. I came across the Exiled Enclave and met High Priestess Aquila Empyrean. Her wisdom and vision for unity between the Light and Shadow inspired me, and I decided to join the Order of the Empyrean Void to contribute my knowledge and skills to their cause.", 0)
        player:GossipMenuAddItem(0, "What are your thoughts on High Priestess Aquila Empyrean?", 0, 4)
    elseif intid == 4 then
        creature:SendUnitSay("High Priestess Aquila Empyrean is a true visionary. She's not only a leader but also a mentor for many of us in the Order. Her dedication to preserving our culture and exploring the potential of the Void is truly admirable. I am honored to be part of her legacy and to fight alongside her in the battles that lie ahead.", 0)
        player:GossipMenuAddItem(0, "Farewell.", 0, 5)
    elseif intid == 5 then
        creature:SendUnitSay("Farewell, traveler. May the Void guide you on your journey.", 0)
		player:CastSpell(player, 1244, true)
        player:GossipComplete()
    end
    
    player:GossipSendMenu(1, creature)
    if (intid == 5) then
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(Elathalis.NPC_ID, 1, Elathalis.GossipHello)
RegisterCreatureGossipEvent(Elathalis.NPC_ID, 2, Elathalis.GossipSelect)
