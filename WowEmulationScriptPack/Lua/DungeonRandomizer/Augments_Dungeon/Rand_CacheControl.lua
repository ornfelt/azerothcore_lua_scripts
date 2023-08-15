playerToSpellEffectCacheRandDung = {}

function addSpellConnection(player,spellID,ProcChance,effectID,name,description,icon,Misc1,Misc2,Misc3,Misc4,Misc5,Misc6,Misc7,Misc8,Misc9,Misc10)
    if(playerToSpellEffectCacheRandDung[player:GetGUIDLow()] == nil) then
        playerToSpellEffectCacheRandDung[player:GetGUIDLow()] = {}
    end
    local count = 0
    for i,v in pairs(playerToSpellEffectCacheRandDung[player:GetGUIDLow()]) do
        count = count + 1
    end
    if(count < 5) then
        player:SendBroadcastMessage(description)
        playerToSpellEffectCacheRandDung[player:GetGUIDLow()][spellID] = {player:GetGUIDLow(),spellID,ProcChance,effectID,name,description,icon,Misc1,Misc2,Misc3,Misc4,Misc5,Misc6,Misc7,Misc8,Misc9,Misc10}
    else
        player:SendBroadcastMessage("You've reached too many augments! Pick another option.")
		givePlayerDungeonpopup(player)
    end
end

function removeSpellConnectionRandDung(player,spellID)
	playerToSpellEffectCacheRandDung[player:GetGUIDLow()][spellID] = nil
end

function removeAllSpellConnectionRandDung(player)
	playerToSpellEffectCacheRandDung[player:GetGUIDLow()] = nil
end