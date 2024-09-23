# Dynamic-Trader
The script uses a dynamic pricing system for items, with prices changing based on several factors, including the day of the week, the time of day, and a global fluctuation value. This means that prices will vary from month to month, day to day, hour to hour and has both buy and sell functions.
Run the Sql in acore_world, place the script under lua_scripts and .npc add 180000 wherever you like. You can set additional npcs for faction specific ones at the top of the script.

So far this is just the vanilla trader.

This script was created for smaller private servers as a means to allow players some semblance of an auctionhouse. In its current iteration, the ah module for Acore leaves a lot to be desired.
Prices are loosely based on authentic vanilla prices as this is for Individual Progression servers or servers that mimic vanilla via the 3.3.5 client. I will also be making scripts for TBC, Wrath, consumables, enchants, etc. 
As a means to not create an infinite source of easy gold, I've adjusted some prices for crafted materials to be lower than usual to make the margins tighter.
Please feel free to adjust any values you see fit.
	
	Features include:
	1. Inflation: The script includes an inflation system that increases prices over time, based on a defined monthly inflation rate. The inflation system can be enabled or disabled as needed.
	2. Price Caps: The script includes a maximum inflation multiplier that limits the amount prices can increase due to inflation.
	3. Price Fluctuations: The script includes a system for randomly fluctuating prices. This feature can be enabled or disabled as needed.
	4. Detailed Item Categories: The script allows for detailed item categorization, with support for item icons and colors based on item quality.
	5. Quantity Selection: The script allows players to select the quantity of an item they wish to buy or sell, with the price per unit displayed.
	6. Mail Delivery: Items bought from the trader are delivered to the player's mailbox.
	7. Customization: Many aspects of the script can be customized, including the NPC IDs, buy and sell multipliers, inflation rate, the time at which the server started, 
	the maximum inflation multiplier, the multipliers for different days of the week and times of the day, and the items and categories available.
	8. Supports Multiple Currencies: The script supports a system where it can convert prices into different types of currency (gold, silver, copper) for display purposes, all of which mimic auctionhouse structure.
	9. GM Commands: The script includes GM commands for checking multipliers and updating global fluctuations.
	
	GM Commands:
	.vprices 
	This command provides the GM with a detailed breakdown of the current state of the price multipliers and percentages. When a GM enters "vprices", they'll receive a series of messages that include:
	-The day of the week and its associated multiplier
	-The current hour and its associated multiplier
	-The global fluctuation multiplier
	-The inflation multiplier
	-The total price multiplier
	-The buy and sell global multipliers
	
	.vprices shuffle
	This command allows the GM to shuffle the global fluctuation, effectively randomizing the current state of the economy. After using this command, the GM receives a message stating the new global fluctuation.
	
	.vbp
	This command allows the GM to set a new buy multiplier. 
	The GM needs to input the command followed by the desired value (e.g., "vbp 0.5" would set the buy multiplier to 0.5). After setting the new buy multiplier, the GM receives a message confirming the change. 
	The GM is also informed that this change will be reset when the server restarts.
	
	.vsp 
	This command is similar to "vbp", but it adjusts the sell multiplier instead. 
	After the GM enters the command and the desired value, they receive a confirmation message and a reminder that the change will be reset when the server restarts.	
