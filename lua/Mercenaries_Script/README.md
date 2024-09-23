# Mercenaries Script by Dinkledork
This script is currently being adapted and is designed to create a custom event where players can interact with specific NPCs (defined by the NPC_IDS list) using a gossip menu. The event requires players to have a particular item (ITEM_ID) in their inventory. When the player initiates a gossip interaction with the NPC, the NPC will say a random battle cry, equip a random two-handed weapon from the predefined list (mainHandItems), and move to a random destination chosen from a set of predefined locations (destinations).

This script will be adapted as a sort of city attacker script where players can hire mercenaries to attack predetermined areas with npcs. This has to potential to be used in BG type scenarios or to create RP events like Hillsbrad PvP. Originally I wrote this script for a Scourge event quest on my server where they attack crossroads and the player has to pass out armaments to npcs and send them to specified locations. Now I'll be adapting it so the player will have a list of gossip options allowing them to choose equiped weapons. Npc abilities will also be scripted based on the weapons the player chooses. Then it's just a matter of adding additional gossip options to have npcs attack specific areas rather than random ones, which people would have to figure out on their own, but still. I supposed I could also include an sql insert for fun with npcs spawned in specific cities designed to attack specific places.

You could currently use this script if you modified x y z coordinates and npcids.

UPDATE: V2 
1. Players can now choose the npc's weapon and target destination.
2. Npcs now have a "Follow me" option.
3. Icons and text have been made pretty.

This is still very much for a custom quest but is much more workable now for other uses.

# Update: V3 #
Can set npcs to have unique abilities based on the weapon chosen.
