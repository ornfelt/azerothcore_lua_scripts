-- This is the shittest script I have ever done... Seriously it is so bad, but I can't be bothered to rewrite it so deal with it!

local PlayerAA = nil -- To Quest 829
local pla = nil -- Quest 831
local Zog = nil -- Quest 831
local PPL = nil -- Quest 849

function OnQuestAccept(event, pPlayer, questId, pQuestGiver)
----------------------------------------------------------------------------------------
	if (questId == 100108) then -- Dark Side Attack
	pPlayer:SetPhase(2)
	end
	if (questId == 100110) then
	pPlayer:SetPhase(1)
	pPlayer:Teleport(1, 16202.920898, 15790.269531, 2.970347)
	end
	if (questId == 40) then
	pPlayer:Teleport(0, -7454.8, -2209.5, 169.5)
	end
	if (questId == 75) then
	pPlayer:Teleport(0, -7889, -2660.3, 223)
	end
	if (questId == 45) then
	pPlayer:SetPhase(2)
	pPlayer:Teleport(0, -8126, -806, 149.5)
	end
	if (questId == 304) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(8057, -2453, 7, 6, 0, "'Portal'")
	end
	if (questID == 90500) then
	pPlayer:GossipSendPOI(1099.130005, -2429.449951, 43, 6, 0, "Commander Aghore")
	pPlayer:CastSpell(68860)
	end
	if (questId == 90501) then
	pPlayer:GossipSendPOI(1203.692871, -2394.319580, 43, 6, 0, "Zombies Village")
	pPlayer:CastSpell(68860)
	end
	if (questId == 90505) then
	pPlayer:GossipSendPOI(1209.979980, -2365.479980, 43, 6, 0, "Captured Human")
	pPlayer:CastSpell(68860)
	end
