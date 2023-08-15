function Grobbulus_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "I think I heard something... Birds in the church! Me be smashin' birds tonite!")
pUnit:RegisterEvent("Grobbulus_PoisonCloud", 125000, 0)
pUnit:RegisterEvent("Grobbulus_SlimeSpray", 125000, 0)
pUnit:RegisterEvent("Grobbulus_MutatingInjection", 30000, 0)
pUnit:RegisterEvent("Grobbulus_SlimeStream", 30000, 0)
end

function Grobbulus_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Grobbulus_OnKillTarget(pUnit, Event)
end

function Grobbulus_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15931, 1, "Grobbulus_OnCombat")
RegisterUnitEvent(15931, 2, "Grobbulus_OnLeaveCombat")
RegisterUnitEvent(15931, 3, "Grobbulus_OnKillTarget")
RegisterUnitEvent(15931, 4, "Grobbulus_OnDeath")

function Grobbulus_PoisonCloud(pUnit, Event)
pUnit:CastSpell(28240)
end

function Grobbulus_SlimeSpray(pUnit, Event)
pUnit:CastSpell(28157)
end

function Grobbulus_MutatingInjection(pUnit, Event)
pUnit:CastSpell(28169)
end

function Grobbulus_SlimeStream(pUnit, Event)
pUnit:CastSpell(28137)
end
