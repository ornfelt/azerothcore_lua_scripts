local StartNPC = {
    entries = {210000, 210001}, -- Creature entry ID's
    sets = {
        [1] = {14156, 14156, 14156, 14156, 21994, 21995, 21996, 21997, 21998, 21999, 22000, 22001}, -- Warrior
        [2] = {14156, 14156, 14156, 14156, 22086, 22087, 22088, 22089, 22090, 22091, 22092, 22093}, -- Paladin
        [3] = {14156, 14156, 14156, 14156, 22010, 22011, 22013, 22015, 22016, 22017, 22060, 22061}, -- Hunter
        [4] = {14156, 14156, 14156, 14156, 22002, 22003, 22004, 22005, 22006, 22007, 22008, 22009}, -- Rogue
        [5] = {14156, 14156, 14156, 14156, 22078, 22079, 22080, 22081, 22082, 22083, 22084, 22085}, -- Priest
        [6] = {43345, 50316, 50317, 51809, 41600, 38082, 34845, 40554, 40557, 40556, 40552, 40550}, -- Death Knight
        [7] = {14156, 14156, 14156, 14156, 22095, 22096, 22097, 22098, 22099, 22100, 22101, 22102}, -- Shaman
        [8] = {14156, 14156, 14156, 14156, 22062, 22063, 22064, 22065, 22066, 22067, 22068, 22069}, -- Mage
        [9] = {14156, 14156, 14156, 14156, 22070, 22071, 22072, 22073, 22074, 22075, 22076, 22077}, -- Warlock
        [11] = {14156, 14156, 14156, 14156, 22106, 22107, 22108, 22109, 22110, 22111, 22112, 22113} -- Druid
    }
}

function StartNPC.OnGossip(event, player, unit)
    -- Only allow players less than max level to use the gossip menu.
    -- This prevents people from using the NPC more than once
    if(player:GetLevel() < 80) then
        player:GossipMenuAddItem(1, "Please level my character", 0, 1)
        player:GossipMenuAddItem(1, "Teleport me to Dalaran", 0, 2)
        player:GossipMenuAddItem(1, "Never mind", 0, 0)
        player:GossipSendMenu(210000, unit)
    end
    if(player:GetLevel() == 80) then
        player:GossipMenuAddItem(1, "Teleport me to Dalaran", 0, 2)
        player:GossipMenuAddItem(1, "Never mind", 0, 0)
        player:GossipSendMenu(210000, unit)
    end
end

function StartNPC.OnSelect(event, player, unit, sender, intid, code, menu_id)
    if(intid == 0) then
        player:GossipComplete()
        end
    if(intid == 1) then
        player:SetLevel(80)
        player:SetCoinage(1000000000)
        player:LearnSpell(34091)
        player:LearnSpell(18248)
        player:LearnSpell(33388)
        player:LearnSpell(54197)
        player:LearnSpell(33391)
        player:LearnSpell(34090)
        player:AddItem(46778)
        player:AddItem(34092)
        for k, v in pairs(StartNPC["sets"][player:GetClass()]) do
            player:AddItem(v)
        end
        player:GossipComplete()
    end

    if(intid == 2) then
        player:Teleport(571,5878.56,666.423,615.294,4)
    end
end

for k, v in pairs(StartNPC["entries"]) do
    RegisterCreatureGossipEvent(v, 1, StartNPC.OnGossip)
    RegisterCreatureGossipEvent(v, 2, StartNPC.OnSelect)
end

