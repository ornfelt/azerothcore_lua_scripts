local Sylvanas = {};

function Sylvanas.OnEnterCombat(event, creature, target)
	creature:RegisterEvent(Sylvanas.CastRapidShot, 7100, 0)
	creature:RegisterEvent(Sylvanas.CastMultiShot, 6100, 0)
	creature:RegisterEvent(Sylvanas.CastExplosiveShot, 6600, 0)
	creature:RegisterEvent(Sylvanas.CastBlackArrow, 15300, 0)
	creature:RegisterEvent(Sylvanas.CastShoot, 499, 0)
end

function Sylvanas.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Sylvanas.OnDied(event, creature, killer)
	creature:RemoveEvents()
end

function Sylvanas.CastRapidShot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or creature:IsCasting(71251) then
		creature:CastSpell(victim, 71251, true)
	end
end

function Sylvanas.CastShoot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 39079, true)
	end
end

function Sylvanas.CastMultiShot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 59713, true)
	end
end

function Sylvanas.CastExplosiveShot(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 60053, true)
	end
end

function Sylvanas.CastBlackArrow(event, delay, calls, creature)
	local victim = creature:GetVictim()
	if not creature:IsCasting() or not creature:IsCasting(71251) then
		creature:CastSpell(victim, 63672, true)
	end
end

function Sylvanas.OnSpawn(event, creature)
creature:SendUnitSay("Hello Thrall. You didn't think I'd let you have all the fun, did you?", 0)
creature:CastSpell(creature, 51908, true)
end

function Sylvanas.OnHealthCheck(event, creature, attacker, damage)
if (creature:GetHealth() - damage) <= 15 then
creature:RegisterEvent(Sylvanas.Shadowstep, 4800, 1)
end
end

function Sylvanas.Shadowstep(event, delay, calls, creature)
creature:CastSpell(creature, 51908, true)
creature:CastSpell(creature, 58984, true)
creature:SendUnitYell("Thrall...I must be going. Hopefully I thinned enough of the scourge forces for you...now you can handle the rest.", 0)
creature:DespawnOrUnsummon(5000)
end

RegisterCreatureEvent(400071, 9, Sylvanas.OnHealthCheck)
RegisterCreatureEvent(400071, 5, Sylvanas.OnSpawn)
RegisterCreatureEvent(400071, 1, Sylvanas.OnEnterCombat)
RegisterCreatureEvent(400071, 2, Sylvanas.OnLeaveCombat)
RegisterCreatureEvent(400071, 4, Sylvanas.OnDied)
