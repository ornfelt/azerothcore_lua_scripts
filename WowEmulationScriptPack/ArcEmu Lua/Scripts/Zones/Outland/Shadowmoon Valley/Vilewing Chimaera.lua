function VilewingChimaera_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("VilewingChimaera_FroststormBreath", 5000, 0)
	Unit:RegisterEvent("VilewingChimaera_VenomSpit", 15000, 0)
end

function VilewingChimaera_FroststormBreath(Unit,Event)
	Unit:FullCastSpellOnTarget(55491,Unit:GetClosestPlayer())
end

function VilewingChimaera_VenomSpit(Unit,Event)
	Unit:FullCastSpellOnTarget(16552,Unit:GetClosestPlayer())
end

function VilewingChimaera_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function VilewingChimaera_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21879, 1, "VilewingChimaera_OnEnterCombat")
RegisterUnitEvent(21879, 2, "VilewingChimaera_OnLeaveCombat")
RegisterUnitEvent(21879, 4, "VilewingChimaera_OnDied")