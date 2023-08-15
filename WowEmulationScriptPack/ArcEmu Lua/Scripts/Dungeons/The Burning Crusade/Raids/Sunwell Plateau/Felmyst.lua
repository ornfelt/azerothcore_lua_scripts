--[[ Boss -- Felmyst.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, February 21, 2008. ]]

--[[ 
Abilities
---------------
*19983=Cleave: Frontal area of effect cleave.
*45866=Corrosion: Cast on the main tank. Deals heavy nature damage and increases damage taken by 100% for 10 seconds.
*45402=Demonic Vapor: Cast when airborne. Similar to Nightbane's breath; deals nature damage and summons skeletons. Also leaves behind a trail that if stepped in applies a nature damage debuff and summons more skeletons.
*45855=Gas Nova: Area of effect spell that will hit all nearby raid members. Periodically deals nature damage and drains mana. Lasts 30 seconds and can be removed with Mass Dispel.
*47002=Noxious Fumes: Nature damage aura similar to Sapphiron's frost aura.
*45662=Encapsulate: Randomly targeted. Stuns a player for six seconds and deals arcane damage to the target and nearby allies.
*45717=Fog of Corruption: Summons a large green cloud that mind controls any player who enters it. Drastically increases speed, damage, and healing done by affected players. Cannot be dispelled.
*46587=Berserk: Felmyst enrages after 10 minutes, killing any remaining raid members quickly.
--]]

function Felmyst_OnEnterCombat(Unit,Event)
	Unit:Land()
	Unit:RegisterEvent("Felmyst_Cleave",20000,0)
	Unit:RegisterEvent("Felmyst_Corrosion",36000,0)
	Unit:RegisterEvent("Felmyst_GasNova",30000,0)
	Unit:RegisterEvent("Felmyst_NoxiousFumes",27000,0)
	Unit:RegisterEvent("Felmyst_Encapsulate",45000,0)
	--Unit:RegisterEvent("Felmyst_FogofCorruption",000,0)
	Unit:RegisterEvent("Felmyst_Enrage",600000,0)
	Unit:RegisterEvent("Felmyst_Phase2",75000,0) -- Every 75 Seconds she will fly into the air.
end

function Felmyst_OnSpawn(Unit,Event)
	Unit:SetFlying()
	--Unit:MoveTo(X,Y,Z) She needs to move to the raid, Flys in and then lands.
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Glory to Kil'jaeden! Death to all who oppose!")
end

function Felmyst_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Felmyst_OnDied(Unit,Event)
	Unit:RemoveEvents()
	--Unit:SpawnCreature(ID,X,Y,Z,O,Faction,0)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Kil'jaeden... will... prevail...")
end

function Felmyst_OnKilledPlayer(Unit,Event)
	local Choice=math.random(1,2)
		if Choice==1 then
			pUnit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I kill for the master!")
		elseif Choice==2 then
			pUnit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"The end has come!")
	end
end

function Felmyst_Phase2(Unit,Event)
	Unit:SetFlying()
	Unit:RegisterEvent("Felmyst_DemonicVapor",000,0)
	Unit:RegisterEvent("Felmyst_Land",000,0)
end
