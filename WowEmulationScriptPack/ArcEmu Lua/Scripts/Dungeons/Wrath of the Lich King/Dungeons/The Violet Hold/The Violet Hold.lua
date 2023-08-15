--[[

	This is created by zdroid9770  :D

	© Copyright 2011 - 2012 

          The Violet Hold


]]


OBJECT_END = 0x0006
UNIT_FIELD_FLAGS = OBJECT_END + 0x0034
UNIT_FLAG_NOT_SELECTABLE = 0x02000000
HH_VH = {}
HH_VH.coordsDB = {}
local function GetUnit(pUnit, entry)
	for k,v in pairs(pUnit:GetInRangeUnits()) do
		if (v:GetEntry() == entry) then
			return v
		end
	end
	return 0
end

local DK    = 48041
local DKC   = 48042
local PG    = 48040
local SS    = 48047
local SC    = 48044
local DS    = 48043
local COL1  = 48035
local ALEX  = 48118
local KRASS = 30658
local K_END = 48119
local MASTR = 48046
--Bosses--
local LDB   = 48048
local PSB   = 48115
local FDB   = 48117
----------

function HH_VH.DeclareAlex(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz = pUnit
end
function HH_VH.DeclareKrasEnd(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd = pUnit
	pUnit:SendChatMessage(14, 0, "Champions! I have returned as I promised! My queen has come to our aid.")
end

function HH_VH.Collection(pUnit, event)
	pUnit:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	local ind = pUnit:GetEntry()-(COL1-1)
	HH_VH.coordsDB[ind] = {}
	HH_VH.coordsDB[ind].x = pUnit:GetX()
	HH_VH.coordsDB[ind].y = pUnit:GetY()
	HH_VH.coordsDB[ind].z = pUnit:GetZ()
	HH_VH.coordsDB[ind].o = pUnit:GetO()
end

RegisterUnitEvent(COL1, 18, "HH_VH.Collection")
RegisterUnitEvent(COL1+1, 18, "HH_VH.Collection")
RegisterUnitEvent(COL1+2, 18, "HH_VH.Collection")
RegisterUnitEvent(COL1+3, 18, "HH_VH.Collection")
RegisterUnitEvent(COL1+4, 18, "HH_VH.Collection")

RegisterUnitEvent(ALEX, 18, "HH_VH.DeclareAlex")
RegisterUnitEvent(K_END, 18, "HH_VH.DeclareKrasEnd")
-----------------

function HH_VH.DeclareMaster(pUnit, event)
	local iid = pUnit:GetInstanceID()
	if (HH_VH[iid] == nil) then
		HH_VH[iid] = {}
	end
	HH_VH[iid].Master = pUnit
	pUnit:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(MASTR, 18, "HH_VH.DeclareMaster")

function HH_VH.Enemy_Movement(pUnit, event)
	local iid = pUnit:GetInstanceID()
	for i,k in pairs(HH_VH[iid].Wave_Handler_Table) do
		k:SetMoveRunFlag(1)
		k:CastSpell(7077)
    		k:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO())
	end
end

function HH_VH.KrasusVisualCandy(pUnit, event)
	HH_VH.coordsDB.K = {}
	HH_VH.coordsDB.K.X = pUnit:GetX()
	HH_VH.coordsDB.K.Y = pUnit:GetY()
	HH_VH.coordsDB.K.Z = pUnit:GetZ()
	HH_VH.coordsDB.K.O = pUnit:GetO()
	for k,v in pairs(pUnit:GetInRangeUnits()) do
		if (v:GetEntry() >= COL1 and v:GetEntry() <= COL1+4 and v:GetEntry() ~= COL1+3) then
			v:ChannelSpell(47855, pUnit)
		end
	end
	pUnit:ChannelSpell(47855, GetUnit(pUnit, COL1+3))
end

function HH_VH.KrasusSpeak(pUnit, event, player)
	pUnit:GossipCreateMenu(70015, player, 0)
	pUnit:GossipMenuAddItem(0, "I am ready to aid the Red Dragonflight Krasus.", 10, 0)
	pUnit:GossipMenuAddItem(0, "I need some more time to prepare Krasus.", 20, 0)
	pUnit:GossipSendMenu(player)
end

function HH_VH.KrasusSelect(pUnit, event, player, id, intid, code)
	if (intid == 10) then
		pUnit:GossipCreateMenu(70016, player, 0)
		pUnit:GossipMenuAddItem(4, "I Accept", 11, 0)
		pUnit:GossipMenuAddItem(4, "I Decline", 21, 0)
		pUnit:GossipSendMenu(player)
	elseif (intid == 11) then
		pUnit:RegisterEvent("HH_VH.HH_VH.StartInstance", 2000, 1)
		pUnit:StopChannel()
		for k,v in pairs(pUnit:GetInRangeUnits()) do
			if (v:GetEntry() >= COL1 and v:GetEntry() <= COL1+4) then
				v:StopChannel()
			end
		end
		pUnit:SendChatMessage(12, 0, "Very well, I shall return champions you have my word!")
		pUnit:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
		player:GossipComplete()
	elseif (intid == 20 or intid == 21) then
		local name = player:GetName()
		pUnit:SendChatMessage(12, 0, "Very well "..name..", I will hold off what I can until you are ready.")
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(KRASS, 1, "HH_VH.KrasusSpeak")
RegisterUnitGossipEvent(KRASS, 2, "HH_VH.KrasusSelect")
RegisterUnitEvent(KRASS, 18, "HH_VH.KrasusVisualCandy")
--////////////////////////////////////////////////////--

function HH_VH.StartInstance(pUnit, event)
	local iid = pUnit:GetInstanceID()
	pUnit:SendChatMessage(16, 0, "You can feel a dark energy fill the room.")
	HH_VH[iid].LichKing = pUnit:SpawnCreature(48034, 1876.880005, 805.305725, 38.609207, 3.165159, 7, 0)
	HH_VH[iid].LichKing:Emote(11, 1)
	HH_VH[iid].LichKing:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:PlaySoundToSet(14820)
	pUnit:RegisterEvent("HH_VH.StartInstance2", 4000, 1)
end

function HH_VH.StartInstance2(pUnit, event)
	local iid = pUnit:GetInstanceID()
	HH_VH[iid].LichKing:PlaySoundToSet(14804)
	HH_VH[iid].LichKing:SendChatMessage(14, 0, "Pathetic...")
	pUnit:RegisterEvent("HH_VH.StartInstance3", 6000, 1)
end

function HH_VH.StartInstance3(pUnit, event)
	local iid = pUnit:GetInstanceID()
	HH_VH[iid].LichKing:PlaySoundToSet(14738)
	HH_VH[iid].LichKing:SendChatMessage(14, 0, "You have crossed into the world of the dead in search of answers. You wish to save your ally, and have risked life and limb to be here? Allow me... to help.")
	pUnit:RegisterEvent("HH_VH.StartInstance4", 25000, 1)
	pUnit:EventChat(14, 0, "Quiet Arthas! Your corruption has spread for to long! You will be stopped!", 20000)
end

function HH_VH.StartInstance4(pUnit, event)
	local iid = pUnit:GetInstanceID()
	HH_VH[iid].LichKing:PlaySoundToSet(14803)
	HH_VH[iid].LichKing:SendChatMessage(14, 0, "Touching...")
	pUnit:RegisterEvent("HH_VH.StartInstance5", 5000, 1)
end

function HH_VH.StartInstance5(pUnit, event)
	local iid = pUnit:GetInstanceID()
	HH_VH[iid].LichKing:PlaySoundToSet(14741)
	HH_VH[iid].LichKing:SendChatMessage(14, 0, "Remember this mortal... for now... I give you the choice... I allow you to pick your allegeance... but in the end... you will be mine... one way... or another.")
	pUnit:RegisterEvent("HH_VH.StartInstance6", 30000, 1)
	pUnit:EventChat(14, 0, "They will never side with you Arthas! You hold yourself high in glory but your reign will come to an end! By the honor of my queen I will NOT allow you to take control of Dalaran!", 20000)
end

function HH_VH.StartInstance6(pUnit, event)
	local iid = pUnit:GetInstanceID()
	HH_VH[iid].LichKing:PlaySoundToSet(14770)
	HH_VH[iid].LichKing:CastSpell(45775)
	HH_VH[iid].LichKing:SendChatMessage(14, 0, "Very well, warriors of the frozen wastes, rise up, I command you to fight, kill and die for your master! Let none survive!")
	pUnit:RegisterEvent("HH_VH.StartInstance7", 12000, 1)
end

function HH_VH.StartInstance7(pUnit, event)
	local iid = pUnit:GetInstanceID()
	HH_VH[iid].LichKing:SendChatMessage(42, 0, "The Lich King begins to open portals in the hold.")
	pUnit:SendChatMessage(15, 0, "I am too weak champions, I must get back to Queen Alexstraza. Do NOT let Arthas take control of Dalaran, should he succeed the effects will be devastating.")
	pUnit:SpawnCreature(MASTR, HH_VH[iid].LichKing:GetX(), HH_VH[iid].LichKing:GetY(), HH_VH[iid].LichKing:GetZ(), HH_VH[iid].LichKing:GetO(), 35, 0)
	pUnit:RegisterEvent("HH_VH.StartInstance8", 1000, 1)
end

function HH_VH.StartInstance8(pUnit, event)
	local iid = pUnit:GetInstanceID()
	pUnit:SetMoveRunFlag(1)
	HH_VH[iid].LichKing:Despawn(1000, 0)
	pUnit:SendChatMessage(12, 0, "I will return champions, do not fear, you have the word of her Consort.")
	pUnit:MoveTo(1804.175049, 804.329712, 44.365353, 3.115675)
	pUnit:Despawn(7000, 0)
	HH_VH[iid].Master:RegisterEvent("HH_VH.Wave1", 5000, 1)
end
--////////////////////////////////////////////////////--
--                       Waves of the Instance                               --
--////////////////////////////////////////////////////--
function HH_VH.Instance_Reset_Check(pUnit, event)
	local iid = pUnit:GetInstanceID()
	local isSomeoneAlive = false
	for k,v in pairs(pUnit:GetInRangePlayers()) do
		if (v:IsAlive() == true) then
			isSomeoneAlive = true
			break
		end
	end
	if (isSomeoneAlive == false or HH_VH[iid].resetMe == true) then
		pUnit:RemoveEvents()
		pUnit:SpawnCreature(KRASS, HH_VH.coordsDB.K.X, HH_VH.coordsDB.K.Y, HH_VH.coordsDB.K.Z, HH_VH.coordsDB.K.O, 35, 0)
		pUnit:RegisterEvent("HH_VH.Enemy_Reset_Despawn", 2000, 1)
		HH_VH[iid] = nil
		print "The Violet Hold Instance has been reset prematurley.."
	end
end

function HH_VH.Enemy_Reset_Despawn(pUnit, event)
	local e = v:GetEntry()
    	for k,v in pairs(pUnit:GetInRangeUnits()) do
    		if (e == SS or e == SC or e == DK or e == DKC or e == PG or e == DS) then
			v:Despawn(2000, 0)
		end
    	end
end

function HH_VH.Wave1(pUnit, event)
	local iid = pUnit:GetInstanceID()
	pUnit:SpawnGameObject(8000028, HH_VH.coordsDB[1].x, HH_VH.coordsDB[1].y, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 5000)
	local mobPick = math.random(1, 3)
	if (mobPick == 1) then
		pUnit:SpawnCreature(SS, HH_VH.coordsDB[1].x + 2, HH_VH.coordsDB[1].y + 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0)
		pUnit:SpawnCreature(SS, HH_VH.coordsDB[1].x - 2, HH_VH.coordsDB[1].y - 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0)
		pUnit:SpawnCreature(SC, HH_VH.coordsDB[1].x + 2, HH_VH.coordsDB[1].y - 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0) --, 40345
	elseif (mobPick == 2) then
		pUnit:SpawnCreature(DK, HH_VH.coordsDB[1].x + 2, HH_VH.coordsDB[1].y + 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0) --,  38237
		pUnit:SpawnCreature(DK, HH_VH.coordsDB[1].x - 2, HH_VH.coordsDB[1].y - 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0) -- , 38237
		pUnit:SpawnCreature(DKC, HH_VH.coordsDB[1].x + 2, HH_VH.coordsDB[1].y - 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0)-- , 40343
	elseif (mobPick == 3) then
		pUnit:SpawnCreature(PG, HH_VH.coordsDB[1].x + 2, HH_VH.coordsDB[1].y + 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0)
		pUnit:SpawnCreature(DS, HH_VH.coordsDB[1].x - 2, HH_VH.coordsDB[1].y - 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0)
		pUnit:SpawnCreature(PG, HH_VH.coordsDB[1].x + 2, HH_VH.coordsDB[1].y - 2, HH_VH.coordsDB[1].z, HH_VH.coordsDB[1].o, 14, 0)
	end
	pUnit:RegisterEvent("HH_VH.Enemy_Movement", 1000, 1)
	pUnit:RegisterEvent("HH_VH.Waves", 150000, 4)
	pUnit:SendChatMessage(42, 0, "The portal has opened and wave "..tostring(HH_VH.WavesCounter).." has arrived!")
	print("Wave number "..tostring(HH_VH[iid].WavesCounter).." has spawned..")
	HH_VH[iid].WavesCounter = 1
	pUnit:RegisterEvent("HH_VH.Instance_Reset_Check", 5000, 0)
end

function HH_VH.Waves(pUnit, event)
	local iid = pUnit:GetInstanceID()
	HH_VH[iid].WavesCounter = HH_VH[iid].WavesCounter + 1
	if (HH_VH[iid].WavesCounter == 5) then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("HH_VH.Instance_Reset_Check", 5000, 0)
		HH_VH.BossWave1(pUnit, event)
	elseif (HH_VH[iid].WavesCounter == 11) then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("HH_VH.Instance_Reset_Check", 5000, 0)
		HH_VH.BossWave2(pUnit, event)
	elseif (HH_VH[iid].WavesCounter == 17) then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("HH_VH.Instance_Reset_Check", 5000, 0)
		HH_VH.BossWave3(pUnit, event)
	else
		pUnit:SendChatMessage(42, 0, "The portal has opened and wave "..tostring(HH_VH[iid].WavesCounter).." has arrived!")
		local WaveSelection = math.random(1, 5)
		local mobSelection = math.random(1, 3)
		pUnit:SpawnGameObject(8000028, HH_VH.coordsDB[WaveSelection].x, HH_VH.coordsDB[WaveSelection].y, HH_VH.coordsDB[WaveSelection].z + 4, HH_VH.coordsDB[WaveSelection].o, 5000)
		if (mobSelection == 1) then
			pUnit:SpawnCreature(SS, HH_VH.coordsDB[WaveSelection].x + 2, HH_VH.coordsDB[WaveSelection].y + 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0)
			pUnit:SpawnCreature(SS, HH_VH.coordsDB[WaveSelection].x - 2, HH_VH.coordsDB[WaveSelection].y - 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0)
			pUnit:SpawnCreature(SC, HH_VH.coordsDB[WaveSelection].x + 2, HH_VH.coordsDB[WaveSelection].y - 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0, 40345)
			pUnit:RegisterEvent("HH_VH.Enemy_Movement", 1000, 1)
		elseif (mobSelection == 2) then
			pUnit:SpawnCreature(DK, HH_VH.coordsDB[WaveSelection].x + 2, HH_VH.coordsDB[WaveSelection].y + 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0,  38237)
			pUnit:SpawnCreature(DK, HH_VH.coordsDB[WaveSelection].x - 2, HH_VH.coordsDB[WaveSelection].y - 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0,  38237)
			pUnit:SpawnCreature(DKC, HH_VH.coordsDB[WaveSelection].x + 2, HH_VH.coordsDB[WaveSelection].y - 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0, 40343)
			pUnit:RegisterEvent("HH_VH.Enemy_Movement", 1000, 1)
		elseif (mobSelection == 3) then
			pUnit:SpawnCreature(PG, HH_VH.coordsDB[WaveSelection].x + 2, HH_VH.coordsDB[WaveSelection].y + 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0)
			pUnit:SpawnCreature(DS, HH_VH.coordsDB[WaveSelection].x - 2, HH_VH.coordsDB[WaveSelection].y - 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0)
			pUnit:SpawnCreature(PG, HH_VH.coordsDB[WaveSelection].x + 2, HH_VH.coordsDB[WaveSelection].y - 2, HH_VH.coordsDB[WaveSelection].z, HH_VH.coordsDB[WaveSelection].o, 14, 0)
			pUnit:RegisterEvent("HH_VH.Enemy_Movement", 1000, 1)
		end
	end
end

function HH_VH.BossWave1(pUnit, event)
	pUnit:SendChatMessage(42, 0, "A leader of the invasion force has spawned!")
	pUnit:SpawnGameObject(8000028, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 5000)
	pUnit:SpawnCreature(LDB, pUnit:GetX() - 3, pUnit:GetY() - 3, pUnit:GetZ(), pUnit:GetO(), 14, 0, 31308)

end

function HH_VH.BossWave2(pUnit, event)
	pUnit:SendChatMessage(42, 0, "A leader of the invasion force has spawned!")
	pUnit:SpawnGameObject(8000028, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 5000)
	pUnit:SpawnCreature(PSB, pUnit:GetX() - 3, pUnit:GetY() - 3, pUnit:GetZ(), pUnit:GetO(), 14, 0, 39245)
end

function HH_VH.BossWave3(pUnit, event)
	pUnit:SendChatMessage(42, 0, "The final leader has arrived.")
	pUnit:SpawnGameObject(8000028, pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO(), 5000)
	pUnit:SpawnCreature(FDB, pUnit:GetX() - 3, pUnit:GetY() - 3, pUnit:GetZ(), pUnit:GetO(), 7, 0, 39422)
end


--Violet Hold NPC Boss Scripts--
function HH_VH.InstanceLDB_PrimeAbility(pUnit, event)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		local selection = math.random(1 , 4)
		if (selection == 1) then
			pUnit:FullCastSpellOnTarget(38836, target)
		elseif (selection == 2) then
			pUnit:FullCastSpellOnTarget(38534, target)
		elseif (selection == 3) then
			pUnit:FullCastSpellOnTarget(59016, target)
		elseif (selection == 4) then
			pUnit:FullCastSpellOnTarget(62249, target)
		end
	end
end

function HH_VH.InstanceLDB_BlastNova(pUnit, event)
	pUnit:FullCastSpell(30600)
end

function HH_VH.InstanceLDB_Start(pUnit, event)
	pUnit:PlaySoundToSet(13175)
	pUnit:SendChatMessage(14, 0, "Such is the fate of all who oppose the Lich King.")
	pUnit:RegisterEvent("HH_VH.InstanceLDB_PrimeAbility", math.random(6000, 9000), 0)
	pUnit:RegisterEvent("HH_VH.InstanceLDB_BlastNova", 24000, 0)
	pUnit:RegisterEvent("HH_VH.InstanceLDB_Phase2", 1000, 0)
end
---
---
function HH_VH.InstanceLDB_Explosion(pUnit, event)
	pUnit:SendChatMessage(14, 0, "I will be your demise!")
	pUnit:FullCastSpell(37106)
end

function HH_VH.InstanceLDB_Phase2(pUnit, event)
	if (pUnit:GetHealthPct() <= 70) then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(13177)
		pUnit:SendChatMessage(14, 0, "Surely you can see the futility of it all?")
		pUnit:RegisterEvent("HH_VH.InstanceLDB_PrimeAbility", math.random(6000, 9000), 0)
		pUnit:RegisterEvent("HH_VH.InstanceLDB_Explosion", 27000, 0)
		pUnit:RegisterEvent("HH_VH.InstanceLDB_Phase3", 1000, 0)
		pUnit:RegisterEvent("HH_VH.Instance_Reset_Check", 5000, 0)
	end
end

function HH_VH.InstanceLDB_Lightning(pUnit, event)
	local light = pUnit:GetMainTank()
	if (light ~= nil) then
		pUnit:FullCastSpellOnTarget(46479, light)
	end
end

function HH_VH.InstanceLDB_SpecialChill(pUnit, event)
	local chillTarg = pUnit:GetRandomPlayer(0)
	if (chillTarg ~= nil) then
		pUnit:PlaySoundToSet(13173)
		pUnit:SendChatMessage(14, 0, "The chill you feel is the herald of your doom.")
		pUnit:CastSpellAoF(chillTarg:GetX(), chillTarg:GetY(), chillTarg:GetZ(), 28547)
	end
end

function HH_VH.InstanceLDB_Phase3(pUnit, event)
	if (pUnit:GetHealthPct() <= 40) then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(13178)
		pUnit:SendChatMessage(14, 0, "Just give up and die already!")
		pUnit:RegisterEvent("HH_VH.InstanceLDB_PrimeAbility", math.random(6000, 9000), 0)
		pUnit:RegisterEvent("HH_VH.InstanceLDB_Lightning",    math.random(12000, 15000), 0)
		pUnit:RegisterEvent("HH_VH.InstanceLDB_SpecialChill", 32000, 0)
	end
end

function HH_VH.InstanceLDB_Dies(pUnit, event)
	local iid = pUnit:GetInstanceID()
	pUnit:RemoveEvents()
	HH_VH[iid].bossDied = 1
	pUnit:PlaySoundToSet(13174)
	pUnit:SendChatMessage(14, 0, "Haha... your efforts... are in... vain...")
	pUnit:RegisterEvent("HH_VH.Waves", 30000, 1)
end

function HH_VH.InstanceLDB_Leaves(pUnit, event)
	pUnit:RemoveEvents()
	if (HH_VH[iid].bossDied == 1) then
		HH_VH.Instance_Reset_Check(pUnit, event)
	end
end

RegisterUnitEvent(LDB, 1, "HH_VH.InstanceLDB_Start")
RegisterUnitEvent(LDB, 2, "HH_VH.InstanceLDB_Leaves")
RegisterUnitEvent(LDB, 4, "HH_VH.InstanceLDB_Dies")
-------------------------------------------------------------------
-------------------------------------------------------------------
function HH_VH.InstancePSB_Frostshock(pUnit, event)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(29666, target)
	end
end

function HH_VH.InstancePSB_FrostVolley(pUnit, event)
	pUnit:FullCastSpell(61594)
end

function HH_VH.InstancePSB_Aggro(pUnit, event)
	pUnit:PlaySoundToSet(13947)
	pUnit:SendChatMessage(14, 0, "We finish this now champions of the Kirin'Tor!")
	pUnit:RegisterEvent("HH_VH.InstancePSB_Frostshock", 6000, 0)
	pUnit:RegisterEvent("HH_VH.InstancePSB_FrostVolley", 15000, 0)
	pUnit:RegisterEvent("HH_VH.InstancePSB_Phase2", 1000, 0)
end
----
----
function HH_VH.InstancePSB_FrostBreath(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(44799, target)
	end
end

function HH_VH.InstancePSB_FrostCleave(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(51857, target)
	end
end

function HH_VH.InstancePSB_Phase2(pUnit, event)
	if (pUnit:GetHealthPct() <= 75) then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(13953)
		pUnit:SendChatMessage(14, 0, "Dalaran will fall!")
		pUnit:RegisterEvent("HH_VH.InstancePSB_FrostCleave", 6000, 0)
		pUnit:RegisterEvent("HH_VH.InstancePSB_FrostBreath", 15000, 0)
		pUnit:RegisterEvent("HH_VH.InstancePSB_Phase3", 1000, 0)
	end
end
----
----
function HH_VH.InstancePSB_Blizzard(pUnit, event)
	pUnit:PlaySoundToSet(13950)
	pUnit:SendChatMessage(14, 0, "Who among you can withstand my power!")
	pUnit:RegisterEvent("HH_VH.InstancePSB_BlizzardGo", 2000, 4)
end
function HH_VH.InstancePSB_BlizzardGo(pUnit, event)
	pUnit:CastSpell(36751)
end

function HH_VH.InstancePSB_Phase3(pUnit, event)
	if (pUnit:GetHealthPct() <= 50) then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(13948)
		pUnit:SendChatMessage(14, 0, "Shiver and die!")
		pUnit:RegisterEvent("HH_VH.InstancePSB_FrostCleave", 6000, 0)
		pUnit:RegisterEvent("HH_VH.InstancePSB_FrostVolley", 15000, 0)
		pUnit:RegisterEvent("HH_VH.InstancePSB_Blizzard", 27000, 0)
		pUnit:RegisterEvent("HH_VH.InstancePSB_Phase4", 1000, 0)
	end
end
----
----

function HH_VH.InstancePSB_SpecialFinal4(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(42049)
	pUnit:SetFlying()
	pUnit:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ() + 10, pUnit:GetO())
	pUnit:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:PlaySoundToSet(13949)
	pUnit:SendChatMessage(14, 0, "The world has forgotten what true magic is! Let this be a reminder!")
	pUnit:RegisterEvent("HH_VH.InstancePSB_SpecialAbility4Cast", 2000, 4)
	pUnit:RegisterEvent("HH_VH.InstancePSB_Phase4Return", 9000, 1)
	pUnit:RegisterEvent("HH_VH.InstancePSB_Phase4Moves", 10000, 1)
end
function HH_VH.InstancePSB_SpecialAbility4Cast(pUnit, event)
	pUnit:FullCastSpell(38837)
end
function HH_VH.InstancePSB_Phase4Return(pUnit, event)
	pUnit:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ() - 10, pUnit:GetO())
end

function HH_VH.InstancePSB_Phase4(pUnit, event)
	if (pUnit:GetHealthPct() <= 30) then
		pUnit:RemoveEvents()
		pUnit:PlaySoundToSet(13952)
		pUnit:SendChatMessage(14, 0, "I will end the Kirin'Tor!")
		pUnit:RegisterEvent("HH_VH.InstancePSB_Phase4Moves", 1000, 1)
	end
end

function HH_VH.InstancePSB_Phase4Moves(pUnit, event)
	pUnit:Land()
	pUnit:SetUInt64Value(UNIT_FIELD_FLAGS, 0)
	pUnit:RegisterEvent("HH_VH.InstancePSB_FrostCleave", math.random(6000, 8000)  , 0)
	pUnit:RegisterEvent("HH_VH.InstancePSB_Frostshock",  math.random(7000, 9000)  , 0)
	pUnit:RegisterEvent("HH_VH.InstancePSB_FrostVolley", math.random(14000, 17000), 0)
	pUnit:RegisterEvent("HH_VH.InstancePSB_FrostBreath", math.random(18000, 22000), 0)
	pUnit:RegisterEvent("HH_VH.InstancePSB_SpecialFinal4", 26000, 0)
end

function HH_VH.InstancePSB_Dies(pUnit, event)
	pUnit:RemoveEvents()
	HH_VH[iid].bossDied = 2
	pUnit:PlaySoundToSet(13955)
	pUnit:SendChatMessage(14, 0, "Perhaps we have...underestimated...you..")
	pUnit:RegisterEvent("HH_VH.Wave_Handler_Table_Clean", 5000, 1)
	pUnit:RegisterEvent("HH_VH.Wave1", 30000, 1)
end

function HH_VH.InstancePSB_Leaves(pUnit, event)
	pUnit:RemoveEvents()
	if (HH_VH[iid].bossDied == 2) then
		HH_VH.Instance_Reset_Check(pUnit, event)
	end
end

function HH_VH.InstancePSB_Slay(pUnit, event)
	pUnit:PlaySoundToSet(13951)
	pUnit:SendChatMessage(14, 0, "Am I interrupting?")
	pUnit:CastSpell(38580)
end

RegisterUnitEvent(PSB, 1, "HH_VH.InstancePSB_Aggro")
RegisterUnitEvent(PSB, 2, "HH_VH.InstancePSB_Leaves")
RegisterUnitEvent(PSB, 3, "HH_VH.InstancePSB_Slay")
RegisterUnitEvent(PSB, 4, "HH_VH.InstancePSB_Dies")
-------------------------------------------------------------------
-- Final Encounter
-------------------------------------------------------------------

function HH_VH.InstanceFDB_ShadowVolley(pUnit, event)
	pUnit:FullCastSpell(38840)
end

----------------------CINEMATIC FOR THE FINAL BATTLE-------------------------------
function HH_VH.InstanceEnterAlexKrasus(pUnit, event)
	pUnit:SpawnCreature(ALEX, 1804.175049, 804.329712, 44.365353, 3.115675, 1719, 0)
	pUnit:SpawnCreature(K_END, 1804.175049, 804.329712 + 6, 44.365353, 3.115675, 1719, 0, 39291)
	HH_VH[pUnit:GetInstanceID()].Cypx:SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	HH_VH[pUnit:GetInstanceID()].Cypx:CastSpell(30206)
	HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].Cypx:SetCombatCapable(1)
	HH_VH[pUnit:GetInstanceID()].Cypx:Root()
	pUnit:RegisterEvent("HH_VH.KrasusAlexMove", 2000, 1)
end

function HH_VH.KrasusAlexMove(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SetMoveRunFlag(1)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:MoveTo(HH_VH.coordsDB.K.X - 4, HH_VH.coordsDB.K.Y, HH_VH.coordsDB.K.Z, HH_VH.coordsDB.K.O)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SetMoveRunFlag(1)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:MoveTo(HH_VH.coordsDB.K.X + 4, HH_VH.coordsDB.K.Y - 3, HH_VH.coordsDB.K.Z, HH_VH.coordsDB.K.O)
	pUnit:RegisterEvent("HH_VH.AlexstrazSpeak", 5000, 1)
end

function HH_VH.AlexstrazSpeak(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(12, 0, "Do not fear champions, I have contained this creature within my bindings. Krasus has told me what you have endured to protect Dalaran. Be at rest now. This is almost over.")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.AlexstrazSpeak2", 5000, 1)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(16, 0, "Chrysophylax has become weakend by the HH_VH[pUnit:GetInstanceID()].Alexstraza's prison.")
end

function HH_VH.AlexstrazSpeak2(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(11209)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(12, 0, "I revel in your pain.")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.AlexstrazSpeak3", 6000, 1)
end

function HH_VH.AlexstrazSpeak3(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SendChatMessage(14, 0, "Quiet you sniviling wretch..You think you can insult us that easily..I should slit your -")
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.AlexstrazSpeak4", 5000, 1)
end

function HH_VH.AlexstrazSpeak4(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(12, 0, "Enough Krasus, you know there is no prize in action out of anger. This creature is helpless in my bindings.")
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(16, 0, "Chrysophylax shows a sly grin.")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.AlexstrazSpeak5", 8000, 1)
end

function HH_VH.AlexstrazSpeak5(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(11206)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(12, 0, "You seek a prize aye? How about death?")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.AlexstrazSpeak6", 8000, 1)
end

function HH_VH.AlexstrazSpeak6(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(12, 0, "Be silent creature. Do not think your manipulative chat can turn my consort, myself, or these Champions of the Kirin'Tor!")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.AlexstrazSpeak7", 10000, 1)
end

function HH_VH.AlexstrazSpeak7(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(12, 0, "You know I can break these chains HH_VH[pUnit:GetInstanceID()].Alexstraza, and you know these bindings cannot hold me..and when I do break free it will not be pleasing..")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.AlexstrazSpeak8", 8000, 1)
end

function HH_VH.AlexstrazSpeak8(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SendChatMessage(12, 0, "You are foolish. My queen I think we should remove this creature and bring him back to the temple for justice. These champions must be weary.")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SetMoveRunFlag(0)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:MoveTo(pUnit:GetX() - 4, pUnit:GetY(), pUnit:GetZ(), pUnit:GetO())
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SetMoveRunFlag(0)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:MoveTo(pUnit:GetX() + 4, pUnit:GetY() , pUnit:GetZ(), pUnit:GetO())
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.AlexstrazSpeak9", 4000, 1)
end

function HH_VH.AlexstrazSpeak9(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(12, 0, "Yes Krasus, it is time to return. Champions I am forever in your debt. Thank You for the aid you have -")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.AlexstrazSpeak10", 3000, 1)
end

function HH_VH.AlexstrazSpeak10(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(11207)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(12, 0, "I hate to say I told you so...")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.CypxVisualEscape", 2000, 4)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.CypxBeginTransform", 9000, 1)
end

function HH_VH.CypxVisualEscape(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:CastSpell(46242)
end

function HH_VH.CypxBeginTransform(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:RemoveAura(30206)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SendChatMessage(12, 0, "What is this?!")
	HH_VH[pUnit:GetInstanceID()].Cypx:CastSpell(30852)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.CypxDragonForm", 4000, 1)
end

function HH_VH.CypxDragonForm(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:SetModel(18062)
	HH_VH[pUnit:GetInstanceID()].Cypx:SetScale(1)
	HH_VH[pUnit:GetInstanceID()].Cypx:SetFaction(1720)
	HH_VH[pUnit:GetInstanceID()].Cypx:SetUInt64Value(UNIT_FIELD_FLAGS, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:SetCombatCapable(0)
	HH_VH[pUnit:GetInstanceID()].Cypx:Unroot()
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(13414)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "This is the hour of our greatest triumph!")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Phase1", 1000, 1)
end
----------------------CINEMATIC END-----------------------------------------
function HH_VH.CypxShadowBreath(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target ~= nil) then
		HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(59126, target)
	end
end

function HH_VH.AlexFireball(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:FullCastSpellOnTarget(29953, HH_VH[pUnit:GetInstanceID()].Cypx)
end

function HH_VH.KrasusDebuff(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:FullCastSpellOnTarget(46279, HH_VH[pUnit:GetInstanceID()].Cypx)
end

function HH_VH.InstanceFDB_Phase1(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(14, 0, "Do not lose faith champions! I will aid you in this fight!")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.CypxShadowBreath", 10000, 0)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.AlexFireball", 7000, 0)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.KrasusDebuff", 12000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_ShadowVolley", 7000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Phase2", 1000, 0)
end
--
--
function HH_VH.KrasusFlamestrike(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:CastSpellAoF(HH_VH[pUnit:GetInstanceID()].Cypx:GetX(), HH_VH[pUnit:GetInstanceID()].Cypx:GetY(), HH_VH[pUnit:GetInstanceID()].Cypx:GetZ(), 41481)
end

function HH_VH.InstanceFDB_TimeStop(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(13410)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Tick Tock, Tick Tock.")
	HH_VH[pUnit:GetInstanceID()].Cypx:CastSpell(47736)
end

function HH_VH.AlexChainHeal(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:FullCastSpellOnTarget(42027, HH_VH[pUnit:GetInstanceID()].KrasusEnd)
end

function HH_VH.InstanceFDB_Darkness(pUnit, event)
	local target = HH_VH[pUnit:GetInstanceID()].Cypx:GetRandomPlayer(0)
	if (target ~= pUnit:GetMainTank()) then
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(13413)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "There is no future...for you.")
		HH_VH[pUnit:GetInstanceID()].Cypx:CastSpellAoF(target:GetX(), target:GetY(), target:GetZ(), 45996)
	else
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Darkness", 500, 1)
	end
end

function HH_VH.InstanceFDB_Phase2(pUnit, event)
	if (HH_VH[pUnit:GetInstanceID()].Cypx:GetHealthPct() <= 80) then
		pUnit:RemoveEvents()
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(13412)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Lets get this over with..")
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.CypxShadowBreath", 10000, 0)
		HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.AlexFireball", 7000, 0)
		HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.KrasusFlamestrike", 17000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_ShadowVolley", 7000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_TimeStop", 25400, 0)
		HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.AlexChainHeal", 32000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Darkness", 42500, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Phase3", 1000, 0)
	end
end
----
----
function HH_VH.InstanceFDB_Phase3(pUnit, event)
	if (HH_VH[pUnit:GetInstanceID()].Cypx:GetHealthPct() <= 65) then
		pUnit:RemoveEvents()
		HH_VH[pUnit:GetInstanceID()].Cypx:SetFlying()
		HH_VH[pUnit:GetInstanceID()].Cypx:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ() + 20, pUnit:GetO())
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10414)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "If you do not cese this foolish quest then you will die!")
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceAlexMorph", 3000, 1)
	end
end

function HH_VH.InstanceAlexMorph(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(14, 0, "Very well Chrysophylax! If it is a battle in the air you wish then it is one you will get!")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO())
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SetCombatMeleeCapable(1)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstanceKrasusSpeak", 3000, 1)
end

function HH_VH.InstanceKrasusSpeak(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SendChatMessage(14, 0, "My queen we should stay grounded to aid the champions!")
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO())
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SetCombatMeleeCapable(1)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.InstanceFDB_Phase3Go", 2000, 1)
end
--
--
function HH_VH.InstanceAlexFlameBreath(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:FullCastSpellOnTarget(29953, HH_VH[pUnit:GetInstanceID()].Cypx)
end

function HH_VH.InstanceFDB_Shadowflame(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(22539, HH_VH[pUnit:GetInstanceID()].Alexstraz)
end

function HH_VH.InstanceFDB_Flameshock(pUnit, event)
	local flameShock = pUnit:GetRandomPlayer(0)
	if (flameShock ~= nil) then
		HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(41115, flameShock)
	end
end

function HH_VH.InstanceFDB_FireVolley(pUnit, event)
	pUnit:FullCastSpell(37109)
end

function HH_VH.InstanceKrasusCleave(pUnit, event)
	pUnit:FullCastSpellOnTarget(40932, HH_VH[pUnit:GetInstanceID()].Cypx)
end

function HH_VH.InstanceFDB_Special1(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10446)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Your days are done!")
	HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpell(57557)
end

function HH_VH.InstanceFDB_Phase3Go(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstancePlayerFlightStart", 1000, 1)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstanceAlexFlameBreath", 7000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Shadowflame", 7000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Flameshock", 10000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_FireVolley", 13000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_Special1", 57000, 0)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.InstanceKrasusCleave", 8000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBPhase4", 1000, 0)
end
--
--
function HH_VH.InstanceFDB_LegionLight(pUnit, event)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(38634, target)
	end
end

function HH_VH.InstanceFDB_FlameBreath(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target ~= nil) then
		HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(56908, target)
	end
end

function HH_VH.InstanceAlexstrazCleave(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:FullCastSpellOnTarget(31345, HH_VH[pUnit:GetInstanceID()].Cypx)
end

function HH_VH.InstanceKrasusFlame(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:FullCastSpellOnTarget(56908, HH_VH[pUnit:GetInstanceID()].Cypx)
end
----
----
function HH_VH.InstanceFDBPhase4(pUnit, event)
	if (HH_VH[pUnit:GetInstanceID()].Cypx:GetHealthPct() <= 50) then
		HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10442)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Why do you persist? Surely you can see the futility of it all... It's not to late. You may still leave with your lives!")
		HH_VH[pUnit:GetInstanceID()].Cypx:MoveTo(pUnit:GetSpawnX(), pUnit:GetSpawnY(), pUnit:GetSpawnZ(), pUnit:GetSpawnO())
		HH_VH[pUnit:GetInstanceID()].Cypx:Land()
		HH_VH[pUnit:GetInstanceID()].Alexstraz:MoveTo(pUnit:GetX() + 6, pUnit:GetY(), pUnit:GetZ(), pUnit:GetO())
		HH_VH[pUnit:GetInstanceID()].KrasusEnd:MoveTo(pUnit:GetX() - 6, pUnit:GetY(), pUnit:GetZ(), pUnit:GetO())
		HH_VH[pUnit:GetInstanceID()].KrasusEnd:Land()
		HH_VH[pUnit:GetInstanceID()].Alexstraz:Land()
		HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.DisableFlightMorph", 1000, 1)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_LegionLight", 6000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_FlameBreath", 15000, 0)
		HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstanceAlexstrazCleave", 8000, 0)
		HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.InstanceKrasusFlame", 12000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBPhase5", 1000, 0)
	end
end
----
----
function HH_VH.InstanceFDBSingleFire(pUnit, event)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(29953, target)
	end
end

function HH_VH.InstanceFDBSpecialFire(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10446)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Your days are done....")
	local FireRain = pUnit:GetRandomPlayer(0)
	if (FireRain ~= nil) then
		HH_VH[pUnit:GetInstanceID()].Cypx:CastSpellAoF(FireRain:GetX(), FireRain:GetY(), FireRain:GetZ(), 58936)
	end
	HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpell(38836)
end

function HH_VH.InstanceFDBPyroDeath(pUnit, event)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(13415)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Lets get this over with.")
		HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(64698, target)
	end
end


function HH_VH.InstanceFDBPhase5(pUnit, event)
	if (HH_VH[pUnit:GetInstanceID()].Cypx:GetHealthPct() <= 40) then
		HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10402)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Let us see what fate has in store..")
		HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstanceHH_VH[pUnit:GetInstanceID()].AlexstrazCleave", 8000, 0)
		HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.KrasusFlamestrike", 23000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBSingleFire", 6000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBSpecialFire", 24000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBPyroDeath", 33000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBPhase6", 1000, 0)
	end
end
----
----
function HH_VH.InstanceFDBFireBarrageFinal(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpell(38836)
end

--Final Special--
function HH_VH.InstanceFDBFinalSpecial6_1(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].Cypx:CastSpell(40647)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10404)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "No one can stop us! No one!")
	HH_VH[pUnit:GetInstanceID()].Cypx:SetFlying()
	HH_VH[pUnit:GetInstanceID()].Cypx:MoveTo(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ() + 20, pUnit:GetO())
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_2", 5000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_2(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(42, 0, "Chrysophylax begins to power a massive spell")
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10424)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Struggle as much as you like!")
	HH_VH[pUnit:GetInstanceID()].Cypx:ChannelSpell(60309, pUnit)
	pUnit:CastSpell(54141)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_3", 2000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_3(pUnit, event)
	GetUnit(pUnit,COL1):ChannelSpell(46906, pUnit)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(14, 0, "Do not worry champions I will give my life for you if the need come!")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_4", 3000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_4(pUnit, event)
	GetUnit(pUnit,COL1+1):ChannelSpell(46906, pUnit)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SendChatMessage(14, 0, "Nor will I allow you to perish my friends, we have come to far!")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_5", 3000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_5(pUnit, event)
	GetUnit(pUnit,COL1+2):ChannelSpell(46906, pUnit)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(13415)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "You were destined to fail!")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_6", 2000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_6(pUnit, event)
	GetUnit(pUnit,COL1+3):ChannelSpell(46906, pUnit)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(14, 0, "I WILL NOT allow you to take...control...OF.....THIS PLACE!")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_7", 2000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_7(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(42, 0, "Alexstraza breaks the bindings of the Twilight Master")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RemoveAura(40647)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SetCombatMeleeCapable(1)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:Root()
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstancePlayerPrisonBreakStart", 1000, 1)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_8", 2000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_8(pUnit, event)
	GetUnit(pUnit,COL1):ChannelSpell(46906, pUnit)
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10421)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Enough! I will erase your very existence!")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_9", 3000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_9(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(42, 0, "Chrysophylax gets ready to unleash his ultimate ability.")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstancePlayerProtectionStart", 1000, 1)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_10", 2000, 1)
end
function HH_VH.InstanceFDBFinalSpecial6_9(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:CastSpell(56397)
	GetUnit(pUnit,COL1):StopChannel()
	GetUnit(pUnit,COL1+1):StopChannel()
	GetUnit(pUnit,COL1+2):StopChannel()
	GetUnit(pUnit,COL1+3):StopChannel()
	GetUnit(pUnit,COL1+4):StopChannel()
	HH_VH[pUnit:GetInstanceID()].Cypx:StopChannel()
	pUnit:RemoveAura(54141)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceReturnFinalSpecial6", 2000, 1)
end
function HH_VH.InstanceReturnFinalSpecial6(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:MoveTo(HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnX(), HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnY(), HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnZ(), HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnO())
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBPhase6Start", 3000, 1)
end
--Final Special End--

function HH_VH.InstanceFDBPhase6(pUnit, event)
	if (HH_VH[pUnit:GetInstanceID()].Cypx:GetHealthPct() <= 20) then
		HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10444)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "So be it... You were warned...")
		HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBPhase6Start", 1000, 1)
	end
end

function HH_VH.InstanceFDBPhase6Start(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:Land()
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstanceAlexstrazCleave", 8000, 0)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RegisterEvent("HH_VH.InstanceKrasusFlame", 12000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFireBarrageFinal", 7000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBFinalSpecial6_1", 40000, 0)
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDBAssureLootDrop", 1000, 0)
end

function HH_VH.InstanceFDBAssureLootDrop(pUnit, event)
	if (HH_VH[pUnit:GetInstanceID()].Cypx:GetHealthPct() <= 2) then
		HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
		HH_VH[pUnit:GetInstanceID()].Cypx:Land()
		HH_VH[pUnit:GetInstanceID()].Cypx:MoveTo(HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnX(), HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnY(), HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnZ(), HH_VH[pUnit:GetInstanceID()].Cypx:GetSpawnO())
	end
end

function HH_VH.InstanceFDB_Start(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx = pUnit
	pUnit:PlaySoundToSet(11205)
	pUnit:SendChatMessage(12, 0, "What aggrivation is this? You will die!")
end

function HH_VH.InstanceFDB_Aggro(pUnit, event)
	pUnit:SetFaction(14)
	pUnit:PlaySoundToSet(11208)
	pUnit:SendChatMessage(14, 0,  "Your life will be mine!")
	pUnit:RegisterEvent("HH_VH.InstanceFDB_ShadowVolley", math.random(7000, 11000), 0)
	pUnit:RegisterEvent("HH_VH.InstanceEnterAlexKrasus", 45000, 1)
end

function HH_VH.InstanceFDB_Dies(pUnit, event)
	pUnit:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].bossDied = 3
	pUnit:PlaySoundToSet(10405)
	pUnit:SendChatMessage(14, 0, "We will triumph... it is only... a matter... of time...")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RegisterEvent("HH_VH.InstanceGrandCinematic_1", 3000, 1)
end

function HH_VH.InstanceFDB_Slay(pUnit, event)
	local slayerSpeak = math.random(1, 4)
	if (slayerSpeak == 1) then
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10403)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "One less obstacle in our way.")
	elseif (slayerSpeak == 2) then
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10416)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Leaving so soon?")
	elseif (slayerSpeak == 3) then
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(13413)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "There is no future for you!")
	elseif (slayerSpeak == 4) then
		HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10425)
		HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "You are irrelevant!")
	end

end

function HH_VH.InstanceFDB_Leaves(pUnit, event)
	pUnit:RemoveEvents()
	if (HH_VH[pUnit:GetInstanceID()].bossDied == 3) then
		pUnit:RegisterEvent("HH_VH.Instance_Reset_Check", 5000, 0)
		HH_VH[pUnit:GetInstanceID()].Cypx:Despawn(2000, 0)
		HH_VH[pUnit:GetInstanceID()].Alexstraz:Despawn(2000, 0)
		HH_VH[pUnit:GetInstanceID()].KrasusEnd:Despawn(2000, 0)
	end
end

function HH_VH.InstanceFDB_KillKrasus(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].Cypx:Root()
	HH_VH[pUnit:GetInstanceID()].Alexstraz:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].Alexstraz:Root()
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10400)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "The time has come to shatter this clockwork universe forever, let us no longer be slaves of the hourglass. I warn you, those who do not embrace this greater path shall be victims of its passing.")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_KillKrasusScene", 1000, 1)
end

function HH_VH.InstanceFDB_KillKrasusScene(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(14, 0, "NO! Krasus!!! My love!!!!")
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(16, 0, "The Queen of the Dragons cries out in agony")
	HH_VH[pUnit:GetInstanceID()].Cypx:Despawn(2000, 0)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:Despawn(3000, 0)
	pUnit:SendChatMessage(42, 0, "The consort of the queen has fallen. The will to fight has been diminished.")
	HH_VH[iid].resetMe = true
	HH_VH.Instance_Reset_Check(pUnit, event)
end

function HH_VH.InstanceFDB_KillAlexstraz(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:Root()
	HH_VH[pUnit:GetInstanceID()].Cypx:RemoveEvents()
	HH_VH[pUnit:GetInstanceID()].Cypx:Root()
	HH_VH[pUnit:GetInstanceID()].Cypx:PlaySoundToSet(10443)
	HH_VH[pUnit:GetInstanceID()].Cypx:SendChatMessage(14, 0, "Time-keeper, the sands of time have run out for you.")
	HH_VH[pUnit:GetInstanceID()].Cypx:RegisterEvent("HH_VH.InstanceFDB_KillAlexstrazScene", 1000, 1)
end
function HH_VH.InstanceFDB_KillAlexstrazScene(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SendChatMessage(14, 0, "My queen....my love...my wife...I have...failed you....")
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:SendChatMessage(16, 0, "Krasus cries out in agony")
	HH_VH[pUnit:GetInstanceID()].Cypx:Despawn(2000, 0)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:Despawn(3000, 0)
	pUnit:SendChatMessage(42, 0, "The Queen has fallen in battle. The will to fight has been diminished.")
	HH_VH[iid].resetMe = true
	HH_VH.Instance_Reset_Check(pUnit, event)
end

RegisterUnitEvent(ALEX, 4, "HH_VH.InstanceFDB_KillAlexstraz")
RegisterUnitEvent(K_END, 4, "HH_VH.InstanceFDB_KillKrasus")
----
----


RegisterUnitEvent(FDB, 1, "HH_VH.InstanceFDB_Aggro")
RegisterUnitEvent(FDB, 2, "HH_VH.InstanceFDB_Leaves")
RegisterUnitEvent(FDB, 3, "HH_VH.InstanceFDB_Slay")
RegisterUnitEvent(FDB, 4, "HH_VH.InstanceFDB_Dies")
RegisterUnitEvent(FDB, 18, "HH_VH.InstanceFDB_Start")
------HANDLE PLAYER FLYING-------------

function HH_VH.InstancePlayerFlightStart(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].Alexstraz:SendChatMessage(14, 0, "Champions! I have imbued you with a portion of power that will allow you to take flight! Come and help put an end to this fiend!")
	for k,players in pairs(HH_VH[pUnit:GetInstanceID()].FlightList) do
		players:SetFlying()
		players:SetMovementType(768)
		players:SetModel(6371)
		players:CastSpell(51802)
		players:SetScale(.6)
		players:EnableFlight(1)
	end
end

------HANDLE PRISON BREAK-------------

function HH_VH.InstancePlayerPrisonBreakStart(pUnit, event)
	for k,playersP in pairs(pUnit:GetInRangePlayers()) do
		playersP:RemoveAura(40647)
		HH_VH[pUnit:GetInstanceID()].Cypx:FullCastSpellOnTarget(38491, playersP)
	end
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:RemoveAura(40647)
end

------HANDLE ULTIMATE PROTECT-------------

function HH_VH.InstancePlayerProtectionStart(pUnit, event)
	for k,v in pairs(pUnit:GetInRangePlayers()) do
		HH_VH[pUnit:GetInstanceID()].Alexstraz:FullCastSpellOnTarget(31901, v)
	end
end

------HANDLE DISABLE FLIGHT AND MORPH-------------

function HH_VH.DisableFlightMorph(pUnit, event)
	for k,playersFlight in pairs(pUnit:GetInRangePlayers()) do
		playersFlight:SetMovementType(256)
		playersFlight:Land()
		playersFlight:SetModel(0)
		playersFlight:DeMorph()
		playersFlight:SetScale(1)
		playersFlight:EnableFlight(0)
		HH_VH[pUnit:GetInstanceID()].Alexstraz:FullCastSpellOnTarget(130, playersFlight)
	end
end

---GRAND CINEMATIC ENDING---
function HH_VH.InstanceGrandCinematic_1(pUnit, event)
	local iid = pUnit:GetInstanceID()
	pUnit:CastSpell(63660)
	HH_VH[iid].KrasusEnd:CastSpell(63660)
	pUnit:SetModel(28227)
	HH_VH[iid].KrasusEnd:SetModel(24976)
	pUnit:SetScale(1)
	HH_VH[iid].KrasusEnd:SetScale(1)
	pUnit:EventChat(12, 0, "Young heroes, I cannot express how grateful I am to have your aid. I do not wish to fathom what may have occured had you not aided my consort.", 2000)
	pUnit:EventChat(12, 0, "Chrysophylax was a powerful opponent. He managed to fool all of us..I can only imagine what other minions The Lich King has.", 6000)
	pUnit:EventChat(16, 0, "Krasus has a troubled look on his face.", 11000)
	pUnit:EventChat(12, 0, "Krasus my love, do not worry what the future holds. We have heroes like these all across the lands to protect Azeroth from destruction.", 11000)
	pUnit:EventChat(12, 0, "My friends, I hearby declare you Champions of the Red Dragonflight. Your actions on this day have showed burning courage in the face of destruction.", 17000)
	pUnit:EventChat(12, 0, "Because of you the Kirin'Tor, Dalaran, and Northrend have been protected from the forces of Arthas, and for this we are eternally grateful!", 21000)
	pUnit:EventChat(12, 0, "I must also extend my personal thanks to you champions, without you I fear I may have not been able to keep the seal on the Violet Hold strong to hold back the forces.", 27000)
	pUnit:EventChat(12, 0, "And now that Chrysophylax has been defeated the Violet Hold is safe from any further invasions, so for that the Kirin'Tor thank you as well.", 34000)
	pUnit:EventChat(12, 0, "Come Krasus, let us go back to the Wyrmrest temple and rest, we have had a long fight today and it is well deserved.", 39000)
	pUnit:EventChat(12, 0, "Yes my queen.", 43000)
	pUnit:EventChat(15, 0, "Haha I think I shall enjoy a nice 'rest' with my queen.", 45000)
	pUnit:EventChat(12, 0, "You know...I can hear your thoughts my love.", 48000)
	pUnit:EventChat(16, 0, "Alexstrasza smiles.", 50000)
	pUnit:RegisterEvent("HH_VH.InstanceGrandCinematic_2", 53000, 1)
end

function HH_VH.InstanceGrandCinematic_2(pUnit, event)
	pUnit:CastSpell(7077)
	pUnit:Despawn(2000 , 0)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:EventChat(12, 0, "Oh my, oh my, this should be fun... Erhem... uhh... Farewell Champions!", 3000)
	pUnit:RegisterEvent("HH_VH.InstanceGrandCinematic_3", 5000, 1)
end

function HH_VH.InstanceGrandCinematic_3(pUnit, event)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:CastSpell(7077)
	HH_VH[pUnit:GetInstanceID()].KrasusEnd:Despawn(2000, 0)
end
-------------------------------------------------------------------------
---                             VIOLET HOLD TRASH			          ---
-------------------------------------------------------------------------

--Deathknight Captain

--Strikes
function HH_VH.Instance_DKCStrike(pUnit, event)
	local timer = math.random(5000, 8000)
	local strikeSelection = math.random(1, 3)
	local target = pUnit:GetMainTank()
	if (target ~= nil and strikeSelection == 1) then
		pUnit:FullCastSpellOnTarget(59130, target)
	elseif (target ~= nil and strikeSelection == 2) then
		pUnit:FullCastSpellOnTarget(55255, target)
	elseif (target ~= nil and strikeSelection == 3) then
		pUnit:FullCastSpellOnTarget(60951, target)
	end
	pUnit:RegisterEvent("HH_VH.Instance_DKCStrike2", timer, 1)
end
function HH_VH.Instance_DKCStrike2(pUnit, event)
	local timer = math.random(5000, 8000)
	local strikeSelection = math.random(1, 3)
	local target = pUnit:GetMainTank()
	if (target ~= nil and strikeSelection == 1) then
		pUnit:FullCastSpellOnTarget(59130, target)
	elseif (target ~= nil and strikeSelection == 2) then
		pUnit:FullCastSpellOnTarget(55255, target)
	elseif (target ~= nil and strikeSelection == 3) then
		pUnit:FullCastSpellOnTarget(60951, target)
	end
	pUnit:RegisterEvent("HH_VH.Instance_DKCStrike", timer, 1)
end

--Icy Touch
function HH_VH.Instance_DKCIceTouch(pUnit, event)
	local timer = math.random(10000, 12000)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(59011, target)
	end
	pUnit:RegisterEvent("HH_VH.Instance_DKCIceTouch2", timer, 1)
end
function HH_VH.Instance_DKCIceTouch2(pUnit, event)
	local timer = math.random(10000, 12000)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(59011, target)
	end
	pUnit:RegisterEvent("HH_VH.Instance_DKCIceTouch", timer, 1)
end

--Death Grip
function HH_VH.Instance_DKCDeathGrip(pUnit, event)
	local timer = math.random(15000, 19000)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(57602, target)
		pUnit:Attack(target)
	end
	pUnit:RegisterEvent("HH_VH.Instance_DKCDeathGrip2", timer, 1)
end
function HH_VH.Instance_DKCDeathGrip2(pUnit, event)
	local timer = math.random(15000, 19000)
	local target = pUnit:GetRandomPlayer(0)
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(57602, target)
		pUnit:Attack(target)
	end
	pUnit:RegisterEvent("HH_VH.Instance_DKCDeathGrip", timer, 1)
end

function HH_VH.Instance_DKCAggro(pUnit, event)
	local auraSelect = math.random(1, 3)
	if (auraSelect == 1) then
		pUnit:CastSpell(50689)
	elseif (auraSelect == 2) then
		pUnit:CastSpell(48263)
	else
		pUnit:CastSpell(49772)
	end
	pUnit:RegisterEvent("HH_VH.Instance_DKCStrike", 7000, 1)
	pUnit:RegisterEvent("HH_VH.Instance_DKCIceTouch", 12000, 1)
	pUnit:RegisterEvent("HH_VH.Instance_DKCDeathGrip", 15000, 1)
end

function HH_VH.Instance_DKCDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function HH_VH.Instance_DKCLeave(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(DKC, 1, "HH_VH.Instance_DKCAggro")
RegisterUnitEvent(DKC, 2, "HH_VH.Instance_DKCLeave")
RegisterUnitEvent(DKC, 4, "HH_VH.Instance_DKCDeath")
---------------------------------------------------

--Skeletal Captain
function HH_VH.Instance_SCStrike(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(32736, target)
	end
end

function HH_VH.Instance_SCThunder(pUnit, event)
	pUnit:CastSpell(60019)
end

function HH_VH.Instance_SCShout(pUnit, event)
	local shoutSelect = math.random(1, 2)
	if (shoutSelect == 1) then
		pUnit:CastSpell(59614)
	else
		pUnit:CastSpell(19778)
	end
end

function HH_VH.Instance_SCAggro(pUnit, event)
	pUnit:RegisterEvent("HH_VH.Instance_SCStrike", 12000, 0)
	pUnit:RegisterEvent("HH_VH.Instance_SCThunder", 8000, 1)
	pUnit:RegisterEvent("HH_VH.Instance_SCShout", 15000, 1)
end

function HH_VH.Instance_SCDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function HH_VH.Instance_SCLeave(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(SC, 1, "HH_VH.Instance_SCAggro")
RegisterUnitEvent(SC, 2, "HH_VH.Instance_SCLeave")
RegisterUnitEvent(SC, 4, "HH_VH.Instance_SCDeath")
---------------------------------------------------

--Darkshade
function HH_VH.Instance_DSVolley(pUnit, event)
	pUnit:FullCastSpell(38840)
end

function HH_VH.Instance_DSCurse(pUnit, event)
	pUnit:FullCastSpell(60121)
end

function HH_VH.Instance_DSAggro(pUnit, event)
	pUnit:RegisterEvent("HH_VH.Instance_DSVolley", 5000, 0)
	pUnit:RegisterEvent("HH_VH.Instance_DSCurse", 8000, 1)
end

function HH_VH.Instance_DSDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function HH_VH.Instance_DSLeave(pUnit, event)
	pUnit:RemoveEvents()
end

function HH_VH.Instance_DodgeSecurity(pUnit, event)
	local dodgeTank = pUnit:GetMainTank()
	local dodgeProc = math.random(1, 10)
	if (dodgeProc >= 5 and dodgeTank ~= nil) then
		pUnit:FullCastSpellOnTarget(16448, dodgeTank)
		pUnit:FullCastSpellOnTarget(31651, dodgeTank)
	end
end

RegisterUnitEvent(DS,  6, "HH_VH.Instance_DodgeSecurity")
RegisterUnitEvent(SC,  6, "HH_VH.Instance_DodgeSecurity")
RegisterUnitEvent(DS,  6, "HH_VH.Instance_DodgeSecurity")
RegisterUnitEvent(DS,  6, "HH_VH.Instance_DodgeSecurity")
RegisterUnitEvent(DKC, 6, "HH_VH.Instance_DodgeSecurity")
RegisterUnitEvent(LDB, 6, "HH_VH.Instance_DodgeSecurity")
RegisterUnitEvent(PSB, 6, "HH_VH.Instance_DodgeSecurity")
RegisterUnitEvent(FDB, 6, "HH_VH.Instance_DodgeSecurity")


RegisterUnitEvent(DS, 1, "HH_VH.Instance_DSAggro")
RegisterUnitEvent(DS, 2, "HH_VH.Instance_DSLeave")
RegisterUnitEvent(DS, 4, "HH_VH.Instance_DSDeath")