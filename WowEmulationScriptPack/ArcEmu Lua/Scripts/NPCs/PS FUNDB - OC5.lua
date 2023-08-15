--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas

timer1 = 0
timer2 = 0
timer3 = 0
timer4 = 0
timer5 = 0
timer6 = 0
timer7 = 0
timer8 = 0
timer9 = 0
timer10 = 0

function oc5_start(pUnit, Event, pMisc)
if (pMisc ~= dlnmr1) and (pMisc ~= dlnmr2) and (pMisc ~= dlnmr3) and (pMisc ~= dlnmr4) and (pMisc ~= dlnmr5) and (pMisc ~= dlnmr6) and (pMisc ~= dlnmr7) and (pMisc ~= dlnmr8) and (pMisc ~= dlnmr9) and (pMisc ~= dlnmr10) then
if dlnmr1 ~= pMisc and dlnmr1 == nil then
dlnmr1 = pMisc
dlnmr1nm = dlnmr1:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the first player", pMisc:GetName())
elseif dlnmr2 ~= pMisc and dlnmr2 == nil then
dlnmr2 = pMisc
dlnmr2nm = dlnmr2:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the second player", pMisc:GetName())
elseif dlnmr3 ~= pMisc and dlnmr3 == nil then
dlnmr3 = pMisc
dlnmr3nm = dlnmr3:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the third player", pMisc:GetName())
elseif dlnmr4 ~= pMisc and dlnmr4 == nil then
dlnmr4 = pMisc
dlnmr4nm = dlnmr4:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the fourth player", pMisc:GetName())
elseif dlnmr5 ~= pMisc and dlnmr5 == nil then
dlnmr5 = pMisc
dlnmr5nm = dlnmr5:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the fifth player", pMisc:GetName())
elseif dlnmr6 ~= pMisc and dlnmr6 == nil then
dlnmr6 = pMisc
dlnmr6nm = dlnmr6:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the sixth player", pMisc:GetName())
elseif dlnmr7 ~= pMisc and dlnmr7 == nil then
dlnmr7 = pMisc
dlnmr7nm = dlnmr7:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the seventh player", pMisc:GetName())
elseif dlnmr8 ~= pMisc and dlnmr8 == nil then
dlnmr8 = pMisc
dlnmr8nm = dlnmr8:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the eighth player", pMisc:GetName())
elseif dlnmr9 ~= pMisc and dlnmr9 == nil then
dlnmr9 = pMisc
dlnmr9nm = dlnmr9:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the ninth player", pMisc:GetName())
elseif dlnmr10 ~= pMisc and dlnmr10 == nil then
dlnmr10 = pMisc
dlnmr10nm = dlnmr10:GetName()
chatmsg = string.format("%s, you have joined Obstacle Course 5, you're the tenth player", pMisc:GetName())
else
chatmsg = string.format("10 Players have already joined the Obstacle Course, you'll need to wait till one of them leaves %s!", pMisc:GetName())
end
else
chatmsg = string.format("You have already joined Obstacle Course 5 %s!", pMisc:GetName())
end
end
RegisterGameObjectEvent(5000056, 4, "oc5_start")

function oc5_chat(pUnit, Event)
if chatmsg ~= chatmsg2 then
pUnit:SendChatMessage(12, 0, chatmsg)
chatmsg2 = chatmsg
end
	if chatmsg_kick ~= chatmsg_kick3 then
	pUnit:SendChatMessage(14, 0, chatmsg_kick)
	chatmsg_kick3 = chatmsg_kick
	end
end

function reg_oc5_chat(pUnit, Event)
pUnit:RegisterEvent("oc5_chat",10,0)
pUnit:RegisterEvent("OC5_Timer", 1000, 0)
end
RegisterUnitEvent(10002648, 18, "reg_oc5_chat")

function OC5_Timer(pUnit, Event)
if dlnmr1 ~= nil then
timer1 = timer1 + 1
	if timer1 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr1nm)
	dlnmr1 = nil
	timer1 = 0
	end
else
timer1 = 0
end
if dlnmr2 ~= nil then
timer2 = timer2 + 1
	if timer2 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr2nm)
	dlnmr2 = nil
	timer2 = 0
	end
