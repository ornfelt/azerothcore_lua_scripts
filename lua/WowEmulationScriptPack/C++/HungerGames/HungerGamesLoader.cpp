#include "ScriptMgr.h"
#include "HungerGamesStore.h"

void HungerGamesPeriodUpdateQueue(void *p, void *)
{
    CP_MAP_PERIODIC_UPDATE *params = PointerCast(CP_MAP_PERIODIC_UPDATE, p);
    if (params->map == NULL)
        return;

    for (auto itr = HungerGameStores.begin(); itr != HungerGameStores.end(); itr++)
    {
        if(params->map->GetId() == (*itr)->GetMap())
            (*itr)->UpdateHungerGameStatus(params->map);
    }
}

void AddHGQueueScripts();
void AddHGZoneProtectScripts();
void HGInitGurubashi();
void AddHugerGamesLootMonitorScripts();
void HGInitAzsharaCrater();
void AddHungerGamesScripts()
{
    // Queue NPC
    // INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123459, 0, 0, 0, 0, 0, 4259, 4260, 4601, 4602, 'Hunger Games queue', '', '', 0, 80, 80, 0, 35, 3, 1, 1.14286, 2, 0, 0, 2000, 2000, 1, 1, 1, 768, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 'HungerGamesQueueNPC', 12340);
    // Queue NPC offer queue
    // INSERT INTO npc_text (id,text0_0) VALUES (98,"The hunger games queue is closed for now. Wait for the current match to finish.");
    // INSERT INTO npc_text (id,text0_0) VALUES (99,"The hunger games is a free for all PVP game. The player that survives the event will be the winner. You start without items. As time goes chests will spawn that you can loot for items");
    // Lootable chest
    // INSERT INTO `gameobject_template` VALUES (5, 3, 259, 'Survival Kit', '', '', '', 1, 57, 2277, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);
    // item for each class : every quality with highest possible level, Every possible slot, Every possible armor type, Every possible weapon type
    // NPC to give XP to players
    // INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123461, 0, 0, 0, 0, 0, 21505, 0, 0, 0, 'XP reward', '', '', 0, 1, 1, 0, 189, 0, 1, 1.2286, 0.7, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
    // INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123462, 0, 0, 0, 0, 0, 18561, 18255, 18256, 18257, 'Spell reward', '', '', 0, 1, 1, 0, 189, 0, 1, 1.2286, 0.7, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
    // INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123463, 0, 0, 0, 0, 0, 14732, 0, 0, 0, 'Aura reward', '', '', 0, 1, 1, 0, 189, 0, 1, 1.2286, 0.7, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);
    // INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123464, 0, 0, 0, 0, 0, 21984, 0, 0, 0, 'Item reward', '', '', 0, 1, 1, 0, 189, 0, 1, 1.2286, 0.7, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);

    //return; // disabled until fully tested
    //register a new periodic update
    RegisterCallbackFunction(CALLBACK_TYPE_MAP_PERIODIC_UPDATE, HungerGamesPeriodUpdateQueue, NULL);

    AddHGQueueScripts();
    AddHGZoneProtectScripts();
    AddHugerGamesLootMonitorScripts();
    HGInitGurubashi();
    HGInitAzsharaCrater();
    /*
    possible custom maps:
    Azshara Crater:
    Map: 37 X: 1003 Y: 281 Z: 327
    - Notes: Azshara Crater was meant to be a battleground, but was seemingly quit by Blizzard. It's good for a big instance, or possibly a whole zone.

    Old Scarlet Monastary:
    Map: 44 X: 77 Y: -1 Z: 20
    - Notes: Very good location! Perfect for an instance. Only two graphic bugs exist. One, the entrance leads to nothing. Should be blocked. Two, when you enter a specific room, the screen will flicker a bit.

    Stormwind Vault:
    Map: 35 X: -1 Y: 52 Z: -27
    - Notes: This one's one of the best locations. Mostly because there is an actual working entrance in Stormwind. Of course, the tower with the entrance is locked off by gates and guards, but you can make some sort of portal or teleport to there.

    Karazhan Crypts:
    Map: 0 X: -11069 Y: -1795 Z: 54
    - Notes: Like luuh, I'll start off with giving a warning. This place is creepy. So, don't get scared, or scare your players, down here. This location is not instanced. This place is probably good for an outdoor raid, or something similar. Could also be used for a normal zone, although, it's not very big, and there's some annoying invisible wall blocking the way down here, so you might want to consider that.

    Old Ironforge:
    Map: 0 X: -4821 Y: -975 Z: 464
    - Notes: This place isn't very big, and is most likely suited for a boss lair or some sort of mall. Keep in mind, if players fall down, they need a way to get up. Would be kind of annoying to be stuck in the lava.

    Secret Deadmines:
    Map: 36 X: -1650 Y: 549 Z: 7
    - Notes: Now, this is a strange place. I don't really see the use of it, but you might be able to use it for something. Keep in mind, it's instanced.

    Emerald Dream:
    Map: 169 X: 458 Y: -377 Z: 92
    - Notes: This, boys and girls, is the biggest instance you will will encounter in WoW/TBC. It consists of several areas that I will list below. These coordinates are for the main area, where you can go in different directions to get to different strange places. I personally think this place is awesome.

    Emerald Forest:
    Map: 169 X: 2965 Y: -3040 Z: 98
    - Notes: This is probably the most finished part you'll find in Emerald Dream, except for the Emerald Mountains, as I call them. The place basically consists of a hill with floating tress. Were these used in Old Outland? Anyway, I think this place would fit good for a normal zone, on MaNGOS that is. As far as I know, Ascent doesn't use an instance template in the DB?

    Emerald Plains:
    Map: 169 X: -3824 Y: 3367 Z: 133
    - Notes: Now, this is the weirdest place of Emerald Dream. Believe me, you'll see what I mean. I don't know if this place is of any use, but you could always try to make it useful somewhere along the lines...

    Emerald Mountains:
    Map: 169 X: 3225 Y: 3046 Z: 23
    - Notes: This is the second most awesome place of Emerald Dream. It consists of beatiful areas in between huge mountains. I must say, the terrain designers did a killer's job here. This area could be vital if using the Emerald Dream zone.

    Verdant Fields:
    Map: 169 X: -1650 Y: -577 Z: 125
    - Notes: This is also a weird place, really. It's sort of a platform of a very strange sort of terrain. Don't really know what this could be used for, other than a huge area with mobs.

    Elwynn Falls:
    Map: 0 X: -8322 Y: -340 Z: 145
    - Notes: This seems to be a closed area of Elwynn Forest, and may be used for general stuffs such as mobs and quests, as in, general leveling.

    Northern Plaguelands:
    Map: 0 X: 3852 Y: -3565 Z: 45
    - Notes: This is the area surrounded by the Plagueland areas. It's completely empty, and has one damn annoying fog, so it could be used for some scary outdoor boss raid, I guess.

    Graymane Area:
    Map: 0 X: -979 Y: 1579 Z: 52
    - Notes: This is the awesome area past the big annoying gate in Silverpine Forest. If you can find a neat way to get here, it would probably be good for some sort of city.

    Isolated Dun Morogh
    Map: 0 X: -4897 Y: 836 Z: 390
    - Notes: As Cursed mentioned, this area would be good for a linear instance. It's very open, and as far as I know, normally inaccessible from the outside. Not instanced, though.

    Arathi Highlands Farm
    Map: 0 X: -1817 Y: -4205 Z: 3
    - Notes: Not much to say. I'd probably use it for some sort of secret hideout, as it's a nice little isolated place.

    Naxxramas Secret
    Map: 533 X: 3598 Y: -4523 Z: 198
    - Notes: This is a very strange place, really. I guess it can be used as an instance? It's very snowy and could remind you of Northrend.

    Isolated Wetlands Town
    Map: 0 X: -4037 Y: -1408 Z: 157
    - Notes: This place is awesome! You can have your own little closed town here. Only thing is, you need to close that tunnel leading to nothing.

    Instanced Altar Of Storms
    Map: 309 X: -12029 Y: -2584 Z: -29
    - Notes: This place is nothing like the real Altar Of Storms. It's sort of a maze that can be used for a small instance, as it's instanced in Zul'Gurub. You'll love it. Believe me.

    Uninstanced Ahn'Qiraj
    Map: 1 X: -9479 Y: 1783 Z: 49
    - Notes: This is sort of a big ruin valley. What makes it awesome is that it's extremely huge, has a dark fog, and is outside! I really like this place, and it could easily be used for a leveling zone.

    Isolated Burning Steppes
    Map: 0 X: -7815 Y: -4266 Z: 131
    - Notes: Just another isolated location in Azeroth.

    Isolated Elwynn Forest
    Map: 0 X: -8322 Y: -340 Z: 145
    - Notes: Just another isolated location in Azeroth.

    Sunspire Top
    Map: 530 X: 177 Y: -6410 Z: 10363
    - Notes: Just the top of the Sunspire. Might be useful for something, I guess. Personally, I once used it for a portal park, or whatever you'd call it.

    Isolated Tirisfal Glades
    Map: 0 X: 2074 Y: 2306 Z: 131
    - Notes: Just another isolated location in Azeroth.

    Tiger Mount Place
    Map: 0 X: -12878 Y: -1408 Z: 120
    - Notes: This is the place in Strangethorn Vale where people thought you could get a tiger mount. Could be useful, maybe? No idea, up to you.

    Above Undercity Glitch
    Map: 0 X: 1545 Y: 150 Z: 61
    - Notes: You can get here by using a certain glitch in Ruins Of Lordaeron. Anyway, I doubt this is really useful, but yah, you could always try to make it become something. Thanks to Spzatt for the glitch in the first place.

    Blackchar Cave
    Map: 0 X: -7347 Y: -642 Z: 294
    - Notes: Now, this is a strange place indeed! It's just a little cave that isn't really good for anything other than a mall, maybe? I find it kind of funny, though. For some reason, on retail, Blizzard does a very good job to keep you out of here...

    Ortell's Hideout
    Map: 0 X: -5314 Y: -2512 Z: 484
    - Notes: Just some strange cave in the mountains. Could be some sort of special event place, maybe?

    Wetlands Help Mountain
    Map: 0 X: -3857 Y: -3485 Z: 579
    - Notes: Not useful, really. Just kind of awesome. You'll see.

    The Room
    Map: 1 X: 16227 Y: 16403 Z: -64
    - Notes: The GM Island jail! You got to get Cursed's The Chair gameobject if you're going to use this.

    Newman's Landing
    Map: 0 X: -6166 Y: -772 Z: 421
    - Notes: Also just some random place at some random water. You could always make a mall here.

    Instanced Silverpine Forest
    Map: 33 X: -588 Y: 1087 Z: 108
    - Notes: The name says it all.

    Instanced Tanaris
    Map: 209 X: 1075 Y: 860 Z: 9
    - Notes: Again, name says all. HOWEVER! Take a look at the ocean here... Or more like, half of Tanaris. You'll get it.
    */
}
