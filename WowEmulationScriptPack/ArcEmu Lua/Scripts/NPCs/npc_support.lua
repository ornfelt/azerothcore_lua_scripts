--(  __  \ (  ___  )|\     /|(  ___ \ ( \      (  ____ \         |\     /|         (  ____ )(  ____ \( \      (  ____ \(  ___  )(  ____ \(  ____ \--
--| (  \  )| (   ) || )   ( || (   ) )| (      | (    \/         | )   ( |         | (    )|| (    \/| (      | (    \/| (   ) || (    \/| (    \/--
--| |   ) || |   | || |   | || (__/ / | |      | (__       _____ | (___) | _____   | (____)|| (__    | |      | (__    | (___) || (_____ | (__    --
--| |   | || |   | || |   | ||  __ (  | |      |  __)     (_____)|  ___  |(_____)  |     __)|  __)   | |      |  __)   |  ___  |(_____  )|  __)   --
--| |   ) || |   | || |   | || (  \ \ | |      | (               | (   ) |         | (\ (   | (      | |      | (      | (   ) |      ) || (      --
--| (__/  )| (___) || (___) || )___) )| (____/\| (____/\         | )   ( |         | ) \ \__| (____/\| (____/\| (____/\| )   ( |/\____) || (____/\--
--(______/ (_______)(_______)|/ \___/ (_______/(_______/         |/     \|         |/   \__/(_______/(_______/(_______/|/     \|\_______)(_______/--

-- Mercenary Selection System --
--      Double H Release      --

--//////////////////////--|
--Standard Configuration  |
--\\\\\\\\\\\\\\\\\\\\\\--|
local MAX_MERC          = 2        --The allowed number of Mercenaries to hire
local MAX_OFFICER       = 1        --The allowed number of Officers to hire
local GOLD_COST         = 1500000  --The amount of gold required to hire mercenaries in copper value.
local GOLD_COST_OFFICER = 4500000
--===========================---
--Creature AI Default Settings--
--===========================---

local WARRIOR_ENTRY = 100000
local MEDIC_ENTRY = 100001
local OFFICER_ENTRY = 100002

-- Warrior Settings (1 = Starting Fight Style, you can only enable one default style to start in. 
-- If you attempt to activate more then one style via cofigs, the standard style will automatically apply itself. (1=balance, 2=defensive, 3=offensive)
local	DEFAULT_WARRIOR_STYLE  = 1

-- Priest Settings (1 = Starting Fight Style, you can only enable one default style to start in. All others will default to 0. 
-- If you attempt to activate more then one style via cofigs, the standard style will automatically apply itself. (1=heals, 2=damage)
local   DEFAULT_MEDIC_STYLE = 1

-- Officer Settings (1 = Starting Fight Style, you can only enable one default style to start in. All others will default to 0. 
-- If you attempt to activate more then one style via cofigs, the standard style will automatically apply itself. (1=offensice, 2=defensive, 3=support)
local DEFAULT_OFFICER_STYLE = 3


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
--                        DO NOT EDIT BELOW                                           --
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
OLDSTRAT = {}
OLDSTRAT.WARRIOR = {}
OLDSTRAT.HEALER = {}
OLDSTRAT.OFFICER = {}
math.randomseed(os.time()); math.random(); math.random(); math.random();

function hasMerc(player, pUnit)
	if (OLDSTRAT[player:GetName()] == nil) then return false; end
	if (OLDSTRAT[player:GetName()].mercs == nil) then return false; end
	for i,v in ipairs(OLDSTRAT[player:GetName()].mercs) do
		if (tostring(v) == tostring(pUnit)) then
			return true
		end
	end
	return false
end

function getNumMercs(player)
	if (OLDSTRAT[player:GetName()] == nil) then return 0; end
	if (OLDSTRAT[player:GetName()].mercs == nil) then return 0; end
	local count = 0
	for i,v in ipairs(OLDSTRAT[player:GetName()].mercs) do
		if (v ~= 0) then
			count = count+1
		end
	end
	return count
end

function hasOfficer(player, pUnit)
	if (OLDSTRAT[player:GetName()] == nil) then return false; end
	if (OLDSTRAT[player:GetName()].officer == nil) then return false; end
	for i,v in ipairs(OLDSTRAT[player:GetName()].officer) do
		if (tostring(v) == tostring(pUnit)) then
			return true
		end
	end
	return false
end

function getNumOfficer(player)
	if (OLDSTRAT[player:GetName()] == nil) then return 0; end
	if (OLDSTRAT[player:GetName()].officer == nil) then return 0; end
	local count = 0
	for i,v in ipairs(OLDSTRAT[player:GetName()].officer) do
		if (v ~= 0) then
			count = count+1
		end
	end
	return count
end

function OLDSTRAT.HookPlayerGone(pUnit, playerName)
	if (OLDSTRAT[playerName] == nil) then return; end --don't even bother with this func if no mercs.
	if (OLDSTRAT[playerName].mercs == nil) then return; end
	pUnit:RemoveEvents()
	for i,v in ipairs(OLDSTRAT[playerName].mercs) do
		if (tostring(v) == tostring(pUnit)) then
			OLDSTRAT[playerName].mercs[i] = 0
		end
	end
	OLDSTRAT[tostring(pUnit)] = nil
	--pUnit:Despawn(1, 60000) causes crashes...
end

function OLDSTRAT.HookPlayerGoneOfficer(pUnit, playerName)
	if (OLDSTRAT[playerName] == nil) then return; end --don't even bother with this func if no officer.
	if (OLDSTRAT[playerName].officer == nil) then return; end
	pUnit:RemoveEvents()
	for i,v in ipairs(OLDSTRAT[playerName].officer) do
		if (tostring(v) == tostring(pUnit)) then
			OLDSTRAT[playerName].officer[i] = 0
		end
	end
	OLDSTRAT[tostring(pUnit)] = nil
end

function OLDSTRAT.LeaveCombat(pUnit, event)
	if (OLDSTRAT[tostring(pUnit)] == nil) then return; end
	local player = OLDSTRAT[tostring(pUnit)].owner
	if (OLDSTRAT[player:GetName()] == nil) then return; end --don't even bother with this func if no mercs.
	if (OLDSTRAT[player:GetName()].mercs == nil) then return; end
	if (OLDSTRAT[player:GetName()].officer == nil) then return; end
	pUnit:SetUInt32Value(0x52, 1) --UNIT_NPC_FLAGS
	pUnit:SetUnitToFollow(player, math.random(1,8), 1)
	pUnit:RemoveEvents()
end

function OLDSTRAT.OfficerLeaveCombat(pUnit, event)
	if (OLDSTRAT[tostring(pUnit)] == nil) then return; end
	local player = OLDSTRAT[tostring(pUnit)].ownerO
	if (OLDSTRAT[player:GetName()] == nil) then return; end --don't even bother with this func if no mercs.
	if (OLDSTRAT[player:GetName()].officer == nil) then return; end
	pUnit:SetUInt32Value(0x52, 1) --UNIT_NPC_FLAGS
	pUnit:SetUnitToFollow(player, math.random(1,8), 1)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(WARRIOR_ENTRY, 2, "OLDSTRAT.LeaveCombat")
RegisterUnitEvent(MEDIC_ENTRY, 2, "OLDSTRAT.LeaveCombat")
RegisterUnitEvent(OFFICER_ENTRY, 2, "OLDSTRAT.OfficerLeaveCombat")

function OLDSTRAT.OnTick(pUnit)
	local p = GetPlayer(OLDSTRAT[tostring(pUnit)].ownerName)
	if (p == false) then
		OLDSTRAT.HookPlayerGone(pUnit, OLDSTRAT[tostring(pUnit)].ownerName)
		OLDSTRAT.HookPlayerGoneOfficer(pUnit, OLDSTRAT[tostring(pUnit)].ownerNameO)
	elseif (p:IsDead() or p:IsInWorld() == false) then
		OLDSTRAT.HookPlayerGone(pUnit, OLDSTRAT[tostring(pUnit)].ownerName)
		OLDSTRAT.HookPlayerGoneOfficer(pUnit, OLDSTRAT[tostring(pUnit)].ownerNameO)
	end
end

function OLDSTRAT.OfficerOnTick(pUnit)
	local po = GetPlayer(OLDSTRAT[tostring(pUnit)].ownerNameO)
	if (po == false) then
		OLDSTRAT.HookPlayerGoneOfficer(pUnit, OLDSTRAT[tostring(pUnit)].ownerNameO)
	elseif (po:IsDead() or po:IsInWorld() == false) then
		OLDSTRAT.HookPlayerGoneOfficer(pUnit, OLDSTRAT[tostring(pUnit)].ownerNameO)
	end
end

function OLDSTRAT.OnDied(pUnit, event)
	pUnit:RemoveEvents()
        local player = OLDSTRAT[tostring(pUnit)].ownerName
	pUnit:Despawn(5000, 60000)
	for i,v in ipairs(OLDSTRAT[player].mercs) do
		if (tostring(v) == tostring(pUnit)) then
			OLDSTRAT[player].mercs[i] = 0
			break
		end
	end
	for i,v in ipairs(OLDSTRAT[player].officer) do
		if (tostring(v) == tostring(pUnit)) then
			OLDSTRAT[player].officer[i] = 0
			break
		end
	end
	if (getNumMercs(player) == 0) then OLDSTRAT[player] = nil end
end
	
RegisterUnitEvent(WARRIOR_ENTRY, 4, "OLDSTRAT.OnDied")
RegisterUnitEvent(MEDIC_ENTRY, 4, "OLDSTRAT.OnDied")
RegisterUnitEvent(OFFICER_ENTRY, 4, "OLDSTRAT.OnDied")

function OLDSTRAT.WARRIOR.Speak1(pUnit, event, player)
	if (OLDSTRAT[player:GetName()] == nil and OLDSTRAT[tostring(pUnit)] == nil) then
		pUnit:GossipCreateMenu(50020, player, 0)
		pUnit:GossipMenuAddItem(0, "I see. I accept your offer.", 1, 0)
		pUnit:GossipMenuAddItem(0, "I do not need you now, Mercenary.", 3, 0)
		pUnit:GossipSendMenu(player)
	elseif (getNumMercs(player) < MAX_MERC) and (hasMerc(player, pUnit) == false) and (OLDSTRAT[tostring(pUnit)] == nil) then
		pUnit:GossipCreateMenu(50020, player, 0)
		pUnit:GossipMenuAddItem(0, "I see. I accept your offer.", 1, 0)
		pUnit:GossipMenuAddItem(0, "I do not need you now, Mercenary.", 3, 0)
		pUnit:GossipSendMenu(player)
	elseif (hasMerc(player, pUnit) == true) then
		pUnit:GossipCreateMenu(50022, player, 0)
		pUnit:GossipMenuAddItem(0, "Focus more on defense right now.", 10, 0)
		pUnit:GossipMenuAddItem(0, "Use a more balance fight style right now.", 11, 0)
		pUnit:GossipMenuAddItem(0, "Go into a more aggressive fight style for now.", 12, 0)
		pUnit:GossipSendMenu(player)
	else
		pUnit:GossipCreateMenu(50021, player, 0)
		pUnit:GossipSendMenu(player)
	end
end

function OLDSTRAT.HEALER.Speak1(pUnit, event, player)
	if (OLDSTRAT[player:GetName()] == nil and OLDSTRAT[tostring(pUnit)] == nil) then
		pUnit:GossipCreateMenu(50020, player, 0)
		pUnit:GossipMenuAddItem(0, "I see. I accept your offer.", 2, 0)
		pUnit:GossipMenuAddItem(0, "I do not need you now, Mercenary.", 3, 0)
		pUnit:GossipSendMenu(player)
	elseif (getNumMercs(player) < MAX_MERC) and (hasMerc(player, pUnit) == false) and (OLDSTRAT[tostring(pUnit)] == nil) then
		pUnit:GossipCreateMenu(50020, player, 0)
		pUnit:GossipMenuAddItem(0, "I see. I accept your offer.", 2, 0)
		pUnit:GossipMenuAddItem(0, "I do not need you now, Mercenary.", 3, 0)
		pUnit:GossipSendMenu(player)
	elseif (hasMerc(player, pUnit) == true) then
		pUnit:GossipCreateMenu(50022, player, 0)
		pUnit:GossipMenuAddItem(0, "Focus more on support right now.", 20, 0)
		pUnit:GossipMenuAddItem(0, "Use a heavy damage based style for now.", 21, 0)
		pUnit:GossipSendMenu(player)
	else
		pUnit:GossipCreateMenu(50021, player, 0)
		pUnit:GossipSendMenu(player)
	end
end

function OLDSTRAT.OFFICER.Speak1(pUnit, event, player)
	if (OLDSTRAT[player:GetName()] == nil and OLDSTRAT[tostring(pUnit)] == nil) then
		pUnit:GossipCreateMenu(50020, player, 0)
		pUnit:GossipMenuAddItem(0, "I see. I accept your offer.", 1, 0)
		pUnit:GossipMenuAddItem(0, "I do not need you now, Mercenary.", 3, 0)
		pUnit:GossipSendMenu(player)
	elseif (getNumOfficer(player) < MAX_OFFICER) and (hasOfficer(player, pUnit) == false) and (OLDSTRAT[tostring(pUnit)] == nil) then
		pUnit:GossipCreateMenu(50020, player, 0)
		pUnit:GossipMenuAddItem(0, "I see. I accept your offer.", 1, 0)
		pUnit:GossipMenuAddItem(0, "I do not need you now, Mercenary.", 3, 0)
		pUnit:GossipSendMenu(player)
	elseif (hasOfficer(player, pUnit) == true) then
		pUnit:GossipCreateMenu(50022, player, 0)
		pUnit:GossipMenuAddItem(0, "I need you in an offensive state.", 30, 0)
		pUnit:GossipMenuAddItem(0, "I am going to need your defensive capabilities.", 31, 0)
		pUnit:GossipMenuAddItem(0, "I need you to play the supportive role.", 32, 0)
		pUnit:GossipSendMenu(player)
	else
		pUnit:GossipCreateMenu(50021, player, 0)
		pUnit:GossipSendMenu(player)
	end
end

function OLDSTRAT.WARRIOR.Selection1(pUnit, event, player, id, intid, code)
	if (intid == 1) then
		if (player:GetCoinage() < GOLD_COST) then
			pUnit:SendChatMessage(12, 0, "I apologize, "..player:GetName().." but you do not have the amount of money I require.")
			player:GossipComplete()
		else
			if (OLDSTRAT[player:GetName()] == nil) then OLDSTRAT[player:GetName()] = {}; end
			if (OLDSTRAT[player:GetName()].mercs == nil) then OLDSTRAT[player:GetName()].mercs = {0,0,0}; end
			for i,v in ipairs(OLDSTRAT[player:GetName()].mercs) do
				if (v == 0) then
					OLDSTRAT[player:GetName()].mercs[i] = pUnit
					break
				end
			end
			OLDSTRAT[tostring(pUnit)] = {}
			OLDSTRAT[tostring(pUnit)].owner = player
			OLDSTRAT[tostring(pUnit)].ownerName = player:GetName()
			pUnit:RegisterEvent("OLDSTRAT.OnTick", 1000, 0)
			pUnit:SetFaction(player:GetFaction())
			pUnit:SendChatMessage(12, 0, "Excellent, I look forward to working with you, "..player:GetName()..".")
			OLDSTRAT[tostring(pUnit)].WARRIOR_STYLE = DEFAULT_WARRIOR_STYLE
			pUnit:SetUnitToFollow(player, math.random(1,8), 1)
			player:DealGoldCost(GOLD_COST)
			player:GossipComplete()
		end
			
	end
	if (intid == 3) then
		player:GossipComplete()
	end
	-- Warrior Segment Playstyle --
	if (intid == 10) then  --Defensive Style
		pUnit:CastSpell(71)
		OLDSTRAT[tostring(pUnit)].WARRIOR_STYLE = 2
		pUnit:SendChatMessage(12, 0, "Well, Tank mode it is then.")
		pUnit:EquipWeapons(45110, 40700, 1)
		player:GossipComplete()
	end		
	if (intid == 11) then  --Balance Style
		pUnit:CastSpell(2457)
		OLDSTRAT[tostring(pUnit)].WARRIOR_STYLE = 1
		pUnit:SendChatMessage(12, 0, "Very well I shall fight in a mixed style.")
		pUnit:EquipWeapons(45165, 1, 1)
		player:GossipComplete()
	end

	if (intid == 12) then  --Agressive Style
		pUnit:CastSpell(2458)
		OLDSTRAT[tostring(pUnit)].WARRIOR_STYLE = 3
		pUnit:SendChatMessage(12, 0, "Hmm, this should be entertaining, I will be taking more damage, just so you know.")
		pUnit:EquipWeapons(46016, 46016, 1)
		player:GossipComplete()
	end
end
	
function OLDSTRAT.HEALER.Selection1(pUnit, event, player, id, intid, code)
	if (intid == 2) then
		if (player:GetCoinage() < GOLD_COST) then
			pUnit:SendChatMessage(12, 0, "I apologize, "..player:GetName().." but you do not have the amount of money I require.")
			player:GossipComplete()
		else
			if (OLDSTRAT[player:GetName()] == nil) then OLDSTRAT[player:GetName()] = {}; end
			if (OLDSTRAT[player:GetName()].mercs == nil) then OLDSTRAT[player:GetName()].mercs = {0,0,0}; end
			for i,v in ipairs(OLDSTRAT[player:GetName()].mercs) do
				if (v == 0) then
					OLDSTRAT[player:GetName()].mercs[i] = pUnit
					break
				end
			end
			OLDSTRAT[tostring(pUnit)] = {}
			OLDSTRAT[tostring(pUnit)].owner = player
			OLDSTRAT[tostring(pUnit)].ownerName = player:GetName()
			pUnit:RegisterEvent("OLDSTRAT.OnTick", 1000, 0)
			pUnit:SetFaction(player:GetFaction())
			pUnit:SendChatMessage(12, 0, "Excellent, I look forward to working with you, "..player:GetName()..".")
			OLDSTRAT[tostring(pUnit)].MEDIC_STYLE = DEFAULT_MEDIC_STYLE
			pUnit:SetUnitToFollow(player, math.random(2,4), math.random(1, 6))
			player:DealGoldCost(GOLD_COST)
			player:GossipComplete()
		end
	end
	if (intid == 3) then
		player:GossipComplete()
	end
	-- Priest Segment Playstyle --
	if (intid == 20) then  --Support Style
		OLDSTRAT[tostring(pUnit)].MEDIC_STYLE = 1
		pUnit:RemoveAura(35194)
		pUnit:SendChatMessage(12, 0, "Oh well back to the heals.")
		player:GossipComplete()
	end		
	if (intid == 21) then  --Damage Style
		OLDSTRAT[tostring(pUnit)].MEDIC_STYLE = 2
		pUnit:CastSpell(35194)
		pUnit:SendChatMessage(12, 0, "Time for some fun.")
		player:GossipComplete()
	end
end

function OLDSTRAT.OFFICER.Selection1(pUnit, event, player, id, intid, code)
	if intid == 1 then
		if (player:GetCoinage() < GOLD_COST_OFFICER) then
			pUnit:SendChatMessage(12, 0, "I apologize, "..player:GetName().." but you do not have the amount of money I require.")
			player:GossipComplete()
		else
			if (OLDSTRAT[player:GetName()] == nil) then OLDSTRAT[player:GetName()] = {}; end
			if (OLDSTRAT[player:GetName()].officer == nil) then OLDSTRAT[player:GetName()].officer = {0,0,0}; end
			for i,v in ipairs(OLDSTRAT[player:GetName()].officer) do
				if (v == 0) then
					OLDSTRAT[player:GetName()].officer[i] = pUnit
					break
				end
			end
			OLDSTRAT[tostring(pUnit)] = {}
			OLDSTRAT[tostring(pUnit)].ownerO = player
			OLDSTRAT[tostring(pUnit)].ownerNameO = player:GetName()
			pUnit:RegisterEvent("OLDSTRAT.OfficerOnTick", 1000, 0)
			pUnit:SetFaction(player:GetFaction())
			pUnit:SendChatMessage(12, 0, "My service and leadership, are yours, "..player:GetName()..".")
			OLDSTRAT[tostring(pUnit)].OFFICER_STYLE = DEFAULT_OFFICER_STYLE
			pUnit:SetUnitToFollow(player, math.random(1,8), 1)
			player:DealGoldCost(GOLD_COST_OFFICER)
			player:GossipComplete()
		end
			
	end
	if (intid == 3) then
		player:GossipComplete()
	end
	-- Officer Segment Playstyle --
	if (intid == 30) then  --Offensive Style
		pUnit:RemoveAura(13589)
		pUnit:RemoveAura(2457)
		pUnit:RemoveAura(48942)
		pUnit:CastSpell(2458)
		pUnit:CastSpell(54043)
		OLDSTRAT[tostring(pUnit)].OFFICER_STYLE = 1
		pUnit:SendChatMessage(12, 0, "Well looks like there will be some blood spilled.")
		pUnit:EquipWeapons(51481, 1, 1)
		player:GossipComplete()
	end		
	if (intid == 31) then  --Defensive Style
		pUnit:RemoveAura(13589)
		pUnit:RemoveAura(2458)
		pUnit:RemoveAura(54043)
		pUnit:CastSpell(2457)
		pUnit:CastSpell(48942)
		OLDSTRAT[tostring(pUnit)].OFFICER_STYLE = 2
		pUnit:SendChatMessage(12, 0, "Sometimes the best offense is an excellent defense.")
		pUnit:EquipWeapons(47314, 45587, 1)
		player:GossipComplete()
	end

	if (intid == 32) then  --Support Style
		pUnit:RemoveAura(2457)
		pUnit:RemoveAura(48942)
		pUnit:RemoveAura(2458)
		pUnit:RemoveAura(54043)
		pUnit:CastSpell(13589)
		OLDSTRAT[tostring(pUnit)].OFFICER_STYLE = 3
		pUnit:SendChatMessage(12, 0, "Very well, I will provide additional support for you.")
		pUnit:EquipWeapons(45442, 45877, 1)
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(WARRIOR_ENTRY, 1, "OLDSTRAT.WARRIOR.Speak1")
RegisterUnitGossipEvent(WARRIOR_ENTRY, 2, "OLDSTRAT.WARRIOR.Selection1")

RegisterUnitGossipEvent(MEDIC_ENTRY, 1, "OLDSTRAT.HEALER.Speak1")
RegisterUnitGossipEvent(MEDIC_ENTRY, 2, "OLDSTRAT.HEALER.Selection1")

RegisterUnitGossipEvent(OFFICER_ENTRY, 1, "OLDSTRAT.OFFICER.Speak1")
RegisterUnitGossipEvent(OFFICER_ENTRY, 2, "OLDSTRAT.OFFICER.Selection1")

--===============================================================================================--
--                           COMBAT HANDLER FOR STANDARD WARRIORS                                --
--===============================================================================================--
--Balance Style						
local THUNDER_CLAP    	 = 58975
local STANDARD_CLEAVE  	 = 30619
local DEMORAL_SHOUT      = 29584
local MORTAL_STRIKE	  	 = 19643
local RETALIATION 	  	 = 22857

--Defensive Style
local SUNDER_ARMOR    	 = 27991
local SHIELD_BASH     	 = 41180
local SHIELD_WALL	  	 = 29390
local DISARM		  	 = 30013
local TAUNT	          	 = 37486

--Aggressive Style
local BLADESTORM	  	 = 63784
local RECKLESSNESS		 = 13847
local SLICE_STRIKES      = 30470
local SLAM               = 52026
local REND               = 29574

local Warrior_Balance    = {THUNDER_CLAP, STANDARD_CLEAVE, DEMORAL_SHOUT, MORTAL_STRIKE, RETALIATION}
local Warrior_Defensive  = {SUNDER_ARMOR, SHIELD_BASH, SHIELD_WALL, DISARM, TAUNT}						
local Warrior_Aggressive = {BLADESTORM, RECKLESSNESS, SLICE_STRIKES, SLAM, REND}

local Warrior_Taunts  = {"This ends now!", "You stand no match against my blade!", "I fear no death!", "For the city of Stratholme!", "Your insolence amuses me.", 
			            "I grow tired of these games!", "Is this truly my entertainment?", "Your blood shall quench my blade!", "Death fears me!", "Fun time!"}
						
function OLDSTRAT.WARRIOR.OnAggro1(pUnit, event)
	pUnit:SetUInt32Value(0x52, 0) --UNIT_NPC_FLAGS
	local speechCheck = math.random(1, 100)
	if (speechCheck <= 32) then
		local yellSay = math.random(1, 2)
		if yellSay == 1 then
			yellSay = 12
		else
			yellSay = 14
		end
		local i = math.random(1, 10)
		pUnit:SendChatMessage(yellSay, 0, Warrior_Taunts[i])
	end
	pUnit:RegisterEvent("OLDSTRAT.WARRIOR.Select1", 7000, 0)
end

function OLDSTRAT.WARRIOR.Select1(pUnit, event)
	if (OLDSTRAT[tostring(pUnit)].WARRIOR_STYLE == 1) then
		OLDSTRAT.WARRIOR.Balance1(pUnit, event)
	elseif (OLDSTRAT[tostring(pUnit)].WARRIOR_STYLE == 2) then
		OLDSTRAT.WARRIOR.Defensive1(pUnit, event)
	elseif (OLDSTRAT[tostring(pUnit)].WARRIOR_STYLE == 3) then
		OLDSTRAT.WARRIOR.Aggressive1(pUnit, event)
	end
end

function OLDSTRAT.WARRIOR.Balance1(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target == nil) then return; end
	local b = math.random(1, 5)
	if (b ~= 3) and (b ~= 5) then
		pUnit:FullCastSpellOnTarget(Warrior_Balance[b], target)
	else
		pUnit:CastSpell(Warrior_Balance[b])
	end
end

function OLDSTRAT.WARRIOR.Defensive1(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target == nil) then return; end
	local d = math.random(1, 5)
	if (d ~= 3) then
		pUnit:FullCastSpellOnTarget(Warrior_Defensive[d], target)
	else
		pUnit:CastSpell(Warrior_Defensive[d])
	end
end

function OLDSTRAT.WARRIOR.Aggressive1(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target == nil) then return; end
	local a = math.random(1, 5)
	if (a ~= 2) and (a ~= 3) then
		pUnit:FullCastSpellOnTarget(Warrior_Aggressive[a], target)
	else
		pUnit:CastSpell(Warrior_Aggressive[a])
	end
end

RegisterUnitEvent(WARRIOR_ENTRY, 1, "OLDSTRAT.WARRIOR.OnAggro1")
--===============================================================================================--
--                           COMBAT HANDLER FOR STANDARD HEALERS                                 --
--===============================================================================================--
local Medic_Taunts  = {"Oh well, another battle to fight.", "Always wtith the fighting and then me with the healing.", "This should be a fun sight.", "For the city of Stratholme!", 
			            "I get no respect whatsoever.", "Is this truly my entertainment?"}
						
--Healing Style						
local SHIELD  	         = 47753
local HOLY_LIGHT         = 32769
local CHAIN_HEAL	  	 = 42477
--TODO: rez

--Shadow Style
local MIND_BLAST   	     = 60500
local MIND_FLAY     	 = 28310
local WORD_DEATH	  	 = 41375

local Medic_Healing = {SHIELD, HOLY_LIGHT, CHAIN_HEAL}
local Medic_Shadow  = {MIND_BLAST, MIND_FLAY, WORD_DEATH}

function OLDSTRAT.HEALER.OnAggro1(pUnit, event)
	pUnit:SetUInt32Value(0x52, 0) --UNIT_NPC_FLAGS
	local speechCheck = math.random(1, 100)
	if (speechCheck <= 32) then
		local yellSay = math.random(1, 2)
		if yellSay == 1 then
			yellSay = 12
		else
			yellSay = 14
		end
		local i = math.random(1, 6)
		pUnit:SendChatMessage(yellSay, 0, Medic_Taunts[i])
	end
	pUnit:RegisterEvent("OLDSTRAT.HEALER.Select1", 8000, 0)
end

function OLDSTRAT.HEALER.Select1(pUnit)
	if (OLDSTRAT[tostring(pUnit)].MEDIC_STYLE == 1) then
		OLDSTRAT.HEALER.Healing1(pUnit)
	elseif (OLDSTRAT[tostring(pUnit)].MEDIC_STYLE == 2) then
		OLDSTRAT.HEALER.Shadow1(pUnit)
	end
end

function OLDSTRAT.HEALER.Healing1(pUnit)
	local target = pUnit:GetRandomFriend()
	for i=1,10 do
		if (target ~= nil) then break; end
		target = pUnit:GetRandomFriend()
	end
	if (OLDSTRAT[tostring(pUnit)].owner:GetHealthPct() < 30) then target = OLDSTRAT[tostring(pUnit)].owner; end
	if (target == nil) then target = pUnit; end
	local h = math.random(1, 3)
	pUnit:FullCastSpellOnTarget(Medic_Healing[h], target)
end

function OLDSTRAT.HEALER.Shadow1(pUnit)
	local target = pUnit:GetMainTank()
	if (target == nil) then return; end
	local s = math.random(1, 3)		
	pUnit:FullCastSpellOnTarget(Medic_Shadow[s], target)
end

RegisterUnitEvent(MEDIC_ENTRY, 1, "OLDSTRAT.HEALER.OnAggro1")

-- TODO: Officers
--===============================================================================================--
--                           COMBAT HANDLER FOR STANDARD OFFICER                                 --
--===============================================================================================--
local Officer_Taunts  = {"Lets get this over with!", "This amuses me!", "I fear death is your only option!", "My blade will meet your throat!", "Your insolence amuses me.", 
			            "Enough of these distractions!", "Is this truly my entertainment?", "My blade yerns to cut!", "Let's go over your situation!", "Play time!"}
						
--Offensive Style--
local OFFICER_SABER_LASH         = 71021
local OFFICER_DEAFENING_ROAR     = 38850
local OFFICER_PIERCE_ARMOR       = 38187
local OFFICER_DARK_STRIKE        = 45271
--Defensive Style--
local OFFICER_SHIELD_SLAM        = 29684
local OFFICER_MORTAL_STRIKE      = 44268
local OFFICER_DEVASTATE          = 57795
local OFFICER_SUNDER_ARMOR       = 65936
--Support Style--
local OFFICER_HOLY_LIGHT         = 29562
local OFFICER_POWER_SHIELD       = 66099
local OFFICER_CHAIN_HEAL	  	 = 42477
local OFFICER_SMITE              = 71842

local Officer_AggressiveStore = {OFFICER_SABER_LASH, OFFICER_DEAFENING_ROAR, OFFICER_PIERCE_ARMOR, OFFICER_DARK_STRIKE}
local Officer_DefensiveStore  = {OFFICER_SHIELD_SLAM, OFFICER_MORTAL_STRIKE, OFFICER_DEVASTATE, OFFICER_SUNDER_ARMOR}
local Officer_SupportStore    = {OFFICER_HOLY_LIGHT, OFFICER_POWER_SHIELD, OFFICER_CHAIN_HEAL, OFFICER_SMITE}

function OLDSTRAT.OFFICER.OnAggro1(pUnit, event)
	pUnit:SetUInt32Value(0x52, 0)
	local speechCheck = math.random(1, 100)
	if (speechCheck <= 32) then
		local yellSay = math.random(1, 2)
		if yellSay == 1 then
			yellSay = 12
		else
			yellSay = 14
		end
		local i = math.random(1, 10)
		pUnit:SendChatMessage(yellSay, 0, Warrior_Taunts[i])
	end
	pUnit:RegisterEvent("OLDSTRAT.OFFICER.Select1", 7000, 0)
end


function OLDSTRAT.OFFICER.Select1(pUnit, event)
	if (OLDSTRAT[tostring(pUnit)].OFFICER_STYLE == 1) then
		OLDSTRAT.OFFICER.Offense1(pUnit, event) -- run offense
	elseif (OLDSTRAT[tostring(pUnit)].OFFICER_STYLE == 2) then
		OLDSTRAT.OFFICER.Defensive1(pUnit, event) -- run defense
	elseif (OLDSTRAT[tostring(pUnit)].OFFICER_STYLE == 3) then
		OLDSTRAT.OFFICER.Support1(pUnit, event) -- run support
	end
end

function OLDSTRAT.OFFICER.Offense1(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target == nil) then return; end
	local o = math.random(1, 4)
	if (o ~= 1) and (o ~= 3) and (o ~= 4) then
		pUnit:FullCastSpellOnTarget(Officer_AggressiveStore[o], target)
	else
		pUnit:CastSpell(Officer_AggressiveStore[o])
	end
end

function OLDSTRAT.OFFICER.Defensive1(pUnit, event)
	local target = pUnit:GetMainTank()
	if (target == nil) then return; end
	local d = math.random(1, 4)
	pUnit:FullCastSpellOnTarget(Officer_DefensiveStore[d], target)
end

function OLDSTRAT.OFFICER.Support1(pUnit, event)
	local target = pUnit:GetRandomFriend()
	for i=1,10 do
		if (target ~= nil) then break; end
		target = pUnit:GetRandomFriend()
	end
	if (OLDSTRAT[tostring(pUnit)].ownerO:GetHealthPct() < 40) then target = OLDSTRAT[tostring(pUnit)].ownerO; end
	if (target == nil) then target = pUnit; end
	local s = math.random(1, 4)
	pUnit:FullCastSpellOnTarget(Officer_SupportStore[s], target)
end

RegisterUnitEvent(OFFICER_ENTRY, 1, "OLDSTRAT.OFFICER.OnAggro1")