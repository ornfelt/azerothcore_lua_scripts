UNIT_FLAG_IS_ATTACKABLE_1 = 0
UNIT_FLAG_NOT_ATTACKABLE_1 = 320

--[[
  NPC Visuals Entries:

		     NAME		     				 |	ENTRY
       ______________________________________|__________
	Tirion Fordring - Welcome 	    	 |	360950
	Tirion Fordring - Gormok Intro	     |	360951
	Tirion Fordring - Jormungar Intro    |	360952
	Tirion Fordring - Yeti Intro         |	360953
	Tirion Fordring - Yeti Death         |  360954
	Tirion Fordring - Yeti Leaves Combat |  360955
	Tirion Fordring - Wilfred Intro	     |  360956
	Tirion Fordring - Jaraxxus Intro     |	360957
	Tirion Fordring - Jaraxxus Death     |	360958
	Tirion Fordring - PVP intro	     	 |	360959
	Tirion Fordring - PVP Outro	     	 |	360960
	Tirion Fordring - Twins Intro	     | 	360961
	Tirion Fordring - Anub Intro	     |	360962
	Tirion Fordring - Ending	     	 |	360963
	King Varian Wrynn - Jaraxxus Death   |	370000
	Garrosh Hellscream - Ally PVP intro  |	370001
	Garrosh Hellscream - Kills target    |	370002
	King Varian Wrynn - Ally PVP win     |	370003
	The Lich King - Anub intro	     	 |	370010
	Anub'Arak - Anub Intro		     	 |	370011
	Lich King's Death Gate - Anub intro  |  370012

]]
	



function NPC_Despawn(pUnit, event)
	pUnit:Despawn(1, 0)
end

------------------
--    Welcome   --	NPC ENTRY: 360950
------------------

function Tirion1_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Welcome champions! You have heard the call of the Argent Crusade, and you are boughly answerd! It is here, in the Crusader's Coliseum that you will face your greatest challenges. Those of you who survive the riggers of the coliseum will join the Argent Crusade on it's march to Icecrown Citadel!")
	pUnit:PlaySoundToSet(16036)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360950, 18, "Tirion1_Spawn")


----------------------
--   Gormok Intro   --	NPC ENTRY: 360951
----------------------

function Tirion2_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Hailing from the deepest darkest caverns of the Storm Peaks, Gormok the Impaler! Battle on heroes.")
	pUnit:PlaySoundToSet(16038)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360951, 18, "Tirion2_Spawn")



-------------------------
--   Jormungar Intro   --	NPC ENTRY: 360952
-------------------------

function Tirion3_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Steel yourselves heroes, for the twin terrors, Acidmaw and Dreadscale. Enter the arena!")
	pUnit:PlaySoundToSet(16039)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360952, 18, "Tirion3_Spawn")



-------------------------
--     Yeti Intro      --	NPC ENTRY: 360953
-------------------------

function Tirion4_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "The air itself freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!")
	pUnit:PlaySoundToSet(16040)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360953, 18, "Tirion4_Spawn")



-------------------------
--     Yeti Death      --	NPC ENTRY: 360954
-------------------------

function Tirion5_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "The monster's vinagiry has been vanquished!")
	pUnit:PlaySoundToSet(16041)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360954, 18, "Tirion5_Spawn")



-------------------------
--     Yeti Kill       --	NPC ENTRY: 360955
-------------------------

function Tirion6_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Tragic. They fought valiantly. But the beasts of northrend triumphed. Let us observe a moment of silence for our fallen heroes.")
	pUnit:PlaySoundToSet(16042)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360955, 18, "Tirion6_Spawn")



-------------------------
--   Wilfred Intro     --	NPC ENTRY: 360956
-------------------------

-- (alliance)

function Tirion7_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!")
	pUnit:PlaySoundToSet(16043)
	pUnit:SpawnCreature(370013, 563.924683, 156.855804, 394.432642, 4.708477, 35, 0)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360956, 18, "Tirion7_Spawn")



