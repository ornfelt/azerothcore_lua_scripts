local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local APTHandlers = AIO.AddHandlers("APTStuff", {})

--	local mod = CreateFrame("Model",nil,parent)
--	
--	light = light or {1, 0, 0, -0.707, -0.707, 0.7, 1.0, 1.0, 1.0, 0.8, 1.0, 1.0, 0.8}
--	mod:SetModel(camera or "world\\expansion07\\doodads\\human\\8hu_kultiras_flag03.m2")
--	mod:SetSize(1000, 500)
--	mod:SetPoint("CENTER")
--	mod:SetCamera(1)
--	mod:SetLight(unpack(light))
--	mod:SetAlpha(1)