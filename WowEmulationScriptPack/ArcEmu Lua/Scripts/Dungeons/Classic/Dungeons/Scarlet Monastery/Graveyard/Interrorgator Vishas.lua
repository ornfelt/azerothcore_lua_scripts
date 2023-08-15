-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

function Vishas_SWPain(pUnit)
    local target = pUnit:GetMainTank()
    if (target ~= nil) then
		pUnit:FullCastSpellOnTarget(2767,target)
	end
end

function Vishas_OnCombat(pUnit, event)
    pUnit:SendChatMessage(13,0,"Tell me... tell me everything!")
	pUnit:PlaySoundToSet(5847)
	pUnit:RegisterEvent("Vishas_SWPain",math.random(5000,12000),0)
	pUnit:RegisterEvent("Vishas_75",1000,0)
end

function Vishas_75(pUnit, event)
	if pUnit:GetHealthPct() <75 then
	    pUnit:RemoveEvents()
    	pUnit:SendChatMessage(13,0,"Naughty secrets!")
		pUnit:PlaySoundToSet(5849)
		pUnit:RegisterEvent("Vishas_SWPain",math.random(5000,12000),0)
		pUnit:RegisterEvent("Vishas_25",1000,0)
	end
end

function Vishas_25(pUnit, event)
	if pUnit:GetHealthPct() <25 then
	    pUnit:RemoveEvents()
	    pUnit:SendChatMessage(13,0,"I'll rip the secrets from your flesh!")
	    pUnit:PlaySoundToSet(5850)
	    pUnit:RegisterEvent("Vishas_SWPain",math.random(5000,12000),0)
    end
end
 
function Vishas_KillPlayer(pUnit)
    pUnit:SendChatMessage(13,0,"Purged by pain!")
	pUnit:PlaySoundToSet(5848)
end
 
function Vishas_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end
 
RegisterUnitEvent(3983,1,"Vishas_OnCombat")
RegisterUnitEvent(3983,2,"Vishas_LeaveCombat")
RegisterUnitEvent(3983,3,"Vishas_KillPlayer")