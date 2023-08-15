-- BLUA Scripting Project
-- Part of OutlandZoning Division
-- Scripted by Hellgawd
-- Give full credits if posting


function UmbWD_OnKill(pUnit,Event)
	pUnit:RemoveEvents();
end

function UmbWD_EnterCombat(pUnit,Event)
pUnit:RegisterEvent("hittest_1",1000, 0)
pUnit:FullCastSpell(34871)
end

function hittest_1(pUnit, Event)
 if pUnit:GetHealthPct() < 90 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(7289,pUnit:GetClosestPlayer())
  pUnit:RegisterEvent("hittest_2",1000, 0)
 end
end

function hittest_2(pUnit, Event)
 if pUnit:GetHealthPct() < 75 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpell(35197)
  pUnit:RegisterEvent("hittest_3",1000, 0)
 end
end

function hittest_3(pUnit, Event)
 if pUnit:GetHealthPct() < 45 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(7289,pUnit:GetClosestPlayer())
  pUnit:RegisterEvent("hittest_4",1000, 0)
 end
end

function hittest_4(pUnit, Event)
 if pUnit:GetHealthPct() < 15 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpell(35197)
 end
end

function UmbWD_Start(pUnit, Event)
 pUnit:RegisterEvent("hittest_1",1000, 0)
end


RegisterUnitEvent(20115, 1, "UmbWD_Start")
RegisterUnitEvent(20115, 3, "UmbWD_OnKill")
RegisterUnitEvent(20115, 1, "UmbWD_EnterCombat")