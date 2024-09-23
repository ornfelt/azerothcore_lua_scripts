## This repo served to showcase https://github.com/55Honey/Acore_eventScripts which got open-sourced meanwhile.

## EventScripts
Lua script for Azerothcore with ElunaLUA to spawn (custom) NPCs and grant them scripted combat abilities.

## acore-cms support
**[world-boss-rank](https://github.com/azerothcore/world-boss-rank)** is an open-source module for a website based on the **[AzerothAPI](https://github.com/AzerothJS/AzerothAPI)**.

#### Find me on patreon: https://www.patreon.com/Honeys

## How to get this module?

The module is not open source, it is only for **AzerothCore contributors**. If you are a contributor, request this module to @Helias in our [discord server](https://discordapp.com/invite/gkt4y2x).  
**If you are not a contributor yet, ask admins to get the contributor rank and afterward contact Helias on Discord.**

There are many ways to [become a contributor](http://www.azerothcore.org/wiki/Contribute). You can help by sending PRs, testing PRs, improving the wiki, giving support to other users, etc... Contributing is not limited to programmers only, everyone is able to help. You too!

In short words, you become a contributor if you make one of the followings:
- have at least one Pull Request merged
- test a few Pull Requests
- write 3 new wiki pages or (1-2 big one)

Alternatively, you can get this module by donating 150$ to the AzerothCore organization. All the money donated to AzerothCore will be used to maintaining the infrastructure and support the community.

## Player Usage:
Be in a party or raid respectively. As the party/raid leader: Talk to the NPC. Go nuts!

**[Video of a 5man encounter](https://www.twitch.tv/videos/1052264022)**

**[Video of a raid encounter](https://www.twitch.tv/videos/1052269366)**

![image](https://user-images.githubusercontent.com/71938210/121605986-a8e7fb00-ca4d-11eb-9327-04535a674bc5.png)

![image](https://user-images.githubusercontent.com/71938210/121604233-6f61c080-ca4a-11eb-8c71-70774a9881ad.png)

## Requirements:
Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
Requires at least commit b824e9d18683ecfa498279de8ed1e49c1bfd887d of the Eluna Engine submodule hence commit 81548013dc0748c1aeb15179fed6b7fe861b64bc from [mod-eluna-lua](https://github.com/azerothcore/mod-eluna-lua-engine).
The ElunaLua module itself usually doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed in the ElunaLua config, add the .lua script to your `../lua_scripts/` directory as a subfolder of the worldserver.
Adjust the top part of the .lua file with the config flags.

## Admin Usage:
Adjust the config flags and IDs in the .lua and .sql in case of conflicts and run the associated SQL to add the required NPCs.

Just from adding more config flags, you can add additional encounters. Two example encounters each, for 5man and 40man tuned for level 39, as well as one encounter for 49 (again 40man and 5man) are already in the package.
![grafik](https://user-images.githubusercontent.com/71938210/126485698-2f5f9f64-39f3-4b9d-a063-c1fd6ec08059.png)




## GM Usage:
Use `.startevent $event $difficulty` to start and spawn the NPC players can interact with. Use .stopevent to despawn it. 
`.startevent 2 4` will start event 2 on difficulty 4. Increased difficulty decreases NPC spell timers and damage done by NPCs. 

## Credits

* [55Honey](https://github.com/55Honey)
* [Roboto](https://github.com/r-o-b-o-t-o)

AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)
