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

-- Sa'at <Keepers of Time>
function Sa_at_Spawn(Unit, event)
        Unit:RegisterEvent("Sa_at_Check_Range",2000,0)
end

function Sa_at_Check_Range(Unit, event)
        for _,plr in pairs (Unit:GetInRangePlayers()) do
                if plr:GetDistanceYards(Unit) < 20 then
                        Unit:SendChatMessage(12,0,"Stop! Do not go any further, mortal. You are ill-prepared to face the forces of the Infinite Dragonflight. Come, let me help you.")
                        Unit:Emote(1,2000)
                        Unit:RemoveEvents()
                end
        end
end

function Sa_at_Gossip(Unit, event, player)
        if player:HasFinishedQuest(10296) then
                Unit:GossipCreateMenu(10000, player, 0)
                        Unit:GossipMenuAddItem(0, "Conjure Chrono-Beacon", 1, 0)
        else
                Unit:GossipCreateMenu(10000, player, 0)
        end
end
                        


function Sa_at_Select(Unit, event, player, id, intid, code)
        if (intid == 1) then
                Unit:FullCastSpell(34975)
                Unit:RegisterEvent("Sa_at_Give_Beacon_To_Player",1000,1)
        player:GossipComplete()
        end
end

function Sa_at_Give_Beacon_To_Player(Unit, event)
        local player = Unit:GetClosestPlayer()
        player:AddItem(24289,1)
end

-- Sa'at <Keepers of Time>
RegisterUnitEvent(20201, 18, "Sa_at_Spawn")
RegisterUnitGossipEvent(20201, 1, "Sa_at_Gossip")
RegisterUnitGossipEvent(20201, 2, "Sa_at_Select")