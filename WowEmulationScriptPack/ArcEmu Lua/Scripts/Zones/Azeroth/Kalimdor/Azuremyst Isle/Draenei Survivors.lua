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

-- Draenei Survivors
DRAENEISURVIVOR = {}

function DRAENEISURVIVOR_onDied(Unit, event, player)
Unit:RemoveEvents()
end

function DRAENEISURVIVOR_onSpawn(Unit, event, player)
Unit:RegisterEvent("DRAENEISURVIVOR_Say",30000, 0)
end

function DRAENEISURVIVOR_Say(Unit, event, player)
local chance = math.random(1,3)
	if(chance == 1) then
		Unit:SendChatMessage(12, 35, "Ughhh... I am hurt. Can you help me?" )
	end
	if(chance == 2) then
		Unit:SendChatMessage(12, 35, "Oh, the pain...")
	end
	if(chance == 3) then
		Unit:SendChatMessage(12, 35, "I dont know, if I can make it. Please help me...")
	end
end

-- Draenei Survivors
RegisterUnitEvent(16483, 18, "DRAENEISURVIVOR_onSpawn")
RegisterUnitEvent(16483, 4, "DRAENEISURVIVOR_onDied")