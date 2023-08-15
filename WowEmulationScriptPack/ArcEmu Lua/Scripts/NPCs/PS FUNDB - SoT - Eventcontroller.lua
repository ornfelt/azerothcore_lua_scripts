------------------------------------------------------>Defines<----------------------------------------------------------
function SoTreset(Unit, Event)
aplr1 = nil
aplr2 = nil
aplr3 = nil
aplr4 = nil
aplr5 = nil
aplr6 = nil
aplr7 = nil
aplr8 = nil
aplr9 = nil
aplr10 = nil
aplr1_name = nil
aplr2_name = nil
aplr3_name = nil
aplr4_name = nil
aplr5_name = nil
aplr6_name = nil
aplr7_name = nil
aplr8_name = nil
aplr9_name = nil
aplr10_name = nil

hplr1 = nil
hplr2 = nil
hplr3 = nil
hplr4 = nil
hplr5 = nil
hplr6 = nil
hplr7 = nil
hplr8 = nil
hplr9 = nil
hplr10 = nil
hplr1_name = nil
hplr2_name = nil
hplr3_name = nil
hplr4_name = nil
hplr5_name = nil
hplr6_name = nil
hplr7_name = nil
hplr8_name = nil
hplr9_name = nil
hplr10_name = nil

msgpplh = "You can join the Event: Statue of Teamwork now!"
msgppla = "You can join the Event: Statue of Teamwork now!"

aready = 0
hready = 0
eready = 0
choose_area_var = nil
area = 0

ahero = 0
hhero = 0

SoT_H_Aquatic = 0
hphase1 = 0
hphase2 = 0
hphase3 = 0
SoT_A_Aquatic = 0
aphase1 = 0
aphase2 = 0
aphase3 = 0

SoT_choose_area = 0
SoT_check_timer = 0
SoT_time = 0
SoT_check_timer2 = 0
SoT_time2 = 0
sot_time30 = nil
sot_time31 = nil
sot_time32 = nil
sot_time302 = nil
sot_time312 = nil
end
SoT_initiated_times = 0
-- Initialize the pseudo random number generator
math.randomseed( os.time() )
function SoT_random(Unit, Event)
math.random(os.time())
math.random(4)
math.random(5)
math.random(2)
end
------------------------------------------------------>Defines<----------------------------------------------------------

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////Enter Event/////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
------------------------------------------------------------------------------------------Horde enter event----------------------------------------------------------------------------------------------
function EnterEventHorde(Unit, Event)
local hplr = pMisc
local plrrace = hplr:GetPlayerRace()
if (eready == 0) then
if (plrrace == 2) or (plrrace == 5) or (plrrace == 6) or (plrrace == 8) or (plrrace == 10) then
if (hplr ~= hplr1) and (hplr ~= hplr2) and (hplr ~= hplr3) and (hplr ~= hplr4) and (hplr ~= hplr5) and (hplr ~= hplr6) and (hplr ~= hplr7) and (hplr ~= hplr8) and (hplr ~= hplr9) and (hplr ~= hplr10) then
if (hplr ~= nil) then
	if (hplr1 == nil) then
	hplr1 = hplr
	hplr1_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 1 at the horde side!", hplr:GetName())
	elseif (hplr2 == nil) then
	hplr2 = hplr
	hplr2_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 2 at the horde side!", hplr:GetName())
	elseif (hplr3 == nil) then
	hplr3 = hplr
	hplr3_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 3 at the horde side!", hplr:GetName())
	elseif (hplr4 == nil) then
	hplr4 = hplr
	hplr4_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 4 at the horde side!", hplr:GetName())
	elseif (hplr5 == nil) then 
	hplr5 = hplr
	hplr5_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 5 at the horde side!", hplr:GetName())
	elseif (hplr6 == nil) then
	hplr6 = hplr
	hplr6_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 6 at the horde side!", hplr:GetName())
	elseif (hplr7 == nil) then
	hplr7 = hplr
	hplr7_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 7 at the horde side!", hplr:GetName())
	elseif (hplr8 == nil) then
	hplr8 = hplr
	hplr8_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 8 at the horde side!", hplr:GetName())
	elseif (hplr9 == nil) then
	hplr9 = hplr
	hplr9_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 9 at the horde side!", hplr:GetName())
	elseif (hplr10 == nil) then
	hplr10 = hplr
	hplr10_name = hplr:GetName()
	msgpplh = string.format("%s has joined the Event: Statue of Teamwork at place 10 at the horde side!", hplr:GetName())
	else
	msgpplh = string.format("%s, you can't join the Event at the moment, it's full already!", hplr:GetName())
	end
end
else
msgpplh = string.format("%s, you have already joined the Event!", hplr:GetName())
end
else
msgpplh = string.format("%s, you are Ally! Join at the Ally side!", hplr:GetName())
end
end
end
------------------------------------------------------------------------------------------Ally enter event----------------------------------------------------------------------------------------------
function EnterEventAlly(Unit, Event)
local aplr = pMisc
local plrrace = aplr:GetPlayerRace()
if (eready == 0) then
if (plrrace == 1) or (plrrace == 3) or (plrrace == 4) or (plrrace == 7) or (plrrace == 11) then
if (aplr ~= aplr1) and (aplr ~= aplr2) and (aplr ~= aplr3) and (aplr ~= aplr4) and (aplr ~= aplr5) and (aplr ~= aplr6) and (aplr ~= aplr7) and (aplr ~= aplr8) and (aplr ~= aplr9) and (aplr ~= aplr10) then
if (aplr ~= nil) then
	if (aplr1 == nil) then
	aplr1 = aplr
	aplr1_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 1 at the alliance side!", aplr:GetName())
	elseif (aplr2 == nil) then
	aplr2 = aplr
	aplr2_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 2 at the alliance side!", aplr:GetName())
	elseif (aplr3 == nil) then
	aplr3 = aplr
	aplr3_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 3 at the alliance side!", aplr:GetName())
	elseif (aplr4 == nil) then
	aplr4 = aplr
	aplr4_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 4 at the alliance side!", aplr:GetName())
	elseif (aplr5 == nil) then 
	aplr5 = aplr
	aplr5_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 5 at the alliance side!", aplr:GetName())
	elseif (aplr6 == nil) then
	aplr6 = aplr
	aplr6_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 6 at the alliance side!", aplr:GetName())
	elseif (aplr7 == nil) then
	aplr7 = aplr
	aplr7_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 7 at the alliance side!", aplr:GetName())
	elseif (aplr8 == nil) then
	aplr8 = aplr
	aplr8_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 8 at the alliance side!", aplr:GetName())
	elseif (aplr9 == nil) then
	aplr9 = aplr
	aplr9_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 9 at the alliance side!", aplr:GetName())
	elseif (aplr10 == nil) then
	aplr10 = aplr
	aplr10_name = aplr:GetName()
	msgppla = string.format("%s has joined the Event: Statue of Teamwork at place 10 at the alliance side!", aplr:GetName())
	else
	msgppla = string.format("%s, you can't join the Event at the moment, it's full already!", aplr:GetName())
	end
end
else
msgppla = string.format("%s, you have already joined the Event!", aplr:GetName())
end
else
msgppla = string.format("%s, you are Horde! Join at the Horde side!", aplr:GetName())
end
end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////Event Gossip////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
---------------------------------------------------------------------------------------------Horde gossip-------------------------------------------------------------------------------------------------
function HordeEventOnGossip(Unit, Event, player)
	EventMenuHorde(Unit, player)
end

function EventMenuHorde(Unit, player)
local plrrace = player:GetPlayerRace()
if (plrrace == 2) or (plrrace == 5) or (plrrace == 6) or (plrrace == 8) or (plrrace == 10) then
	Unit:GossipCreateMenu(100, player, 0)
    Unit:GossipMenuAddItem(0, "At least 5 players of the horde have to join the event for it to be started, at most 10 players of the horde may enter the event.", 3, 0)
    Unit:GossipMenuAddItem(0, "Explain the event, please.", 4, 0)
    Unit:GossipMenuAddItem(4, "Join the Event: statue of teamwork!", 1, 0)
	Unit:GossipMenuAddItem(4, "We're ready, let's go!", 2, 0)
	Unit:GossipSendMenu(player)
else
	Unit:GossipCreateMenu(100, player, 0)
	Unit:GossipMenuAddItem(4, "Only horde can join here!", 3, 0)
	Unit:GossipMenuAddItem(4, "Bye", 3, 0)
	Unit:GossipSendMenu(player)
end
end

