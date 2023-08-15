--[[

	This is created by zdroid9770  :D

	© Copyright 2012


http://luaplusplus.org/forum

]]


function DeeprunRatRoundup_OnComplete(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Into the box me pretties! Thas it. One by one ye go.")
end

RegisterQuestEvent(6661, 1, "DeeprunRatRoundup_OnComplete")

--after completeing Quest ID 6661 Says the message
