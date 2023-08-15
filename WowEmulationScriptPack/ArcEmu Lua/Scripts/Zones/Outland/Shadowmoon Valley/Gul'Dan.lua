function Guldan_Channel(Unit, Event)
	Unit:RemoveEvents()
	Unit:CastSpell(35996)
end

function Guldan_Start(Unit, Event)
	Unit:RegisterEvent("Guldan_Channel", 1000, 0)
end

RegisterUnitEvent(17008, 6, "Guldan_Start")