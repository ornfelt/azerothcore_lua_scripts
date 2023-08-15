local ID = 199999


function tierUpgradeCheck(player,tiernum)
--print(player:GetClassAsString(0))
local check1 = false
local check2 = false
local check3 = false
local check1icon = "|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t"
local check2icon = "|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t"
local check3icon = "|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t"
if tiernum == 1 then
	if player:HasItem(577777, 1) then
		check1 = true
	end
	if player:HasItem(649285, 5) then
		check2 = true
	end
	if player:HasItem(6460050, 500) then
		check3 = true
	end
elseif tiernum == 2 then
	if player:HasItem(577777, 2) then
		check1 = true
	end
	if player:HasItem(649285, 5) then
		check2 = true
	end
	if player:HasItem(6460050, 1000) then
		check3 = true
	end
elseif tiernum == 3 then
	if player:HasItem(577777, 3) then
		check1 = true
	end
	if player:HasItem(649285, 5) then
		check2 = true
	end
	if player:HasItem(6460050, 2000) then
		check3 = true
	end
elseif tiernum == 4 then
	if player:HasItem(577777, 4) then
		check1 = true
	end
	if player:HasItem(649285, 10) then
		check2 = true
	end
	if player:HasItem(6460050, 5000) then
		check3 = true
	end
elseif tiernum == 5 then
	if player:HasItem(577777, 5) then
		check1 = true
	end
	if player:HasItem(649285, 10) then
		check2 = true
	end
	if player:HasItem(6460050, 10000) then
		check3 = true
	end
end
--print(check1,check2,check3)

if (check1==false or check2==false or check3==false) then
	local check1amount = player:GetItemCount(577777)
	local check2amount = player:GetItemCount(649285)
	local check3amount = player:GetItemCount(6460050)
	localsend = ""
	local localsend = "You do not have the materials required for this upgrade.\n\n"
	if tiernum == 1 then
		if check1amount < 1 then
			localsend = localsend .. check1icon .. (1 - check1amount) .. " Burden of Eternity\n"
		end
		if check2amount < 5 then
			localsend = localsend .. check2icon .. (5 - check2amount) .. " Titanforge Stone\n"
		end
		if check3amount < 500 then
			localsend = localsend .. check3icon .. (500 - check3amount) .. " Shazzian Shards (1000)\n"
		end
		player:SendBroadcastMessage(localsend)
	elseif tiernum == 2 then
		if check1amount < 2 then
			localsend = localsend .. check1icon .. (2 - check1amount) .. " Burden of Eternity\n"
		end
		if check2amount < 5 then
			localsend = localsend .. check2icon .. (5 - check2amount) .. " Titanforge Stone\n"
		end
		if check3amount < 1000 then
			localsend = localsend .. check3icon .. (1000 - check3amount) .. " Shazzian Shards (1000)\n"
		end
		player:SendBroadcastMessage(localsend)
	elseif tiernum == 3 then
		if check1amount < 3 then
			localsend = localsend .. check1icon .. (3 - check1amount) .. " Burden of Eternity\n"
		end
		if check2amount < 5 then
			localsend = localsend .. check2icon .. (5 - check2amount) .. " Titanforge Stone\n"
		end
		if check3amount < 2000 then
			localsend = localsend .. check3icon .. (2000 - check3amount) .. " Shazzian Shards (1000)\n"
		end
		player:SendBroadcastMessage(localsend)
	elseif tiernum == 4 then
		if check1amount < 4 then
			localsend = localsend .. check1icon .. (4 - check1amount) .. " Burden of Eternity\n"
		end
		if check2amount < 10 then
			localsend = localsend .. check2icon .. (10 - check2amount) .. " Titanforge Stone\n"
		end
		if check3amount < 5000 then
			localsend = localsend .. check3icon .. (5000 - check3amount) .. " Shazzian Shards (1000)\n"
		end
		player:SendBroadcastMessage(localsend)
    elseif tiernum == 5 then
        if check1amount < 5 then
            localsend = localsend .. check1icon .. (5 - check1amount) .. " Burden of Eternity\n"
        end
        if check2amount < 10 then
            localsend = localsend .. check2icon .. (10 - check2amount) .. " Titanforge Stone\n"
        end
        if check3amount < 10000 then
            localsend = localsend .. check3icon .. (10000 - check3amount) .. " Shazzian Shards (1000)\n"
        end
        player:SendBroadcastMessage(localsend)
    end
    else
    return true
end
return false
end

function onGossip(event, player, unit)
--Paladin Helmet 1 MASTERY
if (player:HasItem(2258422,1) and player:GetClassAsString(0) == "Paladin") then
player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helmet |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your helmet.", 0, 1)

elseif (player:HasItem(2268422,1) and player:GetClassAsString(0) == "Paladin") then
player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helmet |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your helmet.", 0, 2)

elseif (player:HasItem(2278422,1) and player:GetClassAsString(0) == "Paladin") then
player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helmet |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your helmet.", 0, 3)

elseif (player:HasItem(2288422,1) and player:GetClassAsString(0) == "Paladin") then
player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helmet |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your helmet.", 0, 4)

elseif (player:HasItem(2298422,1) and player:GetClassAsString(0) == "Paladin") then
player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helmet |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your helmet.", 0, 5)
end
--Paladin Helmet 1 MASTERY END

