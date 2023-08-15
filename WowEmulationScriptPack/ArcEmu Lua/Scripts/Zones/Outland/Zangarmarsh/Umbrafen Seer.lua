-- BLUA Scripting Project
-- Part of OutlandZoning Division
-- Scripted by Hellgawd
-- Give full credits if posting


function UmbOrcale_OnKill(pUnit,Event)
	pUnit:RemoveEvents();
end

function UmbOrcale_EnterCombat(pUnit,Event)
pUnit:RegisterEvent("hittest_1",1000, 0)
end

function hittest_1(pUnit, Event)
 if pUnit:GetHealthPct() < 85 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(32173,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("hittest_2",1000, 0)
 end
end

function hittest_2(pUnit, Event)
 if pUnit:GetHealthPct() < 55 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(9739,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("hittest_3",1000, 0)
 end
end

function hittest_3(pUnit, Event)
 if pUnit:GetHealthPct() < 25 then
  pUnit:RemoveEvents();
	pUnit:FullCastSpellOnTarget(9739,pUnit:GetClosestPlayer())
 end
end


function UmbOrcale_Start(pUnit, Event)
 pUnit:RegisterEvent("hittest_1",1000, 0)
end


RegisterUnitEvent(18079, 1, "UmbOrcale_Start")
RegisterUnitEvent(18079, 3, "UmbOrcale_OnKill")
RegisterUnitEvent(18079, 1, "UmbOrcale_EnterCombat")