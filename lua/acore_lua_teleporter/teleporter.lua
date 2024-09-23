--This script takes elements from Clottic, Rochet and other people's scripts. I just improved upon it and added a morph.

--[==[
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
	
	ItemEntry is set to Hearthstone. You may use another entry with a spell cast.
]==]

local ItemEntry = 6948 -- Hearthstone. You can change this item ID to whatever as long as it has a spell.

local T = {
	[1] = { "|TInterface\\icons\\achievement_pvp_h_h:37:37:-23|t|cff610B0BHorde Cities|r", 1,
		{"|TInterface\\icons\\achievement_zone_durotar:37:37:-23|t|cff610B0BOrgrimmar|r", 1, 1503, -4415.5, 22, 0},
		{"|TInterface\\icons\\achievement_zone_tirisfalglades_01:37:37:-23|t|cff610B0BUndercity|r", 0, 1831, 238.5, 61.6, 0},
		{"|TInterface\\icons\\achievement_zone_mulgore_01:37:37:-23|t|cff610B0BThunderbluff|r", 1, -1278, 122, 132, 0},
		{"|TInterface\\icons\\achievement_zone_bloodmystisle_01:37:37:-23|t|cff610B0BSilvermoon|r", 530, 9487.69, -7279.2, 14.2866, 0},
		{"|TInterface\\icons\\achievement_reputation_wyrmresttemple:37:37:-23|t|cff642EFEShattrath|r", 530, -1838.16, 5301.79, -12.428, 0},
		{"|TInterface\\icons\\achievement_reputation_kirintor:37:37:-23|t|cff642EFEDalaran|r", 571, 5804.15, 624.771, 647.767, 0},
	},
	[2] = {"|TInterface\\icons\\achievement_pvp_a_a:37:37:-23|t|cff0101DFAlliance Cities|r", 0,
		{"|TInterface\\icons\\achievement_zone_elwynnforest:37:37:-23|t|cff0101DFStormwind|r", 0, -8905, 560, 94, 0.62},
		{"|TInterface\\icons\\achievement_zone_dunmorogh:37:37:-23|t|cff0101DFIronforge|r", 0, -4795, -1117, 499, 0},
		{"|TInterface\\icons\\achievement_zone_ashenvale_01:37:37:-23|t|cff0101DFDarnassus|r", 1, 9952, 2280.5, 1342, 1.6},
		{"|TInterface\\icons\\achievement_zone_zangarmarsh:37:37:-23|t|cff0101DFThe Exodar|r", 530, -3965.7, -11653.6, -138.844, 0},
		{"|TInterface\\icons\\achievement_reputation_wyrmresttemple:37:37:-23|t|cff642EFEShattrath|r", 530, -1838.16, 5301.79, -12.428, 0},
		{"|TInterface\\icons\\achievement_reputation_kirintor:37:37:-23|t|cff642EFEDalaran|r", 571, 5804.15, 624.771, 647.767, 0},
	},
	[3] = { "|TInterface\\icons\\achievement_bg_winwsg:37:37:-23|t|cffC41F3BPvP Locations|r", 2,
		{"Gurubashi Arena", 0, -13229, 226, 33, 1},
		{"Dire Maul Arena", 1, -3669, 1094, 160, 3},
		{"Nagrand Arena", 530, -1983, 6562, 12, 2},
		{"Blade's Edge Arena", 530, 2910, 5976, 2, 4},
	},
	[4] = {"|TInterface\\icons\\achievement_zone_elwynnforest:37:37:-23|t|cff0101DFAlliance Starter Areas|r", 0,
		{"Northshire Valley", 0, -8921.09, -119.13, 82.2, 6},
		{"Coldridge", 0, -6231.77, 333, 383.17, 0},
		{"Shadowglen", 1, 10322.26, 831.4, 1326.37, 0},
		{"Ammen Vale", 530, -3961.64, -13931.2, 100.615, 0},
	},
	[5] = { "|TInterface\\icons\\achievement_zone_durotar:37:37:-23|t|cff610B0BHorde Starter Areas|r", 1,
		{"Valley of Trials", 1, -618.518, -4251.67, 38.718, 0},
		{"Camp Narache", 1, -2917.58, -257.98, 52.9968, 0},
		{"Death Knell", 0, 1676.71, 1678.31, 121.67, 0},
		{"Sunstrider Isle", 530, 10349.6, -6357.29, 33.4026, 0},
	},
	[6] = {"|TInterface\\icons\\achievement_boss_ragnaros:37:37:-23|t|cff0101DFRaids|r", 2,
		{"Molten Core", 230, 1126.64, -459.94, -102.535, 3.46095},
		{"Onyxia's Lair", 1, -4708.27, -3727.64, 54.5589, 3.72786},
		{"Blackwing Lair", 469, -7664.76, -1100.87,399.679, 0},
		{"Zul'Gurub", 309, -11916.9, -1248.36, 92.5334, 4.72417},
		{"Ahn'Qiraj", 1, -8253.067, 1538.91, -4.797, 3.065894},
		{"Naxx 40", 0, 3082.924316, -3746.725830, 133.52, 0},
		{"Karazhan", 0, -11118.9, -2010.33,47.0819, 0.649895},
		{"Magtheridon's Lair", 530, -312.7, 3087.26, -116.52, 5.19026},
		{"Gruul's Lair", 530, 3530.06, 5104.08, 3.50861, 5.51117},
		{"Zul'Aman", 530, 6851.78, -7972.57, 179.242, 4.64691},
		{"Serpentshrine Caverns", 530, 748.984436, 6870.443359, -68, 6.246},
		{"Tempest Keep", 530, 3088.49, 1381.57, 184.863, 4.61973},
		{"Hyjal Summit", 1, -8177.5, -4183, -168, 1},
		{"Black Temple", 530, -3649.92, 317.469, 35.2827, 2.94285},
		{"Sunwell Plateau", 530, 12574.1, -6774.81, 15.0904, 3.13788},
		{"Naxx Wotlk", 571, 3670.268066, -1263.276367, 243.52, 4.61},
		{"Obsidian Sanctum", 571, 3457.11, 262.394, -113.819, 3.28258},
		{"Eye of Eternity", 571, 3859.44, 6989.85, 152.041, 5.79635},
		{"Vault of Archavon", 571, 5453.72, 2840.79, 421.28, 0},
		{"Ulduar", 571, 9251.101562, -1112.424072, 1216.115479, 6.26},
		{"Trial of the Crusader", 571, 8515.68, 716.982, 558.248, 1.57315},
		{"Icecrown Citadel", 571, 5873.82, 2110.98, 636.011, 3.5523},
		{"Ruby Sanctum", 571, 3600.5, 197.34, -113.76, 5.29905},
	},
	[7] = { "|TInterface\\icons\\inv_misc_head_human_01:37:37:-23|t|cffFFFFFFMorphs|r", 2,
	{"Demorph", 0},
    {"Sally", 2043},
    {"New Thrall", 4527},
    {"Old Thrall", 27656},
    {"Cairne", 4307},
    {"Velen", 17822},
    {"Sylvanas", 28213},
    {"Vol'jin", 10357},
    {"Anduin", 11655},
    {"Magni", 3597},
    {"Tyrande", 7274},
    {"Jaina", 2970},
    {"Varian", 28127},
    {"Bolvar", 5566},
    {"Old Tirion", 9477},
    {"New Tirion", 31011},
    {"Vereesa", 28222},
    {"Rhonin", 16024},
    {"Putress", 27611},
    {"Alexstrasza", 28227},
    {"Chromie", 24877},
    {"Arthas", 24949},
    {"Lich King", 22234},
    {"Saurfang", 14732},
    {"Onyxia", 8570},
    {"Nefarian", 9472},
    {"Dark Ranger", 30073},
    {"Millhouse", 19942},
},
}

