<p align="center"><img src="https://github.com/zyggy123/lottery-lua/blob/main/icon.png" alt="Logo" width="250"/></p>

## Name: Lottery System
## Author: zyggy123
## License: GNU Affero General Public License v3.0

## Description

This Lua script implements a customizable lottery system for AzerothCore and TrinityCore. Players can enter the lottery using Emblems of Frost, with a chance to win valuable prizes. The system features automated draws, a flexible claim system for winners, and an intuitive NPC interface for player interaction.

### Features:

- Customizable entry cost using Emblems of Frost
- Highly configurable registration period and prize claim timeout
- Automatic lottery draws at customizable intervals
- Flexible prize claim system with adjustable timeout
- NPC interface for easy player interaction
- Detailed rules and countdown system

## Installation

1. Place the `lottery_system.lua` file in your server's `lua_scripts` directory.
2. Adjust the configuration variables at the top of the script as needed:
   - `LOTTERY_COST`: Cost to enter the lottery
   - `EMBLEM_OF_FROST_ID`: Item ID for Emblem of Frost
   - `REGISTRATION_TIME_SECONDS`: Duration of the lottery registration period
   - `CLAIM_TIMEOUT_SECONDS`: Time allowed for winners to claim their prize
   - `PRIZE_ITEM_ID`: Item ID of the prize to be awarded
   - `NPC_ID`: ID of the NPC that will handle the lottery

3. Restart your server .

## Usage

Players can interact with the lottery system through a designated NPC. The NPC offers the following options:

1. Enter the lottery
2. Claim lottery prize (when applicable)
3. View current participants
4. Check countdown to next draw or prize claim deadline
5. View lottery rules

The system automatically handles lottery draws, winner selection, and prize distribution.

## Configuration

You can easily customize the lottery system by modifying the variables at the top of the script:

- Adjust costs, timers, and prize items to suit your server's economy and preferences.
- Modify the NPC's gossip menu text to match your server's theme or language.

### Customizable Timers

The script comes with default settings of 1 minute for the lottery draw period and 2 minutes for the claim period. However, these can be easily modified to create more challenging and engaging scenarios:

- Set `REGISTRATION_TIME_SECONDS` to 86400 (24 hours) or 604800 (7 days) for daily or weekly lotteries.
- Adjust `CLAIM_TIMEOUT_SECONDS` to 3600 (1 hour), 7200 (2 hours), or 86400 (24 hours) for more strategic claim periods.

Example for a weekly lottery with a 24-hour claim period:

```lua
local REGISTRATION_TIME_SECONDS = 604800 -- 7 days
local CLAIM_TIMEOUT_SECONDS = 86400 -- 24 hours
 ```
#### If you don't have the NPC in SQL

-Run the lottery_install.sql SQL insert command.

-In the game, use the command .reload eluna to reload the Lua scripts.

-To spawn the new NPC, use the command .npc add 500000.

<h1 align="center">Video</h1>

[![Video Demo](https://github.com/zyggy123/Treasure-Chest-System/blob/main/Youtube.png)](https://www.youtube.com/watch?v=7Di4y70icnE)