function HordeEventSubMenu(Unit, Event, player, id, intid, code)
	if(intid == 1) then
	pMisc = player
		if (eready == 0) then
		Unit:RegisterEvent("EnterEventHorde",10,1)
		player:GossipComplete()
		end
		
		if (eready == 1) then
		msgpplh = string.format("%s, the event is already about to start", player:GetName())
		player:GossipComplete()
		end

		if (eready == 2) then
		msgpplh = string.format("%s, the event is already starting", player:GetName())
		player:GossipComplete()
		end
		
		if (eready == 3) then
		msgpplh = string.format("%s, the event has already been started", player:GetName())
		player:GossipComplete()
		end
	end
	
	if(intid == 2) then
		if (eready == 0) then
		Unit:RegisterEvent("Explain",10,1)
		player:GossipComplete()
		end
	
		if (eready == 1) then
		msgpplh = string.format("%s, the event is already about to start", player:GetName())
		player:GossipComplete()
		end
		
	
		if (eready == 2) then
		msgpplh = string.format("%s, the event is already starting", player:GetName())
		player:GossipComplete()
		end
		
		if (eready == 3) then
		msgpplh = string.format("%s, the event has already been started", player:GetName())
		player:GossipComplete()
		end
	end

	if(intid == 3) then
	player:GossipComplete()
	end

	if(intid == 4) then
	Unit:GossipCreateMenu(101, player, 0)
    Unit:GossipMenuAddItem(0, "In the Statue of Teamwork the goal is to kill the three heroes of the opposite faction. The problem is that they are hidden and you have to find them first.", 5, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 5, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 5) then
	Unit:GossipCreateMenu(102, player, 0)
    Unit:GossipMenuAddItem(0, "Once you find one of the heroes of the opposite faction, you have to call the rest of the members of your faction who joined the event to you. When you have enough players you can kill the hero.", 6, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 6, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 6) then
	Unit:GossipCreateMenu(103, player, 0)
    Unit:GossipMenuAddItem(0, "When you've killed all of the heroes of the opposite faction, all members of your faction who joined have to return to your faction's base.", 7, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 7, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 7) then
	Unit:GossipCreateMenu(104, player, 0)
    Unit:GossipMenuAddItem(0, "The first team who kills all of its opposite faction's heroes and returns to its base wins the event.", 8, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 8, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 8) then
	Unit:GossipCreateMenu(105, player, 0)
    Unit:GossipMenuAddItem(0, "Good luck!", 9, 0)
    Unit:GossipMenuAddItem(0, "[Back to main menu]", 9, 0)
	Unit:GossipSendMenu(player)
	end
	
	if(intid == 9) then
	EventMenuHorde(Unit, player)
	end
end
---------------------------------------------------------------------------------------------Ally gossip-------------------------------------------------------------------------------------------------
function AllyEventOnGossip(Unit, Event, player)
	EventMenuAlly(Unit, player)
end

function EventMenuAlly(Unit, player)
local plrrace = player:GetPlayerRace()
if (plrrace == 1) or (plrrace == 3) or (plrrace == 4) or (plrrace == 7) or (plrrace == 11) then
	Unit:GossipCreateMenu(100, player, 0)
    Unit:GossipMenuAddItem(0, "At least 5 players of the alliance have to join the event for it to be started, at most 10 players of the alliance may enter the event.", 3, 0)
    Unit:GossipMenuAddItem(0, "Explain the event, please.", 4, 0)
    Unit:GossipMenuAddItem(4, "Join the Event: statue of teamwork!", 1, 0)
	Unit:GossipMenuAddItem(4, "We're ready, let's go!", 2, 0)
	Unit:GossipSendMenu(player)
else
	Unit:GossipCreateMenu(100, player, 0)
	Unit:GossipMenuAddItem(4, "Only alliance can join here!", 3, 0)
	Unit:GossipMenuAddItem(4, "Bye", 3, 0)
	Unit:GossipSendMenu(player)
end
end

function AllyEventSubMenu(Unit, Event, player, id, intid, code)
	if(intid == 1) then
	pMisc = player
		if (eready == 0) then
		Unit:RegisterEvent("EnterEventAlly",10,1)
		player:GossipComplete()
		end
		
		if (eready == 1) then
		msgppla = string.format("%s, the event is already about to start", player:GetName())
		player:GossipComplete()
		end
		
		if (eready == 2) then
		msgppla = string.format("%s, the event is already starting", player:GetName())
		player:GossipComplete()
		end
		
		if (eready == 3) then
		msgppla = string.format("%s, the event has already been started", player:GetName())
		player:GossipComplete()
		end
	end
	
	if(intid == 2) then
		if (eready == 0) then
		Unit:RegisterEvent("Explain2",10,1)
		player:GossipComplete()
		end
	
		if (eready == 1) then
		msgppla = string.format("%s, the event is already about to start", player:GetName())
		player:GossipComplete()
		end
		
	
		if (eready == 2) then
		msgppla = string.format("%s, the event is already starting", player:GetName())
		player:GossipComplete()
		end
		
		if (eready == 3) then
		msgppla = string.format("%s, the event has already been started", player:GetName())
		player:GossipComplete()
		end
	end

	if(intid == 3) then
	player:GossipComplete()
	end

	if(intid == 4) then
	Unit:GossipCreateMenu(101, player, 0)
    Unit:GossipMenuAddItem(0, "In the Statue of Teamwork the goal is to kill the three heroes of the opposite faction. The problem is that they are hidden and you have to find them first.", 5, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 5, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 5) then
	Unit:GossipCreateMenu(102, player, 0)
    Unit:GossipMenuAddItem(0, "Once you find one of the heroes of the opposite faction, you have to call the rest of the members of your faction who joined the event to you. When you have enough players you can kill the hero.", 6, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 6, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 6) then
	Unit:GossipCreateMenu(103, player, 0)
    Unit:GossipMenuAddItem(0, "When you've killed all of the heroes of the opposite faction, all members of your faction who joined have to return to your faction's base.", 7, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 7, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 7) then
	Unit:GossipCreateMenu(104, player, 0)
    Unit:GossipMenuAddItem(0, "The first team who kills all of its opposite faction's heroes and returns to its base wins the event.", 8, 0)
    Unit:GossipMenuAddItem(0, "[Next]", 8, 0)
	Unit:GossipSendMenu(player)
	end

	if(intid == 8) then
	Unit:GossipCreateMenu(105, player, 0)
    Unit:GossipMenuAddItem(0, "Good luck!", 9, 0)
    Unit:GossipMenuAddItem(0, "[Back to main menu]", 9, 0)
	Unit:GossipSendMenu(player)
	end
	
	if(intid == 9) then
	EventMenuAlly(Unit, player)
	end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////Ready Check////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function Explain(Unit, Event)
Unit:RegisterEvent("ready_check2",10,1)
end

function Explain2(Unit, Event)
Unit:RegisterEvent("ready_check3",10,1)
end

function ready_check2(Unit, Event) 
if (eready == 0) then
if ((hplr1 ~= nil) and (hplr2 ~= nil) and (hplr3 ~= nil) and (hplr4 ~= nil) and (hplr5 ~= nil)) then 
if (hplr1:GetName() ~= hplr1_name) then
hplr1 = nil
hplr1_name = nil
msgpplh = "At least 5 Horde players need to join to start the event!"
else
	if (hplr2:GetName() ~= hplr2_name) then
	hplr2 = nil
	hplr2_name = nil
	msgpplh = "At least 5 Horde players need to join to start the event!"
	else
		if (hplr3:GetName() ~= hplr3_name) then
		hplr3 = nil
		hplr3_name = nil
		msgpplh = "At least 5 Horde players need to join to start the event!"
		else
			if (hplr4:GetName() ~= hplr4_name) then
			hplr4 = nil
			hplr4_name = nil
			msgpplh = "At least 5 Horde players need to join to start the event!"
			else
				if (hplr5:GetName() ~= hplr5_name) then
				hplr5 = nil
				hplr5_name = nil
				msgpplh = "At least 5 Horde players need to join to start the event!"
				else
					hready = 1
					msgpplh = "Horde is ready"
				end
			end
		end
	end
end
else
msgpplh = "At least 5 Horde players need to join to start the event!"
end
end
-----
if ((hready == 1) and (aready == 1) and (choose_area_var == nil)) then
	Unit:RegisterEvent("choose_area", 30000, 1)
	choose_area_var = 1
	msgpplh = "Everybody is ready, Event will be started in 30 seconds!"
	msgppla = "Everybody is ready, Event will be started in 30 seconds!"
end
end

