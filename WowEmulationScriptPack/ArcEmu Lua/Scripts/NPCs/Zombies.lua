local OBJECT = 930001
local NPC = 930012
local NPC2 = 930031

function Grave_OnUse(pObject, Event, pUser)
	local priest = math.random(1, 25)
	if (priest == 20) then
		pObject:SpawnLocalCreature(NPC2, 2080, 0)
	else
		pObject:SpawnLocalCreature(NPC, 2080, 0)
	end
	pObject:Despawn(1000, 0)
end

function GraveZombie_OnCombat(pUnit, event)
	pUnit:SendChatMessage(12, 0, "You try to rob my grave mon? Now you will pay!")
	pUnit:RegisterEvent("Spawn_Grave", 20000, 1)
end

function Spawn_Grave(pUnit, Event)
	pUnit:Despawn(1000, 0)
	pUnit:SpawnLocalGameObject(OBJECT, 0)
end

RegisterGameObjectEvent(OBJECT, 4, "Grave_OnUse")
RegisterUnitEvent(NPC, 1, "GraveZombie_OnCombat")