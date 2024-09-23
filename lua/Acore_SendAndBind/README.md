## lua-send-and-bind
Lua script for Azerothcore with ElunaLua to send soulbound items to players, which are usually Bind on Equip.

**Proudly hosted on [ChromieCraft](https://www.chromiecraft.com/)**

#### Find me on patreon: https://www.patreon.com/Honeys


## Requirements:
Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
The ElunaLua module itself doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed, add the .lua script to your `../lua_scripts/` directory.
Adjust the top part of the .lua file with the config flags.


## Admin usage:
- Compile the core with ElunaLua module
- Adjust the top part of the .lua file with the config flags.
- Change the `.send mail` in your webshop to `.senditemandbind $targetGUID $itemID [$amount] [message]`
- Add this script to ../lua_scripts/


## GM Usage:
`.senditemandbind $targetGUID $itemID [$amount] [message]` instead of `.send item` to send soulbound items. $amount defaults to 1 if left out.


## Config:
See the lua file for a description of the config flags.

