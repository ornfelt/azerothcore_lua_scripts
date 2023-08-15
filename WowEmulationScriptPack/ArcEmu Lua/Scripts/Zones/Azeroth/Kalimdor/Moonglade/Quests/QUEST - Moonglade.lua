--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Moonglade_Quest_onAccept (pUnit, Event)
	player = pUnit:getClosestPlayer ()
	pUnit:CastSpellOnTarget (19027, player)
end
RegisterQuestEvent(5921, 2, "Moonglade_Quest_onAccept")
RegisterQuestEvent(5922, 2, "Moonglade_Quest_onAccept")