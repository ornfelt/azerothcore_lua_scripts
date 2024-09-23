## lua-carbon-copy
LUA script for Azerothcore with ElunaLUA to allow players to keep copies of their characters at a stage, e.g. for twink pvp.

This branch delays the copy process and splits it into 10 pieces to reduce core lag.

**Proudly hosted on [ChromieCraft](https://www.chromiecraft.com/)**
#### Find me on patreon: https://www.patreon.com/Honeys

## Requirements:

Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473), latest version, at least from March 19th, 2021.

The ElunaLua module itself doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed, add the .lua script to your `../lua_scripts/` directory.
Adjust the top part of the .lua file with the config flags.

**On first startup of the core, a scheme specified in the config part of the .lua file will be created.**

## Admin Usage:

Set the conf flags in the top section of the .lua file.

You need to grant account related tickets in the `carboncopy` table:
- `account_id` refers to the unique guid of the account.
- `tickets is the # of times a player can copy a character`
- `allow_copy_from_id` is reserved for future use. 

Or use the command for e.g. SOAP interface granting tickets when sent to worldserver console: Syntax: CCACCOUNTTICKETS $accountName $amount
ingame command to grant tickets, by default restricted to GM-level 2+.
Syntax: `.addcctickets $characterName $amount`. `.addcctickets help` shows a syntax message.

**Most importantly: `Config.ticketCost`**  If this flag is set to "single", every copy will cost *one* ticket.
If ticketCost is set to "level", the cost in tickets is determined by the `ticket_Cost` config flags.

## Player Usage:
- `.carboncopy help` shows a syntax message
- `.carboncopy` shows the amount of available tickets

- Create a new character with same class/race as the one to copy in the same account. Do NOT log it in.
- Log in with the source character
- While logged in on the character to copy from, do `.carboncopy $newToonsName`
- **WAIT** for a minute before you log out.
- Log on the new character, find a mailbox. Possibly the items in the mail show no enchants/gems. Once you take the items out of the mailbox, all modifications will be visible. On latest AC modifications are visible in the mailbox already.

## What it does:
- Delete the new characters starter gear, except the Homestone.
- Send copies of all items worn to the new character by mail. Including gems and enchants. 
- Grant the new character the sources level, xp, discovered flightmasters, /played, stats, explored zones, homebind
- Grant hunters a copy of their **oldest** pet and previously bought stable slots. It's talent points are refunded. Shamans get their low level totems copied if they still have them
- Complete all quests on the new character, which the source has completed already
- Grant the new character all gained reputation, talents, glyphs, spells and skills
- **Place all actions on the new characters bars. If you copy your macro data from one characters /wtf/ directory to the other, you do not need to setup macros either.**

## What it **NOT** does:
- No items from bags/bank are copied. No bags are copied. All starter gear is deleted except the homestone.
- No gold is copied. The new character will be at zero copper.
- No achievements are copied. Achievements were made with the source characters and are reserved to them.

Example query to add one free ticket to all existing accounts:

`REPLACE INTO ac_eluna.carboncopy(account_id) SELECT id FROM acore_auth.account;`
`UPDATE  ac_eluna.carboncopy SET tickets = 1;`

Find me on patreon: https://www.patreon.com/Honeys
