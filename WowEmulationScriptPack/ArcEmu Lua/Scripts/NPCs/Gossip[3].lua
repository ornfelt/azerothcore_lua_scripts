function Demonoid_OnSpawn(pUnit, event)
	pUnit:SetLevel(83)
	pUnit:SetUInt32Value(UNIT_FIELD_MINDAMAGE, 1000)
	pUnit:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, 3000)
	pUnit:SetFaction(15)
	pUnit:SetMaxHealth(120000)
	pUnit:SetHealth(120000)
end

RegisterUnitEvent(22028, 18, "Demonoid_OnSpawn")