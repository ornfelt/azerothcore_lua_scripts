--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MinorManifestationofFire_OnCombat(Unit, Event)
	Unit:RegisterEvent("MinorManifestationofFire_FireShield", 1000, 1)
	Unit:RegisterEvent("MinorManifestationofFire_FlameShock", 8000, 0)
end

function MinorManifestationofFire_FireShield(Unit, Event) 
	Unit:CastSpell(134) 
end

function MinorManifestationofFire_FlameShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(8050, 	Unit:GetMainTank()) 
end

function MinorManifestationofFire_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MinorManifestationofFire_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function MinorManifestationofFire_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5893, 1, "MinorManifestationofFire_OnCombat")
RegisterUnitEvent(5893, 2, "MinorManifestationofFire_OnLeaveCombat")
RegisterUnitEvent(5893, 3, "MinorManifestationofFire_OnKilledTarget")
RegisterUnitEvent(5893, 4, "MinorManifestationofFire_OnDied")