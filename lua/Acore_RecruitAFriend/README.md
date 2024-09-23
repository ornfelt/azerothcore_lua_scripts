## lua-recruit-a-friend
Lua script for Azerothcore with ElunaLua to connect accounts from different players and reward the recruiter for bringing active players.

**Proudly hosted on [ChromieCraft](https://www.chromiecraft.com/)**
#### Find me on patreon: https://www.patreon.com/Honeys

## Requirements:
Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
The ElunaLua module itself doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed, add the .lua script to your `../lua_scripts/` directory.
Adjust the top part of the .lua file with the config flags.

## Optional acore_cms support
The [acore_cms](https://github.com/azerothcore/acore-cms)-RAF-module supports this Lua. It allows to add and monitor RAF links and rewards from the website.

## Admin usage:
Adjust the top part of the .lua file with the config flags. The most important decisions are:
- max duration of the raf link(default 30 days)
- target level for a succesful link and a reward to the recruiter
- check for same IP yes/no, auto end RAF if same IP yes/no (default check:yes, end: no)
- text for the RAF-reward mail (see Lua for defaults)
- rewards as item id and amount (see Lua for defaults)
- maps to allow summoning to (default Eastern Kingdoms and Kalimdor)

`.bindraf $recruit $recruiter` binds the accounts to each other. It is advised to use this from SOAP during account creation. One recruiter can have multiple recruits. Restricted by `Config.minGMRankForBind`. Once the recruit reaches the target level, the recruiter will receive a reward based on their amount of already finished recruits. Target level, item and amount for certain reward levels are all config flags.

The RAF creates a custom db scheme specified in the config flags. Inside the scheme is a table to store all current and past RAF links.
- `time_stamp` is the moment of creation in UNIX-time
- `ip_abuse_counter` is increased everytime recruiter and recruit have the same IPs during login or summon 
- `kick_counter` is increased everytime a player gets kicked because they reached the allowed number of actions specified in `Config.abuseTreshold`.
- `reward_level` stores how many recruiters of that account have succesfully reached the RAF link up to `Config.targetLevel`.
- all other columns in `recruit_a_friend_links` and `recruit_a_friend_rewards` are account id's

Optionally:

`.forcebindraf $recruit $recruiter` same as .bindraf but ignores past binds. Previously unbound, succesful or timed out doesn't matter.

## Player Usage:
- `.raf`        prints your account id and also prints help
- `.raf help`   prints your account id and also prints help
- `.raf list`   shows the account ids of all your recruits
- `.raf summon` allows the recruiter so summon the recruit. The recruit can not summon.

Players have 30 days (config flag) to reach the target level (default 39). If they succeed, their recruiter gets a reward. There is a counter in place and rewards change with a higher amount of succesful recruits. Default rewards are pets, a bag and potions/elixirs.


## Config:
See the lua file for a description of the config flags.


## Default settings/rewards:
- There should be an option in the account creation page to determine a recruiter account. Recruiters can type `.raf` to find out about their account id.
- Once connected, recruiters can summon their recruits without a limit. Abuse might lead to kicks which are logged.
- Using the same IP for recruiter and recruit is restricted by default and also prevents teleporting and is logged.
- Once a recruit reaches the target level of 39, their recruiter gains a reward. The default rewards are a Mini-Thor pet for the first recruit, a 14-slot bag for the second recruit, the Diablos-Stone pet for the fifth recruit and a Tyrael's Hilt pet for the 10th recruit  to reach the target level of 39. For the 4th recruit, the 6th - 9th recruit and any recruit past 10, the recruiter will receive a set of 4 stacks of potions/elixirs.
- If the recruit fails to reach level 39 within 30 days, the RAF-link is removed at the next login.
- If the recruit and the recruiter share an IP, they receive a warning that "possible abuse was logged" at login. If they share an IP while trying to summon, the summoning is blocked and they also see the "possible abuse was logged" message.
