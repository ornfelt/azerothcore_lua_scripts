local NPC_ID = 35200 -- replace with the NPC's ID
local BLESSING_SPELL_ID = 100003 -- replace with the first spell ID
local SOULSTONE_SPELL_ID = 20707 -- replace with the second spell ID

local function OnGossipHello(event, player, creature)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\Spell_Holy_ReviveChampion:50:50:-43:0|tReceive the King's blessing", 0, 1, false, "", 0)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\inv_misc_orb_04:50:50:-43:0|tReceive a Soulstone", 0, 2, false, "", 0)
player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menuid)
if intid == 1 then
player:CastSpell(player, BLESSING_SPELL_ID, true)
elseif intid == 2 then
player:CastSpell(player, SOULSTONE_SPELL_ID, true)
end
player:GossipComplete()
end

local function YellDialogue(event, creature)
creature:SendUnitYell("Adventurers, do not go unprepared! Come speak with me and I will grant you a blessing!", 0)
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)

-- triggers the yell function on spawn
RegisterCreatureEvent(NPC_ID, 5, function(event, creature) YellDialogue(event, creature) end)

