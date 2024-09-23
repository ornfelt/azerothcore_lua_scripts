local enabled = false
local command = "gmmenu"



local function Hello(event, player)
local level = player:GetLevel()
player:GossipClearMenu()

	player:GossipMenuAddItem(0, "Give Gold", 0, 1, true, "You want some gold?")
	player:GossipMenuAddItem(0, "Spawn NPC (20 Seconds) (Zombie = 1501)", 0, 2, true, "What is the NPC ID?")
	player:GossipMenuAddItem(0, "Add Item", 0, 22, true, "What is the Item ID?")
	player:GossipMenuAddItem(0, "Set Level", 0, 3, true, "What level?")
	if level < 80 then
	player:GossipMenuAddItem(0, "Give XP", 0, 4, true, "How Much XP?")
	end
	player:GossipMenuAddItem(0, "Add Quest by ID", 0, 23, true, "Quest ID?")
	player:GossipMenuAddItem(0, "Complete Quest by ID", 0, 90, true, "Quest ID?")
	player:GossipMenuAddItem(0, "Summon your Class Trainer", 0, 5)
	player:GossipMenuAddItem(0, "Learn Spell", 0, 26, true, "What is the Spell ID?")
	player:GossipMenuAddItem(0, "Summon Taxi", 0, 20)
	player:GossipMenuAddItem(0, "Max All Skills", 0, 24)
	if player:HasAura( 15007 ) then
	player:GossipMenuAddItem(0, "Remove Resurrection Sickness", 0, 25)
	end
	player:GossipMenuAddItem(0, "Teleport to Starting Areas", 0, 6)
	player:GossipMenuAddItem(0, "Set Hearthstone", 0, 91)
	player:GossipMenuAddItem(0, "Set movement speed", 0, 92, true, "How fast?")
	if player:HasSpellCooldown( 8690 ) then
	player:GossipMenuAddItem(0, "Reset Hearthstone Cooldown", 0, 93)
	end
	player:GossipMenuAddItem(0, "Reset ALL Cooldowns", 0, 21)
	
	player:GossipMenuAddItem(0, "[Exit Menu]", 0, 99)
	
		
player:GossipSendMenu(1, player, 1979)
end



