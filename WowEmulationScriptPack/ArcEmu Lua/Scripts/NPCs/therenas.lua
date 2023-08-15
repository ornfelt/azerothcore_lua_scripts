function Therenas_Phase1(Unit, event)
	if Unit:GetHealthPct() < 72 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "YOUR ASS WILL SUFFER SOME PAIN!")
		Unit:CastSpell(20594)
		Unit:RegisterEvent("Therenas_Strike",6000, 0)
		Unit:RegisterEvent("Therenas_Phase2",1000, 0)
	end
end

function Therenas_Strike(Unit)
	Unit:CastSpell(3130)
end

function Therenas_Phase2(Unit, event)
	if Unit:GetHealthPct() < 62 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "CHARGE!!!!")
		Unit:CastSpell(31715)
		Unit:RegisterEvent("Therenas_charge",8000, 0)
		Unit:RegisterEvent("Therenas_Phase3",1000, 0)
	end
end

function Therenas_charge(Unit)
	Unit:CastSpell(31715)
end

function Therenas_Phase3(Unit, event)
	if Unit:GetHealthPct() < 52 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "EAT this!")
		Unit:CastSpell(36981)
		Unit:RegisterEvent("Therenas_spin",10000, 0)
		Unit:RegisterEvent("Therenas_Phase4",1000, 0)
	end
end

function Therenas_spin(Unit)
	Unit:CastSpell(36981)
end

function Therenas_Phase4(Unit, event)
	if Unit:GetHealthPct() <= 26 then
		Unit:RemoveEvents()
		Unit:SetCombatCapable(1)
		Unit:SetScale(4)
		Unit:CastSpell(18501)
		Unit:SendChatMessage(14, 0, "HEY FUCKER!")
		Unit:RegisterEvent("Therenas_shoop",7000, 0)
	end
end

function Therenas_shoop(Unit, event)
	Unit:RemoveEvents()
	Unit:SetScale(3)
	Unit:CastSpell(37433)
	Unit:SetCombatCapable(0)
	Unit:SendChatMessage(14, 0, "SHOPPY SHOPPY!")
end

function Therenas_OnCombat(Unit, event)
	Unit:SendChatMessage(14, 0, "HOW DARE YOU ENTER HOME OF ME AND THIR'HALY???!")
	Unit:RegisterEvent("Therenas_Phase1",1000, 0)
	Unit:RegisterEvent("Therenas_Strike",6000, 0)
end

function Therenas_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Therenas_OnKilledTarget(Unit)
	Unit:SendChatMessage(11, 0, "Your ass belongs to me now!")
	Unit:CastSpell(36981)
end

function Therenas_Death(Unit)
	Unit:SendChatMessage(14, 0, "NOOO, BEATEN BYA A N00B")
	Unit:RemoveEvents()
end

RegisterUnitEvent(353501, 1, "Therenas_OnCombat")
RegisterUnitEvent(353501, 2, "Therenas_OnLeaveCombat")
RegisterUnitEvent(353501, 3, "Therenas_OnKilledTarget")
RegisterUnitEvent(353501, 4, "Therenas_Death")