-- Will be used to dump iteminfo for Rolls,
-- to check if we could need that item

-- v change that lmao
abotItemName = "Butcher's Slicer";

abotItemInfoResult='noItem';
abName,abLink,abRarity,abLevel,abMinLevel,abType,abSubType,abStackCount,abEquipLoc,abIcon,abSellPrice=GetItemInfo(abotItemName);

abotItemInfoResult=
'{'..
    '"id": "0",'..
    '"count": "1",'..
    '"quality": "'..tostring(abRarity or 0)..'",'..
    '"curDurability": "0",'..
    '"maxDurability": "0",'..
    '"cooldownStart": "0",'..
    '"cooldownEnd": "0",'..
    '"name": "'..tostring(abName or 0)..'",'..
    '"link": "'..tostring(abLink or 0)..'",'..
    '"level": "'..tostring(abLevel or 0)..'",'..
    '"minLevel": "'..tostring(abMinLevel or 0)..'",'..
    '"type": "'..tostring(abType or 0)..'",'..
    '"subtype": "'..tostring(abSubType or 0)..'",'..
    '"maxStack": "'..tostring(abStackCount or 0)..'",'..
    '"equiplocation": "'..tostring(abEquipLoc or 0)..'",'..
    '"sellprice": "'..tostring(abSellPrice or 0)..'"'..
'}';

abotItemName="Forest Leather Gloves";
abotItemInfoResult='noItem';
abName,abLink,abRarity,abLevel,abMinLevel,abType,abSubType,abStackCount,abEquipLoc,abIcon,abSellPrice=GetItemInfo(abotItemName);
print(abLink);
abotItemInfoResult='{'..'"id": "0",'..'"count": "1",'..'"quality": "'..tostring(abRarity or 0)..'",'..'"curDurability": "0",'..'"maxDurability": "0",'..'"cooldownStart": "0",'..'"cooldownEnd": "0",'..'"name": "'..tostring(abName or 0)..'",'..'"link": "'..tostring(abLink or 0)..'",'..'"level": "'..tostring(abLevel or 0)..'",'..'"minLevel": "'..tostring(abMinLevel or 0)..'",'..'"type": "'..tostring(abType or 0)..'",'..'"subtype": "'..tostring(abSubType or 0)..'",'..'"maxStack": "'..tostring(abStackCount or 0)..'",'..'"equiplocation": "'..tostring(abEquipLoc or 0)..'",'..'"sellprice": "'..tostring(abSellPrice or 0)..'"'..'}';