function ready_check3(Unit, Event) 
if (eready == 0) then
if ((aplr1 ~= nil) and (aplr2 ~= nil) and (aplr3 ~= nil) and (aplr4 ~= nil) and (aplr5 ~= nil)) then 
if (aplr1:GetName() ~= aplr1_name) then
aplr1 = nil
aplr1_name = nil
msgppla = "At least 5 Ally players need to join to start the event!"
else
	if (aplr2:GetName() ~= aplr2_name) then
	aplr2 = nil
	aplr2_name = nil
	msgppla = "At least 5 Ally players need to join to start the event!"
	else
		if (aplr3:GetName() ~= aplr3_name) then
		aplr3 = nil
		aplr3_name = nil
		msgppla = "At least 5 Ally players need to join to start the event!"
		else
			if (aplr4:GetName() ~= aplr4_name) then
			aplr4 = nil
			aplr4_name = nil
			msgppla = "At least 5 Ally players need to join to start the event!"
			else
				if (aplr5:GetName() ~= aplr5_name) then
				aplr5 = nil
				aplr5_name = nil
				msgppla = "At least 5 Ally players need to join to start the event!"
				else
					aready = 1
					msgppla = "Ally is ready"
				end
			end
		end
	end
end
else
msgppla = "At least 5 Ally players need to join to start the event!"
end
end
-----
if ((hready == 1) and (aready == 1) and (choose_area_var == nil)) then
	Unit:RegisterEvent("choose_area", 30000, 1)
	choose_area_var = 1
	msgpplh = "Everybody is ready, Event will be started in 30 seconds!"
	msgppla = "Everybody is ready, Event will be started in 30 seconds!"
end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////Choose Area////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function choose_area(Unit, Event)
area = math.random(2) 
SoT_choose_area = 0
if (area==1) then
	msgppla = "Battleground: Redridge Mountains has been chosen"
	msgpplh = "Battleground: Redridge Mountains has been chosen"
elseif (area==2) then
	msgppla = "Battleground: Arathi Basin has been chosen"
	msgpplh = "Battleground: Arathi Basin has been chosen"
elseif (area==3) then
	msgppla = "Area 3 has been chosen"
	msgpplh = "Area 3 has been chosen"
elseif (area==4) then
	msgppla = "Area 4 has been chosen"
	msgpplh = "Area 4 has been chosen"
end
eready = 1
end

----------------------------------------------------------------------------------------------------Area 1-------------------------------------------------------------------------------------------------
function sotarea1(Unit, Event)
if (SoT_choose_area == 0 and area == 1) then
	SoT_choose_area = 1
	Unit:RegisterEvent("spawn1", 10, 1)
	Unit:RegisterEvent("Check1", 100, 0)
end
end

function reg_sotarea1(Unit, Event)
Unit:RegisterEvent("SoT_random",100,0)
Unit:RegisterEvent("sotarea1", 500, 0)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------Area 2-------------------------------------------------------------------------------------------------
function sotarea2(Unit, Event)
if (SoT_choose_area == 0 and area == 2) then
	SoT_choose_area = 1
	Unit:RegisterEvent("spawn2", 10, 1)
	Unit:RegisterEvent("Check2", 100, 0)
end
end

function reg_sotarea2(Unit, Event)
Unit:RegisterEvent("SoT_random",100,0)
Unit:RegisterEvent("sotarea2", 500, 0)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------Area 3-------------------------------------------------------------------------------------------------
function sotarea3(Unit, Event)
if (SoT_choose_area == 0 and area == 3) then
	SoT_choose_area = 1
	Unit:RegisterEvent("spawn3", 10, 1)
	Unit:RegisterEvent("Check3", 100, 0)
end
end

function reg_sotarea3(Unit, Event)
Unit:RegisterEvent("SoT_random",100,0)
Unit:RegisterEvent("sotarea3", 500, 0)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------Area 4-------------------------------------------------------------------------------------------------
function sotarea4(Unit, Event)
if (SoT_choose_area == 0 and area == 4) then
	SoT_choose_area = 1
	Unit:RegisterEvent("spawn4", 10, 1)
	Unit:RegisterEvent("Check4", 100, 0)
end
end

function reg_sotarea4(Unit, Event)
Unit:RegisterEvent("SoT_random",100,0)
Unit:RegisterEvent("sotarea4", 500, 0)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////Horde Teleport function//////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function horde_teleport(Unit, event)
----------------------------------------------------------------------------------------------------Area 1-------------------------------------------------------------------------------------------------
if (eready == 1) and (area == 1) then
eready = 2
msgpplh = "Horde will be teleported to battleground: Redridge Mountains!"
if (hplr1 ~= nil) then
hplr1:Teleport(0,-9693.758,-2772.847,53.914)
end
if (hplr2 ~= nil) then
hplr2:Teleport(0,-9698.758,-2772.847,53.914)
end
if (hplr3 ~= nil) then
hplr3:Teleport(0,-9702.758,-2772.847,53.914)
end
if (hplr4 ~= nil) then
hplr4:Teleport(0,-9706.758,-2772.847,53.914)
end
if (hplr5 ~= nil) then
hplr5:Teleport(0,-9710.758,-2772.847,54.610)
end
if (hplr6 ~= nil) then
hplr6:Teleport(0,-9710.758,-2784.811,54.610)
	if (hplr7 ~= nil) then
	hplr7:Teleport(0,-9706.758,-2784.811,53.914)
		if (hplr8 ~= nil) then
		hplr8:Teleport(0,-9702.758,-2784.811,53.914)
			if (hplr9 ~= nil) then
			hplr9:Teleport(0,-9698.758,-2784.811,53.914)
				if (hplr10 ~= nil) then
				hplr10:Teleport(0,-9693.758,-2784.811,53.914)
				end
			end
		end
	end
end
end

----------------------------------------------------------------------------------------------------Area 2-------------------------------------------------------------------------------------------------
if (eready == 1) and (area == 2) then
eready = 2
msgpplh = "Horde will be teleported to battleground: Arathi Basin!"
if (hplr1 ~= nil) then
hplr1:Teleport(529, 681.137, 664.103, -12.914)
end
if (hplr2 ~= nil) then
hplr2:Teleport(529, 681.137, 664.103, -12.914)
end
if (hplr3 ~= nil) then
hplr3:Teleport(529, 681.137, 664.103, -12.914)
end
if (hplr4 ~= nil) then
hplr4:Teleport(529, 681.137, 664.103, -12.914)
end
if (hplr5 ~= nil) then
hplr5:Teleport(529, 681.137, 664.103, -12.914)
end
if (hplr6 ~= nil) then
hplr6:Teleport(529, 681.137, 664.103, -12.914)
	if (hplr7 ~= nil) then
	hplr7:Teleport(529, 681.137, 664.103, -12.914)
		if (hplr8 ~= nil) then
		hplr8:Teleport(529, 681.137, 664.103, -12.914)
			if (hplr9 ~= nil) then
			hplr9:Teleport(529, 681.137, 664.103, -12.914)
				if (hplr10 ~= nil) then
				hplr10:Teleport(529, 681.137, 664.103, -12.914)
				end
			end
		end
	end
end
end

----------------------------------------------------------------------------------------------------Area 3-------------------------------------------------------------------------------------------------
if (eready == 1) and (area == 3) then
eready = 2
msgpplh = "Horde will be teleported to arena: Area 3!"
if (hplr1 ~= nil) then
hplr1:Teleport(0,-9693.758,-2772.847,53.914)
end
if (hplr2 ~= nil) then
hplr2:Teleport(0,-9698.758,-2772.847,53.914)
end
if (hplr3 ~= nil) then
hplr3:Teleport(0,-9702.758,-2772.847,53.914)
end
if (hplr4 ~= nil) then
hplr4:Teleport(0,-9706.758,-2772.847,53.914)
end
if (hplr5 ~= nil) then
hplr5:Teleport(0,-9710.758,-2772.847,54.610)
end
if (hplr6 ~= nil) then
hplr6:Teleport(0,-9710.758,-2784.811,54.610)
	if (hplr7 ~= nil) then
	hplr7:Teleport(0,-9706.758,-2784.811,53.914)
		if (hplr8 ~= nil) then
		hplr8:Teleport(0,-9702.758,-2784.811,53.914)
			if (hplr9 ~= nil) then
			hplr9:Teleport(0,-9698.758,-2784.811,53.914)
				if (hplr10 ~= nil) then
				hplr10:Teleport(0,-9693.758,-2784.811,53.914)
				end
			end
		end
	end
end
end

