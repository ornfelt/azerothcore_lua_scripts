-- BLUA Scripting Project
-- Part of OutlandZoning Division
-- Scripted by Hellgawd
-- Give full credits if posting


function CountUng_OnKill(pUnit,Event)
	pUnit:RemoveEvents();
end

function CountUng_EnterCombat(pUnit,Event)
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
 if pUnit:GetHealthPct() < 85 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(35333,pUnit:GetClosestPlayer())
  pUnit:RegisterEvent("hittest_3",1000, 0)
 end
end

function hittest_3(pUnit, Event)
 if pUnit:GetHealthPct() < 55 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(35333,pUnit:GetClosestPlayer())
  pUnit:RegisterEvent("hittest_4",1000, 0)
 end
end

function hittest_4(pUnit, Event)
 if pUnit:GetHealthPct() < 10 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(35333,pUnit:GetClosestPlayer())
 end
end

function CountUng_Start(pUnit, Event)
 pUnit:RegisterEvent("hittest_1",1000, 0)
end


RegisterUnitEvent(18285, 1, "CountUng_Start")
RegisterUnitEvent(18285, 3, "CountUng_OnKill")
RegisterUnitEvent(18285, 1, "CountUng_EnterCombat")