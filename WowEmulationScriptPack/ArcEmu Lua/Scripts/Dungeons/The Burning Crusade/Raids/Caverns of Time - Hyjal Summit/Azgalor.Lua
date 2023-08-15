--[[ Azgalor.Lua - Author: Shorts
********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, April 15, 2008. ]]

function Az_OnCombat(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Abandon all hope! The legion has returned to finish what was begun so many years ago. This time there will be no escape!")
	pUnit:PlaySoundToSet(10999)
	pUnit:RegisterEvent("AzAttacks", 1000, 0)
	pUnit:CastSpell(31344)
end

function Az_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function Az_OnKilledTarget(pUnit, event)
	local AzSpeech = math.random(1,3)
	if (AzSpeech == 1) then
		pUnit:SendChatMessage(14, 0, "Reesh, hokta!")
		pUnit:PlaySoundToSet(11001)
	elseif (AzSpeech == 2) then
		pUnit:SendChatMessage(14, 0, "No one is going to save you!")
		pUnit:PlaySoundToSet(11047)
	elseif (AzSpeech == 3) then
		pUnit:SendChatMessage(14, 0, "Don't fight it!")
		pUnit:PlaySoundToSet(11048)
	end
end

function Az_OnDeath(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Your time is almost... up!")
	pUnit:PlaySoundToSet(11002)
end

function AzAttacks(pUnit, event)
	pUnit:RegisterEvent("AzCleave", math.random(30000, 60000), 0)
	pUnit:RegisterEvent("AzRoF", math.random(30000, 60000), 0)
	pUnit:RegisterEvent("AzHowl", math.random(15000, 20000), 0)
	pUnit:RegisterEvent("AzDoom", math.random(45000, 50000), 0)
end

function AzCleave(pUnit, event)
	pUnit:CastSpellOnTarget(31345, pUnit:GetMainTank())
end

function AzRoF(pUnit, event)
	if (pUnit:GetRandomPlayer(0) ~= nil) then
		local pUnit = pUnit:GetRandomPlayer(0)
		local x = pUnit:GetX()
		local y = pUnit:GetY()
		local z = pUnit:GetZ()
			
		pUnit:CastSpellAoF(x, y, z, 31340)
	end
end

function AzHowl(pUnit, event)
	pUnit:CastSpell(31344)
end

function AzDoom(pUnit, event)
	pUnit:CastSpell(31347, pUnit:GetRandomTarget(7))
	local AzDoomSpeech = math.random(1,2)
		if (AzDoomSpeech == 1) then
			pUnit:SendChatMessage(14, 0, "Just a taste... of what awaits you.")
			pUnit:PlaySoundToSet()
		if (AzDoomSpeech == 2) then
			pUnit:SendChatMessage(14, 0, "Suffer you dispicable insect!")
			pUnit:PlaySoundToSet()
		end
	end
end
	
RegisterUnitEvent(17842, 1, "Az_OnCombat")
RegisterUnitEvent(17842, 2, "Az_OnLeaveCombat")
RegisterUnitEvent(17842, 3, "Az_OnKilledTarget")
RegisterUnitEvent(17842, 4, "Az_OnDeath")