--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas

--Defines
winnerwon = 0
plr1 = 0
plr2 = 0
plr3 = 0
plr4 = 0
plr5 = 0
plr6 = 0
plr7 = 0
plr8 = 0
plr9 = 0
plr10 = 0
msgplr = "You can join the Race of Mount Hyjal now!"
ready = 0
race_times = 0
race_ends = 0
winnercount = 0
winners = ""
------------

-----------------------------------------------------------------Gossip Functions--------------------------------------------------------------------------------
function EnterRace(pUnit, Event)
local plr = pMisc
if (ready == 0) then
if (plr ~= plr1) and (plr ~= plr2) and (plr ~= plr3) and (plr ~= plr4) and (plr ~= plr5) and (plr ~= plr6) and (plr ~= plr7) and (plr ~= plr8) and (plr ~= plr9) and (plr ~= plr10) then
if (plr ~= nil) then
	if (plr1 == 0) then
	plr1 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 1!", plr:GetName())
	elseif (plr2 == 0) then
	plr2 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 2!", plr:GetName())
	elseif (plr3 == 0) then
	plr3 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 3!", plr:GetName())
	elseif (plr4 == 0) then
	plr4 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 4!", plr:GetName())
	elseif (plr5 == 0) then
	plr5 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 5!", plr:GetName())
	elseif (plr6 == 0) then
	plr6 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 6!", plr:GetName())
	elseif (plr7 == 0) then
	plr7 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 7!", plr:GetName())
	elseif (plr8 == 0) then
	plr8 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 8!", plr:GetName())
	elseif (plr9 == 0) then
	plr9 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 9!", plr:GetName())
	elseif (plr10 == 0) then
	plr10 = plr
	msgplr = string.format("%s has joined the Race of Mount Hyjal at place 10!", plr:GetName())
	else
	msgplr = "You can't join the race at the moment, it's full already!"
	end
end
else
msgplr = string.format("%s, you have already joined the race!", plr:GetName())
end
elseif (ready == 1) then
msgplr = "The Race is about to begin, you can't join now!"
elseif (ready == 2) then
msgplr = "The Race has already started, you can't join now!"
end
end

function RaceOnGossip(unit, event, player)
	RaceMenu(unit, player)
end

function RaceMenu(unit, player)
	unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(4, "Join the Race for Mount Hyjal", 1, 0)
	unit:GossipMenuAddItem(4, "I want to see the list of today's winners", 2, 0)
	unit:GossipSendMenu(player)
end

function RaceSubMenu(unit, event, player, id, intid, code)
	if(intid == 1) then
		unit:RegisterEvent("EnterRace",10,1)
		pMisc = player
		player:GossipComplete()
	end
	---------
	if(intid == 2) then
		unit:GossipCreateMenu(99, player, 0)
		if winnercount ~= 0 then
		wnnrs = string.format("There are %s winners today: %s.", winnercount, winners)
		unit:GossipMenuAddItem(5, wnnrs, 3, 0)
		unit:GossipMenuAddItem(5, "[Back]", 50, 0)
		else
		unit:GossipMenuAddItem(5, "No-one has won yet today.", 3, 0)
		unit:GossipMenuAddItem(5, "[Back]", 50, 0)
		end
		unit:GossipSendMenu(player)
	end
	---------
	if(intid == 3) then
		player:GossipComplete()
	end
	---------
	if(intid == 50) then
		RaceMenu(unit, player)
	end
end
-----------------------------------------------------------------End Gameobject Functions--------------------------------------------------------------------------------

