-- created in memory of BloodyWoW
-- rewards players who belong to a guild mg every half hour that they are logged in.
local timer = 1800000 -- 30mins

local function Guild_MG_reward(event, delay, calls, player)
local Paccid = player:GetAccountId()

	if(player:IsInGuild()==true)then
		player:SendBroadcastMessage("Jazzmine whispers:|cff00cc00Your Guild Thankz you for playing.|r")
		AddMG(player, 5*ACCT[Paccid].Vip)
	else
		player:SendBroadcastMessage("Grumbo shouts:|cffff0000Join a Guild to earn extra rewards.|r")
	end
end

function Online_Timer(event, player)
	player:RegisterEvent( Guild_MG_reward, timer, 0)
end

RegisterPlayerEvent(3, Online_Timer)

function ReLoadMGrewarder(event, player, msg)
	if(msg=="Load Vip Table")then
	
		for _,v in ipairs(GetPlayersInWorld()) do
			if(v and v:IsInWorld()) then
				Online_Timer(1, v)
			end
		end
	print("Guild MG Timers Reloaded.")
	return false;	
	end
end
RegisterPlayerEvent(18, ReLoadMGrewarder) 

print("Grumbo'z VIP Guild MG Rewarder loaded.")
