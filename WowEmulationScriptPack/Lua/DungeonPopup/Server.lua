local healthSpell = 7477
local speedSpell = 7471
local damageSpell = 7464
local essenceItemID = 1
local AIO = AIO or require("AIO")

local MyHandlers = AIO.AddHandlers("DungeonBuffHander", {})

function MyHandlers.onClickButton(player,argValue)
	if(argValue == 1) then
		local aura = player:GetAura(healthSpell)
		if (aura) then
			aura:SetStackAmount(aura:GetStackAmount()+1)
		else
			player:AddAura(healthSpell, player)
		end
	elseif(argValue == 2)then
		local aura = player:GetAura(speedSpell)
		if (aura) then
			aura:SetStackAmount(aura:GetStackAmount()+1)
		else
			player:AddAura(speedSpell, player)
		end
	elseif(argValue == 3)then
		local aura = player:GetAura(damageSpell)
		if (aura) then
			aura:SetStackAmount(aura:GetStackAmount()+1)
		else
			player:AddAura(damageSpell, player)
		end
	elseif(argValue == 4)then
		local roll = math.random(2)
		if(roll == 1)then
			player:AddItem(100000)
			giveRandomItem(0,player)
		else
			player:AddItem(essenceItemID,10)
		end
	end
	AIO.Handle(player, "DungeonBuffHander", "RemoveButtons")
	AIO.Handle(player, "DungeonBuffHander", "HideFrame")
end

function givePlayerDungeonpopup(player)
	AIO.Handle(player, "DungeonBuffHander", "ShowFrame")
	AIO.Handle(player, "DungeonBuffHander", "MakeButtons")
end

