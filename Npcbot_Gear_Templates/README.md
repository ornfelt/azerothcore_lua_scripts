# Npcbot_Extended_Commands

## Overview

This is an Eluna lua script designed to enhance your NPC bot gameplay experience. It not only provides level-appropriate gear but also allows you to clear transmogs and set custom names for your bots. The gear is categorized in 5-level increments, starting at level 10 and extending up to level 80, where epic or rare sets are available. The script comes with an extensive list of valid roles and the item list was mostly curated by Upskirt, ensuring a broad range of gear options. It also features GM-only command options for additional security and control.

## Usage

To use this script, place the file in your lua_scripts folder. The script supports multiple in-game commands:

### For Gear Templates:
`.bot items [role] [rarity]`  // Rarity is only applicable for level 80, which is `epic` or `rare`.

### For Transmog Clearing
The .bot clear tmog command clears transmog for the targeted NPC bot. Changes will take effect upon server reset.
`.bot clear tmog ` // Make sure to have an NPC Bot targeted. 

### For Setting Bot Names
The .bot nameset [new name] command sets the name of the targeted NPC Bot. The name must be 15 characters or fewer. Changes will take effect upon server reset.
`.bot nameset [new name]`  // Make sure to have an NPC Bot targeted.

### Valid Roles for Gear Templates

- `caster`
- `tank`
- `leatherdps`
- `maildps`
- `platedps`
- `twohanders`
- `onehanders`
- `ranged`
- `arrows` // Arrows and Bullets aren't needed but I added them anyway.
- `bullets`

## Important Notes

- The script is a work in progress. There are many items and levels of division that still need to be added.
- Some missing items may include weapons for particular specs or classes.

## Purpose

This script is designed for users looking to quickly gear up bots for initial use, clear transmogs, or set bot names. The gear provided should be adequate for most general gameplay scenarios.
