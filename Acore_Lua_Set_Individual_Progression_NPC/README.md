# Acore_Lua_Set_Individual_Progression_NPC
Allows players to easily change what tier they want to be on in the game for the Individual Progression mod. Run the query, .npc add 50000 in game.

Please run the following sql query as well in acore_characters database

ALTER TABLE character_settings MODIFY data VARCHAR(10); 