----------------------------------------------------------------------------------------------------Area 4-------------------------------------------------------------------------------------------------
if (eready == 1) and (area == 4) then
eready = 2
msgpplh = "Horde will be teleported to arena: Area 4!"
if (hplr1 ~= nil) then
hplr1:Teleport(0,-9693.758,-2772.847,53.914)
end
if (hplr2 ~= nil) then
hplr2:Teleport(0,-9698.758,-2772.847,53.914)
end
if (hplr3 ~= nil) then
hplr3:Teleport(0,-9702.758,-2772.847,53.914)
end
if (hplr4 ~= nil) then
hplr4:Teleport(0,-9706.758,-2772.847,53.914)
end
if (hplr5 ~= nil) then
hplr5:Teleport(0,-9710.758,-2772.847,54.610)
end
if (hplr6 ~= nil) then
hplr6:Teleport(0,-9710.758,-2784.811,54.610)
	if (hplr7 ~= nil) then
	hplr7:Teleport(0,-9706.758,-2784.811,53.914)
		if (hplr8 ~= nil) then
		hplr8:Teleport(0,-9702.758,-2784.811,53.914)
			if (hplr9 ~= nil) then
			hplr9:Teleport(0,-9698.758,-2784.811,53.914)
				if (hplr10 ~= nil) then
				hplr10:Teleport(0,-9693.758,-2784.811,53.914)
				end
			end
		end
	end
end
end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////Ally Teleport function//////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function ally_teleport(Unit, Event)
----------------------------------------------------------------------------------------------------Area 1-------------------------------------------------------------------------------------------------
if (eready == 2) and (area == 1) then
eready = 3
msgppla = "Ally will be teleported to battleground: Redridge Mountains!"
if (aplr1 ~= nil) then
aplr1:Teleport(0,-9698.971,-2807.005,53.639)
end
if (aplr2 ~= nil) then
aplr2:Teleport(0,-9704.115,-2806.315,53.639)
end
if (aplr3 ~= nil) then
aplr3:Teleport(0,-9707.115,-2805.845,53.639)
end
if (aplr4 ~= nil) then
aplr4:Teleport(0,-9711.115,-2805.325,53.639)
end
if (aplr5 ~= nil) then
aplr5:Teleport(0,-9715.971,-2804.815,54.334)
end
if (aplr6 ~= nil) then
aplr6:Teleport(0,-9715.971,-2817.285,54.334)
	if (aplr7 ~= nil) then
	aplr7:Teleport(0,-9712.971,-2818.285,53.639)
		if (aplr8 ~= nil) then
		aplr8:Teleport(0,-9712.971,-2818.285,53.639)
			if (aplr9 ~= nil) then
			aplr9:Teleport(0,-9712.971,-2818.285,53.639)
				if (aplr10 ~= nil) then
				aplr10:Teleport(0,-9712.971,-2818.285,53.639)
				end
			end
		end
	end
end
end

----------------------------------------------------------------------------------------------------Area 2-------------------------------------------------------------------------------------------------
if (eready == 2) and (area == 2) then
eready = 3
msgppla = "Ally will be teleported to battleground: Arathi Basin!"
if (aplr1 ~= nil) then
aplr1:Teleport(529, 1321.75, 1324.74, -9.00805)
end
if (aplr2 ~= nil) then
aplr2:Teleport(529, 1321.75, 1324.74, -9.00805)
end
if (aplr3 ~= nil) then
aplr3:Teleport(529, 1321.75, 1324.74, -9.00805)
end
if (aplr4 ~= nil) then
aplr4:Teleport(529, 1321.75, 1324.74, -9.00805)
end
if (aplr5 ~= nil) then
aplr5:Teleport(529, 1321.75, 1324.74, -9.00805)
end
if (aplr6 ~= nil) then
aplr6:Teleport(529, 1321.75, 1324.74, -9.00805)
	if (aplr7 ~= nil) then
	aplr7:Teleport(529, 1321.75, 1324.74, -9.00805)
		if (aplr8 ~= nil) then
		aplr8:Teleport(529, 1321.75, 1324.74, -9.00805)
			if (aplr9 ~= nil) then
			aplr9:Teleport(529, 1321.75, 1324.74, -9.00805)
				if (aplr10 ~= nil) then
				aplr10:Teleport(529, 1321.75, 1324.74, -9.00805)
				end
			end
		end
	end
end
end

----------------------------------------------------------------------------------------------------Area 3-------------------------------------------------------------------------------------------------
if (eready == 2) and (area == 3) then
eready = 3
msgppla = "Ally will be teleported to arena: Area 3!"
if (aplr1 ~= nil) then
aplr1:Teleport(0,-9698.971,-2807.005,53.639)
end
if (aplr2 ~= nil) then
aplr2:Teleport(0,-9704.115,-2806.315,53.639)
end
if (aplr3 ~= nil) then
aplr3:Teleport(0,-9707.115,-2805.845,53.639)
end
if (aplr4 ~= nil) then
aplr4:Teleport(0,-9711.115,-2805.325,53.639)
end
if (aplr5 ~= nil) then
aplr5:Teleport(0,-9715.971,-2804.815,54.334)
end
if (aplr6 ~= nil) then
aplr6:Teleport(0,-9715.971,-2817.285,54.334)
	if (aplr7 ~= nil) then
	aplr7:Teleport(0,-9712.971,-2818.285,53.639)
		if (aplr8 ~= nil) then
		aplr8:Teleport(0,-9712.971,-2818.285,53.639)
			if (aplr9 ~= nil) then
			aplr9:Teleport(0,-9712.971,-2818.285,53.639)
				if (aplr10 ~= nil) then
				aplr10:Teleport(0,-9712.971,-2818.285,53.639)
				end
			end
		end
	end
end
end

----------------------------------------------------------------------------------------------------Area 4-------------------------------------------------------------------------------------------------
if (eready == 2) and (area == 4) then
eready = 3
msgppla = "Ally will be teleported to arena: Area 4!"
if (aplr1 ~= nil) then
aplr1:Teleport(0,-9698.971,-2807.005,53.639)
end
if (aplr2 ~= nil) then
aplr2:Teleport(0,-9704.115,-2806.315,53.639)
end
if (aplr3 ~= nil) then
aplr3:Teleport(0,-9707.115,-2805.845,53.639)
end
if (aplr4 ~= nil) then
aplr4:Teleport(0,-9711.115,-2805.325,53.639)
end
if (aplr5 ~= nil) then
aplr5:Teleport(0,-9715.971,-2804.815,54.334)
end
if (aplr6 ~= nil) then
aplr6:Teleport(0,-9715.971,-2817.285,54.334)
	if (aplr7 ~= nil) then
	aplr7:Teleport(0,-9712.971,-2818.285,53.639)
		if (aplr8 ~= nil) then
		aplr8:Teleport(0,-9712.971,-2818.285,53.639)
			if (aplr9 ~= nil) then
			aplr9:Teleport(0,-9712.971,-2818.285,53.639)
				if (aplr10 ~= nil) then
				aplr10:Teleport(0,-9712.971,-2818.285,53.639)
				end
			end
		end
	end
