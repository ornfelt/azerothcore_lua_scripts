-- enchantments.lua
local EnchantmentModule = {}

-- Default enchant string with 36 zeros
local DEFAULT_ENCHANT_STRING = "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"

local function GetSelectedProperty(properties)
    -- First attempt to get a property based on chance
    for _, property in ipairs(properties) do
        if math.random(0, 100) <= property.chance then
            return property
        end
    end
    
    -- If no property was selected by chance, use the first one
    if #properties > 0 then
        return properties[1]
    end
    
    return nil
end

local function GetRandomSuffix(item)
    local suffixOptions = {}
    
    -- Determine suffix options based on item type
    if item.InventoryType == 23 or item.InventoryType == 20 
    or (item.class == 2 and (item.subclass == 10 or item.subclass == 19))
    or (item.class == 4 and item.subclass == 1) then
        suffixOptions = {36, 37, 38, 39, 9, 15, 19, 26, 81, 84, 85, 31, 32, 33, 34, 35}
    elseif (item.class == 4 and item.subclass == 2) 
    or (item.class == 2 and (item.subclass == 2 or item.subclass == 3 or item.subclass == 6 or
        item.subclass == 13 or item.subclass == 15 or item.subclass == 16 or 
        item.subclass == 17 or item.subclass == 18)) then
        suffixOptions = {56, 63, 68, 69, 71, 74, 84, 89, 91, 31, 32, 33, 34, 35}
    elseif (item.class == 4 and item.subclass == 3) then
        suffixOptions = {91, 89, 86, 71, 69, 63, 67, 50, 31, 32, 33, 34, 35}
    elseif item.class == 2 or (item.class == 4 and (item.subclass == 4 or item.subclass == 6)) then
        suffixOptions = {92, 89, 86, 84, 68, 71, 72, 66, 62, 63, 43, 41, 31, 32, 33, 34, 35}
    else
        return math.random(49, 75)
    end
    
    return suffixOptions[math.random(1, #suffixOptions)]
end

function EnchantmentModule.ApplyRandomEnchantments(item, config)
    local randomStats = 0
    local enchantString = DEFAULT_ENCHANT_STRING
    
    -- Use config values or globals as fallback
    local applyRandomProperties = config and config.ApplyRandomProperties or ApplyRandomProperties
    local debugMode = config and config.AHBotItemDebug or AHBotItemDebug
    local itemRandomProperty = config and config.ItemRandomProperty or ItemRandomProperty
    local itemRandomProperties = config and config.ItemRandomProperties or ItemRandomProperties
    local itemRandomSuffix = config and config.ItemRandomSuffix or ItemRandomSuffix
    
    if not applyRandomProperties then
        return randomStats, enchantString
    end
    
    if item.RandomProperty > 0 then 
        randomStats = item.RandomProperty
    elseif item.RandomSuffix > 0 then 
        randomStats = (item.RandomSuffix) * -1
    else 
        return randomStats, enchantString
    end
    
    if randomStats > 0 then -- Handle random properties
        local properties = itemRandomProperty[randomStats]
        if properties then
            local selectedProperty = GetSelectedProperty(properties)
            if selectedProperty then
                local e1, e2, e3 = table.unpack(itemRandomProperties[selectedProperty.ench])
                enchantString = "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 "..e1.." 0 0 "..e2.." 0 0 "..e3.." 0 0 0 0 0 0 0 0 "
                randomStats = selectedProperty.ench
                if debugMode then 
                    print("[Eluna AH Bot Item Debug]: Item "..item.entry.." - Enchants for "..selectedProperty.ench..": "..e1..", "..e2..", "..e3) 
                end
            end
        end
    elseif randomStats < 0 then -- Handle random suffixes
        local selectedSuffix = GetRandomSuffix(item)
        local e1, e2, e3, e4, e5 = table.unpack(itemRandomSuffix[selectedSuffix].Enchantment)
        enchantString = "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 "..e1.." 0 0 "..e2.." 0 0 "..e3.." 0 0 "..e4.." 0 0 "..e5.." 0 0 "
        randomStats = selectedSuffix * -1
        if debugMode then 
            print("[Eluna AH Bot Item Debug]: Item "..item.entry.." - Enchants found for "..selectedSuffix..": "..e1..", "..e2..", "..e3..", "..e4..", "..e5) 
        end
    end
    
    return randomStats, enchantString
end

return EnchantmentModule