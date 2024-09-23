local NPC_ID = 190025

local function OnGossipHello(event, player, object)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Customize character", 0, 1)
    player:GossipMenuAddItem(0, "Change race", 0, 4)
    player:GossipMenuAddItem(0, "Change faction", 0, 7)
    player:GossipSendMenu(1, object, NPC_ID)
end

local function OnGossipSelect(event, player, object, sender, intid, code)
    if (intid == 1) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "Yes, customize my character", 0, 2)
        player:GossipMenuAddItem(0, "No, cancel", 0, 3)
        player:GossipSendMenu(1, object, NPC_ID)
    elseif (intid == 2) then
        local name = player:GetName()
        player:SendBroadcastMessage("Customization option selected. Please log out and back in.")
        player:SetAtLoginFlag(8) -- Set the "Customize Character" flag
        player:GossipComplete()
    elseif (intid == 3) then
        player:SendBroadcastMessage("Customization cancelled.")
        player:GossipComplete()
    elseif (intid == 4) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "Yes, change my race", 0, 5)
        player:GossipMenuAddItem(0, "No, cancel", 0, 6)
        player:GossipSendMenu(1, object, NPC_ID)
    elseif (intid == 5) then
        local name = player:GetName()
        player:SendBroadcastMessage("Changing race option selected. Please log out and back in.")
        player:SetAtLoginFlag(128) -- Set the "Change Race" flag
        player:GossipComplete()
    elseif (intid == 6) then
        player:SendBroadcastMessage("Race change cancelled.")
        player:GossipComplete()
    elseif (intid == 7) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "Yes, change my faction", 0, 8)
        player:GossipMenuAddItem(0, "No, cancel", 0, 9)
        player:GossipSendMenu(1, object, NPC_ID)
    elseif (intid == 8) then
        local name = player:GetName()
        player:SendBroadcastMessage("Changing faction option selected. Please log out and back in.")
        player:SetAtLoginFlag(64) -- Set the "Change Faction" flag
        player:GossipComplete()
    elseif (intid == 9) then
        player:SendBroadcastMessage("Faction change cancelled.")
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)

WorldDBQuery("DELETE FROM `creature_template` WHERE `entry`=190025;")
WorldDBQuery("INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (190025, 0, 0, 0, 0, 0, 31706, 0, 0, 0, 'Charlie', 'Character Customizer', NULL, 0, 10, 10, 0, 35, 3, 1.2, 1.24286, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 2, '', 12340);")
