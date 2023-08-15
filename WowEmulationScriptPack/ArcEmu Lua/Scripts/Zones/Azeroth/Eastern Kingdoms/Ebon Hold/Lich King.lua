function Arthas_OnEnterCombat(Unit,Event)
 	Unit:SendChatMessage(14, 0, "You shall serve the One... True...King!")
 	Unit:RegisterEvent("Arthas_Talk", 30000, 0)
 	Unit:RegisterEvent("Arthas_Blizzard", 15000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 30000, 0)
 	Unit:RegisterEvent("Arthas_Wrath1", 1000, 0)
  end



               ---BLA BLA BLA---           

function Arthas_Talk(Unit,Event)
 Choice=math.random(1,3)
if Choice==1 then
 	Unit:SendChatMessage(14, 0, "All life shall be extincted!")
 end
if Choice==2 then
 	Unit:SendChatMessage(14, 0, "We... are... one!")
 end
if Choice==3 then
 	Unit:SendChatMessage(14, 0, "Bow... to your Master!")
 end
end

      
               ---ATTACKS---

function Arthas_Blizzard(Unit,Event)
 Choice=math.random(1,2)
if Choice==1 then
 	Unit:FullCastSpellOnTarget(42938,	Unit:GetRandomPlayer(0))
 end
if Choice==2 then
 	Unit:FullCastSpellOnTarget(42938,	Unit:GetRandomPlayer(0))
 	Unit:FullCastSpellOnTarget(60020,	Unit:GetRandomPlayer(0))
 end 
end

function Arthas_Breath(Unit,Event)
 Choice=math.random(1,2)
if Choice==1 then
 	Unit:FullCastSpellOnTarget(49111,	Unit:GetRandomPlayer(0))
 end
if Choice==2 then
 	Unit:FullCastSpellOnTarget(49111,	Unit:GetRandomPlayer(0))
 	Unit:FullCastSpellOnTarget(60020,	Unit:GetRandomPlayer(0))
 end
end

function Arthas_Froze(Unit,Event)
 	Unit:SetCombatCapable(1)
 	Unit:FullCastSpellOnTarget(51209,	Unit:GetRandomPlayer(0))
 end

function Arthas_Summon(Unit,Event)
 	Unit:SetCombatCapable(0)
 	Unit:FullCastSpellOnTarget(49100,	Unit:GetMainTank())
 	Unit:SendChatMessage(14, 0, "Come my minions, extinguish all life!")
 end

function Arthas_FrostBurn(Unit,Event)
 	Unit:FullCastSpellOnTarget(23189,	Unit:GetRandomPlayer(0))
 end

function Arthas_FrostBurn2(Unit,Event)
 	Unit:FullCastSpellOnTarget(23189,	Unit:GetRandomPlayer(0))
 	Unit:FullCastSpellOnTarget(60020,	Unit:GetRandomPlayer(0))
end

function Arthas_Tomb(Unit,Event)
 Choice=math.random(1,2)
if Choice==1 then
 	Unit:FullCastSpellOnTarget(48400,	Unit:GetMainTank())
 end
if Choice==2 then
 	Unit:FullCastSpellOnTarget(48400,	Unit:GetRandomPlayer(4))
 	Unit:FullCastSpellOnTarget(29058,	Unit:GetRandomPlayer(4))
 end
end

function Arthas_Bolt(Unit,Event)
 Choice=math.random(1,3)
if Choice==1 then
 	Unit:FullCastSpellOnTarget(55802,	Unit:GetRandomPlayer(4))
 end
if Choice==2 then
 	Unit:FullCastSpellOnTarget(55802,	Unit:GetRandomPlayer(5))
 end
if Choice==3 then
 	Unit:FullCastSpellOnTarget(55802,	Unit:GetMainTank())
 	Unit:FullCastSpellOnTarget(48400,	Unit:GetMainTank())
 end
end

function Arthas_Rest(Unit,Event)
 	Unit:FullCastSpell(40647)
 	Unit:ClearHateList()
 	Unit:SetCombatCapable(1)
 	Unit:SendChatMessage(12, 0, "I need... energy...")
 end

