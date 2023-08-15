--[[ Molten Core - Thrash mobs

This is all the thrash mobs scripted in Molten Core.

~~End of Script Forenote
-- Viggo-xd, November 29th, 2008. ]]--


-----Molten Giant-----

function MoltenGiant_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("MoltenGiant_Smash", 20000,1)
	pUnit:RegisterEvent("MoltenGiant_Knockback", 10000,1)
end

function MoltenGiant_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function MoltenGiant_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function MoltenGiant_Smash(pUnit, Event)
    pUnit:FullCastSpellOnTarget(18944,pUnit:GetClosestPlayer())
end

function MoltenGiant_Knockback(pUnit, Event)
    pUnit:FullCastSpellOnTarget(18945,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(11658, 1, "MoltenGiant_OnEnterCombat")
RegisterUnitEvent(11658, 2, "MoltenGiant_OnDied")
RegisterUnitEvent(11658, 4, "MoltenGiant_OnLeaveCombat")

-----Molten Destroyer-----

function MoltenDestroyer_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("MoltenDestroyer_Knockdown", 10000,1)
	pUnit:RegisterEvent("MoltenDestroyer_MassiveTremor", 10000,1)
end

function MoltenDestroyer_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end
function MoltenDestroyer_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function MoltenDestroyer_Knockdown(pUnit, Event)
    pUnit:FullCastSpellOnTarget(20276,pUnit:GetClosestPlayer())
end

function MoltenDestroyer_MassiveTremor(pUnit, Event)
    pUnit:FullCastSpellOnTarget(19129,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(11659, 1, "MoltenDestroyer_OnEnterCombat")
RegisterUnitEvent(11659, 2, "MoltenDestroyer_OnDied")
RegisterUnitEvent(11659, 4, "MoltenDestroyer_OnLeaveCombat")

-----Firelord-----

function Firelord_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("Firelord_Fireball", 10000,1)
	pUnit:RegisterEvent("Firelord_FireSpawn", 15000,1)
end

function FireLord_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function FireLord_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Firelord_Fireball(pUnit, Event)
    pUnit:FullCastSpellOnTarget(48246,pUnit:GetClosestPlayer())
end

function Firelord_FireSpawn(pUnit, Event)
    pUnit:FullCastSpellOnTarget(19392,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(11668, 1, "Firelord_OnEnterCombat")
RegisterUnitEvent(11668, 2, "FireLord_OnDied")
RegisterUnitEvent(11668, 4, "FireLord_OnLeaveCombat")

-----Lava Spawn-----

function LavaSpawn_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("LavaSpawn_Split", 10000,1)
	pUnit:RegisterEvent("LavaSpawn_Fireball", 5000,1)
end

function LavaSpawn_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaSpawn_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaSpawn_Split(pUnit, Event)
    pUnit:FullCastSpellOnTarget(19570,pUnit:GetClosestPlayer())
end

function LavaSpawn_Fireball(pUnit, Event)
    pUnit:FullCastSpellOnTarget(19391,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(12265, 1, "LavaSpawn_OnEnterCombat")
RegisterUnitEvent(12265, 2, "LavaSpawn_OnDied")
RegisterUnitEvent(12265, 4, "LavaSpawn_OnLeaveCombat")


-----Ancient Core Hound-----

function AncientCoreHound_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("AncientCoreHound_Debuffs", 30000, 0)
	pUnit:RegisterEvent("AncientCoreHound_Bite", 10000, 1)
	pUnit:RegisterEvent("AncientCoreHound_LavaBreath", 20000, 1)
end

function AncientCoreHound_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function AncientCoreHound_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function AncientCoreHound_Bite(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19319,pUnit:GetClosestPlayer())
end

function AncientCoreHound_LavaBreath(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19272,pUnit:GetClosestPlayer())
end

function AncientCoreHound_Debuffs(pUnit,Event)
local Choice = math.random(1, 6)
	if Choice == 1 then
		pUnit:FullCastSpellOnTarget(19367,pUnit:GetClosestPlayer()) 
	end
	if Choice == 2 then
		pUnit:FullCastSpellOnTarget(19369,pUnit:GetClosestPlayer()) 
	end
	if Choice == 3 then
		pUnit:FullCastSpellOnTarget(19365,pUnit:GetClosestPlayer())
	end
	if Choice == 4 then
		pUnit:FullCastSpellOnTarget(19372,pUnit:GetClosestPlayer())
	end
	if Choice == 5 then
		pUnit:FullCastSpellOnTarget(19366,pUnit:GetClosestPlayer())
	end
	if Choice == 6 then
		pUnit:FullCastSpellOnTarget(19364,pUnit:GetClosestPlayer())
	end
end

RegisterUnitEvent(11673, 1, "AncientCoreHound_OnEnterCombat")
RegisterUnitEvent(11673, 2, "AncientCoreHound_OnDied")
RegisterUnitEvent(11673, 4, "AncientCoreHound_OnLeaveCombat")


-----Lava Surger-----

function LavaSurger_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("LavaSurger_Charge", 10000, 0)
end

function LavaSurger_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaSurger_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaSurger_Charge(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19196,pUnit:GetRandomPlayer(3))
end

RegisterUnitEvent(12101, 1, "LavaSurger_OnEnterCombat")
RegisterUnitEvent(12101, 2, "LavaSurger_OnDied")
RegisterUnitEvent(12101, 4, "LavaSurger_OnLeaveCombat")

-----Core Hound-----

function CoreHound_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent ("CoreHound_Bite", 5000, 0)
end

function CoreHound_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function CoreHound_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function CoreHound_Bite(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19771,pUnit:GetMainTank())
end

RegisterUnitEvent(11671, 1, "CoreHound_OnEnterCombat")
RegisterUnitEvent(11671, 2, "CoreHound_OnDied")
RegisterUnitEvent(11671, 4, "CoreHound_OnLeaveCombat")

-----Lava Pack (alot of Lava's)-----


function LavaReaver_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("LavaReaver_Cleave", 5000, 0)
end

function LavaReaver_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaReaver_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaReaver_Cleave(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19642, pUnit:GetClosestPlayer())
end

RegisterUnitEvent(12100, 1, "LavaReaver_OnEnterCombat")
RegisterUnitEvent(12100, 2, "LavaReaver_OnDied")
RegisterUnitEvent(12100, 4, "LavaReaver_OnLeaveCombat")

function LavaElemental_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("LavaReaver_Pyroclast", 10000, 0)
end

function LavaElemental_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaElemental_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function LavaElemental_Pyroclast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19641, pUnit:GetMainTank())
end

RegisterUnitEvent(12076, 1, "LavaElemental_OnEnterCombat")
RegisterUnitEvent(12076, 2, "LavaElemental_OnDied")
RegisterUnitEvent(12076, 4, "LavaElemental_OnLeaveCombat")


function Flameguard_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("Flameguard_ArmorDebuff", 10000, 0)
	pUnit:RegisterEvent("Flameguard_ConeofFire", 10000, 0)
end

function Flameguard_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function Flameguard_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Flameguard_ArmorDebuff(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19631, pUnit:GetMainTank())
end

function Flameguard_ConeofFire(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19630, pUnit: GetRandomPlayer(0))
end

RegisterUnitEvent(11667, 1, "Flameguard_OnEnterCombat")
RegisterUnitEvent(11667, 2, "Flameguard_OnDied")
RegisterUnitEvent(11667, 4, "Flameguard_OnLeaveCombat")

function Firewalker_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("Firewalker_ResistDebuff", 15000, 0)
	pUnit:RegisterEvent("Firewalker_FireBlossom", 10000, 0)
end

function Firewalker_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

function Firewalker_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Firewalker_ResistDebuff(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19635, pUnit:GetRandomPlayer(0))
end

function Firewalker_FireBlossom(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19636, pUnit:GetMainTank())
end

RegisterUnitEvent(11666, 1, "Firewalker_OnEnterCombat")
RegisterUnitEvent(11666, 2, "Firewalker_OnDied")
RegisterUnitEvent(11666, 4, "Firewalker_OnLeaveCombat")