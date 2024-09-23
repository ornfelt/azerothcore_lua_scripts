local Symbiosis = {}

Symbiosis.SPELL_SYMBIOSIS = 100261

-- Define the spell list based on the target's class
Symbiosis.SYMBIOSIS_SPELLS = {
    [1]  = {100262, 2687}, -- Warriors
    [2]  = {31884, 64205}, -- Paladins
    [3]  = {13809, 5384},  -- Hunters
    [4]  = {13750, 13877}, -- Rogues
    [5]  = {10060, 10952}, -- Priests
    [6]  = {49576, 100268}, -- Death Knights 
    [7]  = {100266, 100267}, -- Shamans
    [8]  = {100263, 30482}, -- Mages
    [9]  = {6215, 11678},  -- Warlocks
}

-- Remove all symbiosis spells and auras from the druid
function Symbiosis.RemoveSymbiosisSpells(druid)
    for _, spellIDs in pairs(Symbiosis.SYMBIOSIS_SPELLS) do
        for _, spellID in ipairs(spellIDs) do
            if druid:HasSpell(spellID) then
                druid:RemoveAura(spellID)
                druid:RemoveSpell(spellID)
            end
        end
    end
end

function Symbiosis.OnCastSymbiosis(event, player, spell, skipCheck)
    if spell:GetEntry() ~= Symbiosis.SPELL_SYMBIOSIS then
        return
    end

    local target = player:GetSelection()
    if not target then
        player:SendBroadcastMessage("You must have a target to cast Symbiosis.") -- Send a broadcast message to the player
        spell:Cancel() -- Cancel the spell
        return
    end

    if player:GetGUID() == target:GetGUID() then -- Check if the player targets themselves
        player:SendBroadcastMessage("You cannot cast Symbiosis on yourself.") -- Send a broadcast message to the player
        spell:Cancel() -- Cancel the spell
        return
    end

    local targetClass = target:GetClass()

    -- Check if target class is a Death Knight and adjust the class ID if needed. Doesn't work otherwise for some reason 
    if targetClass == 10 then
        targetClass = 6
    end

    local symbiosisSpells = Symbiosis.SYMBIOSIS_SPELLS[targetClass]

    if symbiosisSpells then
        Symbiosis.RemoveSymbiosisSpells(player)

        if player:HasAura(52005) then
            player:RemoveAura(52005)
            player:SendBroadcastMessage("The benefits of Earthliving Weapon have been removed.")
        end
        if player:HasAura(33757) then
            player:RemoveAura(33757)
            player:SendBroadcastMessage("The benefits of Windfury Weapon have been removed.")
        end

        for _, spellID in ipairs(symbiosisSpells) do
            player:LearnSpell(spellID)
        end
    end
end

RegisterPlayerEvent(5, Symbiosis.OnCastSymbiosis)
