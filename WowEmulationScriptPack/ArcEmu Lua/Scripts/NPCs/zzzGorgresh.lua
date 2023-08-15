--************************************************************
--*                                                          *
--*               ******************************             *                   
--*               *                            *             *
--*               *   The FrostTeam Project    *             *     
--*               *        stoneharry          *             *
--*               ******************************             *            
--*                                                          *
--*                                                          *
--*      --FrostTeam SVN consists of the latest WotLK        *   
--*      scripts, both Lua and C++. Some will be our own,    *
--*      some will be others with credits attatched. Our     *
--*      Svn includes all scripts that you may need          *
--*      to help make your server a more fun environment.--  *
--*                                                          *
--************************************************************

function gorgresh_OnEnterCombat(pUnit,Event)
  pUnit:SendChatMessage(12, 0, "Everybody always wanna take from us! Now we gonna start taking back. Anybody who get in our way, gonna drown in their own blood. The Amani empire be back now, seek vengence, and we gonna start, with you!")
  pUnit:PlaySoundToSet(12090)
  pUnit:StopMovement(999999999)
  pUnit:SetCombatCapable(1)
  pUnit:CastSpell(9438)
  pUnit:RegisterEvent("gorgresh_timedelay", 8500, 0)
  pUnit:RegisterEvent("gorgresh_start", 29500, 0)
end

function gorgresh_timedelay(pUnit,Event)
        pUnit:CastSpell(9438)
end


function gorgresh_start(pUnit,Event)
        pUnit:RemoveEvents()
        pUnit:StopMovement(1000)
        pUnit:SetCombatCapable(0)
        pUnit:PlaySoundToSet(12094)
        pUnit:SendChatMessage(12, 0, "Let me introduce you to me new brothers, fang and claw.")
        x = pUnit:GetX();
        y = pUnit:GetY();
        z = pUnit:GetZ();
        o = pUnit:GetO();
        x = x - 2
        y = y - 2
        pUnit:SpawnCreature(24043, x, y, z, o, 20, 45000);
        x = x + 4
        y = y + 4
        pUnit:SpawnCreature(24043, x, y, z, o, 20, 45000);
        pUnit:RegisterEvent("gorgresh_phase2", 2500, 0)
        pUnit:RegisterEvent("gorgresh_phase3", 2500, 0)
end


