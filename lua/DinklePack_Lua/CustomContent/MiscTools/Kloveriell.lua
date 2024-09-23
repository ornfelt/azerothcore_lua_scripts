local Kloveriell = {}

Kloveriell.NPC_ID = 100140

function Kloveriell.GossipHello(event, player, unit)
    player:GossipClearMenu()
    player:GossipAddQuests(unit)
    player:GossipMenuAddItem(0, "Tell me about yourself, Kloveriell.", 0, 1)
    player:GossipSendMenu(1, unit)
end

function Kloveriell.GossipSelect(event, player, unit, sender, intid, code)
    player:GossipClearMenu()
    if (intid == 1) then
        unit:SendUnitSay("I am a Paladin, once a Knight of the Silver Hand. My path has been one of honor, justice, and protection. I've seen battles, held comrades as they drew their last breath, and fought for peace. Serving alongside High Priestess Aquila Empyrean, I now strive to guard and counsel High Elves and Void Elves alike.", 0)
        player:GossipMenuAddItem(0, "How did you come to serve High Priestess Aquila Empyrean?", 0, 2)
    elseif (intid == 2) then
        unit:SendUnitSay("The Priestess and I share a similar outlook on the sanctity of our people and the realm. When she took a stance against Kael'thas, my honor dictated that I stand by her. Our paths converged, and here I serve to safeguard our ideals and values.", 0)
        player:GossipMenuAddItem(0, "I've heard you are a formidable Paladin. What advice do you have for aspiring Paladins?", 0, 3)
    elseif (intid == 3) then
        unit:SendUnitSay("The path of a Paladin is not for the faint of heart. It is a path where your faith will be tested and your resolve must be unyielding. Always be guided by the virtues of honor, compassion, and justice. Let the Light guide you, but never forget that the strength of your character is your truest shield.", 0)
        player:GossipMenuAddItem(0, "Can you tell me about your search for Tirion Fordring?", 0, 4)
    elseif (intid == 4) then
        unit:SendUnitSay("Ah, Tirion, a beacon of Light and my dearest friend. His disappearance has weighed heavy upon my soul. I ventured to the Eastern Plaguelands in search of him, and though I found no trace, the journey was not in vain. I would continue the search if the Priestess ever needs me not.", 0)
        player:GossipMenuAddItem(0, "What’s your role in the Silver Covenant?", 0, 5)
    elseif (intid == 5) then
        unit:SendUnitSay("I joined the Silver Covenant later in my years. My role there is much akin to my role here; a guardian and protector. The Silver Covenant stands for the preservation of High Elven culture and values, and I am honored to lend my sword and shield to their cause.", 0)
        player:GossipMenuAddItem(0, "Thank you for your time, Kloveriell. May the Light guide you.", 0, 6)
    elseif (intid == 6) then
        unit:SendUnitSay("Thank you, traveler. May the Light guide your path and may your heart remain steadfast in the face of darkness. Should you or the Priestess ever need assistance, know that my blade is at the ready.", 0)
        player:CastSpell(player, 25898, true)  
        player:GossipComplete()
    end
    if (intid ~= 6) then
        player:GossipSendMenu(1, unit)
    end
end

RegisterCreatureGossipEvent(Kloveriell.NPC_ID, 1, Kloveriell.GossipHello)
RegisterCreatureGossipEvent(Kloveriell.NPC_ID, 2, Kloveriell.GossipSelect)
