local UGLY = 930005
local EVENMOREuGLY = 930002
local OOZE = 930011
local BEAST = 930010
local ZOMBIE = 930008
local BANDIT = 930007 

function ugly_OnCombat(pUnit, event)
	pUnit:RegisterEvent("VileSlime", math.random(10000, 16000), 0)
	pUnit:RegisterEvent("AcidBreath", math.random(9000, 20000), 0)
end

function VileSlime(pUnit, event)
	pUnit:FullCastSpellOnTarget(40099, pUnit:GetRandomPlayer(0))
end

function AcidBreath(pUnit, event)
	pUnit:CastSpell(56524)
end

function ugly_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function ugly_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(UGLY, 1, "ugly_OnCombat")
RegisterUnitEvent(UGLY, 2, "ugly_OnLeaveCombat")
RegisterUnitEvent(UGLY, 4, "ugly_OnDeath")

function EvenMoreUgly(pUnit, event)
	pUnit:RegisterEvent("Emporer", 10000, 0)
	pUnit:RegisterEvent("DeathAndDecay", 20000, 0)
	pUnit:RegisterEvent("ShadowBolt", 4000, 0)
end

function Emporer(pUnit, event)
	pUnit:CastSpell(39364)
end

function DeathAndDecay(pUnit, event)
	local plr = pUnit:GetRandomPlayer(0)
	local x = plr:GetX()
	local z = plr:GetZ()
	local y = plr:GetY()
	pUnit:CastSpellAoF(x, y, z, 61603)
end

function ShadowBolt(pUnit, event)
	pUnit:FullCastSpellOnTarget(69212, pUnit:GetRandomPlayer(0))
end

function EvenMoreUgly_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function EvenMoreUgly_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(EVENMOREuGLY, 1, "EvenMoreUgly")
RegisterUnitEvent(EVENMOREuGLY, 2, "EvenMoreUgly_OnLeaveCombat")
RegisterUnitEvent(EVENMOREuGLY, 4, "EvenMoreUgly_OnDeath")

local oozedeath = 0
local rage = 71603

function Ooze_OnSpawn(pUnit, event)
	oozedeath = 0
end

function Ooze_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Ooze_Explode", 35000, 1)
	pUnit:RegisterEvent("Slime", 15000, 1)
end

function Ooze_Explode(pUnit, event)
	pUnit:FullCastSpell(67886)
end

function Slime(pUnit, event)
	pUnit:CastSpell(73024)
end

function Ooze_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function Ooze_OnDeath(pUnit, event)
	oozedeath = 1
end

RegisterUnitEvent(OOZE, 1, "Ooze_OnCombat")
RegisterUnitEvent(OOZE, 2, "Ooze_OnLeaveCombat")
RegisterUnitEvent(OOZE, 4, "Ooze_OnDeath")
RegisterUnitEvent(OOZE, 18, "Ooze_OnSpawn")

function Beast_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Slam", math.random(12000, 16000), 0)
	pUnit:RegisterEvent("Rage", 35000, 1)
end

function Slam(pUnit, event)
	pUnit:FullCastSpellOnTarget(50234, pUnit:GetPrimaryCombatTarget())
end

function Rage(pUnit, event)
	local friend = pUnit:GetInRangeFriends()
		for _,v in pairs(friend) do
			if(v:GetEntry() == OOZE) and (oozedeath == 1) then
				pUnit:CastSpell(rage)
				end
		end
end

function Beast_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function Beast_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(BEAST, 1, "Beast_OnCombat")
RegisterUnitEvent(BEAST, 2, "Beast_OnLeaveCombat")
RegisterUnitEvent(BEAST, 4, "Beast_OnDeath")

function zombie_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Bite", math.random(14000, 18000), 0)
end

function Bite(pUnit, event)
	pUnit:FullCastSpellOnTarget(54772, pUnit:GetMainTank())
end

function zombie_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function zombie_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(ZOMBIE, 1, "zombie_OnCombat")
RegisterUnitEvent(ZOMBIE, 2, "zombie_OnLeaveCombat")
RegisterUnitEvent(ZOMBIE, 4, "zombie_OnDeath")

function Bandit_OnSpawn(pUnit, event)
	local choice = math.random(1, 4)
	if(choice == 1) then
	pUnit:EquipWeapons(40384, 0, 0)
	elseif(choice == 2) then
	pUnit:EquipWeapons(12592, 0, 0)
	elseif(choice == 3) then
	pUnit:EquipWeapons(49919, 0, 0)
	elseif(choice == 4) then
	pUnit:EquipWeapons(50759, 40266, 0)
	end
end


function Bandit_OnCombat(pUnit, event)
	pUnit:RegisterEvent("MortalStrike", math.random(14000, 16000), 0)
	pUnit:RegisterEvent("Rend", math.random(21000, 34000), 0)
	local choice = math.random(1, 4)
	if(choice == 1) then
	pUnit:SendChatMessage(12, 0, "New flesh.. new items!")
	elseif(choice == 2) then
	pUnit:SendChatMessage(12, 0, "I'll rip your heart out!")
	elseif(choice == 3) then
	pUnit:SendChatMessage(12, 0, "Let's play shall we?!")
	elseif(choice == 4) then
	pUnit:SendChatMessage(12, 0, "Looks like we've caught dinner!")
	end
end

function MortalStrike(pUnit, event)
	pUnit:CastSpellOnTarget(35054, pUnit:GetPrimaryCombatTarget())
end

function Rend(pUnit, event)
	pUnit:CastSpellOnTarget(36965, pUnit:GetPrimaryCombatTarget())
end

function Bandit_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Bandit_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(BANDIT, 1, "Bandit_OnCombat")
RegisterUnitEvent(BANDIT, 2, "Bandit_OnLeaveCombat")
RegisterUnitEvent(BANDIT, 4, "Bandit_OnDeath")
RegisterUnitEvent(BANDIT, 18, "Bandit_OnSpawn")



	
	

