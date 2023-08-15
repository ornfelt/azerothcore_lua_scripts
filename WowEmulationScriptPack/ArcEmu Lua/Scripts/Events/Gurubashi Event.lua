--[[--Arena Teleport
local MapID = 0
local XCoord = -13243.240234
local YCoord = 197.949799
local ZCoord = 32.112690

--Active
local activated = 0

--Message
local ON_MSG = "#on"
local OFF_MSG = "#off"

--PvP Buff Timer
local pvpbufftimer = math.random (1800000, 3600000)

function GurubashiEvent(unit, plr, event)
	if ((activated == 1) and (plr:IsGM() == true)) then
		local plrs = GetPlayersInWorld()
		for k, v in pairs(plrs) do
			if (v:IsAlive() == true) then
				v:Teleport(MapID, XCoord, YCoord, ZCoord)
			else
				v:SendAreaTriggerMessage("The event has started, ressurect quickly!")
			end
		end
	end
end
	
function Event_OnChat(event, plr, message, type, language)
	if(plr:IsGM() == true) then
		if (message == ON_MSG) then
			if (activated == 1) then
				plr:SendAreaTriggerMessage("The event is in progress!")
			else
				activate = 1
				local plrs = GetPlayersInWorld()
				for k, v in pairs(plrs) do
					v:SendAreaTriggerMessage("An event has been started!")
				end
			end
		elseif (message == OFF_MSG) then
			if (activated == 0) then
				plr:SendAreaTriggerMessage("This is already off!")
			else
				activate = 0
			end
		end
	end
end

function Gurubashi_PvPAnnounce(event, plr, victim)
	if (activated == 1) then
		local message = math.random(2)
		local plrs = GetPlayersInWorld()
		for k, v in pairs(plrs) do
			if (message == 1) then
				v:SendAreaTriggerMessage("[Event]:"..plr:GetName().." just killed "..victim:GetName()..", keep it up!")
			elseif (message == 2) then
				v:SendAreaTriggerMessage("[Event]:"..plr:GetName().." has decapitated "..victim:GetName().."!")
			end
		end
	end
end

function Gurubashi_PvPBuffs(event, plr)
	if (activated == 1) then
		local plrs = GetPlayersInWorld()
		for k, v in pairs(plrs) do
			if(v:GetHonorToday() >= 2000) then
				plr:CastSpell(41447) --Enrage
			end
		end
	end
end

RegisterServerHook(16, "Event_OnChat")
RegisterServerHook(2, "Gurubashi_PvPAnnounce")
RegisterTimedEvent("GurubashiEvent", 1000, 0)
RegisterTimedEvent("Gurubashi_PvPBuffs", pvpbufftimer, 0)]]--