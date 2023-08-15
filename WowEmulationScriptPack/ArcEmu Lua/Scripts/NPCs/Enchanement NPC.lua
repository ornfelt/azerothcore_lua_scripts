--[[
#####################################################
#            										#
#				RaxiCax's Scripts					#
#	   		  Scripts created by RaxiCax			#
#	         Free to use, at some purpose	 	    #
#	     All credits, go to the rightful owner.	    #
#													#
#####################################################
]]--

local NPC_ID = 100000					-- Entry ID of you'r NPC.
local TOKEN = false 					-- If true, change TOKEN_ID to a number.
local TOKEN_ID = nil					-- 
local TOKEN_AMOUNT = 1			

--[[ DO NOT TOUCH ANYTHING BELOW ]]--

function EnchanterOnTalk(Unit, event, Player)
	Unit:GossipCreateMenu(3544, Player, 0)
		Unit:GossipMenuAddItem(7, "|cff342D7E<> Armor", 1, 0)
		Unit:GossipMenuAddItem(7, "|cff342D7E<> Weapon", 2, 0)
		if(TOKEN ~= false) then
		Unit:GossipMenuAddItem(1, "Enchanting cost tokens!", 0, 0)
		end
		if(TOKEN == true) and (TOKEN_ID == nil) then
			Player:SendAreaTriggerMessage("|cff000000BROKEN NPC! - Contact GMS!")
		end
			Unit:GossipSendMenu(Player)
end