function gorgresh_phase2(pUnit,Event)
        Choice=math.random(1, 3)
        if Choice==1 then
        pUnit:CastSpellOnTarget(8292, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(8292, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(8292, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(8292, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(8292, pUnit:GetRandomPlayer(0))
        pUnit:StopMovement(2499)
        end 
        if Choice==2 then
        pUnit:FullCastSpellOnTarget(46297, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(38823, pUnit:GetRandomPlayer(0))
        pUnit:StopMovement(2499)
        end
        if Choice==3 then
        pUnit:CastSpellOnTarget(9613, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(9613, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(9613, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(9613, pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(9613, pUnit:GetRandomPlayer(0))
        pUnit:StopMovement(2499)
        end
end

function gorgresh_phase3(pUnit,Event)
      if pUnit:GetHealthPct() < 86 then
         pUnit:RemoveEvents()
         pUnit:PlaySoundToSet(12095)
         pUnit:SendChatMessage(12, 0, "Ya don't have to look to the sky, to see the Dragonhawk!")
         pUnit:StopMovement(99999999)
         pUnit:SetCombatCapable(1)
         pUnit:RegisterEvent("gorgresh_phase3buff", 4000, 0)
      end
end

function gorgresh_phase3buff(pUnit,Event)
         pUnit:RemoveEvents()
         pUnit:StopMovement(99999999)
         pUnit:SetCombatCapable(1)
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpellOnTarget(38887, pUnit:GetRandomPlayer(0))
         pUnit:CastSpell(38627)
         pUnit:CastSpell(23257)
        Choice=math.random(1, 2)
        if Choice==1 then
         pUnit:RemoveEvents()
         pUnit:RegisterEvent("gorgresh_phase4one", 1000, 0)
        end 
        if Choice==2 then
         pUnit:RemoveEvents()
         pUnit:RegisterEvent("gorgresh_phase4two", 1000, 0)
        end
end

function gorgresh_phase4one(pUnit,Event)
                    pUnit:RemoveEvents()
                    pUnit:PlaySoundToSet(12096)
                    pUnit:SendChatMessage(12, 0, "Fire kill you, just as quick.")
                    pUnit:FullCastSpell(36921)
                    pUnit:CastSpellOnTarget(59972, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(18502, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(58845, pUnit:GetRandomPlayer(0))
                    pUnit:RegisterEvent("gorgresh_phase5prep", 7500, 0)
end

function gorgresh_phase4two(pUnit,Event)
                    pUnit:RemoveEvents()
                    pUnit:PlaySoundToSet(12097)
                    pUnit:SendChatMessage(12, 0, "Ya to slow, me to strong!")
                    pUnit:CastSpellOnTarget(59972, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(18502, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(58845, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(58845, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(58845, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(59972, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(16071, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(16071, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(18502, pUnit:GetRandomPlayer(0))
                    pUnit:CastSpellOnTarget(59972, pUnit:GetRandomPlayer(0))
                    pUnit:RegisterEvent("gorgresh_phase5prep", 7500, 0)
end

function gorgresh_phase5prep(pUnit,Event)
               pUnit:RemoveEvents()
               pUnit:SetScale(1.5)
               pUnit:StopMovement(1000)
               pUnit:SetCombatCapable(0)
               pUnit:RegisterEvent("gorgresh_phase5", 1000, 0)
end

function gorgresh_phase5(pUnit,Event)
            if pUnit:GetHealthPct() < 50 then
               pUnit:RemoveEvents()
               Choice=math.random(1, 2)
            if Choice==1 then
               pUnit:CastSpellOnTarget(28969, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(28969, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(28969, pUnit:GetRandomPlayer(0))
               end 
            if Choice==2 then
               pUnit:CastSpellOnTarget(29325, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(29325, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(29325, pUnit:GetRandomPlayer(0))
               end
               pUnit:RegisterEvent("gorgresh_phase6", 1000, 0)
            end
end


function gorgresh_phase6(pUnit,Event)
            if pUnit:GetHealthPct() < 25 then
               pUnit:RemoveEvents()
               pUnit:PlaySoundToSet(12098)
               pUnit:SendChatMessage(12, 0, "Da Amani, de chuka!")
               pUnit:CastSpell(3223)
               pUnit:CastSpell(54452)
               pUnit:CastSpell(17537)
               pUnit:CastSpell(39627)
               pUnit:CastSpell(16883)
               pUnit:RegisterEvent("gorgresh_finalphase", 10000, 0)
               end
end

function gorgresh_finalphase(pUnit,Event)
               pUnit:RemoveEvents()
               pUnit:PlaySoundToSet(12099)
               pUnit:SendChatMessage(12, 0, "Lot more gonna fall like you!")
               Choice=math.random(1, 2)
            if Choice==1 then
               pUnit:CastSpellOnTarget(38027, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(38027, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(38027, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(38027, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(38027, pUnit:GetRandomPlayer(0))
               end 
            if Choice==2 then
               pUnit:CastSpellOnTarget(33132, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(33132, pUnit:GetRandomPlayer(0))
               pUnit:CastSpellOnTarget(33132, pUnit:GetRandomPlayer(0))
               pUnit:CastSpell(30035)
               pUnit:CastSpell(24543)
               pUnit:CastSpell(29979)
               end
               pUnit:RegisterEvent("gorgresh_phase2", 7500, 0)
end

function gorgresh_OnLeaveCombat(pUnit, event)
  pUnit:StopMovement(0)
  pUnit:SetCombatCapable(0)
  pUnit:SetScale(1.2)
  pUnit:RemoveEvents()
end

function gorgresh_OnKilledTarget(pUnit)
  pUnit:CastSpellOnTarget(11, pUnit:GetRandomPlayer(0))
  pUnit:CastSpellOnTarget(11, pUnit:GetRandomPlayer(0))
  pUnit:CastSpellOnTarget(11, pUnit:GetRandomPlayer(0))
  pUnit:CastSpellOnTarget(11, pUnit:GetRandomPlayer(0))
  pUnit:CastSpellOnTarget(11, pUnit:GetRandomPlayer(0))
end


function gorgresh_Death(pUnit)
  pUnit:SetScale(1.2)
  pUnit:StopMovement(0)
  pUnit:SetCombatCapable(0)
  pUnit:PlaySoundToSet(12100)
  pUnit:SendChatMessage(12, 0, "Maybe me fall... but da Amani empire... never gonna die...")
  pUnit:RemoveEvents()
end

RegisterUnitEvent(100450, 1, "gorgresh_OnEnterCombat")
RegisterUnitEvent(100450, 2, "gorgresh_OnLeaveCombat")
RegisterUnitEvent(100450, 3, "gorgresh_OnKilledTarget")
RegisterUnitEvent(100450, 4, "gorgresh_Death")