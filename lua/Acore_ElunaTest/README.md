## lua-eluna-test
 
Lua script for Azerothcore with ElunaLUA to test hooks.

#### Find me on patreon: https://www.patreon.com/Honeys


## Requirements:
Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
The ElunaLua module itself usually doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed in the ElunaLua config, add the .lua script to your `../lua_scripts/` directory as a subfolder of the worldserver.


## Tester Usage:
- Apply the sql to add the testing NPC

- Trigger the events listed below.
- Receive a message in the worldserver console whenever a hook fires.

- `.npc add temp 299`
- Trigger all events for the spawned wolf.

- `.npc add temp 1199000`
- Right-Clicking Chromie must print GOSSIP_EVENT_ON_HELLO. 
- Selecting the "Test" gossip must print GOSSIP_EVENT_ON_SELECT.

Commands:

- `playertest` to list all playerevents which weren't tested in this session.
- `creaturetest` to list all creatureevents which weren't tested in this session.
- `resetluatest` to start an new session.

![image](https://user-images.githubusercontent.com/71938210/139537206-365dff58-72f4-4a6b-8975-7f02ccf5dbbf.png)
![image](https://user-images.githubusercontent.com/71938210/139540053-27c1a37d-f55b-4a69-bad6-8922b16885b0.png)


## Currently listed player events:

- PLAYER_EVENT_ON_CHARACTER_CREATE = 1        --(event, player)
- PLAYER_EVENT_ON_CHARACTER_DELETE = 2        --(event, guid)
- PLAYER_EVENT_ON_LOGIN = 3                   --(event, player)
- PLAYER_EVENT_ON_LOGOUT = 4                  --(event, player)
- PLAYER_EVENT_ON_SPELL_CAST = 5              --(event, player, spell, skipCheck)
- PLAYER_EVENT_ON_KILL_PLAYER = 6             --(event, killer, killed)
- PLAYER_EVENT_ON_KILL_CREATURE = 7           --(event, killer, killed)
- PLAYER_EVENT_ON_KILLED_BY_CREATURE = 8      --(event, killer, killed)
- PLAYER_EVENT_ON_DUEL_REQUEST = 9            --(event, target, challenger)
- PLAYER_EVENT_ON_DUEL_START = 10             --(event, player1, player2)
- PLAYER_EVENT_ON_DUEL_END = 11               --(event, winner, loser, type)
- PLAYER_EVENT_ON_GIVE_XP = 12                --(event, player, amount, victim) - Can return new XP amount
- PLAYER_EVENT_ON_LEVEL_CHANGE = 13           --(event, player, oldLevel)
- PLAYER_EVENT_ON_MONEY_CHANGE = 14           --(event, player, amount) - Can return new money amount
- PLAYER_EVENT_ON_REPUTATION_CHANGE = 15      --(event, player, factionId, standing, incremental) - Can return new standing
- PLAYER_EVENT_ON_TALENTS_CHANGE = 16         --(event, player, points)
- PLAYER_EVENT_ON_TALENTS_RESET = 17          --(event, player, noCost)
- PLAYER_EVENT_ON_CHAT = 18                   --(event, player, msg, Type, lang) - Can return false, newMessage
- PLAYER_EVENT_ON_WHISPER = 19                --(event, player, msg, Type, lang, receiver) - Can return false, newMessage
- PLAYER_EVENT_ON_GROUP_CHAT = 20             --(event, player, msg, Type, lang, group) - Can return false, newMessage
- PLAYER_EVENT_ON_GUILD_CHAT = 21             --(event, player, msg, Type, lang, guild) - Can return false, newMessage
- PLAYER_EVENT_ON_CHANNEL_CHAT = 22           --(event, player, msg, Type, lang, channel) - Can return false, newMessage
- PLAYER_EVENT_ON_EMOTE = 23                  --(event, player, emote) - Not triggered on any known emote
- PLAYER_EVENT_ON_TEXT_EMOTE = 24             --(event, player, textEmote, emoteNum, guid)
- PLAYER_EVENT_ON_SAVE = 25                   --(event, player)
- PLAYER_EVENT_ON_BIND_TO_INSTANCE = 26       --(event, player, difficulty, mapid, permanent)
- PLAYER_EVENT_ON_UPDATE_ZONE = 27            --(event, player, newZone, newArea)
- PLAYER_EVENT_ON_MAP_CHANGE = 28             --(event, player)
- -- Custom
- PLAYER_EVENT_ON_EQUIP = 29                  --(event, player, item, bag, slot)
- PLAYER_EVENT_ON_FIRST_LOGIN = 30            --(event, player)
- PLAYER_EVENT_ON_CAN_USE_ITEM = 31           --(event, player, itemEntry) - Can return InventoryResult enum value
- PLAYER_EVENT_ON_LOOT_ITEM = 32              --(event, player, item, count)
- PLAYER_EVENT_ON_ENTER_COMBAT = 33           --(event, player, enemy)
- PLAYER_EVENT_ON_LEAVE_COMBAT = 34           --(event, player)
- PLAYER_EVENT_ON_REPOP = 35                  --(event, player)
- PLAYER_EVENT_ON_RESURRECT = 36              --(event, player)
- PLAYER_EVENT_ON_LOOT_MONEY = 37             --(event, player, amount)
- PLAYER_EVENT_ON_QUEST_ABANDON = 38          --(event, player, questId)
- PLAYER_EVENT_ON_LEARN_TALENTS = 39          --(event, player, talentId, talentRank, spellid)
- -- UNUSED                     = 40          --(event, player)
- -- UNUSED                     = 41          --(event, player) 
- PLAYER_EVENT_ON_COMMAND = 42                --(event, player, command) - player is nil if command used from console. Can return false
- PLAYER_EVENT_ON_PET_SPAWNED = 43            --(event, player, pet)

## Currently listed creature events:
- CREATURE_EVENT_ON_ENTER_COMBAT = 1          --(event, creature, target) - Can return true to stop normal action
- CREATURE_EVENT_ON_LEAVE_COMBAT = 2          --(event, creature) - Can return true to stop normal action
- CREATURE_EVENT_ON_TARGET_DIED = 3           --(event, creature, victim) - Can return true to stop normal action
- CREATURE_EVENT_ON_DIED = 4                  --(event, creature, killer) - Can return true to stop normal action
- CREATURE_EVENT_ON_SPAWN = 5                 --(event, creature) - Can return true to stop normal action
- CREATURE_EVENT_ON_REACH_WP = 6              --(event, creature, type, id) - Can return true to stop normal action
- CREATURE_EVENT_ON_AIUPDATE = 7              --(event, creature, diff) - Can return true to stop normal action
- CREATURE_EVENT_ON_RECEIVE_EMOTE = 8         --(event, creature, player, emoteid) - Can return true to stop normal action
- CREATURE_EVENT_ON_DAMAGE_TAKEN = 9          --(event, creature, attacker, damage) - Can return true to stop normal action, can return new damage as second return value.
- CREATURE_EVENT_ON_PRE_COMBAT = 10           --(event, creature, target) - Can return true to stop normal action
- -- UNUSED                    = 11
- CREATURE_EVENT_ON_OWNER_ATTACKED = 12       --(event, creature, target) - Can return true to stop normal action
- CREATURE_EVENT_ON_OWNER_ATTACKED_AT = 13    --(event, creature, attacker) - Can return true to stop normal action
- CREATURE_EVENT_ON_HIT_BY_SPELL = 14         --(event, creature, caster, spellid) - Can return true to stop normal action
- CREATURE_EVENT_ON_SPELL_HIT_TARGET = 15     --(event, creature, target, spellid) - Can return true to stop normal action
- -- UNUSED                          = 16     --(event, creature)
- -- UNUSED                          = 17     --(event, creature)
- -- UNUSED                          = 18     --(event, creature)
- CREATURE_EVENT_ON_JUST_SUMMONED_CREATURE = 19    --(event, creature, summon) - Can return true to stop normal action
- CREATURE_EVENT_ON_SUMMONED_CREATURE_DESPAWN = 20 --(event, creature, summon) - Can return true to stop normal action
- CREATURE_EVENT_ON_SUMMONED_CREATURE_DIED = 21    --(event, creature, summon, killer) - Can return true to stop normal action
- CREATURE_EVENT_ON_SUMMONED = 22             --(event, creature, summoner) - Can return true to stop normal action
- CREATURE_EVENT_ON_RESET = 23                --(event, creature)
- CREATURE_EVENT_ON_REACH_HOME = 24           --(event, creature) - Can return true to stop normal action
- -- UNUSED                        = 25       --(event, creature)
- CREATURE_EVENT_ON_CORPSE_REMOVED = 26       --(event, creature, respawndelay) - Can return true to stop normal action, can return new respawndelay as second return value
- CREATURE_EVENT_ON_MOVE_IN_LOS = 27          --(event, creature, unit) - Can return true to stop normal action. Does not actually check LOS, just uses the sight range
- -- UNUSED                     = 28          --(event, creature)
- -- UNUSED                     = 29          --(event, creature)
- CREATURE_EVENT_ON_DUMMY_EFFECT = 30         --(event, caster, spellid, effindex, creature)
- CREATURE_EVENT_ON_QUEST_ACCEPT = 31         --(event, player, creature, quest) - Can return true
- -- UNUSED                      = 32         --(event, creature)
- -- UNUSED                      = 33         --(event, creature)
- CREATURE_EVENT_ON_QUEST_REWARD = 34         --(event, player, creature, quest, opt) - Can return true
- CREATURE_EVENT_ON_DIALOG_STATUS = 35        --(event, player, creature)
- CREATURE_EVENT_ON_ADD = 36                  --(event, creature)
- CREATURE_EVENT_ON_REMOVE = 37               --(event, creature)
