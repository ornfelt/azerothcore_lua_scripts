--[[
Broodlord Lashlayer yells: Clever, mortals - but I am not so easily lured away from my sanctum!
Broodlord Lashlayer yells: None of your kind should be here! You've doomed only yourselves!
]]--
function Broodlord_Lashlayer_OnCombat(pUnit, event)
	pUnit:SendChatMessage(12, 0, "None of your kind should be here! You've doomed only yourselves!")
	pUnit:RegisterEvent("Cleave", 15000, 0)
	pUnit:RegisterEvent("Whelps", 190000, 0)
	pUnit:RegisterEvent("Taskmaster", 640000, 0)
	pUnit:RegisterEvent("Hatcher", 640000, 0)
	pUnit:RegisterEvent("Back", 30000, 0)
end

function Whelps(pUnit, event)
local x,y,z,o = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO()
	pUnit:SpawnCreature(14024 , x, y, z, o, 14, 190000)
	pUnit:SpawnCreature(14025 , x, y, z, o, 14, 190000)
	pUnit:SpawnCreature(14023 , x, y, z, o, 14, 190000)
	pUnit:SpawnCreature(14022 , x, y, z, o, 14, 190000)
end

function Taskmaster(pUnit, event)
local x,y,z,o = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO()
	pUnit:SpawnCreature(12458 , x, y, z, o, 14, 650000)
	pUnit:SpawnCreature(12458 , x, y, z, o, 14, 650000)
	pUnit:SpawnCreature(12458 , x, y, z, o, 14, 650000)
end

function Hatcher(pUnit, event)
local x,y,z,o = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO()
	pUnit:SpawnCreature(12468 , x, y, z, o, 14, 650000)
end

function Cleave(pUnit, event)
local tank = pUnit:GetMainTank()
	if tank ~= nill then
		pUnit:FullCastSpellOnTarget(15284, tank)
	end
end

function Back(pUnit, event)
local plr = pUnit:GetMainTank()
	if plr ~= nil then
		pUnit:CastSpellOnTarget(18670, plr)
		pUnit:RemoveThreatByPtr(plr)
	end
end

function Broodlord_Lashlayer_OnLeaveCombat(pUnit, event)
	pUnit:SendChatMessage(12, 0, "Clever, mortals - but I am not so easily lured away from my sanctum!")
	pUnit:RemoveEvents()
end

function Broodlord_Lashlayer_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12017, 1, "Broodlord_Lashlayer_OnCombat")
RegisterUnitEvent(12017, 2, "Broodlord_Lashlayer_OnLeaveCombat")
RegisterUnitEvent(12017, 4, "Broodlord_Lashlayer_OnDeath")