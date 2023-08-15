--Halazzi script by Project eXa
function Halazzi_OnAgro(Unit, event)
timer=math.random(5000, 15000)
    Unit:SendChatMessage(12,0,"Get on ya knees and bow, to da fang and da claw")
    Unit:PlaySoundToSet(12020)
    Unit:RegisterEvent("Halazzi_Frenzy",10000,0)
    Unit:RegisterEvent("Halazzi_Lash1",timer,1)
    Unit:RegisterEvent("Halazzi_FirstSplit",1000,0)
end

function Halazzi_Frenzy(Unit)
    Unit:CastSpell(43267)
end

function Halazzi_Lash1(pUnit, event)
timer=math.random(5000, 15000)
    pUnit:FullCastSpellOnTarget(43267, pUnit:GetMainTank())
    pUnit:RegisterEvent("Halazzi_Lash2",timer,1)
end

function Halazzi_Lash2(pUnit, event)
timer=math.random(5000, 15000)
    pUnit:FullCastSpellOnTarget(43267, pUnit:GetMainTank())
    pUnit:RegisterEvent("Halazzi_Lash1",timer,1)
end

function Halazzi_FirstSplit(pUnit, event)
  fstimer=math.random(10000, 20000)
  estimer=math.random(10000, 20000)
  totemtimer=math.random(10000, 20000)
  x = pUnit: GetX()
  y = pUnit: GetY()
  z = pUnit: GetZ()
  o = pUnit: GetO()
  x = x - 10
  y = y - 10
   if pUnit:GetHealthPct() <75 then
    pUnit:RemoveEvents()
    pUnit:PlaySoundToSet(12021)
    pUnit:SendChatMessage(12,0,"I fight wit' untamed spirit...")
    pUnit:SetModel(22309)
    pUnit:SetHealthPct(100)
    pUnit:SpawnCreature(24143, x, y, z, o, 1890, 0)
    pUnit:RegisterEvent("Halazzi_FlameShock1",fstimer,1)
    pUnit:RegisterEvent("Halazzi_EarthShock1",estimer,1)
    pUnit:RegisterEvent("Halazzi_Combine1Chk",1000,0)
    pUnit:RegisterEvent("Halazzi_TotemSpawn1",totemtimer,0)
   end
end

function Halazzi_FlameShock1(pUnit, event)
fstimer=math.random(10000, 20000)
    pUnit:FullCastSpellOnTarget(43303, pUnit:GetRandomPlayer(0))
    pUnit:RegisterEvent("Halazzi_FlameShock2",fstimer,1)
end

function Halazzi_FlameShock2(pUnit, event)
fstimer=math.random(10000, 20000)
    pUnit:FullCastSpellOnTarget(43303, pUnit:GetRandomPlayer(0))
    pUnit:RegisterEvent("Halazzi_FlameShock1",fstimer,1)
end

function Halazzi_TotemSpell(pUnit, event)
    pUnit:FullCastSpellOnTarget(41183, pUnit:GetRandomPlayer(0))
    pUnit:SetCombatMeleeCapable(1)
    pUnit:StopMovement(999999999)
    pUnit:SetScale(2)
    pUnit:RegisterEvent("Halazzi_TotemSpell2",6000,0)
end

function Halazzi_TotemSpell2(pUnit, event)
    pUnit:FullCastSpellOnTarget(41183, pUnit:GetRandomPlayer(0))
end

function Halazzi_TotemDeath(Unit)
    Unit:Despawn(1,0)
    nomoretotems = nil
end

function Halazzi_TotemOnLeaveCombat(Unit)
    Unit:Despawn(1,0)
end

function Halazzi_TotemSpawn1(pUnit, event)
   if nomoretotems== nil then
print("Totem spawned")
x2 = pUnit: GetX()
y2 = pUnit: GetY()
z2 = pUnit: GetZ()
o2 = pUnit: GetO()
x2 = x2 -5
y2 = y2 -3
    pUnit:CastSpell(43302)
    nomoretotems = 1
    pUnit:SpawnCreature(24224, x2, y2, z2, o2, 1890, 0)
   else
   end
end

function Halazzi_EarthShock1(pUnit, event)
estimer=math.random(10000, 20000)
    pUnit:FullCastSpellOnTarget(43305, pUnit:GetRandomPlayer(0))
    pUnit:RegisterEvent("Halazzi_EarthShock2",estimer,1)
end

