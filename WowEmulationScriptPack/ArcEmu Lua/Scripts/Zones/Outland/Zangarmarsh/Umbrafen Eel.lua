-- BLUA Scripting Project
-- Part of OutlandZoning Division
-- Scripted by Hellgawd
-- Give full credits if posting


function UmbEel_OnKill(pUnit,Event)
	pUnit:RemoveEvents();

end

function UmbEel_EnterCombat(pUnit,Event)
pUnit:RegisterEvent("electricskin",1000, 0)

end


function electricskin(pUnit, Event)
	pUnit:CastSpell(35319)

end

function UmbEel_Start(pUnit, Event)
 pUnit:RegisterEvent("electricskin",1000, 0)


end

RegisterUnitEvent(18138, 1, "UmbEel_Start")
RegisterUnitEvent(18138, 3, "UmbEel_OnKill")
RegisterUnitEvent(18138, 1, "UmbEel_EnterCombat")