function Thaddius_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "EAT YOUR BONES!")
pUnit:RegisterEvent("Thaddius_PolarityShift", 30000, 0)
pUnit:RegisterEvent("Thaddius_ChainLightning", 15000, 0)
end

function Thaddius_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Thaddius_OnKillTarget(pUnit, Event)
end

function Thaddius_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15928, 1, "Thaddius_OnCombat")
RegisterUnitEvent(15928, 2, "Thaddius_OnLeaveCombat")
RegisterUnitEvent(15928, 3, "Thaddius_OnKillTarget")
RegisterUnitEvent(15928, 4, "Thaddius_OnDeath")

function Thaddius_PolarityShift(pUnit, Event)
pUnit:CastSpell(28089)
end

function Thaddius_ChainLightning(pUnit, Event)
pUnit:FullCastSpellOnTarget(28293, pUnit:GetMainTank())
end