end
end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////////Spawn rolls//////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
----------------------------------------------------------------------------------------------------Area 1-------------------------------------------------------------------------------------------------
function spawn1(Unit, Event)
if area == 1 then
SoT_initiated_times = SoT_initiated_times + 1
--Silvanas(H)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555300,-9815.342773,-3253.055664,58.752060,0.830601, 118, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555300, -9537.46, -3260.2, 48.9567, 0.830601, 118, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555300, -9292.08, -3314.25, 150.143, 0.830601, 118, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555300, -9206.88, -3018.21, 117.483, 0.830601, 118, 1920000);
end
--Jaina (A)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555200,-9010.224609,-3216.167725,108.260620,3.050141, 1096, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555200, -9272.95, -3292.48, 115.669, 3.050141, 1096, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555200, -9452.03, -3280.59, 18.4229, 3.050141, 1096, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555200, -9363.07, -2995.83, 137.665, 3.050141, 1096, 1920000);
end
--Archdruid Fandral (A)
local spwnum = math.random(5)
if (spwnum == 1) then
Unit:SpawnCreature(555202,-9319.030273,-3071.407959,162.420456,4.860827, 79, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555202, -9412.21, -2839.39, 62.2607, 4.860827, 79, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555202, -9723.31, -3132.71, 89.485, 4.860827, 79, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555202, -9424.44, -3166.63, 78.1009, 4.860827, 79, 1920000);
elseif (spwnum == 5) then
SoT_A_Aquatic = 1
Unit:SpawnCreature(555202, -9374.6, -2821.29, 36.8111, 0, 79, 1920000);
end
--Archdruid Hamuul (H)
local spwnum = math.random(5)
if (spwnum == 1) then
Unit:SpawnCreature(555302,-9388.754883,-2861.217285,62.256916,2.100917, 104, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555302, -9296.28, -2937.72, 163.848, 2.100917, 104, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555302, -9195.77, -2878.82, 113.04, 2.100917, 104, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555302, -9187.72, -3112.18, 129.368, 2.100917, 104, 1920000);
elseif (spwnum == 5) then
SoT_H_Aquatic = 1
Unit:SpawnCreature(555302, -9531.97, -3177.89, 45.0581, 0, 104, 1920000);
end
--Prophet Velen (A)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555201,-9178.152344,-3327.702881,139.252686,3.471902, 1640, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555201, -9383.86, -3395.91, 125.03, 3.471902, 1640, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555201, -9717.78, -3126.53, 60.5603, 3.471902, 1640, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555201, -9383.06, -3081.3, 158.073, 3.471902, 1640, 1920000);
end
--Thrall (H)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555301,-9625.506836,-3491.305664,157.095871,1.373325, 125, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555301, -9545.81, -3501.5, 150.76, 1.373325, 125, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555301, -9438.35, -3080.07, 136.687, 1.373325, 125, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555301, -9734.72, -3176.87, 58.6096, 1.373325, 125, 1920000);
end
end
end
----------------------------------------------------------------------------------------------------Area 2-------------------------------------------------------------------------------------------------
function spawn2(Unit, Event)
if area == 2 then
SoT_initiated_times = SoT_initiated_times + 1
--Jaina (A)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555200, 1289.48, 1214.37, -13.512, 3.19741, 1096, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555200, 947.221, 944.294, -23.445, 4.27815, 1096, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555200, 1132.72, 843.994, -88.5096, 4.86643, 1096, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555200, 798.394, 1181.99, 11.9216, 6.16629, 1096, 1920000);
end
--Prophet Velen (A)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555201, 1240.48, 1125.42, -21.375, 3.61366, 1640, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555201, 990.455, 1001.28, -42.6032, 1.11926, 1640, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555201, 814.438, 839.559, -56.5401, 1.63844, 1640, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555201, 1216.52, 800.055, -36.136, 1.37534, 1640, 1920000);
end
--Archdruid Fandral (A)
local spwnum = math.random(5)
if (spwnum == 1) then
Unit:SpawnCreature(555202, 1129.48, 1070.83, -64.5992, 2.20703, 79, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555202, 931.648, 891.247, -51.2027, 2.74192, 79, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555202, 852.4, 1228.17, 13.712, 4.76432, 79, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555202, 827.602, 679.7, -38.6999, 2.63983, 79, 1920000);
elseif (spwnum == 5) then
SoT_A_Aquatic = 1
Unit:SpawnCreature(555202, 1011.13, 1128.85, -71.3325, 0, 79, 1920000);
end
--Silvanas(H)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555300, 1036.14, 1240.18, -22.3936, 5.34546, 118, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555300, 851.813, 1143.08, 20.031, 2.96183, 118, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555300, 1244.95, 778.536, -104.072, 1.70522, 118, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555300, 1067.5, 869.952, -39.4139, 4.98818, 118, 1920000);
end
--Thrall (H)
local spwnum = math.random(4)
if (spwnum == 1) then
Unit:SpawnCreature(555301, 1187.39, 1186.07, -56.3633, 3.83357, 125, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555301, 1086.19, 1117.34, -58.5101, 3.12594, 125, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555301, 754.715, 1254.22, 25.8601, 5.19237, 125, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555301, 671.986, 808.326, 0.807998, 3.97893, 125, 1920000);
end
--Archdruid Hamuul (H)
local spwnum = math.random(5)
if (spwnum == 1) then
Unit:SpawnCreature(555302, 1171.35, 1329.03, -30.5064, 4.22157, 104, 1920000);
elseif (spwnum == 2) then
Unit:SpawnCreature(555302, 948.012, 1059.15, -50.1337, 2.22748, 104, 1920000);
elseif (spwnum == 3) then
Unit:SpawnCreature(555302, 1267.12, 759.43, -57.7684, 2.67125, 104, 1920000);
elseif (spwnum == 4) then
Unit:SpawnCreature(555302, 1211.71, 792.483, -80.4916, 4.08892, 104, 1920000);
elseif (spwnum == 5) then
SoT_H_Aquatic = 1
Unit:SpawnCreature(555302, 1009.4, 894.998, -73.8799, 0, 104, 1920000);
end
end
end
----------------------------------------------------------------------------------------------------Area 3-------------------------------------------------------------------------------------------------
function spawn3(Unit, Event)
end
----------------------------------------------------------------------------------------------------Area 4-------------------------------------------------------------------------------------------------
function spawn4(Unit, Event)
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////////Chat Functions//////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
---------------------------------------------------------------------------------------------------Starter chat-------------------------------------------------------------------------------------------
function reg_instructor_chata(Unit, Event)
Unit:RegisterEvent("SoTreset", 10, 1) 
Unit:RegisterEvent("rules_chata",10,0)
Unit:RegisterEvent("SoT_random",100,0)
Unit:RegisterEvent("ally_teleport",1000,0)
end

function rules_chata(Unit, Event) 
if (msgppla ~= msgppld) then
	Unit:SendChatMessage(12,0,msgppla)
	msgppld = msgppla
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function reg_instructor_chath(Unit, Event) 
Unit:RegisterEvent("SoTreset", 10, 1) 
Unit:RegisterEvent("rules_chath",10,0)
Unit:RegisterEvent("SoT_random",100,0)
Unit:RegisterEvent("horde_teleport",1000,0)
end

function rules_chath(Unit, Event) 
if (msgpplh ~= msgpplg) then
	Unit:SendChatMessage(12,0,msgpplh)
	msgpplg = msgpplh