function Arthas_Rest1(Unit,Event)
 	Unit:SetCombatCapable(1)
 	Unit:SendChatMessage(12, 0, "Spirits of the dead.. Heal me!")
 	Unit:FullCastSpell(35341)
 	Unit:FullCastSpell(19823)
 	Unit:FullCastSpell(35341)
 	Unit:FullCastSpell(19823)
 	Unit:FullCastSpell(35341)
 	Unit:FullCastSpell(19823)
 	Unit:FullCastSpell(35341)
 end

function Arthas_Rest2(Unit,Event)
 	Unit:SetCombatCapable(1)
 	Unit:FullCastSpell(39990)
 	Unit:SetHealthPct(65)
 	Unit:SetCombatCapable(1)
 	Unit:SendChatMessage(12, 0, "Yes...")
 end

function Arthas_Rest3(Unit,Event)
 	Unit:SetCombatCapable(1)
 	Unit:FullCastSpell(39990)
 	Unit:FullCastSpell(26072)
 	Unit:SetHealthPct(69)
 	Unit:SetCombatCapable(1)
 	Unit:SendChatMessage(12, 0, "Power....")
 end

function Arthas_Prepare(Unit,Event)
 	Unit:SetCombatCapable(1)
 	Unit:FullCastSpell(39028)
 	Unit:SendChatMessage(14, 0, "I am ready to kill...")
 end

function Arthas_Fight(Unit,Event)
 	Unit:SetCombatCapable(0)
 end

function Arthas_Ghoul(Unit,Event)
 Choice=math.random(1,3)
if Choice==1 then
 	Unit:FullCastSpell(42651)
 	Unit:SendChatMessage(14, 0, "Fallen knights, rise and deal with these weaklings... Obey to your Master!")
 end
if Choice==2 then
 	Unit:FullCastSpell(42651)
 	Unit:SendChatMessage(14, 0, "The Lich King commands you to Kill... Destroy... Extinguish!")
 end
if Choice==3 then
 	Unit:FullCastSpell(42651)
 	Unit:SendChatMessage(14, 0, "Your partners will rise up against you!")
 end
end

function Arthas_Plague(Unit,Event)
 	Unit:FullCastSpellOnTarget(56361,	Unit:GetClosestPlayer())
 end

function Arthas_Incinerate(Unit,Event)
 	Unit:FullCastSpellOnTarget(40239,	Unit:GetRandomPlayer(0))
 end

function Arthas_ShadowOfDeath(Unit,Event)
 Choice=math.random(1,3)
if Choice==1 then
 	Unit:FullCastSpellOnTarget(40251,	Unit:GetRandomPlayer(0))
 	Unit:SendChatMessage(14, 0, "Time is ticking...")
 end
if Choice==2 then
 	Unit:FullCastSpellOnTarget(40251,	Unit:GetMainTank())
 	Unit:SendChatMessage(14, 0, "Death awaits you...")
 end
if Choice==3 then
 	Unit:FullCastSpellOnTarget(40251,	Unit:GetRandomPlayer(0))
 	Unit:SendChatMessage(14, 0, "You will die and rise has my minion!")
 end
end

function Arthas_Enrage(Unit,Event)
 	Unit:FullCastSpell(40683)
 end

function Arthas_ShadowDemon(Unit,Event)
 Choice=math.random(1,2)
if Choice==1 then
 	Unit:FullCastSpell(41117)
 end
if Choice==2 then
 	Unit:FullCastSpell(41117)
 end
end

function Arthas_Mortal(Unit,Event)
 	Unit:FullCastSpellOnTarget(47486,	Unit:GetMainTank())
 end

function Arthas_Fear(Unit,Event)
 	Unit:FullCastSpell(31970)
 end

function Arthas_Grip(Unit,Event)
 	Unit:FullCastSpellOnTarget(17968,	Unit:GetMainTank())
 	Unit:SendChatMessage(14, 0, "You are on the Lich King's grasp now...")
 end

function Arthas_Betrayal(Unit,Event)
 	Unit:FullCastSpellOnTarget(41001,	Unit:GetRandomPlayer(0))
 	Unit:SendChatMessage(14, 0, "My new disease... your friends will kill you!")
 end

function Arthas_Deathknight(Unit,Event)
       x=Unit:GetX();
       y=Unit:GetY();
       z=Unit:GetZ();
       o=Unit:GetO();
 	Unit:SpawnCreature(29101, x, y, z, o, 20, 0)
 end

