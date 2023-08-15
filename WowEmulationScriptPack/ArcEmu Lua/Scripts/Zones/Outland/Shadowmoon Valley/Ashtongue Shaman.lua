function AshtongueShaman_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("AshtongueShaman_Bloodlust", 60000, 0)
	Unit:RegisterEvent("AshtongueShaman_LightningShield", 60000, 0)
end

function AshtongueShaman_Bloodlust(Unit,Event)
	Unit:CastSpell(37067)
end

function AshtongueShaman_LightningShield(Unit,Event)
	Unit:CastSpell(12550)
end

function AshtongueShaman_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function AshtongueShaman_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21453, 1, "AshtongueShaman_OnEnterCombat")
RegisterUnitEvent (21453, 2, "AshtongueShaman_OnLeaveCombat")
RegisterUnitEvent (21453, 4, "AshtongueShaman_OnDied")