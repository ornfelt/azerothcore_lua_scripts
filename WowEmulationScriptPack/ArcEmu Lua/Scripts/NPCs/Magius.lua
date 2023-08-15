function Magius_Cyclone(Unit)
	Unit:FullCastSpellOnTarget(33786,Unit:GetRandomPlayer(1))
	Unit:SendChatMessage(12, 0, "STAY THERE PUNK!!!")
end

function Magius_Forkedlightning(Unit)
	Unit:SetScale(2)
	Unit:CastSpell(40088)
	Unit:SendChatMessage(12, 0, "Let My Lightning Strike You!!!")
end

function Magius_Corrosivepoison(Unit)
	Unit:SetScale(1)
	Unit:CastSpell(36694)
	Unit:SendChatMessage(12, 0, "Let See how you handle This Infection...")
end

function Magius_Consecration(Unit)
	Unit:SetScale(1)
	Unit:CastSpell(36946)
	Unit:SendChatMessage(12, 0, "Here, Feel my Wrath")
end

function Magius_OnCombat(Unit, Event)
	Unit:SendChatMessage (12, 0, "HOW DARE YOU ENTER OUR NEW HOME!!!")
	Unit:RegisterEvent("Magius_Cyclone",20000, 0)
	Unit:RegisterEvent("Magius_Forkedlightning",30000, 0)
	Unit:RegisterEvent("Magius_Corrosivepoison",40000, 0)
	Unit:RegisterEvent("Magius_Consecration",50000, 0)
end

function Magius_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Magius_OnKilledTarget(Unit)
	Unit:SendChatMessage(12, 0, "HAH, I knew you was a N00b! Now, Your Team members will feel my Powah!!!")
	Unit:CastSpell(36981)
end

function Magius_OnDied(Unit)
	Unit:SendChatMessage(12, 0, "You May have defeated me, But my Slaves will Revenge me....")
	Unit:FullCastSpell(35285)
	Unit:FullCastSpell(35286)
	Unit:FullCastSpell(35287)
	Unit:FullCastSpell(35288)
	Unit:RemoveEvents()
end

RegisterUnitEvent(353500, 1, "Magius_OnCombat")
RegisterUnitEvent(353500, 2, "Magius_OnLeaveCombat")
RegisterUnitEvent(353500, 3, "Magius_OnKilledTarget")
RegisterUnitEvent(353500, 4, "Magius_OnDied")


