--[[ Hellfire Peninsula -- AllInOne.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, October 08, 2008. ]]

function Aeranas_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Aeranas_Shock", 10000, 0)
end

function Aeranas_Shock(Unit,Event)
	Unit:FullCastSpellOnTarget(12553,Unit:GetClosestPlayer())
end

function Aeranas_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Aeranas_OnDied(Unit,Event)
	Unit:RemoveEvents()
end


RegisterUnitEvent (17085, 1, "Aeranas_OnEnterCombat")
RegisterUnitEvent (17085, 2, "Aeranas_OnLeaveCombat")
RegisterUnitEvent (17085, 4, "Aeranas_OnDied")

function Aggonis_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Aggonis_Corruption", 24000, 0)
end

function Aggonis_Corruption(Unit,Event)
	Unit:FullCastSpellOnTarget(21068,Unit:GetClosestPlayer())
end

function Aggonis_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Aggonis_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (17000, 1, "Aggonis_OnEnterCombat")
RegisterUnitEvent (17000, 2, "Aggonis_OnLeaveCombat")
RegisterUnitEvent (17000, 4, "Aggonis_OnDied")

function Arazzius_OnEnterCombat(Unit,Event)
	Unit:CastSpell(34094)
	Unit:RegisterEvent("Arazzius_FeebleWeapons", 120000, 0)
	Unit:RegisterEvent("Arazzius_Inferno", 360000, 0)
	Unit:RegisterEvent("Arazzius_Pyroblast", 24000, 0)
	Unit:RegisterEvent("Arazzius_ShadowBoltVolley", 5000, 0)
end

function Arazzius_FeebleWeapons(Unit,Event)
	Unit:FullCastSpellOnTarget(34088,Unit:GetClosestPlayer())
end

function Arazzius_Inferno(Unit,Event)
	Unit:FullCastSpellOnTarget(34249,Unit:GetClosestPlayer())
end

function Arazzius_Pyroblast(Unit,Event)
	Unit:FullCastSpellOnTarget(33975,Unit:GetClosestPlayer())
end

function Arazzius_ShadowBoltVolley(Unit,Event)
	Unit:FullCastSpellOnTarget(15245,Unit:GetClosestPlayer())
end

function Arazzius_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Arazzius_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19191, 1, "Arazzius_OnEnterCombat")
RegisterUnitEvent (19191, 2, "Arazzius_OnLeaveCombat")
RegisterUnitEvent (19191, 4, "Arazzius_OnDied")

function Torseldori_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Torseldori_ArcaneMissiles", 15000 , 0)
	Unit:RegisterEvent("Torseldori_Blizzard", 30000, 0)
	Unit:RegisterEvent("Torseldori_FrostNova", 20000, 0)
	Unit:RegisterEvent("Torseldori_Frostbolt", 3500, 0)
end

function Torseldori_ArcaneMissiles(Unit,Event)
	Unit:FullCastSpellOnTarget(22273,Unit:GetClosestPlayer())
end

function Torseldori_Blizzard(Unit,Event)
	Unit:FullCastSpellOnTarget(33634,Unit:GetClosestPlayer())
end

function Torseldori_FrostNova(Unit,Event)
	Unit:FullCastSpellOnTarget(12674,Unit:GetClosestPlayer())
end

function Torseldori_Frostbolt(Unit,Event)
	Unit:FullCastSpellOnTarget(15530,Unit:GetClosestPlayer())
end

function Torseldori_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Torseldori_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19257, 1, "Torseldori_OnEnterCombat")
RegisterUnitEvent (19257, 2, "Torseldori_OnLeaveCombat")
RegisterUnitEvent (19257, 4, "Torseldori_OnDied")

function Xintor_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Xintor_ArcaneMissiles", 10000 , 0)
	Unit:RegisterEvent("Xintor_Fireball", 4000, 0)
	Unit:RegisterEvent("Xintor_IceBarrier", 120000, 0) 
end

function Xintor_ArcaneMissiles(Unit,Event)
	Unit:FullCastSpellOnTarget(22273,Unit:GetClosestPlayer())
end

function Xintor_Frostbolt(Unit,Event)
	Unit:FullCastSpellOnTarget(15530,Unit:GetClosestPlayer())
end

function Xintor_IceBarrier(Unit,Event)
	Unit:FullCastSpellOnTarget(33245,Unit:GetClosestPlayer())
end

function Xintor_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Xintor_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (16977, 1, "Xintor_OnEnterCombat")
RegisterUnitEvent (16977, 2, "Xintor_OnLeaveCombat")
RegisterUnitEvent (16977, 4, "Xintor_OnDied")


