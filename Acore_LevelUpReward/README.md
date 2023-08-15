## lua-LevelUpReward
Lua script for Azerothcore with ElunaLUA to reward players for reaching certain levels. The ingame mail they receive will also contain their rank to reach this level.

**Proudly hosted on [ChromieCraft](https://www.chromiecraft.com/)**
#### Find me on patreon: https://www.patreon.com/Honeys

Adds a db scheme specified in `Config_customDbName` on first startup.

## Requirements:

Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
The ElunaLua module itself usually doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed in the ElunaLua config, add the .lua script to your `../lua_scripts/` directory as a subfolder of the worldserver.
Adjust the top part of the .lua file with the config flags.

Decide your mode:
`local Config_mailText = 2` 2 is the new, lore-friendly mode which includes a counter. With this flag set to 2, players will get to know their rank in the mail. 1 sends the original standard letter.

If you add this script to an existing server, make sure to populate it's table with meaningful numbers.

## Player Usage:
- Play, reach a level set in the config and be rewarded by ingame mail


## Example config:
`Config_mailText` is added to the "Hello [playerName]" head part of the mails sent.

`Config_Gold[10] = 10000` grants 1 Gold to the players when they reach level 10.

`Config_ItemId[29] = 5740` sends one rocket to the players when they reach level 29.
A missing Item_Amount always results in *one* item.

`Config_ItemId[29] = 5740` 
`Config_ItemAmount[29] = 5` sends five rockets to the players when they reach level 29.

Only one kind of item can be awarded per level. Multiple Config_ItemId flags for the same level do not work.

## Default config:

- 1g   at Level 10
- 7g   at Level 20
- 18g  at Level 30
- 35g  at Level 40
- 70g  at Level 50
- 140g at Level 60
- 280g at Level 70
- 500g at Level 80