function EnchanterOnSelect(Unit, event, Player, id, intid, code)
	if(intid == 1) then
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEHead", 3, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEShoulder", 4, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DECloak", 5, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEChest", 6, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEBracer", 7, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEHands", 8, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEBelt", 9, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEPants", 10, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEBoots", 11, 0)
				Unit:GossipSendMenu(Player)	
	end
	if(intid == 2) then			-- WEAPON
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEMain Hand", 15, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEOff Hand", 16, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DE2 Handed", 17, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEShield", 18, 0)
			Unit:GossipMenuAddItem(5, "|cff2B60DEBow/Gun", 19, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 3) then			-- HEAD
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Arcanum of Triumph", 30, 0) -- 3795
			Unit:GossipMenuAddItem(3, "|cff252597Arcanum of Dominance", 31, 0) -- 3797
			Unit:GossipMenuAddItem(5, "|cff254116Arcanum of Torment", 32, 0) -- 3817
			Unit:GossipMenuAddItem(3, "|cff252597Arcanum of the Stalwart Protector", 33, 0) -- 3818
			Unit:GossipMenuAddItem(5, "|cff254116Arcanum of Blissful Mending", 34, 0) -- 3819
			Unit:GossipMenuAddItem(3, "|cff252597Arcanum of Burning Mysteries", 35, 0) -- 3820
			Unit:GossipMenuAddItem(5, "|cff254116Arcanum of Savage Gladiator", 36, 0) -- 3842
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 750, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 4) then			-- SHOULDER
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Inscription of Triumph", 45, 0) -- 3793
			Unit:GossipMenuAddItem(3, "|cff252597Inscription of Dominance", 46, 0) -- 3794
			Unit:GossipMenuAddItem(5, "|cff254116Greater Inscription of the Axe", 47, 0) -- 3808
			Unit:GossipMenuAddItem(3, "|cff252597Greater Inscription of the Crag", 48, 0) -- 3809
			Unit:GossipMenuAddItem(5, "|cff254116Greater Inscription of the Storm", 49, 0) -- 3810
			Unit:GossipMenuAddItem(3, "|cff252597Greater Inscription of the Pinnacle", 50, 0) -- 3811
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 751, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 5) then			-- CLOAK
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Major Agility", 60, 0) -- 1099
			Unit:GossipMenuAddItem(3, "|cff252597Superior Dodge", 61, 0) -- 1951
			Unit:GossipMenuAddItem(5, "|cff254116Spell Piercing", 62, 0) -- 3243
			Unit:GossipMenuAddItem(3, "|cff252597Greater Speed", 63, 0) -- 3831
			Unit:GossipMenuAddItem(5, "|cff254116Mighty Armor", 64, 0) -- 3294
			Unit:GossipMenuAddItem(3, "|cff252597Wisdom", 65, 0) -- 3296
			Unit:GossipMenuAddItem(5, "|cff254116Stealth", 66, 0) -- 910
			Unit:GossipMenuAddItem(3, "|cff252597Superior Frost Resistance", 67, 0) -- 1308
			Unit:GossipMenuAddItem(5, "|cff254116Superior Nature Resistance", 68, 0) -- 1400
			Unit:GossipMenuAddItem(3, "|cff252597Superior Fire Resistance", 69, 0) -- 1354
			Unit:GossipMenuAddItem(5, "|cff254116Superior Shadow Resistance", 70, 0) -- 1446
			Unit:GossipMenuAddItem(3, "|cff252597Superior Arcane Resistance", 71, 0) -- 1262
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 752, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 6) then			-- CHEST
		Unit:GossipCreateMenu(3544, Player, 0)	
			Unit:GossipMenuAddItem(5, "|cff254116Super Health", 80, 0) -- 3297
			Unit:GossipMenuAddItem(3, "|cff252597Powerful Stats", 81, 0) -- 3832
			Unit:GossipMenuAddItem(5, "|cff254116Exceptional Resilience", 82, 0) -- 3245
			Unit:GossipMenuAddItem(3, "|cff252597Greater Dodge", 83, 0) -- 1953
			Unit:GossipMenuAddItem(5, "|cff254116Greater Mana Restoration", 84, 0) -- 1149
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 753, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 7) then			-- BRACER
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Greater Assault", 90, 0) -- 1600
			Unit:GossipMenuAddItem(3, "|cff252597Superior Spellpower", 91, 0) -- 2332
			Unit:GossipMenuAddItem(5, "|cff254116Major Spirit", 92, 0) -- 1147
			Unit:GossipMenuAddItem(3, "|cff252597Exceptional Intellect", 93, 0) -- 1119
			Unit:GossipMenuAddItem(5, "|cff254116Major Stamina", 94, 0) -- 1093
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 754, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 8) then			-- HANDS
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Crusher", 100, 0) -- 1603
			Unit:GossipMenuAddItem(3, "|cff252597Exceptional Spellpower", 101, 0) -- 2330
			Unit:GossipMenuAddItem(5, "|cff254116Major Agility", 102, 0) -- 1097
			Unit:GossipMenuAddItem(3, "|cff252597Precision", 103, 0) -- 3234
			Unit:GossipMenuAddItem(5, "|cff254116Expertise", 104, 0) -- 3231
			Unit:GossipMenuAddItem(3, "|cff252597Threat", 105, 0) -- 2613
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 755, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 9) then 		-- BELT
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Extra Socket", 108, 0) -- 3319
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 756, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 10) then 		-- PANTS
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Frosthide Leg Armor", 110, 0) -- 3327
			Unit:GossipMenuAddItem(3, "|cff252597Icescale Leg Armor", 111, 0) -- 3328
			Unit:GossipMenuAddItem(5, "|cff254116Sapphire Spellthread", 112, 0) -- 3873
			Unit:GossipMenuAddItem(3, "|cff252597Brilliant Spellthread", 113, 0) -- 3872
			Unit:GossipMenuAddItem(5, "|cff254116Earthen Leg Armor", 114, 0) -- 3853
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 757, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 11) then		-- BOOTS
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Greater Assault", 120, 0) -- 1597
			Unit:GossipMenuAddItem(3, "|cff252597Greater Fortitude", 121, 0) -- 1075
			Unit:GossipMenuAddItem(5, "|cff254116Greater Vitality", 122, 0) -- 3244
			Unit:GossipMenuAddItem(3, "|cff252597Greater Spirit", 123, 0) -- 1147
			Unit:GossipMenuAddItem(5, "|cff254116Superior Agility", 124, 0) -- 1099
			Unit:GossipMenuAddItem(3, "|cff252597Tuskarr's Vatality", 125, 0) -- 3232
			Unit:GossipMenuAddItem(5, "|cff254116Icewalker", 126, 0) -- 3826
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 758, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 15) then
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Executioner", 200, 0) -- 3225
			Unit:GossipMenuAddItem(3, "|cff252597Mighty Spellpower", 201, 0) -- 3834
			Unit:GossipMenuAddItem(5, "|cff254116Black Magic", 202, 0) -- 3790
			Unit:GossipMenuAddItem(3, "|cff252597Berserking", 203, 0) -- 3789
			Unit:GossipMenuAddItem(5, "|cff254116Exceptional Agility", 204, 0) -- 1103
			Unit:GossipMenuAddItem(3, "|cff252597Superior Potency", 205, 0) -- 3833
			Unit:GossipMenuAddItem(5, "|cff254116Exceptional Spirit", 206, 0) -- 3844
			Unit:GossipMenuAddItem(3, "|cff252597Deathfrost", 207, 0) -- 3273
			Unit:GossipMenuAddItem(5, "|cff254116Lifeward", 208, 0) -- 3241
			Unit:GossipMenuAddItem(3, "|cff252597Giant Slayer", 209, 0) -- 3251
			Unit:GossipMenuAddItem(5, "|cff254116Mongoose", 210, 0) -- 2673
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 759, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 16) then
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Executioner", 211, 0) -- Above
			Unit:GossipMenuAddItem(3, "|cff252597Mighty Spellpower", 212, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Black Magic", 213, 0)
			Unit:GossipMenuAddItem(3, "|cff252597Berserking", 214, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Exceptional Agility", 215, 0)
			Unit:GossipMenuAddItem(3, "|cff252597Superior Potency", 216, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Exceptional Spirit", 217, 0)
			Unit:GossipMenuAddItem(3, "|cff252597Deathfrost", 218, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Lifeward", 219, 0)
			Unit:GossipMenuAddItem(3, "|cff252597Giant Slayer", 220, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Mongoose", 221, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 759, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 17) then
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Scourgebane", 230, 0) -- 3247
			Unit:GossipMenuAddItem(5, "|cff254116Massacre", 231, 0) -- 3827
			Unit:GossipMenuAddItem(3, "|cff252597Major Agility", 232, 0) -- 2670
			Unit:GossipMenuAddItem(5, "|cff254116Staff: Greater Spellpower", 233, 0) -- 3854
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 761, 0)	
				Unit:GossipSendMenu(Player)
	end
	if(intid == 18) then
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Titanium Plating", 240, 0) -- 3849
			Unit:GossipMenuAddItem(3, "|cff252597Intellect III", 241, 0) -- 1128
			Unit:GossipMenuAddItem(5, "|cff254116Dodge", 242, 0) -- 1952
			Unit:GossipMenuAddItem(3, "|cff252597Major Stamina", 243, 0) -- 1071
			Unit:GossipMenuAddItem(5, "|cff254116Resilience", 244, 0) -- 3229
			Unit:GossipMenuAddItem(7, "|cff0000FFEnchantment Information", 762, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 19) then
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff254116Heartseeker Scope", 250, 0) -- 3608
			Unit:GossipMenuAddItem(3, "|cff252597Sun Scope", 251, 0) -- 3607
				Unit:GossipSendMenu(Player)
	end
	--[[ HELM ]]--
	if(intid == 30) then						-- Arcanum of Triumph
		local pItem = Player:GetEquippedItemBySlot(0)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3795, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3795, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				else
					Player:SendAreaTriggerMessage("|cffFF0033|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033|cffFF0033You've no helmet equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 31) then						-- Arcanum of Dominance
		local pItem = Player:GetEquippedItemBySlot(0)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3797, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3797, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no helmet equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 32) then						-- Arcanum of Torment
		local pItem = Player:GetEquippedItemBySlot(0)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3817, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3817, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no helmet equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 33) then						-- Arcanum of the Stalwart Protector
		local pItem = Player:GetEquippedItemBySlot(0)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3818, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3818, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no helmet equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 34) then						-- Arcanum of Blissful Mending
		local pItem = Player:GetEquippedItemBySlot(0)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3819, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3819, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no helmet equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 35) then						-- Arcanum of Burning Mysteries
		local pItem = Player:GetEquippedItemBySlot(0)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3820, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3820, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no helmet equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 36) then						-- Arcanum of Savage Gladiator
		local pItem = Player:GetEquippedItemBySlot(0)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3842, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3842, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHelmet has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no helmet equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ SHOULDER ]]--
	if(intid == 45) then						-- Arcanum of Inscription of Triumph
		local pItem = Player:GetEquippedItemBySlot(2)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3793, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3793, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shoulder equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 46) then						-- Inscription of Dominance
		local pItem = Player:GetEquippedItemBySlot(2)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3794, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3794, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shoulder equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 47) then						-- Greater Inscription of the Axe
		local pItem = Player:GetEquippedItemBySlot(2)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3808, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3808, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shoulder equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 48) then						-- Greater Inscription of the Crag
		local pItem = Player:GetEquippedItemBySlot(2)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3809, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3809, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shoulder equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 49) then						-- Greater Inscription of the Storm
		local pItem = Player:GetEquippedItemBySlot(2)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3810, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3810, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shoulder equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 50) then						-- Greater Inscription of the Pinnacle
		local pItem = Player:GetEquippedItemBySlot(2)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3811, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3811, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShoulder has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shoulder equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ CLOAK ]]--
	if(intid == 60) then						-- Major Agility
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1099, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1099, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 61) then						-- Superior Dodge
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1951, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1951 , 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 62) then						-- Spell Piercing
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3243, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3243 , 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 63) then						-- Greater Speed
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3831, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3831, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 64) then						-- Mighty Armor
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3294, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3294, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 65) then						-- Wisdom
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3296, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3296, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 66) then						-- Stealth
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(910, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(910, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 67) then						-- Superior Frost Resistance
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(910, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(910, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 68) then						-- Superior Nature Resistance
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(910, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(910, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 69) then						-- Superior Fire Resistance
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1354, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1354, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 70) then						-- Superior Shadow Resistance
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1446, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1446, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 71) then						-- Superior Arcane Resistance
		local pItem = Player:GetEquippedItemBySlot(14)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1262, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1262, 0, 0)
					Player:SendAreaTriggerMessage("Cloak has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no cloak equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ CHEST ]]--
	if(intid == 80) then						-- Super Health
		local pItem = Player:GetEquippedItemBySlot(4)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3297, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3297, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no chest equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 81) then						-- Powerful Stats
		local pItem = Player:GetEquippedItemBySlot(4)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3832, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3832, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no chest equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 82) then						-- Exceptional Resilience
		local pItem = Player:GetEquippedItemBySlot(4)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3245, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3245, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no chest equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 83) then						-- Greater Dodge
		local pItem = Player:GetEquippedItemBySlot(4)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1953, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1953, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no chest equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 84) then						-- Greater Mana Restoration
		local pItem = Player:GetEquippedItemBySlot(4)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1149, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1149, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCChest has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no chest equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ BRACER ]]--
	if(intid == 90) then						-- Greater Assault
		local pItem = Player:GetEquippedItemBySlot(8)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1600, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1600, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no bracers equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 91) then						-- Superior Spellpower
		local pItem = Player:GetEquippedItemBySlot(8)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2332, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2332, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no bracers equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 92) then						-- Major Spirit
		local pItem = Player:GetEquippedItemBySlot(8)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1147, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1147, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no bracers equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 93) then						-- Exceptional Intellect
		local pItem = Player:GetEquippedItemBySlot(8)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1119, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1119, 0, 0)
					Player:SendAreaTriggerMessage("Bracers has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no bracers equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 94) then						-- Major Stamina
		local pItem = Player:GetEquippedItemBySlot(8)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1093, 0, 0)
					Player:SendAreaTriggerMessage("Bracerss has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1093, 0, 0)
					Player:SendAreaTriggerMessage("Bracerss has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no bracerss equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ HANDS ]]--
	if(intid == 100) then						-- Crusher
		local pItem = Player:GetEquippedItemBySlot(9)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1093, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1093, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no hands equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 101) then						-- Exceptional Spellpower
		local pItem = Player:GetEquippedItemBySlot(9)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2330, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2330, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no hands equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 102) then						-- Major Agility
		local pItem = Player:GetEquippedItemBySlot(9)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1097, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1097, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no hands equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 103) then						-- Precision
		local pItem = Player:GetEquippedItemBySlot(9)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3234, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3234, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no hands equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 104) then						-- Expertise
		local pItem = Player:GetEquippedItemBySlot(9)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3231, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3231, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no hands equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 105) then						-- Threat
		local pItem = Player:GetEquippedItemBySlot(9)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2613, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2613, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCHands has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no hands equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ BELT ]]--
	if(intid == 108) then						-- Extra Socket
		local pItem = Player:GetEquippedItemBySlot(5)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					Player:AddItem(41611, 1)
					Player:SendAreaTriggerMessage("|cff0099CCBelt - Eternal given.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					Player:AddItem(41611, 1)
					Player:SendAreaTriggerMessage("|cff0099CCBelt - Eternal given.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no belt equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ PANTS ]]--
	if(intid == 110) then						-- Frosthide Leg Armor
		local pItem = Player:GetEquippedItemBySlot(6)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3327, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3327, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no pants equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 111) then						-- Icescale Leg Armor
		local pItem = Player:GetEquippedItemBySlot(6)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3328, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3328, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no pants equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 112) then						-- Sapphire Spellthread
		local pItem = Player:GetEquippedItemBySlot(6)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3873, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3873, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no pants equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 113) then						-- Brilliant Spellthread
		local pItem = Player:GetEquippedItemBySlot(6)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3872, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3872, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no pants equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 114) then						-- Earthen Leg Armor
		local pItem = Player:GetEquippedItemBySlot(6)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3853, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3853, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCPants has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no pants equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ BOOTS ]]--
	if(intid == 120) then						-- Greater Assault
		local pItem = Player:GetEquippedItemBySlot(7)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1597, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1597, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no boots equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 121) then						-- Greater Fortitude
		local pItem = Player:GetEquippedItemBySlot(7)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1075, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1075, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no boots equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 122) then						-- Greater Vitality
		local pItem = Player:GetEquippedItemBySlot(7)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3244, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3244, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no boots equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 123) then						-- Greater Spirit
		local pItem = Player:GetEquippedItemBySlot(7)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1147, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1147, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no boots equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 124) then						-- Superior Agility
		local pItem = Player:GetEquippedItemBySlot(7)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1099, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1099, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no boots equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 125) then						-- Tuskarr's Vatality
		local pItem = Player:GetEquippedItemBySlot(7)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3232, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3232, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no boots equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 126) then						-- Icewalker
		local pItem = Player:GetEquippedItemBySlot(7)	
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					
					pItem:AddEnchantment(3826, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3826, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCBoots has been enchanted.")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no boots equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ 1 HAND ]]--
	if(intid == 200) then						-- Executioner
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3225, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3225, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 201) then						-- Mighty Spellpower
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 202) then						-- Black Magic
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(pItem:HasEnchantment() == true) then
					pItem:RemoveEnchantment(0)
					Player:SendAreaTriggerMessage("WORK!")
				elseif(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3790, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3790, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 203) then						-- Berserking
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 204) then						-- Exceptional Agility
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1103, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1103, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 205) then						-- Superior Potency
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3833, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3833, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 206) then						-- Exceptional Spirit
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3844, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3844, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 207) then						-- Deathfrost
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3273, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3273, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 208) then						-- Lifeward
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3241, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3241, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 209) then						-- Giant Slayer
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3251, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3251, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 210) then						-- Mongoose
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2673, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2673, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ OFF HAND ]]--
	if(intid == 211) then						-- Executioner
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("|cffFF0033Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3225, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3225, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end
	end
	if(intid == 212) then						-- Mighty Spellpower
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("|cffFF0033Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 213) then						-- Black Magic
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("|cffFF0033Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3790, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3790, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 214) then						-- Berserking
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("|cffFF0033Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3834, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 215) then						-- Exceptional Agility
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1103, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1103, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 216) then						-- Superior Potency
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3833, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3833, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 217) then						-- Exceptional Spirit
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3844, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3844, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 218) then						-- Deathfrost
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3273, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3273, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 219) then						-- Lifeward
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3241, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3241, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 220) then						-- Giant Slayer
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3251, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3251, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 221) then						-- Mongoose
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
						Player:SendAreaTriggerMessage("Only weapons is allowed!")
				else
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2673, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2673, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ 2 Hand ]]--
	if(intid == 230) then						-- Scourgebane
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "1") or (sql == "5") or (sql == "8") or (sql == "6") or (sql == "8") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3247, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3247, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("Only 2H's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 231) then						-- Massacre
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "1") or (sql == "5") or (sql == "8") or (sql == "6") or (sql == "8") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3827, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3827, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("Only 2H's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 232) then						-- Major Agility
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "1") or (sql == "5") or (sql == "8") or (sql == "6") or (sql == "8") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2670, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(2670, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("Only 2H's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 233) then						-- Staff: Greater Spellpower
		local pItem = Player:GetEquippedItemBySlot(15)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "10") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3854, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3854, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCWeapon has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("Only Staff's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no weapon equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ SHIELD ]]--
	if(intid == 240) then						-- Titanium Plating
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3849, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3849, 0, 0)
					Player:SendAreaTriggerMessage("Shield has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("|cffFF0033Only Shield's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shield equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 241) then						-- Intellect III
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1128, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1128, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("|cffFF0033Only Shield's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shield equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 242) then						-- Dodge
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1952, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1952, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("|cffFF0033Only Shield's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shield equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 243) then						-- Major Stamina
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1071, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(1071, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("|cffFF0033Only Shield's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shield equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 244) then						-- Resilience
		local pItem = Player:GetEquippedItemBySlot(16)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "6") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3229, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3229, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCShield has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("|cffFF0033Only Shield's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no shield equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ Ranged ]]--
	if(intid == 250) then						-- Heartseeker Scope
		local pItem = Player:GetEquippedItemBySlot(17)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "2") or (sql == "3") or (sql == "18") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3608, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCRanged has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3608, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCRanged has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("|cffFF0033Only Ranged's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no ranged equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	if(intid == 251) then						-- Heartseeker Scope
		local pItem = Player:GetEquippedItemBySlot(17)
			if(pItem ~= nil) then
				local sql = WorldDBQuery("SELECT subclass FROM items WHERE entry = '"..pItem:GetEntryId().."'"):GetColumn(0):GetString()
				if(sql == "2") or (sql == "3") or (sql == "18") then
				if(TOKEN ~= true) then
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3607, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCRanged has been enchanted!")
					Unit:GossipComplete(Player)
				elseif(TOKEN ~= false) and (Player:HasItem(TOKEN_ID) and TOKEN_AMOUNT > 0) then
					Player:RemoveItem(TOKEN_ID, TOKEN_AMOUNT)
					pItem:RemoveEnchantment(0)
					pItem:AddEnchantment(3607, 0, 0)
					Player:SendAreaTriggerMessage("|cff0099CCRanged has been enchanted!")
					Unit:GossipComplete(Player)
					else
					Player:SendAreaTriggerMessage("|cffFF0033You've don't have the requirement.")
					Unit:GossipComplete(Player)
				end
				else
				Player:SendAreaTriggerMessage("|cffFF0033Only Ranged's is allowed!")
				end
			else
				Player:SendAreaTriggerMessage("|cffFF0033You've no ranged equipped.")
				Unit:GossipComplete(Player)
			end	
	end
	--[[ INFORMATION ]]--
	if(intid == 750) then -- HELM
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff25259750 Attack Power + 20 Resilience", 3, 0)
			Unit:GossipMenuAddItem(3, "|cff25411629 Spell Power + 20 Resilience", 3, 0)
			Unit:GossipMenuAddItem(5, "|cff25259750 Attack Power + 20 Crit Rating", 3, 0)
			Unit:GossipMenuAddItem(3, "|cff25411637 Stamina + 20 Defense Rating", 3, 0)
			Unit:GossipMenuAddItem(3, "|cff25259730 Spell Power + 10 Mana per 5 sec", 3, 0)
			Unit:GossipMenuAddItem(5, "|cff25411630 Spell Power + 20 Crit Rating", 3, 0)
			Unit:GossipMenuAddItem(3, "|cff25259730 Stamina + 25 Resilience", 3, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 3, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 751) then -- SHOULDER
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff25259740 Attack Power + 15 Resilience", 4, 0)
			Unit:GossipMenuAddItem(3, "|cff25411623 Spell Power + 15 Resilience", 4, 0)
			Unit:GossipMenuAddItem(5, "|cff25259740 Attack Power + 15 Crit Rating", 4, 0)
			Unit:GossipMenuAddItem(3, "|cff25411624 Spell Power + 8 Mana per 5 sec", 4, 0)
			Unit:GossipMenuAddItem(5, "|cff25259724 Spell Power + 15 Crit Rating", 4, 0)
			Unit:GossipMenuAddItem(3, "|cff25411620 Dodge Rating + 15 Defense Rating", 4, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 4, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 752) then -- CLOAK
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff25259722 Agility", 5, 0)
			Unit:GossipMenuAddItem(3, "|cff25411618 Dodge Rating", 5, 0)
			Unit:GossipMenuAddItem(5, "|cff25259735 Spell Penetration", 5, 0)
			Unit:GossipMenuAddItem(3, "|cff25411623 Haste Rating", 5, 0)
			Unit:GossipMenuAddItem(5, "|cff252597225 Armor", 5, 0)
			Unit:GossipMenuAddItem(3, "|cff25411610 Spirit + 2% Threat Reduce", 5, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Increased Stealth", 5, 0)
			Unit:GossipMenuAddItem(3, "|cff25411620 Frost Resistance", 5, 0)
			Unit:GossipMenuAddItem(5, "|cff25259720 Nature Resistance", 5, 0)
			Unit:GossipMenuAddItem(3, "|cff25411620 Fire Resistance", 5, 0)
			Unit:GossipMenuAddItem(5, "|cff25259720 Shadow Resistance", 5, 0)
			Unit:GossipMenuAddItem(3, "|cff25411620 Arcane Resistance", 5, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 5, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 753) then -- CHEST
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff252597275 Health", 6, 0)
			Unit:GossipMenuAddItem(3, "|cff25411610 All Stats", 6, 0)
			Unit:GossipMenuAddItem(5, "|cff25259720 Resilience", 6, 0)
			Unit:GossipMenuAddItem(3, "|cff25411622 Dodge Rating", 6, 0)
			Unit:GossipMenuAddItem(5, "|cff25259720 Spirit", 6, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 6, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 754) then -- BRACER
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff25259750 Attack Power", 7, 0)
			Unit:GossipMenuAddItem(3, "|cff25411630 Spell Power", 7, 0)
			Unit:GossipMenuAddItem(5, "|cff25259718 Spirit", 7, 0)
			Unit:GossipMenuAddItem(3, "|cff25411616 Intellect", 7, 0)
			Unit:GossipMenuAddItem(5, "|cff25259740 Stamina", 7, 0)
			Unit:GossipMenuAddItem(5, "|cff0000FFClick Anywhere In Menu", 7, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 755) then -- HANDS
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff25259744 Attack Power", 8, 0)
			Unit:GossipMenuAddItem(3, "|cff25411628 Spell Power", 8, 0)
			Unit:GossipMenuAddItem(5, "|cff25259720 Agility", 8, 0)
			Unit:GossipMenuAddItem(3, "|cff25411620 Hit Rating", 8, 0)
			Unit:GossipMenuAddItem(5, "|cff25259715 Expertise Rating", 8, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Reduce 2% Threat", 8, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 8, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 756) then -- BELT
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Extra Socket", 9, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 9, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 757) then -- PANTS
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff25259755 Stamina + 22 Agility", 10, 0)
			Unit:GossipMenuAddItem(3, "|cff25411675 Attack Power + 22 Crit Rating", 10, 0)
			Unit:GossipMenuAddItem(5, "|cff25259750 Spell Power + 30 Stamina", 10, 0)
			Unit:GossipMenuAddItem(3, "|cff25411650 Spell Power + 20 Spirit", 10, 0)
			Unit:GossipMenuAddItem(5, "|cff25259740 Resilience + 28 Stamina", 10, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 10, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 758) then -- BOOTS
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff25259732 Attack Power", 11, 0)
			Unit:GossipMenuAddItem(3, "|cff25411622 Stamina", 11, 0)
			Unit:GossipMenuAddItem(5, "|cff25259714 Stamina + 14 Spirit", 11, 0)
			Unit:GossipMenuAddItem(3, "|cff25411618 Spirit", 11, 0)
			Unit:GossipMenuAddItem(5, "|cff25259716 Agility", 11, 0)
			Unit:GossipMenuAddItem(3, "|cff25411615 Stamina + Minor Movement Speed", 11, 0)
			Unit:GossipMenuAddItem(5, "|cff25259712 Crit Rating + 12 Hit Rating", 11, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 11, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 759) then -- 1H
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for 120 Armor Penetration", 15, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Grant you 63 Spell Power", 15, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for 250 Haste Rating", 15, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Chance for 400 Attack Power", 15, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Grant you 26 Agility", 15, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Grant you 65 Attack Power", 15, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Grant you 45 Spirit", 15, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Grant frost, and slow(Below 73)", 15, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for giving life when melee", 15, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Chance for slow/damage aganist giants", 15, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for 120 Agility and attack speed", 15, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 15, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 760) then -- 1H
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for 120 Armor Penetration", 16, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Grant you 63 Spell Power", 16, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for 250 Haste Rating", 16, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Chance for 400 Attack Power", 16, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Grant you 26 Agility", 16, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Grant you 65 Attack Power", 16, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Grant you 45 Spirit", 16, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Grant frost, and slow(Below 73)", 16, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for giving life when melee", 16, 0)
			Unit:GossipMenuAddItem(3, "|cff254116Chance for slow/damage aganist giants", 16, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Chance for 120 Agility and attack speed", 16, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 16, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 761) then -- 2H
		Unit:GossipCreateMenu(3544, Player, 0)
		Unit:GossipMenuAddItem(5, "|cff252597140 Attack Power against Undead", 17, 0)
		Unit:GossipMenuAddItem(3, "|cff254116110 Attack Power", 17, 0)
		Unit:GossipMenuAddItem(5, "|cff25259735 Agility", 17, 0)
		Unit:GossipMenuAddItem(3, "|cff25411681 Spell Power", 17, 0)
		Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 17, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 762) then -- Shield
		Unit:GossipCreateMenu(3544, Player, 0)
			Unit:GossipMenuAddItem(5, "|cff252597Every block deals 45-67 DMG", 18, 0)
			Unit:GossipMenuAddItem(3, "|cff25411625 Intellect", 18, 0)
			Unit:GossipMenuAddItem(5, "|cff25259720 Dodge Rating", 18, 0)
			Unit:GossipMenuAddItem(3, "|cff25411618 Stamina", 18, 0)
			Unit:GossipMenuAddItem(5, "|cff25259712 Resilience", 18, 0)
			Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 18, 0)
				Unit:GossipSendMenu(Player)
	end
	if(intid == 762) then -- Scopes
		Unit:GossipCreateMenu(3544, Player, 0)
		Unit:GossipMenuAddItem(5, "|cff25259740 Crit Rating", 19, 0)
		Unit:GossipMenuAddItem(3, "|cff25411640 Haste Rating", 19, 0)
		Unit:GossipMenuAddItem(7, "|cff0000FFClick Anywhere In Menu", 19, 0)
				Unit:GossipSendMenu(Player)
	end
end

RegisterUnitGossipEvent(NPC_ID, 1, "EnchanterOnTalk")
RegisterUnitGossipEvent(NPC_ID, 2, "EnchanterOnSelect")