function Arzeth_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Arzeth_MortalStrike", 60000 , 0)
	Unit:RegisterEvent("Arzeth_ShadowBoltVolley", 10000, 0)
end

function Arzeth_ShadowBoltVolley(Unit,Event)
	Unit:FullCastSpellOnTarget(15245,Unit:GetClosestPlayer())
end

function Arzeth_MortalStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(16856,Unit:GetClosestPlayer())
end

function Arzeth_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Arzeth_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19354, 1, "Arzeth_OnEnterCombat")
RegisterUnitEvent (19354, 2, "Arzeth_OnLeaveCombat")
RegisterUnitEvent (19354, 4, "Arzeth_OnDied")

function Avruu_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Avruu_Darkness", 18000, 0)
end

function Avruu_Darkness(Unit,Event)
	Unit:FullCastSpellOnTarget(34112,Unit:GetClosestPlayer())
end

function Avruu_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Avruu_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (17084, 1, "Avruu_OnEnterCombat")
RegisterUnitEvent (17084, 2, "Avruu_OnLeaveCombat")
RegisterUnitEvent (17084, 4, "Avruu_OnDied")

function BatRiderGuard_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BatRiderGuard_UnstableConcoction", 22000, 0)
end

function BatRiderGuard_UnstableConcoction(Unit,Event)
	Unit:FullCastSpellOnTarget(38066,Unit:GetClosestPlayer())
end

function BatRiderGuard_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BatRiderGuard_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (15242, 1, "BatRiderGuard_OnEnterCombat")
RegisterUnitEvent (15242, 2, "BatRiderGuard_OnLeaveCombat")
RegisterUnitEvent (15242, 4, "BatRiderGuard_OnDied")

function BHDS_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BHDS_FireNova", 20000, 0)
	Unit:RegisterEvent("BHDS_Bloodlust", 60000, 0)
	Unit:RegisterEvent("BHDS_LightningShield", 30000, 0)
end

function BHDS_FireNova(Unit,Event)
	Unit:FullCastSpellOnTarget(32062,Unit:GetClosestPlayer())
end

function BHDS_Bloodlust(Unit,Event)
	Unit:CastSpell(6742)
end

function BHDS_LightningShield(Unit,Event)
	Unit:CastSpell(12550)
end

function BHDS_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BHDS_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (16873, 1, "BHDS_OnEnterCombat")
RegisterUnitEvent (16873, 2, "BHDS_OnLeaveCombat")
RegisterUnitEvent (16873, 4, "BHDS_OnDied")

function BHGrunt_OnEnterCombat(Unit,Event)
	Unit:CastSpell(8599)
	Unit:RegisterEvent("BHGrunt_Strike", 6000, 0)
end

function BHGrunt_Strike(Unit,Event)
	Unit:FullCastSpellOnTarget(11976,Unit:GetClosestPlayer())
end

function BHGrunt_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BHGrunt_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(16871, 1, "BHGrunt_OnEnterCombat")
RegisterUnitEvent(16871, 2, "BHGrunt_OnLeaveCombat")
RegisterUnitEvent(16871, 4, "BHGrunt_OnDied")

function BHN_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BHN_Fireball", 7000, 0)
	Unit:RegisterEvent("BHN_Spell", 240000, 0)
end

function BHN_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(34073,Unit,Event)
end

function BHN_Fireball(Unit,Event)
	Unit:FullCastSpellOnTarget(9053,Unit:GetClosestPlayer())
end

function BHN_Phase(Unit,Event)
 if Unit:GetHealthPct() == 75 then 
	Unit:CastSpell(34019)
end
end

function BHN_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BHN_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19422, 1, "BHN_OnEnterCombat")
RegisterUnitEvent(19422, 1, "BHN_Phase")
RegisterUnitEvent(19422, 2, "BHN_OnLeaveCombat")
RegisterUnitEvent(19422, 4, "BHN_OnDied")

function BHT_OnEnterCombat(Unit,Event)
	Unit:CastSpell(34368)
	Unit:FullCastSpellOnTarget(33924,Unit:GetRandomPlayer(3))
end

function BHT_Phase1(Unit,Event)
 if Unit:GetHealthPct() == 15 then
	Unit:FullCastSpellOnTarget(31553,Unit:GetClosestPlayer())

end
end

function BHT_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BHT_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19424, 1, "BHT_OnEnterCombat")
RegisterUnitEvent(19424, 1, "BHT_Phase1")
RegisterUnitEvent(19424, 2, "BHT_OnLeaveCombat")
RegisterUnitEvent(19424, 4, "BHT_OnDied")

