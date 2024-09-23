# TemplateNPC
Template NPC for TrinityCore 3.3.5  (Updated 10-March-2019)  


## How to install  
**1.** Navigate to your **TrinityCore\src\server\scripts\Custom** and make a new folder called **TemplateNPC**.  
Copy **TemplateNPC.cpp** and **TemplateNPC.h** to your **TemplateNPC** folder you just created.  (this is optional but I recommend it just to keep things organized)<br/>

![alt_tag](https://i.ibb.co/510V7Y8/Template-NPC.png)

***

**2.** Add TemplateNPC to \src\server\scripts\Custom\ **custom_script_loader.cpp**<br/>

![alt_tag](https://i.imgur.com/kNRA3Au.png)<br/>

***

**3.** Use CMake (configure and generate)<br/>

***

**4.** Execute **characters.sql** to your database<br/>

***

**5.** Open TrinityCore.sln and Build the solution. Click on **Build** and then **Build Solution** or press (Ctrl+Shift+B)<br/>

![alt_tag](https://i.ibb.co/R2m3Rwy/build-solution.png)  
  
***
  
## Screenshot
![alt tag](https://image.ibb.co/nGfeYn/template_Npc.png)  
  
Video Showcase:  
https://streamable.com/yxv1m

***

**NOTE:** You can use **.templatenpc reload** command if you changed template gear, talents, glyphs. So you don't have to restart your server.
