WeaponMasterNamespace = {}

WeaponMasterNamespace.NpcId = 36544 

WeaponMasterNamespace.Weapon_Master = {}

WeaponMasterNamespace.CLASS_WARRIOR = 1
WeaponMasterNamespace.CLASS_PALADIN = 2
WeaponMasterNamespace.CLASS_HUNTER = 3
WeaponMasterNamespace.CLASS_ROGUE = 4
WeaponMasterNamespace.CLASS_PRIEST = 5
WeaponMasterNamespace.CLASS_DEATH_KNIGHT = 6
WeaponMasterNamespace.CLASS_SHAMAN = 7
WeaponMasterNamespace.CLASS_MAGE = 8
WeaponMasterNamespace.CLASS_WARLOCK = 9
WeaponMasterNamespace.CLASS_DRUID = 11

WeaponMasterNamespace.Skills = {
    ["Menu"] = {
        {"Warrior", 1},
        {"Paladin", 2},
        {"Hunter", 3},
        {"Rogue", 4},
        {"Priest", 5},
        {"Shaman", 7},
        {"Mage", 8},
        {"Warlock", 9},
        {"Druid", 11},
        {"Death Knight", 6}
    },
    [WeaponMasterNamespace.CLASS_WARRIOR] = {202,199,197,227,200,201,198,196,266,15590,1180,5011,264},
    [WeaponMasterNamespace.CLASS_PALADIN] = {202, 199,197,200,201,198,196},
    [WeaponMasterNamespace.CLASS_HUNTER] = {202,197,227,200,201,196,266,15590,1180,5011,264},
    [WeaponMasterNamespace.CLASS_ROGUE] = {201,198,196,266,15590,1180,5011,264},
    [WeaponMasterNamespace.CLASS_PRIEST] = {227,198,1180},
    [WeaponMasterNamespace.CLASS_SHAMAN] = {199,197,227,198,196,15590,1180},
    [WeaponMasterNamespace.CLASS_MAGE] = {227,201,1180},
    [WeaponMasterNamespace.CLASS_WARLOCK] = {227,201,1180},
    [WeaponMasterNamespace.CLASS_DRUID] = {199,227,200,198,15590,1180},
    [WeaponMasterNamespace.CLASS_DEATH_KNIGHT] = {202,199,197,200,201,198,196}
}

function WeaponMasterNamespace.Weapon_Master.Hello(event, player, object)
    for _, v in ipairs(WeaponMasterNamespace.Skills["Menu"]) do
        player:GossipMenuAddItem(3, " " .. v[1] .. ".|R", 0, v[2])
    end

    player:GossipSendMenu(1, object)
end

function WeaponMasterNamespace.Weapon_Master.Select(event, player, object, sender, intid, code, menu_id)
    local playerclass = player:GetClass()
    if (intid == playerclass) then
        for k, v in pairs(WeaponMasterNamespace.Skills) do
            if (k == playerclass) then
                for _, v in ipairs(v) do
                    if player:HasSpell(v) == false then
                        player:LearnSpell(v)
                    end

                end
            end
        end
        object:SendChatMessageToPlayer(8, 0, "You have learned all your weapon skills!", player)
        player:GossipComplete()
    else
        object:SendChatMessageToPlayer(8, 0, "Wrong Class " .. player:GetName(), player)

        WeaponMasterNamespace.Weapon_Master.Hello(event, player, object)
    end
end

RegisterCreatureGossipEvent(WeaponMasterNamespace.NpcId, 1, WeaponMasterNamespace.Weapon_Master.Hello)
RegisterCreatureGossipEvent(WeaponMasterNamespace.NpcId, 2, WeaponMasterNamespace.Weapon_Master.Select)
