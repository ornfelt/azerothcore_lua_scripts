--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
-- % Complete: 50%

--Alliance Guards--

-- Stormwind Guard ( Npc_id = 68 )
-- Ironforge Guard ( Npc_id = 5595 )
-- Darnassus Guard ( Npc_id = 4262 )

-- functions

function Alliance_OnCombat(Unit, Event)
        Unit:SendChatMessage(13, 0, "|cff00ccffFor the Alliance!")
                 
end

function Alliance_OnLeaveCombat(Unit, Event)        
end

function Alliance_OnKilledTarget(Unit, Event, Plyr)        
                Plyr:TakeHonor(25)
                player:RemoveItem(43307, 10)
                Unit:SendChatMessage(13, 0, "|cffff0000You just lost 25 Honor Points and 10 Arena points!")
         
end             

function Alliance_OnDied(Unit, Event, Plyr)
        Plyr:GiveHonor(50)
		player:AddItem(43307, 50)      
        Unit:SendChatMessage(13, 0, "|cff00ff00You have earned 50 Honor Points and Arena Points!")
end

-- Register Unit Event
--Stormwind
RegisterUnitEvent(68, 1, "Alliance_OnCombat")
RegisterUnitEvent(68, 2, "Alliance_OnLeaveCombat")
RegisterUnitEvent(68, 3, "Alliance_OnKilledTarget")
RegisterUnitEvent(68, 4, "Alliance_OnDied")
--Ironforge
RegisterUnitEvent(5595, 1, "Alliance_OnCombat")
RegisterUnitEvent(5595, 2, "Alliance_OnLeaveCombat")
RegisterUnitEvent(5595, 3, "Alliance_OnKilledTarget")
RegisterUnitEvent(5595, 4, "Alliance_OnDied")
--Darnassus
RegisterUnitEvent(4262, 1, "Alliance_OnCombat")
RegisterUnitEvent(4262, 2, "Alliance_OnLeaveCombat")
RegisterUnitEvent(4262, 3, "Alliance_OnKilledTarget")
RegisterUnitEvent(4262, 4, "Alliance_OnDied")

RegisterUnitEvent(4423, 1, "Alliance_OnCombat")
RegisterUnitEvent(4423, 2, "Alliance_OnLeaveCombat")
RegisterUnitEvent(4423, 3, "Alliance_OnKilledTarget")
RegisterUnitEvent(4423, 4, "Alliance_OnDied")
--Exodar
RegisterUnitEvent(16733, 1, "Alliance_OnCombat")
RegisterUnitEvent(16733, 2, "Alliance_OnLeaveCombat")
RegisterUnitEvent(16733, 3, "Alliance_OnKilledTarget")
RegisterUnitEvent(16733, 4, "Alliance_OnDied")
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
--Aliance Elite Guards--
-- Stormwind Royal Guard ( Npc_id = 1756 )
-- Shield of Velen ( Npc_id = 20674 )

-- functions

function Alliance_Elite_OnCombat(Unit, Event)
        Unit:SendChatMessage(13, 0, "|cff00ccffFor the Alliance!")
                 
end

function Alliance_Elite_OnLeaveCombat(Unit, Event)        
end

function Alliance_Elite_OnKilledTarget(Unit, Event, Plyr)        
                Plyr:TakeHonor(25)
                player:RemoveItem(43307, 10)
                Unit:SendChatMessage(13, 0, "|cffff0000You just lost 25 Honor Points and 10 Arena points!")
         
end             

function Alliance_Elite_OnDied(Unit, Event, Plyr)
        Plyr:GiveHonor(100)
		player:AddItem(43307, 100) 
        Unit:SendChatMessage(13, 0, "|cff00ff00You have earned 100 Honor Points and Arena Points!")
end

-- Register Unit Event
--Stormwind
RegisterUnitEvent(1756, 1, "Alliance_Elite_OnCombat")
RegisterUnitEvent(1756, 2, "Alliance_Elite_OnLeaveCombat")
RegisterUnitEvent(1756, 3, "Alliance_Elite_OnKilledTarget")
RegisterUnitEvent(1756, 4, "Alliance_Elite_OnDied")
--Exodar
RegisterUnitEvent(20674, 1, "Alliance_Elite_OnCombat")
RegisterUnitEvent(20674, 2, "Alliance_Elite_OnLeaveCombat")
RegisterUnitEvent(20674, 3, "Alliance_Elite_OnKilledTarget")
RegisterUnitEvent(20674, 4, "Alliance_Elite_OnDied")

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
--Horde Guards--

-- Orgrimmar Grunt ( Npc_id = 3296 )
-- BluffWatcher    ( Npc_id = 3084 )
-- Silvermoon City ( Npc_id = 16222 )
-- Undercity Guardian ( Npc_id = 5624 )

-- functions

function Horde_OnCombat(Unit, Event)
        Unit:SendChatMessage(13, 0, "|cff00ccffFor the Horde!")
                 
