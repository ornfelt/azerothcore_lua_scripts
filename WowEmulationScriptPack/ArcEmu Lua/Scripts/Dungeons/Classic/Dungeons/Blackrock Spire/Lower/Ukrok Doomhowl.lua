-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Urok Doomhowl yells: You have summoned me, fool! Now DIE!
Urok Doomhowl says: I'll crush you!
Urok Doomhowl says: Me smash! You die!
----Spells-ID
Intimidating Roar-16508
Rend-16509
Strike-15580
]]--

function UDH_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("UDH_Spells", 100, 0)
	local npcsay = math.random(1,3)
		if(npcsay == 1) then
			pUnit:SendChatMessage(12, 0, "You have summoned me, fool! Now DIE!")
		end
		if(npcsay == 2) then
			pUnit:SendChatMessage(11, 0, "I'll crush you!")
		end
		if(npcsay == 3) then
			pUnit:SendChatMessage(11, 0, "Me smash! You Die!")
		end
end

function UDH_Spells(pUnit, Event)
	pUnit:RegisterEvent("UDH_IntimidatingRoar", 1100, 0)
	pUnit:RegisterEvent("UDH_Rend", 2100, 0)
	pUnit:RegisterEvent("UDH_Strike", 3100, 0)
end

function UDH_IntimidatinRoar(pUnit, Event)
	pUnit:CastSpellOnTarget(16508)
end

function UDH_Rend(pUnit, Event)
	pUnit:CastSpellOnTarget(16509)
end

function UDH_Strike(pUnit, Event)
	pUnit:CastSpellOnTarget(15580)
end

function UDH_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function UDH_OnDeath(pUnit, Event)
	pUnit:removeEvents()
end

RegisterUnitEvent(10584, 1, "UDH_OnCombat")
RegisterUnitEvent(10584, 2, "UDH_OnLeaveCombat")
RegisterUnitEvent(10584, 4, "UDH_OnDeath")