----------------------------------------------------------------------------------------
	if (questId == 800) then -- Horde onwards
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6501, -1941, 7, 6, 0, "Apothecary")
	end
	if (questId == 802) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6605, -1869, 7, 6, 0, "Captured Soldier")
	end
	if (questId == 803) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6774, -1794, 7, 6, 0, "Civilians")
	end
	if (questId == 804) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6490, -2004, 7, 6, 0, "Tree")
	end
	if (questId == 805) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6805, -1854, 7, 6, 0, "Magister Trevor")
	end
	if (questId == 806) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6974, -1729, 7, 6, 0, "Edward Cenclardo")
	end
	if (questId == 807) then
	SetDBCSpellVar(16739, "c_is_flags", 0x01000)
	pPlayer:FullCastSpell(16739)
	pPlayer:GossipSendPOI(-7008, -1748, 7, 6, 0, "Dig Master Wolly")
	pPlayer:SetPhase(2)
	end
	if (questId == 808) then
	pPlayer:RemoveAura(16739)
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6395, -1942, 7, 6, 0, "The Captain")
	end
	if (questId == 811) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-7174, -1874, 7, 6, 0, "Archmage Vangoth")
	end
	if (questId == 812) then
	pPlayer:SetPhase(2)
	pQuestGiver:SpawnCreature(151519, -7205, -1964, 312, 1, 35, 0)
	end
	if (questId == 813) then
	pPlayer:SetPhase(1)
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-7230, -1740, 7, 6, 0, "Razzak")
	end
	if (questId == 814) then
	pPlayer:CastSpell(2825)
	end
	if (questId == 815) then
	pPlayer:CastSpell(37962) -- Soaring
	pPlayer:CastSpell(33271) -- God knows
	--pPlayer:SetPlayerWeather(4,2) -- This looks ugly as it rains a lot in searing gorge already
	pPlayer:CastSpell(50203) -- Fog
	pPlayer:MovePlayerTo(-6605, -1481, 292, 3.556944, 12288, 45)
	end
	if (questId == 816) then
	pPlayer:CastSpell(28136)
	pPlayer:CastSpell(58538)
	pPlayer:RemoveAura(50203)
	pPlayer:GossipSendPOI(-6691, -1411, 7, 6, 0, "Razzak")
	end
	if (questId == 817) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6693, -1601, 7, 6, 0, "Unstable Crystal")
	end
	if (questId == 819) then
	pPlayer:GossipSendPOI(-6658, -1540, 7, 6, 0, "Kazmok")
	end
	if (questId == 820) then
	local name = pPlayer:GetName()
	pQuestGiver:SendChatMessage(12, 0 ,"Go with peace "..name..". You have my blessing.")
	--pQuestGiver:FullCastSpell(24217)
	pPlayer:FullCastSpell(46242)
	pPlayer:GossipSendPOI(-6891, -1621, 7, 6, 0, "Haldrin")
	end
	if (questId == 821) then
	pPlayer:FullCastSpell(10689)
	end
	if (questId == 851) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6686, -1341, 7, 6, 0, "Vodoo Doll")
	end
	if (questId == 822) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6926, -1442, 7, 6, 0, "Naturist Flora")
	end
	if (questId == 823) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6735, -1104, 7, 6, 0, "Horde Rogue")
	end
	if (questId == 826) then
	pPlayer:CastSpell(64446)
	pPlayer:Teleport(0,-6434.2, -1114, 314.3)
	pPlayer:PlaySoundToSet(6077)
	pPlayer:SetPhase(2)
	end
	if (questId == 827) then
	pPlayer:SetPhase(4)
	pPlayer:PlaySoundToSet(14869)
	pPlayer:PlaySoundToSet(16022)
	end
	if (questId == 828) then
	pPlayer:SetPhase(1)
	pPlayer:CastSpell(64446)
	pPlayer:Teleport(0, -6725, -1078, 270)
	end
	if (questId == 829) then
	PlayerAA = pPlayer
	pPlayer:SetPhase(4)
	pPlayer:CastSpell(5267)
	pPlayer:CastSpell(22650)
	pPlayer:CastSpell(51347)
	pPlayer:Teleport(0, -6632.10887, -1229.971924, 209.810593)
	RegisterTimedEvent("themagicalmomentsofalittlecinematichehe", 4000, 1)
	end
	if (questId == 830) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6500, -1173, 7, 6, 0, "General Zog")
	end
	if (questId == 831) then
	pPlayer:SetPlayerLock(1)
	pPlayer:MovePlayerTo(-6504.8, -1167, 327.5, 5.366923, 256)
	RegisterTimedEvent("StrangleHim_LOLAGN", 100, 1)
	pla = pPlayer
	Zog = pQuestGiver
	end
	if (questId == 832) then
	pPlayer:CastSpell(64446)
	pPlayer:Teleport(0, -6736, -1223, 207)
	end
	if (questId == 833) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6611, -864, 7, 6, 0, "Spirits")
	end
	if (questId == 834) then
	SetDBCSpellVar(61611, "c_is_flags", 0x01000)
	pPlayer:CastSpell(61611)
	end
	if (questId == 836) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6749, -1016, 7, 6, 0, "Pudge")
	end
	if (questId == 837) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6802, -955, 7, 6, 0, "Woman")
	end
	if (questId == 839) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-7297, -1058, 7, 6, 0, "Enterance to Blackrock Mountain")
	end
	if (questId == 840) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-6359, -2075, 7, 6, 0, "Stonewrought Pass")
	pPlayer:PlaySoundToSet(8886)
	end
	if (questId == 843) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-5859, -2627, 7, 6, 0, "Duke Dan")
	pPlayer:PlaySoundToSet(8887)
	end
	if (questId == 844) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-5642.6, -2535.2, 7, 6, 0, "South Gate Pass")
	end
	if (questId == 846) then
	SetDBCSpellVar(47740, "c_is_flags", 0x01000)
	pPlayer:CastSpell(47740)
	end
	if (questId == 847) then
	pPlayer:RemoveAura(47740)
	pPlayer:CastSpell(58538)
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(-5717, -2602, 7, 6, 0, "Boulders to Climb")
	end
	if (questId == 849) then
    --SMSG_TRIGGER_MOVIE = 0x464
    --[[local packet = LuaPacket:CreatePacket(0x464, 4) -- Move type 4
    packet:WriteULong(16) -- Id 16
    players:SendPacketToPlayer(packet) -- Send to players]]
	--SMSG_TRIGGER_CINEMATIC = 0x0FA
		if PPL == nil then
		PPL = pPlayer
		RegisterTimedEvent("eajieajpajpz_ezgeziough_Eagsolh", 3000, 1)
		RegisterTimedEvent("eajieajpajpz_ezgeziough_Eagsolhz", 900, 3)
		else
		pPlayer:SendBroadcastMessage("ERROR: Please abandon the quest and then take it again.")
		pPlayer:SendAreaTriggerMessage("ERROR: Please abandon the quest and then take it again.")
		end
	end
	if (questId == 852) then
	local packet = LuaPacket:CreatePacket(0x0FA, 4) -- Move type 4
	packet:WriteULong(1) -- Id
	pPlayer:SendPacketToPlayer(packet) -- Send to players
	end
	if (questId == 855) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(7842.5, -2225, 7, 6, 0, "Priestess of Elune")
	end
	--Horde still
----------------------------------------------------------------------------------------
	--Peace
	if (questId == 1100) then
	pPlayer:SetPhase(4)
	pPlayer:AddAchievement(522)
	end
	if (questId == 1101) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(7954.9, -2372.7, 7, 6, 0, "Moonglade's Haven")
	end
	if (questId == 1102) then
	pPlayer:SetPhase(24)
	end
	if (questId == 1103) then
	pPlayer:CastSpell(28136)
	pPlayer:GossipSendPOI(8052.5, -2458.9, 7, 6, 0, "Teleportation Device")
	end
