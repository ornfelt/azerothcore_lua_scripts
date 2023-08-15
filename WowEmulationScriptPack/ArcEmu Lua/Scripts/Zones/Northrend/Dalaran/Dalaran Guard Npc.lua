--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Grimgrizzle_OnCombat(Unit, Event)
	Unit:RegisterEvent("Grimgrizzle_ShootGun", 6000, 0)
end

function Grimgrizzle_ShootGun(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(61353, pUnit:GetMainTank()) 
end

function Grimgrizzle_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Grimgrizzle_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(32710, 1, "Grimgrizzle_OnCombat")
RegisterUnitEvent(32710, 2, "Grimgrizzle_OnLeaveCombat")
RegisterUnitEvent(32710, 4, "Grimgrizzle_OnDied")


--[[ 

Dalaran -- Warp Huntress Kula.lua

 
]]


function WarpHuntressKula_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarpHuntressKula_ShootGun", 6000, 0)
end

function WarpHuntressKula_ShootGun(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(61353, pUnit:GetMainTank()) 
end

function WarpHuntressKula_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarpHuntressKula_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(32711, 1, "WarpHuntressKula_OnCombat")
RegisterUnitEvent(32711, 2, "WarpHuntressKula_OnLeaveCombat")
RegisterUnitEvent(32711, 4, "WarpHuntressKula_OnDied")


--[[

Dalaran -- Horde Guards
Dalaran -- Alliance Guards

]]

local function Check(pUnit, spell)
	local P = pUnit:GetInRangeEnemies()
	if(P) then
		for _,v in ipairs(P) do
			if(v:IsPlayer() and not v:IsGm() and v:GetAreaId() == 4553 and not v:HasAura(70973) and not v:HasAura(70971) and pUnit:GetDistanceYards(v) <= 8) then
				v:CastSpell(spell)
			end
		end
	end
end

RegisterUnitEvent(29254, 18, function(pUnit) pUnit:RegisterEvent(function() Check(pUnit, 54028); end, 5000, 0); end) -- A
RegisterUnitEvent(29255, 18, function(pUnit) pUnit:RegisterEvent(function() Check(pUnit, 54029); end, 5000, 0); end) -- H