else
timer2 = 0
end
if dlnmr3 ~= nil then
timer3 = timer3 + 1
	if timer3 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr3nm)
	dlnmr3 = nil
	timer3 = 0
	end
else
timer3 = 0
end
if dlnmr4 ~= nil then
timer4 = timer4 + 1
	if timer4 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr4nm)
	dlnmr4 = nil
	timer4 = 0
	end
else
timer4 = 0
end
if dlnmr5 ~= nil then
timer5 = timer5 + 1
	if timer5 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr5nm)
	dlnmr5 = nil
	timer5 = 0
	end
else
timer5 = 0
end
if dlnmr6 ~= nil then
timer6 = timer6 + 1
	if timer6 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr6nm)
	dlnmr6 = nil
	timer6 = 0
	end
else
timer6 = 0
end
if dlnmr7 ~= nil then
timer7 = timer7 + 1
	if timer7 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr7nm)
	dlnmr7 = nil
	timer7 = 0
	end
else
timer7 = 0
end
if dlnmr8 ~= nil then
timer8 = timer8 + 1
	if timer8 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr8nm)
	dlnmr8 = nil
	timer8 = 0
	end
else
timer8 = 0
end
if dlnmr9 ~= nil then
timer9 = timer9 + 1
	if timer9 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr9nm)
	dlnmr9 = nil
	timer9 = 0
	end
else
timer9 = 0
end
if dlnmr10 ~= nil then
timer10 = timer10 + 1
	if timer10 > 900 then
	chatmsg_kick = string.format("%s has been kicked from OC5. Reason: Taking more than 15 minutes to complete it.", dlnmr10nm)
	dlnmr10 = nil
	timer10 = 0
	end
else
timer10 = 0
end
end

function OC_5_finish(pUnit, Event, pMisc)
if dlnmr1 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer1
dlnmr1 = nil
timer1 = 0
elseif dlnmr2 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer2
dlnmr2 = nil
timer2 = 0
elseif dlnmr3 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer3
dlnmr3 = nil
timer3 = 0
elseif dlnmr4 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer4
dlnmr4 = nil
timer4 = 0
elseif dlnmr5 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer5
dlnmr5 = nil
timer5 = 0
elseif dlnmr6 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer6
dlnmr6 = nil
timer6 = 0
elseif dlnmr7 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer7
dlnmr7 = nil
timer7 = 0
elseif dlnmr8 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer8
dlnmr8 = nil
timer8 = 0
elseif dlnmr9 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer9
dlnmr9 = nil
timer9 = 0
elseif dlnmr10 == pMisc then
rwrd_plr = pMisc
rwrd_time = timer10
dlnmr10 = nil
timer10 = 0
else
chatmsg_end = "You haven't joined OC 5! Go back to the start and join."
end
end
RegisterGameObjectEvent(5000077, 4, "OC_5_finish")

function OC5_reward(pUnit, Event)
	if rwrd_plr ~= nil and rwrd_time ~= nil then
	rwrd_seconds = rwrd_time % 60
	rwrd_minutes = math.floor(rwrd_time/60)
	chatmsg_end = string.format("%s, you have completed Obstacle Course 5 in %s minutes and %s seconds!", rwrd_plr:GetName(), rwrd_minutes, rwrd_seconds)
	chatmsg = string.format("%s has completed Obstacle Course 5 in %s minutes and %s seconds!", rwrd_plr:GetName(), rwrd_minutes, rwrd_seconds)
		if rwrd_time < 300 then
		rwrd_plr:AddItem(70086, 1)
		rwrd_plr:AddItem(70087, 3)
		elseif rwrd_time < 480 then
		rwrd_plr:AddItem(70085, 1)
		rwrd_plr:AddItem(70087, 2)
		else
		rwrd_plr:AddItem(70033, 3)
		rwrd_plr:AddItem(70087, 1)
		end
	rwrd_plr = nil
	rwrd_time = nil
	end
	
	if chatmsg_end ~= chatmsg_end2 then
	pUnit:SendChatMessage(12, 0, chatmsg_end)
	chatmsg_end2 = chatmsg_end
	end
	if chatmsg_kick ~= chatmsg_kick2 then
	pUnit:SendChatMessage(14, 0, chatmsg_kick)
	chatmsg_kick2 = chatmsg_kick
	end
end

