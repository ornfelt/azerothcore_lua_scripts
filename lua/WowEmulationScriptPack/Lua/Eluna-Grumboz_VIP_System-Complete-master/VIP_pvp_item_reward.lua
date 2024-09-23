-- 1 in xx chance to try and loot equiped item IF same class's
-- added loop so the higher your vip the more tries you do.
-- added a class check so warrior wont get useless gear from a warlock lol but can be removed easily
-- to remove the class check just delete lines #28 and then #8

function Pvp_Gear_Reward(_, killer, killed)

	if((killed:GetClass())==(killer:GetClass()))then -- why would a warrior want hunter gear?? -- remove if you dont want to do class check.
	
	local chance = 100

		for viploop=1, ACCT[killer:GetAccountId()].Vip do
			local ChanceA = math.random(1,chance)

				if(ChanceA==chance)then
					local Iscan = math.random(0, 18) -- choose random equip slot 0 to 18
					local Itemid = killed:GetEquippedItemBySlot(Iscan) -- attempt to grab guid of equipped item.

						if(Itemid==nil)then -- catch22 for nil'z
						return false;
						end

					if(killer:AddItem(Itemid:GetEntry(), 1)==true)then
						killer:SendBroadcastMessage("|cff00cc00Congratulations you looted "..Itemid:GetName().." from "..killed:GetName()..".|r")
						killed:RemoveItem(Itemid:GetEntry(), 1)
						killed:SendBroadcastMessage("|cffcc0000"..killer:GetName().." looted your "..Itemid:GetName()..".|r")
					end
				return false;
				end
		end
	end -- remove if you dont want to do class check
end

RegisterPlayerEvent(6, Pvp_Gear_Reward)

print("Grumbo'z VIP PvP Item Looter loaded.")
