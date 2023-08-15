-- BLUA Scripting Project
-- Part of OutlandZoning Division
-- Scripted by Hellgawd
-- Give full credits if posting


function UmbOrcale_OnKill(pUnit,Event)
	pUnit:RemoveEvents();
end

function UmbOrcale_EnterCombat(pUnit,Event)
pUnit:RegisterEvent("hittest_1",1000, 0)
pUnit:CastSpell(12550)
end

function hittest_1(pUnit, Event)
 if pUnit:GetHealthPct() < 15 then
  pUnit:RemoveEvents();
	pUnit:CastSpell(26097)

 end
end

function UmbOrcale_Start(pUnit, Event)
 pUnit:RegisterEvent("hittest_1",1000, 0)
end


RegisterUnitEvent(18077, 1, "UmbOrcale_Start")
RegisterUnitEvent(18077, 3, "UmbOrcale_OnKill")
RegisterUnitEvent(18077, 1, "UmbOrcale_EnterCombat")