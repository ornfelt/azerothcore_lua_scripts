# Acore_Sortmachine

**Make sure you have decent backups! Do not run the .SQL file it produces on a live server without testing.**

* Please report your findings if you try it. Thank you!
* Credits to Disclosurez for large scale testing.

This script is supposed to read your unique guid's in item_instance and their references in character_inventory, guild_bank_item, mail_items and possibly customs, then create a sql script named **"sortguid.sql"** in your worldserver.exe directory which sorts items to start from 1, counting up without gaps. Running it repeatedly will skip creating SQL commands on already sorted items, until a single gap is occured in the servers db.
It checks for inconsistencies from broken items and removes all references for non existant item guids in guild_bank_item, mail_items and character_inventory.

Alternative use: Set ItemLimit = 1 and run `.sortguid`. This will create a SQL file which does only fixes. No sorting.

**Small scale tested and proven working with character backpack + bags, bank, bank bags, guild bank and mail.**


## Requirements:

Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
Add this script to your `../bin/release/lua_scripts/` directory.


## Usage:
- Close the worldserver to make sure no player has been active since it started and all changes are written to the db.
- Run the worldserver standalone. Do **not** have players on the server. Do not have anything active which could potentially create items.
- Type `.sortguid` into the console (recommended) or optionaly on an ingame client with sufficient rights.
- Close the worldserver
- Run the "sortguid.sql" file which was created in your directory where worldserver.exe resides.


## Settings in the .lua file:

`Schemename = "acore_characters"`

Change this to the name of your character database.


`ConsoleOnly = true`

If this is true the .sortguid command will not work ingame but only from the world server console


`MinGMRank = 4`

Staff must have at least this rank to use `.sortguid`


`PrintProgress = 1000`

How often the console or chat should print progression. 1000 means every 1000th item. Skipped or written doesn't matter, both are counted.


`ItemLimit = 0`

For testing. Script will stop after the # of items below.
* 0 = no limit
* 1 = only fixes, no items
* 2+ = # of items to sort


`StartFromGuid = 1`

The lowest item guid to sort. Don't start at 1 if there are few gaps.


`SearchForGapsFrom = 1`

The lowest guid to scan for gaps. Don't start at 1 if there are few gaps.


`ChangeCustom = false`

If there is a custom table e.g. from a transmog module this must be set to true or all affected items will be lost/bugged


`table.insert(CustomTableNames, 1, "Test_table1")`
`table.insert(CustomColumnNames, 1, "Test_column1")`

Insert your custom tables name and column here. You can add an unlimited (in theory) number of custom spots, as long as there is a column and a table for each custom spot.

#### Find me on patreon: https://www.patreon.com/Honeys
