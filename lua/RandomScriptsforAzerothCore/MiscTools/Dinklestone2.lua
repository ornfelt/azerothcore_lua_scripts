function OnGossipHello(event, player, item)
    player:GossipMenuAddItem(0, "|TInterface\\icons\\achievement_boss_lichking:37:37:-23|t|cff007d45Manage Scourge Events|r", 150, 0)
    player:GossipMenuAddItem(0, "|TInterface\\icons\\inv_misc_book_11:37:37:-23|t|cff007d45General Information|r", 200, 0)
    player:GossipSendMenu(1, item)
end

local function OnGossipSelect(event, player, item, sender, intid, code)
    player:GossipClearMenu()

    if (sender == 150) then
        -- Show Scourge Event menu
        player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionhappy:37:37:-23|t|cff007d45Start Event for Bonus Lich Runes|r", 1, 100)
        player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionsad:37:37:-23|t|cffC41F3BStop Event but Suffer|r", 1, 101)
        player:GossipMenuAddItem(0, "Back", 999, 0)
        player:GossipSendMenu(1, item)
		
    elseif (sender == 200) then
        -- Show Information menu
        player:GossipMenuAddItem(0, "1. Tell me more about Scourge Invasions", 2, 201)
        player:GossipMenuAddItem(0, "2. How can I participate in Scourge Invasions?", 2, 202)
        player:GossipMenuAddItem(0, "3. What are the rewards for Scourge Invasions?", 2, 203)
        player:GossipMenuAddItem(0, "4. How often do you plan on updating?", 2, 204)
		player:GossipMenuAddItem(0, "5. I found something that's broken. What do I do?", 2, 205)
		player:GossipMenuAddItem(0, "6. It looks like Khyle is coming out with a new HD pack, do you plan on making your repack compatible with it again?", 2, 206)
		player:GossipMenuAddItem(0, "7. How do I access flying for free?", 2, 207)
		player:GossipMenuAddItem(0, "8. What content will your next big update contain?", 2, 208)
		player:GossipMenuAddItem(0, "9. I'm seeing a lot of red messages in the World Server Window, do I need to worry?", 2, 209)
		player:GossipMenuAddItem(0, "10. Will NPC Bots ever get functionality in BGs? And why aren't there any wandering bots in Outland or Northrend?", 2, 210)
		player:GossipMenuAddItem(0, "11. Do I have to worry about my class getting nerfed or significantly altered?", 2, 210)
		player:GossipMenuAddItem(0, "12. Is there anything I can help with?", 2, 212)
        player:GossipMenuAddItem(0, "Back", 999, 0)
        player:GossipSendMenu(1, item)
    elseif (sender == 1 and (intid == 100 or intid == 101)) then
        -- Start or Stop the event based on intid
        if intid == 100 then
            -- Start the event
            if IsGameEventActive(17) then
                player:GossipMenuAddItem(0, "The Scourge event is already active.", 100, 0)
                player:GossipMenuAddItem(0, "Back", 150, 0)
                player:GossipSendMenu(1, item)
            else
                player:AddItem(43949, 2)
                StartGameEvent(17, true)
                player:PlayDirectSound(14797)
                player:GossipComplete()
            end
        elseif intid == 101 then
            -- Stop the event
            if not IsGameEventActive(17) then
                player:GossipMenuAddItem(0, "The Scourge event is not currently active.", 101, 0)
                player:GossipMenuAddItem(0, "Back", 150, 0)
                player:GossipSendMenu(1, item)
            else
                StopGameEvent(17, true)
                player:CastSpell(player, 15007, true)
                player:RemoveItem(43949, 2)
                player:SetLevel(player:GetLevel())
                player:SendBroadcastMessage("2 Lich Runes have been removed, you've been given Resurrection Sickness and have lost your current level's experience progress. So sad :(")
                player:PlayDirectSound(14776)
                player:GossipComplete()
            end
        end
    elseif (sender == 2 and intid >= 201 and intid <= 212) then
        local responseText = {
            [201] = "Scourge invasions are a thematic element to this server as the goal is to create a more cohesive tie between the original three expansions. Obviously this only one aspect of creating that tie. \n\nOriginal elements from vanilla scourge invasions are being restored and some are already available, primarily for lower levels, but new additions and rewards have been made to make the invasion more threatening and meaningful. As time goes on, more events will be added and more of the original content will be restored and modified. \n\nAt present, the conceptualization of Scourge Events is in its early infancy. During the event, excepting in Outland and players below level 15, players will also be attacked randomly by various undead. These events occur every 7 hours and last 2 hours. \n\nScourge Dungeon bosses have been restored for these events, and you'll even find a few new raid bosses as well (one for right now, more later). The latter will not require the scourge invasion to be active to kill, and any additional non-blizz bosses will also not need the Scourge Event to be active.",
            [202] = "At present, Scourge Invasions have been created for Orgrimmar, Stormwind, Westfall, Lakeshire and Crossroads. The largest events are those in capital cities, where you can pick up unique buffs for the duration of the event. Each area has unique challenges, quests, and rewards. If you have ideas for ways to improve Scourge Events or features you'd like to see added, message Dinkledork on Discord. I always needs more creative ideas. \n\nPlease keep in mind that major city invasions, particularly Orgrimmar, are somewhat machine intensive so you may need to reduce graphics if you're not on a decent computer. Skalathrax pumps out some serious amount of spells and other than the AQ War Event, I doubt I'll be making such a hardware-demanding event in the future. \n\nStormwind will likely be getting a bit of an overhaul as I originally made that event prior to expanding the world for flying.",
            [203] = "Rewards can be found from primary quest givers in both major capital cities, Stormwind and Orgrimmar, namely Archbishop Benedictus in the Cathedral of Light, and Grand Apothecary Putress near Thrall's room. They will offer you both familiar and unique rewards in exchange for a currency tied to the event, Lich Runes.",
            [204] = "I plan on releasing new content no less than once a month. Some releases will have more content than others. I may end up being faster but at present am only a one-man development team. If anyone with some art skills would like to help, I'd love to speak with you as I'm primarily just decent at coding. Again you can message Dinkledork on Discord.",
			[205] = "The benefit of being a lua junkie is that I don't have to recompile and redistribute everything again. This means I can address issues typically pretty quickly and with as little interruption as possible on the fly. \n\nIf you found an error or issue with gameplay, you can post in the repack-talk section of my discord. Same if you're experiencing any issues with your client. I'm always more than happy to help and odds are if you're experiencing an issue, others are as well, so I'd like to keep all issues tracked in that particular Discord channel. \n\nIf you happen to be experiencing visual or sound bugs and are using Khyle's V6 HD pack, please delete Patch-K.",
			[206] = "Let me just say that I love Khyle's work and will do everything possible to make my server compatible with it. \n\nThat said, it is unlikely as I will be implementing a number of new races that will not be compatible with is work. If his worked happened to be open source and not encrypted, then that would be a different issue, but unfortunately he has not made his content publically viewable. So I'll be attempting to create my own HD pack as a result.",
			[207] = "I've left instructions on how to do so under the help section of Discord. I even added pretty pictures :)",
			[208] = "1. I'm hoping to have updates for BWL in place, such as new bosses, modified existing bosses, and new rewards. \n\n2. I plan on adding rewards for reaching level 60 in Hardcore Mode. \n\n3. New Class spells and power-ups. \n\n4. A route to additional winged flight Ranks implemented. \n\n5. New Race-Class Combos. \n\n6.Hillsbrad Scourge/PvP event as well as some other outdoor Horde vs. Alliance content. \n\n7.At least getting started on Bizmo's Brawler's Guild.\n\n8. Additional Scourge-Themed dungeon bosses. \n\n9. More unique mounts and items. \n\n10. Updating Professions to be more vanilla/tbc like. \n\n11. Giving hybrid classes more options for tier sets in Tiers 1-3. \n\n12. Taking a look at old tier sets and readjusting the set bonuses to be closer in line with what they were originally. (Sorry Paladins but you won't be able to spam Lay on Hands). \n\n13. Hoping to get started with filling out Stormwind's empty new areas with npcs. \n\n14. Additional Scourge Event rewars. \n\n15. At least 6 new playable races. \n\nPlease keep in mind that I do have a day job, am married, and a 9-month old child so I may not reach everything on that list by the next update, but you can bet I'll make it to everything on that list eventually.",
			[209] = "Nah. That's pretty much an info log and it's mostly for wandering NPC Bot actions. If you've played the Cmangos SPP servers, you'll know this to be the case. \n\nYou'll also notice the server yelling at you for other things on occasion, a lot of these caused by mods, but again these aren't things that will hinder the game in any way. The only things you need to worry about are 'Assertion Failed' messages. If you can, screenshot those and send them to me. n\nThat said, I am trying to add more of the new areas to the area table dbc so if you come accross an 'unknown area' and your worldserver is yelling at you, do .gps and send me the area id.",
			[210] = "I don't know man, I don't develop the bots in any way shape or form. Trickerer is the one who does that, and he's probably gotten those questions a number of times. I would say yes, eventually? \n\nThere has been some indication that wandering bots may not make it to Outland or Northrend but we'll see. Setting up waypoints for that crap is extremely time intensive. I'd be happy if we just get BG functionality soon. Either way, Trickerer has done an amazing job with the system and I'm very grateful for it.",
			[211] = "Not really no. If I feel like a change I made is breaking the game, then yes I'll have to take a look at it. But generally speaking I'll just make things more difficult if gameplay gets too easy due to class additions. \n\nWhile this is a singleplayer server and balance may be less of a concern, I'd rather the game be fun and enjoyable than just a complete faceroll. I'm a big fan of limitations. I believe the limitations in systems are what make those systems great. These limitations create heroic moments for the player, something that has been lost since the Classic era. \n\nThat said, I try to make all my crap configurable so you can play the way you want. I favor players playing the way they want so long as it doesn't adversely affect others in the community, and if I can make a config option out of it as a result, I will. Good examples of this are the unlimited ammo scripts and DK shield/dual wielding 2H weapons scripts, or the flying for free scripts. \n\nAs far as 'significantly altered' goes, I like to keep class gameplay the same overall rather than entirely reinventing the wheel. That said, if I can come up with a new viable spec, like Smite Priests, then I will so long as it doesn't kill another type of viable spec.",
			[212] = "More than anything, I like good ideas. If you have a good idea and want to see that implemented, please let me know. My best implementations come from you guys 100%. \n\nIf you have any good lua scripts, I'd also love those too. I like lua over C++ simply for ease of portability and on the fly changes, as well as easily being able to turn things on and off. \n\nIf you come accross a new, unknown area and your world.exe is yelling at you, please also .gps where you are and send me the area id. That would be extremely helpful.\n\nI guess one last thing I'll mention is that I will be starting a Patreon soon. If you have ideas for perks or would like to support me, I would love to give you something back in return. I do have a family to support so any support is awesome and greatly appreciated. I'll keep you posted on that one.",
		}
        player:GossipMenuAddItem(0, responseText[intid], intid, 0)
        player:GossipMenuAddItem(0, "Back", 200, 0)
        player:GossipSendMenu(1, item)
elseif (sender == 999) then
    OnGossipHello(event, player, item)
    else
        player:GossipComplete()
    end
end

RegisterItemGossipEvent(65001, 1, OnGossipHello)
RegisterItemGossipEvent(65001, 2, OnGossipSelect)


