--local function OnKillCreature(event, killer, killed)
  --  if killer:HasAura(107097) then
    --    print("Player has aura 107097")

      --  -- Get the dead creature's position
        --local x, y, z, o = killed:GetLocation()

        -- Spawn creature 401117 at the dead creature's position for 25 seconds
        --local spawnedCreature = killer:SpawnCreature(401117, x, y, z, o, 2, 25000)

        -- Set the spawned creature's faction to the dead creature's faction
        --local killedCreatureFaction = killed:GetFaction()
        --spawnedCreature:SetFaction(killedCreatureFaction)

        -- Set the spawned creature's react state to 0
        --spawnedCreature:SetReactState(0)

        --print("Spawned creature 401117, set its faction, and set react state 0")
    --else
      --  print("Player does not have aura 107097")
    --end
--end

--RegisterPlayerEvent(7, OnKillCreature)
