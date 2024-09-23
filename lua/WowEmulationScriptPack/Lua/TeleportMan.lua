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
]==]
print(">>  Teleport Man")
local UnitEntry = 70001

local T = {
	[1] = { "部落主城", 1,
		{"奥格瑞玛", 1, 1503, -4415.5, 22, 0},
		{"幽暗城", 0, 1831, 238.5, 61.6, 0},
		{"雷霆崖", 1, -1278, 122, 132, 0},
	},
	[2] = { "联盟主城", 0,
		{"暴风城", 0, -8905, 560, 94, 0.62},
		{"铁炉堡", 0, -4795, -1117, 499, 0},
		{"达纳苏斯", 1, 9952, 2280.5, 1342, 1.6},
	},

	[3] = { "竞技场", 2,
		{"古拉巴什竞技场", 0, -13229, 226, 33, 1},
		-- {"厄运之槌竞技场", 1, -3669, 1094, 160, 3},
	},
}

-- CODE STUFFS! DO NOT EDIT BELOW
-- UNLESS YOU KNOW WHAT YOU'RE DOING!

local function OnGossipHello(event, player, unit)
	
    -- Show main menu
    for i, v in ipairs(T) do
        if (v[2] == 2 or v[2] == player:GetTeam()) then
            player:GossipMenuAddItem(0, v[1], i, 0)
        end
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