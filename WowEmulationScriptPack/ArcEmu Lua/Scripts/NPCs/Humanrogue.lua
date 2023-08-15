function HumanRogue_Gouge(pUnit, event)
pUnit:FullCastSpellOnTarget(28456,Unit:GetClosestPlayer(1))
pUnit:SendChatMessage(12, 0, "hehehe.")
end

function HumanRogue_Vanish(pUnit, event)
print "Vanish"
pUnit:FullCastSpell(41476)
pUnit:SendChatMessage(12, 0, "Now your dead!")
end

function HumanRogue_OnCombat(pUnit, event)
pUnit:SendChatMessage (12, 0, "Intruder!!!")
pUnit:RegisterEvent("Rogue_Gouge",15000,0)
pUnit:RegisterEvent("Rogue_Vanish",50000,0)
end

function HumanRogue_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function HumanRogue_OnKilledTarget(pUnit, event)
pUnit:SendChatMessage(12, 0, "hehehe, owned!")
end

function HumanRogue_OnDied(pUnit, event)
pUnit:SendChatMessage(12, 0, "This can't be!")
pUnit:RemoveEvents()
end

RegisterUnitEvent(65015, 1, "HumanRogue_OnCombat")
RegisterUnitEvent(65015, 2, "HumanRogue_OnLeaveCombat")
RegisterUnitEvent(65015, 3, "HumanRogue_OnKilledTarget")
RegisterUnitEvent(65015, 4, "HumanRogue_OnDied")


