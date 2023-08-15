-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Hurley Blackbreath yells: Get away from those kegs!
Hurley Blackbreath says: You'll pay for that!
----Spells-ID
Drunken Rage-14872
Flame Breath-9573
]]--

function HBB_OnCombat(pUnit, Event)
local chance = math.random(1,2)
	if(chance == 1) then
		pUnit:SendChatMessage(12, 0, "Get away from those kegs!")
	elseif(chance == 2) then
		pUnit:SendChatMessage(11, 0, "You'll pay for that!")
	end
	pUnit:RegisterEvent("HBB_Drunkenrage", 20000, 0)
	pUnit:RegisterEvent("HBB_FlameBreath", 5000, 0)
end

function HBB_FlameBreath(pUnit, Event)
	pUnit:CastSpellOnTarget(9573)
end

function HBB_Drunkenrage(pUnit, Event)
	pUnit:CastSpellonTarget(14872)
end

function HBB_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function HBB_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9537, 1, "HBB_OnCombat")
RegisterUnitEvent(9537, 2, "HBB_OnLeaveCombat")
RegisterUnitEvent(9537, 4, "HBB_OnDeath")