end

function Horde_OnLeaveCombat(Unit, Event)        
end

function Horde_OnKilledTarget(Unit, Event, Plyr)
                Plyr:TakeHonor(25)
                player:RemoveItem(43307, 10)
                Unit:SendChatMessage(13, 0, "|cffff0000You just lost 25 Honor Points and 10 Arena points!")
         
end             

function Horde_OnDied(Unit, Event, Plyr)
        Plyr:GiveHonor(100)
		player:AddItem(43307, 100) 
        Unit:SendChatMessage(13, 0, "|cff00ff00You have earned 100 Honor Points and Arena Points!")
end

-- Register Unit Event
--Orgrimmar
RegisterUnitEvent(3296, 1, "Horde_OnCombat")
RegisterUnitEvent(3296, 2, "Horde_OnLeaveCombat")
RegisterUnitEvent(3296, 3, "Horde_OnKilledTarget")
RegisterUnitEvent(3296, 4, "Horde_OnDied")
--Thunder Bluff
RegisterUnitEvent(3084, 1, "Horde_OnCombat")
RegisterUnitEvent(3084, 2, "Horde_OnLeaveCombat")
RegisterUnitEvent(3084, 3, "Horde_OnKilledTarget")
RegisterUnitEvent(3084, 4, "Horde_OnDied")
--Silvermoon City
RegisterUnitEvent(16222, 1, "Horde_OnCombat")
RegisterUnitEvent(16222, 2, "Horde_OnLeaveCombat")
RegisterUnitEvent(16222, 3, "Horde_OnKilledTarget")
RegisterUnitEvent(16222, 4, "Horde_OnDied")
--Undercity154980
RegisterUnitEvent(5624, 1, "Horde_OnCombat")
RegisterUnitEvent(5624, 2, "Horde_OnLeaveCombat")
RegisterUnitEvent(5624, 3, "Horde_OnKilledTarget")
RegisterUnitEvent(5624, 4, "Horde_OnDied")

RegisterUnitEvent(36213, 1, "Horde_OnCombat")
RegisterUnitEvent(36213, 2, "Horde_OnLeaveCombat")
RegisterUnitEvent(36213, 3, "Horde_OnKilledTarget")
RegisterUnitEvent(36213, 4, "Horde_OnDied")

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
--Horde Elite Guards--

-- Kor'kron Elite ( Npc_id = 14304 )
-- Honor Guard    ( Npc_id = 3083  )
-- Royal Guard    ( Npc_id = 20672 )
-- Royal Dreadguard ( Npc_id = 13839 )
-- functions

function Horde_Elite_OnCombat(Unit, Event)
    Unit:SendChatMessage(13, 0, "|cff00ccffFor the Horde!")             
end

function Horde_Elite_OnLeaveCombat(Unit, Event)      
end

function Horde_Elite_OnKilledTarget(Unit, Event)     
    Plyr:TakeHonor(25)
    player:RemoveItem(43307, 10)
    Unit:SendChatMessage(13, 0, "|cffff0000You just lost 25 Honor Points and 10 Arena points!")     
end             

function Horde_Elite_OnDied(Unit, Event)
    player:GiveHonor(100)
	player:AddItem(43307, 100) 
    Unit:SendChatMessage(13, 0, "|cff00ff00You have earned 100 Honor Points and Arena Points!")
end

-- Register Unit Event
--Orgrimmar
RegisterUnitEvent(14304, 1, "Horde_Elite_OnCombat")
RegisterUnitEvent(14304, 2, "Horde_Elite_OnLeaveCombat")
RegisterUnitEvent(14304, 3, "Horde_Elite_OnKilledTarget")
RegisterUnitEvent(14304, 4, "Horde_Elite_OnDied")
--Thunder Bluff
RegisterUnitEvent(3083, 1, "Horde_Elite_OnCombat")
RegisterUnitEvent(3083, 2, "Horde_Elite_OnLeaveCombat")
RegisterUnitEvent(3083, 3, "Horde_Elite_OnKilledTarget")
RegisterUnitEvent(3083, 4, "Horde_Elite_OnDied")
--Silvermoon City
RegisterUnitEvent(20672, 1, "Horde_Elite_OnCombat")
RegisterUnitEvent(20672, 2, "Horde_Elite_OnLeaveCombat")
RegisterUnitEvent(20672, 3, "Horde_Elite_OnKilledTarget")
RegisterUnitEvent(20672, 4, "Horde_Elite_OnDied")
--Undercity
RegisterUnitEvent(13839, 1, "Horde_Elite_OnCombat")
RegisterUnitEvent(13839, 2, "Horde_Elite_OnLeaveCombat")
RegisterUnitEvent(13839, 3, "Horde_Elite_OnKilledTarget")
RegisterUnitEvent(13839, 4, "Horde_Elite_OnDied")
