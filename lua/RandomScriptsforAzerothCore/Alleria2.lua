local Alleria = {};

function Alleria.OnEnterCombat(event, creature, target)
	creature:RegisterEvent(Alleria.CastFD, 1, 1)
	creature:RegisterEvent(Alleria.CastRoot, 10300, 1)
	creature:RegisterEvent(Alleria.CastDisengage, 10400, 1)
	creature:RegisterEvent(Alleria.CastRapidShot, 7100, 0)
	creature:RegisterEvent(Alleria.CastMultiShot, 6100, 0)
	creature:RegisterEvent(Alleria.CastExplosiveShot, 6600, 0)
	creature:RegisterEvent(Alleria.CastBlackArrow, 15300, 0)
	creature:RegisterEvent(Alleria.CastShoot, 499, 0)
	creature:RegisterEvent(Alleria.ForceDespawn, 90000, 1)
end

function Alleria.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Alleria.OnDied(event, creature, killer)
	creature:RemoveEvents()
end

function Alleria.CastRapidShot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or creature:IsCasting(71251) then
		creature:CastSpell(victim, 71251, true)
	end
end

function Alleria.CastShoot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 39079, true)
	end
end

function Alleria.CastMultiShot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 59713, false)
	end
end

function Alleria.CastExplosiveShot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 60053, false)
	end
end

function Alleria.CastBlackArrow(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 63672, false)
	end
end

function Alleria.CastDisengage(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 57635, false)
	end
end

function Alleria.CastFD(event, delay, calls, creature)
	if not creature:IsCasting() or not creature:IsCasting(71251) then
creature:CastSpell(creature, 23604, false)
end
end

function Alleria.CastRoot(event, delay, calls, creature)
local victim = creature:GetVictim()
if not creature:IsCasting() or not creature:IsCasting(71251) then
creature:CastSpell(victim, 50762, false)
end
end

function Alleria.ForceDespawn(event, delay, calls, creature)
creature:DespawnOrUnsummon(1)
end

RegisterCreatureEvent(400021, 1, Alleria.OnEnterCombat)
RegisterCreatureEvent(400021, 2, Alleria.OnLeaveCombat)
RegisterCreatureEvent(400021, 4, Alleria.OnDied)