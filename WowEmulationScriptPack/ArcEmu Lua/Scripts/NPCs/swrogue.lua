--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SwhumanRogue_Gouge(pUnit, event)
pUnit:FullCastSpellOnTarget(28456,Unit:GetClosestPlayer(1))
pUnit:SendChatMessage(12, 0, "Sleep Tight.")
end

function SwhumanRogue_Vanish(pUnit, event)
print "Vanish"
pUnit:FullCastSpell(41476)
pUnit:SendChatMessage(12, 0, "byebye!")
end

function SwhumanRogue_OnCombat(pUnit, event)
pUnit:SendChatMessage (12, 0, "Intruder!!!")
pUnit:RegisterEvent("Rogue_Gouge",15000,0)
pUnit:RegisterEvent("Rogue_Vanish",50000,0)
end

function SwhumanRogue_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function SwhumanRogue_OnKilledTarget(pUnit, event)
pUnit:SendChatMessage(12, 0, "hehehe, Loho Seher!")
end

function SwhumanRogue_OnDied(pUnit, event)
pUnit:SendChatMessage(12, 0, "whut???!")
pUnit:RemoveEvents()
end

RegisterUnitEvent(70012, 1, "SwhumanRogue_OnCombat")
RegisterUnitEvent(70012, 2, "SwhumanRogue_OnLeaveCombat")
RegisterUnitEvent(70012, 3, "SwhumanRogue_OnKilledTarget")
RegisterUnitEvent(70012, 4, "SwhumanRogue_OnDied")