--Paladin Chest 1 MASTERY
if (player:HasItem(2258421,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 6)
    
    elseif (player:HasItem(2268421,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 7)
    
    elseif (player:HasItem(2278421,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 8)
    
    elseif (player:HasItem(2288421,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 9)
    
    elseif (player:HasItem(2298421,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 10)
end
    --Paladin Chest 1 MASTERY END

--Paladin Legplates 1 MASTERY
if (player:HasItem(2258423,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 11)
    
    elseif (player:HasItem(2268423,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 12)
    
    elseif (player:HasItem(2278423,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 13)
    
    elseif (player:HasItem(2288423,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 14)
    
    elseif (player:HasItem(2298423,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 15)
end
    --Paladin Legplates 1 MASTERY END


--Paladin Spaulders 1 MASTERY
if (player:HasItem(2258424,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 16)
    
    elseif (player:HasItem(2268424,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 17)
    
    elseif (player:HasItem(2278424,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 18)
    
    elseif (player:HasItem(2288424,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 19)
    
    elseif (player:HasItem(2298424,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 20)
end
    --Paladin Spaulders 1 MASTERY END

    
--Paladin Belt 1 MASTERY
if (player:HasItem(2258425,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 21)
    
    elseif (player:HasItem(2268425,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 22)
    
    elseif (player:HasItem(2278425,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 23)
    
    elseif (player:HasItem(2288425,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 24)
    
    elseif (player:HasItem(2298425,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 25)
end
    --Paladin Belt 1 MASTERY END
	
--Paladin Boots 1 MASTERY
if (player:HasItem(2258426,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 26)
    
    elseif (player:HasItem(2268426,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 27)
    
    elseif (player:HasItem(2278426,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 28)
    
    elseif (player:HasItem(2288426,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 29)
    
    elseif (player:HasItem(2298426,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 30)
end
    --Paladin Boots 1 MASTERY END

--Paladin Gauntlets 1 MASTERY
if (player:HasItem(2258427,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 31)
    
    elseif (player:HasItem(2268427,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 32)
    
    elseif (player:HasItem(2278427,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 33)
    
    elseif (player:HasItem(2288427,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 34)
    
    elseif (player:HasItem(2298427,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 35)
    end
    --Paladin Gauntlets 1 MASTERY END
--Paladin Bracers 1 MASTERY
if (player:HasItem(2258494,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 36)
    
    elseif (player:HasItem(2268494,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 37)
    
    elseif (player:HasItem(2278494,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 38)
    
    elseif (player:HasItem(2288494,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 39)
    
    elseif (player:HasItem(2298494,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 40)
    end
    --Paladin Bracers 1 MASTERY END

--Paladin Chestguard 2 MASTERY
if (player:HasItem(2258477,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 41)
    
    elseif (player:HasItem(2268477,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 42)
    
    elseif (player:HasItem(2278477,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 43)
    
    elseif (player:HasItem(2288477,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 44)
    
    elseif (player:HasItem(2298477,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Chestguard |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 45)
    end
    --Paladin Chest 2 MASTERY END
--Paladin Helm 2 MASTERY
if (player:HasItem(2258478,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helm |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 46)
    
    elseif (player:HasItem(2268478,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helm |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 47)
    
    elseif (player:HasItem(2278478,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helm |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 48)
    
    elseif (player:HasItem(2288478,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helm |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 49)
    
    elseif (player:HasItem(2298478,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Helm |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 50)
    end
    --Paladin Helm 2 MASTERY END

--Paladin Legplates 2 MASTERY
if (player:HasItem(2258479,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 51)
    
    elseif (player:HasItem(2268479,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 52)
    
    elseif (player:HasItem(2278479,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 53)
    
    elseif (player:HasItem(2288479,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 54)
    
    elseif (player:HasItem(2298479,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Legplates |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legplates.", 0, 55)
    end
    --Paladin Legplates 2 MASTERY END


--Paladin Spaulders 2 MASTERY
if (player:HasItem(2258480,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 56)
    
    elseif (player:HasItem(2268480,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 57)
    
    elseif (player:HasItem(2278480,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 58)
    
    elseif (player:HasItem(2288480,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 59)
    
    elseif (player:HasItem(2298480,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 60)
    end
    --Paladin Spaulders 2 MASTERY END

    
--Paladin Belt 2 MASTERY
if (player:HasItem(2258481,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 61)
    
    elseif (player:HasItem(2268481,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 62)
    
    elseif (player:HasItem(2278481,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 63)
    
    elseif (player:HasItem(2288481,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 64)
    
    elseif (player:HasItem(2298481,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 65)
    end
    --Paladin Belt 2 MASTERY END


--Paladin Boots 2 MASTERY
if (player:HasItem(2258482,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 66)
    
    elseif (player:HasItem(2268482,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 67)
    
    elseif (player:HasItem(2278482,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 68)
    
    elseif (player:HasItem(2288482,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 69)
    
    elseif (player:HasItem(2298482,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 70)
    end
    --Paladin Boots 2 MASTERY END


--Paladin Gauntlets 2 MASTERY
if (player:HasItem(2258483,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 71)
    
    elseif (player:HasItem(2268483,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 72)
    
    elseif (player:HasItem(2278483,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 73)
    
    elseif (player:HasItem(2288483,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 74)
    
    elseif (player:HasItem(2298483,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 75)
    end
    --Paladin Gauntlets 2 MASTERY END
--Paladin Bracers 2 MASTERY
if (player:HasItem(2258502,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 76)
    
    elseif (player:HasItem(2268502,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 77)
    
    elseif (player:HasItem(2278502,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 78)
    
    elseif (player:HasItem(2288502,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 79)
    
    elseif (player:HasItem(2298502,1) and player:GetClassAsString(0) == "Paladin") then
    player:GossipMenuAddItem(0,"|cff9700FFBurning Avenger Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 80)
    end
    --Paladin Bracers 2 MASTERY END

--Rogue Chest MASTERY
if (player:HasItem(2258401,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Chestpiece |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 81)
    
    elseif (player:HasItem(2268401,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Chestpiece |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 82)
    
    elseif (player:HasItem(2278401,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Chestpiece |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 83)
    
    elseif (player:HasItem(2288401,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Chestpiece |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 84)
    
    elseif (player:HasItem(2298401,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Chestpiece |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 85)
    end
    --Rogue Chest MASTERY END
--Rogue Hood MASTERY
if (player:HasItem(2258404,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Hood |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Hood.", 0, 86)
    
    elseif (player:HasItem(2268404,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Hood |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Hood.", 0, 87)
    
    elseif (player:HasItem(2278404,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Hood |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Hood.", 0, 88)
    
    elseif (player:HasItem(2288404,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Hood |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Hood.", 0, 89)
    
    elseif (player:HasItem(2298404,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Hood |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Hood.", 0, 90)
    end
    --Rogue Hood MASTERY END

--Rogue Pants MASTERY
if (player:HasItem(2258405,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Pants |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Pants.", 0, 91)
    
    elseif (player:HasItem(2268405,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Pants |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Pants.", 0, 92)
    
    elseif (player:HasItem(2278405,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Pants |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Pants.", 0, 93)
    
    elseif (player:HasItem(2288405,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Pants |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Pants.", 0, 94)
    
    elseif (player:HasItem(2298405,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Pants |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Pants.", 0, 95)
    end
    --Rogue Pants MASTERY END


--Rogue Spaulders MASTERY
if (player:HasItem(2258400,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 96)
    
    elseif (player:HasItem(2268400,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 97)
    
    elseif (player:HasItem(2278400,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 98)
    
    elseif (player:HasItem(2288400,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 99)
    
    elseif (player:HasItem(2298400,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 100)
    end
    --Rogue Spaulders MASTERY END

    
--Rogue Belt MASTERY
if (player:HasItem(2258406,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 101)
    
    elseif (player:HasItem(2268406,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 102)
    
    elseif (player:HasItem(2278406,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 103)
    
    elseif (player:HasItem(2288406,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 104)
    
    elseif (player:HasItem(2298406,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 105)
    end
    --Rogue Belt MASTERY END


--Rogue Boots MASTERY
if (player:HasItem(2258402,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 106)
    
    elseif (player:HasItem(2268402,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 107)
    
    elseif (player:HasItem(2278402,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 108)
    
    elseif (player:HasItem(2288402,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 109)
    
    elseif (player:HasItem(2298402,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 110)
    end
    --Rogue Boots MASTERY END


--Rogue Gauntlets MASTERY
if (player:HasItem(2258403,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 111)
    
    elseif (player:HasItem(2268403,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 112)
    
    elseif (player:HasItem(2278403,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 113)
    
    elseif (player:HasItem(2288403,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 114)
    
    elseif (player:HasItem(2298403,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 115)
    end
    --Rogue Gauntlets MASTERY END
--Rogue Bracers MASTERY
if (player:HasItem(2258491,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 116)
    
    elseif (player:HasItem(2268491,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 117)
    
    elseif (player:HasItem(2278491,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 118)
    
    elseif (player:HasItem(2288491,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 119)
    
    elseif (player:HasItem(2298491,1) and player:GetClassAsString(0) == "Rogue") then
    player:GossipMenuAddItem(0,"|cff9700FFDarkshadow Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 120)
    end
    --Rogue Bracers MASTERY END


--Druid Helm 1 MASTERY
if (player:HasItem(2258411,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 121)
    
    elseif (player:HasItem(2268411,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 122)
    
    elseif (player:HasItem(2278411,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 123)
    
    elseif (player:HasItem(2288411,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 124)
    
    elseif (player:HasItem(2298411,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 125)
    end
    --Druid  Helm 1 MASTERY END
--Druid Chest 1 MASTERY 
if (player:HasItem(2258410,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 126)
    
    elseif (player:HasItem(2268410,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 127)
    
    elseif (player:HasItem(2278410,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 128)
    
    elseif (player:HasItem(2288410,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 129)
    
    elseif (player:HasItem(2298410,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 130)
    end
    --Druid Chest 1 MASTERY END

--Druid Leggings 1 MASTERY
if (player:HasItem(2258412,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 131)
    
    elseif (player:HasItem(2268412,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 132)
    
    elseif (player:HasItem(2278412,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 133)
    
    elseif (player:HasItem(2288412,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 134)
    
    elseif (player:HasItem(2298412,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 135)
    end
    --Druid Leggings 1 MASTERY END


--Druid Spaulders 1 MASTERY
if (player:HasItem(2258413,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 136)
    
    elseif (player:HasItem(2268413,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 137)
    
    elseif (player:HasItem(2278413,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 138)
    
    elseif (player:HasItem(2288413,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 139)
    
    elseif (player:HasItem(2298413,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 140)
    end
    --Druid Spaulders 1 MASTERY END

    
--Druid Belt 1 MASTERY
if (player:HasItem(2258407,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 141)
    
    elseif (player:HasItem(2268407,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 142)
    
    elseif (player:HasItem(2278407,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 143)
    
    elseif (player:HasItem(2288407,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 144)
    
    elseif (player:HasItem(2298407,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 145)
    end
    --Druid Belt 1 MASTERY END


--Druid Boots 1 MASTERY
if (player:HasItem(2258408,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 146)
    
    elseif (player:HasItem(2268408,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 147)
    
    elseif (player:HasItem(2278408,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 148)
    
    elseif (player:HasItem(2288408,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 149)
    
    elseif (player:HasItem(2298408,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 150)
    end
    --Druid Boots 1 MASTERY END


--Druid Gloves 1 MASTERY
if (player:HasItem(2258409,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 151)
    
    elseif (player:HasItem(2268409,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 152)
    
    elseif (player:HasItem(2278409,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 153)
    
    elseif (player:HasItem(2288409,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 154)
    
    elseif (player:HasItem(2298409,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 155)
    end
    --Druid Gloves 1 MASTERY END
--Druid Bracers 1 MASTERY
if (player:HasItem(2258492,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 156)
    
    elseif (player:HasItem(2268492,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 157)
    
    elseif (player:HasItem(2278492,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 158)
    
    elseif (player:HasItem(2288492,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 159)
    
    elseif (player:HasItem(2298492,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 160)
    end
    --Druid Bracers 1 MASTERY END

--Druid Vestments 2 MASTERY
if (player:HasItem(2258473,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 161)
    
    elseif (player:HasItem(2268473,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 162)
    
    elseif (player:HasItem(2278473,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 163)
    
    elseif (player:HasItem(2288473,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 164)
    
    elseif (player:HasItem(2298473,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Vestments |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 165)
    end
    --Druid Chest 2 MASTERY END
--Druid Helm 2 MASTERY
if (player:HasItem(2258474,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 166)
    
    elseif (player:HasItem(2268474,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 167)
    
    elseif (player:HasItem(2278474,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 168)
    
    elseif (player:HasItem(2288474,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 169)
    
    elseif (player:HasItem(2298474,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Helm |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 170)
    end
    --Druid Helm 2 MASTERY END

--Druid Leggings 2 MASTERY
if (player:HasItem(2258475,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 171)
    
    elseif (player:HasItem(2268475,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 172)
    
    elseif (player:HasItem(2278475,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 173)
    
    elseif (player:HasItem(2288475,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 174)
    
    elseif (player:HasItem(2298475,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Leggings |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Leggings.", 0, 175)
    end
    --Druid Leggings 2 MASTERY END


--Druid Spaulders 2 MASTERY
if (player:HasItem(2258476,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 176)
    
    elseif (player:HasItem(2268476,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 177)
    
    elseif (player:HasItem(2278476,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 178)
    
    elseif (player:HasItem(2288476,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 179)
    
    elseif (player:HasItem(2298476,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 180)
    end
    --Druid Spaulders 2 MASTERY END

    
--Druid Belt 2 MASTERY
if (player:HasItem(2258470,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 181)
    
    elseif (player:HasItem(2268470,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 182)
    
    elseif (player:HasItem(2278470,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 183)
    
    elseif (player:HasItem(2288470,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 184)
    
    elseif (player:HasItem(2298470,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 185)
    end
    --Druid Belt 2 MASTERY END


--Druid Boots 2 MASTERY
if (player:HasItem(2258471,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 186)
    
    elseif (player:HasItem(2268471,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 187)
    
    elseif (player:HasItem(2278471,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 188)
    
    elseif (player:HasItem(2288471,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 189)
    
    elseif (player:HasItem(2298471,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 190)
    end
    --Druid Boots 2 MASTERY END


--Druid Gloves 2 MASTERY
if (player:HasItem(2258472,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 191)
    
    elseif (player:HasItem(2268472,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 192)
    
    elseif (player:HasItem(2278472,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 193)
    
    elseif (player:HasItem(2288472,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 194)
    
    elseif (player:HasItem(2298472,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Gloves |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 195)
    end
    --Druid Gloves 2 MASTERY END
--Druid Bracers 2 MASTERY
if (player:HasItem(2258501,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 196)
    
    elseif (player:HasItem(2268501,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 197)
    
    elseif (player:HasItem(2278501,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 198)
    
    elseif (player:HasItem(2288501,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 199)
    
    elseif (player:HasItem(2298501,1) and player:GetClassAsString(0) == "Druid") then
    player:GossipMenuAddItem(0,"|cff9700FFEverlasting Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 200)
    end
    --Druid Bracers 2 MASTERY END

--Hunter Chest MASTERY
if (player:HasItem(2258420,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Breastplate |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 201)
    
    elseif (player:HasItem(2268420,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Breastplate |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 202)
    
    elseif (player:HasItem(2278420,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Breastplate |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 203)
    
    elseif (player:HasItem(2288420,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Breastplate |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 204)
    
    elseif (player:HasItem(2298420,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Breastplate |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 205)
    end
    --Hunter Chest MASTERY END
--Hunter Helm MASTERY
if (player:HasItem(2258417,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Helm |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 206)
    
    elseif (player:HasItem(2268417,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Helm |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 207)
    
    elseif (player:HasItem(2278417,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Helm |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 208)
    
    elseif (player:HasItem(2288417,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Helm |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 209)
    
    elseif (player:HasItem(2298417,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Helm |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 210)
    end
    --Hunter Helm MASTERY END

--Hunter Legguards MASTERY
if (player:HasItem(2258416,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Legguards |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legguards.", 0, 211)
    
    elseif (player:HasItem(2268416,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Legguards |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legguards.", 0, 212)
    
    elseif (player:HasItem(2278416,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Legguards |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legguards.", 0, 213)
    
    elseif (player:HasItem(2288416,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Legguards |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legguards.", 0, 214)
    
    elseif (player:HasItem(2298416,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Legguards |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legguards.", 0, 215)
    end
    --Hunter Legguards MASTERY END


--Hunter Spaulders MASTERY
if (player:HasItem(2258415,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 216)
    
    elseif (player:HasItem(2268415,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 217)
    
    elseif (player:HasItem(2278415,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 218)
    
    elseif (player:HasItem(2288415,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 219)
    
    elseif (player:HasItem(2298415,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 220)
    end
    --Hunter Spaulders MASTERY END

    
--Hunter Belt MASTERY
if (player:HasItem(2258414,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 221)
    
    elseif (player:HasItem(2268414,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 222)
    
    elseif (player:HasItem(2278414,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 223)
    
    elseif (player:HasItem(2288414,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 224)
    
    elseif (player:HasItem(2298414,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 225)
    end
    --Hunter Belt MASTERY END


--Hunter Greaves MASTERY
if (player:HasItem(2258419,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Greaves |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Greaves.", 0, 226)
    
    elseif (player:HasItem(2268419,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Greaves |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Greaves.", 0, 227)
    
    elseif (player:HasItem(2278419,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Greaves |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Greaves.", 0, 228)
    
    elseif (player:HasItem(2288419,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Greaves |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Greaves.", 0, 229)
    
    elseif (player:HasItem(2298419,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Greaves |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Greaves.", 0, 230)
    end
    --Hunter Greaves MASTERY END


--Hunter Gauntlets MASTERY
if (player:HasItem(2258418,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 231)
    
    elseif (player:HasItem(2268418,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 232)
    
    elseif (player:HasItem(2278418,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 233)
    
    elseif (player:HasItem(2288418,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 234)
    
    elseif (player:HasItem(2298418,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gauntlets.", 0, 235)
    end
    --Hunter Gauntlets MASTERY END
--Hunter Bracers MASTERY
if (player:HasItem(2258493,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 236)
    
    elseif (player:HasItem(2268493,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 237)
    
    elseif (player:HasItem(2278493,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 238)
    
    elseif (player:HasItem(2288493,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 239)
    
    elseif (player:HasItem(2298493,1) and player:GetClassAsString(0) == "Hunter") then
    player:GossipMenuAddItem(0,"|cff9700FFBlack Widow Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 240)
    end
    --Hunter Bracers MASTERY END
--Warlock Chest MASTERY
if (player:HasItem(2258432,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Robes |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 241)
    
    elseif (player:HasItem(2268432,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Robes |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 242)
    
    elseif (player:HasItem(2278432,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Robes |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 243)
    
    elseif (player:HasItem(2288432,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Robes |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 244)
    
    elseif (player:HasItem(2298432,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Robes |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 245)
    end
    --Warlock Chest MASTERY END
--Warlock Helm MASTERY
if (player:HasItem(2258430,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Skullcap |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 246)
    
    elseif (player:HasItem(2268430,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Skullcap |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 247)
    
    elseif (player:HasItem(2278430,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Skullcap |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 248)
    
    elseif (player:HasItem(2288430,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Skullcap |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 249)
    
    elseif (player:HasItem(2298430,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Skullcap |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 250)
    end
    --Warlock Helm MASTERY END

--Warlock Legs MASTERY
if (player:HasItem(2258431,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Leggings |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 251)
    
    elseif (player:HasItem(2268431,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Leggings |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 252)
    
    elseif (player:HasItem(2278431,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Leggings |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 253)
    
    elseif (player:HasItem(2288431,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Leggings |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 254)
    
    elseif (player:HasItem(2298431,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Leggings |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 255)
    end
    --Warlock Legs MASTERY END


--Warlock Spaulders MASTERY
if (player:HasItem(2258433,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 256)
    
    elseif (player:HasItem(2268433,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 257)
    
    elseif (player:HasItem(2278433,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 258)
    
    elseif (player:HasItem(2288433,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 259)
    
    elseif (player:HasItem(2298433,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 260)
    end
    --Warlock Spaulders MASTERY END

    
--Warlock Belt MASTERY
if (player:HasItem(2258434,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 261)
    
    elseif (player:HasItem(2268434,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 262)
    
    elseif (player:HasItem(2278434,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 263)
    
    elseif (player:HasItem(2288434,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 264)
    
    elseif (player:HasItem(2298434,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 265)
    end
    --Warlock Belt MASTERY END


--Warlock Boots MASTERY
if (player:HasItem(2258428,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 266)
    
    elseif (player:HasItem(2268428,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 267)
    
    elseif (player:HasItem(2278428,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 268)
    
    elseif (player:HasItem(2288428,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 269)
    
    elseif (player:HasItem(2298428,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 270)
    end
    --Warlock Boots MASTERY END


--Warlock Gloves MASTERY
if (player:HasItem(2258429,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Gloves |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 271)
    
    elseif (player:HasItem(2268429,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Gloves |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 272)
    
    elseif (player:HasItem(2278429,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Gloves |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 273)
    
    elseif (player:HasItem(2288429,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Gloves |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 274)
    
    elseif (player:HasItem(2298429,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Gloves |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 275)
    end
    --Warlock Gloves MASTERY END
--Warlock Bracers MASTERY
if (player:HasItem(2258495,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 276)
    
    elseif (player:HasItem(2268495,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 277)
    
    elseif (player:HasItem(2278495,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 278)
    
    elseif (player:HasItem(2288495,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 279)
    
    elseif (player:HasItem(2298495,1) and player:GetClassAsString(0) == "Warlock") then
    player:GossipMenuAddItem(0,"|cff9700FFNecromancer Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 280)
    end
    --Warlock Bracers MASTERY END

--Mage Chest MASTERY
if (player:HasItem(2258437,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Robes |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 281)
    
    elseif (player:HasItem(2268437,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Robes |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 282)
    
    elseif (player:HasItem(2278437,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Robes |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 283)
    
    elseif (player:HasItem(2288437,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Robes |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 284)
    
    elseif (player:HasItem(2298437,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Robes |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 285)
    end
    --Mage Chest MASTERY END
--Mage Helm MASTERY
if (player:HasItem(2258436,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Cowl |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 286)
    
    elseif (player:HasItem(2268436,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Cowl |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 287)
    
    elseif (player:HasItem(2278436,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Cowl |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 288)
    
    elseif (player:HasItem(2288436,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Cowl |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 289)
    
    elseif (player:HasItem(2298436,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Cowl |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 290)
    end
    --Mage Helm MASTERY END

--Mage Legs MASTERY
if (player:HasItem(2258438,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Leggings |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 291)
    
    elseif (player:HasItem(2268438,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Leggings |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 292)
    
    elseif (player:HasItem(2278438,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Leggings |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 293)
    
    elseif (player:HasItem(2288438,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Leggings |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 294)
    
    elseif (player:HasItem(2298438,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Leggings |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 295)
    end
    --Mage Legs MASTERY END


--Mage Shoulders MASTERY
if (player:HasItem(2258439,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Mantle |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 296)
    
    elseif (player:HasItem(2268439,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Mantle |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 297)
    
    elseif (player:HasItem(2278439,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Mantle |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 298)
    
    elseif (player:HasItem(2288439,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Mantle |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 299)
    
    elseif (player:HasItem(2298439,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Mantle |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 300)
    end
    --Mage Shoulders MASTERY END

    
--Mage Belt MASTERY
if (player:HasItem(2258440,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 301)
    
    elseif (player:HasItem(2268440,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 302)
    
    elseif (player:HasItem(2278440,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 303)
    
    elseif (player:HasItem(2288440,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 304)
    
    elseif (player:HasItem(2298440,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 305)
    end
    --Mage Belt MASTERY END


--Mage Boots MASTERY
if (player:HasItem(2258441,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 306)
    
    elseif (player:HasItem(2268441,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 307)
    
    elseif (player:HasItem(2278441,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 308)
    
    elseif (player:HasItem(2288441,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 309)
    
    elseif (player:HasItem(2298441,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 310)
    end
    --Mage Boots MASTERY END


--Mage Gloves MASTERY
if (player:HasItem(2258435,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Gloves |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 311)
    
    elseif (player:HasItem(2268435,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Gloves |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 312)
    
    elseif (player:HasItem(2278435,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Gloves |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 313)
    
    elseif (player:HasItem(2288435,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Gloves |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 314)
    
    elseif (player:HasItem(2298435,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Gloves |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 315)
    end
    --Mage Gloves MASTERY END
--Mage Bracers MASTERY
if (player:HasItem(2258496,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 316)
    
    elseif (player:HasItem(2268496,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 317)
    
    elseif (player:HasItem(2278496,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 318)
    
    elseif (player:HasItem(2288496,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 319)
    
    elseif (player:HasItem(2298496,1) and player:GetClassAsString(0) == "Mage") then
    player:GossipMenuAddItem(0,"|cff9700FFFrostbane Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 320)
    end
    --Mage Bracers MASTERY END


--Priest Chest MASTERY
if (player:HasItem(2258442,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Vestments |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 321)
    
    elseif (player:HasItem(2268442,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Vestments |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 322)
    
    elseif (player:HasItem(2278442,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Vestments |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 323)
    
    elseif (player:HasItem(2288442,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Vestments |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 324)
    
    elseif (player:HasItem(2298442,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Vestments |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 325)
    end
    --Priest Chest MASTERY END
--Priest Helm MASTERY
if (player:HasItem(2258444,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Cowl |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 326)
    
    elseif (player:HasItem(2268444,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Cowl |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 327)
    
    elseif (player:HasItem(2278444,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Cowl |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 328)
    
    elseif (player:HasItem(2288444,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Cowl |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 329)
    
    elseif (player:HasItem(2298444,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Cowl |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 330)
    end
    --Priest Helm MASTERY END

--Priest Legs MASTERY
if (player:HasItem(2258445,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Breeches |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 331)
    
    elseif (player:HasItem(2268445,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Breeches |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 332)
    
    elseif (player:HasItem(2278445,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Breeches |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 333)
    
    elseif (player:HasItem(2288445,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Breeches |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 334)
    
    elseif (player:HasItem(2298445,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Breeches |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 335)
    end
    --Priest Legs MASTERY END


--Priest Shoulders MASTERY
if (player:HasItem(2258446,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Epaulets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 336)
    
    elseif (player:HasItem(2268446,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Epaulets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 337)
    
    elseif (player:HasItem(2278446,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Epaulets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 338)
    
    elseif (player:HasItem(2288446,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Epaulets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 339)
    
    elseif (player:HasItem(2298446,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Epaulets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 340)
    end
    --Priest Shoulders MASTERY END

    
--Priest Belt MASTERY
if (player:HasItem(2258448,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Belt |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 341)
    
    elseif (player:HasItem(2268448,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Belt |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 342)
    
    elseif (player:HasItem(2278448,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Belt |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 343)
    
    elseif (player:HasItem(2288448,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Belt |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 344)
    
    elseif (player:HasItem(2298448,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Belt |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 345)
    end
    --Priest Belt MASTERY END


--Priest Boots MASTERY
if (player:HasItem(2258447,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Boots |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 346)
    
    elseif (player:HasItem(2268447,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Boots |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 347)
    
    elseif (player:HasItem(2278447,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Boots |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 348)
    
    elseif (player:HasItem(2288447,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Boots |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 349)
    
    elseif (player:HasItem(2298447,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Boots |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 350)
    end
    --Priest Boots MASTERY END


--Priest Gloves MASTERY
if (player:HasItem(2258443,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Handguards |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 351)
    
    elseif (player:HasItem(2268443,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Handguards |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 352)
    
    elseif (player:HasItem(2278443,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Handguards |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 353)
    
    elseif (player:HasItem(2288443,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Handguards |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 354)
    
    elseif (player:HasItem(2298443,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Handguards |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 355)
    end
    --Priest Gloves MASTERY END
--Priest Bracers MASTERY
if (player:HasItem(2258497,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 356)
    
    elseif (player:HasItem(2268497,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 357)
    
    elseif (player:HasItem(2278497,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 358)
    
    elseif (player:HasItem(2288497,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 359)
    
    elseif (player:HasItem(2298497,1) and player:GetClassAsString(0) == "Priest") then
    player:GossipMenuAddItem(0,"|cff9700FFArchangel Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 360)
    end
    --Priest Bracers MASTERY END

--Shaman Helm 1 MASTERY
if (player:HasItem(2258451,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 361)
    
    elseif (player:HasItem(2268451,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 362)
    
    elseif (player:HasItem(2278451,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 363)
    
    elseif (player:HasItem(2288451,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 364)
    
    elseif (player:HasItem(2298451,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 365)
    end
    --Shaman  Helm 1 MASTERY END
--Shaman Chest 1 MASTERY 
if (player:HasItem(2258449,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 366)
    
    elseif (player:HasItem(2268449,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 367)
    
    elseif (player:HasItem(2278449,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 368)
    
    elseif (player:HasItem(2288449,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 369)
    
    elseif (player:HasItem(2298449,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 370)
    end
    --Shaman Chest 1 MASTERY END

--Shaman Legs 1 MASTERY
if (player:HasItem(2258452,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 371)
    
    elseif (player:HasItem(2268452,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 372)
    
    elseif (player:HasItem(2278452,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 373)
    
    elseif (player:HasItem(2288452,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 374)
    
    elseif (player:HasItem(2298452,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 375)
    end
    --Shaman Legs 1 MASTERY END


--Shaman Spaulders 1 MASTERY
if (player:HasItem(2258453,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 376)
    
    elseif (player:HasItem(2268453,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 377)
    
    elseif (player:HasItem(2278453,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 378)
    
    elseif (player:HasItem(2288453,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 379)
    
    elseif (player:HasItem(2298453,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 380)
    end
    --Shaman Spaulders 1 MASTERY END

    
--Shaman Belt 1 MASTERY
if (player:HasItem(2258454,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 381)
    
    elseif (player:HasItem(2268454,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 382)
    
    elseif (player:HasItem(2278454,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 383)
    
    elseif (player:HasItem(2288454,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 384)
    
    elseif (player:HasItem(2298454,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 385)
    end
    --Shaman Belt 1 MASTERY END


--Shaman Boots 1 MASTERY
if (player:HasItem(2258455,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 386)
    
    elseif (player:HasItem(2268455,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 387)
    
    elseif (player:HasItem(2278455,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 388)
    
    elseif (player:HasItem(2288455,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 389)
    
    elseif (player:HasItem(2298455,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 390)
    end
    --Shaman Boots 1 MASTERY END


--Shaman Gloves 1 MASTERY
if (player:HasItem(2258450,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 391)
    
    elseif (player:HasItem(2268450,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 392)
    
    elseif (player:HasItem(2278450,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 393)
    
    elseif (player:HasItem(2288450,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 394)
    
    elseif (player:HasItem(2298450,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 395)
    end
    --Shaman Gloves 1 MASTERY END
--Shaman Bracers 1 MASTERY
if (player:HasItem(2258498,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 396)
    
    elseif (player:HasItem(2268498,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 397)
    
    elseif (player:HasItem(2278498,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 398)
    
    elseif (player:HasItem(2288498,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 399)
    
    elseif (player:HasItem(2298498,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 400)
    end
    --Shaman Bracers 1 MASTERY END

--Shaman Chest 2 MASTERY
if (player:HasItem(2258484,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 401)
    
    elseif (player:HasItem(2268484,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 402)
    
    elseif (player:HasItem(2278484,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 403)
    
    elseif (player:HasItem(2288484,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 404)
    
    elseif (player:HasItem(2298484,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Armor |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 405)
    end
    --Shaman Chest 2 MASTERY END
--Shaman Helm 2 MASTERY
if (player:HasItem(2258486,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 406)
    
    elseif (player:HasItem(2268486,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 407)
    
    elseif (player:HasItem(2278486,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 408)
    
    elseif (player:HasItem(2288486,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 409)
    
    elseif (player:HasItem(2298486,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Helm |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 410)
    end
    --Shaman Helm 2 MASTERY END

--Shaman Legs 2 MASTERY
if (player:HasItem(2258487,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 411)
    
    elseif (player:HasItem(2268487,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 412)
    
    elseif (player:HasItem(2278487,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 413)
    
    elseif (player:HasItem(2288487,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 414)
    
    elseif (player:HasItem(2298487,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Leggings |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 415)
    end
    --Shaman Legs 2 MASTERY END


--Shaman Spaulders 2 MASTERY
if (player:HasItem(2258488,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 416)
    
    elseif (player:HasItem(2268488,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 417)
    
    elseif (player:HasItem(2278488,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 418)
    
    elseif (player:HasItem(2288488,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 419)
    
    elseif (player:HasItem(2298488,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Spaulders |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Spaulders.", 0, 420)
    end
    --Shaman Spaulders 2 MASTERY END

    
--Shaman Belt 2 MASTERY
if (player:HasItem(2258489,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 421)
    
    elseif (player:HasItem(2268489,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 422)
    
    elseif (player:HasItem(2278489,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 423)
    
    elseif (player:HasItem(2288489,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 424)
    
    elseif (player:HasItem(2298489,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Girdle |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 425)
    end
    --Shaman Belt 2 MASTERY END


--Shaman Boots 2 MASTERY
if (player:HasItem(2258490,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 426)
    
    elseif (player:HasItem(2268490,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 427)
    
    elseif (player:HasItem(2278490,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 428)
    
    elseif (player:HasItem(2288490,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 429)
    
    elseif (player:HasItem(2298490,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Sabatons |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 430)
    end
    --Shaman Boots 2 MASTERY END


--Shaman Gloves 2 MASTERY
if (player:HasItem(2258485,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 431)
    
    elseif (player:HasItem(2268485,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 432)
    
    elseif (player:HasItem(2278485,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 433)
    
    elseif (player:HasItem(2288485,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 434)
    
    elseif (player:HasItem(2298485,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 435)
    end
    --Shaman Gloves 2 MASTERY END
--Shaman Bracers 2 MASTERY
if (player:HasItem(2258503,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 436)
    
    elseif (player:HasItem(2268503,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 437)
    
    elseif (player:HasItem(2278503,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 438)
    
    elseif (player:HasItem(2288503,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 439)
    
    elseif (player:HasItem(2298503,1) and player:GetClassAsString(0) == "Shaman") then
    player:GossipMenuAddItem(0,"|cff9700FFLightning-Weave Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 440)
    end
    --Shaman Bracers 2 MASTERY END

--Death Knight Chest MASTERY
if (player:HasItem(2258459,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Embrace |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 441)
    
    elseif (player:HasItem(2268459,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Embrace |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 442)
    
    elseif (player:HasItem(2278459,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Embrace |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 443)
    
    elseif (player:HasItem(2288459,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Embrace |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 444)
    
    elseif (player:HasItem(2298459,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Embrace |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 445)
    end
    --Death Knight Chest MASTERY END
--Death Knight Helm MASTERY
if (player:HasItem(2258456,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Helmet |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 446)
    
    elseif (player:HasItem(2268456,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Helmet |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 447)
    
    elseif (player:HasItem(2278456,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Helmet |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 448)
    
    elseif (player:HasItem(2288456,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Helmet |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 449)
    
    elseif (player:HasItem(2298456,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Helmet |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 450)
    end
    --Death Knight Helm MASTERY END

--Death Knight Legs MASTERY
if (player:HasItem(2258457,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Leggings |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 451)
    
    elseif (player:HasItem(2268457,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Leggings |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 452)
    
    elseif (player:HasItem(2278457,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Leggings |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 453)
    
    elseif (player:HasItem(2288457,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Leggings |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 454)
    
    elseif (player:HasItem(2298457,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Leggings |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 455)
    end
    --Death Knight Legs MASTERY END


--Death Knight Shoulders MASTERY
if (player:HasItem(2258460,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Shoulderplates |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 456)
    
    elseif (player:HasItem(2268460,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Shoulderplates |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 457)
    
    elseif (player:HasItem(2278460,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Shoulderplates |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 458)
    
    elseif (player:HasItem(2288460,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Shoulderplates |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 459)
    
    elseif (player:HasItem(2298460,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Shoulderplates |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 460)
    end
    --Death Knight Shoulders MASTERY END

    
--Death Knight Belt MASTERY
if (player:HasItem(2258458,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Girdle |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 461)
    
    elseif (player:HasItem(2268458,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Girdle |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 462)
    
    elseif (player:HasItem(2278458,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Girdle |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 463)
    
    elseif (player:HasItem(2288458,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Girdle |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 464)
    
    elseif (player:HasItem(2298458,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Girdle |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 465)
    end
    --Death Knight Belt MASTERY END


--Death Knight Boots MASTERY
if (player:HasItem(2258462,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Sabatons |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 466)
    
    elseif (player:HasItem(2268462,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Sabatons |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 467)
    
    elseif (player:HasItem(2278462,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Sabatons |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 468)
    
    elseif (player:HasItem(2288462,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Sabatons |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 469)
    
    elseif (player:HasItem(2298462,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Sabatons |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 470)
    end
    --Death Knight Boots MASTERY END


--Death Knight Gloves MASTERY
if (player:HasItem(2258461,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 471)
    
    elseif (player:HasItem(2268461,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 472)
    
    elseif (player:HasItem(2278461,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 473)
    
    elseif (player:HasItem(2288461,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 474)
    
    elseif (player:HasItem(2298461,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 475)
    end
    --Death Knight Gloves MASTERY END
--Death Knight Bracers MASTERY
if (player:HasItem(2258499,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 476)
    
    elseif (player:HasItem(2268499,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 477)
    
    elseif (player:HasItem(2278499,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 478)
    
    elseif (player:HasItem(2288499,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 479)
    
    elseif (player:HasItem(2298499,1) and player:GetClassAsString(0) == "Death Knight") then
    player:GossipMenuAddItem(0,"|cff9700FFPlaguewalker Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 480)
    end
    --Death Knight Bracers MASTERY END


--Warrior Chest MASTERY
if (player:HasItem(2258463,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Breastplate |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 481)
    
    elseif (player:HasItem(2268463,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Breastplate |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 482)
    
    elseif (player:HasItem(2278463,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Breastplate |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 483)
    
    elseif (player:HasItem(2288463,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Breastplate |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 484)
    
    elseif (player:HasItem(2298463,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Breastplate |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Chest.", 0, 485)
    end
    --Warrior Chest MASTERY END
--Warrior Helm MASTERY
if (player:HasItem(2258465,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Helmet |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 486)
    
    elseif (player:HasItem(2268465,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Helmet |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 487)
    
    elseif (player:HasItem(2278465,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Helmet |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 488)
    
    elseif (player:HasItem(2288465,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Helmet |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 489)
    
    elseif (player:HasItem(2298465,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Helmet |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Helm.", 0, 490)
    end
    --Warrior Helm MASTERY END

--Warrior Legs MASTERY
if (player:HasItem(2258464,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Legplates |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 491)
    
    elseif (player:HasItem(2268464,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Legplates |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 492)
    
    elseif (player:HasItem(2278464,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Legplates |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 493)
    
    elseif (player:HasItem(2288464,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Legplates |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 494)
    
    elseif (player:HasItem(2298464,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Legplates |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Legs.", 0, 495)
    end
    --Warrior Legs MASTERY END


--Warrior Shoulders MASTERY
if (player:HasItem(2258466,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Pauldrons |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 496)
    
    elseif (player:HasItem(2268466,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Pauldrons |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 497)
    
    elseif (player:HasItem(2278466,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Pauldrons |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 498)
    
    elseif (player:HasItem(2288466,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Pauldrons |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 499)
    
    elseif (player:HasItem(2298466,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Pauldrons |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Shoulders.", 0, 500)
    end
    --Warrior Shoulders MASTERY END

    
--Warrior Belt MASTERY
if (player:HasItem(2258469,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Waistguard |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 501)
    
    elseif (player:HasItem(2268469,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Waistguard |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 502)
    
    elseif (player:HasItem(2278469,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Waistguard |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 503)
    
    elseif (player:HasItem(2288469,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Waistguard |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 504)
    
    elseif (player:HasItem(2298469,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Waistguard |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Belt.", 0, 505)
    end
    --Warrior Belt MASTERY END


--Warrior Boots MASTERY
if (player:HasItem(2258462,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Sabatons |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 506)
    
    elseif (player:HasItem(2268462,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Sabatons |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 507)
    
    elseif (player:HasItem(2278462,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Sabatons |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 508)
    
    elseif (player:HasItem(2288462,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Sabatons |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 509)
    
    elseif (player:HasItem(2298462,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Sabatons |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Boots.", 0, 510)
    end
    --Warrior Boots MASTERY END


--Warrior Gloves MASTERY
if (player:HasItem(2258468,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Gauntlets |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 511)
    
    elseif (player:HasItem(2268468,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Gauntlets |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 512)
    
    elseif (player:HasItem(2278468,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Gauntlets |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 513)
    
    elseif (player:HasItem(2288468,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Gauntlets |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 514)
    
    elseif (player:HasItem(2298468,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Gauntlets |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Gloves.", 0, 515)
    end
    --Warrior Gloves MASTERY END
--Warrior Bracers MASTERY
if (player:HasItem(2258500,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Bracers |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 516)
    
    elseif (player:HasItem(2268500,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Bracers |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 517)
    
    elseif (player:HasItem(2278500,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Bracers |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 518)
    
    elseif (player:HasItem(2288500,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Bracers |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 519)
    
    elseif (player:HasItem(2298500,1) and player:GetClassAsString(0) == "Warrior") then
    player:GossipMenuAddItem(0,"|cff9700FFStormwarden Bracers |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+5 Item Levels] |cff000000and an additional mastery bonus to your Bracers.", 0, 520)
    end
    --Warrior Bracers MASTERY END
	
--Ring of Ultimate Power
if (player:HasItem(5535553,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFRing of Ultimate Power |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+15 Item Levels] |cff000000and an additional mastery bonus to your Ring.", 0, 521)
    
    elseif (player:HasItem(5535554,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFRing of Ultimate Power |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+15 Item Levels] |cff000000and an additional mastery bonus to your Ring.", 0, 522)
    
    elseif (player:HasItem(5535555,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFRing of Ultimate Power |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+15 Item Levels] |cff000000and an additional mastery bonus to your Ring.", 0, 523)
    
    elseif (player:HasItem(5535556,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFRing of Ultimate Power |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+15 Item Levels] |cff000000and an additional mastery bonus to your Ring.", 0, 524)
    
    elseif (player:HasItem(5535557,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFRing of Ultimate Power |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+15 Item Levels] |cff000000and an additional mastery bonus to your Ring.", 0, 525)
    end
--Ring of Ultimate Power End

--Grandmaster Necklace Power
if (player:HasItem(1879830,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Warrior]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 526)
    
    elseif (player:HasItem(1879831,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Rogue]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 527)
    
    elseif (player:HasItem(1879832,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Deathknight]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 528)
    
    elseif (player:HasItem(1879833,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Hunter]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 529)
    
    elseif (player:HasItem(1879835,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Shaman]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 530)
        
    elseif (player:HasItem(1879836,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Druid]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 531)
    
    elseif (player:HasItem(1879837,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Priest]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 532)
    
    elseif (player:HasItem(1879838,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Warlock]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 533)
    
    elseif (player:HasItem(1879839,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Mage]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 534)
    
    elseif (player:HasItem(1879834,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFGrandmaster Necklace [Paladin]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+100 Item Levels] |cff000000and an additional mastery bonus to your Necklace.", 0, 535)

	end
--Grandmaster Necklace End
--Novu Shen
if (player:HasItem(995656,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFNovu-Shen |cffff0000[MASTERY I]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t1 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t500,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+20 Item Levels] |cff000000and an additional mastery bonus to your Cloak.", 0, 536)
    
    elseif (player:HasItem(995657,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFNovu-Shen |cffff0000[MASTERY II]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t2 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t1,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+20 Item Levels] |cff000000and an additional mastery bonus to your Cloak.", 0, 537)
    
    elseif (player:HasItem(995658,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFNovu-Shen |cffff0000[MASTERY III]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t3 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t5 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t2,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+20 Item Levels] |cff000000and an additional mastery bonus to your Cloak.", 0, 538)
    
    elseif (player:HasItem(995659,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFNovu-Shen |cffff0000[MASTERY IV]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t4 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t5,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+20 Item Levels] |cff000000and an additional mastery bonus to your Cloak.", 0, 539)
    
    elseif (player:HasItem(995660,1)) then
    player:GossipMenuAddItem(0,"|cff9700FFNovu-Shen |cffff0000[MASTERY V]|r\n\n|TInterface\\icons\\Frostfire Orb:25:25:-15:0|t5 Burden of Eternity\n|TInterface\\icons\\Titanforge_Stone:25:25:-15:0|t10 Titanforge Stone\n|TInterface\\icons\\INV_Misc_Apexis_Crystal:25:25:-15:0|t10,000,000 Shazzian Crystals\n\n|cff000000This upgrade will apply |cff2D7600[+20 Item Levels] |cff000000and an additional mastery bonus to your Cloak.", 0, 540)
    end
--Novu Shen End



player:GossipSendMenu(100, unit)

end



function onSelect(event, player, unit, sender, intid, code, id)
--Paladin Helmet Mastery
if(intid == 1) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258422, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268422, 1)
player:GossipComplete()
end
end
if(intid == 2) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268422, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278422, 1)
player:GossipComplete()
end
end
if(intid == 3) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278422, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288422, 1)
player:GossipComplete()
end
end
if(intid == 4) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288422, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298422, 1)
player:GossipComplete()
end
end
if(intid == 5) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298422, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308422, 1)
player:GossipComplete()
end
end
--Paladin Helmet Mastery END

--New Item Starts Here
if(intid == 6) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258421, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268421, 1)
player:GossipComplete()
end
end
if(intid == 7) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268421, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278421, 1)
player:GossipComplete()
end
end
if(intid == 8) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278421, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288421, 1)
player:GossipComplete()
end
end
if(intid == 9) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288421, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298421, 1)
player:GossipComplete()
end
end
if(intid == 10) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298421, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308421, 1)
player:GossipComplete()
end
end

--New Item Starts Here
if(intid == 11) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258423, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268423, 1)
player:GossipComplete()
end
end
if(intid == 12) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268423, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278423, 1)
player:GossipComplete()
end
end
if(intid == 13) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278423, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288423, 1)
player:GossipComplete()
end
end
if(intid == 14) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288423, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298423, 1)
player:GossipComplete()
end
end
if(intid == 15) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298423, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308423, 1)
player:GossipComplete()
end
end

--New Item Starts Here
if(intid == 16) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258424, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268424, 1)
player:GossipComplete()
end
end
if(intid == 17) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268424, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278424, 1)
player:GossipComplete()
end
end
if(intid == 18) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278424, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288424, 1)
player:GossipComplete()
end
end
if(intid == 19) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288424, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298424, 1)
player:GossipComplete()
end
end
if(intid == 20) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298424, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308424, 1)
player:GossipComplete()
end
end

--New Item Starts Here
if(intid == 21) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258425, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268425, 1)
player:GossipComplete()
end
end
if(intid == 22) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268425, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278425, 1)
player:GossipComplete()
end
end
if(intid == 23) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278425, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288425, 1)
player:GossipComplete()
end
end
if(intid == 24) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288425, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298425, 1)
player:GossipComplete()
end
end
if(intid == 25) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298425, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308425, 1)
player:GossipComplete()
end
end

--New Item Starts Here
if(intid == 26) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258426, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268426, 1)
player:GossipComplete()
end
end
if(intid == 27) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268426, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278426, 1)
player:GossipComplete()
end
end
if(intid == 28) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278426, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288426, 1)
player:GossipComplete()
end
end
if(intid == 29) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288426, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298426, 1)
player:GossipComplete()
end
end
if(intid == 30) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298426, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308426, 1)
player:GossipComplete()
end
end

--New Item Starts Here
if(intid == 31) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258427, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268427, 1)
player:GossipComplete()
end
end
if(intid == 32) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268427, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278427, 1)
player:GossipComplete()
end
end
if(intid == 33) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278427, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288427, 1)
player:GossipComplete()
end
end
if(intid == 34) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288427, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298427, 1)
player:GossipComplete()
end
end
if(intid == 35) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298427, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308427, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 36) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258494, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268494, 1)
player:GossipComplete()
end
end
if(intid == 37) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268494, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278494, 1)
player:GossipComplete()
end
end
if(intid == 38) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278494, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288494, 1)
player:GossipComplete()
end
end
if(intid == 39) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288494, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298494, 1)
player:GossipComplete()
end
end
if(intid == 40) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298494, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308494, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 41) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258477, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268477, 1)
player:GossipComplete()
end
end
if(intid == 42) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268477, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278477, 1)
player:GossipComplete()
end
end
if(intid == 43) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278477, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288477, 1)
player:GossipComplete()
end
end
if(intid == 44) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288477, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298477, 1)
player:GossipComplete()
end
end
if(intid == 45) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298477, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308477, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 46) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258478, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268478, 1)
player:GossipComplete()
end
end
if(intid == 47) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268478, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278478, 1)
player:GossipComplete()
end
end
if(intid == 48) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278478, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288478, 1)
player:GossipComplete()
end
end
if(intid == 49) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288478, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298478, 1)
player:GossipComplete()
end
end
if(intid == 50) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298478, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308478, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 51) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258479, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268479, 1)
player:GossipComplete()
end
end
if(intid == 52) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268479, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278479, 1)
player:GossipComplete()
end
end
if(intid == 53) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278479, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288479, 1)
player:GossipComplete()
end
end
if(intid == 54) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288479, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298479, 1)
player:GossipComplete()
end
end
if(intid == 55) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298479, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308479, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 56) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258480, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268480, 1)
player:GossipComplete()
end
end
if(intid == 57) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268480, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278480, 1)
player:GossipComplete()
end
end
if(intid == 58) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278480, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288480, 1)
player:GossipComplete()
end
end
if(intid == 59) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288480, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298480, 1)
player:GossipComplete()
end
end
if(intid == 60) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298480, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308480, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 61) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258481, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268481, 1)
player:GossipComplete()
end
end
if(intid == 62) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268481, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278481, 1)
player:GossipComplete()
end
end
if(intid == 63) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278481, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288481, 1)
player:GossipComplete()
end
end
if(intid == 64) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288481, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298481, 1)
player:GossipComplete()
end
end
if(intid == 65) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298481, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308481, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 66) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258482, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268482, 1)
player:GossipComplete()
end
end
if(intid == 67) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268482, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278482, 1)
player:GossipComplete()
end
end
if(intid == 68) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278482, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288482, 1)
player:GossipComplete()
end
end
if(intid == 69) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288482, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298482, 1)
player:GossipComplete()
end
end
if(intid == 70) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298482, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308482, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 71) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258483, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268483, 1)
player:GossipComplete()
end
end
if(intid == 72) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268483, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278483, 1)
player:GossipComplete()
end
end
if(intid == 73) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278483, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288483, 1)
player:GossipComplete()
end
end
if(intid == 74) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288483, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298483, 1)
player:GossipComplete()
end
end
if(intid == 75) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298483, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308483, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 76) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258502, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268502, 1)
player:GossipComplete()
end
end
if(intid == 77) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268502, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278502, 1)
player:GossipComplete()
end
end
if(intid == 78) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278502, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288502, 1)
player:GossipComplete()
end
end
if(intid == 79) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288502, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298502, 1)
player:GossipComplete()
end
end
if(intid == 80) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298502, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308502, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 81) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258401, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268401, 1)
player:GossipComplete()
end
end
if(intid == 82) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268401, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278401, 1)
player:GossipComplete()
end
end
if(intid == 83) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278401, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288401, 1)
player:GossipComplete()
end
end
if(intid == 84) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288401, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298401, 1)
player:GossipComplete()
end
end
if(intid == 85) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298401, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308401, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 86) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258404, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268404, 1)
player:GossipComplete()
end
end
if(intid == 87) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268404, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278404, 1)
player:GossipComplete()
end
end
if(intid == 88) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278404, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288404, 1)
player:GossipComplete()
end
end
if(intid == 89) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288404, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298404, 1)
player:GossipComplete()
end
end
if(intid == 90) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298404, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308404, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 91) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258405, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268405, 1)
player:GossipComplete()
end
end
if(intid == 92) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268405, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278405, 1)
player:GossipComplete()
end
end
if(intid == 93) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278405, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288405, 1)
player:GossipComplete()
end
end
if(intid == 94) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288405, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298405, 1)
player:GossipComplete()
end
end
if(intid == 95) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298405, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308405, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 96) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258400, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268400, 1)
player:GossipComplete()
end
end
if(intid == 97) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268400, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278400, 1)
player:GossipComplete()
end
end
if(intid == 98) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278400, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288400, 1)
player:GossipComplete()
end
end
if(intid == 99) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288400, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298400, 1)
player:GossipComplete()
end
end
if(intid == 100) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298400, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308400, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 101) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258406, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268406, 1)
player:GossipComplete()
end
end
if(intid == 102) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268406, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278406, 1)
player:GossipComplete()
end
end
if(intid == 103) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278406, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288406, 1)
player:GossipComplete()
end
end
if(intid == 104) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288406, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298406, 1)
player:GossipComplete()
end
end
if(intid == 105) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298406, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308406, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 106) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258402, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268402, 1)
player:GossipComplete()
end
end
if(intid == 107) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268402, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278402, 1)
player:GossipComplete()
end
end
if(intid == 108) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278402, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288402, 1)
player:GossipComplete()
end
end
if(intid == 109) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288402, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298402, 1)
player:GossipComplete()
end
end
if(intid == 110) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298402, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308402, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 111) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258403, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268403, 1)
player:GossipComplete()
end
end
if(intid == 112) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268403, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278403, 1)
player:GossipComplete()
end
end
if(intid == 113) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278403, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288403, 1)
player:GossipComplete()
end
end
if(intid == 114) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288403, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298403, 1)
player:GossipComplete()
end
end
if(intid == 115) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298403, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308403, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 116) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258491, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268491, 1)
player:GossipComplete()
end
end
if(intid == 117) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268491, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278491, 1)
player:GossipComplete()
end
end
if(intid == 118) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278491, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288491, 1)
player:GossipComplete()
end
end
if(intid == 119) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288491, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298491, 1)
player:GossipComplete()
end
end
if(intid == 120) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298491, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308491, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 121) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258411, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268411, 1)
player:GossipComplete()
end
end
if(intid == 122) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268411, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278411, 1)
player:GossipComplete()
end
end
if(intid == 123) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278411, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288411, 1)
player:GossipComplete()
end
end
if(intid == 124) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288411, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298411, 1)
player:GossipComplete()
end
end
if(intid == 125) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298411, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308411, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 126) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258410, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268410, 1)
player:GossipComplete()
end
end
if(intid == 127) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268410, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278410, 1)
player:GossipComplete()
end
end
if(intid == 128) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278410, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288410, 1)
player:GossipComplete()
end
end
if(intid == 129) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288410, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298410, 1)
player:GossipComplete()
end
end
if(intid == 130) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298410, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308410, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 131) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258412, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268412, 1)
player:GossipComplete()
end
end
if(intid == 132) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268412, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278412, 1)
player:GossipComplete()
end
end
if(intid == 133) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278412, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288412, 1)
player:GossipComplete()
end
end
if(intid == 134) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288412, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298412, 1)
player:GossipComplete()
end
end
if(intid == 135) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298412, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308412, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 136) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258413, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268413, 1)
player:GossipComplete()
end
end
if(intid == 137) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268413, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278413, 1)
player:GossipComplete()
end
end
if(intid == 138) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278413, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288413, 1)
player:GossipComplete()
end
end
if(intid == 139) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288413, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298413, 1)
player:GossipComplete()
end
end
if(intid == 140) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298413, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308413, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 141) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258407, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268407, 1)
player:GossipComplete()
end
end
if(intid == 142) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268407, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278407, 1)
player:GossipComplete()
end
end
if(intid == 143) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278407, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288407, 1)
player:GossipComplete()
end
end
if(intid == 144) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288407, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298407, 1)
player:GossipComplete()
end
end
if(intid == 145) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298407, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308407, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 146) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258408, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268408, 1)
player:GossipComplete()
end
end
if(intid == 147) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268408, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278408, 1)
player:GossipComplete()
end
end
if(intid == 148) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278408, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288408, 1)
player:GossipComplete()
end
end
if(intid == 149) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288408, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298408, 1)
player:GossipComplete()
end
end
if(intid == 150) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298408, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308408, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 151) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258409, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268409, 1)
player:GossipComplete()
end
end
if(intid == 152) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268409, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278409, 1)
player:GossipComplete()
end
end
if(intid == 153) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278409, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288409, 1)
player:GossipComplete()
end
end
if(intid == 154) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288409, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298409, 1)
player:GossipComplete()
end
end
if(intid == 155) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298409, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308409, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 156) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258492, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268492, 1)
player:GossipComplete()
end
end
if(intid == 157) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268492, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278492, 1)
player:GossipComplete()
end
end
if(intid == 158) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278492, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288492, 1)
player:GossipComplete()
end
end
if(intid == 159) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288492, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298492, 1)
player:GossipComplete()
end
end
if(intid == 160) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298492, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308492, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 161) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258473, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268473, 1)
player:GossipComplete()
end
end
if(intid == 162) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268473, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278473, 1)
player:GossipComplete()
end
end
if(intid == 163) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278473, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288473, 1)
player:GossipComplete()
end
end
if(intid == 164) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288473, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298473, 1)
player:GossipComplete()
end
end
if(intid == 165) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298473, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308473, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 166) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258474, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268474, 1)
player:GossipComplete()
end
end
if(intid == 167) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268474, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278474, 1)
player:GossipComplete()
end
end
if(intid == 168) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278474, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288474, 1)
player:GossipComplete()
end
end
if(intid == 169) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288474, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298474, 1)
player:GossipComplete()
end
end
if(intid == 170) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298474, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308474, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 171) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258475, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268475, 1)
player:GossipComplete()
end
end
if(intid == 172) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268475, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278475, 1)
player:GossipComplete()
end
end
if(intid == 173) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278475, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288475, 1)
player:GossipComplete()
end
end
if(intid == 174) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288475, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298475, 1)
player:GossipComplete()
end
end
if(intid == 175) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298475, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308475, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 176) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258476, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268476, 1)
player:GossipComplete()
end
end
if(intid == 177) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268476, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278476, 1)
player:GossipComplete()
end
end
if(intid == 178) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278476, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288476, 1)
player:GossipComplete()
end
end
if(intid == 179) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288476, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298476, 1)
player:GossipComplete()
end
end
if(intid == 180) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298476, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308476, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 181) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258470, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268470, 1)
player:GossipComplete()
end
end
if(intid == 182) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268470, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278470, 1)
player:GossipComplete()
end
end
if(intid == 183) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278470, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288470, 1)
player:GossipComplete()
end
end
if(intid == 184) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288470, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298470, 1)
player:GossipComplete()
end
end
if(intid == 185) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298470, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308470, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 186) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258471, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268471, 1)
player:GossipComplete()
end
end
if(intid == 187) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268471, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278471, 1)
player:GossipComplete()
end
end
if(intid == 188) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278471, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288471, 1)
player:GossipComplete()
end
end
if(intid == 189) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288471, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298471, 1)
player:GossipComplete()
end
end
if(intid == 190) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298471, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308471, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 191) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258472, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268472, 1)
player:GossipComplete()
end
end
if(intid == 192) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268472, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278472, 1)
player:GossipComplete()
end
end
if(intid == 193) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278472, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288472, 1)
player:GossipComplete()
end
end
if(intid == 194) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288472, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298472, 1)
player:GossipComplete()
end
end
if(intid == 195) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298472, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308472, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 196) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258501, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268501, 1)
player:GossipComplete()
end
end
if(intid == 197) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268501, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278501, 1)
player:GossipComplete()
end
end
if(intid == 198) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278501, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288501, 1)
player:GossipComplete()
end
end
if(intid == 199) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288501, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298501, 1)
player:GossipComplete()
end
end
if(intid == 200) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298501, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308501, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 201) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258420, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268420, 1)
player:GossipComplete()
end
end
if(intid == 202) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268420, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278420, 1)
player:GossipComplete()
end
end
if(intid == 203) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278420, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288420, 1)
player:GossipComplete()
end
end
if(intid == 204) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288420, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298420, 1)
player:GossipComplete()
end
end
if(intid == 205) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298420, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308420, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 206) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258417, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268417, 1)
player:GossipComplete()
end
end
if(intid == 207) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268417, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278417, 1)
player:GossipComplete()
end
end
if(intid == 208) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278417, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288417, 1)
player:GossipComplete()
end
end
if(intid == 209) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288417, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298417, 1)
player:GossipComplete()
end
end
if(intid == 210) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298417, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308417, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 211) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258416, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268416, 1)
player:GossipComplete()
end
end
if(intid == 212) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268416, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278416, 1)
player:GossipComplete()
end
end
if(intid == 213) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278416, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288416, 1)
player:GossipComplete()
end
end
if(intid == 214) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288416, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298416, 1)
player:GossipComplete()
end
end
if(intid == 215) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298416, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308416, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 216) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258415, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268415, 1)
player:GossipComplete()
end
end
if(intid == 217) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268415, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278415, 1)
player:GossipComplete()
end
end
if(intid == 218) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278415, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288415, 1)
player:GossipComplete()
end
end
if(intid == 219) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288415, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298415, 1)
player:GossipComplete()
end
end
if(intid == 220) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298415, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308415, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 221) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258414, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268414, 1)
player:GossipComplete()
end
end
if(intid == 222) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268414, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278414, 1)
player:GossipComplete()
end
end
if(intid == 223) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278414, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288414, 1)
player:GossipComplete()
end
end
if(intid == 224) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288414, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298414, 1)
player:GossipComplete()
end
end
if(intid == 225) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298414, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308414, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 226) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258419, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268419, 1)
player:GossipComplete()
end
end
if(intid == 227) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268419, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278419, 1)
player:GossipComplete()
end
end
if(intid == 228) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278419, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288419, 1)
player:GossipComplete()
end
end
if(intid == 229) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288419, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298419, 1)
player:GossipComplete()
end
end
if(intid == 230) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298419, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308419, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 231) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258418, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268418, 1)
player:GossipComplete()
end
end
if(intid == 232) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268418, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278418, 1)
player:GossipComplete()
end
end
if(intid == 233) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278418, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288418, 1)
player:GossipComplete()
end
end
if(intid == 234) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288418, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298418, 1)
player:GossipComplete()
end
end
if(intid == 235) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298418, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308418, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 236) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258493, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268493, 1)
player:GossipComplete()
end
end
if(intid == 237) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268493, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278493, 1)
player:GossipComplete()
end
end
if(intid == 238) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278493, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288493, 1)
player:GossipComplete()
end
end
if(intid == 239) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288493, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298493, 1)
player:GossipComplete()
end
end
if(intid == 240) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298493, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308493, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 241) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258432, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268432, 1)
player:GossipComplete()
end
end
if(intid == 242) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268432, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278432, 1)
player:GossipComplete()
end
end
if(intid == 243) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278432, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288432, 1)
player:GossipComplete()
end
end
if(intid == 244) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288432, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298432, 1)
player:GossipComplete()
end
end
if(intid == 245) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298432, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308432, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 246) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258430, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268430, 1)
player:GossipComplete()
end
end
if(intid == 247) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268430, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278430, 1)
player:GossipComplete()
end
end
if(intid == 248) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278430, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288430, 1)
player:GossipComplete()
end
end
if(intid == 249) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288430, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298430, 1)
player:GossipComplete()
end
end
if(intid == 250) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298430, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308430, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 251) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258431, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268431, 1)
player:GossipComplete()
end
end
if(intid == 252) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268431, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278431, 1)
player:GossipComplete()
end
end
if(intid == 253) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278431, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288431, 1)
player:GossipComplete()
end
end
if(intid == 254) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288431, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298431, 1)
player:GossipComplete()
end
end
if(intid == 255) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298431, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308431, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 256) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258433, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268433, 1)
player:GossipComplete()
end
end
if(intid == 257) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268433, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278433, 1)
player:GossipComplete()
end
end
if(intid == 258) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278433, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288433, 1)
player:GossipComplete()
end
end
if(intid == 259) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288433, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298433, 1)
player:GossipComplete()
end
end
if(intid == 260) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298433, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308433, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 261) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258434, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268434, 1)
player:GossipComplete()
end
end
if(intid == 262) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268434, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278434, 1)
player:GossipComplete()
end
end
if(intid == 263) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278434, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288434, 1)
player:GossipComplete()
end
end
if(intid == 264) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288434, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298434, 1)
player:GossipComplete()
end
end
if(intid == 265) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298434, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308434, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 266) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258428, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268428, 1)
player:GossipComplete()
end
end
if(intid == 267) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268428, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278428, 1)
player:GossipComplete()
end
end
if(intid == 268) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278428, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288428, 1)
player:GossipComplete()
end
end
if(intid == 269) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288428, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298428, 1)
player:GossipComplete()
end
end
if(intid == 270) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298428, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308428, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 271) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258429, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268429, 1)
player:GossipComplete()
end
end
if(intid == 272) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268429, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278429, 1)
player:GossipComplete()
end
end
if(intid == 273) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278429, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288429, 1)
player:GossipComplete()
end
end
if(intid == 274) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288429, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298429, 1)
player:GossipComplete()
end
end
if(intid == 275) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298429, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308429, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 276) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258495, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268495, 1)
player:GossipComplete()
end
end
if(intid == 277) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268495, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278495, 1)
player:GossipComplete()
end
end
if(intid == 278) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278495, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288495, 1)
player:GossipComplete()
end
end
if(intid == 279) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288495, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298495, 1)
player:GossipComplete()
end
end
if(intid == 280) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298495, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308495, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 281) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258437, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268437, 1)
player:GossipComplete()
end
end
if(intid == 282) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268437, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278437, 1)
player:GossipComplete()
end
end
if(intid == 283) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278437, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288437, 1)
player:GossipComplete()
end
end
if(intid == 284) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288437, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298437, 1)
player:GossipComplete()
end
end
if(intid == 285) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298437, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308437, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 286) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258436, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268436, 1)
player:GossipComplete()
end
end
if(intid == 287) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268436, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278436, 1)
player:GossipComplete()
end
end
if(intid == 288) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278436, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288436, 1)
player:GossipComplete()
end
end
if(intid == 289) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288436, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298436, 1)
player:GossipComplete()
end
end
if(intid == 290) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298436, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308436, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 291) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258438, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268438, 1)
player:GossipComplete()
end
end
if(intid == 292) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268438, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278438, 1)
player:GossipComplete()
end
end
if(intid == 293) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278438, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288438, 1)
player:GossipComplete()
end
end
if(intid == 294) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288438, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298438, 1)
player:GossipComplete()
end
end
if(intid == 295) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298438, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308438, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 296) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258439, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268439, 1)
player:GossipComplete()
end
end
if(intid == 297) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268439, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278439, 1)
player:GossipComplete()
end
end
if(intid == 298) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278439, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288439, 1)
player:GossipComplete()
end
end
if(intid == 299) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288439, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298439, 1)
player:GossipComplete()
end
end
if(intid == 300) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298439, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308439, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 301) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258440, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268440, 1)
player:GossipComplete()
end
end
if(intid == 302) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268440, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278440, 1)
player:GossipComplete()
end
end
if(intid == 303) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278440, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288440, 1)
player:GossipComplete()
end
end
if(intid == 304) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288440, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298440, 1)
player:GossipComplete()
end
end
if(intid == 305) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298440, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308440, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 306) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258441, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268441, 1)
player:GossipComplete()
end
end
if(intid == 307) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268441, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278441, 1)
player:GossipComplete()
end
end
if(intid == 308) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278441, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288441, 1)
player:GossipComplete()
end
end
if(intid == 309) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288441, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298441, 1)
player:GossipComplete()
end
end
if(intid == 310) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298441, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308441, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 311) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258435, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268435, 1)
player:GossipComplete()
end
end
if(intid == 312) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268435, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278435, 1)
player:GossipComplete()
end
end
if(intid == 313) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278435, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288435, 1)
player:GossipComplete()
end
end
if(intid == 314) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288435, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298435, 1)
player:GossipComplete()
end
end
if(intid == 315) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298435, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308435, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 316) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258496, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268496, 1)
player:GossipComplete()
end
end
if(intid == 317) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268496, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278496, 1)
player:GossipComplete()
end
end
if(intid == 318) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278496, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288496, 1)
player:GossipComplete()
end
end
if(intid == 319) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288496, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298496, 1)
player:GossipComplete()
end
end
if(intid == 320) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298496, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308496, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 321) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258442, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268442, 1)
player:GossipComplete()
end
end
if(intid == 322) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268442, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278442, 1)
player:GossipComplete()
end
end
if(intid == 323) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278442, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288442, 1)
player:GossipComplete()
end
end
if(intid == 324) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288442, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298442, 1)
player:GossipComplete()
end
end
if(intid == 325) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298442, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308442, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 326) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258444, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268444, 1)
player:GossipComplete()
end
end
if(intid == 327) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268444, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278444, 1)
player:GossipComplete()
end
end
if(intid == 328) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278444, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288444, 1)
player:GossipComplete()
end
end
if(intid == 329) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288444, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298444, 1)
player:GossipComplete()
end
end
if(intid == 330) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298444, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308444, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 331) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258445, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268445, 1)
player:GossipComplete()
end
end
if(intid == 332) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268445, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278445, 1)
player:GossipComplete()
end
end
if(intid == 333) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278445, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288445, 1)
player:GossipComplete()
end
end
if(intid == 334) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288445, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298445, 1)
player:GossipComplete()
end
end
if(intid == 335) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298445, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308445, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 336) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258446, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268446, 1)
player:GossipComplete()
end
end
if(intid == 337) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268446, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278446, 1)
player:GossipComplete()
end
end
if(intid == 338) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278446, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288446, 1)
player:GossipComplete()
end
end
if(intid == 339) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288446, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298446, 1)
player:GossipComplete()
end
end
if(intid == 340) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298446, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308446, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 341) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258448, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268448, 1)
player:GossipComplete()
end
end
if(intid == 342) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268448, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278448, 1)
player:GossipComplete()
end
end
if(intid == 343) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278448, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288448, 1)
player:GossipComplete()
end
end
if(intid == 344) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288448, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298448, 1)
player:GossipComplete()
end
end
if(intid == 345) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298448, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308448, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 346) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258447, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268447, 1)
player:GossipComplete()
end
end
if(intid == 347) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268447, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278447, 1)
player:GossipComplete()
end
end
if(intid == 348) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278447, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288447, 1)
player:GossipComplete()
end
end
if(intid == 349) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288447, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298447, 1)
player:GossipComplete()
end
end
if(intid == 350) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298447, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308447, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 351) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258443, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268443, 1)
player:GossipComplete()
end
end
if(intid == 352) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268443, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278443, 1)
player:GossipComplete()
end
end
if(intid == 353) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278443, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288443, 1)
player:GossipComplete()
end
end
if(intid == 354) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288443, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298443, 1)
player:GossipComplete()
end
end
if(intid == 355) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298443, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308443, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 356) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258497, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268497, 1)
player:GossipComplete()
end
end
if(intid == 357) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268497, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278497, 1)
player:GossipComplete()
end
end
if(intid == 358) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278497, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288497, 1)
player:GossipComplete()
end
end
if(intid == 359) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288497, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298497, 1)
player:GossipComplete()
end
end
if(intid == 360) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298497, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308497, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 361) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258451, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268451, 1)
player:GossipComplete()
end
end
if(intid == 362) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268451, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278451, 1)
player:GossipComplete()
end
end
if(intid == 363) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278451, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288451, 1)
player:GossipComplete()
end
end
if(intid == 364) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288451, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298451, 1)
player:GossipComplete()
end
end
if(intid == 365) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298451, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308451, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 366) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258449, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268449, 1)
player:GossipComplete()
end
end
if(intid == 367) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268449, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278449, 1)
player:GossipComplete()
end
end
if(intid == 368) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278449, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288449, 1)
player:GossipComplete()
end
end
if(intid == 369) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288449, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298449, 1)
player:GossipComplete()
end
end
if(intid == 370) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298449, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308449, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 371) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258452, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268452, 1)
player:GossipComplete()
end
end
if(intid == 372) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268452, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278452, 1)
player:GossipComplete()
end
end
if(intid == 373) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278452, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288452, 1)
player:GossipComplete()
end
end
if(intid == 374) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288452, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298452, 1)
player:GossipComplete()
end
end
if(intid == 375) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298452, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308452, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 376) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258453, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268453, 1)
player:GossipComplete()
end
end
if(intid == 377) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268453, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278453, 1)
player:GossipComplete()
end
end
if(intid == 378) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278453, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288453, 1)
player:GossipComplete()
end
end
if(intid == 379) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288453, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298453, 1)
player:GossipComplete()
end
end
if(intid == 380) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298453, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308453, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 381) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258454, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268454, 1)
player:GossipComplete()
end
end
if(intid == 382) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268454, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278454, 1)
player:GossipComplete()
end
end
if(intid == 383) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278454, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288454, 1)
player:GossipComplete()
end
end
if(intid == 384) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288454, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298454, 1)
player:GossipComplete()
end
end
if(intid == 385) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298454, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308454, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 386) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258455, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268455, 1)
player:GossipComplete()
end
end
if(intid == 387) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268455, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278455, 1)
player:GossipComplete()
end
end
if(intid == 388) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278455, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288455, 1)
player:GossipComplete()
end
end
if(intid == 389) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288455, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298455, 1)
player:GossipComplete()
end
end
if(intid == 390) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298455, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308455, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 391) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258450, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268450, 1)
player:GossipComplete()
end
end
if(intid == 392) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268450, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278450, 1)
player:GossipComplete()
end
end
if(intid == 393) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278450, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288450, 1)
player:GossipComplete()
end
end
if(intid == 394) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288450, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298450, 1)
player:GossipComplete()
end
end
if(intid == 395) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298450, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308450, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 396) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258498, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268498, 1)
player:GossipComplete()
end
end
if(intid == 397) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268498, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278498, 1)
player:GossipComplete()
end
end
if(intid == 398) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278498, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288498, 1)
player:GossipComplete()
end
end
if(intid == 399) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288498, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298498, 1)
player:GossipComplete()
end
end
if(intid == 400) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298498, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308498, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 401) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258484, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268484, 1)
player:GossipComplete()
end
end
if(intid == 402) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268484, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278484, 1)
player:GossipComplete()
end
end
if(intid == 403) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278484, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288484, 1)
player:GossipComplete()
end
end
if(intid == 404) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288484, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298484, 1)
player:GossipComplete()
end
end
if(intid == 405) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298484, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308484, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 406) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258486, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268486, 1)
player:GossipComplete()
end
end
if(intid == 407) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268486, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278486, 1)
player:GossipComplete()
end
end
if(intid == 408) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278486, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288486, 1)
player:GossipComplete()
end
end
if(intid == 409) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288486, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298486, 1)
player:GossipComplete()
end
end
if(intid == 410) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298486, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308486, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 411) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258487, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268487, 1)
player:GossipComplete()
end
end
if(intid == 412) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268487, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278487, 1)
player:GossipComplete()
end
end
if(intid == 413) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278487, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288487, 1)
player:GossipComplete()
end
end
if(intid == 414) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288487, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298487, 1)
player:GossipComplete()
end
end
if(intid == 415) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298487, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308487, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 416) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258488, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268488, 1)
player:GossipComplete()
end
end
if(intid == 417) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268488, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278488, 1)
player:GossipComplete()
end
end
if(intid == 418) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278488, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288488, 1)
player:GossipComplete()
end
end
if(intid == 419) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288488, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298488, 1)
player:GossipComplete()
end
end
if(intid == 420) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298488, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308488, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 421) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258489, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268489, 1)
player:GossipComplete()
end
end
if(intid == 489) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268489, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278489, 1)
player:GossipComplete()
end
end
if(intid == 423) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278489, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288489, 1)
player:GossipComplete()
end
end
if(intid == 424) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288489, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298489, 1)
player:GossipComplete()
end
end
if(intid == 425) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298489, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308490, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 490) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258490, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268490, 1)
player:GossipComplete()
end
end
if(intid == 427) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268490, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278490, 1)
player:GossipComplete()
end
end
if(intid == 428) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278490, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288490, 1)
player:GossipComplete()
end
end
if(intid == 429) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288490, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298490, 1)
player:GossipComplete()
end
end
if(intid == 430) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298485, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308485, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 431) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258485, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268485, 1)
player:GossipComplete()
end
end
if(intid == 432) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268485, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278485, 1)
player:GossipComplete()
end
end
if(intid == 433) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278485, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288485, 1)
player:GossipComplete()
end
end
if(intid == 434) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288485, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298485, 1)
player:GossipComplete()
end
end
if(intid == 435) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298503, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308503, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 436) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258503, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268503, 1)
player:GossipComplete()
end
end
if(intid == 437) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268503, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278503, 1)
player:GossipComplete()
end
end
if(intid == 438) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278503, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288503, 1)
player:GossipComplete()
end
end
if(intid == 439) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288503, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298503, 1)
player:GossipComplete()
end
end
if(intid == 440) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298459, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308459, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 441) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258459, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268459, 1)
player:GossipComplete()
end
end
if(intid == 442) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268459, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278459, 1)
player:GossipComplete()
end
end
if(intid == 443) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278459, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288459, 1)
player:GossipComplete()
end
end
if(intid == 444) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288459, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298459, 1)
player:GossipComplete()
end
end
if(intid == 445) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298459, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308459, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 446) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258456, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268456, 1)
player:GossipComplete()
end
end
if(intid == 447) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268456, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278456, 1)
player:GossipComplete()
end
end
if(intid == 448) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278456, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288456, 1)
player:GossipComplete()
end
end
if(intid == 449) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288456, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298456, 1)
player:GossipComplete()
end
end
if(intid == 450) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298456, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308456, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 451) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258457, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268457, 1)
player:GossipComplete()
end
end
if(intid == 452) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268457, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278457, 1)
player:GossipComplete()
end
end
if(intid == 453) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278457, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288457, 1)
player:GossipComplete()
end
end
if(intid == 454) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288457, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298457, 1)
player:GossipComplete()
end
end
if(intid == 455) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298457, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308457, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 456) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258460, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268460, 1)
player:GossipComplete()
end
end
if(intid == 457) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268460, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278460, 1)
player:GossipComplete()
end
end
if(intid == 458) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278460, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288460, 1)
player:GossipComplete()
end
end
if(intid == 459) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288460, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298460, 1)
player:GossipComplete()
end
end
if(intid == 460) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298460, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308460, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 461) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258458, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268458, 1)
player:GossipComplete()
end
end
if(intid == 462) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268458, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278458, 1)
player:GossipComplete()
end
end
if(intid == 463) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278458, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288458, 1)
player:GossipComplete()
end
end
if(intid == 464) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288458, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298458, 1)
player:GossipComplete()
end
end
if(intid == 465) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298458, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308458, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 466) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258462, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268462, 1)
player:GossipComplete()
end
end
if(intid == 467) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268462, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278462, 1)
player:GossipComplete()
end
end
if(intid == 468) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278462, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288462, 1)
player:GossipComplete()
end
end
if(intid == 469) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288462, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298462, 1)
player:GossipComplete()
end
end
if(intid == 470) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298462, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308462, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 471) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258461, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268461, 1)
player:GossipComplete()
end
end
if(intid == 472) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268461, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278461, 1)
player:GossipComplete()
end
end
if(intid == 473) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278461, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288461, 1)
player:GossipComplete()
end
end
if(intid == 474) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288461, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298461, 1)
player:GossipComplete()
end
end
if(intid == 475) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298461, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308461, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 476) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258499, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268499, 1)
player:GossipComplete()
end
end
if(intid == 477) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268499, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278499, 1)
player:GossipComplete()
end
end
if(intid == 478) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278499, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288499, 1)
player:GossipComplete()
end
end
if(intid == 479) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288499, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298499, 1)
player:GossipComplete()
end
end
if(intid == 480) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298499, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308499, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 481) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258463, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268463, 1)
player:GossipComplete()
end
end
if(intid == 482) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268463, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278463, 1)
player:GossipComplete()
end
end
if(intid == 483) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278463, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288463, 1)
player:GossipComplete()
end
end
if(intid == 484) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288463, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298463, 1)
player:GossipComplete()
end
end
if(intid == 485) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298463, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308463, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 486) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258465, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268465, 1)
player:GossipComplete()
end
end
if(intid == 487) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268465, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278465, 1)
player:GossipComplete()
end
end
if(intid == 488) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278465, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288465, 1)
player:GossipComplete()
end
end
if(intid == 489) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288465, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298465, 1)
player:GossipComplete()
end
end
if(intid == 490) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298465, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308465, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 491) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258464, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268464, 1)
player:GossipComplete()
end
end
if(intid == 492) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268464, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278464, 1)
player:GossipComplete()
end
end
if(intid == 493) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278464, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288464, 1)
player:GossipComplete()
end
end
if(intid == 494) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288464, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298464, 1)
player:GossipComplete()
end
end
if(intid == 495) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298464, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308464, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 496) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258466, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268466, 1)
player:GossipComplete()
end
end
if(intid == 497) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268466, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278466, 1)
player:GossipComplete()
end
end
if(intid == 498) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278466, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288466, 1)
player:GossipComplete()
end
end
if(intid == 499) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288466, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298466, 1)
player:GossipComplete()
end
end
if(intid == 500) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298466, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308466, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 501) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258469, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268469, 1)
player:GossipComplete()
end
end
if(intid == 502) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268469, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278469, 1)
player:GossipComplete()
end
end
if(intid == 503) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278469, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288469, 1)
player:GossipComplete()
end
end
if(intid == 504) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288469, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298469, 1)
player:GossipComplete()
end
end
if(intid == 505) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298469, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308469, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 506) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258462, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268462, 1)
player:GossipComplete()
end
end
if(intid == 507) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268462, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278462, 1)
player:GossipComplete()
end
end
if(intid == 508) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278462, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288462, 1)
player:GossipComplete()
end
end
if(intid == 509) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288462, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298462, 1)
player:GossipComplete()
end
end
if(intid == 510) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298462, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308462, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 511) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258468, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268468, 1)
player:GossipComplete()
end
end
if(intid == 512) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268468, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278468, 1)
player:GossipComplete()
end
end
if(intid == 513) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278468, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288468, 1)
player:GossipComplete()
end
end
if(intid == 514) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288468, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298468, 1)
player:GossipComplete()
end
end
if(intid == 515) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298468, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308468, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 516) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(2258500, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(3268500, 1)
player:GossipComplete()
end
end
if(intid == 517) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(2268500, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(3278500, 1)
player:GossipComplete()
end
end
if(intid == 518) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(2278500, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(3288500, 1)
player:GossipComplete()
end
end
if(intid == 519) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(2288500, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(3298500, 1)
player:GossipComplete()
end
end
if(intid == 520) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(2298500, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(3308500, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 521) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(5535553, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(6535554, 1)
player:GossipComplete()
end
end
if(intid == 522) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(5535554, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(6535555, 1)
player:GossipComplete()
end
end
if(intid == 523) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(5535555, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(6535556, 1)
player:GossipComplete()
end
end
if(intid == 524) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(5535556, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(6535557, 1)
player:GossipComplete()
end
end
if(intid == 525) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(5535557, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6535558, 1)
player:GossipComplete()
end
end

--New Item Starts Here
if(intid == 526) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879830, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879830, 1)
player:GossipComplete()
end
end
if(intid == 527) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879831, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879831, 1)
player:GossipComplete()
end
end
if(intid == 528) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879832, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879832, 1)
player:GossipComplete()
end
end
if(intid == 529) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879833, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879833, 1)
player:GossipComplete()
end
end
if(intid == 530) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879835, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879835, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 531) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879836, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879836, 1)
player:GossipComplete()
end
end
if(intid == 532) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879837, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879837, 1)
player:GossipComplete()
end
end
if(intid == 533) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879838, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879838, 1)
player:GossipComplete()
end
end
if(intid == 534) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879839, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879839, 1)
player:GossipComplete()
end
end
if(intid == 535) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(1879834, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6879834, 1)
player:GossipComplete()
end
end
--New Item Starts Here
if(intid == 536) then
if(tierUpgradeCheck(player,1)) then
player:RemoveItem(995656, 1)
player:RemoveItem(577777, 1)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 500)
player:AddItem(6995657, 1)
player:GossipComplete()
end
end
if(intid == 537) then
if(tierUpgradeCheck(player,2)) then
player:RemoveItem(995657, 1)
player:RemoveItem(577777, 2)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 1000)
player:AddItem(6995658, 1)
player:GossipComplete()
end
end
if(intid == 538) then
if(tierUpgradeCheck(player,3)) then
player:RemoveItem(995658, 1)
player:RemoveItem(577777, 3)
player:RemoveItem(649285, 5)
player:RemoveItem(6460050, 2000)
player:AddItem(6995659, 1)
player:GossipComplete()
end
end
if(intid == 539) then
if(tierUpgradeCheck(player,4)) then
player:RemoveItem(995659, 1)
player:RemoveItem(577777, 4)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 5000)
player:AddItem(6995660, 1)
player:GossipComplete()
end
end
if(intid == 540) then
if(tierUpgradeCheck(player,5)) then
player:RemoveItem(995660, 1)
player:RemoveItem(577777, 5)
player:RemoveItem(649285, 10)
player:RemoveItem(6460050, 10000)
player:AddItem(6995661, 1)
player:GossipComplete()
end
end




end

RegisterCreatureGossipEvent(ID, 1, onGossip)
RegisterCreatureGossipEvent(ID, 2, onSelect)