----------------------------------------------------------------------------------------
	--War
	if (questId == 1300) then
	pPlayer:SetPhase(16)
	pPlayer:AddAchievement(522)
	local Taxi = LuaTaxi:CreateTaxi()
	Taxi:AddPathNode(1, 7830, -2240, 475)
	Taxi:AddPathNode(1, 7708, -2201, 472)
	Taxi:AddPathNode(1, 7582.8, -2188, 487)
	Taxi:AddPathNode(1, 7535.9, -2129.8, 494)
	Taxi:AddPathNode(1, 7482.1, -2126.3, 492.5)
	Taxi:AddPathNode(1, 7482.1, -2126.3, 492.5)
	pPlayer:StartTaxi(Taxi, 28400)
	end
----------------------------------------------------------------------------------------
end

--[[function stoneharry_sucks_m(event, pPlayer, pQuestGiver, questId)
	print("--------------")
	print("OnAccept")
	print("Event")
	print(event)
	print("Player")
	print(pPlayer)
	print("Questgiver")
	print(pQuestGiver)
	print("QuestID")
	print(questId)
	print("--------------")
	if (Quest == 9) then
	player:Teleport(0, -7889, -2660.3, 223)
	end
	if Quest == 40 then
	player:Teleport(0, -7454.8, -2209.5, 169.5)
	end
end]]--

RegisterServerHook(14, "OnQuestAccept")
--RegisterServerHook(22, "stoneharry_sucks_m")

-- quest 829

local The_Npc_A = nil -- This is the first npc we shall use
local The_Npc_B = nil -- This is the second npc we shall use

function NPCGIA_GJOEAOJG_HXOJzzz(pUnit, Event)
    The_Npc_A = pUnit -- Here we say variable is the unit
end

RegisterUnitEvent(426016, 18, "NPCGIA_GJOEAOJG_HXOJzzz") -- The first npc, on spawn tell the script that this is him

function NPCGIA_GJOEAOJG_HXOJ_Zzzz(pUnit, Event)
    The_Npc_B = pUnit -- Here we say variable is the unit
end

RegisterUnitEvent(426017, 18, "NPCGIA_GJOEAOJG_HXOJ_Zzzz") -- The second npc, on spawn tell the script that this is him

function themagicalmomentsofalittlecinematichehe(pUnit,event)
  PlayerAA:SetPlayerLock(1)
  The_Npc_A:ChannelSpell(24618, PlayerAA)
  The_Npc_B:ChannelSpell(24618, PlayerAA)
  The_Npc_A:SendChatMessage(12,0,"Welcome mage, to the mines of the Slag Pit.") 
  The_Npc_A:RegisterEvent("nowlettheotheronetalkalittleyouidiot", 7000, 1)
end

function nowlettheotheronetalkalittleyouidiot(pUnit,event)
  The_Npc_B:SendChatMessage(12,0,"We're almost done with the summoning! Hang on!") 
  The_Npc_A:RegisterEvent("nowletusmovearoundandspyimeanpieyummyyummypie", 8000, 1)
end

function nowletusmovearoundandspyimeanpieyummyyummypie(pUnit,event)
  The_Npc_B:SendChatMessage(14,0,"Another proud member of the Alliance has joined us!") 
  The_Npc_A:StopChannel() -- stop it
  The_Npc_B:StopChannel() -- stop it
  PlayerAA:SetPlayerLock(0)
  PlayerAA:RemoveAura(22650)
  PlayerAA:CastSpell(58538)
end

--Quest 831

function StrangleHim_LOLAGN(pUnit, Event)
	if Zog == nil or pla == nil then
	pUnit:Despawn(0,1)
	else
	pla:CastSpell(64446)
	pla:Emote(473, 5900)
	Zog:ChannelSpell(40401, pla)
	Zog:SendChatMessage(12,0,"Get ready!")
	RegisterTimedEvent("Check_Check_Sgjieosjgss", 6000, 1)
	end
end

function Check_Check_Sgjieosjgss(pUnit, Event)
	if Zog == nil or pla == nil then
	pUnit:Despawn(0,1)
	else
	pla:SetPlayerLock(0)
	pla:Teleport(0, -6729.4, -1244.5, 187)
	pla:CastSpell(64446)
	Zog:StopChannel()
	Zog = nil
	pla = nil
	end
end

--849

function eajieajpajpz_ezgeziough_Eagsolh(pUnit, Event)
	if PPL ~= nil then
	PPL:SetStandState(7)
	local packet = LuaPacket:CreatePacket(0x0FA, 4) -- Move type 4
	packet:WriteULong(161) -- Id
	PPL:SendPacketToPlayer(packet) -- Send to players
	PPL:Teleport(0,-9012, -3215, 109)
	PPL:SetStandState(7)
	PPL = nil
	end
end

function eajieajpajpz_ezgeziough_Eagsolhz(pUnit, Event)
	if PPL ~= nil then
	PPL:CastSpell(61126)
	PPL:SetStandState(7)
	end
end

