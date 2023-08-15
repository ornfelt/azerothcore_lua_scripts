function Bronjahm_OnCombat (pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Finally a captive audience!")
	pUnit:PlaySoundToSet(16595)
	pUnit:RegisterEvent("Bronjahm_Magicbane", 5000, 0)
	pUnit:RegisterEvent("Bronjahm_Corruptsoul", 18000, 0)
	pUnit:RegisterEvent("Bronjahm_Phase1", 1000, 1)
end

function Bronjahm_Magicbane (pUnit, Event)
	pUnit:FullCastSpellOnTarget(68793, pUnit:GetMainTank())
end

function Bronjahm_Corruptsoul (pUnit, Event)
	pUnit:FullCastSpellOnTarget (68839, pUnit:GetRandomPlayer(0))
	pUnit:SendChatMessage (12, 0, "I will sever your soul from your body!")
end

function Bronjahm_Phase1(pUnit, Event)
	if pUnit:GetHealthPct() < 30 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(12, 0, "The vortex of the harvested calls to you!")
		pUnit:RegisterEvent("Bronjahm_Teleport", 1000, 1)
	end
end

function Bronjahm_Teleport(pUnit, Event)
	pUnit:FullCastSpell(68988)
	pUnit:TeleportCreature(5297.43, 2506.55, 686.068)
	pUnit:RegisterEvent("Bronjahm_Soulstorm", 1000, 1)
end

function Bronjahm_Soulstorm(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Another soul to strengthen the host!")
	pUnit:FullCastSpell(68872)
	pUnit:Root()
	pUnit:RegisterEvent("Bronjahm_Shadowbolt", 2000, 0)
end

function Bronjahm_Shadowbolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(70043, pUnit:GetMainTank())
end

function Bronjahm_OnKillPlr (pUnit, Event)
	pUnit:SendChatMessage (12, 0, "Fodder for the engine!")
	pUnit:PlaySoundToSet(16596)
end

function Bronjahm_OnDeath (pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:PlaySoundToSet(16598)
end

function Bronjahm_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(36497, 1, "Bronjahm_OnCombat")
RegisterUnitEvent(36497, 2, "Bronjahm_OnLeaveCombat")
RegisterUnitEvent(36497, 3, "Bronjahm_OnKillPlr")
RegisterUnitEvent(36497, 4, "Bronjahm_OnDeath")