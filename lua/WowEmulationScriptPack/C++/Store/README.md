# Table of Contents
* [Presentation](#presentation)
* [How it Works](#how-it-works)
* [Installation](#installation)
  * [Database](#database)
  * [Core](#core)
  * [In Game](#in-game)

# Presentation
This is a store script that you can put on a NPC. In the store, you can add several items and set them in categories. When you open the NPC's gossip menu, you will see all the available categories and the coins that you have on your account. When you click on a category, you will see all items that belong to it with the following layout:

[price] ItemName (x quantity)

* Price is the amount of coins required to purchase the item
* ItemName is the name of the item. When you create your store you just have to put the item entry and it will find its name
* Quantity is the quantity of the item that the player will receive if it makes the purchase

When you click on an item, if you have enough coins and space in your bags, the purchase will be completed. If one of those conditions if not verified, an error message will be displayed.

When you add an item in your store, you can define the minimum equipment level the player must have to see it.

The items and categories are set directly into the database.

# How it works
There are two tables that will be added to your characters database: *store_categories* and *store_items*. In the first one, you create all the categories of your store.
In the second one, you add items you want to sell in each category.

The items and categories will be loaded on the World start so you will need to restart your WorldServer if you make some changes in one of those two tables.

The coins that players have are stored in a new field of the auth.account table, called "coins".

# Installation
First, download all the files of this folder (including the sql/ folder).

## Database
* Execute the sql file located in sql/auth on your _auth_ database. It will add a new field in the account table: "coins". It represents the coins that players can use to purchase some items in the store.
* Execute the sql files located in sql/characters folder on your _characters_ database. It will create two tables as mentioned earlier.
* Fill in your store_categories table with the several categories of your store
* Fill in your store_items table with the items you want to sell on your store
* Take the NPC you want as your store NPC and set its script_name to "script_store"

## Core
* Add the _StoreManager.h_ and _StoreManager.cpp_ files in TrinityCore/src/server/game/Scripting
* Open your IDE and add the .h file into "Header Files" and the .cpp file into "Source Files" **on your "Game" project**
* Add the *store_script.cpp* file in TrinityCore/src/server/scripts/Custom
* Open your IDE and add that file to the "Source Files" **of your "Scripts" project**
* Open the World.cpp file in your "Game" project
* Add the "StoreManager.h" file in the included files (around line 66) => #include "StoreManager.h"
* Find the implementation of the *void World::SetInitialWorldSettings()* function (around line 1306)
* In that function's implementation, just before the line "uint32 startupDuration = GetMSTimeDiffToNow(startupBegin);" (around line 1893) add the following instruction: "Maelstrom::sStoreMgr->LoadStore();"
* Go to your ScriptLoader.cpp file and add the script for the store NPC as an usual script. The function to register is "void AddSC_script_store()"
* Compile your core

If everything went fine, once you run your WorldServer it should display "Store successfully loaded" at the end of the loading process.

If you don't want to modify your World.cpp file, there is an alternative. You can do all steps before the one telling you to open World.cpp.
Then you can create a World script and call "Maelstrom::sStoreMgr->LoadStore()" on the world startup.

## In Game
* Add your store NPC
* Talk to him/her
* Enjoy !
