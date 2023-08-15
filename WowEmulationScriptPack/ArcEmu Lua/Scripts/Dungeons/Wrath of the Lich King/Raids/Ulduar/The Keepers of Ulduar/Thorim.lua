function Thorim_Define(pUnit, Event)
	pUnit:RegisterEvent("Thorim_Chat1", 1000, 0)
	pUnit:RegisterEvent("Thorim_Chat2", 3000, 0)
	pUnit:RegisterEvent("Thorim_Summon1", 25000, 0)
	pUnit:RegisterEvent("Thorim_Stormhammer", 30000, 0)
	pUnit:RegisterEvent("Thorim_Summon2", 45000, 0)
	pUnit:RegisterEvent("Thorim_SeathofLightning", 1000, 0)
	pUnit:RegisterEvent("Thorim_Summon3", 10000, 0)
	pUnit:RegisterEvent("Thorim_Summon4", 30000, 0)
	pUnit:RegisterEvent("Thorim_Summon5", 55000, 0)
	pUnit:RegisterEvent("Thorim_Phase1", 415000, 1)
	pUnit:RegisterEvent("Thorim_Phase2", 1000, 0)
	pUnit:RegisterEvent("Thorim_CheckDeath", 1000, 0)
end

function Thorim_Chat1(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "Interlopers! You mortals who dare to interfere with my sport will pay... Wait--you...")
end

function Thorim_Chat2(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "I remember you... In the mountains... But you... what is this? Where am--")
end

