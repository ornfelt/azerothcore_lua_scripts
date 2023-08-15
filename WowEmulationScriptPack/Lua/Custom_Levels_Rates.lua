local xpbonus_1to10 = 1 --multiply servers XP rate 1-10
local xpbonus_11to20 = 1
local xpbonus_21to30 = 1
local xpbonus_31to40 = 1
local xpbonus_41to50 = 1
local xpbonus_51to60 = 1
local xpbonus_61to70 = 1
local xpbonus_71to80 = 1

local unlimitedpower = false --if true player will have unlimited power...rage,energy,mana.


local function SKULYANNOUNCE(eventid, delay, repeats, player)
local level = player:GetLevel()
local xpbonus

if level >0 and level <11 then --Level 1-10
xpbonus = xpbonus_1to10
end

if level >10 and level <21 then --Level 11-20
xpbonus = xpbonus_11to20
end

if level >20 and level <31 then --Level 21-30
xpbonus = xpbonus_21to30
end

if level >30 and level <41 then --Level 31-40
xpbonus = xpbonus_31to40
end

if level >40 and level <51 then --Level 41-50
xpbonus = xpbonus_41to50
end

if level >50 and level <61 then--Level 51-60
xpbonus = xpbonus_51to60
end

if level >60 and level <71 then --Level 61-70
xpbonus = xpbonus_61to70
end

if level >70 then --Level 71+
xpbonus = xpbonus_71to80
end


if unlimitedpower then
player:SendBroadcastMessage("|cff00cc00 You are getting x"..xpbonus.." the servers xp rate and unlimited Rage/Energy/Mana.")
else
player:SendBroadcastMessage("|cff00cc00 You are getting x"..xpbonus.." the servers xp rate.")
end


end

local function SKULY2(eventid, delay, repeats, player)
local level = player:GetLevel()
local charcount = CharDBQuery(string.format("SELECT * FROM characters WHERE account='%i'", player:GetAccountId()))
local rowCount = charcount:GetRowCount()


if unlimitedpower then
local powerType = player:GetPowerType()
local maxPowerAmount = player:GetMaxPower( powerType )
player:ModifyPower( maxPowerAmount, powerType )
else
end


end

local function SKULY(eventid, delay, repeats, player)
local level = player:GetLevel()
local xpbonus

if level >0 and level <11 then --Level 1-10
xpbonus = xpbonus_1to10
end

if level >10 and level <21 then --Level 11-20
xpbonus = xpbonus_11to20
end

if level >20 and level <31 then --Level 21-30
xpbonus = xpbonus_21to30
end

if level >30 and level <41 then --Level 31-40
xpbonus = xpbonus_31to40
end

if level >40 and level <51 then --Level 41-50
xpbonus = xpbonus_41to50
end

if level >50 and level <61 then--Level 51-60
xpbonus = xpbonus_51to60
end

if level >60 and level <71 then --Level 61-70
xpbonus = xpbonus_61to70
end

if level >70 then --Level 71+
xpbonus = xpbonus_71to80
end


if unlimitedpower then
player:SendBroadcastMessage("|cff00cc00 You are getting x"..xpbonus.." the servers xp rate and unlimited Rage/Energy/Mana.")
else
player:SendBroadcastMessage("|cff00cc00 You are getting x"..xpbonus.." the servers xp rate.")
end

player:RegisterEvent(SKULYANNOUNCE, 360000, 0, player)
end


local function OnLogin(event, player)
	if player ~= nil then
	player:RegisterEvent(SKULY, 10000, 1, player)
	player:RegisterEvent(SKULY2, 300, 0, player)
	end
end




local function OnXP(event, player, amount, victim)
local level = player:GetLevel()
local xpbonus

if level >0 and level <11 then --Level 1-10
xpbonus = xpbonus_1to10
end

if level >10 and level <21 then --Level 11-20
xpbonus = xpbonus_11to20
end

if level >20 and level <31 then --Level 21-30
xpbonus = xpbonus_21to30
end

if level >30 and level <41 then --Level 31-40
xpbonus = xpbonus_31to40
end

if level >40 and level <51 then --Level 41-50
xpbonus = xpbonus_41to50
end

if level >50 and level <61 then--Level 51-60
xpbonus = xpbonus_51to60
end

if level >60 and level <71 then --Level 61-70
xpbonus = xpbonus_61to70
end

if level >70 then --Level 71+
xpbonus = xpbonus_71to80
end


local givexp = amount * xpbonus
return givexp


end


RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(12, OnXP)