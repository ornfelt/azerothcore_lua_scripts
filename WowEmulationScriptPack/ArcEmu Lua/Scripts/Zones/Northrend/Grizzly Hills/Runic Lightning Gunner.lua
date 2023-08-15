--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RunicLightningGunner_OnCombat(Unit, Event)
Unit:RegisterEvent("RunicLightningGunner_LightningGunShot", 6000, 0)
end

function RunicLightningGunner_LightningGunShot(Unit, Event) 
Unit:FullCastSpellOnTarget(46982, Unit:GetMainTank()) 
end

function RunicLightningGunner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunicLightningGunner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunicLightningGunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26414, 1, "RunicLightningGunner_OnCombat")
RegisterUnitEvent(26414, 2, "RunicLightningGunner_OnLeaveCombat")
RegisterUnitEvent(26414, 3, "RunicLightningGunner_OnKilledTarget")
RegisterUnitEvent(26414, 4, "RunicLightningGunner_OnDied")