
 function Sylvannas_OnCombat(pUnit, Event)
 local agrochoice = math.random(1,2)
  local fbtime=math.random(20000,30000)
if agrochoice==1 then
    pUnit:SendChatMessage(14,0,"You shall meet death now!")
 end
if agrochoice==2 then
    pUnit:SendChatMessage(14,0,"The Forsaken shall rule the world")
 end
    pUnit:RegisterEvent("Sylvannas_Shadowbolt", fbtime, 0)
    pUnit:RegisterEvent("Sylvannas_Plague", fbtime, 0)
    pUnit:RegisterEvent("Sylvannas_Spawns", 35654, 6)
    pUnit:RegisterEvent("Sylvannas_Phase2",1000,0)
 end


 function Sylvannas_OnLeaveCombat(pUnit, Event)
    pUnit:RemoveEvents()
 end


 function Sylvannas_OnKilledTarget(pUnit, Event)
    pUnit:SendChatMessage(14,0,"The Forsaken are unbeatable!")	
 end


 function Sylvannas_OnDied(pUnit, Event)
    pUnit:SendChatMessage(14,0,"I might be dead... but The Forsaken will never die!")
    pUnit:RemoveEvents()	
 end


 function Sylvannas_Shadowbolt(pUnit, event)
local fbtime=math.random(15000,45000)
    pUnit:FullCastSpell(28479)
 end


 function Sylvannas_Plague(pUnit, Event)
Choice=math.random(1,2)
 if Choice == 1 then
    pUnit:FullCastSpellOnTarget(55264, pUnit:GetRandomPlayer(0))
 end
 if Choice == 2 then
    pUnit:SendChatMessage(12, 0, "Scream, cowards, SCREAM!")
    pUnit:FullCastSpellOnTarget(55264, pUnit:GetRandomPlayer(0))
 end
end

 function Sylvannas_Spawns(pUnit, Event)
 x = pUnit:GetX();
 y = pUnit:GetY();
 z = pUnit:GetZ();
 o = pUnit:GetO();
    pUnit:SpawnCreature(17902, x+4, y-3, z, o, 20, 20000)
    pUnit:SpawnCreature(17902, x-5, y+1, z, o, 20, 20000)
    pUnit:SpawnCreature(17902, x-3, y+2, z, o, 20, 20000)
    pUnit:SpawnCreature(17902, x-3, y-3, z, o, 20, 20000)
    pUnit:SpawnCreature(17902, x+4, y-5, z, o, 20, 20000)
    pUnit:SpawnCreature(17902, x+1, y-4, z, o, 20, 20000)
    pUnit:SpawnCreature(17902, x-4, y+1, z, o, 20, 20000)
    pUnit:SendChatMessage(14, 0, "Warriors of The Forsaken, aid me!")
 end

 function Sylvannas_Enrage(pUnit, Event)
    pUnit:FullCastSpell(42705)
 end


 function Sylvannas_Armor(pUnit, Event)
    pUnit:FullCastSpell(29476)
 end

 function Sylvannas_Fire(pUnit, Event)
