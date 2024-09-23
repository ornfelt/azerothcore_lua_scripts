local enabled = false
local PlayedTimeInterval = 30 --minutes
local MoneyReward = 10000 -- COPPER (100 Copper = 1 Silver| 100 Silver = 1 Gold) 10000 Copper = 1 gold
local HonorReward = 0 -- Honor points to reward
local ArenaReward = 0 -- Arena points to reward
local ItemReward = 0 -- Itemid if 0 then no item given
local ItemRewardCount = 1 -- How many of the item to reward.

local playtime
local timerPR = PlayedTimeInterval * 60000

local function OnLoad(event)

		local intervaltime = PlayedTimeInterval
		local hours = 0
		local minutes = 0
		local timestring
		
		if PlayedTimeInterval >= 60 then
		hours = intervaltime/60
		minutes = intervaltime%60
		timestring = ""..math.floor(hours).."|cff3399FF hour and |cff00cc00"..math.floor(minutes).."|cff3399FF minutes"
		end
		
		if PlayedTimeInterval < 60 then
		minutes = intervaltime%60
		timestring = ""..math.floor(minutes).." minutes"
		end
		
		SendWorldMessage("|cff3399FF Playtime Reward active and interval set to |cff00cc00"..timestring.."|cff3399FF .")
		
end

local function REWARD(eventid, delay, repeats, player)
	local gold = 0
	local silver = 0
	local copper = 0
	
	if MoneyReward >= 10000 then
		number = MoneyReward
		gold = number/10000
		number = number%10000
		silver = number/100
		copper = number%100
	end
	
	if MoneyReward > 100 and MoneyReward < 10000 then
		number = MoneyReward
		silver = number/100
		copper = number%100
	end
	
	if MoneyReward <= 100 then
		copper = MoneyReward
	end

	local rewardstring = ""..math.floor(gold).."|c00FFFF00g|cff3399FF"..math.floor(silver).."|cFFFFFFFFs|cff3399FF"..math.floor(copper).."|cFFcc0000c"


	if player:GetTotalPlayedTime() >= (playtime + timerPR/1000) then
	
	if MoneyReward > 0 then
	player:ModifyMoney( MoneyReward )
	player:SendBroadcastMessage("|cff3399FF You received "..rewardstring.."|cff3399FF as a Playtime Reward.")
	end
	
	if HonorReward > 0 then
	player:ModifyHonorPoints( HonorReward )
	player:SendBroadcastMessage("|cff3399FF You received |cff00cc00"..HonorReward.."|cff3399FF Honor Points as a Playtime Reward.")
	end
	
	if ArenaReward > 0 then
	player:ModifyArenaPoints( ArenaReward )
	player:SendBroadcastMessage("|cff3399FF You received |cff00cc00"..ArenaReward.."|cff3399FF Arena Points as a Playtime Reward.")
	end
	
	if ItemReward > 0 then
	local Item = player:AddItem( ItemReward, ItemRewardCount )
	local itemname = Item:GetName()
	player:SendBroadcastMessage("|cff3399FF You received |c00FFFF00"..ItemRewardCount.."|cff3399FFx |cff00cc00"..itemname.."|cff3399FF as a Playtime Reward.")
	end
	
	end
	
	playtime = player:GetTotalPlayedTime()
end

local function SKULY(eventid, delay, repeats, player)
	playtime = player:GetTotalPlayedTime()
	player:RegisterEvent(REWARD, timerPR, 0, player)
	player:SendBroadcastMessage("|cff3399FF Playtime Reward active and interval set to |cff00cc00"..PlayedTimeInterval.."|cff3399FF minutes.")

end

local firstlogin = false


local function OnFirstLogin(event, player)

	if event == 30 then
	firstlogin = true
	player:RegisterEvent(SKULY, 10000, 1, player)
	player:SendBroadcastMessage("|cff3399FF Playtime Reward active and interval set to |cff00cc00"..PlayedTimeInterval.."|cff3399FF minutes.")
	end
end

local function OnLogin(event, player)
	if not firstlogin then
	player:RegisterEvent(SKULY, 10000, 1, player)
	player:SendBroadcastMessage("|cff3399FF Playtime Reward active and interval set to |cff00cc00"..PlayedTimeInterval.."|cff3399FF minutes.")
	else
	firstlogin = false
	end
end

if enabled then
RegisterPlayerEvent(30, OnFirstLogin)
RegisterPlayerEvent(3, OnLogin)
RegisterServerEvent(33, OnLoad)
end