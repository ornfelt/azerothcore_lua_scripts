--[[Made by Sillocan]]--

function BufferOnLoad(pUnit, event)
	Buffer = pUnit
	Buffer:RegisterEvent("CheckForSomeone", 1000, 0)
end

function CheckForSomeone(pUnit, event)
	local plrs = pUnit:GetInRangePlayers()
	for k, v in pairs(plrs) do
		if (pUnit:GetDistance(v) <= 250) then
			if (v:HasAura(33077) == false) then
				v:CastSpell(33077)
				v:CastSpell(33078)
				v:CastSpell(33079)
				v:CastSpell(33080)
				v:CastSpell(33081)
				v:CastSpell(33082)
				v:CastSpell(56525) -- Blessing of Kings
				v:CastSpell(48162) -- Prayer of Fortitude
				v:CastSpell(48074) -- Prayer of Spirit
				v:CastSpell(48470) -- Gift of the Wild
				v:CastSpell(53307) -- Thorns
			end
		end
	end
end	

RegisterUnitEvent(76000,  18, "BufferOnLoad")
RegisterUnitEvent(76000,  18, "BufferOnLoad")

local NPCID =76000

function WeatherChangerOnunitTrigger(unit, event, player) 
Creature_menu(unit, player) 
end 

function Creature_menu(unit, player) 
	unit:GossipCreateMenu(1, player, 0) 
		unit:GossipMenuAddItem(10, "Sunny", 2, 0) 
		unit:GossipMenuAddItem(10, "Raining", 4, 0) 
		unit:GossipMenuAddItem(10, "Heavy Rain", 5, 0) 
		unit:GossipMenuAddItem(10, "Snowing", 6, 0)
		unit:GossipMenuAddItem(10, "Sandstorm", 7, 0)
		unit:GossipMenuAddItem(10, "Close", 8, 0) 
	unit:GossipSendMenu(player) 
end 

function WeatherChangerOnSelect(unit, event, player, id, intid, code) 
if (intid == 1) then 
	unit:GossipCreateMenu(1, player, 0) 
		unit:GossipMenuAddItem(10, "Sunny", 2, 0) 
		unit:GossipMenuAddItem(10, "Raining", 4, 0) 
		unit:GossipMenuAddItem(10, "Heavy Rain", 5, 0) 
		unit:GossipMenuAddItem(10, "Snowing", 6, 0)
		unit:GossipMenuAddItem(10, "Sandstorm", 7, 0)
		unit:GossipMenuAddItem(10, "Close", 8, 0)
	unit:GossipSendMenu(player) 
end 

if(intid == 2) then 
	player:SetPlayerWeather(1, 1) 
	player:SendBroadcastMessage("Better put your sunglasses on!")
	player:GossipComplete() 
end 

if(intid == 4) then 
	player:SetPlayerWeather(2, 1) 
	player:SendBroadcastMessage("It's raining, it's pouring...")
	player:GossipComplete() 
end 

if(intid == 5) then 
	player:SetPlayerWeather(4, 1) 
	player:SendBroadcastMessage("Why would you start a hurricane?")
	player:GossipComplete() 
end 

if(intid == 6) then 
	player:SetPlayerWeather(8, 1) 
	player:SendBroadcastMessage("Buuuur, it just started snowing!")
	player:GossipComplete() 
end 

if(intid == 7) then 
	player:SetPlayerWeather(16, 1) 
	player:SendBroadcastMessage("Sandshrew casts Sandstorm!")
	player:GossipComplete() 
end 

if(intid == 8) then
	player:SendBroadcastMessage("Goodbye!")
	player:GossipComplete() 
	end 
end 
RegisterUnitGossipEvent(NPCID, 1, "WeatherChangerOnunitTrigger") 
RegisterUnitGossipEvent(NPCID, 2, "WeatherChangerOnSelect")