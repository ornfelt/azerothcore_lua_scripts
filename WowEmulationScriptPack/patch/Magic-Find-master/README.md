
## [ Magic Find ]

---------------------------------------
### Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Commands](#commands)
4. [Config](#config)

---------------------------------------
### Introduction

Magic Find (MF) is Diablo II reference. MF stat increases chances of getting loot of better quality in a non-linear progression.  
Refer to the [graph](https://www.desmos.com/calculator/s1rs0xdyyb) for percentages.  
Magic Find affects all types of loot, but it will never push items off loot rolls table.  
Magic Find comes from 2 sources: DB and items. I provide 3 example charm items (MF amount is item durability - for now). Items are bound to account, and you can simply send them in mail or add directly. Player needs to keep them in bags to gain bonus. List of items to be counted as MF charms is stored in [Config](#config). For MF in DB See [Commands](#commands)  
MF scaling factor is configurable for all droppable magic item quality types. See [Config](#config) for details.  

### Installation

Follow TrinityCore Installation Guide (https://TrinityCore.info/)  
Download MagicFind.patch and put it into your TrinityCore folder. Apply the patch using `patch -p1 < MagicFind.patch` command.  
Run CMake and build.  
Merge worldserver.conf.dist into your worldserver.conf file.  
Download and apply SQL files:
```
chracters DB: characters_character_magic_find.sql
world DB: world_item_template.sql
```
Now you can run the server.

### Commands

Commands are divised by persmissions into two groups: Player commands and GM commands  
- **`mf`** -- (Player command) shows amount of MF acquired by selected player (current player if no selection)  
    - **`setbase _NAME_ _AMOUNT_`** -- (GM command) sets base MF amount (DB one) for player named '_NAME_' equal to '_AMOUNT_'. It will also show you previous value to avoid mistakes.  
        **Example Usage:**  
            - `.mf setbase trickerer 0`  
            - `.mf set trickerer 123`  
    - **`reloadcfg`** -- (GM command) reloads MF system config.  

### Config

- **`MF.Demonstration`**
    - Demonstration mode will make drop chance gain linear (+900% MF = +900% drop chance for all magic item quality types).
- **`MF.QualityAffectsEquallyChanced`**
    - Allows MF to affect loot groups with explicit equal drop chance.
    - This will also affect these items by Rate.Drop.Item.<Quality> config parameters.
    Explanation: Equally chanced loot groups have all items chance **0** which automatically distributes drop chance equally (quality drop chance increase does not apply). If this config is enabled, these chances will be re-calculated (total 100% won't change).
- **`MF.Factor.Uncommon`**
- **`MF.Factor.Rare`**
- **`MF.Factor.Epic`**
- **`MF.Factor.Legendary`**
    - This is a factor taken into the 'MF to drop chance' formula. The greater this parameter is, the more linear drop chance increase will be.
- **`MF.CharmItems`**
    - This is the list of item IDs to be counted as MF Charm items.
    - Refer to the default value for the template.

---------------------------------------
