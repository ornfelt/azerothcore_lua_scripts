--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas
RegisterUnitGossipEvent(10002683 , 1, "staff_talk")
RegisterUnitGossipEvent(10002683 , 2, "staff_select")

function staff_talk(pUnit, event, player)
	StaffMainMenu(pUnit, player)
end

function StaffMainMenu(pUnit, player)
pUnit:GossipCreateMenu(1000, player, 0)
pUnit:GossipMenuAddItem(5, "Start an Event", 1, 0)
pUnit:GossipMenuAddItem(2, "Give me our staff gear", 2, 1)
--[[if (player:GetFaction() ~= 1634) then
pUnit:GossipMenuAddItem(0, "Make me hostile", 3, 1)
else
pUnit:GossipMenuAddItem(0, "Make me friendly again", 4, 1)
end]]--
--pUnit:GossipMenuAddItem(0, "", 5, 0)
--pUnit:GossipMenuAddItem(0, "", 6, 0)
--pUnit:GossipMenuAddItem(0, "", 7, 0)
pUnit:GossipSendMenu(player)
end

--////// Start an Event //////--
function staff_select(pUnit, event, player, id, intid, code)
if(intid == 1) then
pUnit:GossipCreateMenu(3542, player, 0)

if(org_started == 0) then
pUnit:GossipMenuAddItem(5, "Orgrimmar Fireworks Display", 101, 1)
else
pUnit:GossipMenuAddItem(5, "(Started) Orgrimmar Fireworks Display", 101, 1)
end

if (sw_started == 0) then
pUnit:GossipMenuAddItem(5, "Stormwind Fireworks Display", 102, 1)
else
pUnit:GossipMenuAddItem(5, "(Started) Stormwind Fireworks Display", 102, 1)
end

if (started == 0) then
pUnit:GossipMenuAddItem(5, "Easter Egg Hunt (Moonglade)", 108, 1)
else
pUnit:GossipMenuAddItem(5, "(Started) Easter Egg Hunt (Moonglade)", 108, 1)
end

--pUnit:GossipMenuAddItem(5, "Scourge Invasion (Undercity)", 103, 1)

if(IF_started == 0) then
pUnit:GossipMenuAddItem(5, "Scourge Invasion (Ironforge)", 104, 1)
else
pUnit:GossipMenuAddItem(5, "(Started) Scourge Invasion (Ironforge)", 104, 1)
end

pUnit:GossipMenuAddItem(5, "Blizzlike Events", 105, 0)
pUnit:GossipSendMenu(player)
end

--////// Blizzlike Events //////--
if(intid == 105) then
pUnit:GossipCreateMenu(3543, player, 0)

if (lunar_event_0_started == 0 and lunar_event_1_started == 0) then
pUnit:GossipMenuAddItem(5, "Lunar Festival", 106, 1)
else
pUnit:GossipMenuAddItem(5, "(Started) Lunar Festival", 106, 1)
end

pUnit:GossipMenuAddItem(5, "Fire Festival (NYI)", 107, 0)
pUnit:GossipSendMenu(player)
end

--////// Add staff gear //////--
if(intid == 2) then
if(code == staffcode) then
player:LearnSpell(201)
player:AddItem(staffgear1, 1)
player:AddItem(staffgear2, 1)
player:AddItem(staffgear3, 1)
player:AddItem(staffgear4, 1)
player:AddItem(staffgear5, 1)
player:AddItem(staffgear6, 1)
player:AddItem(staffgear7, 1)
player:AddItem(staffgear8, 1)
player:AddItem(staffgear9, 1)
player:GossipComplete()
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Orgrimmar Fireworks //////--
if(intid == 101) then
if(code == staffcode) then
	if (org_started == 0) then
	org_started = 1
	pUnit:SendChatMessage(12, 0, "The Orgrimmar Fireworkshow has been started, it will last 15 minutes.")
	pUnit:SpawnGameObject(176499, player:GetX(), player:GetY(), player:GetZ(), 0, 600000)
	player:GossipComplete()
	else
	pUnit:SendChatMessage(14, 0, "The Orgrimmar Fireworkshow has already been started!")
	player:GossipComplete()
	end
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Stormwind Fireworks //////--
if(intid == 102) then
if(code == staffcode) then
	if (sw_started == 0) then
	sw_started = 1
	pUnit:SendChatMessage(12, 0, "The Stormwind Fireworkshow has been started, it will last 15 minutes.")
	pUnit:SpawnGameObject(176296, player:GetX(), player:GetY(), player:GetZ(), 0, 600000)
	player:GossipComplete()
	else
	pUnit:SendChatMessage(14, 0, "The Stormwind Fireworkshow has already been started!")
	player:GossipComplete()
	end
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Easter Egg Hunt (Moonglade) //////--
if(intid == 108) then
if(code == staffcode) then
if (started == 0) then
started = 1
pUnit:SendChatMessage(12,0,"The Easter Egg Event has been started, it will last one hour.")
pUnit:SpawnGameObject(5000038, player:GetX(), player:GetY(), player:GetZ(), 0, 600000)
player:GossipComplete()
else
pUnit:SendChatMessage(14,0,"The Easter Egg Event has already been started!")
player:GossipComplete()
end
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Undercity Scourge Invasion //////--
if(intid == 103) then
if(code == staffcode) then
--pUnit:RegisterEvent("", 2, 0)
player:GossipComplete()
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Ironforge Scourge Invasion //////--
if(intid == 104) then
if(code == staffcode) then
if(IF_started == 0) then
IF_started = 1
pUnit:SendChatMessage(12, 0, "The Ironforge Scourge Invasion has been started, it will last 1 hour.") --Message
pUnit:SpawnGameObject(176497, player:GetX(), player:GetY(), player:GetZ(), 0, 600000)
player:GossipComplete()
else
pUnit:SendChatMessage(14, 0, "The Ironforge Scourge Invasion has already been started!") --Message: already started
player:GossipComplete()
end
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Lunar Festival //////--
if(intid == 106) then
if(code == staffcode) then
if (lunar_event_0_started == 0 and lunar_event_1_started == 0) then
lunar_event_0_started = 1
lunar_event_1_started = 1
pUnit:SendChatMessage(12, 0, "The Lunar Festival has been started, it will last 3 hours.") --Message
player:GossipComplete()
else
pUnit:SendChatMessage(14, 0, "The Lunar Festival has already been started!") --Message: already started
player:GossipComplete()
end
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Make me hostile //////--
if(intid == 3) then
if(code == staffcode) then
player:SetFaction(1634)
player:GossipComplete()
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

--////// Make me friendly //////--
if(intid == 4) then
if(code == staffcode) then
player:SetFaction(35) 
player:GossipComplete()
else
pUnit:SendChatMessage(14,0, "Are you too pathetic to remember a basic password!?")
player:GossipComplete()
end
end

end
