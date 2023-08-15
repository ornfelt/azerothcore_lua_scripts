-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Twilight Lord Kelris yells: Who dares disturb my meditation?!
Twilight Lord Kelris yells: Dust to Dust.
Twilight Lord Kelris yells: Sleep...
----Spells-ID
Mind Blast-15587
Sleep-8399
]]--

function TwilightLordKelris_OnCombat(pUnit, event)
	pUnit:SendChatMessage(12, 0, "Who dares disturb my meditation?!")
	pUnit:PlaySoundToSet(5802)
	pUnit:RegisterEvent("TwilightLordKelris_MindBlast", 10000, 0)
	pUnit:RegisterEvent("TwilightLordKelris_Sleep", 20000, 0)
end
 
function TwilightLordKelris_MindBlast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15587, pUnit:GetRandomPlayer(0))
end
 
function TwilightLordKelris_Sleep(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Sleep...")
	pUnit:PlaySoundToSet(5804)
	pUnit:CastSpell(8399)
end
 
function TwilightLordKelris_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end
 
function TwilightLordKelris_OnDeath(pUnit, event)
	pUnit:SendChatMessage(12, 0, "Dust to Dust.")
	pUnit:PlaySoundToSet(5803)
	pUnit:RemoveEvents()
end
 
RegisterUnitEvent(4832, 1, "TwilightLordKelris_OnCombat")
RegisterUnitEvent(4832, 2, "TwilightLordKelris_OnLeaveCombat")
RegisterUnitEvent(4832, 3, "TwilightLordKelris_OnDeath")