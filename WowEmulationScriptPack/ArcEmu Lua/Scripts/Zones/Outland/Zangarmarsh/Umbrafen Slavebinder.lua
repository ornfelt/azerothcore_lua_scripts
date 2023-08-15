-- BLUA Scripting Project
-- Part of OutlandZoning Division
-- Scripted by Hellgawd
-- Give full credits if posting


function UmbSeer_OnKill(pUnit,Event)
	pUnit:RemoveEvents();
end

function UmbSeer_EnterCombat(pUnit,Event)
pUnit: SendChatMessage(12, 0, "You will not unbind the slaves!")
end

RegisterUnitEvent(18042, 3, "UmbSeer_OnKill")
RegisterUnitEvent(18042, 1, "UmbSeer_EnterCombat")