-- (horde)

function Tirion7Horde_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry!")
	pUnit:PlaySoundToSet(16043)
	pUnit:SpawnCreature(570013, 563.924683, 156.855804, 394.432642, 4.708477, 35, 0)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(560956, 18, "Tirion7Horde_Spawn")



-------------------------
--   Jaraxxus Intro    --	NPC ENTRY: 360957
-------------------------

function Tirion8_Spawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Quickly, heroes! Destroy the demon lord before it can open a portal to its twisted demonic realm!")
	pUnit:PlaySoundToSet(16044)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360957, 18, "Tirion8_Spawn")



-------------------------
--   Jaraxxus Death    --	NPC ENTRY: 360958
-------------------------

function Tirion9_Spawn(pUnit, event)
	pUnit:RegisterEvent("Tirion9_Talk", 6000, 1)
end

function Tirion9_Talk(pUnit, event)
	pUnit:SendChatMessage(14, 0, "The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and must now face the next challenge.")
	pUnit:PlaySoundToSet(16045)
	pUnit:RegisterEvent("Tirion9_JaraxxusCalm", 31000, 1)
	local x = pUnit:GetX();
	local y = pUnit:GetY();
	local z = pUnit:GetZ();
	local o = pUnit:GetO();
	pUnit:SpawnCreature(370004, x, y, z, o, 35, 0)
end

RegisterUnitEvent(360958, 18, "Tirion9_Spawn")



-------------------------
--   Jaraxxus Calm     --
-------------------------

function Tirion9_JaraxxusCalm(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Everyone, calm down! Compose yourselves! There is no conspiracy at play here. The warlock acted on his own volition - outside of influences from the Alliance. The tournament must go on!")
	pUnit:PlaySoundToSet(16046)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

function GarroshX_OnSpawn(pUnit, event)		-- NPC ENTRY: 370004
	pUnit:RegisterEvent("GarroshX_Talk", 15000, 1)
end

function Varian1_OnSpawn(pUnit, event)		-- NPC ENTRY: 370000
	pUnit:RegisterEvent("Varian1_Talk", 9000, 1)
end

function GarroshX_Talk(pUnit, event)
	local x = pUnit:GetX();
	local y = pUnit:GetY();
	local z = pUnit:GetZ();
	local o = pUnit:GetO();
	pUnit:SpawnCreature(370000, x, y, z, o, 35, 0)
	pUnit:SendChatMessage(14, 0, "Treacherous Alliance dogs! You summon a demon lord against warriors of the Horde!? Your deaths will be swift!")
	pUnit:PlaySoundToSet(16021)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

function Varian1_Talk(pUnit, event)
	pUnit:SendChatMessage(14, 0, "The Alliance doesn't need the help of a demon lord to deal with Horde filth. Come, pig!")
	pUnit:PlaySoundToSet(16064)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(370004, 18, "GarroshX_OnSpawn")
RegisterUnitEvent(370000, 18, "Varian1_OnSpawn")



---------------------------------
--     PVP Intro  Alliance     --	NPC ENTRY: 360959
---------------------------------

function Tirion10_OnSpawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "The next battle will be against the Argent Crusade's most powerful knights! Only by defeating them will you be deemed worthy.")
	pUnit:PlaySoundToSet(16047)
	local x = pUnit:GetX();
	local y = pUnit:GetY();
	local z = pUnit:GetZ();
	local o = pUnit:GetO();
	pUnit:SpawnCreature(370001, x, y, z, o, 35, 0)
	pUnit:RegisterEvent("Tirion10_PVPAgree", 23000, 1)
end

RegisterUnitEvent(360959, 18, "Tirion10_OnSpawn")


function Garrosh1_OnSpawn(pUnit, event)		-- NPC ENTRY: 370001
	pUnit:RegisterEvent("Garrosh1_Talk", 8000, 1)
