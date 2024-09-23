--[==[

-- vmangos v21
INSERT INTO `creature_template` (`entry`, `patch`, `display_id1`, `display_id2`, `display_id3`
	, `display_id4`, `name`, `subname`, `gossip_menu_id`, `level_min`
	, `level_max`, `faction`, `npc_flags`, `speed_walk`, `speed_run`
	, `display_scale1`, `detection_range`, `call_for_help_range`, `leash_range`, `rank`
	, `xp_multiplier`, `damage_school`, `damage_multiplier`, `base_attack_time`, `ranged_attack_time`
	, `unit_class`, `unit_flags`, `pet_family`, `trainer_type`, `trainer_spell`
	, `trainer_class`, `trainer_race`, `type`, `type_flags`, `loot_id`
	, `pickpocket_loot_id`, `skinning_loot_id`, `holy_res`, `fire_res`, `nature_res`
	, `frost_res`, `shadow_res`, `arcane_res`, `spell_id1`, `spell_id2`
	, `spell_id3`, `spell_id4`, `spell_list_id`, `pet_spell_list_id`, `gold_min`
	, `gold_max`, `ai_name`, `movement_type`, `inhabit_type`, `civilian`
	, `racial_leader`, `regeneration`, `equipment_id`, `trainer_id`, `vendor_id`
	, `mechanic_immune_mask`, `school_immune_mask`, `flags_extra`, `script_name`)
VALUES ('70006', '0', '11121', '0', '0'
	, '0', '传送商人', '快速传送到安其拉', '0', '55'
	, '55', '35', '1', '1.1', '1.14286'
	, '0.1', '20', '5', '0', '0'
	, '1', '0', '1', '2000', '2000'
	, '8', '32768', '0', '0', '0'
	, '0', '0', '7', '0', '0'
	, '0', '0', '0', '0', '0'
	, '0', '0', '0', '0', '0'
	, '0', '0', '0', '0', '0'
	, '0', '', '0', '3', '0'
	, '0', '3', '0', '0', '0'
	, '0', '0', '0', '');


    = How to add new locations =

    Example:

    The first line will be the main menu ID (Here [1], 
    increment this for each main menu option!),
    the main menu gossip title (Here "Horde Cities"),
    as well as which faction can use the said menu (Here 1 (Horde)). 
    0 = Alliance, 1 = Horde, 2 = Both

    The second line is the name of the main menu's sub menus, 
    separated by name (Here "Orgrimmar") and teleport coordinates
    using Map, X, Y, Z, O (Here 1, 1503, -4415.5, 22, 0)

    [1] = { "Horde Cities", 1,	--  This will be the main menu title, as well as which faction can use the said menu. 0 = Alliance, 1 = Horde, 2 = Both
        {"Orgrimmar", 1, 1503, -4415.5, 22, 0},
    },

    You can copy paste the above into the script and change the values as informed.
]==]
print(">>  AQL Teleport Man")
local UnitEntry = 70006

local T = {
	[1] = { "进入神秘之地", 1,
		{"进入安其拉废墟", 509, 8418.5, 1505.94, 31.8232, 509},
		{"进入安其拉神殿", 531, -8212, 2034.47, 129.141, 0},

	},

}

local function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

-- CODE STUFFS! DO NOT EDIT BELOW
-- UNLESS YOU KNOW WHAT YOU'RE DOING!

local function OnGossipHello(event, player, unit)
	print(dump(T))
    -- Show main menu
    for i, v in ipairs(T) do
        --print(dump(v).. " " .. player:GetTeam())
        --此处加阵营判断是为什么？
        --if (v[2] == 2 or v[2] == player:GetTeam()) then
            player:GossipMenuAddItem(0, v[1], i, 0)
        --end
    end
    player:GossipSendMenu(1, unit)
end	

local function OnGossipSelect(event, player, unit, sender, intid, code)
	print(sender)
	print(intid)
    if (sender == 0) then
        -- return to main menu
        OnGossipHello(event, player, unit)
        return
    end

    if (intid == 0) then
        -- Show teleport menu
        for i, v in ipairs(T[sender]) do
            if (i > 2) then
                player:GossipMenuAddItem(0, v[1], sender, i)
            end
        end
        player:GossipMenuAddItem(0, "返回", 0, 0)
        player:GossipSendMenu(1, unit)
        return
    else
        -- teleport
        local name, map, x, y, z, o = table.unpack(T[sender][intid])
        player:Teleport(map, x, y, z, o)
    end
    
    player:GossipComplete()
end

RegisterCreatureGossipEvent(UnitEntry, 1, OnGossipHello)
RegisterCreatureGossipEvent(UnitEntry, 2, OnGossipSelect)