-- Dumps your equipment items

abotEquipmentResult = "["

for a = 0, 23 do
    abId = GetInventoryItemID("player", a)

    if (string.len(tostring(abId or "")) > 0) then
        abotItemLink = GetInventoryItemLink("player", a)
        abCount = GetInventoryItemCount("player", a)
        abCurrentDurability, abMaxDurability = GetInventoryItemDurability(a)
        abCooldownStart, abCooldownEnd = GetInventoryItemCooldown("player", a)
        abName, abLink, abRarity, abLevel, abMinLevel, abType, abSubType, abStackCount, abEquipLoc, abIcon, abSellPrice = GetItemInfo(abotItemLink)

        stats={};
        abStats=GetItemStats(abotItemLink, stats);

        statsResult={};
        for key, value in pairs(stats) do
            table.insert(statsResult, string.format("\"%s\":\"%s\"", key, value))
        end

        abotEquipmentResult = abotEquipmentResult..
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
            '"equiplocation": "'..tostring(a or 0)..'",'..
            '"stats": '.."{" .. table.concat(statsResult, ",").."}"..','..
            '"sellprice": "'..tostring(abSellPrice or 0)..'"'..
        '}';

        if a < 23 then
            abotEquipmentResult = abotEquipmentResult .. ","
        end
    end
end

abotEquipmentResult = abotEquipmentResult .. "]"
