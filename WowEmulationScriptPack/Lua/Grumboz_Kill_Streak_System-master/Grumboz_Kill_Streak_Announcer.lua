-- By Slp13at420 of EmuDevs.com --
local Streak = {};
local GuildStreak = {};
local Ann = {};

print("----------------©------------------")
print("Grumboz Kill Streak loading.")

Ann = {
	[5] = {"`The Boring`", "has earned 5 kills.", 200, 300,},
	[10] = {"`The Annoyance`", "is warming up with 10 kills.", 201, nil,},
	[25] = {"`The War Machine`", "has reached 25 kills.", 202, nil,},
	[50] = {"`The Bloody`", "has reached 50 kills.", 203, 301,},
	[75] = {"`The Widow Maker`", "has caused a blood bath by slaughtering 75 victims.", 204, nil,},
	[100] = {"`The WarLord`", "walks thru the battlefield drenched with the blood of 100 victims.", 205, 302,},
	[125] = {"`The Chaotic`", "is litteraly standing in his victims blood with 125 kills.", 206, nil,},
	[150] = {"`The Reaper`", "has devistated the realm with 150 victims.", 207, 303,},
	[175] = {"`The Destroyer of Worlds`", "Stands atop a pile of bodies of 175 victims.", 208, nil,},
};

local function StreakKill(event, killer, victim)

local Kguid = killer:GetGUIDLow()
local Vguid = victim:GetGUIDLow()
local Kname = killer:GetName()
local Vname = victim:GetName()

	if(killer:IsInGuild()==true)then
	
		if(GuildStreak[Kguid]==nil)then
			GuildStreak[Kguid] = {kills = 0}
		end
		
		if(GuildStreak[Vguid]==nil)then
			GuildStreak[Vguid] = {kills = 0}
		end
	end
			
	if(Vguid~=Kguid)then
	
		if(Streak[Kguid].prior~=Vguid)then
		
			Streak[Kguid].kills = (Streak[Kguid].kills + 1)
		
			if(Ann[Streak[Kguid].kills])then
				
				if((killer:IsInGuild()==true)and(victim:IsInGuild()==true))then
				
					GuildStreak[Kguid].kills = (GuildStreak[Kguid].kills + 1)

					if(Ann[GuildStreak[Kguid].kills][4])then
						killer:SetKnownTitle(Ann[GuildStreak[Kguid].kills][4])
						GuildStreak[Vguid].kills = 0
					else
					end
				end		
				
				killer:SetKnownTitle(Ann[Streak[Kguid].kills][3])
				Streak[Kguid].title = Ann[Streak[Kguid].kills][1]
				SendWorldMessage("|cffcc0000"..Kname.." "..Ann[Streak[Kguid].kills][1].." "..Ann[Streak[Kguid].kills][2].."|r")
				victim:SendBroadcastMessage("|cffcc0000You have fallen to "..Kname.." "..Streak[Kguid].title..".|r")
				Streak[Vguid].kills = 0
			end
		else
			killer:SendBroadcastMessage("You cant kill the same player twice.")
		end
	else
		killer:SendBroadcastMessage("You cant earn titles by killing yourself.")
	end
Streak[Kguid].prior = Vguid
end

local function StreakLogin(event, killer)

local Kguid = killer:GetGUIDLow()

Streak[Kguid] = {title = "`The Noob`", kills = 0, prior = 0}
	
	if(killer:IsInGuild()==true)then
		GuildStreak[Kguid] = {kills = 0}
	end
end

local function StreakLogoff(event, killer)

local Kguid = killer:GetGUIDLow()

Streak[Kguid] = {nil}
GuildStreak[Kguid] = {nil}

end

RegisterPlayerEvent(6, StreakKill)
RegisterPlayerEvent(3, StreakLogin)
RegisterPlayerEvent(4, StreakLogoff)

print("Counter started.")
print("-----------------------------------")