end

function Garrosh1_Talk(pUnit, event)
	pUnit:SendChatMessage(14, 0, "The Horde demands justice! We challenge the Alliance. Allow us to battle in place of your knights, paladin. We will show these dogs what it means to insult the Horde!")
	pUnit:PlaySoundToSet(16023)
	pUnit:RegisterEvent("Garrosh1_Talk2", 19000, 1)
end

function Tirion10_PVPAgree(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Very well, I will allow it. Fight with honor!")
	pUnit:PlaySoundToSet(16048)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

function Garrosh1_Talk2(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Show them no mercy, Horde champions! LOK'TAR OGAR!")
	pUnit:PlaySoundToSet(16022)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(370001, 18, "Garrosh1_OnSpawn")




-------------------------
--     	PVP Slay       --	NPC ENTRY: 370002
-------------------------

function Garrosh2_OnSpawn(pUnit, event)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
	local randomsay=math.random(1, 4)
		if randomsay==1 then
			pUnit:SendChatMessage(14, 0, "Weakling!")
			pUnit:PlaySoundToSet(16017)
		elseif randomsay==2 then
			pUnit:SendChatMessage(14, 0, "Pathetic!")
			pUnit:PlaySoundToSet(16018)
		elseif randomsay==3 then
			pUnit:SendChatMessage(14, 0, "Overpowered.")
			pUnit:PlaySoundToSet(16019)
		elseif randomsay==4 then
			pUnit:SendChatMessage(14, 0, "Lok'tar!")
			pUnit:PlaySoundToSet(16020)
	end
end

RegisterUnitEvent(370002, 18, "Garrosh2_OnSpawn")



--------------------------
--	 	PVP Win			--	NPC ENTRY: 370003
--------------------------

function Varian2_OnSpawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Glory to the Alliance!")
	pUnit:PlaySoundToSet(16067)
	local x = pUnit:GetX();
	local y = pUnit:GetY();
	local z = pUnit:GetZ();
	local o = pUnit:GetO();
	pUnit:SpawnCreature(360960, x, y, z, o, 35, 0)	
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(370003, 18, "Varian2_OnSpawn")




--------------------------
--		PVP Outro		--	NPC ENTRY: 360960
--------------------------

function Tirion11_OnSpawn(pUnit, event)
	pUnit:RegisterEvent("Tirion11_Talk", 3000, 1)
end

function Tirion11_Talk(pUnit, event)
	pUnit:SendChatMessage(14, 0, "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.")
	pUnit:PlaySoundToSet(16049)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360960, 18, "Tirion11_OnSpawn")




--------------------------
--		Twins Intro		--	NPC ENTRY: 360961
--------------------------

function Tirion12_OnSpawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Only by working together will you overcome the final challenge. From the deaths of icecrown come two of the scourge's most powerful lieutennants! Fearsome Val'kyr, winged avangers of the Lich King!")
	pUnit:PlaySoundToSet(16050)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

RegisterUnitEvent(360961, 18, "Tirion12_OnSpawn")




--------------------------
--		Anub Into		--	NPC ENTRYS: TirionVisual-360962    LichKing-370010    AnubArakVisual-370011
--------------------------

function Tirion13_OnSpawn(pUnit, event)
	pUnit:SendChatMessage(14, 0, "A mighty blow has been dealt to the Lich King! You have proven yourselves able bodied champions of the Argent Crusade. Together we will strike at Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!")
	pUnit:PlaySoundToSet(16051)
	pUnit:RegisterEvent("Tirion13_Talk1", 24000, 1)
	pUnit:RegisterEvent("Tirion13_SpawnLichKing", 16000, 1)
	
end

RegisterUnitEvent(360962, 18, "Tirion13_OnSpawn")

function Tirion13_SpawnLichKing(pUnit, event)
	pUnit:SpawnCreature(370010, 563.924683, 156.855804, 394.432642, 4.708477, 16, 0)
	pUnit:SpawnCreature(370012, 563.924683, 151.867065, 394.432642, 4.708477, 35, 0)
end

function LichKing_OnSpawn(pUnit, event)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:MoveTo(563.924683, 147.140350, 393.930328, 4.712687)
	pUnit:RegisterEvent("LichKing_Talk1", 3000, 1)
end

RegisterUnitEvent(370010, 18, "LichKing_OnSpawn")

function LichKing_Talk1(pUnit, event)
	pUnit:SendChatMessage(14, 0, "You will have your challenge, Fordring.")
	pUnit:PlaySoundToSet(16321)
	pUnit:RegisterEvent("LichKing_Talk2", 12000, 1)
end

function Tirion13_Talk1(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.")
	pUnit:PlaySoundToSet(16052)
	pUnit:RegisterEvent("NPC_Despawn", 1000, 1)
end

function LichKing_Talk2(pUnit, event)
	pUnit:SendChatMessage(14, 0, "The Nerubians built an empire beneath the frozen wastes of Northrend. An empire that you so foolishly built your structures upon. MY EMPIRE.")
	pUnit:PlaySoundToSet(16322)
	pUnit:RegisterEvent("LichKing_Talk3", 21000, 1)
end

function LichKing_Talk3(pUnit, event)
  pUnit:SpawnCreature(370011, 678.977905, 137.517639, 142.228220, 3.112536, 16, 0)
  pUnit:RegisterEvent("NPC_Despawn", 10000, 1)
  pUnit:SendChatMessage(14, 0, "The souls of your fallen champions will be mine, Fordring.")
  pUnit:PlaySoundToSet(16323)
    local x = pUnit:GetX();
    local y = pUnit:GetY();
    local z = pUnit:GetZ();
    local o = pUnit:GetO();
    local floor = pUnit:GetGameObjectNearestCoords(x,y,z,195003);
	if floor ~= nil then
		floor:SetUInt32Value(GAMEOBJECT_STATE, 1)
	end
end

function AnubArak_Welcome(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Ahhh... Our guests have arrived, just as the master promised.")
	pUnit:PlaySoundToSet(16235)
	pUnit:Despawn(1, 0)
end

RegisterUnitEvent(370011, 1, "AnubArak_Welcome")

function LichKingDeathGate_OnSpawn(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	pUnit:RegisterEvent("NPC_Despawn", 4000, 1)
end

RegisterUnitEvent(370012, 18, "LichKingDeathGate_OnSpawn")




--------------------------
--		Anub Outro		--	NPC ENTRY: 360963
--------------------------

function Tirion14_OnSpawn(pUnit, event)
	pUnit:MoveTo(712.979004, 134.200302, 142.159021, 6.259623)
	pUnit:RegisterEvent("Tirion14_Talk1", 27000, 1)
end

function Tirion14_Talk1(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Champions, you're alive! Not only have you defeated every challenge of the Trial of the Crusader, but thwarted Arthas directly! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of my mages to transport you back to the surface!")
	-- couldn't find the sound id :(
	pUnit:SpawnGameObject(195080, 707.049622, 127.587372, 142.140053, 0)
	pUnit:RegisterEvent("NPC_Despawn", 30000, 0)
end

RegisterUnitEvent(360963, 18, "Tirion14_OnSpawn")




----------------------------------------------------------
--		Wilfred Fizzlebang and Jaraxxus (alliance)		--   NPC ENTRIES: WilfredAlliance: 370013	WilfredHorde: 570013         SummoningCircleVisual: 370014	       JaraxxusAlliance: 34780	      JaraxxusHorde: 54780
----------------------------------------------------------

function Wilfred_OnSpawn(pUnit, event)
	pUnit:RegisterEvent("Wilfred_Talk1", 7000, 1)
	pUnit:MoveTo(563.572388, 139.693527, 393.849, 4.739881)
end

function Wilfred_Talk1(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Thank you, Highlord! Now challengers, I will begin the ritual of summoning. When I am done, a fearsome doomguard will appear.")
	pUnit:PlaySoundToSet(16268)
	pUnit:RegisterEvent("Wilfred_StartSummoning", 10000, 1)
end

function Wilfred_StartSummoning(pUnit, event)
	pUnit:Emote(468)
	pUnit:SpawnCreature(370014, 563.700, 139.595, 393.868, 4.729359, 35, 9000)
	pUnit:RegisterEvent("Wilfred_SummoningTalk", 3000, 1)
	pUnit:Emote(468)
end

function SummoningCircle_OnSpawn(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(370014, 18, "SummoningCircle_OnSpawn")

function Wilfred_SummoningTalk(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Prepare for oblivion!")
	pUnit:SpawnCreature(34807, 563.700, 139.595, 393.868, 4.729359, 35, 6000)
	pUnit:PlaySoundToSet(16269)
	pUnit:RegisterEvent("Wilfred_DoneSummoning", 5000, 1)
end

function Wilfred_DoneSummoning(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Haha, I have done it! Behold the absolute power of Wilfred Fizzlebang, Master Summoner! You are bound to me, demon.")
	pUnit:PlaySoundToSet(16270)
	pUnit:Emote(0)
	pUnit:RegisterEvent("Wilfred_Death", 17000, 1)
	pUnit:SpawnCreature(34780, 563.791, 133.299, 393.960, 1.623110, 16, 0)
end

function Wilfred_Death(pUnit, event)
	pUnit:SendChatMessage(14, 0, "But I'm in charge he-")
	pUnit:PlaySoundToSet(16271)
	pUnit:RemoveEvents()
	pUnit:Despawn(2000, 0)
end

RegisterUnitEvent(370013, 18, "Wilfred_OnSpawn")

function Jaraxxus_OnSpawn(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatSpellCapable(1)
	pUnit:SetCombatRangedCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:RegisterEvent("Jaraxxus_Talk1", 12500, 1)
end

function Jaraxxus_Talk1(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Triffeling gnome! Your arrogance will be your undoing!")
	pUnit:PlaySoundToSet(16143)
	pUnit:RegisterEvent("Jaraxxus_KillGnome", 5000, 1)
end

function Jaraxxus_KillGnome(pUnit, event)
	pUnit:RegisterEvent("Jaraxxus_Move", 2000, 1)

end

function Jaraxxus_Move(pUnit, event)
	pUnit:MoveTo(563.881, 151.592, 393.932, 4.705012)
	pUnit:RegisterEvent("Jaraxxus_Attack", 8000, 1)
end

function Jaraxxus_Attack(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_IS_ATTACKABLE_1)
	pUnit:SetCombatCapable(0)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:SetCombatSpellCapable(0)
	pUnit:SetCombatRangedCapable(0)
	pUnit:SetCombatTargetingCapable(0)
	pUnit:Emote(333)
	pUnit:SpawnCreature(360957, 563, 151, 393, 4, 35, 0)
end

RegisterUnitEvent(34780, 18, "Jaraxxus_OnSpawn")



----------------------------------------------------------
--		Wilfred Fizzlebang and Jaraxxus (horde)			--
----------------------------------------------------------

function WilfredHorde_OnSpawn(pUnit, event)
	pUnit:RegisterEvent("WilfredHorde_Talk1", 7000, 1)
	pUnit:MoveTo(563.572388, 139.693527, 393.849, 4.739881)
end

function WilfredHorde_Talk1(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Thank you, Highlord! Now challengers, I will begin the ritual of summoning. When I am done, a fearsome doomguard will appear.")
	pUnit:PlaySoundToSet(16268)
	pUnit:RegisterEvent("WilfredHorde_StartSummoning", 10000, 1)
end

function WilfredHorde_StartSummoning(pUnit, event)
	pUnit:Emote(468)
	pUnit:SpawnCreature(370014, 563.700, 139.595, 393.868, 4.729359, 35, 9000)
	pUnit:RegisterEvent("WilfredHorde_SummoningTalk", 3000, 1)
	pUnit:Emote(468)
end

function WilfredHorde_SummoningTalk(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Prepare for oblivion!")
	pUnit:SpawnCreature(34807, 563.700, 139.595, 393.868, 4.729359, 35, 6000)
	pUnit:PlaySoundToSet(16269)
	pUnit:RegisterEvent("WilfredHorde_DoneSummoning", 5000, 1)
end

function WilfredHorde_DoneSummoning(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Haha, I have done it! Behold the absolute power of Wilfred Fizzlebang, Master Summoner! You are bound to me, demon.")
	pUnit:PlaySoundToSet(16270)
	pUnit:Emote(0)
	pUnit:RegisterEvent("WilfredHorde_Death", 17000, 1)
	pUnit:SpawnCreature(54780, 563.791, 133.299, 393.960, 1.623110, 16, 0)
end

function WilfredHorde_Death(pUnit, event)
	pUnit:SendChatMessage(14, 0, "But I'm in charge he-")
	pUnit:PlaySoundToSet(16271)
	pUnit:RemoveEvents()
	pUnit:Despawn(1, 0)
end

RegisterUnitEvent(570013, 18, "WilfredHorde_OnSpawn")

function JaraxxusHorde_OnSpawn(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatSpellCapable(1)
	pUnit:SetCombatRangedCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:RegisterEvent("JaraxxusHorde_Talk1", 12500, 1)
end

function JaraxxusHorde_Talk1(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Triffeling gnome! Your arrogance will be your undoing!")
	pUnit:PlaySoundToSet(16143)
	pUnit:RegisterEvent("JaraxxusHorde_KillGnome", 5000, 1)
end

function JaraxxusHorde_KillGnome(pUnit, event)
	pUnit:RegisterEvent("JaraxxusHorde_Move", 2000, 1)
end

function JaraxxusHorde_Move(pUnit, event)
	pUnit:MoveTo(563.881, 151.592, 393.932, 4.705012)
	pUnit:RegisterEvent("JaraxxusHorde_Attack", 8000, 1)
end

function JaraxxusHorde_Attack(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_IS_ATTACKABLE_1)
	pUnit:SetCombatCapable(0)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:SetCombatSpellCapable(0)
	pUnit:SetCombatRangedCapable(0)
	pUnit:SetCombatTargetingCapable(0)
	pUnit:Emote(333)
	pUnit:SpawnCreature(360957, 563, 151, 393, 4, 35, 0)
end

RegisterUnitEvent(54780, 18, "JaraxxusHorde_OnSpawn")



function SummoningPortal_OnSpawn(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end
RegisterUnitEvent(34807, 18, "SummoningPortal_OnSpawn")

------------------------------------------------------------------
------------------------------------------------------------------
--																--
--	EEEEEEEE			NNN     NN				DDDDDDDDD		--
--	EE					NNNN    NN				DDDDDDDDDDD		--
--	EE					NN NN   NN				DD	  	  DD	--
--	EE					NN NN   NN				DD	       DD	--
--	EE					NN  NN  NN				DD	       DD	--
--	EEEEEEE 			NN  NN  NN				DD	       DD	--
--	EE					NN   NN NN  			DD	       DD	--
--	EE					NN   NN NN  			DD  	  DD	--
--	EE					NN    NNNN				DD	 	 DD		--
--	EE					NN     NNN				DDDDDDDDDDD	   	--
--	EEEEEEEE			NN      NN				DDDDDDDDD		--
--																--
------------------------------------------------------------------
------------------------------------------------------------------