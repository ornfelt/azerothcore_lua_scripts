-- server agent query

insert into `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `unk4`, `spelldataid`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `civilian`, `leader`) 
values ('89000', "Server Agent", "HHScripts by Twl", '', '0', '7', '0', '2', '0', '0', '27153', '0', '0', '0', '1', '1', '1', '0');

insert into `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `death_state`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`) 
values ('89000', '83', '83', '35', '2350000', '2350000', '1200000', '1', '1', '1300', '0', '2300', '5400', '0', '0', '0', '0', '300000', '60000', '100', '100', '100', '100', '100', '100', '0', '0', "0", '0', '1304455', '0', '0', '2.50', '8.00', '14.00', '0', '0', '0', '0', '0', '0', '0');