local function OnSelect(event, player, _, sender, intid, code)
player:GossipClearMenu()
		local map = player:GetMap()
		local mapID = map:GetMapId()
		local x = player:GetX()
		local y = player:GetY()
		local z = player:GetZ()
		local o = player:GetO()
		local areaId = map:GetAreaId( x, y, z )
		
		local level = player:GetLevel()
		local currentgold = player:GetCoinage()
		local class = player:GetClass()
		local faction = player:GetFaction()
		local gold = 10000
		local Target = player:GetSelectedPlayer()
		
		local typeID
		
		if Target == nil then
		Target = player:GetSelection()
		end
		
		if Target ~= nil then
		typeID = Target:GetTypeId()
		end
		
		
	if(intid== 1) then
	if code ~= nil then
	local isnum = tonumber(code)
	if typeID == 4 then
	if isnum then
		if isnum >= -214748 and isnum <= 214748 then
	    Target:ModifyMoney( gold*isnum )
		else
		if isnum <= -214748 then 
		player:SendAreaTriggerMessage("Value must be greater than -214748")
		end
		if isnum >= 214748 then 
		player:SendAreaTriggerMessage("Value must be less than 214748")
		end
		end

		player:GossipComplete()
	else
	    player:SendAreaTriggerMessage(""..tostring(code).." is not a number.")
		player:GossipComplete()
	end
	else
	player:SendAreaTriggerMessage("Target is not a Player!!")

	end
	
	end
	player:GossipComplete()
	end
	
	if(intid== 2) then
	local spawnedCreature
	local spawnedCreature2
	local spawnedCreature3
	local spawnedCreature4
	
	local spawnlevel = level

	spawnedCreature = player:SpawnCreature( code, x+1, y+1, z+0.5, o-3.5, 1, 20  )
	spawnedCreature:SetLevel( spawnlevel )
	
	
	spawnedCreature2 = player:SpawnCreature( code, x+2, y+2, z+0.5, o-3.5, 1, 20  )
	spawnedCreature2:SetLevel( spawnlevel )
	
	
	spawnedCreature3 = player:SpawnCreature( code, x+3, y+3, z+0.5, o-3.5, 1, 20  )
	spawnedCreature3:SetLevel( spawnlevel )
	
	
	spawnedCreature4 = player:SpawnCreature( code, x+4, y+4, z+0.5, o-3.5, 1, 20  )
	spawnedCreature4:SetLevel( spawnlevel )
	
	
	player:GossipComplete()
	end
	
	if (intid== 3) then
	Target:SetLevel( code )
	player:GossipComplete()
	end
	
	if (intid== 4) then
		if typeID == 4 then
		Target:GiveXP( code )
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
	player:GossipComplete()
	end
	

	if(intid== 5) then

	if class == 1 then
	player:SpawnCreature( 26332, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 2 then
	player:SpawnCreature( 26327, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 3 then
	player:SpawnCreature( 26325, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 4 then
	player:SpawnCreature( 26329, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 5 then
	player:SpawnCreature( 26328, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	
	if class == 6 then
	player:SpawnCreature( 33251, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 7 then
	player:SpawnCreature( 26330, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 8 then
	player:SpawnCreature( 26326, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 9 then
	player:SpawnCreature( 26331, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end
	
	if class == 11 then
	player:SpawnCreature( 26324, x+1, y+1, z+0.5, o-3.5, 1, 120 )
	end

	end
	
	if(intid== 6) then
	if player:IsHorde() then
	player:GossipMenuAddItem(0, "Tauren Starting Area", 0, 7)
	player:GossipMenuAddItem(0, "Undead Starting Area", 0, 8)
	player:GossipMenuAddItem(0, "Bloode Elf Starting Area", 0, 9)
	player:GossipMenuAddItem(0, "Orc/Troll Starting Area", 0, 10)

	else
	player:GossipMenuAddItem(0, "Gnome/Dwarf Starting Area", 0, 11)
	player:GossipMenuAddItem(0, "Night Elf Starting Area", 0, 12)
	player:GossipMenuAddItem(0, "Draenei Starting Area", 0, 13)
	player:GossipMenuAddItem(0, "Human Starting Area", 0, 14)
	end
	player:GossipMenuAddItem(0, "Back", 0, 15)
	player:GossipSendMenu(1, player, 1979)
	
	end
	
	
	if(intid == 7) then
		player:Teleport( 1, -2921, -244, 53.33, 4.62 )
		player:GossipComplete()
	end

	if(intid == 8) then
		player:Teleport( 0, 1662, 1663, 141.89, 6.26 )
		player:GossipComplete()
	end
	
	if(intid == 9) then
		player:Teleport( 530, 10345, -6372, 35.89, 1.40 )
		player:GossipComplete()
	end
	
	if(intid == 10) then
		player:Teleport( 1, -601, -4266, 39, 1.79 )
		player:GossipComplete()
	end
	
	if(intid == 11) then
		player:Teleport( 0, -6240, 342, 383.22, 5.36 )
		player:GossipComplete()
	end
	
	
	if(intid == 12) then
		player:Teleport( 1, 10311.30, 831.46, 1326.41, 5.48 )
		player:GossipComplete()
	end
	
	if(intid == 13) then
		player:Teleport( 530, -3963, -13934, 100.26, 1.64 )
		player:GossipComplete()
	end
	
	if(intid == 14) then
		player:Teleport( 0, -8950, -132.50, 83.53, 0 )
		player:GossipComplete()
	end
	
	if(intid == 15) then
		Hello(event, player)
		return false
	end
	
	if(intid == 20) then
		player:SpawnCreature( 37888, x+1, y+1, z+0.5, o-3.5, 1, 20 )
		player:GossipComplete()
	end
	
	if(intid == 21) then
		player:ResetAllCooldowns()
		player:GossipComplete()
	end
	
	if(intid == 22) then
	if typeID == 4 then
		Target:AddItem( code, 1 )
		else
	player:SendAreaTriggerMessage("Target is not a Player!!")	
	end
		player:GossipComplete()
	end
	
	if(intid == 23) then
		if typeID == 4 then
		Target:AddQuest( code )
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 24) then
		if typeID == 4 then
		Target:AdvanceSkillsToMax()
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 25) then
		if typeID == 4 then
		Target:RemoveAura( 15007 )
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 26) then
		if typeID == 4 then
		Target:LearnSpell( code )
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 90) then
		if typeID == 4 then
		Target:CompleteQuest( code )
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 91) then
		if typeID == 4 then
		player:SetBindPoint( x, y, z, map:GetMapId(), areaId )
		player:SendAreaTriggerMessage("This is your new home location!")
		player:ResetSpellCooldown( 8690, true ) --Hearthstone return spell ID 8690
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 92) then
		if typeID == 4 then
		Target:SetSpeed( 1, code, true )
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 93) then
		if typeID == 4 then
		player:ResetSpellCooldown( 8690, true ) --Hearthstone return spell ID 8690
		else
		player:SendAreaTriggerMessage("Target is not a Player!!")	
		end
		player:GossipComplete()
	end
	
	if(intid == 99) then
		player:SendAreaTriggerMessage("Good Bye!")
		player:GossipComplete()
	end
end



local function PlrMenu(event, player, message)
	
	if (message:lower() == command) then
		if enabled or (player:GetGMRank() > 2) then
		Hello(event, player)
		return false
	end
	end
end


RegisterPlayerEvent(42, PlrMenu)
RegisterPlayerGossipEvent(1979, 2, OnSelect)