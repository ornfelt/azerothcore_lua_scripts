function Adherent_OnSpawn(pUnit, Event, player)
local plr = pUnit:GetRandomPlayer(0)
local x = plr:GetX()
local y = plr:GetY()
local z = plr:GetZ()
	pUnit:MoveTo(x, y, z, o)
end

function Adherent_OnCombat (pUnit, Event)
	pUnit:RegisterEvent("Adherent_DeathChill", 5000, 0)
	pUnit:RegisterEvent("Adherent_determination", 1000, 0)
	pUnit:RegisterEvent("Adherent_Curse", 5000, 0)
end

function Adherent_DeathChill (pUnit, Event)
local Deathchill = math.random (1, 2)
	if(Deathchill == 1) then
		pUnit:FullCastSpellOnTarget(70594,pUnit:GetRandomPlayer(0))
	elseif(Deathchill == 2) then
		pUnit:FullCastSpellOnTarget(70906,pUnit:GetRandomPlayer(0))
	end
end

function Adherent_determination (pUnit, Event)
local determination = math.random (1, 6)
	if(determination == 1) then
		pUnit:CastSpell(71234)
	end
end

function Adherent_Curse (pUnit, Event)
local Curse = math.random (1, 5)
	if(Curse == 1) then
		pUnit:FullCastSpellOnTarget(71237,pUnit:GetRandomPlayer(0))
	end
end


function Adherent_OnLeaveCombat (pUnit, Event)
	pUnit:CastSpell(70903)
	pUnit:RemoveEvents()
	pUnit:RemoveAuras()
end

function Adherent_OnDeath (pUnit, Event)
	pUnit:CastSpell(70903)
	pUnit:RemoveEvents()
	pUnit:RemoveAuras()
end

RegisterUnitEvent(37949, 1, "Adherent_OnCombat")
RegisterUnitEvent(37949, 18, "Adherent_OnSpawn")
RegisterUnitEvent(37949, 2, "Adherent_OnLeaveCombat")
RegisterUnitEvent(37949, 4, "Adherent_OnDeath")