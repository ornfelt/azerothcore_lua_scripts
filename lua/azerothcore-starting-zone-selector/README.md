# azerothcore-starting-zone-selector
Places an NPC in each starting zone that allows players to select a different starting zone if they want.  For example, Orc can start in Sunstrider Isle.



https://github.com/user-attachments/assets/4d3c3a0f-496f-4320-96da-65d25b8a5f30



# Setup

- First, your server and client need to have AIO And Eluna set up or the scripts will not work:  https://github.com/Rochet2/AIO
- Run "ZoneSelectorNPCs.sql" on your `acore_world` database.
- Copy both the "zone_selector.lua" and "zone_selector_ui.lua" files into the lua_scripts folder on your server.  These can be within a subfolder inside of the lua_scripts folder as long as they are within the same folder together.
- Copy the "Patch-5.mpq" file into your client's data folder, or move the patch file contents to another patch of your choice.
