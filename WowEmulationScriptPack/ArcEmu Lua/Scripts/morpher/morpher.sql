-- morpher sql query
/*   
	
    Hungarian Half Scripting team (HHScripts).
    Copyright (C) 2009  Twl

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

insert into `creature_names` (`entry`, `name`, `subname`, `info_str`, `Flags1`, `type`, `family`, `rank`, `unk4`, `spelldataid`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `civilian`, `leader`) 
values ('91000', "Morpher", "HHScripts by Empri", '', '0', '10', '0', '3', '0', '0', '24084 ', '0', '0', '0', '1', '1', '0', '0');

insert into `creature_proto` (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `death_state`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell_flags`, `modImmunities`) 
values ('91000', '90', '90', '35', '75000', '75000', '75000', '1.5', '1', '100', '0', '75000', '75000', '0', '0', '0', '0', '0', '75000', '0', '0', '0', '0', '0', '0', '0', '0', "0", '0', '0', '0', '0', '2.50', '8.00', '14.00', '0', '0', '0', '0', '0', '0', '0');
