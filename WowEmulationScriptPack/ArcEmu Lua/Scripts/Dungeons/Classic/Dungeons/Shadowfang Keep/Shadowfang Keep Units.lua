--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]


function Rethilgore_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Rethilgore_SoulDrain", 1400, 0)
end

function Rethilgore_SoulDrain(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7295, GetRandomPlayer(0))
end

function Razorclaw_OnCombat(pUnit, Event)
	-- Nothing for Razorclaw.
end

function Baron_Silverlaine_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Baron_Silverlaine_Veil", 5000, 0)
end

function Baron_Silverlaine_Veil(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7068, pUnit:GetRandomPlayer(4)) 
end

function Commander_Springvale_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Commander_Springvale_Hammer", 11000, 0)
	pUnit:RegisterEvent("Commander_Springvale_Heal", 15765, 0)
end

function Commander_Springvale_Heal(pUnit, Event)
	pUnit:CastSpell(5573) 
	pUnit:CastSpell(1026)
end

function Commander_Springvale_Hammer(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7068, pUnit:GetRandomPlayer(0)) 
end

function Odo_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Odo_Rage1", 100, 0)
	pUnit:RegisterEvent("Odo_Rage2", 100, 0)
	pUnit:RegisterEvent("Odo_Rage3", 100, 0)
end

function Odo_Rage1(pUnit, Event)
	if (pUnit:GetHealthPct() == 45) then
		pUnit:CastSpell(7481) 
	end
end

function Odo_Rage2(pUnit, Event)
	if (pUnit:GetHealthPct() == 30) then
		pUnit:CastSpell(7483) 
	end
end
	
function Odo_Rage3(pUnit, Event)
	if (pUnit:GetHealthPct() == 15) then
		pUnit:CastSpell(7484) 
	end
end

function Fenrus_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Fenrus_Toxic", 951, 0)
end

function Fenrus_Toxic(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7125, pUnit:GetRandomPlayer(0))
end

function Nandos_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "You have disturbed my pack! Feel my wrath!")
	pUnit:RegisterEvent("Nandos_Worg", 5550, 6)
end	

function Nandos_Worg(pUnit, Event)
	RandomTimer5 = math.random(1,3)
	if RandomTimer5 == 1 then
		pUnit:CastSpell(7487)
	end
	if RandomTimer5 == 2 then
		pUnit:CastSpell(7488)
	end
	if RandomTimer5 == 3 then
		pUnit:CastSpell(7489)
	end
end	

function Arugal_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Arugal_Random", 1573, 0)
	pUnit:SendChatMessage(14, 0, "Feel my wrath!")
end

function Arugal_Random(pUnit, Event)
	RandomTimer7 = math.random(1,6)
	if RandomTimer7 == 1 then
		pUnit:FullCastSpellOnTarget(7588, pUnit:GetRandomPlayer(0)) 
	end
	if RandomTimer7 == 2 then
		pUnit:FullCastSpellOnTarget(7588, pUnit:GetRandomPlayer(0))
	end
	if RandomTimer7 == 3 then
		pUnit:FullCastSpellOnTarget(7588, pUnit:GetRandomPlayer(0)) 
	end
	if RandomTimer7 == 4 then
		pUnit:FullCastSpellOnTarget(7124, pUnit:GetRandomPlayer(0)) 
	end
	if RandomTimer7 == 5 then
		pUnit:CastSpell(7803) 
	end
	if RandomTimer7 == 6 then
		pUnit:FullCastSpellOnTarget(7621, pUnit:GetRandomPlayer(0)) 
	end
end

RegisterUnitEvent(4275, 1, "Arugal_OnCombat")
RegisterUnitEvent(3927, 1, "Nandos_OnCombat")
RegisterUnitEvent(4274, 1, "Fenrus_OnCombat")
RegisterUnitEvent(4279, 1, "Odo_OnCombat")
RegisterUnitEvent(4278, 1, "Commander_Springvale_OnCombat")
RegisterUnitEvent(3887, 1, "Baron_Silverlaine_OnCombat")
RegisterUnitEvent(3886, 1, "Razorclaw_OnCombat")
RegisterUnitEvent(3914, 1, "Rethilgore_OnCombat")