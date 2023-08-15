--[[ Skarvald_Dalronn.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, October 26, 2008. ]]

function Skarvald_OnEnterCombat(pUnit,Event)
	pUnit:SendChatMessage(14, 0,"Dalronn! See if you can muster the nerve to join my attack!")
	pUnit:RegisterEvent("Skarvald_Charge",8000, 0)
	pUnit:RegisterEvent("Skarvald_StoneStrike",10000, 0)
end

function Skarvald_Charge(pUnit, Event)
	pUnit:FullCastSpellOnTarget(43651,pUnit:GetRandomPlayer(7))
end

function Skarvald_StoneStrike(pUnit, Event)
	pUnit:FullCastSpellOnTarget(48583,pUnit:GetClosestPlayer())
end

function Skarvald_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function Skarvald_OnDied(pUnit, event, player)
	pUnit:SendChatMessage(14, 0,"A warrior's death.")
	pUnit:RemoveEvents()
end

RegisterUnitEvent(24200, 1, "Skarvald_OnEnterCombat")
RegisterUnitEvent(24200, 2, "Skarvald_OnLeaveCombat")
RegisterUnitEvent(24200, 4, "Skarvald_OnDied")

-- Other Boss :)
function Dalronn_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Dalronn_Reply",5000, 1)	
	pUnit:RegisterEvent("Dalronn_ShadowBolt",2000, 0)
	pUnit:RegisterEvent("Dalronn_Debilitate",8000, 0)
end

function Skarvald_Reply(pUnit, event, player)
	pUnit:SendChatMessage(14, 0,"By all means, don't assess the situation, you halfwit! Just jump into the fray!")
end

function Dalronn_ShadowBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(43649,pUnit:GetRandomPlayer(0))
end

function Dalronn_Debilitate(pUnit, Event)
	pUnit:FullCastSpellOnTarget(43650,pUnit:GetRandomPlayer(0))
end

function Dalronn_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function Dalronn_OnDied(pUnit, event, player)
	pUnit:SendChatMessage(14, 0,"See... you... soon.")
	pUnit:RemoveEvents()
end

RegisterUnitEvent(24201, 1, "Dalronn_OnEnterCombat")
RegisterUnitEvent(24201, 2, "Dalronn_OnLeaveCombat")
RegisterUnitEvent(24201, 4, "Dalronn_OnDied")