function Thorim_Summon1(pUnit, Event)
	pUnit:SpawnCreature(33110, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_Stormhammer(pUnit, Event)
	pUnit:FullCastSpellOnTarget(62042, pUnit:GetRandomPlayer(0))
end

function Thorim_Summon2(pUnit, Event)
	pUnit:SpawnCreature(32876, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_SeathofLightning(pUnit, Event)
	pUnit:CastSpell(62276)
end

function Thorim_Summon3(pUnit, Event)
	pUnit:SpawnCreature(32904, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_Summon4(pUnit, Event)
	pUnit:SpawnCreature(32878, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_Summon5(pUnit, Event)
	pUnit:SpawnCreature(32877, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_CheckDeath(pUnit, Event)
	if AncientRuneGiant:IsDead(true) then
		pUnit:SetFaction(14)
end
	if AncientRuneGiant:IsDead(false) then
end
end

function Thorim_Phase1(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:RegisterEvent("Thorim_Summon1", 25000, 0)
	pUnit:RegisterEvent("Thorim_Stormhammer", 30000, 0)
	pUnit:RegisterEvent("Thorim_Summon2", 45000, 0)
	pUnit:RegisterEvent("Thorim_SeathofLightning", 1000, 0)
	pUnit:RegisterEvent("Thorim_Summon3", 10000, 0)
	pUnit:RegisterEvent("Thorim_Summon4", 30000, 0)
	pUnit:RegisterEvent("Thorim_Summon5", 55000, 0)
	pUnit:RegisterEvent("Thorim_CheckDeath", 1000, 0)
	pUnit:RegisterEvent("Thorim_Phase3", 1000, 0)
end

function Thorim_Summon1(pUnit, Event)
	pUnit:SpawnCreature(33110, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_Stormhammer(pUnit, Event)
	pUnit:FullCastSpellOnTarget(62042, pUnit:GetRandomPlayer(0))
end

function Thorim_Summon2(pUnit, Event)
	pUnit:SpawnCreature(32876, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_SeathofLightning(pUnit, Event)
	pUnit:CastSpell(62276)
end

function Thorim_Summon3(pUnit, Event)
	pUnit:SpawnCreature(32904, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_Summon4(pUnit, Event)
	pUnit:SpawnCreature(32878, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_Summon5(pUnit, Event)
	pUnit:SpawnCreature(32877, x-cords, y-cords, z-cords, o-cords, 14, 500000)
end

function Thorim_CheckDeath(pUnit, Event)
	if AncientRuneGiant:IsDead(true) then
	pUnit:SetFaction(14)
end
	if AncientRuneGiant:IsDead(false) then
end
end

function Thorim_Phase2(pUnit, Event)
	if pUnit:GetHealthPct() <= 99 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "Impertinent whelps! You dare challenge me atop my pedestal! I will crush you myself!")
		pUnit:MoveTo(--[[Put the Coordinates where you mostly put the Summons Above--]])
		pUnit:RegisterEvent("Thorim_ChainLightning", 25500, 0)
		pUnit:RegisterEvent("Thorim_UnbalancingStrike", 50000, 0)
		pUnit:RegisterEvent("Thorim_Summon6", 5000, 1)
		pUnit:RegisterEvent("Thorim_Phase5", 1000, 0)
end
end

function Thorim_ChainLightning(pUnit, Event)
	pUnit:FullCastSpellOnTarget(62131, pUnit:GetRandomPlayer(0))
end

function Thorim_UnbalancingStrike(pUnit, Event)
	pUnit:CastSpellOnTarget(62279, pUnit:GetMainTank())
end

function Thorim_Summon6(pUnit, Event)
	local x = pUnit:GetX();
	local y = pUnit:GetY();
	local z = pUnit:GetZ();
	local o = pUnit:GetO();
		pUnit:SpawnCreature (33196, x, y, z, o, 14 , 60000000);
end

function Thorim_Phase3(pUnit, Event)
	if pUnit:GetHealthPct() <= 99 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "Impertinent whelps! You dare challenge me atop my pedestal! I will crush you myself!")
		pUnit:MoveTo(--[[Put the Coordinates where you mostly put the Summons Above--]])
		pUnit:RegisterEvent("Thorim_ChainLightning", 15500, 0)
		pUnit:RegisterEvent("Thorim_UnbalancingStrike", 30000, 0)
		pUnit:CastSpell(62565)
		pUnit:RegisterEvent("Thorim_Phase4", 1000, 0)
end
end

function Thorim_ChainLightning(pUnit, Event)
	pUnit:FullCastSpellOnTarget(62131, pUnit:GetRandomPlayer(0))
end

function Thorim_UnbalancingStrike(pUnit, Event)
	pUnit:CastSpellOnTarget(62279, pUnit:GetMainTank())
end

function Thorim_Phase4(pUnit, Event)
	if pUnit:GetHealthPct() <= 1 then
		pUnit:RemoveEvents()
		pUnit:SetFaction(35)
		pUnit:SendChatMessage(14, 0, "Stay your arms! I yield!")
		pUnit:RegisterEvent("Thorim_Chat3", 1000, 0)
		pUnit:RegisterEvent("Thorim_Chat4", 3000, 0)
		pUnit:RegisterEvent("Thorim_Chat5", 5000, 0)
		pUnit:RegisterEvent("Thorim_Box", 1000, 0)
end
end

function Thorim_Chat3(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "I feel as though I am awakening from a nightmare, but the shadows in this place yet linger.")
end

function Thorim_Chat4(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "Sif... was Sif here? Impossible--she died by my brother's hand. A dark nightmare indeed....")
end

function Thorim_Chat5(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "I need time to reflect.... I will aid your cause if you should require it. I owe you at least that much. Farewell.")
	pUnit:RemoveFromWorld()
end

function Thorim_Box(pUnit, Event)
	pUnit:SpawnGameObject(194312, 1000000)
end

function Thorim_Phase5(pUnit, Event)
	if pUnit:GetHealthPct() <= 1 then
		pUnit:RemoveEvents()
		pUnit:SetFaction(35)
		pUnit:Root()
		pUnit:SendChatMessage(14, 0, "Stay your arms! I yield!")
		pUnit:RegisterEvent("Thorim_Chat6", 1000, 0)
		pUnit:RegisterEvent("Thorim_Chat7", 3000, 0)
		pUnit:RegisterEvent("Thorim_Chat8", 5000, 0)
		pUnit:RegisterEvent("Thorim_Box", 1000, 0)
end
end

function Thorim_Chat6(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "You! Fiend! You are not my beloved! Be gone!")
end

function Thorim_Chat7(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "Behold the hand behind all the evil that has befallen Ulduar! Left my kingdom in ruins, corrupted my brother and slain my wife!")
end

function Thorim_Chat8(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "And now it falls to you, champions, to avenge us all! The task before you is great, but I will lend you my aid as I am able. You must prevail!")
	pUnit:RemoveFromWorld()
end

function Thorim_Box(pUnit, Event)
	pUnit:SpawnGameObject(194312, 1000000)
end

function Thorim_OnCombat(pUnit, Event)
end

function Thorim_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveFromWorld()
	pUnit:RegisterEvent("Thorim_Summon7", 0, 1)
end

function Thorim_Summon7(pUnit, Event)
			local x = pUnit:GetX();
			local y = pUnit:GetY();
			local z = pUnit:GetZ();
			local o = pUnit:GetO();
				pUnit:SpawnCreature (32882, x, y, z, o, 14, 60000000);
end

RegisterUnitEvent(32865, 18, "Thorim_Define")
RegisterUnitEvent(32865, 1, "Thorim_OnCombat")
RegisterUnitEvent(32865, 2, "Thorim_OnLeaveCombat")