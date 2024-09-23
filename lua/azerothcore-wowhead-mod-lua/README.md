## Azerothcore WowHead Mod Lua

This module creates a npc that allows you to enter a WoWHead URL to get the given GearSet by email.

WoWHead pages:
    1. https://www.wowhead.com/classic/gear-sets
    2. https://www.wowhead.com/wotlk/gear-sets

### Requirements:
    1. Server compiled with https://github.com/azerothcore/mod-eluna
    2. Enable Remote Access: https://www.azerothcore.org/wiki/remote-access
    3. Python 3
    4. Run Http Server main.py. Setting up 3 environment variables: AZEROTHCORE_REMOTE_ADDRESS GM_USERNAME and GM_PASSWORD. See Dockerfile for details

### Install
    1. Copy files from lua inside azerothcore lua_script folder. for example ~/azerothcore-wotlk/env/dist/bin/lua_scripts/
    2. pip install -r requirements.txt
    3. Customize file lua_scripts/wowhead.lua: adjust API_ENDPOINT variable with the Http Server main.py URL.
    4. [Optional] execute up sql from databas directory.
    5. [Optional] create npc with a gm command: .npc add 3442

### Example video
![example](assets/example.gif)
