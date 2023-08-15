function DInfernal_Yell(Unit, Event)
	Unit:RemoveEvents()
	Unit:CastSpell(36658)
end

function DInfernal_Start(Unit, Event)
	Unit:RegisterEvent("DInfernal_Yell", 1000, 0)
end

RegisterUnitEvent(21316, 6, "DInfernal_Start")