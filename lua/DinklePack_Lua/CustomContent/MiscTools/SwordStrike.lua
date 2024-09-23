local SinisterStrike = {}

-- Constants for IDs
SinisterStrike.ITEM_ID = 60095
SinisterStrike.SPELL_SINISTER_STRIKE_IDS = {1752, 1757, 1758, 1759, 1760, 8621, 11294, 11294, 26861, 26862, 48637, 48638} -- Replace with actual IDs
SinisterStrike.AURA_ID = 920020
SinisterStrike.STACK_LIMIT = 10
SinisterStrike.SPELL_ON_LIMIT = 920021

-- Function to check if a value exists in a table
function SinisterStrike.existsInTable(tbl, val)
    for _, value in pairs(tbl) do
        if value == val then
            return true
        end
    end
    return false
end

function SinisterStrike.OnCast(event, player, spell, skipCheck)
    -- Check if the player has the required item equipped
    local item = player:GetItemByEntry(SinisterStrike.ITEM_ID)
    if item and item:IsEquipped() and SinisterStrike.existsInTable(SinisterStrike.SPELL_SINISTER_STRIKE_IDS, spell:GetEntry()) then
        -- Random 50% chance
        if math.random(1, 2) == 1 then
            -- Add the aura
            local aura = player:AddAura(SinisterStrike.AURA_ID, player)
            -- Check the aura stack and cast the spell if reached the limit
            if aura and aura:GetStackAmount() >= SinisterStrike.STACK_LIMIT then
                player:CastSpell(player, SinisterStrike.SPELL_ON_LIMIT, true)
                aura:SetStackAmount(0)
            end
        end
    end
end

RegisterPlayerEvent(5, SinisterStrike.OnCast)