function BR_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BR_Spell", 120000, 0)
end

function BR_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(32722,Unit:GetClosestPlayer())
end

function BR_OnEnterCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BR_OnEnterCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(16901, 1, "BR_OnEnterCombat")
RegisterUnitEvent(16901, 2, "BR_OnLeaveCombat")
RegisterUnitEvent(16901, 4, "BR_OnDied")

function Bloodmage_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Bloodmage_Blizzard", 40000, 0)
	Unit:RegisterEvent("Bloodmage_FrostNova", 13000, 0)
	Unit:RegisterEvent("Bloodmage_Frostbolt", 7000, 0)
	Unit:RegisterEvent("Bloodmage_ArcaneMissle", 8000, 0)
end

function Bloodmage_FrostNova(Unit,Event)
	Unit:FullCastSpellOnTarget(12674,Unit:GetClosestPlayer())
end

function Bloodmage_Frostbolt(Unit,Event)
	Unit:FullCastSpellOnTarget(15530,Unit:GetClosestPlayer())
end

function Bloodmage_Blizzard(Unit,Event)
	Unit:FullCastSpellOnTarget(33634,Unit:GetClosestPlayer())
end

function Bloodmage_ArcaneMissle(Unit,Event)
 if Unit:GetHealthPct () == 30 then
	Unit:FullCastSpellOnTarget(22273,Unit:GetClosestPlayer())
end
end

function Bloodmage_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Bloodmage_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19258, 1, "Bloodmage_OnEnterCombat")
RegisterUnitEvent(19258, 2, "Bloodmage_OnLeaveCombat")
RegisterUnitEvent(19258, 4, "Bloodmage_OnDied")

function BCE_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BCE_Fireball", 10000, 0)
end

function BCE_Fireball(Unit,Event)
	Unit:FullCastSpellOnTarget(9053,Unit:GetClosestPlayer())
end

function BCE_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BCE_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19701, 1, "BCE_OnEnterCombat")
RegisterUnitEvent(19701, 2, "BCE_OnLeaveCombat")
RegisterUnitEvent(19701, 4, "BCE_OnDied")

function BWM_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(34113,Unit:GetClosestPlayer())
	Unit:RegisterEvent("BWM_Enrage", 120000, 0)
	Unit:RegisterEvent("BWM_Bite", 240000, 0)
end

function BWM_Bite(Unit,Event)
	Unit:FullCastSpellOnTarget(34113,Unit:GetClosestPlayer())
end

function BWM_Enrage(Unit,Event)
	Unit:FullCastSpellOnTarget(8599,Unit:GetClosestPlayer())
end

function BWM_OnNearDeath(Unit,Event)
 if Unit:GetHealthPct() == 15 then
	Unit:CastSpell(34114)
end
end

function BWM_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BWM_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(16876, 1, "BWM_OnEnterCombat")
RegisterUnitEvent(16876, 1, "BWM_OnNearDeath")
RegisterUnitEvent(16876, 2, "BWM_OnLeaveCombat")
RegisterUnitEvent(16876, 4, "BWM_OnDied")

function BCR_OnEnterCombat(Unit,Event)
	Unit:CastSpell(32723)
end

RegisterUnitEvent(16925, 1, "BCR_OnEnterCombat")

function BCRW_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BCRW_Howl", 30000, 0)
	Unit:RegisterEvent("BCRW_Bite", 120000, 0)
end

function BCRW_Howl(Unit,Event)
	Unit:FullCastSpellOnTarget(3149,Unit:GetClosestPlayer())
end

function BCRW_Bite(Unit,Event)
	Unit:FullCastSpellOnTarget(16460,Unit:GetClosestPlayer())
end

function BCRW_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BCRW_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(18706, 1, "BCRW_OnEnterCombat")
RegisterUnitEvent(18706, 2, "BCRW_OnLeaveCombat")
RegisterUnitEvent(18706, 4, "BCRW_OnDied")

function Scavenger_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Scavenger_Spell", 5000, 0)
end

function Scavenger_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(13398,Unit:GetClosestPlayer())
end

function Scavenger_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Scavenger_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(18952, 1, "Scavenger_OnEnterCombat")
RegisterUnitEvent(18952, 2, "Scavenger_OnLeaveCombat")
RegisterUnitEvent(18952, 4, "Scavenger_OnDied")

function Buzzard_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Buzzard_Spell", 5000, 0)
end

