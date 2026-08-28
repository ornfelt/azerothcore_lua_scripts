-- --------------------------------------------------------------------------------------
--  LOTTERY SYSTEM - Installation Script (Fixed for AzerothCore latest)
-- --------------------------------------------------------------------------------------
SET
@Entry      := 500001,
@Model      := 14888,
@Name       := "Lottery Master",
@Title      := "Lucky Games",
@Icon       := "Speak",
@GossipMenu := 0,
@MinLevel   := 80,
@MaxLevel   := 80,
@Faction    := 35,
@NPCFlag    := 1,
@Scale      := 1.0,
@Type       := 7,
@TypeFlags  := 0,
@FlagsExtra := 2;

-- Cleanup
DELETE FROM `creature_template` WHERE `entry` = @Entry;
DELETE FROM `creature_template_model` WHERE `CreatureID` = @Entry;
DELETE FROM `creature_text` WHERE `CreatureID` = @Entry;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @Entry AND `source_type` = 0;

-- Create NPC Template
INSERT INTO `creature_template` (
    `entry`, `name`, `subname`, `IconName`, `gossip_menu_id`,
    `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
    `detection_range`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `type`, `type_flags`, `RegenHealth`,
    `CreatureImmunitiesId`, `flags_extra`, `AIName`, `ScriptName`, `VerifiedBuild`
) VALUES (
    @Entry, @Name, @Title, @Icon, @GossipMenu,
    @MinLevel, @MaxLevel, 0, @Faction, @NPCFlag,
    1.0, 1.14286, 1.0, 1.0,
    20.0, 1, 2, 0,
    0, @Type, @TypeFlags, 1,
    0, @FlagsExtra, 'SmartAI', '', 0
);

-- Add NPC Model
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(@Entry, 0, @Model, 1, 1, 0);

-- Add NPC Text
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@Entry, 0, 0, 'Step right up! Try your luck in our lottery! Just one Emblem of Frost could win you amazing prizes!', 14, 0, 100, 22, 0, 0, 0, 0, 'Lottery Master Yell');

-- Add SmartAI
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@Entry, 0, 0, 0, 1, 0, 100, 0, 1000, 60000, 60000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 'Lottery Master - OOC - Say Text');
