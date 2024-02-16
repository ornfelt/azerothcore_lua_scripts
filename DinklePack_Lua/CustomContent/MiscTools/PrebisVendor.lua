local GearDistributor = {}

GearDistributor.NPC_ID = 90006

-- Prebis raiding gear for each class and specialization
GearDistributor.classGear = {
 [1] = {name = "Mage",
        ["DPS"] = {22267, 22403, 23264, 20697, 14152, 19597, 22870, 11662, 19683, 19684, 22339, 22433, 12930, 22268, 20069, 13938},
    },
    [2] = {name = "Warlock",
        ["DPS"] = {22267, 22403, 18681, 18350, 14153, 19597, 18407, 11662, 13170, 18735, 22339, 22433, 12930, 13968, 18534, 13396},
    },
    [3] = {name = "Rogue",
        ["DPS"] = {22005, 15411, 22008, 13340, 22009, 22004, 15063, 15062, 22003, 18500, 19325, 11815, 13965, 12940, 12939, 18323},
    },
    [4] = {name = "Hunter",
        ["DPS"] = {18421, 15411, 12927, 13340, 11726, 18375, 15063, 18393, 15062, 13967, 18500, 18500, 18473, 13965, 18520, 18738},
    },
    [5] = {name = "Warrior",
        ["DPS"] = {12640, 15411, 20212, 21187, 11726, 19578, 14551, 13959, 22385, 12555, 19325, 21182, 21180, 11815, 11684, 12590, 19107},
        ["Tank"] = {12640, 19491, 16733, 21187, 11726, 19578, 14551, 22385, 14549, 19325, 21182, 21180, 18537, 18348, 19321, 12651},
    },
    [6] = {name = "Druid",
        ["Balance"] = {10041, 12103, 18681, 11623, 18385, 13253, 11662, 13170, 11822, 13001, 13001, 13968, 12930, 18534, 23197},
        ["Feral"] = {8345, 19491, 12927, 14637, 10710, 15063, 13252, 15062, 12553, 18500, 18500, 13965, 11815, 13167, 22397},
        ["Restoration"] = {13102, 18723, 15061, 18510, 13346, 18525, 12554, 14553, 18386, 13954, 22334, 13178, 18470, 18371, 22406, 22398},
    },
    [7] = {name = "Priest",
        ["Healing"] = {13102, 18723, 18510, 14154, 19597, 12554, 18327, 18386, 22247, 16058, 22334, 11923, 19312, 13938},
        ["DPS"] = {22267, 22403, 18681, 11623, 14136, 19597, 18407, 11662, 13170, 18735, 22339, 13001, 12930, 18371, 22335, 13396},
    },
   [8] = {name = "Paladin",
        ["Holy"] = {13102, 18723, 18510, 13346, 13969, 18527, 14553, 18386, 13954, 16058, 22334, 11819, 12930, 11923, 19312, 23201},
        ["Protection"] = {12952, 13091, 14552, 18495, 18503, 18754, 13072, 14620, 14623, 14621, 11669, 2246, 17774, 11810, 868, 12602, 22401},
        ["Retribution"] = {12640, 15411, 12927, 13340, 11726, 19578, 13957, 13959, 22753, 14616, 19325, 13098, 11815, 13965, 19323, 23203},
    },
[9] = {name = "Shaman",
    ["Elemental"] = {22267, 19426, 18681, 20697, 19682, 21186, 13253, 18676, 19683, 19684, 22339, 21190, 12930, 18471, 20069, 23199},
    ["Enhancement"] = {13359, 19491, 12927, 20691, 11726, 19584, 19157, 13252, 22673, 14616, 19325, 21182, 21180, 11815, 11684, 12590, 22395},
    ["Restoration"] = {18490, 20685, 22234, 18510, 13346, 13969, 18527, 19162, 18386, 22247, 22681, 16058, 12930, 18371, 20214, 172133, 23200},
},
}



function GearDistributor.onGossipSelect(event, player, creature, sender, intid, code, menu_id)
    if (intid >= 1 and intid <= 9) then
        local class = GearDistributor.classGear[intid]
        local roles = {}
        for k, v in pairs(class) do
            if k ~= "name" then
                table.insert(roles, k)
            end
        end

        player:GossipMenuAddItem(0, "Select Role", 0, 10, false, "", 0)
        for k, role in pairs(roles) do
            player:GossipMenuAddItem(0, role, 0, intid * 100 + k, false, "", 0)
        end
        player:GossipSendMenu(1, creature)
    elseif (intid >= 10 and intid <= 999) then
        local classIndex = math.floor(intid / 100)
        local roleIndex = intid % 100

        local class = GearDistributor.classGear[classIndex]
        local roles = {}
        for k, v in pairs(class) do
            if k ~= "name" then
                table.insert(roles, k)
            end
        end
        local gear = class[roles[roleIndex]]

        for _, item in pairs(gear) do
            player:AddItem(item, 1)
        end

        player:GossipComplete()
    end
end

function GearDistributor.onGossipHello(event, player, creature)
    player:GossipClearMenu()

    local jokes = {
        "What do you get when you cross a Draenei and a Gnome? A tall tale!",
        "Why did the Draenei open a bakery? Because he kneaded more dough!",
        "What do you call a Draenei with no legs? Grounded.",
        "What do you call a Draenei who loves to dance? A 'hoof-er'!",
        "How do Draenei stay fit? They do plenty of Exodar-cise!",
        "Why don't draenei ever get lost? They have a built-in GPS: the Light!",
        "Why did the draenei shaman join a band? To play the elekk-tric guitar!"
    }

    local jokeIndex = math.random(1, #jokes)
    creature:SendUnitSay(jokes[jokeIndex], 0)

    for i = 1, 9 do
        local class = GearDistributor.classGear[i]
        player:GossipMenuAddItem(0, class.name, 0, i, false, "", 0)
    end

    player:GossipSendMenu(1, creature)
end

RegisterCreatureGossipEvent(GearDistributor.NPC_ID, 1, GearDistributor.onGossipHello)
RegisterCreatureGossipEvent(GearDistributor.NPC_ID, 2, GearDistributor.onGossipSelect)