# MaloWBotLK
3.3.5 version of MaloWBot, specifically designed for the 'Wrath of the Multiboxer' private server: https://discord.gg/wwKfnKR

Currently, supports: All classes/specs except for Frost Deathknight.
It should be noted that the class rotations are designed around level 80. While it is very unlikely, you may encounter
weird behaviour at lower levels.

If you have just a little coding experience then adding more classes and specs or changing their rotations is easy by modifying the files in the /classes/ folder.

This addon requires Lua-unlocking to work, as it automates rotations. You can find a Lua-unlocker that MaloW coded in the above Discord Server in the #faq room.

The addon currently has a hard-coded check that realm-name is "LichKingMBW", and the addon is disabled if it's not. This is because I don't want to have it running when I play on other realms.
You are most likely to be banned anywhere other than our dedicated LichKingMBW server if you use this addon elsewhere.

# Installation instructions:
1. Download the files in this repository, and place the 3 folders in it inside your Interface/AddOns folder. 
2. Open MalowBotLK/Config.lua and modify it to your needs, the most important thing is to add your commander (the character you want to play on as your main) to the list of trusted characters.
3. Start your wows, and log each character in.
4. Run the Lua-unlocker.
5. Invite each character to your raid-group.
6. On your commander type /mb InitAsCommander
7. Everything should now be running for you, your slaves should follow you and assist you, and do their rotations.

# Useful things to set within MaloWBotLK/Config.lua:
1. mb_config.trustedCharacters -> Replace all names and add new rows as necessary to fill in your raid team.
2. mb_config.tanks = {"YourTank1", "YourTank2" ...}
3. mb_config.focusMagicTargets.first/second = "Target1"/"Target2"
4. mb_config.raidLayout -> Insert all of your raid members into the appropriate groups here by replacing the current names.
5. mb_config.statWeights -> If you wish to change the assigned stat weights used for the loot-council function then you can do that here.

Make sure to set mb_config.tanks, these values decides on whom the healers cast things like Beacon of Light. The mb_config.classOrder decides which member of the raid that should do what.
Each member of the raid of the same class is sorted alphabetically and given a class-order number based on that order. The mb_config.raidLayout stuff is used by running "/run mb_fixRaidSetupName = "25man";", it should automatically invite all those people to your raid and set FFA-loot, and in the future it will also automatically move people around to create the specific sub-groups specified here. 
The mb_config.statWeights stuff is used by "/mb lc [itemlink]" to make each raid-member say if they need an item that dropped.

By default each slave will have 2 macros automatically placed on their bars. The macro on button "1" will cause them to reload their UI. and the macro on button "2" will set their commander to nil, which means they stop following and assisting. This is useful if you need to break off a character and play it manually, maybe to mind-control some mob, or to off-tank some mob.
  
# Supported Commands through /mb:
Initialize the addon with you as commander and the rest of the raid as your slaves:  
/mb InitAsCommander

Remote-execute code on all your slaves:  
/mb re mb_SayRaid("Hello")  
This will make each of your slaves say "Hello" in the raid chat.

Start a loot council for an item that dropped:  
/mb lc [itemlink]

Loads a boss-module which will override certain behaviour depending on the boss:  
/mb bm bossname   
Example: /mb bm gluth

Switch to the other dual-spec on a character, and equip an equipment-set corresponding to the new spec's name if it exists, and perform a soft-reload to load the new spec's class-functions:  
/mb respec  
Command is run on the character you want to respec, can also be remote-executed through "mb_isRespecing = true".  

# Some useful macros I use on my Commander:
Make all slaves accept pending trades or guild invites:  
/run mb_SendMessage("accept")

Set cleaveMode, which changes rotations automatically on all slaves, 0 = single-target, 1 = cleave, 2 = full AoE. Default is 0  
/mb re mb_cleaveMode = 0

Invite everyone specified in the mb_config.raidLayout in Config.lua, and set loot to FFA.  
/run mb_fixRaidSetupName = "25man"

Change the follow-mode, "none" = they will never /follow the commander, "lenient" = they will follow the commander if he gets too far away, but they're free to move a little if they're within that range, "strict" = they will /follow spam each OnUpdate. Default is "lenient".  
/mb re mb_followMode = "strict"

Make all the slaves set your target as their focus. If you set the focus to a friendly target the slaves will heal it if needed. Useful for bosses where you need to keep a friendly NPC alive.  
/mb re FocusUnit(mb_GetUnitForPlayerName("Malowtank") .. "target");  
/focus

Makes all your slaves move forward for 2 seconds. Useful to make them go through instance portals.  
/run mb_SendMessage("moveForward")

Request a Heroism/Bloodlust from one of your Shamans:  
/run mb_SendExclusiveRequest("heroism")

Make all your slaves Interact With Target, useful for looting/skinning or interacting with game objects (mage table, teleporters):  
/mb re InteractUnit("target")

Make all the slaves jump, in case they get stuck on something:  
/mb re JumpOrAscendStart()

Make all slaves mount up:  
/run mb_SendMessage("mount")

Make all slaves release spirit when they're dead to corpse-run:  
/mb re RepopMe()

Change commander on the fly, for example if you want all your slaves to start following and assisting someone else:  
/mb re mb_SetCommanderHandler("Elerien", "Malowtank");  
Where "Elerien" is the name of the new character that they should follow, and "Malowtank" is the name of your main.

Change commander on the fly for a single character:  
/mb re if UnitName("player") == "Ceolmar" then mb_commanderUnit = mb_GetUnitForPlayerName("Odia") end

Request a tank to taunt your current target:  
/run mb_SendExclusiveRequest("taunt")

Request a healer to use a CD (for example when there's large raid damage):  
/run mb_SendExclusiveRequest("healcd")

Request an external cooldown to be cast on you like Pain Suppression or Hand of Sacrifice:  
/run mb_SendExclusiveRequest("external")

Request a Paladin with Improved Divine Sacrifice to cast it:  
/run mb_SendExclusiveRequest("impdivinesac")

Toggle auto-rotation on/off on your commander:  
/run if mb_doAutoRotationAsCommander then mb_doAutoRotationAsCommander = false; mb_Print("AutoRot disabled"); else mb_doAutoRotationAsCommander = true; mb_Print("AutoRot enabled"); end

Toggle everyone in the raid using DPS cooldowns automatically on/off:  
/run local c=mb_forceBlockDpsCooldowns;if c then c=false; mb_Print("DPS CDs free");else c=true; mb_Print("DPS CDs blocked");end mb_forceBlockDpsCooldowns=c; mb_SendMessage("remoteExecute ", "mb_forceBlockDpsCooldowns="..tostring(c));

Grab conjured water from a mage table on every character:  
/mb re InteractUnit("Refreshment Table")

Request a Combat Ress on your mouseover target:
/run mb_SendExclusiveRequest("cr", UnitName("mouseover"))

