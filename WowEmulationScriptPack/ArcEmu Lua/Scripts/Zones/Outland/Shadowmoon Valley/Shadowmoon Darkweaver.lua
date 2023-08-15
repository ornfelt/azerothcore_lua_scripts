function ShadowmoonDarkweaver_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ShadowmoonDarkweaver_Immolate", 4000, 0)
	Unit:RegisterEvent("ShadowmoonDarkweaver_NetherInfusion", 35000, 3)
	Unit:RegisterEvent("ShadowmoonDarkweaver_ShadowBolt", 2500, 0)
	Unit:RegisterEvent("ShadowmoonDarkweaver_Shadowfury", 9000, 0)
end

function ShadowmoonDarkweaver_Immolate(Unit,Event)
	Unit:FullCastSpellOnTarget(11962,Unit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_NetherInfusion(Unit,Event)
	Unit:FullCastSpellOnTarget(38446,Unit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_Shadowfury(Unit,Event)
	Unit:FullCastSpellOnTarget(35373,Unit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ShadowmoonDarkweaver_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function ShadowmoonDarkweaver_OnSpawn(Unit,Event)
	Unit:CastSpell(38442)
end

RegisterUnitEvent(22081, 1, "ShadowmoonDarkweaver_OnEnterCombat")
RegisterUnitEvent(22081, 2, "ShadowmoonDarkweaver_OnLeaveCombat")
RegisterUnitEvent(22081, 4, "ShadowmoonDarkweaver_OnDied")
RegisterUnitEvent(22081, 6, "ShadowmoonDarkweaver_OnSpawn")