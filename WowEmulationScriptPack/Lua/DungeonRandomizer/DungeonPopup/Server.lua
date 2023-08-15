local healthSpell = 7477
local speedSpell = 7471
local damageSpell = 7464
local essenceItemID = 1

local AIO = AIO or require("AIO")
local MyHandlers = AIO.AddHandlers("DungeonBuffHander", {})

function MyHandlers.onClickButton(player,argValue)
	if(isCorrectMap(player))then
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
			local chosenSpellID = randDungPossibleSpellAugmentChoice[player:GetClass()][math.random(#randDungPossibleSpellAugmentChoice[player:GetClass()])]
			for i,v in pairs(playerToSpellEffectCacheRandDung[player:GetGUIDLow()])do
				if(i == chosenSpellID)then
					MyHandlers.onClickButton(player,3)
				end
			 end
			generateRandomAugmentRandDung(player,chosenSpellID,math.random(100))
		elseif(argValue == 4)then
			local curMult = playerCurFloor[player:GetGUIDLow()]
			if(curMult == nil)then
				curMult = 1
				print("DungeonPopup/Server.lua - playerCurFloor[player:GetGUIDLow()] was nil, fix it")
			end
			player:AddItem(essenceItemID,5*curMult)
		end
	end
	AIO.Handle(player, "DungeonBuffHander", "RemoveButtons")
	AIO.Handle(player, "DungeonBuffHander", "HideFrame")
end

function givePlayerDungeonpopup(player)
	AIO.Handle(player, "DungeonBuffHander", "ShowFrame")
	AIO.Handle(player, "DungeonBuffHander", "MakeButtons")
end

