-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

function Deep_Borer_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(44030, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Deep_Borerphase1", 1000, 0)
	pUnit:RegisterEvent("Deep_BorerTackle", 1000, 0)
end

function Deep_Borerphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(26992)
		pUnit:RegisterEvent("Deep_Borerphase2", 1000, 0)
		pUnit:RegisterEvent("Deep_BorerTackle", 1000, 0)
	end
end

function Deep_Borerphase2(pUnit, event)
	if pUnit:GetHealthPct() < 24 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(19364)
	end
end


function Deep_BorerTackle(pUnit, event)
	pUnit:FullCastSpellOnTarget(44030, pUnit:GetRandomPlayer(0))
end

function Deep_Borer_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Deep_Borer_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(11789, 1, "Deep_Borer_OnCombat")
RegisterUnitEvent(11789, 2, "Deep_Borer_OnLeaveCombat")
RegisterUnitEvent(11789, 4, "Deep_Borer_OnDeath")

function Deeprot_Stomper_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(27993, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Deeprot_Stomperphase1", 1000, 0)
end

function Deeprot_Stomperphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Stomperphase2", 1000, 0)
		pUnit:RegisterEvent("Deeprot_StomperStomp", 10000, 0)
	end
end

function Deeprot_Stomperphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Stomperphase3", 1000, 0)
	end
end

function Deeprot_Stomperphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Stomperphase4", 1000, 0)
		pUnit:RegisterEvent("Deeprot_StomperStun", 15000, 0)
	end
end

function Deeprot_Stomperphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Stomperphase5", 1000, 0)
		pUnit:RegisterEvent("Deeprot_StomperSlam", 8000, 0)
	end
end

function Deeprot_Stomperphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(27993)
		pUnit:RegisterEvent("Deeprot_Stomperphase6", 1000, 0)
		pUnit:RegisterEvent("Deeprot_StomperSlam", 8000, 0)
	end
end

function Deeprot_Stomperphase6(pUnit, event)
	if pUnit:GetHealthPct() < 12 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(27993)
		pUnit:RegisterEvent("Deeprot_StomperStun", 15000, 0)
	end
end

function Deeprot_StomperStomp(pUnit, event)
	pUnit:CastSpell(27993)
end

function Deeprot_StomperSlam(pUnit, event)
	pUnit:FullCastSpellOnTarget(35953, pUnit:GetRandomPlayer(0))
end

function Deeprot_StomperStun(pUnit, event)
	pUnit:FullCastSpellOnTarget(34620, pUnit:GetRandomPlayer(0))
end

function Deeprot_Stomper_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Deeprot_Stomper_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(13141, 1, "Deeprot_Stomper_OnCombat")
RegisterUnitEvent(13141, 2, "Deeprot_Stomper_OnLeaveCombat")
RegisterUnitEvent(13141, 4, "Deeprot_Stomper_OnDeath")

function Deeprot_Tangler_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(40363, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Deeprot_Tanglerphase1", 1000, 0)
end

function Deeprot_Tanglerphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Tanglerphase2", 1000, 0)
		pUnit:RegisterEvent("Deeprot_TanglerRoot", 10000, 0)
	end
end

function Deeprot_Tanglerphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Tanglerphase3", 1000, 0)
	end
end

function Deeprot_Tanglerphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Tanglerphase4", 1000, 0)
		pUnit:RegisterEvent("Deeprot_TanglerStun", 15000, 0)
	end
end

function Deeprot_Tanglerphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("Deeprot_Tanglerphase5", 1000, 0)
		pUnit:RegisterEvent("Deeprot_TanglerSlam", 8000, 0)
	end
end

function Deeprot_Tanglerphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(40363)
		pUnit:RegisterEvent("Deeprot_Tanglerphase6", 1000, 0)
		pUnit:RegisterEvent("Deeprot_TanglerSlam", 8000, 0)
	end
end

function Deeprot_Tanglerphase6(pUnit, event)
	if pUnit:GetHealthPct() < 12 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(40363)
		pUnit:RegisterEvent("Deeprot_TanglerStun", 15000, 0)
	end
end


function Deeprot_TanglerRoot(pUnit, event)
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
end

function Deeprot_TanglerSlam(pUnit, event)
	pUnit:FullCastSpellOnTarget(35953, pUnit:GetRandomPlayer(0))
end

function Deeprot_TanglerStun(pUnit, event)
	pUnit:FullCastSpellOnTarget(34620, pUnit:GetRandomPlayer(0))
end

function Deeprot_Tangler_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Deeprot_Tangler_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(13142, 1, "Deeprot_Tangler_OnCombat")
RegisterUnitEvent(13142, 2, "Deeprot_Tangler_OnLeaveCombat")
RegisterUnitEvent(13142, 4, "Deeprot_Tangler_OnDeath")


function Diemetradon_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(12734, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Diemetradonphase1", 1000, 0)
end

function Diemetradonphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(45772)
		pUnit:RegisterEvent("Diemetradonphase2", 1000, 0)
		pUnit:RegisterEvent("DiemetradonMark", 25000, 0)
	end
end

function Diemetradonphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Diemetradonphase3", 1000, 0)
		pUnit:RegisterEvent("DiemetradonMend", 10000, 0)
	end
end

function Diemetradonphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Diemetradonphase4", 1000, 0)
		pUnit:RegisterEvent("DiemetradonMark", 25000, 0)
		pUnit:RegisterEvent("DiemetradonMend", 10000, 0)
	end
end

function Diemetradonphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Diemetradonphase5", 1000, 0)
		pUnit:RegisterEvent("DiemetradonMark", 25000, 0)
		pUnit:CastSpell(26167)
	end
end

function Diemetradonphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(12734)
		pUnit:RegisterEvent("Diemetradonphase6", 1000, 0)
		pUnit:RegisterEvent("DiemetradonMark", 25000, 0)
		pUnit:RegisterEvent("DiemetradonMend", 7000, 0)
	end
end

function Diemetradonphase6(pUnit, event)
	if pUnit:GetHealthPct() < 17 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(12734)
		pUnit:RegisterEvent("DiemetradonMend", 6000, 0)
	end
end

function DiemetradonMark(pUnit, event)
	pUnit:CastSpell(27825)
end

function DiemetradonMend(pUnit, event)
	pUnit:CastSpell(37367)
end

function Diemetradon_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Diemetradon_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(13323, 1, "Diemetradon_OnCombat")
RegisterUnitEvent(13323, 2, "Diemetradon_OnLeaveCombat")
RegisterUnitEvent(13323, 4, "Diemetradon_OnDeath")

function Hydra_OnCombat(pUnit, event)
	pUnit:RegisterEvent("HydraArcane", 18000, 0)
	pUnit:RegisterEvent("HydraHoly", 22000, 0)
	pUnit:RegisterEvent("HydraPoison", 15000, 0)
end

function HydraArcane(pUnit, event)
	pUnit:FullCastSpellOnTarget(38823, pUnit:GetRandomPlayer(0))
end

function HydraHoly(pUnit, event)
	pUnit:FullCastSpellOnTarget(36743, pUnit:GetRandomPlayer(0))
end

function HydraPoison(pUnit, event)
	pUnit:FullCastSpellOnTarget(25424, pUnit:GetRandomPlayer(0))
end

function Hydra_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Hydra_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12207, 1, "Hydra_OnCombat")
RegisterUnitEvent(12207, 2, "Hydra_OnLeaveCombat")
RegisterUnitEvent(12207, 4, "Hydra_OnDeath")
--[[
function Pre_Behemoth_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(26281, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Pre_Behemothphase1", 1000, 0)
	pUnit:SendChatMessage(12, 0, "My stone body will crush you!")
end

function Pre_Behemothphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(26167)
		pUnit:RegisterEvent("Pre_Behemothphase2", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 10000, 0)
		pUnit:SendChatMessage(12, 0, "Do you really think you have any chance at all!")
		pUnit:CastSpell(34716)
	end
end

function Pre_Behemothphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(34716)
		pUnit:RegisterEvent("Pre_Behemothphase3", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothCrush", 8000, 0)
		pUnit:SendChatMessage(12, 0, "Leave now or be crushed!")
	end
end

function Pre_Behemothphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(34716)
		pUnit:RegisterEvent("Pre_Behemothphase4", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 10000, 0)
		pUnit:RegisterEvent("Pre_BehemothCrush", 8000, 0)
		pUnit:SendChatMessage(12, 0, "My strenght can be compared to the strenght of a god! Nobody will ever be a real match for me!")
	end
end

function Pre_Behemothphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(34716)
		pUnit:RegisterEvent("Pre_Behemothphase5", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 10000, 0)
		pUnit:SendChatMessage(12, 0, "You are holding out longer than I've expected... but that doesn't mean you will defeat me!")
		pUnit:CastSpell(26167)
	end
end

function Pre_Behemothphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(12734)
		pUnit:CastSpell(34716)
		pUnit:RegisterEvent("Pre_Behemothphase6", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 10000, 0)
		pUnit:RegisterEvent("Pre_BehemothCrush", 8000, 0)
		pUnit:SendChatMessage(12, 0, "Your pain is only feeding me, making me even stronger!")
	end
end

function Pre_Behemothphase6(pUnit, event)
	if pUnit:GetHealthPct() < 17 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(12734)
		pUnit:CastSpell(34716)
		pUnit:RegisterEvent("Pre_BehemothCrush", 6000, 0)
		pUnit:SendChatMessage(12, 0, "What is happening... I'm falling apart! This can't be happening! Die you little pestering rats!")
	end
end


function Pre_BehemothStomp(pUnit, event)
	pUnit:CastSpell(27758)
end

function Pre_BehemothCrush(pUnit, event)
	pUnit:FullCastSpellOnTarget(33661, pUnit:GetRandomPlayer(0))
end

function Pre_Behemoth_OnDeath(pUnit, event)
	pUnit:SendChatMessage(12, 0, "What is going on... why aren't they dead yet... argh... falling apart... noooo!")
	pUnit:RemoveEvents()
end

function Pre_Behemoth_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12203, 1, "Pre_Behemoth_OnCombat")
RegisterUnitEvent(12203, 2, "Pre_Behemoth_OnLeaveCombat")
RegisterUnitEvent(12203, 4, "Pre_Behemoth_OnDeath")
]]--

function Barbed_Lasher_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Barbed_Lasherphase1", 1000, 0)
end

function Barbed_Lasherphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(29963)
		pUnit:RegisterEvent("Barbed_Lasherphase2", 1000, 0)
		pUnit:RegisterEvent("Barbed_LasherFaerieFire", 25000, 0)
	end
end

function Barbed_Lasherphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Barbed_Lasherphase3", 1000, 0)
		pUnit:RegisterEvent("Barbed_LasherCyclone", 30000, 0)
	end
end

function Barbed_Lasherphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Barbed_Lasherphase4", 1000, 0)
		pUnit:RegisterEvent("Barbed_LasherFaerieFire", 25000, 0)
	end
end

function Barbed_Lasherphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Barbed_Lasherphase5", 1000, 0)
		pUnit:RegisterEvent("Barbed_LasherCyclone", 30000, 0)
	end
end

function Barbed_Lasherphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(29963)
		pUnit:RegisterEvent("Barbed_Lasherphase6", 1000, 0)
		pUnit:RegisterEvent("Barbed_LasherSwarm", 15000, 0)
	end
end

function Barbed_Lasherphase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(27993)
		pUnit:RegisterEvent("Barbed_LasherSwarm", 15000, 0)
	end
end


function Barbed_LasherFaerieFire(pUnit, event)
	pUnit:FullCastSpellOnTarget(21670, pUnit:GetRandomPlayer(0))
end

function Barbed_LasherCyclone(pUnit, event)
	pUnit:FullCastSpellOnTarget(33786, pUnit:GetRandomPlayer(0))
end

function Barbed_LasherSwarm(pUnit, event)
	pUnit:FullCastSpellOnTarget(24975, pUnit:GetRandomPlayer(0))
end

function Barbed_Lasher_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Barbed_Lasher_OnLeaveCombat(pUnit)
pUnit:RemoveEvents()
end

RegisterUnitEvent(12219, 1, "Barbed_Lasher_OnCombat")
RegisterUnitEvent(12219, 2, "Barbed_Lasher_OnLeaveCombat")
RegisterUnitEvent(12219, 4, "Barbed_Lasher_OnDeath")

function Constrictor_Vine_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Constrictor_Vinephase1", 1000, 0)
end

function Constrictor_Vinephase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(26992)
		pUnit:RegisterEvent("Constrictor_Vinephase2", 1000, 0)
		pUnit:RegisterEvent("Constrictor_VineFaerieFire", 25000, 0)
	end
end

function Constrictor_Vinephase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Constrictor_Vinephase3", 1000, 0)
		pUnit:RegisterEvent("Constrictor_VineCyclone", 30000, 0)
	end
end

function Constrictor_Vinephase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Constrictor_Vinephase4", 1000, 0)
		pUnit:RegisterEvent("Constrictor_VineFaerieFire", 25000, 0)
	end
end

function Constrictor_Vinephase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Constrictor_Vinephase5", 1000, 0)
		pUnit:RegisterEvent("Constrictor_VineCyclone", 30000, 0)
	end
end

function Constrictor_Vinephase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(27993)
		pUnit:RegisterEvent("Constrictor_Vinephase6", 1000, 0)
		pUnit:RegisterEvent("Constrictor_VineSwarm", 15000, 0)
	end
end

function Constrictor_Vinephase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(27993)
		pUnit:RegisterEvent("Constrictor_VineSwarm", 15000, 0)
	end
end

function Constrictor_VineFaerieFire(pUnit, event)
	pUnit:FullCastSpellOnTarget(21670, pUnit:GetRandomPlayer(0))
end

function Constrictor_VineCyclone(pUnit, event)
	pUnit:FullCastSpellOnTarget(33786, pUnit:GetRandomPlayer(0))
end

function Constrictor_VineSwarm(pUnit, event)
	pUnit:FullCastSpellOnTarget(24975, pUnit:GetRandomPlayer(0))
end

function Constrictor_Vine_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Constrictor_Vine_OnLeaveCombat(pUnit)
pUnit:RemoveEvents()
end

RegisterUnitEvent(12220, 1, "Constrictor_Vine_OnCombat")
RegisterUnitEvent(12220, 2, "Constrictor_Vine_OnLeaveCombat")
RegisterUnitEvent(12220, 4, "Constrictor_Vine_OnDeath")


function Creeping_Sludge_OnCombat(pUnit, event)
	pUnit:CastSpell(40818)
	pUnit:RegisterEvent("Creeping_Sludgephase2", 1000, 0)
end

function Creeping_Sludgephase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Creeping_Sludgephase3", 1000, 0)
		pUnit:RegisterEvent("Creeping_SludgeAcidBite", 5000, 0)
	end
end

function Creeping_Sludgephase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(40102)
		pUnit:RegisterEvent("Creeping_Sludgephase4", 1000, 0)
		pUnit:RegisterEvent("Creeping_SludgeAcidBite", 5000, 0)
	end
end

function Creeping_Sludgephase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(28989)
		pUnit:CastSpell(30109)
		pUnit:RegisterEvent("Creeping_Sludgephase5", 1000, 0)
		pUnit:RegisterEvent("Creeping_SludgeSludgeNova", 5000, 0)
	end
end

function Creeping_Sludgephase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(30913)
		pUnit:RegisterEvent("Creeping_Sludgephase6", 1000, 0)
		pUnit:RegisterEvent("Creeping_SludgeSludgeNova", 5000, 0)
	end
end

function Creeping_Sludgephase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(34268)
		pUnit:RegisterEvent("Creeping_SludgeSludgeNova", 5000, 0)
	end
end


function Creeping_SludgeSludgeNova(pUnit, event)
	pUnit:FullCastSpellOnTarget(40103, pUnit:GetRandomPlayer(0))
end

function Creeping_SludgeAcidBite(pUnit, event)
	pUnit:FullCastSpellOnTarget(36796, pUnit:GetRandomPlayer(0))
end

function Creeping_Sludge_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Creeping_Sludge_OnLeaveCombat(pUnit)
pUnit:RemoveEvents()
end

RegisterUnitEvent(12222, 1, "Creeping_Sludge_OnCombat")
RegisterUnitEvent(12222, 2, "Creeping_Sludge_OnLeaveCombat")
RegisterUnitEvent(12222, 4, "Creeping_Sludge_OnDeath")


function Cavern_Shambler_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Cavern_Shamblerphase1", 1000, 0)
end

function Cavern_Shamblerphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(18944)
		pUnit:RegisterEvent("Cavern_Shamblerphase2", 1000, 0)
		pUnit:RegisterEvent("Cavern_ShamblerStomp", 10000, 0)
	end
end

function Cavern_Shamblerphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Cavern_Shamblerphase3", 1000, 0)
		pUnit:RegisterEvent("Cavern_ShamblerArcSmash", 10000, 0)
	end
end

function Cavern_Shamblerphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Cavern_ShamblerStomp", 10000, 0)
	end
end

function Cavern_ShamblerStomp(pUnit, event)
	pUnit:FullCastSpellOnTarget(24375, pUnit:GetRandomPlayer(0))
end

function Cavern_ShamblerArcSmash(pUnit, event)
	pUnit:FullCastSpellOnTarget(28168, pUnit:GetRandomPlayer(0))
end

function Cavern_Shambler_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Cavern_Shambler_OnLeaveCombat(pUnit)
pUnit:RemoveEvents()
end

RegisterUnitEvent(12223, 1, "Cavern_Shambler_OnCombat")
RegisterUnitEvent(12223, 2, "Cavern_Shambler_OnLeaveCombat")
RegisterUnitEvent(12223, 4, "Cavern_Shambler_OnDeath")
RegisterUnitEvent(12224, 1, "Cavern_Shambler_OnCombat")
RegisterUnitEvent(12224, 2, "Cavern_Shambler_OnLeaveCombat")
RegisterUnitEvent(12224, 4, "Cavern_Shambler_OnDeath")

function Celebrian_Dryad_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Celebrian_Dryadphase1", 1000, 0)
	pUnit:RegisterEvent("Celebrian_DryadWrath", 8000, 0)
end

function Celebrian_Dryadphase1(pUnit, event)
	if pUnit:GetHealthPct() < 66 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(23537)
		pUnit:RegisterEvent("Celebrian_Dryadphase2", 1000, 0)
		pUnit:RegisterEvent("Celebrian_DryadWrathSpeed", 6000, 0)
	end
end

function Celebrian_Dryadphase2(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Celebrian_Dryadphase3", 1000, 0)
		pUnit:RegisterEvent("Celebrian_DryadSwarm", 15000, 0)
	end
end

function Celebrian_Dryadphase3(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(18944)
		pUnit:RegisterEvent("Celebrian_Dryadphase4", 1000, 0)
	end
end

function Celebrian_Dryadphase4(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Celebrian_Dryadphase5", 1000, 0)
		pUnit:RegisterEvent("Celebrian_DryadSwarm", 15000, 0)
	end
end

function Celebrian_Dryadphase5(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(18944)
		pUnit:RegisterEvent("Celebrian_DryadWrathSpeed", 6000, 0)
	end
end

function Celebrian_DryadWrath(pUnit, event)
	pUnit:FullCastSpellOnTarget(26985, pUnit:GetRandomPlayer(0))
end

function Celebrian_DryadWrathSpeed(pUnit, event)
	pUnit:FullCastSpellOnTarget(26985, pUnit:GetRandomPlayer(0))
end

function Celebrian_DryadSwarm(pUnit, event)
	pUnit:FullCastSpellOnTarget(24975, pUnit:GetRandomPlayer(0))
end

function Celebrian_Dryad_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Celebrian_Dryad_OnLeaveCombat(pUnit)
pUnit:RemoveEvents()
end

RegisterUnitEvent(11793, 1, "Celebrian_Dryad_OnCombat")
RegisterUnitEvent(11793, 2, "Celebrian_Dryad_OnLeaveCombat")
RegisterUnitEvent(11793, 4, "Celebrian_Dryad_OnDeath")
RegisterUnitEvent(11794, 1, "Celebrian_Dryad_OnCombat")
RegisterUnitEvent(11794, 2, "Celebrian_Dryad_OnLeaveCombat")
RegisterUnitEvent(11794, 4, "Celebrian_Dryad_OnDeath")


function Meshlok_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Meshlokphase1", 1000, 0)
	pUnit:RegisterEvent("MeshlokSuperEnrage", 360000, 0)
	pUnit:SendChatMessage(12, 0, "May the earth aid me in this battle!")
end

function Meshlokphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(18944)
		pUnit:RegisterEvent("Meshlokphase2", 1000, 0)
		pUnit:RegisterEvent("MeshlokStomp", 15000, 0)
		pUnit:SendChatMessage(12, 0, "I call you, ground of the earth!")
	end
end

function Meshlokphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Meshlokphase3", 1000, 0)
		pUnit:RegisterEvent("MeshlokArcSmash", 10000, 0)
		pUnit:SendChatMessage(12, 0, "You will regret this moment, feel my imperial power!")
	end
end

function Meshlokphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Meshlokphase4", 1000, 0)
		pUnit:RegisterEvent("MeshlokArcSmash", 10000, 0)
		pUnit:RegisterEvent("MeshlokStomp", 15000, 0)
	end
end

function Meshlokphase4(pUnit, event)
	if pUnit:GetHealthPct() < 31 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("MeshlokArcSmash", 10000, 0)
		pUnit:RegisterEvent("MeshlokStomp", 15000, 0)
		pUnit:CastSpell(23537)
		pUnit:SendChatMessage(12, 0, "Must... Kill... RAAWRRRRR!")
	end
end

function MeshlokStomp(pUnit, event)
	pUnit:FullCastSpellOnTarget(24375, pUnit:GetRandomPlayer(0))
end

function MeshlokSuperEnrage(pUnit, event)
	pUnit:SendChatMessage(12, 0, "You really got me mad now, no way you will ever defeat me muahahaha!")
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
	pUnit:CastSpell(41953)
end

function MeshlokArcSmash(pUnit, event)
	pUnit:CastSpell(28168)
end

function Meshlok_OnDeath(pUnit, event)
	pUnit:SendChatMessage(12, 0, "You will not get out of here safely... I swear it to the almighty! *cough* argh...")
	pUnit:RemoveEvents()
end

function Meshlok_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12237, 1, "Meshlok_OnCombat")
RegisterUnitEvent(12237, 2, "Meshlok_OnLeaveCombat")
RegisterUnitEvent(12237, 4, "Meshlok_OnDeath")


function Noxious_Slime_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(15475, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Noxious_Slimephase1", 1000, 0)
	pUnit:RegisterEvent("Noxious_SlimeDebiPoison", 10000, 0)
end

function Noxious_Slimephase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(26992)
		pUnit:RegisterEvent("Noxious_Slimephase3", 1000, 0)
		pUnit:RegisterEvent("Noxious_SlimeDebiPoison", 10000, 0)
	end
end

function Noxious_Slimephase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:FullCastSpellOnTarget(5208, pUnit:GetRandomPlayer(0))
		pUnit:RegisterEvent("Noxious_Slimephase4", 1000, 0)
	end
end

function Noxious_Slimephase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Noxious_Slimephase5", 1000, 0)
		pUnit:RegisterEvent("Noxious_SlimeDebiPoison", 10000, 0)
	end
end

function Noxious_Slimephase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(36619)
		pUnit:RegisterEvent("Noxious_Slimephase6", 1000, 0)
	end
end

function Noxious_Slimephase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(25198)
	end
end


function Noxious_SlimeDebiPoison(pUnit, event)
	pUnit:FullCastSpellOnTarget(43133, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Noxious_SlimeDebiPoison", 10000, 0)
end

function Noxious_Slime_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Noxious_Slime_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12221, 1, "Noxious_Slime_OnCombat")
RegisterUnitEvent(12221, 2, "Noxious_Slime_OnLeaveCombat")
RegisterUnitEvent(12221, 4, "Noxious_Slime_OnDeath")

function Noxxion_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(16050, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Noxxionphase1", 1000, 0)
	pUnit:RegisterEvent("NoxxionSpout", 6000, 0)
	pUnit:SendChatMessage(12, 0, "May the power of the water stop these pestering rats!")
end

function Noxxionphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Noxxionphase3", 1000, 0)
		pUnit:RegisterEvent("NoxxionSludgeNova", 5000, 0)
		pUnit:SendChatMessage(12, 0, "Don't be afraid of death! Be afraid of me!")
	end
end

function Noxxionphase3(pUnit, event)
	x = pUnit:GetX()
	y = pUnit:GetY()
	z = pUnit:GetZ()
	o = pUnit:GetO()
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Noxxionphase4", 1000, 0)
		pUnit:SpawnCreature(12218, x + 4, y, z, o, 14, 100000)
		pUnit:SpawnCreature(12218, x - 4, y, z, o, 14, 100000)
		pUnit:SendChatMessage(12, 0, "Come and help me in my aid!")
	end
end

function Noxxionphase4(pUnit, event)
	x = pUnit:GetX()
	y = pUnit:GetY()
	z = pUnit:GetZ()
	o = pUnit:GetO()
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Noxxionphase5", 1000, 0)
		pUnit:SpawnCreature(12218, x + 4, y, z, o, 14, 100000)
		pUnit:SpawnCreature(12218, x - 4, y, z, o, 14, 100000)
		pUnit:SendChatMessage(12, 0, "With these creatures on my side the battle will be so easy!")
	end
end

function Noxxionphase5(pUnit, event)
	x = pUnit:GetX()
	y = pUnit:GetY()
	z = pUnit:GetZ()
	o = pUnit:GetO()
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(30035)
		pUnit:RegisterEvent("Noxxionphase6", 1000, 0)
		pUnit:SpawnCreature(12218, x + 4, y, z, o, 14, 100000)
		pUnit:SpawnCreature(12218, x - 4, y, z, o, 14, 100000)
		pUnit:SendChatMessage(12, 0, "Why am I getting weaker... help me you fools!")
	end
end

function Noxxionphase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("NoxxionSludgeNova", 5000, 0)
		pUnit:CastSpell(41953)
		pUnit:CastSpell(41953)
		pUnit:CastSpell(41953)
		pUnit:SendChatMessage(12, 0, "I feel death in this place... Death which makes me stronger!")
	end
end

function NoxxionSpout(pUnit, event)
	pUnit:FullCastSpellOnTarget(39207, pUnit:GetRandomPlayer(0))
end

function NoxxionSludgeNova(pUnit, event)
	pUnit:CastSpell(40103)
end

function NoxxionSwarm(pUnit, event)
	pUnit:FullCastSpellOnTarget(24975, pUnit:GetRandomPlayer(0))
end

function Noxxion_OnDeath(pUnit, event)
	pUnit:SendChatMessage(12, 0, "I have been weakened but I will never die... I dare you to come back once I get my powers back... it's time... to rest now... argh...")
	pUnit:RemoveEvents()
end

function Noxxion_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(13282, 1, "Noxxion_OnCombat")
RegisterUnitEvent(13282, 2, "Noxxion_OnLeaveCombat")
RegisterUnitEvent(13282, 4, "Noxxion_OnDeath")

function Poison_Sprite_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(26601, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Poison_Spritephase1", 1000, 0)
end

function Corruptor_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Poison_SpriteCorruption", 10000, 0)
end

function Poison_Spritephase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Poison_SpritePoisonBolt", 5000, 0)
	end
end

function Poison_SpritePoisonBolt(pUnit, event)
	pUnit:FullCastSpellOnTarget(37862, pUnit:GetRandomPlayer(0))
end

function Poison_SpriteCorruption(pUnit, event)
	pUnit:FullCastSpellOnTarget(41988, pUnit:GetRandomPlayer(0))
end

function Poison_Sprite_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Poison_Sprite_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

function Corruptor_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Corruptor_OnLeaveCombat(pUnit)
pUnit:RemoveEvents()
end

RegisterUnitEvent(12216, 1, "Poison_Sprite_OnCombat")
RegisterUnitEvent(12216, 2, "Poison_Sprite_OnLeaveCombat")
RegisterUnitEvent(12216, 4, "Poison_Sprite_OnDeath")
RegisterUnitEvent(12217, 1, "Corruptor_OnCombat")
RegisterUnitEvent(12217, 2, "Corruptor_OnLeaveCombat")
RegisterUnitEvent(12217, 4, "Corruptor_OnDeath")


function Putridus_Trickster_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(30741, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Putridus_Tricksterphase1", 1000, 0)
end

function Putridus_Tricksterphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(26992)
		pUnit:RegisterEvent("Putridus_Tricksterphase2", 1000, 0)
		pUnit:RegisterEvent("Putridus_TricksterCut", 6000, 0)
	end
end

function Putridus_Tricksterphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Putridus_Tricksterphase3", 1000, 0)
		pUnit:RegisterEvent("Putridus_TricksterCut", 6000, 0)
	end
end

function Putridus_Tricksterphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Putridus_Tricksterphase4", 1000, 0)
		pUnit:RegisterEvent("Putridus_TricksterSlice", 10000, 0)
	end
end

function Putridus_Tricksterphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Putridus_Tricksterphase6", 1000, 0)
		pUnit:RegisterEvent("Putridus_TricksterCut", 4000, 0)
		pUnit:RegisterEvent("Putridus_TricksterSlice", 10000, 0)
	end
end

function Putridus_Tricksterphase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(15593)
	end
end


function Putridus_TricksterCut(pUnit, event)
	pUnit:FullCastSpellOnTarget(32009, pUnit:GetRandomPlayer(0))
end

function Putridus_TricksterSlice(pUnit, event)
	pUnit:FullCastSpellOnTarget(4285, pUnit:GetRandomPlayer(0))
end

function Putridus_Trickster_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Putridus_Trickster_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(11791, 1, "Putridus_Trickster_OnCombat")
RegisterUnitEvent(11791, 2, "Putridus_Trickster_OnLeaveCombat")
RegisterUnitEvent(11791, 4, "Putridus_Trickster_OnDeath")
RegisterUnitEvent(11790, 1, "Putridus_Trickster_OnCombat")
RegisterUnitEvent(11790, 2, "Putridus_Trickster_OnLeaveCombat")
RegisterUnitEvent(11790, 4, "Putridus_Trickster_OnDeath")


function Spewed_Larva_OnCombat(pUnit, event)
	pUnit:CastSpell(19630)
	pUnit:RegisterEvent("Spewed_Larvaphase1", 1000, 0)
	pUnit:RegisterEvent("Spewed_LarvaChainFireball", 2500, 0)
end

function Spewed_Larvaphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:FullCastSpellOnTarget(20420, pUnit:GetRandomPlayer(0))
		pUnit:RegisterEvent("Spewed_Larvaphase2", 1000, 0)
	end
end

function Spewed_Larvaphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Spewed_Larvaphase5", 1000, 0)
		pUnit:RegisterEvent("Spewed_LarvaFireball", 6000, 0)
	end
end

function Spewed_Larvaphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Spewed_LarvaFireShield", 4400, 0)
		pUnit:RegisterEvent("Spewed_LarvaFireball", 6000, 0)
	end
end

function Spewed_LarvaChainFireball(pUnit, event)
	pUnit:FullCastSpellOnTarget(35853, pUnit:GetRandomPlayer(0))
end

function Spewed_LarvaFireball(pUnit, event)
	pUnit:FullCastSpellOnTarget(21162, pUnit:GetRandomPlayer(0))
end

function Spewed_LarvaFireShield(pUnit, event)
	pUnit:CastSpell(38733)
end

function Spewed_Larva_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Spewed_Larva_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(13533, 1, "Spewed_Larva_OnCombat")
RegisterUnitEvent(13533, 2, "Spewed_Larva_OnLeaveCombat")
RegisterUnitEvent(13533, 4, "Spewed_Larva_OnDeath")


function Vine_Larva_OnCombat(pUnit, event)
	pUnit:CastSpell(12278)
	pUnit:RegisterEvent("Vine_Larvaphase1", 1000, 0)
	pUnit:RegisterEvent("Vine_LarvaChainFireball", 4000, 0)
end

function Vine_Larvaphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:FullCastSpellOnTarget(20420, pUnit:GetRandomPlayer(0))
		pUnit:RegisterEvent("Vine_Larvaphase2", 1000, 0)
	end
end

function Vine_Larvaphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Vine_Larvaphase5", 1000, 0)
		pUnit:RegisterEvent("Vine_LarvaFireball", 6000, 0)
	end
end

function Vine_Larvaphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Vine_LarvaFireShield", 15000, 0)
		pUnit:RegisterEvent("Vine_LarvaFireball", 6000, 0)
	end
end



function Vine_LarvaChainFireball(pUnit, event)
	pUnit:FullCastSpellOnTarget(35853, pUnit:GetRandomPlayer(0))
end

function Vine_LarvaFireball(pUnit, event)
	pUnit:FullCastSpellOnTarget(18199, pUnit:GetRandomPlayer(0))
end

function Vine_LarvaFireShield(pUnit, event)
	pUnit:CastSpell(19627)
end

function Vine_Larva_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Vine_Larva_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12218, 1, "Vine_Larva_OnCombat")
RegisterUnitEvent(12218, 2, "Vine_Larva_OnLeaveCombat")
RegisterUnitEvent(12218, 4, "Vine_Larva_OnDeath")

function Pre_Behemoth_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(26281, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Pre_Behemothphase1", 1000, 0)
end

function Pre_Behemothphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(26167)
		pUnit:RegisterEvent("Pre_Behemothphase2", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 25000, 0)
	end
end

function Pre_Behemothphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Pre_Behemothphase3", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothCrush", 10000, 0)
	end
end

function Pre_Behemothphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Pre_Behemothphase4", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 25000, 0)
		pUnit:RegisterEvent("Pre_BehemothCrush", 10000, 0)
	end
end

function Pre_Behemothphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Pre_Behemothphase5", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 25000, 0)
		pUnit:CastSpell(26167)
	end
end

function Pre_Behemothphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(12734)
		pUnit:RegisterEvent("Pre_Behemothphase6", 1000, 0)
		pUnit:RegisterEvent("Pre_BehemothStomp", 25000, 0)
		pUnit:RegisterEvent("Pre_BehemothCrush", 7000, 0)
	end
end

function Pre_Behemothphase6(pUnit, event)
	if pUnit:GetHealthPct() < 17 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(12734)
		pUnit:RegisterEvent("Pre_BehemothCrush", 6000, 0)
	end
end


function Pre_BehemothStomp(pUnit, event)
	pUnit:CastSpell(27758)
end

function Pre_BehemothCrush(pUnit, event)
	pUnit:FullCastSpellOnTarget(33661, pUnit:GetRandomPlayer(0))
end

function Pre_Behemoth_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Pre_Behemoth_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12206, 1, "Pre_Behemoth_OnCombat")
RegisterUnitEvent(12206, 2, "Pre_Behemoth_OnLeaveCombat")
RegisterUnitEvent(12206, 4, "Pre_Behemoth_OnDeath")


function Putridus_Shadowstalker_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(30741, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Putridus_Shadowstalkerphase1", 1000, 0)
end

function Putridus_Shadowstalkerphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(26992)
		pUnit:RegisterEvent("Putridus_Shadowstalkerphase2", 1000, 0)
		pUnit:RegisterEvent("Putridus_ShadowstalkerCut", 4000, 0)
	end
end

function Putridus_Shadowstalkerphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Putridus_Shadowstalkerphase3", 1000, 0)
		pUnit:RegisterEvent("Putridus_ShadowstalkerCut", 4000, 0)
	end
end

function Putridus_Shadowstalkerphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Putridus_Shadowstalkerphase4", 1000, 0)
		pUnit:RegisterEvent("Putridus_ShadowstalkerSlice", 10000, 0)
	end
end

function Putridus_Shadowstalkerphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Putridus_Shadowstalkerphase6", 1000, 0)
		pUnit:RegisterEvent("Putridus_ShadowstalkerCut", 4000, 0)
		pUnit:RegisterEvent("Putridus_ShadowstalkerSlice", 10000, 0)
	end
end

function Putridus_Shadowstalkerphase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(15593)
	end
end


function Putridus_ShadowstalkerCut(pUnit, event)
	pUnit:FullCastSpellOnTarget(32009, pUnit:GetRandomPlayer(0))
end

function Putridus_ShadowstalkerSlice(pUnit, event)
	pUnit:FullCastSpellOnTarget(4285, pUnit:GetRandomPlayer(0))
end

function Putridus_Shadowstalker_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Putridus_Shadowstalker_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(11792, 1, "Putridus_Shadowstalker_OnCombat")
RegisterUnitEvent(11792, 2, "Putridus_Shadowstalker_OnLeaveCombat")
RegisterUnitEvent(11792, 4, "Putridus_Shadowstalker_OnDeath")