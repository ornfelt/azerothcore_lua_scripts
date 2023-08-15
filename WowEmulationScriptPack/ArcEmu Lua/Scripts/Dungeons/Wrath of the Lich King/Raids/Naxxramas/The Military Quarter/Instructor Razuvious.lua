function InstructorRazuvious_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Haha! I am just getting warmed up!")
pUnit:RegisterEvent("InstructorRazuvious_DisruptingShout", 60000, 0)
pUnit:RegisterEvent("InstructorRazuvious_Obilterate", 5000, 0)
pUnit:RegisterEvent("InstructorRazuvious_IcyTouch", 9000, 0)
end

function InstructorRazuvious_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function InstructorRazuvious_OnKillTarget(pUnit, Event)
end

function InstructorRazuvious_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(16061, 1, "InstructorRazuvious_OnCombat")
RegisterUnitEvent(16061, 2, "InstructorRazuvious_OnLeaveCombat")
RegisterUnitEvent(16061, 3, "InstructorRazuvious_OnKillTarget")
RegisterUnitEvent(16061, 4, "InstructorRazuvious_OnDeath")

function InstructorRazuvious_DisruptingShout(pUnit, Event)
pUnit:CastSpell(29107)
end

function InstructorRazuvious_Obilterate(pUnit, Event)
pUnit:FullCastSpellOnTarget(51425, pUnit:GetMainTank())
end

function InstructorRazuvious_IcyTouch(pUnit, Event)
pUnit:FullCastSpellOnTarget(55331, pUnit:GetMainTank())
end
