----------------------------------------------------------------
--------------------- Created by Agger -------------------------
---------------------    AC-WEB.ORG    -------------------------
----------------------------------------------------------------
local NPC_ID = 99997

function Drakthoar_OnCombat(Unit, Event)
		Unit:SendChatMessage(14, 0, "Haha, do ya think ya can beat me mon!")
		Unit:RegisterEvent("Drakthoar_Phase1", 1000, 0)
end

function Drakthoar_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function Drakthoar_OnKilledTarget(Unit, Event)
		Unit:SendChatMessage(14, 0, "Ya should say yes to my offer mon!")
end

function Drakthoar_OnDeath(Unit, Event)
		Unit:SendChatMessage(14, 0, "What, NO! Dis cannot be happening!")
		Unit:RemoveEvents()
end

function Drakthoar_Phase1(Unit, Event)
		Unit:RemoveEvents()
		Unit:RegisterEvent("Spell_1", 7500, 0)
		Unit:RegisterEvent("Spell_2", 18000, 0)
		Unit:RegisterEvent("Drakthoar_Check1", 1000, 0)
end

function Drakthoar_Check1(Unit, Event)
		if (Unit:GetHealthPct() <= 65) then
				Unit:RegisterEvent("Drakthoar_Phase2", 1, 1)
		end
end

function Drakthoar_Phase2(Unit, Event)
		Unit:RemoveEvents()
		Unit:RegisterEvent("Spell_3", 30000, 0)
		Unit:RegisterEvent("Spell_4", 16000, 0)
		Unit:RegisterEvent("Spell_5", 7000, 0)
		Unit:RegisterEvent("Drakthoar_Check2", 1000, 0)
end

function Drakthoar_Check2(Unit, Event)
		if (Unit:GetHealthPct() <= 45) then
				Unit:RegisterEvent("Drakthoar_Phase3", 1, 1)
		end
end

function Drakthoar_Phase3(Unit, Event)
		Unit:RemoveEvents()
		Unit:RegisterEvent("Spell_6", 7000, 0)
		Unit:RegisterEvent("Spell_7", 25000, 0)
		Unit:RegisterEvent("Spell_8", 7500, 0)
		Unit:RegisterEvent("Drakthoar_Check3", 1000, 0)
end

function Drakthoar_Check3(Unit, Event)
		if (Unit:GetHealthPct() <= 5) then
				Unit:RegisterEvent("Drakthoar_end", 1, 1)
		end
end

function Drakthoar_end(Unit, Event)
		Unit:RemoveEvents()
		Unit:CastSpellOnTarget(40647, Unit:GetRandomPlayer(0))
		Unit:SendChatMessage(14, 0, "Hahaha! What you gonna do now mon? You fools shouldn't have come! You can't do anything while trapped in dat shadow prison mon! I will kill you all! Ahaha!")
		Unit:RegisterEvent("Drakthoar_Check4", 25000, 0)
end

function Drakthoar_Check4(Unit, Event)
		if (Unit:GetHealthPct() <= 5) then
				Unit:RegisterEvent("Drakthoar_Chat", 1, 1)
		end
end

function Drakthoar_Chat(Unit, Event)
		Unit:RemoveEvents()
		Unit:SendChatMessage(14, 0, "Ahaha, come at me mon!")
end

---------------------------------------------------------
------------------------ Spells -------------------------
---------------------------------------------------------
-------------------- List of Spells ---------------------
---------------------------------------------------------
-------------- Spell_1 = FireBall		    -------------
-------------- Spell_2 = Fel-Acid Breath    -------------
-------------- Spell_3 = HurtFul Strike	    -------------
-------------- Spell_4 = Shadow Bolt		-------------
-------------- Spell_5 = Legion Lightning	-------------
-------------- Spell_6 = Blast Wave			-------------
-------------- Spell_7 = Cleave				-------------
-------------- Spell_8 = FrostBolt			-------------
---------------------------------------------------------

function Spell_1(Unit, Event)
Unit:FullCastSpellOnTarget(40598, Unit:GetRandomPlayer(0))
end

function Spell_2(Unit, Event)
Unit:FullCastSpellOnTarget(40508, Unit:GetRandomPlayer(0))
end

function Spell_3(Unit, Event)
Unit:FullCastSpellOnTarget(33813, Unit:GetRandomPlayer(0))
end

function Spell_4(Unit, Event)
Unit:FullCastSpellOnTarget(71143, Unit:GetRandomPlayer(0))
end

function Spell_5(Unit, Event)
Unit:FullCastSpellOnTarget(45664, Unit:GetRandomPlayer(0))
end

function Spell_6(Unit, Event)
Unit:FullCastSpellOnTarget(33061, Unit:GetRandomPlayer(0))
end

function Spell_7(Unit, Event)
Unit:FullCastSpellOnTarget(31345, Unit:GetRandomPlayer(0))
end

function Spell_8(Unit, Event)
Unit:FullCastSpellOnTarget(59855, Unit:GetRandomPlayer(0))
end

RegisterUnitEvent(99997, 1, "Drakthoar_OnCombat")
RegisterUnitEvent(99997, 2, "Drakthoar_OnLeaveCombat")
RegisterUnitEvent(99997, 3, "Drakthoar_OnKilledTarget")
RegisterUnitEvent(99997, 4, "Drakthoar_OnDeath")