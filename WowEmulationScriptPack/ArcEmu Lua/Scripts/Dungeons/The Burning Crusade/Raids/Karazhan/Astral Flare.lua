function Astral_Flare_Arcing_Sear(Unit, event, miscunit, misc)
	print "Astral Flare Arcing Sear"
	Unit:FullCastSpellOnTarget(30235,Unit:GetClosestPlayer())
	Unit:SendChatMessage(11, 0, "Take that...")
end

function AstralFlare_OnSpawn(unit, event, miscunit, misc)
	print "Astral_Flare"
	unit:RegisterEvent("Astral_Flare_Arcing_Sear",1000,0)
end

RegisterUnitEvent(15691,1,"AstralFlare_OnSpawn")