function Halazzi_EarthShock2(pUnit, event)
estimer=math.random(10000, 20000)
    pUnit:FullCastSpellOnTarget(43305, pUnit:GetRandomPlayer(0))
    pUnit:RegisterEvent("Halazzi_EarthShock1",estimer,1)
end

function LynxSpirit_OnSpawn(pUnit, event)
    pUnit:RegisterEvent("LynxSpirit_CombineChk",1000,0)
end

function LynxSpirit_CombineChk(pUnit, event)
   if pUnit:GetHealthPct() < 20 and Didthat == nil then
    pUnit:RemoveEvents()
    pUnit:Despawn(1,0)
    Didthat = 1
    pUnit:RegisterEvent("Halazzi_Combine1Chk",1,0)
   elseif Didthat == 1 then
    pUnit:Despawn(1,0)
    pUnit:RegisterEvent("Halazzi_Combine1",1,0)
   end
end

function Halazzi_Combine1Chk(pUnit, event)
   if pUnit:GetHealthPct() < 20 and Didthat == nil then
    pUnit:RemoveEvents()
    pUnit:RegisterEvent("Halazzi_Combine1",1,0)
    Didthat = 1
    pUnit:RegisterEvent("LynxSpirit_CombineChk",1,0)
   elseif Didthat == 1 then
    pUnit:RegisterEvent("Halazzi_Combine1",1,0)

   end
end

function Halazzi_Combine1(pUnit, event)
timer=math.random(5000, 15000)
    pUnit:RemoveEvents()
    pUnit:SetHealthPct(75)
    pUnit:SetModel(21632)
    pUnit:PlaySoundToSet(12022)
    pUnit:SendChatMessage(12,0,"Spirit! Come back to me...")
    pUnit:RegisterEvent("Halazzi_Frenzy",10000,0)
    pUnit:RegisterEvent("Halazzi_Lash1",timer,1)
    pUnit:RegisterEvent("Halazzi_SecondSplit",1000,0)

end

function Halazzi_SecondSplit(pUnit, event)
  fstimer=math.random(10000, 20000)
  estimer=math.random(10000, 20000)
  totemtimer=math.random(10000, 20000)
  x = pUnit: GetX()
  y = pUnit: GetY()
  z = pUnit: GetZ()
  o = pUnit: GetO()
  x = x - 10
  y = y - 10
   if pUnit:GetHealthPct() <50 then
   Didthat = nil
    pUnit:RemoveEvents()
    pUnit:PlaySoundToSet(12021)
    pUnit:SendChatMessage(12,0,"I fight wit' untamed spirit...")
    pUnit:SetModel(22309)
    pUnit:SetHealthPct(100)
    pUnit:SpawnCreature(24143, x, y, z, o, 1890, 0)
    pUnit:RegisterEvent("Halazzi_FlameShock1",fstimer,1)
    pUnit:RegisterEvent("Halazzi_EarthShock1",estimer,1)
    pUnit:RegisterEvent("Halazzi_Combine2Chk",1000,0)
    pUnit:RegisterEvent("Halazzi_TotemSpawn1",totemtimer,0)

   end
end

function LynxSpirit_OnSpawn(pUnit, event)
    pUnit:RegisterEvent("LynxSpirit_CombineChk",1000,0)
end

function LynxSpirit_CombineChk(pUnit, event)
   if pUnit:GetHealthPct() < 20 and Didthat == nil then
    pUnit:RemoveEvents()
    pUnit:Despawn(1,0)
    Didthat = 1
    pUnit:RegisterEvent("Halazzi_Combine2Chk",1,0)
   elseif Didthat == 1 then
    pUnit:Despawn(1,0)
    pUnit:RegisterEvent("Halazzi_Combine2",1,0)
   end
end

function Halazzi_Combine2Chk(pUnit, event)
   if pUnit:GetHealthPct() < 20 and Didthat == nil then
    pUnit:RemoveEvents()
    pUnit:RegisterEvent("Halazzi_Combine2",1,0)
    Didthat = 1
    pUnit:RegisterEvent("LynxSpirit_CombineChk",1,0)
   elseif Didthat == 1 then
    pUnit:RegisterEvent("Halazzi_Combine2",1,0)

   end
end

function Halazzi_Combine2(pUnit, event)
timer=math.random(5000, 15000)
    pUnit:RemoveEvents()
    pUnit:SetHealthPct(50)
    pUnit:SetModel(21632)
    pUnit:PlaySoundToSet(12022)
    pUnit:SendChatMessage(12,0,"Spirit! Come back to me...")
    pUnit:RegisterEvent("Halazzi_Frenzy",10000,0)
    pUnit:RegisterEvent("Halazzi_Lash1",timer,1)
    pUnit:RegisterEvent("Halazzi_ThirdSplit",1000,0)
