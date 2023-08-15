function zDoomwalkerOnCombat(pUnit, event)
	pUnit:RegisterEvent("zDoomwalker_Enrage",1000,1)
	pUnit:RegisterEvent("zDoomwalker_Earthquake",10000,0)
	pUnit:RegisterEvent("zDoomwalker_Chain_Light",17000,0)
	pUnit:RegisterEvent("zDoomwalker_Overrun",23000,0)
end

function zDoomwalkerOnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function zDoomwalkerOnKilledTarget(pUnit, event)
	local DWSpeech = math.random(1,3)
		if (DWSpeech == 1) then
			pUnit:SendChatMessage(14, 0, "Your all doomed mortals!")
		if (DWSpeech == 2) then
			pUnit:SendChatMessage(14, 0, "Futile worms!")
		if (DWSpeech == 3) then
			pUnit:SendChatMessage(14, 0, "Dead, again!")
end
end
end
end

function zDoomwalkerOnDied(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(14, 0, "For the love of, no!")
end

function zDoomwalker_Overrun(pUnit, event)
	pUnit:ClearThreatList()
	pUnit:CastSpell(32637)
	local Overrun = math.random(1,2)
		if (Overrun == 1) then
			pUnit:SendChatMessage(14, 0, "One down, two down three down, four!")
		if (Overrun == 2) then
			pUnit:SendChatMessage(12, 0, "Claw in, claw out, walk around, eat corpse..")
end
end
end


function zDoomwalker_Earthquake(pUnit, event)
	
	local X = pUnit:GetX()
	local Y = pUnit:GetY()
	local Z = pUnit:GetZ()

	pUnit:CastSpellAoF(X, Y, Z, 32686)
	local Earthquake = math.random(1,2)
		if (Earthquake == 1) then
			pUnit:SendChatMessage(14, 0, "What the, time for you to have a lesson!")
			pUnit:PlaySoundToSet()
		end
		if (Earthquake == 2) then
			pUnit:SendChatMessage(12, 0, "This is to easy.")
		end
end

function zDoomwalker_Chain_Light(pUnit, event)
	pUnit:FullCastSpellOnTarget(28167,pUnit:GetRandomPlayer(7))
end

function zDoomwalker_Enrage(pUnit, event)
	if pUnit:GetHealthPct() < 20 and Didthat == 0 then
		pUnit:FullCastSpell(34670)
		Didthat = 1
	else
	end
end

RegisterUnitEvent(2679711, 1, "zDoomwalkerOnCombat")
RegisterUnitEvent(2679711, 2, "zDoomwalkerOnLeaveCombat")
RegisterUnitEvent(2679711, 3, "zDoomwalkerOnKilledTarget")
RegisterUnitEvent(2679711, 4, "zDoomwalkerOnDied")