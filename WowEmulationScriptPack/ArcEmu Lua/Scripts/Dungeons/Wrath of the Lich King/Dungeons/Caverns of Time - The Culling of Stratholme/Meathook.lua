--[[ Boss -- Meathook.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, September 23, 2008. ]]

function Meathook_OnEnterCombat(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "New toys!")
	pUnit:RegisterEvent("Meathook_ConstrictingChains", 11000, 0)
	pUnit:RegisterEvent("Meathook_DiseaseExplusion", 6000, 0)
end

function Meathook_OnSpawn(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Play time!")
end

function Meathook_OnKill(pUnit,Event)
	local Choice=math.random(1, 3)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "Boring...")
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Why you stop moving?")
		elseif Choice==3 then
			pUnit:SendChatMessage(14, 0, "Get up! Me not done!")
end
end

function Meathook_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(14, 0, "This not fun...")
end

function Meathook_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Meathook_ConstrictingChains(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52696,pUnit:GetClosestPlayer())
end

function Meathook_DiseaseExplusion(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52666,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(26529, 1, "Meathook_OnEnterCombat")
RegisterUnitEvent(26529, 6, "Meathook_OnSpawn")
RegisterUnitEvent(26529, 3, "Meathook_OnKill")
RegisterUnitEvent(26529, 4, "Meathook_OnDied")
RegisterUnitEvent(26529, 2, "Meathook_OnLeaveCombat")