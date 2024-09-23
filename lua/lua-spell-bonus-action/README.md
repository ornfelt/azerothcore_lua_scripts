# Spell Bonus Action

## Table of contents
- [Short description](https://github.com/iThorgrim/lua-spell-bonus-action/tree/main#short-description)
- [How it works](https://github.com/iThorgrim/lua-spell-bonus-action/tree/main#how-it-works)
- [Installation](https://github.com/iThorgrim/lua-spell-bonus-action/tree/main#installation)
- [Database schema](https://github.com/iThorgrim/lua-spell-bonus-actions/tree/main#database-schema)
- [Configuration](https://github.com/iThorgrim/lua-spell-bonus-action/tree/main#configuration)
- [How to use](https://github.com/iThorgrim/lua-spell-bonus-action/tree/main#how-to-use)
- [Contribution](https://github.com/iThorgrim/lua-spell-bonus-action/tree/main#contribution)

## Short description
This project is a Lua implementation for managing spell bonus action activation conditions, including features such as spell activation when equipping items, zone change, aura application and more.

It uses an entity-oriented approach to data management and also includes an AIO client to manage the client-side user interface. The whole project is based on an MVC architecture for better organization and readability.

A "generic" condition system is linked to the database.

## How it works
Two main modules drive the operation of this project: Entity and Controller.

**Entity** is responsible for loading and organizing database-based conditions. It retrieves all conditions from a database query and organizes these conditions by associating them with spell identifiers.

**Controller** is responsible for processing player events, such as zone change, item acquisition, aura application and so on. It checks whether the player meets all the conditions for spell activation, and triggers spell activation if necessary.

## Installation
First, make sure your project's dependencies(last revision of [AzerothCore](https://www.azerothcore.org/), [mod-eluna](https://github.com/azerothcore/mod-eluna) and [AIO](https://github.com/Rochet2/AIO)) are correctly installed.

Then clone this repository in the appropriate directory of your project.
```bash
git clone https://github.com/iThorgrim/lua-spell-bonus-action.git
```

Make a Patch with ClientSide content, simply, take the interface folder and drag it into a patch.
Share the patch with players.

**Database schema**

Make sure your database contains the tables required for the application. You can find the necessary schema in the database.sql file included in this repository.

```sql
CREATE TABLE `index_spell_bonus_action` (
  `spell_id` int(10) NOT NULL,
  `overlay_texture` varchar(150) NOT NULL DEFAULT 'stormyellow-extrabutton',
  PRIMARY KEY (`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `index_spell_bonus_action_conditions` (
  `spell_id` int(11) NOT NULL,
  `condition_type` enum('aura','item','item_equipped','map_id','zone_id','area_id','active_event','min_level','class','race','phase_mask','quest_rewarded','quest_incomplete','min_hp_pct','max_hp_pct') NOT NULL,
  `condition_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`spell_id`,`condition_type`),
  CONSTRAINT `spell_id` FOREIGN KEY (`spell_id`) REFERENCES `index_spell_bonus_action` (`spell_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

## Configuration
Just edit the database name in : 
> Spell_Bonus_Action/Config/Spell_Bonus_Action_Config.lua


## Use
Once the project has been set up correctly, each player event will trigger a check of the conditions associated with that type of event (e.g. equipping an item). If all conditions are met, the corresponding effect will be triggered.

## Exemple
I'd like to display spell 59752 (Will to Survive) to players who have the hearthstone in their bags, in Northrend, Dalaran and Runeweaver Square.

**MySQL Code**
```sql
INSERT INTO `index_spell_bonus_action` VALUES ('59752', 'air-extrabutton');

INSERT INTO `index_spell_bonus_action_conditions` (`spell_id`, `condition_type`, `condition_value`) VALUES
('59752', 'item', '6948'),
('59752', 'map_id', '571'),
('59752', 'zone_id', '4395'),
('59752', 'area_id', '4739');
```

**In-game command**
```bash
.reload eluna
```

**Result**

![image](https://github.com/iThorgrim/lua-overlay-spells/assets/125808072/ca18b050-c444-40fd-a0f6-dae72bff3501)

## Contribution
Contributions are always welcome! Feel free to submit a Pull Request.
