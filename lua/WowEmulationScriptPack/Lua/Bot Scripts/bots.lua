local faction = 1668
--add some faction where they are angry at everybody but spawn as 35(friendly to all)
--for some reason, they only attack with SAI, use Bloodmage(19258) and Thrallmar Grunt(16580) as templates since they work
local function checkCombat(eventid, delay, repeats, worldobject)
	if(GetPlayerByGUID(worldobject:GetOwnerGUID()):IsInCombat())then
		worldobject:AttackStart( GetPlayerByGUID(worldobject:GetOwnerGUID()):GetSelection())
	else
		worldobject:MoveFollow( GetPlayerByGUID(worldobject:GetOwnerGUID()), 1 )
	end	
end

local function onChat(event, player, msg, Type, lang)
	if(string.find(msg:lower(), "follow"))then
		if(player:GetSelection() ~= nil and player:GetPetGUID() < 1) then
			local target = player:GetSelection()
			if(target:GetFaction() == 35 and target:GetAIName() == "SmartAI" and target:GetOwnerGUID() < 1)then
				player:SetPetGUID( target:GetGUIDLow() )
				target:SetFaction(faction)
				target:MoveFollow( player, 1 )
				target:SetOwnerGUID(player:GetGUIDLow())
				target:RegisterEvent(checkCombat, 5000, 0)
			end
		end
	elseif(string.find(msg:lower(), "home"))then
		if(player:GetSelection() ~= nil) then
			local target = player:GetSelection()
			if(target:GetFaction() == faction and target:GetOwner():GetGUIDLow() == player:GetGUIDLow())then
				target:SetFaction(35)
				target:SetOwnerGUID(0)
				target:RemoveEvents()
				target:MoveHome()
				player:SetPetGUID(0)
			end
		end
	end
end

RegisterPlayerEvent( 18, onChat )