--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Claximus_OnCombat(Unit, Event)
Unit:RegisterEvent("Claximus_ArcaneBarrage", 8000, 0)
Unit:RegisterEvent("Claximus_StabilizedMagic", 2000, 1)
end

function Claximus_ArcaneBarrage(Unit, Event) 
Unit:FullCastSpellOnTarget(50273, Unit:GetMainTank()) 
end

function Claximus_StabilizedMagic(Unit, Event) 
Unit:CastSpell(50275) 
end

function Claximus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Claximus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Claximus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25209, 1, "Claximus_OnCombat")
RegisterUnitEvent(25209, 2, "Claximus_OnLeaveCombat")
RegisterUnitEvent(25209, 3, "Claximus_OnKilledTarget")
RegisterUnitEvent(25209, 4, "Claximus_OnDied")