Choice = math.random(1,2)
 if Choice==1 then
    pUnit:SpawnGameObject(183816, x+4, y-3, z, o, 50000)
    pUnit:SpawnGameObject(189330, x+4, y-3, z, o, 50000)
    pUnit:SpawnGameObject(183816, x+6, y-5, z, o, 50000)
    pUnit:SpawnGameObject(189330, x+6, y-5, z, o, 50000)
    pUnit:SpawnGameObject(183816, x-5, y+3, z, o, 50000)
    pUnit:SpawnGameObject(189330, x-5, y+3, z, o, 50000)
 end
    pUnit:SpawnGameObject(183816, x-4, y+3, z, o, 50000)
    pUnit:SpawnGameObject(189330, x-4, y+3, z, o, 50000)
    pUnit:SpawnGameObject(183816, x-6, y+5, z, o, 50000)
    pUnit:SpawnGameObject(189330, x-6, y+5, z, o, 50000)
    pUnit:SpawnGameObject(183816, x+5, y-3, z, o, 50000)
    pUnit:SpawnGameObject(189330, x+5, y-3, z, o, 50000)
 end

 function Sylvannas_Shear(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
 if (plr ~= nil) then
    pUnit:FullCastSpellOnTarget(41032, plr)
    pUnit:SendChatMessage(12, 0, "Experience the power of The Forsaken")
 end
end

 function Sylvannas_DrawSoul(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
 if (plr ~= nil) then
    pUnit:FullCastSpellOnTarget(40904, plr)
end
 end

 function Sylvannas_Wipe(pUnit, Event)
    pUnit:FullCastSpell(35354)
 end

 function Sylvannas_Phase2(pUnit, Event)
   local fbtime=math.random(70000, 80000)
if pUnit:GetHealthPct() < 45 then
    pUnit:SendChatMessage(14,0, "Im enraging!")
    pUnit:RemoveEvents()
    pUnit:RegisterEvent("Sylvannas_Shadowbolt", 20756, 0)
    pUnit:RegisterEvent("Sylvannas_Plague", 25000, 0)
    pUnit:RegisterEvent("Sylvannas_Spawns", 35654, 0)
    pUnit:RegisterEvent("Sylvannas_Enrage", fbtime, 0)
    pUnit:RegisterEvent("Sylvannas_Armor", 54609, 1)
    pUnit:RegisterEvent("Sylvannas_Phase3", 1000, 0)
 end
end



 function Sylvannas_Phase3(pUnit, Event)
   local fbtime=math.random(40000, 65000)
if pUnit:GetHealthPct() < 20 then
    pUnit:SendChatMessage(14, 0, "You are pissing me off...")
    pUnit:RemoveEvents()
    pUnit:FullCastSpell(41524)
     pUnit:SpawnGameObject(183816, x+4, y-3, z, o, 20000)
     pUnit:SpawnGameObject(189330, x+4, y-3, z, o, 20000)
    pUnit:RegisterEvent("Sylvannas_Fire", 20000, 0)
    pUnit:RegisterEvent("Sylvannas_Spawns", fbtime, 0)
    pUnit:RegisterEvent("Sylvannas_Shadowbolt", 20756, 0)
    pUnit:RegisterEvent("Sylvannas_Plague", 25000, 0)
    pUnit:RegisterEvent("Sylvannas_Shear", 34533, 0)
    pUnit:RegisterEvent("Sylvannas_Finalphase", 1000, 0)
 end
end

 function Sylvannas_Finalphase(pUnit, Event)
   local fbtime=math.random(35406, 57687)
if pUnit:GetHealthPct() < 4 then
    pUnit:RemoveEvents()
    pUnit:SendChatMessage(12, 0, "You have come so far.... to die here, mortals!")
     pUnit:SpawnGameObject(183816, x+4, y-3, z, o, 20000)
     pUnit:SpawnGameObject(189330, x+4, y-3, z, o, 20000)
    pUnit:RegisterEvent("Sylvannas_Fire", 20000, 0)
    pUnit:RegisterEvent("Sylvannas_Spawns", fbtime, 0)
    pUnit:RegisterEvent("Sylvannas_Shadowbolt", 20756, 0)
    pUnit:RegisterEvent("Sylvannas_Plague", 25000, 0)
    pUnit:RegisterEvent("Sylvannas_Shear", 34533, 0)
    pUnit:RegisterEvent("Sylvannas_DrawSoul", fbtime, 0)
    pUnit:RegisterEvent("Sylvannas_Wipe", 300000, 1)
 end
end


RegisterUnitEvent(101810,1,"Sylvannas_OnCombat")
RegisterUnitEvent(101810,2,"Sylvannas_OnLeaveCombat")
RegisterUnitEvent(101810,3,"Sylvannas_OnKilledTarget")
RegisterUnitEvent(101810,4,"Sylvannas_OnDied")