function Buzzard_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(37012,Unit:GetClosestPlayer())
end

function Buzzard_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Buzzard_OnDied(Unit,Event)
	Unit:RemoveEvents()
	Unit:CastSpell(33985)
end

RegisterUnitEvent(16972, 1, "Buzzard_OnEnterCombat")
RegisterUnitEvent(16972, 2, "Buzzard_OnLeaveCombat")
RegisterUnitEvent(16972, 4, "Buzzard_OnDied")

function CollapsingVoidwalker_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CollapsingVoidwalker_Collapse", 1000, 1)
	Unit:RegisterEvent("CollapsingVoidwalker_Fear", 12000, 0)
end

function CollapsingVoidwalker_Collapse(Unit,Event)
 if Unit:GetHealthPct() == 10 then
	Unit:CastSpell(34302)
	Unit:CastSpell(34233)
	Unit:CastSpell(34234)
	Unit:CastSpell(34842)
end
end

function CollapsingVoidwalker_Fear(Unit,Event)
	Unit:FullCastSpellOnTarget(34259,Unit:GetClosestPlayer())
end

function CollapsingVoidwalker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CollapsingVoidwalker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17014, 1, "CollapsingVoidwalker_OnEnterCombat")
RegisterUnitEvent(17014, 2, "CollapsingVoidwalker_OnLeaveCombat")
RegisterUnitEvent(17014, 4, "CollapsingVoidwalker_OnDied")

function CorporalIronridge_OnSpawn(Unit,Event)
	Unit:CastSpell(35998)
end

RegisterUnitEvent(21133, 6, "CorporalIronridge_OnSpawn")

function CrustBurster_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CrustBurster_Bore", 35000, 0)
	Unit:RegisterEvent("CrustBurster_Poison", 4000, 0)
	Unit:RegisterEvent("CrustBurster_Submerged", 50000, 0)
end

function CrustBurster_Bore(Unit,Event)
	Unit:FullCastSpellOnTarget(32738,Unit:GetClosestPlayer())
end

function CrustBurster_Poison(Unit,Event)
	Unit:FullCastSpellOnTarget(31747,Unit:GetClosestPlayer())
end

function CrustBurster_Submerged(Unit,Event)
	Unit:RemoveEvents()
	Unit:CastSpell(37751)
	Unit:RegsiterEvent("CrustBurster_Stand", 11000, 1)
end

function CrustBurster_Stand(Unit,Event)
	Unit:RemoveEvents()
	Unit:CastSpell(37752)
	Unit:RegisterEvent("CrustBurster_Bore", 35000, 0)
	Unit:RegisterEvent("CrustBurster_Poison", 4000, 0)
	Unit:RegisterEvent("CrustBurster_Submerged", 50000, 0)
end

function CrustBurster_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CrustBurster_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(16844, 1, "CrustBurster_OnEnterCombat")
RegisterUnitEvent(16844, 2, "CrustBurster_OnLeaveCombat")
RegisterUnitEvent(16844, 4, "CrustBurster_OnDied")

function CursedScarab_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(3256,Unit:GetClosestPlayer())
end

RegisterUnitEvent(21306, 1, "CursedScarab_OnEnterCombat")

function CollapsingVoidwalker_OnEnterCombat(Unit,Event)
	Unit:RegsiterEvent("CollapsingVoidwalker_Fear", 14000, 0)
end

function CollapsingVoidwalker_Fear(Unit,Event)
	Unit:FullCastSpellOnTarget(34259,Unit:GetClosestPlayer())
end

function CollapsingVoidwalker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CollapsingVoidwalker_OnDied(Unit,Event)
	Unit:CastSpell(34302)
	Unit:CastSpell(34233)
	Unit:FullCastSpellOnTarget(34234,Unit:GetClosestPlayer())
	Unit:CastSpell(34842)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17014, 1, "CollapsingVoidwalker_OnEnterCombat")
RegisterUnitEvent(17014, 2, "CollapsingVoidwalker_OnLeaveCombat")
RegisterUnitEvent(17014, 4, "CollapsingVoidwalker_OnDied")

--[[ Crust Burster
function CrustBurster_OnEnterCombat(Unit,Event)

end

function
--]]

function CursedScarab_OnSpawn(Unit,Event)
	Unit:FullCastSpellOnTarget(3256)
	Unit:RegisterEvent("CursedScarab_OnDespawn", 20000, 1)
end

function CursedScarab_OnDespawn(Unit,Event)
	Unit:Despawn()
end

RegisterUnitEvent(21306, 6, "CursedScarab_OnSpawn")