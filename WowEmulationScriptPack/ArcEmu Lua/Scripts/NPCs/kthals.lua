function Kthals_Rust(Unit, event, miscunit, misc)
	print "Rust"
	Unit:FullCastSpellOnTarget(31086,Unit:GetClosestPlayer())
	Unit:SendChatMessage(11, 0, "Ho, some rust...")
end

function Kthals_Cleave(Unit, event, miscunit, misc)
	print "Cleave"
	Unit:FullCastSpellOnTarget(39174,Unit:GetClosestPlayer())
	Unit:SendChatMessage(11, 0, "Cleave...")
end

function Kthals(unit, event, miscunit, misc)
	print "Kthals"
	unit:RegisterEvent("Kthals_Rust",5000,0)
	unit:RegisterEvent("Kthals_Cleave",10000,0)
end

RegisterUnitEvent(70000,1,"Kthals")