function SonOfCorok_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(12612,Unit:GetClosestPlayer())
	Unit:RegisterEvent("SonOfCorok_Stomp", 15000, 0)
end

function SonOfCorok_Stomp(Unit,Event)
	Unit:FullCastSpellOnTarget(12612,Unit:GetClosestPlayer())
end

function SonOfCorok_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SonOfCorok_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19824, 1, "SonOfCorok_OnEnterCombat")
RegisterUnitEvent(19824, 2, "SonOfCorok_OnLeaveCombat")
RegisterUnitEvent(19824, 4, "SonOfCorok_OnDied")