-- Will dump the item stats to a json

-- v change that lmao
abotItemSlot=1;
abotItemLink=GetInventoryItemLink('player',abotItemSlot);
-- or
abotItemLink="item:41002";

abotItemStatsResult='';
stats={};
abStats=GetItemStats(abotItemLink,stats);

abotItemStatsResult=
'{'..
    '"stamina": "'..tostring(stats["ITEM_MOD_STAMINA_SHORT"] or 0)..'",'..
    '"agility": "'..tostring(stats["ITEM_MOD_AGILITY_SHORT"] or 0)..'",'..
    '"strenght": "'..tostring(stats["ITEM_MOD_STRENGHT_SHORT"] or 0)..'",'..
    '"intellect": "'..tostring(stats["ITEM_MOD_INTELLECT_SHORT"]or 0)..'",'..
    '"spirit": "'..tostring(stats["ITEM_MOD_SPIRIT_SHORT"] or 0)..'",'..
    '"attackpower": "'..tostring(stats["ITEM_MOD_ATTACK_POWER_SHORT"] or 0)..'",'..
    '"spellpower": "'..tostring(stats["ITEM_MOD_SPELL_POWER_SHORT"] or 0)..'",'..
    '"mana": "'..tostring(stats["ITEM_MOD_MANA_SHORT"] or 0)..'"'..
'}';