function reg_OC5_reward(pUnit, Event)
pUnit:RegisterEvent("OC5_reward",10,0)
end
RegisterUnitEvent(10002649, 18, "reg_OC5_reward")

--/////////////////////////////////////////////// Portal to leave /////////////////////////////////////////--
function leave_oc5(pUnit, Event, pMisc)
if dlnmr1 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr1 = nil
timer1 = 0
elseif dlnmr2 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr2 = nil
timer2 = 0
elseif dlnmr3 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr3 = nil
timer3 = 0
elseif dlnmr4 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr4 = nil
timer4 = 0
elseif dlnmr5 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr5 = nil
timer5 = 0
elseif dlnmr6 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr6 = nil
timer6 = 0
elseif dlnmr7 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr7 = nil
timer7 = 0
elseif dlnmr8 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr8 = nil
timer8 = 0
elseif dlnmr9 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr9 = nil
timer9 = 0
elseif dlnmr10 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr10 = nil
timer10 = 0
end
pMisc:Teleport (1,-8467.96,-4236.72,-208.443)
end
RegisterGameObjectEvent(5000081, 4, "leave_oc5")

function Teleporting_onUse31 (pUnit, Event, pMisc)
if dlnmr1 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr1 = nil
timer1 = 0
elseif dlnmr2 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr2 = nil
timer2 = 0
elseif dlnmr3 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr3 = nil
timer3 = 0
elseif dlnmr4 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr4 = nil
timer4 = 0
elseif dlnmr5 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr5 = nil
timer5 = 0
elseif dlnmr6 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr6 = nil
timer6 = 0
elseif dlnmr7 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr7 = nil
timer7 = 0
elseif dlnmr8 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr8 = nil
timer8 = 0
elseif dlnmr9 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr9 = nil
timer9 = 0
elseif dlnmr10 == pMisc then
chatmsg = string.format("%s has left Obstacle Course 5", pMisc:GetName())
dlnmr10 = nil
timer10 = 0
end
pMisc:Teleport (1, 8078.52, -4854.72, 984.768)
end
RegisterGameObjectEvent (5000047, 4, "Teleporting_onUse31")

function plr_time(pUnit, Event, pMisc)
if dlnmr1 == pMisc then
	sec1 = timer1 % 60
	min1 = math.floor(timer1/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr1:GetName(), min1, sec1)
elseif dlnmr2 == pMisc then
	sec2 = timer2 % 60
	min2 = math.floor(timer2/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr2:GetName(), min2, sec2)
elseif dlnmr3 == pMisc then
	sec3 = timer3 % 60
	min3 = math.floor(timer3/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr3:GetName(), min3, sec3)
elseif dlnmr4 == pMisc then
	sec4 = timer4 % 60
	min4 = math.floor(timer4/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr4:GetName(), min4, sec4)
elseif dlnmr5 == pMisc then
	sec5 = timer5 % 60
	min5 = math.floor(timer5/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr5:GetName(), min5, sec5)
elseif dlnmr6 == pMisc then
	sec6 = timer6 % 60
	min6 = math.floor(timer6/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr6:GetName(), min6, sec6)
elseif dlnmr7 == pMisc then
	sec7 = timer7 % 60
	min7 = math.floor(timer7/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr7:GetName(), min7, sec7)
elseif dlnmr8 == pMisc then
	sec8 = timer8 % 60
	min8 = math.floor(timer8/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr8:GetName(), min8, sec8)
elseif dlnmr9 == pMisc then
	sec9 = timer9 % 60
	min9 = math.floor(timer9/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr9:GetName(), min9, sec9)
elseif dlnmr10 == pMisc then
	sec10 = timer10 % 60
	min10 = math.floor(timer10/60)
	chatmsg_time = string.format("%s, you have been trying for %s minutes and %s seconds now.", dlnmr10:GetName(), min10, sec10)
end
end
RegisterGameObjectEvent(5000082, 4, "plr_time")

function plr_timer(pUnit, Event)
	if chatmsg_time ~= chatmsg_time2 then
	pUnit:SendChatMessage(14, 0, chatmsg_time)
	chatmsg_time2 = chatmsg_time
	end
end

function reg_plr_timer(pUnit, Event)
pUnit:RegisterEvent("plr_timer", 1000, 0)
end
RegisterUnitEvent(10002655, 18, "reg_plr_timer")