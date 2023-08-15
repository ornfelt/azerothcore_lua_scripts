local stack1 = 706008
local stack2 = 707450
local stack3 = 707451
local stackMax1 = 249
local stackMax2 = 4
local itemID = 5509000

local function onUseParagon(event,player,item,target)
	if not(player:HasAura(stack3)) then
		player:RemoveItem(item,1)
		if(player:HasAura(stack1))then
			local curAura = player:GetAura(stack1)
			local stackAmount = curAura:GetStackAmount()
			if(stackAmount <= stackMax1)then
				curAura:SetStackAmount(stackAmount + 1)
			else
				player:RemoveAura(stack1)
				if(player:HasAura(stack2))then
					local secondAura = player:GetAura(stack2)
					local secondAmount = secondAura:GetStackAmount()
					if(secondAmount < stackMax2)then
						secondAura:SetStackAmount(secondAmount + 1)
					else
						player:RemoveAura(stack2)
						player:AddAura(stack3,player)
					end
				else
					player:AddAura(stack2,player)
				end
			end
		else
			player:AddAura(stack1)
		end
	end
end

RegisterItemEvent(itemID,2,onUseParagon)