-----------------------------------------------------------------Check if Ready Function--------------------------------------------------------------------------------
function root_players(pUnit, Event)
if (ready == 1) then
	if ((plr1:GetX() < 4622.45) or (plr1:GetX() > 4622.46)) and ((plr1:GetY() < -3838.05) or (plr1:GetY() > -3838.06)) then
	plr1:Teleport(1,4622.46,-3838.05,943.745)
	end
	if ((plr2:GetX() < 4623.50) or (plr2:GetX() > 4623.51)) and ((plr2:GetY() < -3838.93) or (plr2:GetY() > -3838.94)) then
	plr2:Teleport(1,4623.51,-3838.94,943.666)
	end
	if ((plr3:GetX() < 4624.68) or (plr3:GetX() > 4624.69)) and ((plr3:GetY() < -3839.92) or (plr3:GetY() > -3839.93)) then
	plr3:Teleport(1,4624.68,-3839.93,943.674)
	end
	if (plr4 ~= 0) then
	if ((plr4:GetX() < 4625.95) or (plr4:GetX() > 4625.96)) and ((plr4:GetY() < -3841.02) or (plr4:GetY() > -3841.03)) then
	plr4:Teleport(1,4625.95,-3841.02,943.689)
	end
		if (plr5 ~= 0) then
		if ((plr5:GetX() < 4627.41) or (plr5:GetX() > 4627.42)) and ((plr5:GetY() < -3842.26) or (plr5:GetY() > -3842.27)) then
		plr5:Teleport(1,4627.42,-3842.26,943.709)
		end
			if (plr6 ~= 0) then
			if ((plr6:GetX() < 4625.54) or (plr6:GetX() > 4625.55)) and ((plr6:GetY() < -3844.44) or (plr6:GetY() > -3844.45)) then
			plr6:Teleport(1,4625.55,-3844.45,943.789)
			end
				if (plr7 ~= 0) then
				if ((plr7:GetX() < 4624.47) or (plr7:GetX() > 4624.48)) and ((plr7:GetY() < -3843.53) or (plr7:GetY() > -3843.54)) then
				plr7:Teleport(1,4624.47,-3843.53,943.778)
				end
					if (plr8 ~= 0) then
					if ((plr8:GetX() < 4623.16) or (plr8:GetX() > 4623.17)) and ((plr8:GetY() < -3842.41) or (plr8:GetY() > -3842.42)) then
					plr8:Teleport(1,4623.17,-3842.42,943.765)
					end
						if (plr9 ~= 0) then
						if ((plr9:GetX() < 4622.00) or (plr9:GetX() > 4622.01)) and ((plr9:GetY() < -3841.42) or (plr9:GetY() > -3841.43)) then
						plr9:Teleport(1,4622,-3841.43,943.753)
						end
							if (plr10 ~= 0) then
							if ((plr10:GetX() < 4620.89) or (plr10:GetX() > 4620.90)) and ((plr10:GetY() < -3840.47) or (plr10:GetY() > -3840.48)) then
							plr10:Teleport(1,4620.89,-3840.48,943.793)
							end
							end
						end
					end
				end
			end
		end
	end
end
end

function ready_check(pUnit, Event) --10002534: Race Starter
if (ready == 0) and (plr1 ~= 0) and (plr2 ~= 0) and (plr3 ~= 0) then
	ready = 1
	msgplr2 = "The Race starts in 1 minute, get ready!"
		pUnit:RegisterEvent("tirthysec",30000,1)
		pUnit:RegisterEvent("twentysec",40000,1)
		pUnit:RegisterEvent("tensec",50000,1)
		pUnit:RegisterEvent("ninesec",51000,1)
		pUnit:RegisterEvent("eightsec",52000,1)
		pUnit:RegisterEvent("sevensec",53000,1)
		pUnit:RegisterEvent("sixsec",54000,1)
		pUnit:RegisterEvent("fivesec",55000,1)
		pUnit:RegisterEvent("foursec",56000,1)
		pUnit:RegisterEvent("threesec",57000,1)
		pUnit:RegisterEvent("twosec",58000,1)
		pUnit:RegisterEvent("onesec",59000,1)
		pUnit:RegisterEvent("gogogo",60000,1)
	plr1:Teleport(1,4622.46,-3838.05,943.745)
	plr2:Teleport(1,4623.51,-3838.94,943.666)
	plr3:Teleport(1,4624.68,-3839.93,943.674)
	if (plr4 ~= 0) then
	plr4:Teleport(1,4625.95,-3841.02,943.689)
		if (plr5 ~= 0) then
		plr5:Teleport(1,4627.42,-3842.26,943.709)
			if (plr6 ~= 0) then
			plr6:Teleport(1,4625.55,-3844.45,943.789)
				if (plr7 ~= 0) then
				plr7:Teleport(1,4624.47,-3843.53,943.778)
					if (plr8 ~= 0) then
					plr8:Teleport(1,4623.17,-3842.42,943.765)
						if (plr9 ~= 0) then
						plr9:Teleport(1,4622,-3841.43,943.753)
							if (plr10 ~= 0) then
							plr10:Teleport(1,4620.89,-3840.48,943.793)
							end
						end
					end
				end
			end
		end
	end
