-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Houndmaster Grebmar says: Ahh, a new chew toy for my dogs!
----Spells-ID
Bloodlust-21049
Demoralizing Shout-13730
Pummel-15615
]]--

function HoundMGM_OnCombat(pUnit, event)
		pUnit:SendChatMessage(11, 0, "Ahh, a new chew toy for my dogs!")
        pUnit:RegisterEvent("HoundMGM_Bloodlust", 5000, 0)
        pUnit:RegisterEvent("HoundMGM_DS", 20000, 0)
		pUnit:RegisterEvent("HoundMGM_Pummel", 25000, 0)
end
 
function HoundMGM_Bloodlust(pUnit, Event)
        pUnit:FullCastSpell(21049)
end
 
function HoundMGM_DS(pUnit, Event)
        pUnit:CastSpell(13730)
end

function HoundMGM_Pummel(pUnit, Event)
        pUnit:CastSpellOnTarget(15615)
end
 
function HoundMGM_OnLeaveCombat(pUnit, event)
        pUnit:RemoveEvents()
end
 
function HoundMGM_OnDeath(pUnit, event)
        pUnit:RemoveEvents()
end
 
RegisterUnitEvent(9319, 1, "HoundMGM_OnCombat")
RegisterUnitEvent(9319, 2, "HoundMGM_OnLeaveCombat")
RegisterUnitEvent(9319, 3, "HoundMGM_OnDeath")