function Arthas_Deathknight2(Unit,Event)
       x=Unit:GetX();
       y=Unit:GetY();
       z=Unit:GetZ();
       o=Unit:GetO();
 	Unit:SpawnCreature(29196, x, y, z, o, 20, 0)
 end

function Arthas_DKChoice(Unit,Event)
 Choice=math.random(1,2)
if Choice==1 then
       x=Unit:GetX();
       y=Unit:GetY();
       z=Unit:GetZ();
       o=Unit:GetO();
 	Unit:SpawnCreature(29196, x, y, z, o, 20, 0)
 end
if Choice==2 then  
       x=Unit:GetX();
       y=Unit:GetY();
       z=Unit:GetZ();
       o=Unit:GetO();
 	Unit:SpawnCreature(29101, x, y, z, o, 20, 0)
 end
end




--------------------------------------------FUNCTIONS--------------------------------------



function Arthas_Wrath1(Unit,Event)
if	Unit:GetHealthPct() < 94 then
 	Unit:RemoveEvents()
 	Unit:RegisterEvent("Arthas_Talk", 30000, 0)
 	Unit:RegisterEvent("Arthas_Froze", 2000, 1)
 	Unit:RegisterEvent("Arthas_Summon", 45000, 5)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 28000, 0)
 	Unit:RegisterEvent("Arthas_Wrath2", 2000, 0)
 end
end

function Arthas_Wrath2(Unit,Event)
if	Unit:GetHealthPct() < 80 then
 	Unit:RemoveEvents()
 	Unit:SendChatMessage(12, 0, "Your courage will lead to your death!")
 	Unit:RegisterEvent("Arthas_Talk", 30000, 0)
 	Unit:RegisterEvent("Arthas_Summon", 40000, 6)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 28000, 0)
 	Unit:RegisterEvent("Arthas_FrostBurn", 10000, 2)
 	Unit:RegisterEvent("Arthas_FrostBurn2", 30000, 0) 
 	Unit:RegisterEvent("Arthas_Tomb", 17000, 0) 
 	Unit:RegisterEvent("Arthas_Wrath3", 3000, 0)
 end
end

function Arthas_Wrath3(Unit,Event)
if	Unit:GetHealthPct() < 70 then
 	Unit:RemoveEvents()
 	Unit:RegisterEvent("Arthas_Talk", 30000, 0)
 	Unit:RegisterEvent("Arthas_Summon", 40000, 5)
 	Unit:RegisterEvent("Arthas_Bolt", 20000, 1)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 28000, 0)
 	Unit:RegisterEvent("Arthas_FrostBurn", 10000, 2)
 	Unit:RegisterEvent("Arthas_FrostBurn2", 30000, 0) 
 	Unit:RegisterEvent("Arthas_Tomb", 17000, 0) 
 	Unit:RegisterEvent("Arthas_Wrath4", 3000, 0)
 end
end

function Arthas_Wrath4(Unit,Event)
if	Unit:GetHealthPct() < 60 then
 	Unit:RemoveEvents()
 	Unit:SendChatMessage(14, 0, "This is getting boring...")
 	Unit:SendChatMessage(12, 0, "Kel'thuzad needs... rest..")
 	Unit:RegisterEvent("Arthas_Rest", 4000, 1) 
 	Unit:RegisterEvent("Arthas_Rest1", 7000, 1) 
 	Unit:RegisterEvent("Arthas_Rest2", 13000, 1) 
 	Unit:RegisterEvent("Arthas_Rest3", 17000, 1) 
 	Unit:RegisterEvent("Arthas_Prepare", 27000, 1)
 	Unit:RegisterEvent("Arthas_Fight", 31000, 0)
 	Unit:RegisterEvent("Arthas_Blizzard", 37000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 32000, 0)
 	Unit:RegisterEvent("Arthas_Wrath5", 2000, 0)
 end
end

function Arthas_Wrath5(Unit,Event)
if	Unit:GetHealthPct() < 69 then
 	Unit:RemoveEvents()
 	Unit:RegisterEvent("Arthas_Talk", 30000, 0)
 	Unit:RegisterEvent("Arthas_Summon", 35000, 0)
 	Unit:RegisterEvent("Arthas_Bolt", 20000, 1)
 	Unit:RegisterEvent("Arthas_Deathknight", 60000, 0)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 28000, 0)
 	Unit:RegisterEvent("Arthas_FrostBurn", 10000, 2)
 	Unit:RegisterEvent("Arthas_FrostBurn2", 30000, 0) 
 	Unit:RegisterEvent("Arthas_Tomb", 17000, 0)
 	Unit:RegisterEvent("Arthas_Wrath6", 2000, 0)
 end
