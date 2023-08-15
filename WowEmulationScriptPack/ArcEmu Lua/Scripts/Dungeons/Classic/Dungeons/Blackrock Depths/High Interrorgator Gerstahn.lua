-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Mana Burn-14033
Psychic Scream-13704
Shadow Shield-12040
Shadow Word: Pain-14032
]]--

function HIGS_OnCombat(pUnit, event)
        pUnit:RegisterEvent("HIGS_ManaBurn", 5000, 0)
        pUnit:RegisterEvent("HIGS_ShadowShield", 25000, 0)
		pUnit:RegisterEvent("HIGS_SWPain", 30000, 0)
		pUnit:RegisterEvent("HIGS_PsychicScream", 50000, 0)
end
 
function HIGS_ManaBurn(pUnit, Event)
        pUnit:CastSpell(14033)
end
 
function HIGS_ShadowShield(pUnit, Event)
        pUnit:CastSpell(12040)
end

function HIGS_SWPain(pUnit, Event)
        pUnit:CastSpell(14032)
end

function HIGS_PsychicScreamp(Unit, Event)
        pUnit:CastSpell(13704)
end
 
function HIGS_OnLeaveCombat(pUnit, event)
    pUnit:RemoveEvents()
end
 
function HIGS_OnDeath(pUnit, event)
    pUnit:RemoveEvents()
end
 
RegisterUnitEvent(9018, 1, "HIGS_OnCombat")
RegisterUnitEvent(9018, 2, "HIGS_OnLeaveCombat")
RegisterUnitEvent(9018, 4, "HIGS_OnDeath")