SET @ENTRY := 210000;

INSERT INTO creature_template (entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1,
                               KillCredit2, modelid1, modelid2, modelid3, modelid4, name, subname, IconName,
                               gossip_menu_id, minlevel, maxlevel, exp, faction, npcflag, speed_walk, speed_run,
                               speed_swim, speed_flight, detection_range, scale, `rank`, dmgschool, DamageModifier,
                               BaseAttackTime, RangeAttackTime, BaseVariance, RangeVariance, unit_class, unit_flags,
                               unit_flags2, dynamicflags, family, trainer_type, trainer_spell, trainer_class,
                               trainer_race, type, type_flags, lootid, pickpocketloot, skinloot, PetSpellDataId,
                               VehicleId, mingold, maxgold, AIName, MovementType, HoverHeight, HealthModifier,
                               ManaModifier, ArmorModifier, ExperienceModifier, RacialLeader, movementId, RegenHealth,
                               mechanic_immune_mask, spell_school_immune_mask, flags_extra, ScriptName, VerifiedBuild)
VALUES (@ENTRY, 0, 0, 0, 0, 0, 7054, 0, 0, 0, 'Sputtervalve Son', 'Tinkers Union', null, 21, 15, 15, 0, 69, 3, 1,
        1.14286, 1,
        1, 18, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1,
        1, 1, 1, 1, 0, 0, 1, 0, 0, 2, '', 12340);


INSERT INTO creature (id1, id2, id3, map, zoneId, areaId, spawnMask, phaseMask, equipment_id,
                      position_x, position_y, position_z, orientation, spawntimesecs, wander_distance,
                      currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags,
                      ScriptName, VerifiedBuild)
VALUES (@ENTRY, 0, 0, 0, 0, 0, 1, 1, 1, -4913.9, -971.14, 501.463, 0.0595295, 300, 0, 0, 328, 0, 0, 0, 0, 0, '',
        null);
