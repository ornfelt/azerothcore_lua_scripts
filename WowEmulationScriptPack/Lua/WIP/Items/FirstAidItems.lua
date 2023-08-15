-- This script contains information for first aid items that need to be scripted.
-- author: grimreapaa

-- entries for items
ANTISEPTIC_OINTMENT = 1999922
LIGHT_BANDAGE = 1999924
HEAVY_BANDAGE = 1999923

-- spell entries
ANTISEPTIC_OINTMENT_COOLDOWN = 2000083
BATTLE_FATIGUE = 2000003

local function First_Aid_Bandage_Debuff_Apply(eventid, delay, repeats, player)
	player:AddAura(11196, player)
end

local function First_Aid_Bandage_Debuff(event, player, item, target)
	if player:HasAura(11196) == false then
		player:RegisterEvent(First_Aid_Bandage_Debuff_Apply, 8000, 1)
		return true
	end
end

local function First_Aid_Antiseptic_Ointment(event, player, item, target)
	if player:HasAura(ANTISEPTIC_OINTMENT_COOLDOWN) == false then
		target:AddAura(ANTISEPTIC_OINTMENT_COOLDOWN, player)
		target:RemoveAura(BATTLE_FATIGUE)
		player:SendBroadcastMessage("You have removed Battle Fatigue from " ..target:GetName().. ".")
		return true
	else
		player:SendBroadcastMessage("This player has already been medically serviced.")
		return false
	end
end


RegisterItemEvent(LIGHT_BANDAGE, 2, First_Aid_Bandage_Debuff)
RegisterItemEvent(HEAVY_BANDAGE, 2, First_Aid_Bandage_Debuff)
RegisterItemEvent(ANTISEPTIC_OINTMENT, 2, First_Aid_Antiseptic_Ointment)