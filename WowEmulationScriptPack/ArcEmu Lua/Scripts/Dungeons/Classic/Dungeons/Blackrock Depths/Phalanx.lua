-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Phalanx yells: Violence! Property damage! None shall pass!!
----Spells-ID
Fireball Volley-15285
Mighty Blow-14099
Thunderclap-15588
]]--

function PX_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Violence! Property damage! None shall pass!!")
	pUnit:RegisterEvent("PSR_FireballVolley", 5000, 0) --Time could be wrong
	pUnit:RegisterEvent("PSR_ThunderClap", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("PSR_MightyBlow", 25000, 0) --Time could be wrong
end

function PX_FireballVolley(pUnit, Event)
	pUnit:CastSpell(15285)
end

function PX_MightyBlow(pUnit, Event)
	pUnit:FullCastSpellonTarget(14099)
end

function PX_ThunderClap(pUnit, Event)
	pUnit:FullCastSpellonTarget(15588)
end

function PX_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function PX_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9502, 1, "PX_OnCombat")
RegisterUnitEvent(9502, 2, "PX_OnLeaveCombat")
RegisterUnitEvent(9502, 4, "PX_OnDeath")