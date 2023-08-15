function Falric_OnCombat (pUnit, Event)
local chance = math.random(1,5)
	if(chance == 1) then
		pUnit:SendChatMessage(12, 0, "Men, women, and children... None were spared the master's wrath. Your death will be no different.")
	elseif(chance == 2) then
		pUnit:SendChatMessage(12, 0, "As you wish, my lord.")
	elseif(chance == 3) then
		pUnit:SendChatMessage(12, 0, "Sniveling maggot!")
	elseif(chance == 4) then
		pUnit:SendChatMessage(12, 0, "Soldiers of lordaeron, rise to meet your master's call!")
	elseif(chance == 5) then
		pUnit:SendChatMessage(12, 0, "The children of Stratholme fought with more ferocity!")
	end
	pUnit:RegisterEvent("Falric_Despair", 14000, 0)
	pUnit:RegisterEvent("Falric_Fear", 20000, 0)
	pUnit:RegisterEvent("Falric_Strike", 11000, 0)
end

function Falric_Despair (pUnit, Event)
	pUnit:CastSpellOnTarget (72426, pUnit:GetRandomPlayer(0))
	pUnit:SendChatMessage(14, 0, "Despair.. so delicious...")
end

function Falric_Fear (pUnit, Event)
	pUnit:CastSpellOnTarget (72435, pUnit:GetRandomPlayer(0))
	pUnit:SendChatMessage(14, 0, "Fear.. so exhilirating...")
end

function Falric_Strike (pUnit, Event)
	pUnit:FullCastSpellOnTarget(72422, pUnit:GetMainTank())
end

function Falric_OnDeath (pUnit, Event)
	pUnit:SendChatMessage(14, 0, "Marwyn finish them...")
	pUnit:RemoveEvents()
end

function Falric_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(38112, 1, "Falric_OnCombat")
RegisterUnitEvent(38112, 2, "Falric_OnLeaveCombat")
RegisterUnitEvent(38112, 4, "Falric_OnDeath")