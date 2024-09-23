local function onSpellCastRandDung(event, player, spell, skipCheck)
	if(isCorrectMap(player))then
		if(playerToSpellEffectCacheRandDung[player:GetGUIDLow()] ~= nil) then
			if(playerToSpellEffectCacheRandDung[player:GetGUIDLow()][spell:GetEntry()] ~= nil) then
				local currentSpellInfo = playerToSpellEffectCacheRandDung[player:GetGUIDLow()][spell:GetEntry()]
				local target = spell:GetTarget()
				if(currentSpellInfo[3] >= math.random(100))  then
					if(currentSpellInfo[4] == 1) then
						if(currentSpellInfo[8] == 1) then
							if(target:GetHealthPct() > currentSpellInfo[9]) then
								player:CastSpell(target,currentSpellInfo[10],true)
							end
						else
							if(target:GetHealthPct() < currentSpellInfo[9]) then
								player:CastSpell(target,currentSpellInfo[10],true)
							end
						end
					elseif(currentSpellInfo[4] == 2) then
						if(currentSpellInfo[8] == 1) then
							if(player:GetPowerPct(player:GetPowerType()) > currentSpellInfo[9]) then
								player:CastSpell(target,currentSpellInfo[10],true)
							end
						else
							if(player:GetPowerPct(player:GetPowerType()) < currentSpellInfo[9]) then
								player:CastSpell(target,currentSpellInfo[10],true)
							end
						end
					elseif(currentSpellInfo[4] == 3) then
						player:CastSpell(target,currentSpellInfo[8],true)
					elseif(currentSpellInfo[4] == 4) then
						local totalHealth = target:GetHealth() + currentSpellInfo[8] + math.random(currentSpellInfo[9])
						if(totalHealth <= 0) then
							player:CastSpell(target,7)
						else
							target:SetHealth(totalHealth)
						end
					elseif(currentSpellInfo[4] == 5) then	
						local creature = player:SpawnCreature(currentSpellInfo[8],player:GetX(),player:GetY(),player:GetZ(),player:GetO(),2,currentSpellInfo[9])
						if(currentSpellInfo[10] == 1)then
							creature:SetFaction(1)
						else
							creature:SetFaction(2)
						end
					elseif(currentSpellInfo[4] == 6) then	
						target:SetPower(math.floor(target:GetPower(target:GetPowerType())/currentSpellInfo[8]),target:GetPowerType()) 
					elseif(currentSpellInfo[4] == 7) then
						local choiceSpell = currentSpellInfo[math.random(10)+7]
						while (choiceSpell == 0) do
							choiceSpell = currentSpellInfo[math.random(10)+7]
						end
						player:CastSpell(target,choiceSpell,true)
					elseif(currentSpellInfo[4] == 8) then
						local choiceSpell = currentSpellInfo[8]
						local i = 0
						while (choiceSpell ~= 0) do
							if(choiceSpell == nil) then
								break
							end
							player:CastSpell(target,choiceSpell,true)
							i = i+1
							choiceSpell = currentSpellInfo[8+i]
						end
					elseif(currentSpellInfo[4] == 9) then
						local totalDamage = currentSpellInfo[8] + math.random(currentSpellInfo[9])
						player:DealDamage( target, totalDamage,true,currentSpellInfo[10] )
					elseif(currentSpellInfo[4] == 10) then
						if(currentSpellInfo[8] == 1) then
							if(player:GetDistance2d(target) > currentSpellInfo[9]) then
								player:CastSpell(target,currentSpellInfo[10],true)
							end
						else
							if(player:GetDistance2d(target) < currentSpellInfo[9]) then
								player:CastSpell(target,currentSpellInfo[10],true)
							end
						end
					elseif(currentSpellInfo[4] == 11) then
						player:ResetAllCooldowns()
					end
				end
			end
		end
	end
end

RegisterPlayerEvent(5,onSpellCastRandDung)