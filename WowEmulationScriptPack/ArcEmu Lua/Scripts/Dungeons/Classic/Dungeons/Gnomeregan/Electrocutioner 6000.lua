-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Electrocutioner 6000 yells: Electric justice!
----Spells-ID
Chain Bolt-11085
Megavolt-11082
Shock-11084
]]--

function Electrocutioner_6000_OnCombat(pUnit, Event)
	pUnit:SendChatMessage (12, 0, "Electric justice!")
	pUnit:RegisterEvent("Chain_Bolt", 15000, 0)
	pUnit:RegisterEvent("Megavolt", 30000, 0)
	pUnit:RegisterEvent("Shock", 50000, 0)
end

function Chain_Bolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(11085)
end

function Megavolt(pUnit)
	pUnit:FullCastSpellOnTarget(11082)
end

function Shock(pUnit, Event)
	pUnit:CastSpellOnTarget(11084)
end

function Electrocutioner_6000_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

function Electrocutioner_6000_OnDied(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(6235, 1, "Electrocutioner_6000_OnCombat")
RegisterUnitEvent(6235, 2, "Electrocutioner_6000_OnLeaveCombat")
RegisterUnitEvent(6235, 4, "Electrocutioner_6000_OnDied")