end
end
-----------------------------------------------------------------End Check if Ready Function--------------------------------------------------------------------------------


-----------------------------------------------------------------Chat Functions--------------------------------------------------------------------------------
function tirthysec(pUnit, Event) --10002534: Race Starter
msgplr2 = "30 Seconds left, get ready!!"
end

function twentysec(pUnit, Event) --10002534: Race Starter
msgplr2 = "20 Seconds left, get ready!!"
end

function tensec(pUnit, Event) --10002534: Race Starter
msgplr2 = "10 Seconds left, get ready!!"
end
function ninesec(pUnit, Event) --10002534: Race Starter
msgplr2 = "9"
end
function eightsec(pUnit, Event) --10002534: Race Starter
msgplr2 = "8"
end
function sevensec(pUnit, Event) --10002534: Race Starter
msgplr2 = "7"
end
function sixsec(pUnit, Event) --10002534: Race Starter
msgplr2 = "6"
end
function fivesec(pUnit, Event) --10002534: Race Starter
msgplr2 = "5"
end
function foursec(pUnit, Event) --10002534: Race Starter
msgplr2 = "4"
end
function threesec(pUnit, Event) --10002534: Race Starter
msgplr2 = "3"
end
function twosec(pUnit, Event) --10002534: Race Starter
msgplr2 = "2"
end
function onesec(pUnit, Event) --10002534: Race Starter
msgplr2 = "1"
end
function gogogo(pUnit, Event) --10002534: Race Starter
msgplr2 = "GOOOOOOO!!!!"
ready = 2
pUnit:PlaySoundToSet(11803)
pUnit:RegisterEvent("race_reset", 900000, 1)
race_times = race_times + 1
end
------------------
function instructor_chat(pUnit, Event) --10002535: Race Instructor
if (msgplr ~= msgplrb) then
	pUnit:SendChatMessage(12,0,msgplr)
	msgplrb = msgplr
end
end

function starter_chat(pUnit, Event) --10002534: Race Starter
if (msgplr2 ~= msgplrc) then
	pUnit:SendChatMessage(12,0,msgplr2)
	msgplrc = msgplr2
end
end

function reg_starter_chat(pUnit, Event) --10002534: Race Starter
pUnit:RegisterEvent("starter_chat",10,0)
pUnit:RegisterEvent("ready_check",120000,0)
pUnit:RegisterEvent("root_players",10,0)
end

function reg_instructor_chat(pUnit, Event) --10002535: Race Instructor
pUnit:RegisterEvent("instructor_chat",10,0)
end
-----------------------------------------------------------------End Chat Functions--------------------------------------------------------------------------------


------------------------------------------Race Finish-----------------------------------------
function announce_winner(pUnit, Event)
pUnit:SendChatMessage(14,0,msg)
end

