--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GlasshideBasilisk_OnCombat(Unit, Event)
	Unit:RegisterEvent("GlasshideBasilisk_CrystalFlash", 12000, 2)
end

function GlasshideBasilisk_CrystalFlash(Unit, Event) 
	Unit:FullCastSpellOnTarget(5106, 	Unit:GetMainTank()) 
end

function GlasshideBasilisk_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GlasshideBasilisk_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GlasshideBasilisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5419, 1, "GlasshideBasilisk_OnCombat")
RegisterUnitEvent(5419, 2, "GlasshideBasilisk_OnLeaveCombat")
RegisterUnitEvent(5419, 3, "GlasshideBasilisk_OnKilledTarget")
RegisterUnitEvent(5419, 4, "GlasshideBasilisk_OnDied")