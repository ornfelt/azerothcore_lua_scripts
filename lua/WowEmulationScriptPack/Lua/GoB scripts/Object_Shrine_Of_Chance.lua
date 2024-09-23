local ShrineofChance = 1815004

local function ShrineRoll(event, go, player)
    local chance = math.random(100)
	    if(chance == 100) then
			player:AddItem(6460051,1)
			player:AddItem(577777,1)
			player:AddItem(5461213,1)
			player:SendBroadcastMessage("[Shrine of Chance]: |cffff0000With a roll of |cff00ff00" ..chance.. "|cffff0000, A Hero... emerges...")
		elseif(chance > 95) then
			player:AddItem(6460052,2)
			player:SendBroadcastMessage("[Shrine of Chance]: |cffff0000With a roll of |cff00ff00" ..chance.. "|cffff0000, So close... but yet so far...")
		elseif(chance > 90) then
			player:AddItem(6460052,1)
			player:SendBroadcastMessage("[Shrine of Chance]: |cffff0000With a roll of |cff00ff00" ..chance.. "|cffff0000, Perhaps there is some hope for you yet...")
		elseif(chance > 85) then
			player:AddItem(6460050,50)
			player:SendBroadcastMessage("[Shrine of Chance]: |cffff0000With a roll of |cff00ff00" ..chance.. "|cffff0000, Not bad... mortal.")
		else
			player:Kill(player)
			player:SendBroadcastMessage("[Shrine of Chance]: |cffff0000With a roll of |cff00ff00" ..chance.. "|cffff0000, You are... unworthy.\n\nRolls above |cffff000085|r reward : 50,000 |TInterface/ICONS/INV_Misc_Apexis_Crystal:20:20|t.\n\nRolls above |cffff000090|r reward : 100,000 |TInterface/ICONS/INV_Misc_Apexis_Crystal:20:20|t.\n\nRolls above |cffff000095|r reward : 200,000 |TInterface/ICONS/INV_Misc_Apexis_Crystal:20:20|t.\n\nRolls above |cffff000099|r reward : 1,000,000 |TInterface/ICONS/INV_Misc_Apexis_Crystal:20:20|t, 1 |TInterface/ICONS/Frostfire Orb:20:20|t, 100,000 |TInterface/ICONS/inv_misc_coin_18:20:20|t.")
    end
end

RegisterGameObjectEvent( ShrineofChance, 14, ShrineRoll )