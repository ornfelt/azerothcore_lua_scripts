--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitherbarkWitchDoctor_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("HealingWard",1000,1)
	Unit:RegisterEvent("MagmaTotem",8000,0)
end

function HealingWard(Unit,Event)
	if Unit:GetHealthPct() <= 29 then
		Unit:CastSpell(5605)
	end
end

function MagmaTotem(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local Totem = Unit:GetCreatureNearestCoords(X,Y,Z,8190)
	if (Totem ~= nil) then
		Unit:CastSpell(8190)
	else
		return
	end
end

function WitherbarkWitchDoctor_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function WitherbarkWitchDoctor_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2605,1,"WitherbarkWitchDoctor_OnEnterCombat")
RegisterUnitEvent(2605,2,"WitherbarkWitchDoctor_OnLeaveCombat")
RegisterUnitEvent(2605,4,"WitherbarkWitchDoctor_OnDied")