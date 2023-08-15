--yiera--

function Brook_OnCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "All will bear the scar of my blade!")
pUnit:RegisterEvent("Brook_Spell1", 7000, 900)
end

function Brook_Spell1(pUnit, event)
pUnit:FullCastSpellOnTarget(61903, pUnit:GetRandomPlayer(7))
end

function Brook_Spell2(pUnit, event)
pUnit:FullCastSpellOnTarget(68025, pUnit:GetRandomPlayer(7))
end

function Brook_OnLeaveCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "To scared to face me?!")
pUnit:RemoveEvents()
end

function Brook_OnDied(pUnit, event)
pUnit:SendChatMessage(13, 0, "I never knew it would come to this...AHHH")
pUnit:RemoveEvents()
end

RegisterUnitEvent(100106, 1, "Brook_OnCombat")
RegisterUnitEvent(100106, 2, "Brook_OnLeaveCombat")
RegisterUnitEvent(100106, 3, "Brook_OnDied")