local Mistress_ID = 99999
local Minion_ID = 99998
local Minion = nil

function MistressAley_OnCombat(pUnit, Event)
		pUnit:RegisterEvent("MistressAley_Phase1", 1000, 0)
		pUnit:SendChatMessage(14, 0, "Do you think this is wise? Playing with SHADOW!")
end

function MistressAley_OnLeaveCombat(pUnit, Event)
		pUnit:RemoveEvents()
end

function MistressAley_OnKilledTarget(pUnit, Event)
		pUnit:SendChatMessage(14, 0, "Ahahaha! Puny mortals!")
end

function MistressAley_OnDeath(pUnit, Event)
		pUnit:SendChatMessage(14, 0, "Noo! Damn you mortals!!")
end

function MistressAley_Phase1(pUnit, Event)
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Spell_1", 10000, 0)
		pUnit:RegisterEvent("Spell_2", 7500, 0)
		pUnit:RegisterEvent("Spell_3", 20000, 0)
		pUnit:RegisterEvent("MistressAley_Phase2check", 1000, 0)
end

function MistressAley_Phase2check(pUnit, Event)
		if (pUnit:GetHealthPct() <= 50) then
				pUnit:RegisterEvent("MistressAley_Phase2start", 1, 1)
		end
end

function MistressAley_Phase2start(pUnit, Event, pPlayer)
		pUnit:RemoveEvents()
		local x = pUnit:GetX()
		local y = pUnit:GetY()
		local z = pUnit:GetZ()
		local o = pUnit:GetO()
		local map = pUnit:GetMapId()
		pUnit:SetFaction(35)
		pUnit:SendChatMessage(14, 0, "Ahahaha! Rise my minion! Rise and protect your master!")
		pUnit:RegisterEvent("Spell_4", 3000, 0)
		pUnit:RegisterEvent("MinionOfMistressAley_Check", 1000, 0)
		Minion = PerformIngameSpawn(1, Minion_ID, map, x, y, z, o, 7, 0)
end

function MinionOfMistressAley_Check(pUnit, Event)
		if (Minion:IsAlive() == false) then
				pUnit:RegisterEvent("MistressAley_Phase3", 1, 1)
		end
end

function MistressAley_Phase3(pUnit, Event)
		pUnit:RemoveEvents()
		pUnit:SetFaction(16)
		pUnit:SendChatMessage(14, 0, "Mhm, you killed my minion. Now I kill you!")
		pUnit:RegisterEvent("Spell_1", 7500, 0)
		pUnit:RegisterEvent("Spell_2", 6000, 0)
		pUnit:RegisterEvent("Spell_3", 10000, 0)
end

----------------------------------------------------------
----------------------- SPELLS -------------------------
----------------------------------------------------------
-------------         List of Spells used ---------------
----------------------------------------------------------
------------- Spell_1 = ShadowBolt Volley ---------
------------- Spell_2 = Mind Flay             ----------
------------- Spell_3 = Shadow Blast	----------
------------- Spell_4 = Flame Crash		----------
----------------------------------------------------------

function Spell_1(Unit, Event)
Unit:FullCastSpellOnTarget(70145, Unit:GetRandomPlayer(0))
end

function Spell_2(Unit, Event)
Unit:FullCastSpellOnTarget(52586, Unit:GetRandomPlayer(0))
end

function Spell_3(Unit, Event)
Unit:FullCastSpellOnTarget(41078, Unit:GetRandomPlayer(0))
end

function Spell_4(Unit, Event)
Unit:FullCastSpellOnTarget(40832, Unit:GetRandomPlayer(0))
end

RegisterUnitEvent(Mistress_ID, 1, "MistressAley_OnCombat")
RegisterUnitEvent(Mistress_ID, 2, "MistressAley_OnLeaveCombat")
RegisterUnitEvent(Mistress_ID, 3, "MistressAley_OnKilledTarget")
RegisterUnitEvent(Mistress_ID, 4, "MistressAley_OnDeath")