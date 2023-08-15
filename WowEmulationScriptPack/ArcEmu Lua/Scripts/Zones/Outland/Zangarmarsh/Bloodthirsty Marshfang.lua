-- BLUA Scripting Project
-- Part of OutlandZoning Division
-- Scripted by Hellgawd
-- Give full credits if posting


function bloodthirstymarsh_OnKill(pUnit,Event)
	pUnit:RemoveEvents();
end

function bloodthirstymarsh_EnterCombat(pUnit,Event)
pUnit:RegisterEvent("hittest_1",1000, 0)
end

function hittest_1(pUnit, Event)
 if pUnit:GetManaPct() < 30 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(17008,pUnit:GetClosestPlayer())
  pUnit:RegisterEvent("hittest_2",1000, 0)
 end
end

function hittest_2(pUnit, Event)
 if pUnit:GetHealthPct() < 65 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(17008,pUnit:GetClosestPlayer())
  pUnit:RegisterEvent("hittest_3",1000, 0)
 end
end

function hittest_3(pUnit, Event)
 if pUnit:GetHealthPct() < 45 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(17008,pUnit:GetClosestPlayer())
  pUnit:RegisterEvent("hittest_4",1000, 0)
 end
end

function hittest_4(pUnit, Event)
 if pUnit:GetHealthPct() < 10 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(35333,pUnit:GetClosestPlayer())
 end
end

function bloodthirstymarsh_Start(pUnit, Event)
 pUnit:RegisterEvent("hittest_1",1000, 0)
end


RegisterUnitEvent(20196, 1, "bloodthirstymarsh_Start")
RegisterUnitEvent(20196, 3, "bloodthirstymarsh_OnKill")
RegisterUnitEvent(20196, 1, "bloodthirstymarsh_EnterCombat")