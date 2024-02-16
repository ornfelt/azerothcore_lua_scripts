--local AURA_TO_CHECK = 107099
--local SPELL_TO_CAST = 107100
--local COOLDOWN = 5
--local playerLastCast = {}

--local function OnPlayerCastSpell(event, player, spell, skipCheck)
   -- if player:HasAura(AURA_TO_CHECK) then
      --  local playerGuid = player:GetGUIDLow()
      --  local currentTime = GetGameTime()

 
    --    local spellEntryId = spell:GetEntry()

 
     --   if spellEntryId ~= 107 and spellEntryId ~= 81 and spellEntryId ~= 3127 and spellEntryId ~= 3124 then
         --   if not playerLastCast[playerGuid] or (currentTime - playerLastCast[playerGuid]) >= COOLDOWN then
           --     local target = spell:GetTarget()
--
           --     if target and not target:IsPlayer() then
          --          player:CastSpell(player, SPELL_TO_CAST, true)
          --          playerLastCast[playerGuid] = currentTime
         --       end
        --    end
       -- end
   -- end
--end

--RegisterPlayerEvent(5, OnPlayerCastSpell)