end

function Arthas_Wrath6(Unit,Event)
if	Unit:GetHealthPct() < 50 then
 	Unit:RemoveEvents()
 	Unit:RegisterEvent("Arthas_Talk", 30000, 0)
 	Unit:RegisterEvent("Arthas_Ghoul", 40000, 0)
 	Unit:RegisterEvent("Arthas_Bolt", 20000, 3)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 28000, 0)
 	Unit:RegisterEvent("Arthas_FrostBurn", 10000, 2)
 	Unit:RegisterEvent("Arthas_DeathKnight2", 70000, 0)
 	Unit:RegisterEvent("Arthas_FrostBurn2", 30000, 0) 
 	Unit:RegisterEvent("Arthas_Tomb", 17000, 0)
 	Unit:RegisterEvent("Arthas_Plague", 15687, 0)
 	Unit:RegisterEvent("Arthas_Wrath7", 2000, 0)
 end
end

function Arthas_Wrath7(Unit,Event)
if	Unit:GetHealthPct() < 25 then
 	Unit:RemoveEvents()
 	Unit:RegisterEvent("Arthas_Talk", 30000, 0)
 	Unit:RegisterEvent("Arthas_Ghoul", 40000, 0)
 	Unit:RegisterEvent("Arthas_Incinerate", 20000, 0)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Breath", 28000, 0)
 	Unit:RegisterEvent("Arthas_Tomb", 17000, 0)
 	Unit:RegisterEvent("Arthas_Plague", 15687, 0)
 	Unit:RegisterEvent("Arthas_DeathKnight2", 70000, 0)
 	Unit:RegisterEvent("Arthas_ShadowOfDeath", 60000, 2)
 	Unit:RegisterEvent("Arthas_Fury1", 2000, 0)
 end
end

function Arthas_Fury1(Unit,Event)
if	Unit:GetHealthPct() < 5 then
 	Unit:SendChatMessage(12, 0, "Kel'Thuzad, this is getting dangerous...")
 	Unit:SendChatMessage(12, 0, "I'll have to use your power.")
 	Unit:RegisterEvent("Arthas_Enrage", 20000, 0)
 	Unit:RegisterEvent("Arthas_ShadowDemon", 34000, 0)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Plague", 15687, 0)
 	Unit:RegisterEvent("Arthas_Mortal", 30000, 0)
 	Unit:RegisterEvent("Arthas_DeathKnight2", 50000, 0)
 	Unit:RegisterEvent("Arthas_Final", 2000, 0)
 end
end

function Arthas_Final(Unit,Event)
if	Unit:GetHealthPct() < 2 then
 	Unit:SendChatMessage(14, 0, "Impossible! The King cant be defeated!")
 	Unit:PlaySoundToSet(12736)
 	Unit:PlaySoundToSet(12735)
 	Unit:RegisterEvent("Arthas_Enrage", 2000, 0)
 	Unit:RegisterEvent("Arthas_ShadowDemon", 34000, 0)
 	Unit:RegisterEvent("Arthas_Blizzard", 14000, 0)
 	Unit:RegisterEvent("Arthas_Plague", 15687, 0)
 	Unit:RegisterEvent("Arthas_DeathKnight2", 50000, 0)
 	Unit:RegisterEvent("Arthas_DeathKnight", 50000, 0)
 	Unit:RegisterEvent("Arthas_Mortal", 30000, 0)
 	Unit:RegisterEvent("Arthas_Fear", 20000, 0)
 	Unit:RegisterEvent("Arthas_Grip", 25000, 1)
 	Unit:RegisterEvent("Arthas_Betrayal", 45000, 0)
 end
end

-----------------------------------Other functions----------------------------------------------------

function Arthas_OnLeaveCombat(Unit,Event)
 	Unit:RemoveEvents()
 end

function Arthas_Died(Unit,Event)
 	Unit:RemoveEvents()
 	Unit:SendChatMessage(14, 0, "Kel'thuzad... I have been defeated by... your creations.")
 end

