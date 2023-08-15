function Fanatic_OnSpawn(pUnit, Event, player)
local plr = pUnit:GetRandomPlayer(0)
local x = plr:GetX()
local y = plr:GetY()
local z = plr:GetZ()
	pUnit:MoveTo(x, y, z, o)
end

function Fanatic_OnCombat (pUnit, Event)
	pUnit:RegisterEvent("Fanatic_Attack ",5000, 0)
	pUnit:RegisterEvent("Fanatic_determination", 3000, 0)
end

function Fanatic_Attack (pUnit, Event)
local Deathchill = math.random (1, 2)
	if(Deathchill == 1) then
		pUnit:FullCastSpellOnTarget(70659,pUnit:GetRandomPlayer(0))
	elseif(Deathchill == 2) then
		pUnit:FullCastSpellOnTarget(70906,pUnit:GetRandomPlayer(0))
	end
end

function Fanatic_determination (pUnit, Event)
local determination = math.random (1, 12)
	if(determination == 1) then
		pUnit:CastSpell(71235)
	elseif(determination == 2)then
		pUnit:CastSpell(70900)
	elseif(determination == 3 )then
		pUnit:CastSpell(70674)
	end
end

function Fanatic_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:RemoveAuras()
end

function Fanatic_OnDeath (pUnit, Event)
	pUnit:CastSpell(70903)
	pUnit:RemoveEvents()
	pUnit:RemoveAuras()
end

RegisterUnitEvent(37890, 18, "Fanatic_OnSpawn")
RegisterUnitEvent(37890, 1, "Fanatic_OnCombat")
RegisterUnitEvent(37890, 2, "Fanatic_OnLeaveCombat")
RegisterUnitEvent(37890, 4, "Fanatic_OnDeath")