--[[ Kaz'Rogal.Lua - Author: Shorts
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

function Kaz_OnCombat(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Cry for mercy! Your meaningless lives will soon be forfeit.")
	pUnit:PlaySoundToSet(11015)
	pUnit:RegisterEvent("KazAttacks", 1000, 0)
end

function Kaz_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function Kaz_OnKilledTarget(pUnit, event)
	local KazSpeech = math.random(1, 2)
	if (KazSpeech == 1) then
		pUnit:SendChatMessage(14, 0, "Your death will be a painful one.")
		pUnit:PlaySoundToSet(11016)
	elseif (KazSpeech == 2) then
		pUnit:SendChatMessage(14, 0, "You... are marked.")
		pUnit:PlaySoundToSet(11052)
	end
end

function Kaz_OnDeath(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Hahahahaa aahaah!")
	pUnit:PlaySoundToSet(11018)
end

function KazAttacks(pUnit, event)
	pUnit:RegisterEvent("KazCleave", math.random(30000, 60000), 0)
	pUnit:RegisterEvent("KazMOKR", math.random(30000, 60000), 0)
	pUnit:RegisterEvent("KazStomp", math.random(25000, 45000), 0)
	pUnit:RegisterEvent("KazDispel", math.random(30000, 60000), 0)
end

function KazCleave(pUnit, event)
	pUnit:CastSpellOnTarget(31345, pUnit:GetMainTank())
end

function KazMOKR(pUnit, event)
	local KazMOKRSpeech = math.random(1,2)
	if (KazMOKRSpeech == 1) then
		pUnit:SendChatMessage(14, 0, "You... are nothing!")
		pUnit:PlaysoundToSet(11053)
		pUnit:CastSpellOnTarget(31447, pUnit:GetInRangePlayers())
	elseif (KazMOKRSpeech == 2) then
		pUnit:SendChatMessage(14, 0, "Miserable nuisance!")
		pUnit:PlaySoundToSet(11054)
		pUnit:CastSpellOnTarget(31447, pUnit:GetInRangePlayers())
	end
end

function KazStomp(pUnit, event)
	pUnit:CastSpell(31408)
end

function KazDispel(pUnit, event)
	pUnit:CastSpellOnTarget(43577, pUnit:GetRandomPlayer(0))
end

RegisterUnitEvent(17888, 1, "Kaz_OnCombat")
RegisterUnitEvent(17888, 2, "Kaz_OnLeaveCombat")
RegisterUnitEvent(17888, 3, "Kaz_OnKilledTarget")
RegisterUnitEvent(17888, 4, "Kaz_OnDeath")