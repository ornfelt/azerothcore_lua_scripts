--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WarleaderKrazzilak_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarleaderKrazzilak_Backhand", 8000, 0)
	Unit:RegisterEvent("WarleaderKrazzilak_Hamstring", 15000, 0)
	Unit:RegisterEvent("WarleaderKrazzilak_InfectedWound", 20000, 1)
end

function WarleaderKrazzilak_Backhand(Unit, Event) 
	Unit:FullCastSpellOnTarget(18103, 	Unit:GetMainTank()) 
end

function WarleaderKrazzilak_Hamstring(Unit, Event) 
	Unit:FullCastSpellOnTarget(9080, 	Unit:GetMainTank()) 
end

function WarleaderKrazzilak_InfectedWound(Unit, Event) 
	Unit:FullCastSpellOnTarget(17230, 	Unit:GetMainTank()) 
end

function WarleaderKrazzilak_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarleaderKrazzilak_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WarleaderKrazzilak_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8199, 1, "WarleaderKrazzilak_OnCombat")
RegisterUnitEvent(8199, 2, "WarleaderKrazzilak_OnLeaveCombat")
RegisterUnitEvent(8199, 3, "WarleaderKrazzilak_OnKilledTarget")
RegisterUnitEvent(8199, 4, "WarleaderKrazzilak_OnDied")