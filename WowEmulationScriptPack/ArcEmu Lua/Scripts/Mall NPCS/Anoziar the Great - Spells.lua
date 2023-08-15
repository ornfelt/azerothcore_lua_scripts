function AnoziartheGreat_Deathcoil(Unit)
	Unit:CastSpell(35954)
end

function AnoziartheGreat_Forkedlightning(Unit)
	Unit:CastSpell(40088)
end

function AnoziartheGreat_Consecration(Unit)
	Unit:CastSpell(36946)
end

function AnoziartheGreat_OnCombat(Unit, Event)
	Unit:SendChatMessage (11, 0, "You should have never came!")
	Unit:RegisterEvent("AnoziartheGreat_Deathcoil",17000, 0)
	Unit:RegisterEvent("AnoziartheGreat_Forkedlightning",20000, 0)
	Unit:RegisterEvent("AnoziartheGreat_Consecration",30000, 0)
end

RegisterUnitEvent(800005, 1, "AnoziartheGreat_OnCombat")
