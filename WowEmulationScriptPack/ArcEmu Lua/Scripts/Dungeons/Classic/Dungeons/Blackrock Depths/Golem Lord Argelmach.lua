-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Golem Lord Argelmach says: Intruders in the Manufactory? My constructs will destroy you!
----Spells-ID
Chain Lightning-15305
Lightning Shield-15507
Shock-15605
]]--

function GLA_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(11, 0, "Intruders in the Manufactory? My constructs will destroy you!")
	pUnit:RegisterEvent("GLA_LightningShield", 25000, 0)
	pUnit:RegisterEvent("GLA_ChainLightning", 5000, 0)
	pUnit:RegisterEvent("GLA_Shock", 20000, 0)
end

function GLA_LightningShield(pUnit, Event)
		pUnit:CastSpell(15507)
end

function GLA_ChainLightning(pUnit, Event)
	pUnit:FullCastSpell(15305)
end

function GLA_Shock(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15605)
end

function GLA_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function GLA_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(8983, 1, "GLA_OnCombat")
RegisterUnitEvent(8983, 2, "GLA_OnLeaveCombat")
RegisterUnitEvent(8983, 4, "GLA_OnDeath")