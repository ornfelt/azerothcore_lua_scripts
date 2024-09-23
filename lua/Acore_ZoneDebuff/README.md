## lua-zone-debuff
Lua script for Azerothcore with ElunaLUA to buff/debuff players in zones listed in the configuration.


# Deprecated
## This lua script is now deprecated. It is encouraged to replace it with https://github.com/Azerothcore/mod-zone-difficulty.



#### Find me on patreon: https://www.patreon.com/Honeys

## Requirements:
Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://github.com/azerothcore/mod-eluna).
The ElunaLua module itself usually doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed in the ElunaLua config, add the .lua script to your `../lua_scripts/` directory as a subfolder of the worldserver.

The hook which alters absorb effects and excludes secondary effects, like chainheal-jumps being double-nerfed, might not exist in the default Azerothcore.

## Admin Usage:
- Adjust the config flags and IDs in the `.lua` files. Each file has it's own list of zones.
- Apply the .sql in `../database/world/` for the custom spell effects


There is `zoneDebuff.lua` to change player stats globally for certain zones as well as player and and pet/minion damage dealt, damage taken and max hp.
They're configurable individually for
- Dungeons, 
- Raids and 
- BGs/Arenas.
- It is also possible to remove a configurable list of Auras, meant for World Buffs for another list of map IDs.

## GM Usage:
Nothing to do.

## Player Usage:
Go to the zones. Enjoy the buffs / endure the debuffs.
