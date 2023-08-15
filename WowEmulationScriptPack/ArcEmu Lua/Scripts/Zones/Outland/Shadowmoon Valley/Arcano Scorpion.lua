function ArcanoScorp_OnEnterCombat(Unit,Event)
	Unit:CastSpell(37917) 
	Unit:CastSpell(37851)
	Unit:RegisterEvent("ArcanoScorp_DisMantle", 3000, 0)
	Unit:RegisterEvent("ArcanoScorp_Pince", 6600, 0)
end

function ArcanoScorp_Dismantle(Unit,Event)
	Unit:FullCastSpellOnTarget(37919,Unit:GetClosestPlayer())
end

function ArcanoScorp_Pince(Unit,Event)
	Unit:FullCastSpellOnTarget(37918,Unit:GetClosestPlayer())
end

function ArcanoScorp_OnLeaveCombat(Unit, Event)
end

function ArcanoScorp_OnDied(Unit, event)
end

RegisterUnitEvent (21909, 1, "ArcanoScorp_OnEnterCombat")
RegisterUnitEvent (21909, 2, "ArcanoScorp_OnLeaveCombat")
RegisterUnitEvent (21909, 4, "ArcanoScorp_OnDied")