function winner(pUnit, Event) --10002529: Race Referee
if (ready == 2) then
if plr1 ~= 0 then
if ((plr1:GetY() < -2762.74) and (plr1:GetY() > -2773) and (plr1:GetX() < 5482) and (plr1:GetX() > 5471)) then
plrrce = plr1
end
end
if plr2 ~= 0 then
if ((plr2:GetY() < -2762.74) and (plr2:GetY() > -2773) and (plr2:GetX() < 5482) and (plr2:GetX() > 5471)) then
plrrce = plr2
end
end
if plr3 ~= 0 then
if ((plr3:GetY() < -2762.74) and (plr3:GetY() > -2773) and (plr3:GetX() < 5482) and (plr3:GetX() > 5471)) then
plrrce = plr3
end
end
if plr4 ~= 0 then
if ((plr4:GetY() < -2762.74) and (plr4:GetY() > -2773) and (plr4:GetX() < 5482) and (plr4:GetX() > 5471)) then
plrrce = plr4
end
end
if plr5 ~= 0 then
if ((plr5:GetY() < -2762.74) and (plr5:GetY() > -2773) and (plr5:GetX() < 5482) and (plr5:GetX() > 5471)) then
plrrce = plr5
end
end
if plr6 ~= 0 then
if ((plr6:GetY() < -2762.74) and (plr6:GetY() > -2773) and (plr6:GetX() < 5482) and (plr6:GetX() > 5471)) then
plrrce = plr6
end
end
if plr7 ~= 0 then
if ((plr7:GetY() < -2762.74) and (plr7:GetY() > -2773) and (plr7:GetX() < 5482) and (plr7:GetX() > 5471)) then
plrrce = plr7
end
end
if plr8 ~= 0 then
if ((plr8:GetY() < -2762.74) and (plr8:GetY() > -2773) and (plr8:GetX() < 5482) and (plr8:GetX() > 5471)) then
plrrce = plr8
end
end
if plr9 ~= 0 then
if ((plr9:GetY() < -2762.74) and (plr9:GetY() > -2773) and (plr9:GetX() < 5482) and (plr9:GetX() > 5471)) then
plrrce = plr9
end
end
if plr10 ~= 0 then
if ((plr10:GetY() < -2762.74) and (plr10:GetY() > -2773) and (plr10:GetX() < 5482) and (plr10:GetX() > 5471)) then
plrrce = plr10
end
end
if (plrrce ~= nil) then
if ((plrrce:GetY() < -2762.74) and (plrrce:GetY() > -2773) and (plrrce:GetX() < 5482) and (plrrce:GetX() > 5471)) then
		if winnerwon == 0 then
			winnerwon = 1
			plrrce:AddItem(70063,2)
			plrrce:AddItem(70087,1)
			if winnercount == 0 then
			winners = string.format("%s", plrrce:GetName())
			else
			winners = string.format("%s, %s", winners, plrrce:GetName())
			end
			winnercount = winnercount + 1
			msg = string.format("%s won the race of Mount Hyjal!", plrrce:GetName())
			pUnit:SendChatMessage(14,0,msg)
			pUnit:RegisterEvent("announce_winner", 10000, 1)
			xje = plrrce:GetX()
			yje = plrrce:GetY()
			zje = plrrce:GetZ()
			plr1:Teleport(1,xje,yje,zje)
			plr1:AddItem(70087,1)
			plr2:Teleport(1,xje,yje,zje)
			plr2:AddItem(70087,1)
			plr3:Teleport(1,xje,yje,zje)
			plr3:AddItem(70087,1)
			if (plr4 ~= 0) then
			plr4:Teleport(1,xje,yje,zje)
			plr4:AddItem(70087,1)
				if (plr5 ~= 0) then
				plr5:Teleport(1,xje,yje,zje)
				plr5:AddItem(70087,1)
					if (plr6 ~= 0) then
					plr6:Teleport(1,xje,yje,zje)
					plr6:AddItem(70087,1)
						if (plr7 ~= 0) then
						plr7:Teleport(1,xje,yje,zje)
						plr7:AddItem(70087,1)
							if (plr8 ~= 0) then
							plr8:Teleport(1,xje,yje,zje)
							plr8:AddItem(70087,1)
								if (plr9 ~= 0) then
								plr9:Teleport(1,xje,yje,zje)
								plr9:AddItem(70087,1)
									if (plr10 ~= 0) then
									plr10:Teleport(1,xje,yje,zje)
									plr10:AddItem(70087,1)
									end
								end
							end
						end
					end
				end
			end
			--Fireworks Display
				--1st
				pUnit:SpawnGameObject(180861, 5465, -2770.48, 1458.98, 5.82137, 1000) --blue
				pUnit:SpawnGameObject(180860, 5483.82, -2773.32, 1458.7, 3.17144, 1000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 1000) --blue
				pUnit:SpawnGameObject(180860, 5461.86, -2771.84, 1459.21, 5.95332, 1000) --red
				pUnit:SpawnGameObject(180861, 5463.05, -2776.82, 1459.79, 6.18894, 1000) --blue
				pUnit:SpawnGameObject(180861, 5465, -2770.48, 1458.98, 5.82137, 1000) --blue
				pUnit:SpawnGameObject(180860, 5483.82, -2773.32, 1458.7, 3.17144, 1000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 1000) --blue
				pUnit:SpawnGameObject(180860, 5461.86, -2771.84, 1459.21, 5.95332, 1000) --red
				pUnit:SpawnGameObject(180861, 5463.05, -2776.82, 1459.79, 6.18894, 1000) --blue
				--2nd
				pUnit:SpawnGameObject(180862, 5463.21, -2769.59, 1458.92, 5.82137, 3000) --green
				pUnit:SpawnGameObject(180864, 5462.55, -2774.18, 1459.48, 4.56788, 3000) --white
				pUnit:SpawnGameObject(180865, 5478.92, -2777.24, 1459.44, 5.90148, 3000) --yellow
				pUnit:SpawnGameObject(180864, 5482.85, -2777.73, 1459.44, 3.1683, 3000) --white
				pUnit:SpawnGameObject(180862, 5485.35, -2772.03, 1458.47, 3.84688, 3000) --green
				pUnit:SpawnGameObject(180862, 5463.21, -2769.59, 1458.92, 5.82137, 3000) --green
				pUnit:SpawnGameObject(180864, 5462.55, -2774.18, 1459.48, 4.56788, 3000) --white
				pUnit:SpawnGameObject(180865, 5478.92, -2777.24, 1459.44, 5.90148, 3000) --yellow
				pUnit:SpawnGameObject(180864, 5482.85, -2777.73, 1459.44, 3.1683, 3000) --white
				pUnit:SpawnGameObject(180862, 5485.35, -2772.03, 1458.47, 3.84688, 3000) --green
				--3th
				pUnit:SpawnGameObject(180861, 5465, -2770.48, 1458.98, 5.82137, 6000) --blue
				pUnit:SpawnGameObject(180860, 5483.82, -2773.32, 1458.7, 3.17144, 6000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 6000) --blue
				pUnit:SpawnGameObject(180860, 5461.86, -2771.84, 1459.21, 5.95332, 6000) --red
				pUnit:SpawnGameObject(180861, 5463.05, -2776.82, 1459.79, 6.18894, 6000) --blue
				pUnit:SpawnGameObject(180861, 5465, -2770.48, 1458.98, 5.82137, 6000) --blue
				pUnit:SpawnGameObject(180860, 5483.82, -2773.32, 1458.7, 3.17144, 6000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 6000) --blue
				pUnit:SpawnGameObject(180860, 5461.86, -2771.84, 1459.21, 5.95332, 6000) --red
				pUnit:SpawnGameObject(180861, 5463.05, -2776.82, 1459.79, 6.18894, 6000) --blue
				--4th
				pUnit:SpawnGameObject(180862, 5463.21, -2769.59, 1458.92, 5.82137, 9000) --green
				pUnit:SpawnGameObject(180864, 5462.55, -2774.18, 1459.48, 4.56788, 9000) --white
				pUnit:SpawnGameObject(180865, 5478.92, -2777.24, 1459.44, 5.90148, 9000) --yellow
				pUnit:SpawnGameObject(180864, 5482.85, -2777.73, 1459.44, 3.1683, 9000) --white
				pUnit:SpawnGameObject(180862, 5485.35, -2772.03, 1458.47, 3.84688, 9000) --green
				pUnit:SpawnGameObject(180862, 5463.21, -2769.59, 1458.92, 5.82137, 9000) --green
				pUnit:SpawnGameObject(180864, 5462.55, -2774.18, 1459.48, 4.56788, 9000) --white
				pUnit:SpawnGameObject(180865, 5478.92, -2777.24, 1459.44, 5.90148, 9000) --yellow
				pUnit:SpawnGameObject(180864, 5482.85, -2777.73, 1459.44, 3.1683, 9000) --white
				pUnit:SpawnGameObject(180862, 5485.35, -2772.03, 1458.47, 3.84688, 9000) --green
				--5th
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 12000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 12000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 12000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 12000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 12000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 12000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 12000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 12000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 12000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 12000) --yellow
				--6th
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 15000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 15000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 15000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 15000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 15000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 15000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 15000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 15000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 15000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 15000) --yellow
				--7th
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 18000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 18000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 18000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 18000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 18000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 18000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 18000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 18000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 18000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 18000) --yellow
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 18000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 18000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 18000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 18000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 18000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 18000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 18000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 18000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 18000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 18000) --yellow
				--8th
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 21000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 21000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 21000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 21000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 21000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 21000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 21000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 21000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 21000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 21000) --yellow
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 21000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 21000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 21000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 21000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 21000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 21000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 21000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 21000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 21000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 21000) --yellow
				--9th
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 24000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 24000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 24000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 24000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 24000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 24000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 24000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 24000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 24000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 24000) --yellow
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 24000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 24000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 24000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 24000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 24000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 24000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 24000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 24000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 24000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 24000) --yellow
				--10th
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 27000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 27000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 27000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 27000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 27000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 27000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 27000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 27000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 27000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 27000) --yellow
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 27000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 27000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 27000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 27000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 27000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 27000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 27000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 27000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 27000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 27000) --yellow
				--11th
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 30000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 30000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 30000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 30000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 30000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 30000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 30000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 30000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 30000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 30000) --yellow
				pUnit:SpawnGameObject(180860, 5465, -2770.48, 1458.98, 5.82137, 30000) --red
				pUnit:SpawnGameObject(180861, 5463.21, -2769.59, 1458.92, 5.82137, 30000) --blue
				pUnit:SpawnGameObject(180862, 5462.55, -2774.18, 1459.48, 4.56788, 30000) --green
				pUnit:SpawnGameObject(180864, 5483.82, -2773.32, 1458.7, 3.17144, 30000) --white
				pUnit:SpawnGameObject(180865, 5485.35, -2772.03, 1458.47, 3.84688, 30000) --yellow
				pUnit:SpawnGameObject(180860, 5482.85, -2777.73, 1459.44, 3.1683, 30000) --red
				pUnit:SpawnGameObject(180861, 5484.85, -2775.07, 1459.01, 4.26471, 30000) --blue
				pUnit:SpawnGameObject(180862, 5478.92, -2777.24, 1459.44, 5.90148, 30000) --green
				pUnit:SpawnGameObject(180864, 5461.86, -2771.84, 1459.21, 5.95332, 30000) --white
				pUnit:SpawnGameObject(180865, 5463.05, -2776.82, 1459.79, 6.18894, 30000) --yellow
			pUnit:RegisterEvent("race_reset",1,1) --reset the race
		end
