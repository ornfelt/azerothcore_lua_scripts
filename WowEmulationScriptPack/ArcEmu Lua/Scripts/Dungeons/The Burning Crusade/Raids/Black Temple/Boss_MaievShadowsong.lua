--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   Boss_MaievShadowsong.lua
   Original Code by DARKI
   Version 1
========================================]]--






function Maiev_Died(Unit, event, player)

Unit:RemoveEvents()

end


function Maiev_OnCombat(Unit, event, player)

Unit:RegisterEvent("Maiev_Say", 62000, 0)

end



function Maiev_Say(Unit, event, player)

Unit:SendChatMessage(12, 0, "I've waited for this moment for years. Illidan and his lapdogs will be destroyed!!")
Unit:SendChatMessage(12, 0, "You've sealed your fate, Akama. The Master will learn of your betrayal!")

end


RegisterUnitEvent(21699, 18, "Maiev_OnCombat")

RegisterUnitEvent(21699, 4, "Maiev_Died")

