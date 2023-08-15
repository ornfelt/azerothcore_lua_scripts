--[[

	This is created by zdroid9770  :D

	� Copyright 2012

]]

function TeleportDown_AI(pUnit,Event)
	pUnit:RegsiterEvent("TeleportDown_DownFront", 1000, 0)
	pUnit:RegsiterEvent("TeleportDown_DownBack", 1000, 0)
end

function TeleportDown_DownFront(pUnit,Event)
 if pUnit:IsInFront() then
	pUnit:Teleport(609, 2389.989990, -5640.930176, 377.266998)
end
end

function TeleportDown_DownBack(pUnit,Event)
 if pUnit:IsInBack() then
	pUnit:Teleport(609, 2389.989990, -5640.930176, 377.266998)
end
end

RegisterUnitEvent(29581, 10, "TeleportDown_AI")

function TeleportUp_AI(pUnit,Event)
	pUnit:RegsiterEvent("TeleportDown_UpFront", 1000, 0)
	pUnit:RegsiterEvent("TeleportDown_UpBack", 1000, 0)
end

function TeleportUp_UpFront(pUnit,Event)
 if pUnit:IsInFront() then
	pUnit:Teleport(609, 2383.649902, -5645.240234, 420.880005)
end
end

function TeleportUp_UpBack(pUnit,Event)
 if pUnit:IsInBack() then
	pUnit:Teleport(609, 2383.649902, -5645.240234, 420.880005)
end
end

RegisterUnitEvent(29580, 10, "TeleportUp_AI")