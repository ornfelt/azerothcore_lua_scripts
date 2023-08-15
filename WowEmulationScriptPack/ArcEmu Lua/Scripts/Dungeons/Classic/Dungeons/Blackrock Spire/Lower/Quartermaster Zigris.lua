-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Drink Healing Potion-15504
Hooked Net-15609
Shoot-59146
Stun Bomb-16497
]]--

function Zigris_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Drink_Healing_Potion", 1000, 0)
	pUnit:RegisterEvent("Hooked_Net", 2000, 0)
	pUnit:RegisterEvent("Shoot", 3000, 0)
	pUnit:RegisterEvent("Stun_Bomb", 4000, 0)
end

function Drink_Healing_Potion(pUnit, Event)
	pUnit:CastSpell(15504)
end

function Hooked_Net(pUnit, Event)
	pUnit:CastSpellOnTarget(15609)
end

function Shoot(pUnit, Event)
	pUnit:CastSpellOnTarget(59146)
end

function Stun_Bomb(pUnit, Event)
	pUnit:FullCastSpellOnTarget(16497)
end

function Zigris_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Zigris_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9736, 1, "Zigris_OnCombat")
RegisterUnitEvent(9736, 2, "Zigris_OnLeaveCombat")
RegisterUnitEvent(9736, 4, "Zigris_OnDied")