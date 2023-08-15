function DDPeon_Spell(Unit, Event)
	Unit:RemoveEvents()
	Unit:CastSpell(40732)
	Unit:RegisterEvent("DDPeon_Spell2", 10000, 0)
end

function DDPeon_Spell2(Unit, Event)
	Unit:RemoveEvents()
	Unit:CastSpell(40735)
	Unit:RegisterEvent("DDPeon_Spell3", 20000, 0)
end

function DDPeon_Spell3(Unit, Event)
	Unit:RemoveEvents()
	Unit:CastSpell(40714)
	Unit:RegisterEvent("DDPeon_Spell1", 30000, 0)
end

function DDPeon_Start(Unit, Event)
	Unit:RegisterEvent("DDPeon_Spell", 1000, 0)
end

RegisterUnitEvent(21316, 6, "DDPeon_Start")