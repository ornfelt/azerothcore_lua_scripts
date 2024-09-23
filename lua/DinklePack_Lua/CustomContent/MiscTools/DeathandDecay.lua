local DeathKnightDnD = {}

DeathKnightDnD.SPELL_IDS = {49938, 43265, 49937, 49936} -- The spell IDs to watch for
DeathKnightDnD.AURA_ID_TO_CAST = 80019 -- The aura to cast at the DnD location
DeathKnightDnD.REQUIRED_AURA_ID = 80012 -- The required aura for the event to occur

-- Function to check if a table contains a specific value
local function contains(table, val)
   for i=1,#table do
      if table[i] == val then 
         return true
      end
   end
   return false
end

function DeathKnightDnD.OnSpellCast(event, player, spell, skipCheck)
    if player:GetClass() ~= 6 or not player:HasAura(DeathKnightDnD.REQUIRED_AURA_ID) then -- 6 is the class ID for Death Knight
        return
    end

    local spellId = spell:GetEntry()
    if not contains(DeathKnightDnD.SPELL_IDS, spellId) then -- check if the spell is in the SPELL_IDS table
        return
    end

    local spellX, spellY, spellZ = spell:GetTargetDest()

    if spellX == nil or spellY == nil or spellZ == nil then
        return
    end

    -- Cast the required aura at the DnD location
    player:CastSpellAoF(spellX, spellY, spellZ, DeathKnightDnD.AURA_ID_TO_CAST, true)
end

RegisterPlayerEvent(5, DeathKnightDnD.OnSpellCast) 
