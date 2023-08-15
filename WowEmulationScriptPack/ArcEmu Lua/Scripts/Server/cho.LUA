--Lord Chronic--

function Cho_OnCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "I will not fall to such inferior beings! DIE!!!!")
pUnit:RegisterEvent("Cho_Spell1", 5000, 900)
pUnit:RegisterEvent("Cho_Spell2", 9000, 3)
pUnit:RegisterEvent("Cho_Spell3", 14000, 70)
end

function Cho_Spell1(pUnit, event)
pUnit:FullCastSpellOnTarget(60871, pUnit:GetRandomPlayer(0))
end

function Cho_Spell2(pUnit, event)
pUnit:CastSpell(69963)
end

function Cho_Spell3(pUnit, event)
pUnit:FullCastSpellOnTarget(29522, pUnit:GetRandomPlayer(0))
end

function Cho_OnLeaveCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "Run...Forest...Run...")
pUnit:RemoveEvents()
end

function Cho_OnKilledTarget(pUnit, event)
pUnit:SendChatMessage(14, 0, "I will destroy all of ac-web...")
end

function Cho_OnDied(pUnit, event)
pUnit:SendChatMessage(12, 0, "Ahh I should of know you are ...too...STRONG!!!...")
pUnit:RemoveEvents()
end

RegisterUnitEvent(200034, 1, "Cho_OnCombat")
RegisterUnitEvent(200034, 2, "Cho_OnLeaveCombat")
RegisterUnitEvent(200034, 3, "Cho_OnKilledTarget")
RegisterUnitEvent(200034, 4, "Cho_OnDied")