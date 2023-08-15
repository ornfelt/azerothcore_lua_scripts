-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Curse of Blood-16098
Hex-16097
]]--

function SHV_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("SHV_CurseOfBlood", 1000, 0)
	pUnit:RegisterEvent("SHV_Hex", 5000, 0)
end

function SHV_Hex(pUnit, Event)
local target = pUnit:GetRandomPlayer(0)
	if(target ~= nil) then
		pUnit:CastSpellOnTarget(16097)
	end
end

function SHV_CurseofBlood(pUnit, Event)
	pUnit:CastSpellOnTarget(16098)
end

function SHV_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function SHV_OnDeath(pUnit, Event)
	pUnit:removeEvents()
end

RegisterUnitEvent(9236, 1, "SHV_OnCombat")
RegisterUnitEvent(9236, 2, "SHV_OnLeaveCombat")
RegisterUnitEvent(9236, 4, "SHV_OnDeath")