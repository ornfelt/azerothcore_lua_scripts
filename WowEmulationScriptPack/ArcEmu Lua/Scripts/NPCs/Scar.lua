--yiera--

function Scar_OnCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "All will bear the scar of my blade!")
pUnit:RegisterEvent("Scar_Spell1", 2500, 900)
pUnit:RegisterEvent("Scar_Spell2", 20000, 1)
end

function Scar_Spell1(pUnit, event)
pUnit:FullCastSpellOnTarget(66963, pUnit:GetRandomPlayer(7))
end

function Scar_Spell2(pUnit, event)
pUnit:CastSpell(34186)
end

function Scar_OnLeaveCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "To scared to face me?!")
pUnit:RemoveEvents()
end

function Scar_OnKilledTarget(pUnit, event)
pUnit:SendChatMessage(14, 0, "I knew you'd fall, they all do!")
end

function Scar_OnDied(pUnit, event)
pUnit:SendChatMessage(13, 0, "I never knew it would come to this...")
pUnit:RemoveEvents()
end

RegisterUnitEvent(100105, 1, "Scar_OnCombat")
RegisterUnitEvent(100105, 2, "Scar_OnLeaveCombat")
RegisterUnitEvent(100105, 3, "Scar_OnKilledTarget")
RegisterUnitEvent(100105, 4, "Scar_OnDied")