function Arthas_Killtarget(Unit,Event)
 	Unit:RemoveEvents()
 	Unit:SendChatMessage(14, 0, "Rise as my minion!")
 	Unit:RegisterEvent("Arthas_DKChoice", 2000, 0)
 end
  


RegisterUnitEvent(25462, 1, "Arthas_OnEnterCombat")
RegisterUnitEvent(25462, 2, "Arthas_OnLeaveCombat")
RegisterUnitEvent(25462, 4, "Arthas_Died")
RegisterUnitEvent(25462, 3, "Arthas_Killtarget")





-------------------------------------------                   ------------------------------
-------------------------------------------DEATHKNIGHT SCRIPTS------------------------------
-------------------------------------------                   ------------------------------


function DeathKnight_OnEnterCombat(Unit,Event)
 	Unit:SendChatMessage(14, 0, "The Lich King demands me to kill... destroy... extinguish!")
 	Unit:RegisterEvent("DeathKnight_DeathCoil", 36547,  0)
 	Unit:RegisterEvent("DeathKnight_Strangulate", 15000, 0)
 	Unit:RegisterEvent("DeathKnight_HungeringCold", 20000, 0)
 	Unit:RegisterEvent("DeathKnight_HowlingBlast", 20100, 0)
 end
  

  




function DeathKnight_DeathCoil(Unit,Event)
 	Unit:FullCastSpellOnTarget(35954,	Unit:GetMainTank())
 end

function DeathKnight_Strangulate(Unit,Event)
 	Unit:FullCastSpellOnTarget(55334,	Unit:GetMainTank())
 end

function DeathKnight_HungeringCold(Unit,Event)
 	Unit:FullCastSpellOnTarget(51209,	Unit:GetMainTank())
 end

function DeathKnight_HowlingBlast(Unit,Event)
 	Unit:FullCastSpellOnTarget(61061,	Unit:GetMainTank())
 end

function DeathKnight_OnLeaveCombat(Unit,Event)
 	Unit:RemoveEvents()
 end

function DeathKnight_KillTarget(Unit,Event)
 	Unit:RemoveEvents()
 end

function DeathKnight_Died(Unit,Event)
 	Unit:RemoveEvents()
 end

RegisterUnitEvent(29101, 1, "DeathKnight_OnEnterCombat")
RegisterUnitEvent(29101, 2, "DeathKnight_OnLeaveCombat")
RegisterUnitEvent(29101, 3, "DeathKnight_KillTarget")
RegisterUnitEvent(29101, 4, "DeathKnight_Died")



--------------------------------------------------------



function DeathKnight2_OnEnterCombat(Unit,Event)
 	Unit:SendChatMessage(14, 0, "Experience the DeathKnight Power!")
 	Unit:RegisterEvent("DeathKnight2_DeathCoil", 36547,  0)
 	Unit:RegisterEvent("DeathKnight2_Strangulate", 15000, 0)
 	Unit:RegisterEvent("DeathKnight2_HungeringCold", 20000, 0)
 	Unit:RegisterEvent("DeathKnight2_HowlingBlast", 20100, 0)
 end
  



function DeathKnight2_DeathCoil(Unit,Event)
 	Unit:FullCastSpellOnTarget(35954,	Unit:GetMainTank())
 end

function DeathKnight2_Strangulate(Unit,Event)
 	Unit:FullCastSpellOnTarget(55334,	Unit:GetMainTank())
 end

function DeathKnight2_HungeringCold(Unit,Event)
 	Unit:FullCastSpellOnTarget(51209,	Unit:GetMainTank())
 end

function DeathKnight2_HowlingBlast(Unit,Event)
 	Unit:FullCastSpellOnTarget(61061,	Unit:GetMainTank())
 end

function DeathKnight2_OnLeaveCombat(Unit,Event)
 	Unit:RemoveEvents()
 end

function DeathKnight2_KillTarget(Unit,Event)
 	Unit:RemoveEvents()
 end

function DeathKnight2_Died(Unit,Event)
 	Unit:RemoveEvents()
 end

RegisterUnitEvent(29196, 1, "DeathKnight2_OnEnterCombat")
RegisterUnitEvent(29196, 2, "DeathKnight2_OnLeaveCombat")
RegisterUnitEvent(29196, 3, "DeathKnight2_KillTarget")
RegisterUnitEvent(29196, 4, "DeathKnight2_Died")