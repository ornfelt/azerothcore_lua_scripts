function Kthals_Eternal_Affection(Unit, event, miscunit, misc)
	print "Kthals Eternal Affection"
	Unit:FullCastSpell(30878)
	Unit:SendChatMessage(11, 0, "HEAL...")
end

function Kthals_Powerful_Attraction(Unit, event, miscunit, misc)
	print "Kthals Powerful Attraction"
	Unit:FullCastSpellOnTarget(30889,Unit:GetClosestPlayer())
	Unit:SendChatMessage(11, 0, "You love me...HOooo...")
end

function Kthals_Blinding_Passion(Unit, event, miscunit, misc)
	print "Kthals Blinding Passion"
	Unit:FullCastSpellOnTarget(30890,Unit:GetClosestPlayer())
	Unit:SendChatMessage(11, 0, "Some passion...")
end

function Kthals_Devotion(Unit, event, miscunit, misc)
	print "Kthals Devotion"
	Unit:FullCastSpell(30887)
	Unit:SendChatMessage(11, 0, "I will kill you...")
end

function Kthals(unit, event, miscunit, misc)
	print "Kthals"
	unit:RegisterEvent("Kthals_Eternal_Affection",10000,0)
	unit:RegisterEvent("Kthals_Powerful_Attraction",15000,0)
	unit:RegisterEvent("Kthals_Blinding_Passion",20000,0)
	unit:RegisterEvent("Kthals_Devotion",25000,0)
end

RegisterUnitEvent(70001,1,"Kthals")