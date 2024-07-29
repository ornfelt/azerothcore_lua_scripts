-- will dump all your inventory items

abotInventoryResult = "["

for a = 0, 4 do
    containerSlots = GetContainerNumSlots(a)

    for b = 1, containerSlots do
        abId = GetContainerItemID(a, b)

        if (string.len(tostring(abId or "")) > 0) then
            abItemLink = GetContainerItemLink(a, b)
            abCurrentDurability, abMaxDurability = GetContainerItemDurability(a, b)
            abCooldownStart, abCooldownEnd = GetContainerItemCooldown(a, b)
            abIcon, abItemCount, abLocked, abQuality, abReadable, abLootable, abItemLink, isFiltered = GetContainerItemInfo(a, b)
            abName, abLink, abRarity, abLevel, abMinLevel, abType, abSubType, abStackCount, abEquipLoc, abIcon, abSellPrice = GetItemInfo(abItemLink)

            stats={};
            abStats=GetItemStats(abotItemLink, stats);
    
            statsResult={};
            for key, value in pairs(stats) do
                table.insert(statsResult, string.format("\"%s\":\"%s\"", key, value))
            end

            abotInventoryResult = abotInventoryResult..
                "{"..
                    '"id": "'..tostring(abId or 0)..'",'..
                    '"count": "'..tostring(abItemCount or 0)..'",'..
                    '"quality": "'..tostring(abQuality or 0)..'",'..
                    '"curDurability": "'..tostring(abCurrentDurability or 0)..'",'..
                    '"maxDurability": "'..tostring(abMaxDurability or 0)..'",'..
                    '"cooldownStart": "'..tostring(abCooldownStart or 0)..'",'..
                    '"cooldownEnd": "'..tostring(abCooldownEnd or 0)..'",'..
                    '"name": "'..tostring(abName or 0)..'",'..
                    '"lootable": "'..tostring(abLootable or 0)..'",'..
                    '"readable": "'..tostring(abReadable or 0)..'",'..
                    '"link": "'..tostring(abItemLink or 0)..'",'..
                    '"level": "'..tostring(abLevel or 0)..'",'..
                    '"minLevel": "'..tostring(abMinLevel or 0)..'",'..
                    '"type": "'..tostring(abType or 0)..'",'..
                    '"subtype": "'..tostring(abSubType or 0)..'",'..
                    '"maxStack": "'..tostring(abStackCount or 0)..'",'..
                    '"equiplocation": "'..tostring(abEquipLoc or 0)..'",'..
                    '"sellprice": "'..tostring(abSellPrice or 0)..'",'..
                    '"stats": '.."{" .. table.concat(statsResult, ",").."}"..','..
                    '"bagid": "'..tostring(a or 0)..'",'..
                    '"bagslot": "'..tostring(b or 0)..'"'
                .."}"

            if b < containerSlots then
                abotInventoryResult = abotInventoryResult .. ","
            end
        end
    end
end

abotInventoryResult = abotInventoryResult .. "]"
