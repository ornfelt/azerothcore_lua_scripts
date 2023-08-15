-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Ambassador Flamelash yells: Your reign of terror ends now! Face your doom mortals!
----Spells-ID
Burning Spirit-14744
----Other
Summon Burning Spirits (Fire elementals that are capable of healing him.)
Immune to Stun.
]]--

function AFL_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Your reign of terror ends now! Face your doom mortals!")
	pUnit:RegisterEvent("AFL_BurningSpirit", 1000, 0) --Time could be wrong
end

function AFL_BurningSpirit(pUnit, Event)
	pUnit:CastSpell(14744)
end

function AFL_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function AFL_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9156, 1, "AFL_OnCombat")
RegisterUnitEvent(9156, 2, "AFL_OnLeaveCombat")
RegisterUnitEvent(9156, 4, "AFL_OnDeath")