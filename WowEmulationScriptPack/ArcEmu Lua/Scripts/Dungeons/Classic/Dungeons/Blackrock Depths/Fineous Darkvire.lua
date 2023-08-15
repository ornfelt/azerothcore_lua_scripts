-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Devotion Aura-8258
Holy Light-15493
Holy Strike-13953
Kick-11978
Seal of Reckoning-15346
]]--

 function FDV_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("FDV_DevotionAura", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_HolyLight", 30000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_HolyStrike", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_SealOfReckoning", 25000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_Kick", 30000, 0) --Time could be wrong
end

function FDV_Kick(pUnit, Event)
	pUnit:CastSpellOnTarget(11978)
end

function FDV_SealOfReckoning(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15346)
end

function FDV_HolyStrike(pUnit, Event)
	pUnit:FullCastSpellonTarget(13953)
end

function FDV_HolyLight(pUnit, Event)
	pUnit:FullCastSpellonTarget(15493)
end

function FDV_DevotionAura(pUnit, Event)
	pUnit:FullCastSpellonTarget(8258)
end

function FDV_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function FDV_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9056, 1, "FDV_OnCombat")
RegisterUnitEvent(9056, 2, "FDV_OnLeaveCombat")
RegisterUnitEvent(9056, 4, "FDV_OnDeath")