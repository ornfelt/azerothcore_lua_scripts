## lua-DiscordNotifier
Lua script for Azerothcore with ElunaLUA to push messages related to your server into Discord.

## Requirements:
Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [mod-eluna](https://github.com/azerothcore/mod-eluna).
The ElunaLua module itself usually doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed in the ElunaLua config, add the folder to your `../lua_scripts/` directory as a subfolder of the worldserver.

## Current Synced Events:
- PLAYER_EVENT_ON_CHAT
- PLAYER_EVENT_ON_WHISPER
- PLAYER_EVENT_ON_GROUP_CHAT
- PLAYER_EVENT_ON_GUILD_CHAT

## Configuration
Adjust the top part of the main.lua file with the config flags.
