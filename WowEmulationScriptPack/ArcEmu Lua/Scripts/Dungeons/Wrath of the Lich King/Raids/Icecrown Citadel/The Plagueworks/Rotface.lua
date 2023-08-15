--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.0  ////
--//////////////////////////////////

local rotface = 36627
local SmallOoze = 43301
local BigOoze = 36899
local OozeFlood = 37006

function Rotface_OnCombat(punit, event)
  rotface = punit
   rotface:SendChatMessage(14, 0, "WEEEEEEE!")
    rotface:RegisterEvent("rotface_OozeFlood", 20000, 1)
	rotface:RegisterEvent("rotface_OozeFlood_InPairs", 22000, 1)
	rotface:RegisterEvent("rotface_SlimeSpray", 11000, 0)
	rotface:RegisterEvent("rotface_MutatedInfection", 35000, 0) 
end

-- Ooze Flood Start --

   -- First wave of flood --

function rotface_OozeFlood(punit, event)
  rotface:SpawnCreature(37006, 4427.700689, 3174.871826, 360.385315, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood_Two", 20000, 1)
end

function rotface_OozeFlood_InPairs(punit, event)
  rotface:SpawnCreature(37006, 4409.125000, 3155.542725, 360.385315, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood_InPairs_Two", 22000, 1)
end

   -- Secund wave of flood --

function rotface_OozeFlood_Two(punit, event)
  rotface:SpawnCreature(37006, 4406.874512, 3118.262207, 360.385742, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood_Tree", 20000, 1)
end

function rotface_OozeFlood_InPairs_Two(punit, event)
  rotface:SpawnCreature(37006, 4428.574707, 3101.385742, 360.385742, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood_InPairs_Tree", 22000, 1)
end

   -- Trede wave of flood --

function rotface_OozeFlood_Tree(punit, event)
  rotface:SpawnCreature(37006, 4461.988770, 3101.588867, 360.385590, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood_For", 20000, 1)
end

function rotface_OozeFlood_InPairs_Tree(punit, event)
  rotface:SpawnCreature(37006, 4481.371094, 3119.097412, 360.385590, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood_InPairs_For", 22000, 1)
end

   -- Last wave of flood --

function rotface_OozeFlood_For(punit, event)
  rotface:SpawnCreature(37006, 4482.102051, 3153.623779, 360.385590, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood", 20000, 1)
end

function rotface_OozeFlood_InPairs_For(punit, event)
  rotface:SpawnCreature(37006, 4463.563965, 3173.374268, 360.385590, 0, 14, 25000)
  rotface:RegisterEvent("rotface_OozeFlood_InPairs", 22000, 1)
end

-- Ooze Flood Ends --

function rotface_SlimeSpray(punit, event)
 rotface:SendChatMessage(14, 0, "Icky sticky.")
  local target = rotface:GetRandomPlayer(0)
   rotface:FullCastSpell(69508)
   rotface:AddAura(69507, 1000)
end

function rotface_MutatedInfection(punit, event)
  local targetz = rotface:GetRandomPlayer(0)
   rotface:CastSpellOnTarget(69674, targetz)
    rotface:RegisterEvent("Small_Ooze_Spawn", 12000, 1)
end

function Small_Ooze_Spawn(punit, event)
  local targetz = rotface:GetRandomPlayer(0)
   local x = targetz:GetX()
   local y = targetz:GetY()
   local z = targetz:GetZ()
   local o = targetz:GetO()
  rotface:SpawnCreature(SmallOoze, x, y, z, o, 14, 360000)
end

-- Small Ooze --

function SmallOoze_OnCombat(punit, event)
   smallooze = punit
    smallooze:Unroot()
     smallooze:CastSpell(69750)
	 smallooze:AddAura(69751, 0)
      smallooze:RegisterEvent("smallooze_StickyOoze", 10000, 0)
	  smallooze:RegisterEvent("smallooze_BigOoze_SpawnCheck", 1000, 0)
end

function smallooze_BigOoze_SpawnCheck(punit, event)
   local target = smallooze:GetClosestFriend()
     if smallooze:GetDistanceYards(target) < 10 then 
	  local x = smallooze:GetX()
	  local z = smallooze:GetY()
	  local z = smallooze:GetZ()
	  local o = smallooze:GetO()
	smallooze:SpawnCreature(36899, x, y, z, o, 14, 360000)
  end
end

function smallooze_StickyOoze(punit, event)
    local player = smallooze:GetRandomPlayer(0)
   smallooze:CastSpellAoF(player:GetX(), player:GetY(), player:GetZ(), 69776)
    player:AddAura(69778, 1000)
end

-- Big Ooze --

function BigOoze_OnCombat(punit, event)
   bigooze = punit
    bigooze:CastSpell(69760)
	bigooze:AddAura(69761, 0)
     bigooze:RegisterEvent("BigOoze_StickyOoze", 10000, 0)
	 bigooze:RegisterEvent("BigOoze_Aura_Check", 1000, 0)
	 bigooze:RegisterEvent("BigOoze_UnstableOozeExplosion", 1000, 0)
end

function BigOoze_StickyOoze(punit, event)
    local player = bigooze:GetRandomPlayer(0)
   bigooze:CastSpellAoF(player:GetX(), player:GetY(), player:GetZ(), 69776)
    player:AddAura(69778, 1000)
end

function BigOoze_Aura_Check(punit, event)
   local target = bigooze:GetInRangeFriends()
    if target:GetDistanceYards(bigooze) < 10 then 
	 bigooze:AddAura(69558, 0)
  end
end

function BigOoze_UnstableOozeExplosion(punit, event)
  if bigooze:HasAura(69558) == 5 then
      local targets = GetThreeRandomEnemies(pUnit)
        if(targets) then
           for k,v in ipairs(targets) do
             pUnit:CastSpellOnTarget(69839, v)
            end
        end
	end
end

function OozeFlood_OnSpawn(punit, event)
   oozeflod = punit
    oozeflod:Root()
    oozeflod:SetModel(11686)
    oozeflod:SetScale(5)
    oozeflod:RegisterEvent("oozeflod_Cast", 1000, 1)
	oozeflod:RegisterEvent("oozeflod_Aura_Check", 500, 0)
end

function oozeflod_Cast(punit, event)
    local x = oozeflod:GetX()
	local y = oozeflod:GetY()
	local z = oozeflod:GetZ()
   oozeflod:CastSpellAoF(x, y, z, 69776)
end

function oozeflod_Aura_Check(punit, event)
   local target = oozeflod:GetClosestEnemy()
    if oozeflod:GetDistanceYards(target) < 20 then 
	 oozeflod:CastSpellOnTarget(69789, target)
   end
end

function Rotface_OnLeaveCombat(punit, event)
   punit:RemoveEvents()
end

function Rotface_OnKillPlayer(punit, event)
	 punit:SendChatMessage(14, 0, "Daddy make toys out of you!")
end

function Rotface_OnDead(punit, event)
   punit:RemoveEvents()
end

function SmallOoze_OnDeath(punit, event)
    punit:Despawn(1, 0)
end

RegisterUnitEvent(rotface, 1, "Rotface_OnCombat")
RegisterUnitEvent(rotface, 2, "Rotface_OnLeaveCombat")
RegisterUnitEvent(rotface, 3, "Rotface_OnKillPlayer")
RegisterUnitEvent(rotface, 4, "Rotface_OnDead")
RegisterUnitEvent(SmallOoze, 1, "SmallOoze_OnCombat")
RegisterUnitEvent(SmallOoze, 4, "SmallOoze_OnDeath")
RegisterUnitEvent(BigOoze, 1, "BigOoze_OnCombat")
RegisterUnitEvent(OozeFlood, 18, "OozeFlood_OnSpawn")