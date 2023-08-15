local warriorspells = {1180, 201, 196, 198, 202, 197, 199, 227, 200, 266, 264, 5011, 9116}
local paladinspells = {201, 196, 198, 202, 197, 199, 200, 9116}
local hunterspells = {1180, 201, 196, 198, 202, 197, 266, 264, 5011}
local roguespells = {1180, 201, 196, 198, 266, 264, 5011}
local priestspells = {1180, 198, 227, 5009}
local deathknightspells = {1180, 201, 196, 198, 202, 197, 199}
local shamanspells = {1180, 198, 199, 9116}
local magespells = {201, 227, 5009, 1180}
local warlockspells = {227, 5009, 201, 1180}
local druidspells = {227, 198, 1180, 200}



function FirstLogin(event, plr)
        pClass = plr:GetPlayerClass()   
        

                if pClass == "Warrior" then
                        plr:LearnSpells(warriorspells) 
                        plr:AddItem(22416, 1)
                        plr:AddItem(22417, 1)
                        plr:AddItem(22418, 1)
                        plr:AddItem(22419, 1)
                        plr:AddItem(22420, 1)
                        plr:AddItem(22421, 1)
                        plr:AddItem(22422, 1)
                        plr:AddItem(22423, 1)
                elseif pClass == "Paladin" then
                        plr:LearnSpells(paladinspells) 
                        plr:AddItem(22424, 1)
                        plr:AddItem(22425, 1)
                        plr:AddItem(22426, 1)
                        plr:AddItem(22427, 1)
                        plr:AddItem(22428, 1)
                        plr:AddItem(22429, 1)
                        plr:AddItem(22430, 1)
                        plr:AddItem(22431, 1)
                elseif pClass == "Hunter" then
                        plr:LearnSpells(hunterspells) 
                        plr:AddItem(22436, 1)
                        plr:AddItem(22437, 1)
                        plr:AddItem(22438, 1)
                        plr:AddItem(22439, 1)
                        plr:AddItem(22440, 1)
                        plr:AddItem(22441, 1)
                        plr:AddItem(22442, 1)
                        plr:AddItem(22443, 1)
                elseif pClass == "Rogue" then
                        plr:LearnSpells(roguespells) 
                        plr:AddItem(22476, 1)
                        plr:AddItem(22477, 1)
                        plr:AddItem(22478, 1)
                        plr:AddItem(22479, 1)
                        plr:AddItem(22480, 1)
                        plr:AddItem(22481, 1)
                        plr:AddItem(22482, 1)
                        plr:AddItem(22483, 1)
                elseif pClass == "Priest" then
                        plr:LearnSpells(priestspells) 
                        plr:AddItem(22512, 1)
                        plr:AddItem(22513, 1)
                        plr:AddItem(22514, 1)
                        plr:AddItem(22515, 1)
                        plr:AddItem(22516, 1)
                        plr:AddItem(22517, 1)
                        plr:AddItem(22518, 1)
                        plr:AddItem(22519, 1)
                elseif pClass == "Shaman" then
                        plr:LearnSpells(shamanspells) 
                        plr:AddItem(22464, 1)
                        plr:AddItem(22465, 1)
                        plr:AddItem(22466, 1)
                        plr:AddItem(22467, 1)
                        plr:AddItem(22468, 1)
                        plr:AddItem(22469, 1)
                        plr:AddItem(22470, 1)
                        plr:AddItem(22471, 1)
                elseif pClass == "Mage" then
                        plr:LearnSpells(magespells) 
			plr:AddItem(22496, 1)
                        plr:AddItem(22497, 1)
                        plr:AddItem(22498, 1)
                        plr:AddItem(22499, 1)
                        plr:AddItem(22500, 1)
                        plr:AddItem(22501, 1)
                        plr:AddItem(22502, 1)
                        plr:AddItem(22503, 1)
                elseif pClass == "Warlock" then
                        plr:LearnSpells(warlockspells) 
			plr:AddItem(22504, 1)
                        plr:AddItem(22505, 1)
                        plr:AddItem(22506, 1)
                        plr:AddItem(22507, 1)
                        plr:AddItem(22508, 1)
                        plr:AddItem(22509, 1)
                        plr:AddItem(22510, 1)
                        plr:AddItem(22511, 1)
                elseif pClass == "Death Knight" then
                        plr:LearnSpells(deathknightspells)
			plr:AddItem(38661, 1)
                        plr:AddItem(38663, 1)
                        plr:AddItem(38665, 1)
                        plr:AddItem(38666, 1)
                        plr:AddItem(38667, 1)
                        plr:AddItem(38668, 1)
                        plr:AddItem(38669, 1)
                        plr:AddItem(38670, 1)
                elseif pClass == "Druid" then
                        plr:LearnSpells(druidspells) 
                        plr:AddItem(22488, 1)
                        plr:AddItem(22489, 1)
                        plr:AddItem(22490, 1)
                        plr:AddItem(22491, 1)
                        plr:AddItem(22492, 1)
                        plr:AddItem(22493, 1)
                        plr:AddItem(22494, 1)
                        plr:AddItem(22495, 1)
                end
                
                
      	plr:AdvanceAllSkills(300)
	plr:SendBroadcastMessage("|cFFFFCC00Welcome to CNA WoW, talk to Chuck before going any further.")
	plr:SetPhase(2)
end
	


RegisterServerHook(3, FirstLogin)