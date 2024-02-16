local Ragged = {}

Ragged.Jon_Entry = 9563 

local Dialogues = {
    [1] = {"Windsor was particularly ornery that day - and believe me, for Windsor, that's a monumental accomplishment. He kept telling me that 'something feels off.' Well, he wasn't kidding! We were in the middle of Blackrock Mountain when the filthy animals attacked. I'm talking about the orcs, of course. Pay attention, will ya? All you could hear were the grunts and the clanging of steel as they rushed us.", "So what did you do?", 2},
    [2] = {"Me versus fifty orcs? I'm no fool, %s. My pappy always told me, 'Discretion is the better part of valor,' or something, and I knew what that meant.", "Start making sense, dwarf. I don't want to have anything to do with your cracker, your pappy, or any sort of 'discreditin'.", 3},
    [3] = {"Alright, alright. Anyhow, so I sorta slipped into the shadows. That didn't sit too well with Windsor, seeing as how he was already extra cranky. Well he started spinnin' old Ironfoe around and screaming like a mad man at the orcs.", "Ironfoe?", 4},
    [4] = {"Yep. You never heard of Ironfoe? The legendary orc slaying hammer? Yep, yep, that was ol' Windsor's hammer. He told me that Franclorn Forgewright himself made that hammer for his great, great, grand pappy. THE Franclorn Forgewright. The Dark Iron responsible for stonewrought architecture... building stuff. He also said the hammer had a twin that Franclorn kept for himself. Think he called it Ironfel or something.", "Interesting... continue, John.", 5},
    [5] = {"So where was I? Oh yea, so the orcs rushed Windsor and Windsor? Well, he didn't move an inch. He stood tall as they charged him, ten at a time. All I could see was the glow from Ironfoe and a lot of blood. This went on for hours, maybe days. I don't remember. Anyhow, FINALLY, it stopped.", "So that's how Windsor died...", 6},
    [6] = {"Died? Are you cracked, %s? Excuse me, %s %s! Windsor wouldn't have died from no fifty orcs. As sure as Thelsamar blood sausage is the tastiest food the world may ever know, there he stood: he was covered in orc chunks from head to toe, drenched in about eighteen layers of their blood, but he was definitely alive... and really, really angry.", "So how did he die?", 7},
    [7] = {"Why do you keep saying he died? Who told you he died? I never said he died. He went missing is all. You see, apparently we had gotten into the middle of some big orc versus Dark Iron dwarf battle. The orcs, being the filthy miserable curs that they are, were out early, setting up some traps and other diabolical things you probably wouldn't understand.", "Ok, so where the hell is he? Wait a minute! Are you drunk?", 8},
    [8] = {"Dwarves don't get drunk, %s. I'm just a little sloppy. Anyhow, Windsor? I figure he's somewhere in the Blackrock Depths. That's the Dark Iron City for you uneducated peoples.", "WHY is he in Blackrock Depths?", 9},
    [9] = {"Slow down! I was getting to that! So there he was, standing tall with all the blood and guts dripping off him when who shows up? The Dark Irons! Didn't you hear a word I said?? Well, the Dark Irons are a little craftier than those Blackrock Orcs. They came prepared. By prepared I mean there were about 300 of em... *hic* 'scuse me.", "300? So the Dark Irons killed him and dragged him into the Depths?", 10},
    [10] = {"%s, if I didn't know better, I'd think you were one of those 'special' peoples. We call 'em Troggs. Windsor didn't have no beef with the Dark Irons, after all, his great, great, grand pappy's best friend was a Dark Iron. Which is also probably why that army of Dark Irons didn't kill him on sight.", "Ahhh... Ironfoe.", 11},
    [11] = {"Finally! Put some fingers in your ears, your brain mighta just grown five sizes and I'm worried it might leak out. So the Dark Irons spared his life and took him prisoner. Their leader, some self-important, took Ironfoe for himself. And that was the last I saw of ol' Windsor... *hic* 'scuse me.", "Thanks, Ragged John. Your story was very uplifting and informative.", 12},
    [12] = {"You're welcome! If you need any more stories or a swig of ale, you know where to find me!", nil, nil}
}

function Ragged.Jon_GossipHello(event, player, unit)
    player:GossipClearMenu()
    
    if player:HasQuest(4224) then
        player:GossipMenuAddItem(0, "Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him.", 0, 1)
    else
        player:GossipAddQuests(unit)
    end
    
    player:GossipSendMenu(2713, unit)
end

function Ragged.Jon_GossipSelect(event, player, unit, sender, intid, code)
    player:GossipClearMenu()
    
    if Dialogues[intid] then
        local dialogue = Dialogues[intid]
        local playerName = player:GetName()
        local playerAddress = player:GetGender() == 0 and "master" or "miss"
        unit:SendUnitSay(string.format(dialogue[1], playerName, playerAddress, playerName), 0)
        
        if dialogue[2] then
            player:GossipMenuAddItem(0, dialogue[2], 0, dialogue[3])
            player:GossipSendMenu(2713, unit)
        else
            player:CompleteQuest(4224)
            player:GossipComplete()
        end
    end
end

RegisterCreatureGossipEvent(Ragged.Jon_Entry, 1, Ragged.Jon_GossipHello)
RegisterCreatureGossipEvent(Ragged.Jon_Entry, 2, Ragged.Jon_GossipSelect)
