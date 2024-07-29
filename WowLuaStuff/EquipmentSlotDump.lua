-- Dumps the selected itemslots iteminfo,
-- will be used for Equipment

-- v change that lmao
abotItemSlot=1;

abotItemInfoResult='noItem';

abId=GetInventoryItemID('player',abotItemSlot);
abCount=GetInventoryItemCount('player',abotItemSlot);
abCurrentDurability,abMaxDurability=GetInventoryItemDurability(abotItemSlot);
abCooldownStart,abCooldownEnd=GetInventoryItemCooldown('player',abotItemSlot);
abName,abLink,abRarity,abLevel,abMinLevel,abType,abSubType,abStackCount,abEquipLoc,abIcon,abSellPrice=GetItemInfo(GetInventoryItemLink('player',abotItemSlot));

abotItemInfoResult=
'{'..
    '"id": "'..tostring(abId or 0)..'",'..
    '"count": "'..tostring(abCount or 0)..'",'..
    '"quality": "'..tostring(abRarity or 0)..'",'..
    '"curDurability": "'..tostring(abCurrentDurability or 0)..'",'..
    '"maxDurability": "'..tostring(abMaxDurability or 0)..'",'..
    '"cooldownStart": "'..tostring(abCooldownStart or 0)..'",'..
    '"cooldownEnd": '..tostring(abCooldownEnd or 0)..','..
    '"name": "'..tostring(abName or 0)..'",'..
    '"link": "'..tostring(abLink or 0)..'",'..
    '"level": "'..tostring(abLevel or 0)..'",'..
    '"minLevel": "'..tostring(abMinLevel or 0)..'",'..
    '"type": "'..tostring(abType or 0)..'",'..
    '"subtype": "'..tostring(abSubType or 0)..'",'..
    '"maxStack": "'..tostring(abStackCount or 0)..'",'..
    '"equiplocation": "'..tostring(abotItemSlot or 0)..'",'..
    '"sellprice": "'..tostring(abSellPrice or 0)..'"'..
'}';