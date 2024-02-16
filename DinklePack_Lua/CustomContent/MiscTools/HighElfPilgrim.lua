local HighElfPilgrim = {}

HighElfPilgrim.entry = 100152

function HighElfPilgrim.GossipHello(event, player, unit)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Tell me about yourself, Pilgrim.", 0, 1)
    player:GossipSendMenu(1, unit)
end

function HighElfPilgrim.GossipSelect(event, player, unit, sender, intid, code)
    player:GossipClearMenu()

    if (intid == 1) then
        unit:SendUnitSay("I am a High Elf who once lived in the beautiful city of Quel'Thalas. I have seen both peace and turmoil in my time, and I am now seeking refuge in Stormwind after the tragic events that have befallen my people.", 0)
        player:GossipMenuAddItem(0, "Why did you leave Quel'Thalas?", 0, 2)
    elseif (intid == 2) then
        unit:SendUnitSay("Our homeland was ravaged by conflict, and many of us were forced to flee. I chose to leave, seeking safety and a new beginning in Stormwind. I cherish the memories of my homeland, but I must now forge a new path.", 0)
        player:GossipMenuAddItem(0, "How has Stormwind been treating you?", 0, 3)
    elseif (intid == 3) then
        unit:SendUnitSay("Stormwind has been kind in welcoming me and others who sought refuge here. It is not without its challenges, but I have found solace in the presence of fellow High Elves, and I have been able to start anew.", 0)
        player:GossipMenuAddItem(0, "What are your thoughts on the Exiled Enclave?", 0, 4)
    elseif (intid == 4) then
        unit:SendUnitSay("The Exiled Enclave is a beacon of hope for us. It represents the unity and strength of our people in the face of adversity. I am grateful for the support Aquila provides and for the opportunity to be a part of this community.", 0)
        player:GossipMenuAddItem(0, "What do you miss most about your homeland?", 0, 5)
    elseif (intid == 5) then
        unit:SendUnitSay("I miss the beauty and serenity of Quel'Thalas, the vibrant forests, and the camaraderie of our people. But most of all, I miss the sense of belonging to a place where our history and culture thrived.", 0)
        player:GossipMenuAddItem(0, "Thank you for sharing your story. Stay strong.", 0, 6)
    elseif (intid == 6) then
        unit:SendUnitSay("Thank you for your kind words, traveler. It is heartening to see that there are still those who care. May our paths cross again in the future, and may fortune favor you on your journey.", 0)
    end

    player:GossipSendMenu(1, unit)
    if (intid == 6) then
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(HighElfPilgrim.entry, 1, HighElfPilgrim.GossipHello)
RegisterCreatureGossipEvent(HighElfPilgrim.entry, 2, HighElfPilgrim.GossipSelect)
