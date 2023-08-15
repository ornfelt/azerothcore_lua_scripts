function tormentorofold_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "Im going to make your intestines bleed!")
		Unit:RegisterEvent("AxeThrow", 25000, 0)
		Unit:RegisterEvent("GutRip", 12000, 0)
		Unit:RegisterEvent("Frenzy", 1000, 1)
end

function AxeThrow(Unit, Event)
	Unit:FullCastSpellOnTarget(42359, Unit:GetRandomPlayer(0))
end

function GutRip(Unit, Event)
	Unit:FullCastSpellOnTarget(52401, Unit:GetClosestPlayer(0))
end

function Frenzy(Unit, Event)
	if Unit:GetHealthPct() <= 40 then
		Unit:RemoveEvents()
		Unit:CastSpell(54124)
end
end

function tormentorofold_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function tormentorofold_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "Ill make a pelt out of your flesh!")
end

function tormentorofold_OnDied(Unit, Event)
		Unit:RemoveEvents()
end

RegisterUnitEvent(700009,1,"tormentorofold_OnCombat")
RegisterUnitEvent(700009,2,"tormentorofold_OnLeaveCombat")
RegisterUnitEvent(700009,3,"tormentorofold_OnKilledTarget")
RegisterUnitEvent(700009,4,"tormentorofold_OnDied")