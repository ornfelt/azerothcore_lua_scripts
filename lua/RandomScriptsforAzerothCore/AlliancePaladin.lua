local AlliancePaladin = 400030
local kingsSpell = 25898
local wisdomSpell = 25918
local mightSpell = 25916

local function OnSpawn(event, creature)
creature:CastSpell(creature, kingsSpell, true)
end

local function OnGossipHello(event, player, creature)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\spell_magic_magearmor:50:50:-13:0|tGrant me a Blessing of Kings", 0, 1, false, "", 0)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\spell_holy_sealofwisdom:50:50:-13:0|tGrant me a Blessing of Wisdom", 0, 2, false, "", 0)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\spell_holy_fistofjustice:50:50:-13:0|tGrant me a Blessing of Might", 0, 3, false, "", 0)
player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menuid)
if intid == 1 then
player:CastSpell(player, kingsSpell, true)
elseif intid == 2 then
player:CastSpell(player, wisdomSpell, true)
elseif intid == 3 then
player:CastSpell(player, mightSpell, true)
end
player:GossipComplete()
end

RegisterCreatureEvent(AlliancePaladin, 5, OnSpawn)
RegisterCreatureGossipEvent(AlliancePaladin, 1, OnGossipHello)
RegisterCreatureGossipEvent(AlliancePaladin, 2, OnGossipSelect)