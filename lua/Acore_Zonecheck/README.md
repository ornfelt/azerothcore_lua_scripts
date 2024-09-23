## lua-zonecheck

Lua script for Azerothcore with ElunaLUA to check for a players zone and kick the player if it is listed in the config flags.

**Proudly hosted on [ChromieCraft](https://www.chromiecraft.com/)**
#### Find me on patreon: https://www.patreon.com/Honeys

Adds a db scheme specified in `Config_customDbName` on first startup.

## Requirements:

Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
The ElunaLua module itself usually doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed in the ElunaLua config, add the .lua script to your `../lua_scripts/` directory as a subfolder of the worldserver.
Adjust the top part of the .lua file with the config flags.

GMs Level 1 or higher are excluded by default.

Credits to [Roboto](https://github.com/r-o-b-o-t-o) for re-writing most of this.

#### Find me on patreon: https://www.patreon.com/Honeys