end

function Halazzi_ThirdSplit(pUnit, event)
  fstimer=math.random(10000, 20000)
  estimer=math.random(10000, 20000)
  totemtimer=math.random(10000, 20000)
  x = pUnit: GetX()
  y = pUnit: GetY()
  z = pUnit: GetZ()
  o = pUnit: GetO()
  x = x - 10
  y = y - 10
   if pUnit:GetHealthPct() <25 then
   Didthat = nil
    pUnit:RemoveEvents()
    pUnit:PlaySoundToSet(12021)
    pUnit:SendChatMessage(12,0,"I fight wit' untamed spirit...")
    pUnit:SetModel(22309)
    pUnit:SetHealthPct(100)
    pUnit:SpawnCreature(24143, x, y, z, o, 1890, 0)
    pUnit:RegisterEvent("Halazzi_FlameShock1",fstimer,1)
    pUnit:RegisterEvent("Halazzi_EarthShock1",estimer,1)
    pUnit:RegisterEvent("Halazzi_Combine3Chk",1000,0)
    pUnit:RegisterEvent("Halazzi_TotemSpawn1",totemtimer,0)
   end
end

function LynxSpirit_OnSpawn(pUnit, event)
    pUnit:RegisterEvent("LynxSpirit_CombineChk",1000,0)
end

function LynxSpirit_CombineChk(pUnit, event)
   if pUnit:GetHealthPct() < 20 and Didthat == nil then
    pUnit:RemoveEvents()
    pUnit:Despawn(1,0)
    Didthat = 1
    pUnit:RegisterEvent("Halazzi_Combine3Chk",1,0)
   elseif Didthat == 1 then
    pUnit:Despawn(1,0)
    pUnit:RegisterEvent("Halazzi_Combine3",1,0)
   end
end

function Halazzi_Combine3Chk(pUnit, event)
   if pUnit:GetHealthPct() < 20 and Didthat == nil then
    pUnit:RemoveEvents()
    pUnit:RegisterEvent("Halazzi_Combine3",1,0)
    Didthat = 1
    pUnit:RegisterEvent("LynxSpirit_CombineChk",1,0)
   elseif Didthat == 1 then
    pUnit:RegisterEvent("Halazzi_Combine3",1,0)

   end
end

function Halazzi_Combine3(pUnit, event)
timer=math.random(5000, 15000)
    pUnit:RemoveEvents()
    pUnit:SetHealthPct(25)
    pUnit:SetModel(21632)
    pUnit:PlaySoundToSet(12022)
    pUnit:SendChatMessage(12,0,"Spirit! Come back to me...")
    pUnit:RegisterEvent("Halazzi_Frenzy",10000,0)
    pUnit:RegisterEvent("Halazzi_Lash1",timer,1)
end

function Halazzi_OnKill(Unit, event)
    Killchoice=math.random()
    if Killchoice > .5 then
    Unit:SendChatMessage(12,0,"Ya can't fight da power!")
    Unit:PlaySoundToSet(12026)
    else
    Unit:SendChatMessage(12,0,"You gonna fail!")
    Unit:PlaySoundToSet(12027)
    end
end

function LynxSpirit_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
    Unit:Despawn(1,0)
    Didthat = nil
end

function Halazzi_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
    Unit:SetModel(21632)
    Didthat = nil
end

function Halazzi_OnDied(Unit)
    Unit:PlaySoundToSet(12028)
    Unit:SendChatMessage(12,0,"Chaga... choka'jinn.")
                Unit:RemoveEvents()
end


RegisterUnitEvent(23577,1,"Halazzi_OnAgro")
RegisterUnitEvent(23577,2,"LynxSpirit_OnLeaveCombat")
RegisterUnitEvent(24224,2,"Halazzi_TotemOnLeaveCombat")
RegisterUnitEvent(23577,2,"Halazzi_OnLeaveCombat")
RegisterUnitEvent(23577,3,"Halazzi_OnKill")
RegisterUnitEvent(24224,4,"Halazzi_TotemDeath")
RegisterUnitEvent(23577,4,"Halazzi_OnDied")
RegisterUnitEvent(24143,6,"LynxSpirit_OnSpawn")
RegisterUnitEvent(24224,6,"Halazzi_TotemSpell")