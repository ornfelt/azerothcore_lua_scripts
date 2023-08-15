function Marwyn_OnCombat (pUnit, Event)
local chance = math.random(1,5)
	if(chance == 1) then
		pUnit:SendChatMessage(12, 0, "As you wish, my lord.")
	elseif(chance == 2) then
		pUnit:SendChatMessage(12, 0, "The master surveyed his kingdom and fount it... Lacking. His judgement was swift and without mercy: DEATH TO ALL!")
	elseif(chance == 3) then
		pUnit:SendChatMessage(12, 0, "Death is all that you will find here!")
	elseif(chance == 4) then
		pUnit:SendChatMessage(12, 0, "Waste away into nothingness!")
	elseif(chance == 5) then
		pUnit:SendChatMessage(12, 0, "I saw the same look in his eyes when he died. Terenas could hardly believe it.")
	end
	pUnit:RegisterEvent("Marwyn_Obliterate", 16000, 0)
	punit:RegisterEvent("Marwyn_Shared", 20000, 0)
	punit:RegisterEvent("Marwyn_Well", 24000, 0)
	pUnit:RegisterEvent("Marwyn_Flesh", 18000, 0)
end

function Marwyn_Obliterate (pUnit, Event)
	pUnit:FullCastSpellOnTarget(72360, pUnit:GetMainTank())
end

function Marwyn_Shared (pUnit, Event)
	pUnit:FullCastSpellOnTarget (72368, pUnit:GetRandomPlayer(0))
	pUnit:SendChatMessage(12, 0, "Choke On Your Suffering!")
end

function Marwyn_Well (pUnit, Event)
	pUnit:FullCastSpellOnTarget (72362, pUnit:GetRandomPlayer(0))
end

function Marwyn_Flesh (pUnit, Event)
	pUnit:FullCastSpellOnTarget (72363, pUnit:GetRandomPlayer(0))
	pUnit:SendChatMessage(12, 0, "Your flesh shall decay before your very eyes!")
end

function Marwyn_OnDeath (pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Yes... Run... Run... to meet your destiny... Its bitter, cold embrace, awaits you.")
	pUnit:RemoveEvents()
end

function Marwyn_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(38113, 1, "Marwyn_OnCombat")
RegisterUnitEvent(38113, 2, "Marwyn_OnLeaveCombat")
RegisterUnitEvent(38113, 4, "Marwyn_OnDeath")