end
end
end
end

function reg_winner(pUnit) --10002529: Race Referee
pUnit:RegisterEvent("winner",10,0)
end

function race_reset(pUnit) --10002529: Race Referee
if (race_times - 1) == race_ends then
ready = 0
winnerwon = 0
plrrce = nil
plr1 = 0
plr2 = 0
plr3 = 0
plr4 = 0
plr5 = 0
plr6 = 0
plr7 = 0
plr8 = 0
plr9 = 0
plr10 = 0
msgplr = "You can join the Race of Mount Hyjal now!"
race_ends = race_ends + 1
end
end
------------------------------------------End Race Finish-----------------------------------------


----------------------Register Events----------------------
RegisterUnitGossipEvent(10002535, 1, "RaceOnGossip")
RegisterUnitGossipEvent(10002535, 2, "RaceSubMenu")
RegisterUnitEvent(10002534, 18, "reg_starter_chat")
RegisterUnitEvent(10002535, 18, "reg_instructor_chat")
RegisterUnitEvent(10002529, 18, "reg_winner")
-------------------------------------------------------------

function Teleporting_onUse22 (pUnit, Event, pMisc)
   pMisc:Teleport (1,4580.61,-3921.23,943.982)
  end
RegisterGameObjectEvent (5000028, 4, "Teleporting_onUse22")

