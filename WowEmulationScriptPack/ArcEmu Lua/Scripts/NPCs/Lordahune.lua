local playercheck = 0
local objectused = 0

function Object_OnUse(pObject, event, User)
	 objectused = 1
	 pObject:Activate()
end

function lordahune_OnSpawn(pUnit, Event)
	pUnit:SetUInt32Value(26, 0)
	pUnit:SetScale(1)
	pUnit:SetFaction(35)
	pUnit:CastSpell(71614)
	pUnit:RegisterEvent("lordahune_Check", 10000, 0)
end

function lordahune_Check(pUnit, Event)
	if (playercheck == 1) and (objectused == 0) then 
	else
	pUnit:SetUInt32Value(0, 0)
	local plrs = pUnit:GetInRangePlayers()
	for _,v in pairs(plrs) do
		if(pUnit:GetDistance(v) <= 3) then
		pUnit:RegisterEvent("lordahune_UnIceBlock", 5000, 1)
		playercheck = 1
		break;
			end
		end
	end
end

function lordahune_UnIceBlock(pUnit, Event)
	local target = pUnit:GetRandomPlayer(0)
	pUnit:RemoveAura(71614)
	pUnit:SendChatMessage(12, 0, "Finally... thank you for freeing me..")
	pUnit:MoveTo(target:GetX(), target:GetY(), target:GetZ())
	pUnit:RegisterEvent("lordahune_agressive", 5000, 1)
end


function lordahune_agressive(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "But now..")
	pUnit:RegisterEvent("lordahune_Rawr", 5000, 1)
end

function lordahune_Rawr(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "YOU WILL DIE!")
	pUnit:SetFaction(2080)
	pUnit:SetScale(0.2)
	pUnit:SetModel(23344)
end

function lordahune_OnDeath(pUnit, Event)
	playercheck = 0
	objectused = 0
	pUnit:SetModel(24799)
	pUnit:SetScale(1)
	pUnit:RemoveEvents()
end

function lordahune_OnLeaveCombat(pUnit, Event)
	playercheck = 0
	objectused = 0
	pUnit:Despawn(4000, 1)
	pUnit:SetModel(24799)
end

	

RegisterUnitEvent(930006, 18, "lordahune_OnSpawn")
RegisterUnitEvent(930006, 4, "lordahune_OnDeath")
RegisterUnitEvent(930006, 2, "lordahune_OnLeaveCombat")
RegisterGameObjectEvent(186649, 3, "Object_OnUse")