local function OnGossipHello(event, player, item)
    -- Show main menu
    for i, v in ipairs(T) do
        if (v[2] == 2 or v[2] == player:GetTeam()) then
            player:GossipMenuAddItem(0, v[1], i, 0)
        end
    end
    player:GossipSendMenu(1, item)
end	

local function OnGossipSelect(event, player, item, sender, intid, code)
    if (sender == 0) then
        -- return to main menu
        OnGossipHello(event, player, item)
        return
    end

    if intid == 0 then
        -- Show teleport menu
        for i, v in ipairs(T[sender]) do
            if (i > 2) then
                player:GossipMenuAddItem(0, v[1], sender, i)
            end
        end
        player:GossipMenuAddItem(0, "Back", 0, 0)
        player:GossipSendMenu(1, item)
        return
    elseif sender == 7 then
    -- Morph the player
    local morphName, morphID = table.unpack(T[sender][intid])
    if morphID == 0 then
        -- Demorph
        player:SetDisplayId(player:GetNativeDisplayId())
    else
        -- Morph
        player:SetDisplayId(morphID)
        player:CastSpell(player, 51908, true) -- Cast the morph spell
    end
    player:GossipComplete()
    return
    else
        -- teleport
        local name, map, x, y, z, o = table.unpack(T[sender][intid])
        player:Teleport(map, x, y, z, o)
    end
    
    player:GossipComplete()
end


RegisterItemGossipEvent(ItemEntry, 1, OnGossipHello)
RegisterItemGossipEvent(ItemEntry, 2, OnGossipSelect)
