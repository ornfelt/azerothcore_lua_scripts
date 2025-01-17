local triviaQuestionsFile = {}

triviaQuestionsFile.triviaQuestions = {
    {points = 3, question = "What is the main capital city of the Night Elves?", answer = {"Darnassus"}},
    {points = 4, question = "Which zone is home to the dwarven city of Ironforge?", answer = {"Dun Morogh"}},
    {points = 6, question = "What is the name of the dragon aspect who turned into Deathwing?", answer = {"Neltharion"}},
    {points = 5, question = "Which race's starting zone is Mulgore?", answer = {"Tauren"}},
    {points = 4, question = "Who is the king of Stormwind during the events of World of Warcraft?", answer = {"King Varian Wrynn", "Varian Wrynn"}},
    {points = 3, question = "What is the name of the zone where The Dark Portal is located?", answer = {"Blasted Lands"}},
    {points = 5, question = "Who is the leader of the Horde in Vanilla?", answer = {"Thrall"}},
    {points = 7, question = "Which dungeon is located in the Swamp of Sorrows?", answer = {"Sunken Temple"}},
    {points = 6, question = "What is the name of the raid where players fight against Ragnaros?", answer = {"Molten Core"}},
    {points = 4, question = "What is the main capital city of the Horde?", answer = {"Orgrimmar"}},
    {points = 8, question = "Which race is known for their engineering skills and mechanical creations?", answer = {"Gnomes", "Gnome"}},
    {points = 9, question = "Who is the final boss of the Karazhan raid?", answer = {"Prince Malchezaar", "Malchezaar"}},
    {points = 5, question = "Which city is the main hub for the undead Forsaken?", answer = {"Undercity"}},
    {points = 8, question = "Who is the leader of the Argent Dawn?", answer = {"Tirion Fordring", "Tirion"}},
    {points = 7, question = "Which zone contains the Scarlet Monastery?", answer = {"Tirisfal Glades"}},
    {points = 5, question = "What is the name of the Lich King's sword?", answer = {"Frostmourne"}},
    {points = 4, question = "Which raid boss is known for their phrase 'Bone Storm!'?", answer = {"Lord Marrowgar"}},
    {points = 4, question = "Which city is known as the 'City of Mages'?", answer = {"Dalaran"}},
    {points = 10, question = "Which raid boss in the Burning Crusade expansion is known for their phrase 'You are not prepared'?", answer = {"Illidan Stormrage", "Illidan"}},
    {points = 5, question = "Which class uses totems as a primary source of their abilities?", answer = {"Shaman"}},
    {points = 3, question = "Who is the leader of the Blood Elves?", answer = {"Lor'themar Theron", "Lor'themar", "Lorthemar", "Lorthemar Theron"}},
    {points = 4, question = "What is the name of the continent where the starting zones for the Alliance races are located?", answer = {"Eastern Kingdoms"}},
    {points = 6, question = "In the Wrath of the Lich King expansion, which zone is the starting area for Death Knights?", answer = {"Eastern Plaguelands"}},
    {points = 7, question = "Who is the final boss of the Icecrown Citadel raid?", answer = {"The Lich King", "Lich King"}},
    {points = 5, question = "What is the name of the main capital city of the Draenei?", answer = {"The Exodar", "Exodar"}},
    {points = 8, question = "Which raid instance is found in the zone of Zangarmarsh?", answer = {"Serpentshrine Cavern"}},
    {points = 9, question = "What is the name of the faction that players gain reputation with by completing quests in Silithus?", answer = {"Cenarion Circle"}},
    {points = 4, question = "What is the name of the faction that primarily consists of pirates located in Booty Bay?", answer = {"Bloodsail Buccaneers", "Bloodsail Buccaneer"}},
    {points = 6, question = "Which dungeon is found in the Western Plaguelands?", answer = {"Scholomance"}},
    {points = 5, question = "What is the name of the zone where you can find the Scarlet Crusade's headquarters?", answer = {"Tirisfal Glades"}},
    {points = 7, question = "Which class is known for their ability to stealth?", answer = {"Rogue"}},
    {points = 8, question = "Which city is the main capital of the Blood Elves?", answer = {"Silvermoon City", "Silvermoon"}},
    {points = 4, question = "Which race's starting zone is Teldrassil?", answer = {"Night Elf", "Night Elves", "Nelf"}},
    {points = 6, question = "What is the name of the dungeon located in Stranglethorn Vale?", answer = {"Zul'Gurub", "ZulGurub", "Zul Gurub"}},
    {points = 6, question = "Which class is known for their use of demonic pets?", answer = {"Warlock"}},
    {points = 5, question = "Which faction is led by Highlord Bolvar Fordragon?", answer = {"Alliance"}},
    {points = 7, question = "What is the name of the main villain in the Wrath of the Lich King expansion?", answer = {"Arthas Menethil", "Arthas"}},
    {points = 4, question = "Which area is known for its red rocks and towering cliffs?", answer = {"Redridge Mountains"}},
    {points = 6, question = "Who is the leader of the Scourge?", answer = {"The Lich King", "Lich King"}},
    {points = 5, question = "What is the name of the main capital city in the Burning Crusade expansion?", answer = {"Shattrath City", "Shattrath"}},
    {points = 8, question = "What is the name of the area where the Amani trolls reside?", answer = {"Zul'Aman"}},
    {points = 3, question = "Which zone is the starting area for the Dwarves?", answer = {"Dun Morogh"}},
    {points = 7, question = "Which raid boss is known for their fiery dragon form and volcanic lair?", answer = {"Onyxia"}},
    {points = 8, question = "Which zone is known to have a giant Fel Reaver roaming the land?", answer = {"Hellfire Peninsula"}},
    {points = 6, question = "Which faction do players primarily align with in the zone of Durotar?", answer = {"Horde"}},
    {points = 5, question = "What is the name of the instance where players can fight against Nefarian?", answer = {"Blackwing Lair"}},
    {points = 7, question = "Which zone is home to the giant mushrooms and the Sporeggar faction?", answer = {"Zangarmarsh"}},
    {points = 8, question = "What is the name of the city that floats above the zone of Crystalsong Forest?", answer = {"Dalaran", "Dalaran City"}},
    {points = 9, question = "Which World of Warcraft faction is based in the Eastern Plaguelands and fights against the undead Scourge?", answer = {"Argent Dawn"}},
    {points = 10, question = "What is the name of the event where players could open the gates of Ahn'Qiraj?", answer = {"The Shifting Sands", "Shifting Sands"}},
    {points = 3, question = "Which zone would you find the dungeon, Razorfen Kraul?", answer = {"The Barrens"}},
    {points = 9, question = "Who is the leader of the Forsaken?", answer = {"Sylvanas Windrunner", "Sylvanas"}},
    {points = 6, question = "What is the name of the dungeon where players fight against the blood elf Kael'thas Sunstrider?", answer = {"Magisters' Terrace", "Magisters Terrace"}},
    {points = 4, question = "Which zone is known for its jungles and trolls?", answer = {"Stranglethorn Vale"}},
    {points = 3, question = "Who is the leader of the Night Elves?", answer = {"Tyrande Whisperwind"}},
    {points = 5, question = "Which class can learn to tame beasts as companions?", answer = {"Hunter"}},
    {points = 8, question = "Which raid boss is found at the end of the Black Temple?", answer = {"Illidan Stormrage", "Illidan"}},
    {points = 4, question = "Which class can use totems for various buffs and abilities?", answer = {"Shaman"}},
    {points = 2, question = "Which World of Warcraft expansion introduced the continent of Northrend?", answer = {"Wrath of the Lich King", "WOTLK"}},
    {points = 7, question = "Which zone contains the ruins of Lordaeron?", answer = {"Tirisfal Glades"}},
    {points = 8, question = "Which race has the starting zone of Eversong Woods?", answer = {"Blood Elf", "Blood Elves", "Belf"}},
    {points = 9, question = "Who is the final boss in the Sunwell Plateau raid?", answer = {"Kil'jaeden", "Kiljaeden"}},
    {points = 4, question = "Which class is known for their shapeshifting abilities?", answer = {"Druid"}},
    {points = 3, question = "Who is the leader of the Tauren?", answer = {"Cairne Bloodhoof"}},
    {points = 5, question = "Which city is known for being a sanctuary for all players?", answer = {"Shattrath City", "Shattrath"}},
    {points = 7, question = "What is the name of the undead zone in the Eastern Kingdoms where the Scarlet Monastery is located?", answer = {"Tirisfal Glades"}},
    {points = 8, question = "Which faction is known for their animosity towards the undead?", answer = {"Scarlet Crusade"}},
    {points = 6, question = "What is the name of the lich king's former human identity?", answer = {"Arthas Menethil", "Arthas"}},
    {points = 9, question = "Who is the leader of the Cenarion Circle?", answer = {"Malfurion Stormrage", "Malfurion"}},
    {points = 10, question = "Which event marked the transition from Vanilla to The Burning Crusade?", answer = {"The Dark Portal Opens", "Dark Portal Opens"}},
    {points = 4, question = "Which city is known for its grand library and magical artifacts?", answer = {"Dalaran", "Dalaran City"}},
    {points = 7, question = "Which dungeon is located in the Burning Steppes?", answer = {"Blackrock Depths"}},
    {points = 5, question = "What is the name of the dragonflight that protects the Emerald Dream?", answer = {"Green Dragonflight"}},
    {points = 8, question = "Who is the final boss of the Naxxramas raid?", answer = {"Kel'Thuzad", "KelThuzad"}},
    {points = 9, question = "Which World of Warcraft expansion introduced flying mounts?", answer = {"The Burning Crusade", "Burning Crusade"}},
    {points = 6, question = "Who is the leader of the Kirin Tor?", answer = {"Rhonin"}},
    {points = 7, question = "Which faction is based in the Undercity?", answer = {"Undead", "Forsaken"}},
    {points = 5, question = "What is the name of the zone where the entrance to Blackwing Lair is located?", answer = {"Burning Steppes"}},
    {points = 10, question = "Who is the leader of the Dragonmaw clan in Outland?", answer = {"Warlord Zaela"}},
    {points = 4, question = "Who is the leader of the Night Elves' military forces?", answer = {"Malfurion Stormrage"}},
    {points = 7, question = "Which class can summon and control demons?", answer = {"Warlock"}},
    {points = 6, question = "What is the name of the zone where the Black Temple is located?", answer = {"Shadowmoon Valley"}},
    {points = 5, question = "Which city serves as a neutral hub for both Alliance and Horde players?", answer = {"Shattrath City", "Shattrath"}},
    {points = 3, question = "What is the starting zone for the Orcs?", answer = {"Durotar", "Valley of Trials"}},
    {points = 8, question = "Which raid boss is known for their necrotic powers and icy lair?", answer = {"The Lich King", "Lich King"}},
    {points = 9, question = "Who is the leader of the Argent Dawn?", answer = {"Tirion Fordring", "Tirion"}},
    {points = 4, question = "Which city is known for its towering spires and elven architecture?", answer = {"Silvermoon City", "Silvermoon"}},
    {points = 4, question = "Which class uses the spell 'Heroic Strike'?", answer = {"Warrior"}},
    {points = 9, question = "What is the name of the Titan facility in the Storm Peaks?", answer = {"Ulduar"}},
    {points = 3, question = "What is the name of the orc who founded Orgrimmar?", answer = {"Thrall"}},
    {points = 8, question = "Which artifact weapon does the Highlord of the Silver Hand wield?", answer = {"Ashbringer"}},
    {points = 3, question = "What are the two main continents in the original World of Warcraft?", answer = {"Kalimdor and Eastern Kingdoms", "Eastern Kingdoms and Kalimdor", "Kalimdor Eastern Kingdoms", "Eastern Kingdoms Kalimdor"}},
    {points = 5, question = "Which race can communicate with animals?", answer = {"Night Elf", "Night Elves", "Nelf"}},
    {points = 7, question = "Who betrayed the Alliance and led to the opening of the Dark Portal?", answer = {"Medivh"}},
    {points = 6, question = "What is the name of the fortress in the heart of Icecrown?", answer = {"Icecrown Citadel"}},
    {points = 5, question = "Who was the first wielder of Ashbringer?", answer = {"Alexandros Mograine", "Mograine"}},
    {points = 7, question = "Which dungeon is located in the Caverns of Time?", answer = {"Old Hillsbrad Foothills", "Black Morass"}},
    {points = 9, question = "Who is the leader of the Naaru?", answer = {"A'dal"}},
    {points = 6, question = "Which race has the racial ability 'Will of the Forsaken'?", answer = {"Undead", "Forsaken"}},
    {points = 8, question = "What is the name of the dragon aspect of time?", answer = {"Nozdormu"}},
    {points = 4, question = "Which zone is known for its lush forests and ancient night elf ruins?", answer = {"Ashenvale"}},
    {points = 5, question = "What is the name of the troll city located in Stranglethorn Vale?", answer = {"Zul'Gurub"}},
    {points = 3, question = "Which class can use 'Death Grip'?", answer = {"Death Knight"}},
    {points = 7, question = "Who was the first death knight?", answer = {"Teron'gor", "Teron Gorefiend"}},
    {points = 6, question = "Which horde faction is based in the Hellfire Peninsula?", answer = {"Thrallmar"}},
    {points = 6, question = "Which alliance faction is based in the Hellfire Peninsula?", answer = {"Honor Hold"}},
    {points = 8, question = "Who is the final boss of the Blackwing Lair raid?", answer = {"Nefarian"}},
    {points = 5, question = "Which city is known for its gardens and tranquil nature?", answer = {"Darnassus"}},
    {points = 9, question = "Who is the leader of the Illidari?", answer = {"Illidan Stormrage", "Illidan"}},
    {points = 4, question = "Which race has the racial ability 'Stoneform'?", answer = {"Dwarf"}},
    {points = 6, question = "Which faction is led by Sylvanas Windrunner?", answer = {"Undead", "Forsaken"}},
    {points = 7, question = "Which zone is known for its marshlands and hydras?", answer = {"Dustwallow Marsh"}},
    {points = 3, question = "Which class can use 'Divine Shield'?", answer = {"Paladin"}},
    {points = 5, question = "Who is the leader of the Ebon Blade?", answer = {"Darion Mograine", "Mograine"}},
    {points = 9, question = "What is the name of the dragon who guards the Caverns of Time?", answer = {"Anachronos"}},
    {points = 4, question = "Which city is known for its alchemy and potions?", answer = {"Undercity"}},
    {points = 5, question = "What is the name of the night elf who became the first druid?", answer = {"Malfurion Stormrage", "Malfurion"}},
    {points = 8, question = "Who is the final boss of the Ulduar raid?", answer = {"Yogg-Saron", "Yogg Saron"}},
    {points = 9, question = "Which World of Warcraft expansion introduced the Death Knight class?", answer = {"Wrath of the Lich King", "WOTLK"}},
    {points = 6, question = "Who is the leader of the Trolls in Durotar?", answer = {"Vol'jin"}},
    {points = 7, question = "Which faction is known for their loyalty to the Horde?", answer = {"Frostwolf Clan"}},
    {points = 5, question = "What is the name of the demon lord who leads the Burning Legion?", answer = {"Sargeras"}},
    {points = 10, question = "Who is the final boss of the Sunwell Plateau?", answer = {"Kil'jaeden", "Kiljaeden"}},
    {points = 4, question = "Which class can use the spell 'Fireball'?", answer = {"Mage"}},
    {points = 7, question = "Which faction is known for their resilience and determination?", answer = {"Dwarves"}},
    {points = 6, question = "Who is the leader of the Burning Blade clan?", answer = {"Jubei'thos"}},
    {points = 8, question = "Which raid boss is known for their ability to mind control players?", answer = {"C'Thun", "Cthun"}},
    {points = 9, question = "Who is the leader of the Blackrock orcs?", answer = {"Rend Blackhand"}},
    {points = 4, question = "Which class can use the spell 'Chain Lightning'?", answer = {"Shaman"}},
    {points = 6, question = "Who is the leader of the Scarlet Crusade?", answer = {"Grand Crusader Dathrohan"}},
    {points = 5, question = "What is the name of the night elf who became the first warden?", answer = {"Maiev Shadowsong", "Maiev"}},
    {points = 8, question = "Who is the final boss of the Trial of the Crusader raid?", answer = {"Anub'arak", "Anubarak"}},
    {points = 6, question = "Who is the leader of the Mag'har orcs?", answer = {"Grommash Hellscream", "Grommash"}},
    {points = 7, question = "Which faction is known for their connection to the elements?", answer = {"Earthen Ring"}},
    {points = 4, question = "Which class can use the spell 'Shadow Bolt'?", answer = {"Warlock"}},
    {points = 7, question = "Which faction is known for their connection to the Emerald Dream?", answer = {"Cenarion Circle"}},
    {points = 6, question = "Who is the leader of the Dragonmaw clan?", answer = {"Zaela"}},
    {points = 5, question = "What is the name of the capital city of the Draenei?", answer = {"The Exodar", "Exodar"}},
    {points = 8, question = "Which raid boss is known for their ability to control time?", answer = {"Murozond"}},
    {points = 9, question = "Who is the leader of the Black Dragonflight?", answer = {"Deathwing"}}
}

return triviaQuestionsFile