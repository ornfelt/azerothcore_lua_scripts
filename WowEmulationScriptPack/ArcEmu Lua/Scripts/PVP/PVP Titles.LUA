--        ##### ##         ##### ##          ##### ##        ##### ##   
--     /#####  /##      ######  /###      /#####  /##     ######  /##   
--   //    /  / ###    /#   /  /  ###   //    /  / ###   /#   /  / ##   
--  /     /  /   ###  /    /  /    ### /     /  /   ### /    /  /  ##   
--       /  /     ###     /  /      ##      /  /     ###    /  /   /    
--      ## ##      ##    ## ##      ##     ## ##      ##   ## ##  /     
--      ## ##      ##    ## ##      ##     ## ##      ##   ## ## /      
--      ## ##      ##  /### ##      /      ## ##      ##   ## ##/       
--      ## ##      ## / ### ##     /       ## ##      ##   ## ## ###    
--      ## ##      ##    ## ######/        ## ##      ##   ## ##   ###  
--      #  ##      ##    ## ######         #  ##      ##   #  ##     ## 
--         /       /     ## ##                /       /       /      ## 
--    /###/       /      ## ##           /###/       /    /##/     ###  
--   /   ########/       ## ##          /   ########/    /  ########    
--  /       ####    ##   ## ##         /       ####     /     ####      
--  #              ###   #  /          #                #               
--   ##             ###    /            ##               ##             
--                  #####/                                             
--                    ###               www.DPS-DB.com         

-- Blizzlike PvP Title System
----------------------------------------------
-- DO NOT CHANGE ANYTHING BEYOND THIS POINT --
----------------------------------------------


-------------------
----Ally Titles----
-------------------
local Private = 1
local Corporal = 2
local Sergeant = 3
local Master_Sergeant = 4
local Sergeant_Major = 5
local Knight = 6
local Knight_Lieutenant = 7
local Knight_Captain = 8
local Knight_Champion = 9
local Lieutenant_Commander = 10
local Commander = 11
local Marshal = 12
local Field_Marshal = 13
local Grand_Marshal = 14

------------------
---Horde Titles---
------------------
local Scout = 15
local Grunt = 16
local Sergeant = 17
local Senior_Sergeant = 18
local First_Sergeant = 19
local Stone_Guard = 20
local Blood_Guard = 21
local Legionnaire  = 22
local Centurion = 23
local Champion = 24
local Lieutenant_General = 25
local General = 26
local Warlord = 27
local High_Warlord = 28

function HKCheck_Proc(event, player, victim)
        if (player:LifeTimeKills(0, "0") == Rank1) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Private)
        elseif (player:LifeTimeKills(0, "0") == Rank2) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Corporal)
                player:UnsetKnownTitle(Private)
        elseif (player:LifeTimeKills(0, "0") == Rank3) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Sergeant)
                player:UnsetKnownTitle(Corporal)
        elseif (player:LifeTimeKills(0, "0") == Rank4) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Master_Sergeant)
                player:UnsetKnownTitle(Sergeant)
        elseif (player:LifeTimeKills(0, "0") == Rank5) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Sergeant_Major)
                player:UnsetKnownTitle(Master_Sergeant)
        elseif (player:LifeTimeKills(0, "0") == Rank6) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Knight)
                player:UnsetKnownTitle(Sergeant_Major)
        elseif (player:LifeTimeKills(0, "0") == Rank7) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Knight_Lieutenant)
                player:UnsetKnownTitle(Knight)
        elseif (player:LifeTimeKills(0, "0") == Rank8) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Knight_Captain)
                player:UnsetKnownTitle(Knight_Lieutenant)
        elseif (player:LifeTimeKills(0, "0") == Rank9) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Knight_Champion)
                player:UnsetKnownTitle(Knight_Captain)
        elseif (player:LifeTimeKills(0, "0") == Rank10) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Lieutenant_Commander)
                player:UnsetKnownTitle(Knight_Champion)
        elseif (player:LifeTimeKills(0, "0") == Rank11) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Commander)
                player:UnsetKnownTitle(Lieutenant_Commander)
        elseif (player:LifeTimeKills(0, "0") == Rank12) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Marshal)
                player:UnsetKnownTitle(Commander)
        elseif (player:LifeTimeKills(0, "0") == Rank13) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Field_Marshal)
                player:UnsetKnownTitle(Marshal)
        elseif (player:LifeTimeKills(0, "0") == Rank14) and (player:GetTeam() == 0) then
                player:SetKnownTitle(Grand_Marshal)
                player:UnsetKnownTitle(Field_Marshal)
        end
        if (player:LifeTimeKills(0, "0") == Rank1) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Scout)
        elseif (player:LifeTimeKills(0, "0") == Rank2) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Grunt)
                player:UnsetKnownTitle(Scout)
        elseif (player:LifeTimeKills(0, "0") == Rank3) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Sergeant)
                player:UnsetKnownTitle(Grunt)
        elseif (player:LifeTimeKills(0, "0") == Rank4) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Senior_Sergeant)
                player:UnsetKnownTitle(Sergeant)
        elseif (player:LifeTimeKills(0, "0") == Rank5) and (player:GetTeam() == 1) then
                player:SetKnownTitle(First_Sergeant)
                player:UnsetKnownTitle(Senior_Sergeant)
        elseif (player:LifeTimeKills(0, "0") == Rank6) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Stone_Guard)
                player:UnsetKnownTitle(First_Sergeant)
        elseif (player:LifeTimeKills(0, "0") == Rank7) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Blood_Guard)
                player:UnsetKnownTitle(Stone_Guard)
        elseif (player:LifeTimeKills(0, "0") == Rank8) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Legionnaire)
                player:UnsetKnownTitle(Blood_Guard)
        elseif (player:LifeTimeKills(0, "0") == Rank9) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Centurion)
                player:UnsetKnownTitle(Legionnaire)
        elseif (player:LifeTimeKills(0, "0") == Rank10) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Champion)
                player:UnsetKnownTitle(Centurion)
        elseif (player:LifeTimeKills(0, "0") == Rank11) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Lieutenant_General)
                player:UnsetKnownTitle(Champion)
        elseif (player:LifeTimeKills(0, "0") == Rank12) and (player:GetTeam() == 1) then
                player:SetKnownTitle(General)
                player:UnsetKnownTitle(Lieutenant_General)
        elseif (player:LifeTimeKills(0, "0") == Rank13) and (player:GetTeam() == 1) then
                player:SetKnownTitle(Warlord)
                player:UnsetKnownTitle(General)
        elseif (player:LifeTimeKills(0, "0") == Rank14) and (player:GetTeam() == 1) then
                player:SetKnownTitle(High_Warlord)
                player:UnsetKnownTitle(Warlord)
        end
end

-- Blizzlike PvP Title System
RegisterServerHook(23, "HKCheck_Proc")