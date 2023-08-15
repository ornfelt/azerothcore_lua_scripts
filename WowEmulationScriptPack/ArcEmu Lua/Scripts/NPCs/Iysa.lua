--yiera--

function Iysa_OnCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "I will not fall to such inferior beings! Wyrnn will not have his vengance!")
pUnit:RegisterEvent("Iysa_Spell1", 5000, 900)
pUnit:RegisterEvent("Iysa_Spell2", 9000, 3)
pUnit:RegisterEvent("Iysa_Spell3", 14000, 70)
end

function Iysa_Spell1(pUnit, event)
pUnit:FullCastSpellOnTarget(66963, pUnit:GetRandomPlayer(0))
end

function Iysa_Spell2(pUnit, event)
pUnit:CastSpell(69963)
end

function Iysa_Spell3(pUnit, event)
pUnit:FullCastSpellOnTarget(29522, pUnit:GetRandomPlayer(0))
end

function Iysa_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function Iysa_OnKilledTarget(pUnit, event)
pUnit:SendChatMessage(14, 0, "I will destory all of Stormwind! It is my destiny!")
end

function Iysa_OnDied(pUnit, event)
pUnit:SendChatMessage(12, 0, "I should have known...Wrynn would find....a way...")
pUnit:RemoveEvents()
end

RegisterUnitEvent(100107, 1, "Iysa_OnCombat")
RegisterUnitEvent(100107, 2, "Iysa_OnLeaveCombat")
RegisterUnitEvent(100107, 3, "Iysa_OnKilledTarget")
RegisterUnitEvent(100107, 4, "Iysa_OnDied")