# lua-summon-all
 Lua script for ElunaLua with Azerothcore

This script will allow any player to summon their whole party/raid, as long as the summoner is
1) not in combat and
2) on one of the maps listed below.

## Requirements:

Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
Add this script to your `../bin/release/lua_scripts/` directory.


## Usage:

Unless restricted otherwise, all players will be able to use `.summonall` to summon their whole party/raid.


## Settings in the .lua file:

`table.insert(maps, 0)`

Each line of `table.insert` adds one map to the list of allowed locations. *By default Eastern Kingdoms, Kalimdor, Outland and Northrend are allowed.* You can add more by providing the related map id in its own line. Find map ids e.g. in ./data/map.dbc.

Trying to use the command on other than the listed maps will result in "Summoning is not possible here." as a message in the chat.
Trying to use the command while in combat will result in "Summoning is not possible in combat." as a message in the chat.

#### Find me on patreon: https://www.patreon.com/Honeys