end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////Check function Area 1/////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function Check1(Unit, Event)
if area == 1 then
------------ Ally Finish Coords -------------
SoT_finish_x1 = -9690 -- Xmax
SoT_finish_x2 = -9718 -- Xmin
SoT_finish_y1 = -2803 -- Ymax
SoT_finish_y2 = -2821 -- Ymin
---------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if ((eready == 3) and (ahero == 3)) then 
sot_ally_count = 10
sot_ally_fin = 0
if (aplr1 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr1:GetY() < SoT_finish_y1) and (aplr1:GetY() > SoT_finish_y2) and (aplr1:GetX() < SoT_finish_x1) and (aplr1:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr2 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr2:GetY() < SoT_finish_y1) and (aplr2:GetY() > SoT_finish_y2) and (aplr2:GetX() < SoT_finish_x1) and (aplr2:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr3 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr3:GetY() < SoT_finish_y1) and (aplr3:GetY() > SoT_finish_y2) and (aplr3:GetX() < SoT_finish_x1) and (aplr3:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr4 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr4:GetY() < SoT_finish_y1) and (aplr4:GetY() > SoT_finish_y2) and (aplr4:GetX() < SoT_finish_x1) and (aplr4:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr5 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr5:GetY() < SoT_finish_y1) and (aplr5:GetY() > SoT_finish_y2) and (aplr5:GetX() < SoT_finish_x1) and (aplr5:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr6 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr6:GetY() < SoT_finish_y1) and (aplr6:GetY() > SoT_finish_y2) and (aplr6:GetX() < SoT_finish_x1) and (aplr6:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr7 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr7:GetY() < SoT_finish_y1) and (aplr7:GetY() > SoT_finish_y2) and (aplr7:GetX() < SoT_finish_x1) and (aplr7:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr8 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr8:GetY() < SoT_finish_y1) and (aplr8:GetY() > SoT_finish_y2) and (aplr8:GetX() < SoT_finish_x1) and (aplr8:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr9 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr9:GetY() < SoT_finish_y1) and (aplr9:GetY() > SoT_finish_y2) and (aplr9:GetX() < SoT_finish_x1) and (aplr9:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr10 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr10:GetY() < SoT_finish_y1) and (aplr10:GetY() > SoT_finish_y2) and (aplr10:GetX() < SoT_finish_x1) and (aplr10:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (sot_ally_count == sot_ally_fin) then
Unit:SendChatMessage(14, 0, "Ally wins!!")
Unit:RegisterEvent("allywins",1000,1)
eready = 4
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------- Horde Finish Coords -----------
SoT_finish_x1 = -9683 -- Xmax
SoT_finish_x2 = -9713 -- Xmin
SoT_finish_y1 = -2771 -- Ymax
SoT_finish_y2 = -2786 -- Ymin
---------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if ((eready == 3) and (hhero == 3)) then 
sot_horde_count = 10
sot_horde_fin = 0
if (hplr1 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr1:GetY() < SoT_finish_y1) and (hplr1:GetY() > SoT_finish_y2) and (hplr1:GetX() < SoT_finish_x1) and (hplr1:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr2 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr2:GetY() < SoT_finish_y1) and (hplr2:GetY() > SoT_finish_y2) and (hplr2:GetX() < SoT_finish_x1) and (hplr2:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr3 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr3:GetY() < SoT_finish_y1) and (hplr3:GetY() > SoT_finish_y2) and (hplr3:GetX() < SoT_finish_x1) and (hplr3:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr4 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr4:GetY() < SoT_finish_y1) and (hplr4:GetY() > SoT_finish_y2) and (hplr4:GetX() < SoT_finish_x1) and (hplr4:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr5 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr5:GetY() < SoT_finish_y1) and (hplr5:GetY() > SoT_finish_y2) and (hplr5:GetX() < SoT_finish_x1) and (hplr5:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr6 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr6:GetY() < SoT_finish_y1) and (hplr6:GetY() > SoT_finish_y2) and (hplr6:GetX() < SoT_finish_x1) and (hplr6:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr7 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr7:GetY() < SoT_finish_y1) and (hplr7:GetY() > SoT_finish_y2) and (hplr7:GetX() < SoT_finish_x1) and (hplr7:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr8 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr8:GetY() < SoT_finish_y1) and (hplr8:GetY() > SoT_finish_y2) and (hplr8:GetX() < SoT_finish_x1) and (hplr8:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr9 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr9:GetY() < SoT_finish_y1) and (hplr9:GetY() > SoT_finish_y2) and (hplr9:GetX() < SoT_finish_x1) and (hplr9:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr10 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr10:GetY() < SoT_finish_y1) and (hplr10:GetY() > SoT_finish_y2) and (hplr10:GetX() < SoT_finish_x1) and (hplr10:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (sot_horde_count == sot_horde_fin) then
Unit:SendChatMessage(14, 0, "Horde wins!!")
Unit:RegisterEvent("hordewins",1000,1)
eready = 4
end
end
----------------------------------------------------------------------------------Every 60 sec announce status------------------------------------------------------------------------------------------
if (eready == 3) then
SoT_check_timer = SoT_check_timer + 1
if SoT_check_timer == 600 then
SoT_check_timer = 0
SoT_time = SoT_time + 1
local hkilled = string.format("Horde killed %s heroes. Ally killed %s heroes.", hhero, ahero)
Unit:SendChatMessage(14, 0, hkilled)
if hhero == 3 then
Unit:SendChatMessage(14, 0, "Horde has killed all ally heroes, return to your base!")
end
if ahero == 3 then
Unit:SendChatMessage(14, 0, "Ally has killed all horde heroes, return to your base!")
end
end
if (SoT_time == 30 and sot_time30 == nil) then -- 32 = Auto-reset
sot_time30 = 1
Unit:SendChatMessage(14, 0, "2 Minutes left till auto-reset! Hurry up!")
end
if (SoT_time == 31 and sot_time31 == nil) then
sot_time31 = 1
Unit:SendChatMessage(14, 0, "Auto-reset in 1 minute!")
end
if (SoT_time == 32 and sot_time32 == nil) then
sot_time32 = 1
Unit:RegisterEvent("nowinner",10,1)
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if hplr1 ~= nil then
if (hplr1:GetName() ~= hplr1_name) then
hplr1 = nil
hplr1_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr1_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr2 ~= nil then
if (hplr2:GetName() ~= hplr2_name) then
hplr2 = nil
hplr2_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr2_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr3 ~= nil then
if (hplr3:GetName() ~= hplr3_name) then
hplr3 = nil
hplr3_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr3_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr4 ~= nil then
if (hplr4:GetName() ~= hplr4_name) then
hplr4 = nil
hplr4_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr4_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr5 ~= nil then
if (hplr5:GetName() ~= hplr5_name) then
hplr5 = nil
hplr5_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr5_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr6 ~= nil then
if (hplr6:GetName() ~= hplr6_name) then
hplr6 = nil
hplr6_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr6_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr7 ~= nil then
if (hplr7:GetName() ~= hplr7_name) then
hplr7 = nil
hplr7_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr7_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr8 ~= nil then
if (hplr8:GetName() ~= hplr8_name) then
hplr8 = nil
hplr8_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr8_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr9 ~= nil then
if (hplr9:GetName() ~= hplr9_name) then
hplr9 = nil
hplr9_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr9_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr10 ~= nil then
if (hplr10:GetName() ~= hplr10_name) then
hplr10 = nil
hplr10_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr10_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if aplr1 ~= nil then
if (aplr1:GetName() ~= aplr1_name) then
aplr1 = nil
aplr1_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr1_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr2 ~= nil then
if (aplr2:GetName() ~= aplr2_name) then
aplr2 = nil
aplr2_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr2_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr3 ~= nil then
if (aplr3:GetName() ~= aplr3_name) then
aplr3 = nil
aplr3_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr3_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr4 ~= nil then
if (aplr4:GetName() ~= aplr4_name) then
aplr4 = nil
aplr4_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr4_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr5 ~= nil then
if (aplr5:GetName() ~= aplr5_name) then
aplr5 = nil
aplr5_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr5_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr6 ~= nil then
if (aplr6:GetName() ~= aplr6_name) then
aplr6 = nil
aplr6_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr6_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr7 ~= nil then
if (aplr7:GetName() ~= aplr7_name) then
aplr7 = nil
aplr7_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr7_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr8 ~= nil then
if (aplr8:GetName() ~= aplr8_name) then
aplr8 = nil
aplr8_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr8_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr9 ~= nil then
if (aplr9:GetName() ~= aplr9_name) then
aplr9 = nil
aplr9_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr9_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr10 ~= nil then
if (aplr10:GetName() ~= aplr10_name) then
aplr10 = nil
aplr10_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr10_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////Check function Area 2/////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function Check2(Unit, Event)
if area == 2 then
------------ Ally Finish Coords -------------
SoT_finish_x1 = 1339 -- Xmax
SoT_finish_x2 = 1299 -- Xmin
SoT_finish_y1 = 1345 -- Ymax
SoT_finish_y2 = 1303 -- Ymin
---------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if ((eready == 3) and (ahero == 3)) then 
sot_ally_count = 10
sot_ally_fin = 0
if (aplr1 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr1:GetY() < SoT_finish_y1) and (aplr1:GetY() > SoT_finish_y2) and (aplr1:GetX() < SoT_finish_x1) and (aplr1:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr2 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr2:GetY() < SoT_finish_y1) and (aplr2:GetY() > SoT_finish_y2) and (aplr2:GetX() < SoT_finish_x1) and (aplr2:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr3 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr3:GetY() < SoT_finish_y1) and (aplr3:GetY() > SoT_finish_y2) and (aplr3:GetX() < SoT_finish_x1) and (aplr3:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr4 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr4:GetY() < SoT_finish_y1) and (aplr4:GetY() > SoT_finish_y2) and (aplr4:GetX() < SoT_finish_x1) and (aplr4:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr5 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr5:GetY() < SoT_finish_y1) and (aplr5:GetY() > SoT_finish_y2) and (aplr5:GetX() < SoT_finish_x1) and (aplr5:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr6 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr6:GetY() < SoT_finish_y1) and (aplr6:GetY() > SoT_finish_y2) and (aplr6:GetX() < SoT_finish_x1) and (aplr6:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr7 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr7:GetY() < SoT_finish_y1) and (aplr7:GetY() > SoT_finish_y2) and (aplr7:GetX() < SoT_finish_x1) and (aplr7:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr8 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr8:GetY() < SoT_finish_y1) and (aplr8:GetY() > SoT_finish_y2) and (aplr8:GetX() < SoT_finish_x1) and (aplr8:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr9 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr9:GetY() < SoT_finish_y1) and (aplr9:GetY() > SoT_finish_y2) and (aplr9:GetX() < SoT_finish_x1) and (aplr9:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (aplr10 == nil) then
sot_ally_count = sot_ally_count - 1
elseif ((aplr10:GetY() < SoT_finish_y1) and (aplr10:GetY() > SoT_finish_y2) and (aplr10:GetX() < SoT_finish_x1) and (aplr10:GetX() > SoT_finish_x2)) then
sot_ally_fin = sot_ally_fin + 1
end
if (sot_ally_count == sot_ally_fin) then
Unit:SendChatMessage(14, 0, "Ally wins!!")
sot_a_2_ally = 1
Unit:RegisterEvent("allywins",1000,1)
eready = 4
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------- Horde Finish Coords -----------
SoT_finish_x1 = 700 -- Xmax
SoT_finish_x2 = 659 -- Xmin
SoT_finish_y1 = 689 -- Ymax
SoT_finish_y2 = 647 -- Ymin
---------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if ((eready == 3) and (hhero == 3)) then 
sot_horde_count = 10
sot_horde_fin = 0
if (hplr1 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr1:GetY() < SoT_finish_y1) and (hplr1:GetY() > SoT_finish_y2) and (hplr1:GetX() < SoT_finish_x1) and (hplr1:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr2 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr2:GetY() < SoT_finish_y1) and (hplr2:GetY() > SoT_finish_y2) and (hplr2:GetX() < SoT_finish_x1) and (hplr2:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr3 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr3:GetY() < SoT_finish_y1) and (hplr3:GetY() > SoT_finish_y2) and (hplr3:GetX() < SoT_finish_x1) and (hplr3:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr4 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr4:GetY() < SoT_finish_y1) and (hplr4:GetY() > SoT_finish_y2) and (hplr4:GetX() < SoT_finish_x1) and (hplr4:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr5 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr5:GetY() < SoT_finish_y1) and (hplr5:GetY() > SoT_finish_y2) and (hplr5:GetX() < SoT_finish_x1) and (hplr5:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr6 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr6:GetY() < SoT_finish_y1) and (hplr6:GetY() > SoT_finish_y2) and (hplr6:GetX() < SoT_finish_x1) and (hplr6:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr7 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr7:GetY() < SoT_finish_y1) and (hplr7:GetY() > SoT_finish_y2) and (hplr7:GetX() < SoT_finish_x1) and (hplr7:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr8 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr8:GetY() < SoT_finish_y1) and (hplr8:GetY() > SoT_finish_y2) and (hplr8:GetX() < SoT_finish_x1) and (hplr8:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr9 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr9:GetY() < SoT_finish_y1) and (hplr9:GetY() > SoT_finish_y2) and (hplr9:GetX() < SoT_finish_x1) and (hplr9:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (hplr10 == nil) then
sot_horde_count = sot_horde_count - 1
elseif ((hplr10:GetY() < SoT_finish_y1) and (hplr10:GetY() > SoT_finish_y2) and (hplr10:GetX() < SoT_finish_x1) and (hplr10:GetX() > SoT_finish_x2)) then
sot_horde_fin = sot_horde_fin + 1
end
if (sot_horde_count == sot_horde_fin) then
Unit:SendChatMessage(14, 0, "Horde wins!!")
sot_h_2_horde = 1
Unit:RegisterEvent("hordewins",1000,1)
eready = 4
end
end
----------------------------------------------------------------------------------Every 60 sec announce status------------------------------------------------------------------------------------------
if (eready == 3) then
SoT_check_timer = SoT_check_timer + 1
if SoT_check_timer == 600 then
SoT_check_timer = 0
SoT_time = SoT_time + 1
local hkilled = string.format("Horde killed %s heroes. Ally killed %s heroes.", hhero, ahero)
Unit:SendChatMessage(14, 0, hkilled)
if hhero == 3 then
Unit:SendChatMessage(14, 0, "Horde has killed all ally heroes, return to your base!")
end
if ahero == 3 then
Unit:SendChatMessage(14, 0, "Ally has killed all horde heroes, return to your base!")
end
end
if (SoT_time == 30 and sot_time30 == nil) then -- 32 = Auto-reset
sot_time30 = 1
Unit:SendChatMessage(14, 0, "2 Minutes left till auto-reset! Hurry up!")
end
if (SoT_time == 31 and sot_time31 == nil) then
sot_time31 = 1
Unit:SendChatMessage(14, 0, "Auto-reset in 1 minute!")
end
if (SoT_time == 32 and sot_time32 == nil) then
sot_time32 = 1
Unit:RegisterEvent("nowinner",10,1)
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if hplr1 ~= nil then
if (hplr1:GetName() ~= hplr1_name) then
hplr1 = nil
hplr1_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr1_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr2 ~= nil then
if (hplr2:GetName() ~= hplr2_name) then
hplr2 = nil
hplr2_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr2_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr3 ~= nil then
if (hplr3:GetName() ~= hplr3_name) then
hplr3 = nil
hplr3_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr3_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr4 ~= nil then
if (hplr4:GetName() ~= hplr4_name) then
hplr4 = nil
hplr4_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr4_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr5 ~= nil then
if (hplr5:GetName() ~= hplr5_name) then
hplr5 = nil
hplr5_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr5_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr6 ~= nil then
if (hplr6:GetName() ~= hplr6_name) then
hplr6 = nil
hplr6_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr6_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr7 ~= nil then
if (hplr7:GetName() ~= hplr7_name) then
hplr7 = nil
hplr7_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr7_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr8 ~= nil then
if (hplr8:GetName() ~= hplr8_name) then
hplr8 = nil
hplr8_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr8_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr9 ~= nil then
if (hplr9:GetName() ~= hplr9_name) then
hplr9 = nil
hplr9_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr9_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if hplr10 ~= nil then
if (hplr10:GetName() ~= hplr10_name) then
hplr10 = nil
hplr10_name = nil
sot_plr_leaves = string.format("%s leaves the horde team.", hplr10_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if aplr1 ~= nil then
if (aplr1:GetName() ~= aplr1_name) then
aplr1 = nil
aplr1_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr1_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr2 ~= nil then
if (aplr2:GetName() ~= aplr2_name) then
aplr2 = nil
aplr2_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr2_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr3 ~= nil then
if (aplr3:GetName() ~= aplr3_name) then
aplr3 = nil
aplr3_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr3_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr4 ~= nil then
if (aplr4:GetName() ~= aplr4_name) then
aplr4 = nil
aplr4_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr4_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr5 ~= nil then
if (aplr5:GetName() ~= aplr5_name) then
aplr5 = nil
aplr5_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr5_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr6 ~= nil then
if (aplr6:GetName() ~= aplr6_name) then
aplr6 = nil
aplr6_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr6_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr7 ~= nil then
if (aplr7:GetName() ~= aplr7_name) then
aplr7 = nil
aplr7_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr7_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr8 ~= nil then
if (aplr8:GetName() ~= aplr8_name) then
aplr8 = nil
aplr8_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr8_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr9 ~= nil then
if (aplr9:GetName() ~= aplr9_name) then
aplr9 = nil
aplr9_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr9_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
if aplr10 ~= nil then
if (aplr10:GetName() ~= aplr10_name) then
aplr10 = nil
aplr10_name = nil
sot_plr_leaves = string.format("%s leaves the ally team.", aplr10_name)
Unit:SendChatMessage(12, 0, sot_plr_leaves)
end
end
end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Check2b(Unit, Event)
if area == 2 then
if (eready == 3) then
SoT_check_timer2 = SoT_check_timer2 + 1
if SoT_check_timer2 == 600 then
SoT_check_timer2 = 0
SoT_time2 = SoT_time2 + 1
local hkilled = string.format("Horde killed %s heroes. Ally killed %s heroes.", hhero, ahero)
Unit:SendChatMessage(14, 0, hkilled)
	if hhero == 3 then
	Unit:SendChatMessage(14, 0, "Horde has killed all ally heroes, return to your base!")
	end
	if ahero == 3 then
	Unit:SendChatMessage(14, 0, "Ally has killed all horde heroes, return to your base!")
	end
end
	if (SoT_time2 == 30 and sot_time302 == nil) then
	sot_time302 = 1
	Unit:SendChatMessage(14, 0, "2 Minutes left till auto-reset! Hurry up!")
	end
	if (SoT_time2 == 31 and sot_time312 == nil) then
	sot_time312 = 1
	Unit:SendChatMessage(14, 0, "Auto-reset in 1 minute!")
	end
	if sot_h_2_horde == 1 then
	sot_h_2_horde = 2
	Unit:SendChatMessage(14, 0, "Horde wins!!")
	end
	if sot_a_2_ally == 1 then
	sot_a_2_ally = 2
	Unit:SendChatMessage(14, 0, "Ally wins!!")
	end
end
end
end

function reg_sotarea2b(Unit, Event)
Unit:RegisterEvent("Check2b", 100, 0)
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////Check function Area 3/////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////Check function Area 4/////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////////Winners//////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function hordewins(Unit, Event)
Unit:RegisterEvent("SoTreset", 1000, 1)
---------------------- Teleport Horde ----------------------
if (hplr1 ~= nil) then
hplr1:AddItem(70087,1)
hplr1:Teleport(1,-8467.96,-4236.72,-208.443)
end
	if (hplr2 ~= nil) then
	hplr2:AddItem(70087,1)
	hplr2:Teleport(1,-8467.96,-4236.72,-208.443)
	end
		if (hplr3 ~= nil) then
		hplr3:AddItem(70087,1)
		hplr3:Teleport(1,-8467.96,-4236.72,-208.443)
		end
			if (hplr4 ~= nil) then
			hplr4:AddItem(70087,1)
			hplr4:Teleport(1,-8467.96,-4236.72,-208.443)
			end
				if (hplr5 ~= nil) then
				hplr5:AddItem(70087,1)
				hplr5:Teleport(1,-8467.96,-4236.72,-208.443)
				end
					if (hplr6 ~= nil) then
					hplr6:Teleport(1,-8467.96,-4236.72,-208.443)
					hplr6:AddItem(70087,1)
					end
						if (hplr7 ~= nil) then
						hplr7:Teleport(1,-8467.96,-4236.72,-208.443)
						hplr7:AddItem(70087,1)
						end
							if (hplr8 ~= nil) then
							hplr8:Teleport(1,-8467.96,-4236.72,-208.443)
							hplr8:AddItem(70087,1)
							end
								if (hplr9 ~= nil) then
								hplr9:Teleport(1,-8467.96,-4236.72,-208.443)
								hplr9:AddItem(70087,1)
								end
									if (hplr10 ~= nil) then
									hplr10:Teleport(1,-8467.96,-4236.72,-208.443)
									hplr10:AddItem(70087,1)
									end
---------------------- Teleport Ally ----------------------
if (aplr1 ~= nil) then
aplr1:Teleport(1,-8467.96,-4236.72,-208.443)
end
	if (aplr2 ~= nil) then
	aplr2:Teleport(1,-8467.96,-4236.72,-208.443)       
	end
		if (aplr3 ~= nil) then
		aplr3:Teleport(1,-8467.96,-4236.72,-208.443)
		end
			if (aplr4 ~= nil) then
			aplr4:Teleport(1,-8467.96,-4236.72,-208.443)
			end
				if (aplr5 ~= nil) then
				aplr5:Teleport(1,-8467.96,-4236.72,-208.443)
				end
					if (aplr6 ~= nil) then
					aplr6:Teleport(1,-8467.96,-4236.72,-208.443)
					end
						if (aplr7 ~= nil) then
					    aplr7:Teleport(1,-8467.96,-4236.72,-208.443)
						end
							if (aplr8 ~= nil) then
							aplr8:Teleport(1,-8467.96,-4236.72,-208.443)
							end
								if (aplr9 ~= nil) then
								aplr9:Teleport(1,-8467.96,-4236.72,-208.443)
								end
									if (aplr10 ~= nil) then
									aplr10:Teleport(1,-8467.96,-4236.72,-208.443)
									end
end

function allywins(Unit, Event)
Unit:RegisterEvent("SoTreset",100,1)
---------------------- Teleport Ally ----------------------
if (aplr1 ~= nil) then
aplr1:AddItem(70087,1)
aplr1:Teleport(1,-8467.96,-4236.72,-208.443)
end
	if (aplr2 ~= nil) then
	aplr2:AddItem(70087,1)
	aplr2:Teleport(1,-8467.96,-4236.72,-208.443)
	end
		if (aplr3 ~= nil) then
		aplr3:AddItem(70087,1)
		aplr3:Teleport(1,-8467.96,-4236.72,-208.443)
		end
			if (aplr4 ~= nil) then
			aplr4:AddItem(70087,1)
			aplr4:Teleport(1,-8467.96,-4236.72,-208.443)
			end
				if (aplr5 ~= nil) then
				aplr5:AddItem(70087,1)
				aplr5:Teleport(1,-8467.96,-4236.72,-208.443)
				end
					if (aplr6 ~= nil) then
					aplr6:Teleport(1,-8467.96,-4236.72,-208.443)
					aplr6:AddItem(70087,1)
					end
						if (aplr7 ~= nil) then
						aplr7:Teleport(1,-8467.96,-4236.72,-208.443)
						aplr7:AddItem(70087,1)
						end
							if (aplr8 ~= nil) then
							aplr8:Teleport(1,-8467.96,-4236.72,-208.443)
							aplr8:AddItem(70087,1)
							end
								if (aplr9 ~= nil) then
								aplr9:Teleport(1,-8467.96,-4236.72,-208.443)
								aplr9:AddItem(70087,1)
								end
									if (aplr10 ~= nil) then
									aplr10:Teleport(1,-8467.96,-4236.72,-208.443)
									aplr10:AddItem(70087,1)
									end
---------------------- Teleport Horde ----------------------
if (hplr1 ~= nil) then
hplr1:Teleport(1,-8467.96,-4236.72,-208.443)
end
	if (hplr2 ~= nil) then
	hplr2:Teleport(1,-8467.96,-4236.72,-208.443)
	end
		if (hplr3 ~= nil) then
		hplr3:Teleport(1,-8467.96,-4236.72,-208.443)
		end
			if (hplr4 ~= nil) then
			hplr4:Teleport(1,-8467.96,-4236.72,-208.443)
			end
				if (hplr5 ~= nil) then
				hplr5:Teleport(1,-8467.96,-4236.72,-208.443)
				end
					if (hplr6 ~= nil) then
					hplr6:Teleport(1,-8467.96,-4236.72,-208.443)
					end
						if (hplr7 ~= nil) then
						hplr7:Teleport(1,-8467.96,-4236.72,-208.443)
						end
							if (hplr8 ~= nil) then
							hplr8:Teleport(1,-8467.96,-4236.72,-208.443)
							end
								if (hplr9 ~= nil) then
								hplr9:Teleport(1,-8467.96,-4236.72,-208.443)
								end
									if (hplr10 ~= nil) then
									hplr10:Teleport(1,-8467.96,-4236.72,-208.443)
									end
end

function nowinner(Unit, Event)
Unit:RegisterEvent("SoTreset", 100, 1)
---------------------- Teleport Ally ----------------------
if (aplr1 ~= nil) then
aplr1:Teleport(1,-8467.96,-4236.72,-208.443)
end
	if (aplr2 ~= nil) then
	aplr2:Teleport(1,-8467.96,-4236.72,-208.443)       
	end
		if (aplr3 ~= nil) then
		aplr3:Teleport(1,-8467.96,-4236.72,-208.443)
		end
			if (aplr4 ~= nil) then
			aplr4:Teleport(1,-8467.96,-4236.72,-208.443)
			end
				if (aplr5 ~= nil) then
				aplr5:Teleport(1,-8467.96,-4236.72,-208.443)
				end
					if (aplr6 ~= nil) then
					aplr6:Teleport(1,-8467.96,-4236.72,-208.443)
					end
						if (aplr7 ~= nil) then
					    aplr7:Teleport(1,-8467.96,-4236.72,-208.443)
						end
							if (aplr8 ~= nil) then
							aplr8:Teleport(1,-8467.96,-4236.72,-208.443)
							end
								if (aplr9 ~= nil) then
								aplr9:Teleport(1,-8467.96,-4236.72,-208.443)
								end
									if (aplr10 ~= nil) then
									aplr10:Teleport(1,-8467.96,-4236.72,-208.443)
									end
---------------------- Teleport Horde ----------------------
if (hplr1 ~= nil) then	
hplr1:Teleport(1,-8467.96,-4236.72,-208.443)
end
	if (hplr2 ~= nil) then	
	hplr2:Teleport(1,-8467.96,-4236.72,-208.443)
	end
		if (hplr3 ~= nil) then	
		hplr3:Teleport(1,-8467.96,-4236.72,-208.443)
		end
			if (hplr4 ~= nil) then	
			hplr4:Teleport(1,-8467.96,-4236.72,-208.443)
			end
				if (hplr5 ~= nil) then	
				hplr5:Teleport(1,-8467.96,-4236.72,-208.443)
				end
					if (hplr6 ~= nil) then
				    hplr6:Teleport(1,-8467.96,-4236.72,-208.443)
					end
						if (hplr7 ~= nil) then
					    hplr7:Teleport(1,-8467.96,-4236.72,-208.443)
						end
							if (hplr8 ~= nil) then
							hplr8:Teleport(1,-8467.96,-4236.72,-208.443)
							end
								if (hplr9 ~= nil) then
								hplr9:Teleport(1,-8467.96,-4236.72,-208.443)
								end
									if (hplr10 ~= nil) then
									hplr10:Teleport(1,-8467.96,-4236.72,-208.443)
									end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--//////////////////////////////////////////////////////////////////////////Register Functions//////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
RegisterUnitGossipEvent(555998, 1, "HordeEventOnGossip")
RegisterUnitGossipEvent(555998, 2, "HordeEventSubMenu")
RegisterUnitGossipEvent(555999, 1, "AllyEventOnGossip")
RegisterUnitGossipEvent(555999, 2, "AllyEventSubMenu")
RegisterUnitEvent(555999, 18, "reg_instructor_chata")
RegisterUnitEvent(555998, 18, "reg_instructor_chath")
RegisterUnitEvent(555994, 18, "reg_sotarea1")
RegisterUnitEvent(555995, 18, "reg_sotarea2")
RegisterUnitEvent(555993, 18, "reg_sotarea2b")
RegisterUnitEvent(555996, 18, "reg_sotarea3")
RegisterUnitEvent(555997, 18, "reg_sotarea4")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------