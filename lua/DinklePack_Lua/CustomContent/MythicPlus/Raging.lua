--local raging = {}
--local casted = {}

--function raging.OnSpellCast(event, player, spell, skipCheck)
    -- Check if the player has aura 107095
  --  if not player:HasAura(107095) then
   --     return
  --  end

    -- Check if the target's health is less than 30%
  --  local target = player:GetSelection()
   -- if target and target ~= player and target:GetHealthPct() <= 30 and not casted[target:GetGUIDLow()] then
        -- Cast spell 107094 on the target
   --     target:CastSpell(target, 107094)
   --     casted[target:GetGUIDLow()] = true
   -- end
--end

--RegisterPlayerEvent(5, raging.OnSpellCast)
