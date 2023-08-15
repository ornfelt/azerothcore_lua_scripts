-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Mekgineer Thermaplugg yells: Explosions! MORE explosions! I got to have more explosions!
Mekgineer Thermaplugg yells: My machines are the future! They'll destroy you all!
Mekgineer Thermaplugg yells: Usurpers! Gnomeregan is mine!
----Spells-ID
Knock Away-10101
Knock Away-11130
]]--

function Knock_Away(pUnit)
	pUnit:CastSpellOnTarget(10101, pUnit:GetClosestPlayer(1))
end

function Knocks_Away(pUnit)
	pUnit:CastSpellOnTarget(11130, pUnit:GetRandomPlayer(1))
end

function Mekgineer_OnCombat(pUnit, event)
local chance = math.random(1,3)
	if(chance == 1) then
		pUnit:SendChatMessage(12, 0, "Explosions! MORE explosions! I got to have more explosions!")
	elseif(chance == 2) then
		pUnit:SendChatMessage(12, 0, "My machines are the future! They'll destroy you all!")
	elseif(chance == 3) then
		pUnit:SendChatMessage(12, 0, "Usurpers! Gnomeregan is mine!")
	else
		pUnit:SendChatMessage(11, 0, "math.random(1,3) mal-function error lua")
	end
	pUnit:RegisterEvent("Knock_Away", 10000, 0)
	pUnit:RegisterEvent("Knocks_Away", 17000, 0)
end

function Mekgineer_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

function Mekgineer_OnDied(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(6228, 1, "Mekgineer_OnCombat")
RegisterUnitEvent(6228, 2, "Mekgineer_OnLeaveCombat")
RegisterUnitEvent(6228, 4, "Mekgineer_OnDied")