# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

# Global Personal Bank/Mailbox/Auction House/Repair
Simple Lua Script that allows access to your character's bank, mailbox, auction house, or repair your gear anywhere in the world via chat commands.  If you would like to add or change the commands, you can do so in the Lua script.

- The bank can be accessed with the following commands: `.bank`, `.openbank`.
- The mailbox can be accessed with the following commands: `.mb`, `.mail`, `.mailbox`.
- The auction house can be accessed with the following commands: `.auctions`, `.ah`, `.auctionhouse`.
- Your gear can be repaired with the following commands: `.repair`, `.gearrepair`, `.fixgear`.

# Setup

- Copy the "Global Mail_Banking_Auctions_Repair.lua" file into the lua_scripts folder on your server.
- If your server is already running, type ".reload ale" in the worldserver window.  Otherwise, just start up the server.
- While in-game, prepend any of the bank, mailbox, auctionhouse, or repair commands with "!" or ".".  For example, `.bank` or `!mail`.
