--[[

	Fixes:
		
		Hand of Reckoning.
		Frozen power.
		Killshot.
		Explosive shot.
		Chimera shot.
		Hungering cold.

]]--

--[[

	Bugs found:
	
		Aspect of the dragonhawk
			Doesn't add extra chance on dodge.
			
		Earth shield:
			Only gives one earthshield instead of 6 or 8.

]]--

function SpellFixes(_, plr, spellId)
	if (spellId == 62124) then -- Hand of Reckoning.
		local target = plr:GetSelection()
		local pTarget = target:GetMainTank()
		if not (pTarget:GetName() == plr:GetName()) then
			plr:CastSpellOnTarget(67485, target)
		end
	--[[elseif (spellId == frozen_shock) then -- Frost Shock.
		if (plr:HasAura(63373 or 63374) then -- Frozen power rank 1 or higher.
			local target = plr:GetSelection()
			if (plr:GetDistanceYards(target) >= 15) then
				if (plr:HasAura(63374) then -- Frozen power rank 2.
					target:CastSpell(freeze)
				elseif (plr:HasAura(63373) then -- Frozen power rank 1.
					if (math.random(2) == 1) then
						target:CastSpell(freeze)
					end	
				end	
			end
		end	]]--
	elseif (spellId == 53351) or (spellId == 61005) or (spellId == 61006) then -- Killshot.
		local target = plr:GetSelection()
		if (target:GetHealthPct() > 20) then
			plr:SendAreaTriggerMessage("|cffff0000You can't do that yet.")
			return 0;
		end	
	elseif (spellId == 53301) then -- Explosive shot.
		plr:CastSpellOnTarget(53352) -- Explosive shot, explosion.
	elseif (spellId == 53209) then -- Chimera shot.
		local target = plr:GetSelection()
		local stings = {3034,3043,1978,13549,13550,13551,13552,
			13553,13554,13555,25295,27016,49000,49001
		};
		for _, v in pairs(strings) do
			if (target:HasAura(v)) then
				target:RemoveAura(v)
				plr:CastSpellOnTarget(v, target)
			end
		end
	elseif (spellId == 49203) then -- Hungering cold.
		plr:CastSpell(51209) -- Freezing effect.
	end
end	

RegisterServerHook(10, "SpellFixes")