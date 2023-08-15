--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NerubarCorpseHarvester_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarCorpseHarvester_VenomSpit", 8000, 0)
end

function NerubarCorpseHarvester_VenomSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(45577, Unit:GetMainTank()) 
end

function NerubarCorpseHarvester_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarCorpseHarvester_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarCorpseHarvester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25445, 1, "NerubarCorpseHarvester_OnCombat")
RegisterUnitEvent(25445, 2, "NerubarCorpseHarvester_OnLeaveCombat")
RegisterUnitEvent(25445, 3, "NerubarCorpseHarvester_OnKilledTarget")
RegisterUnitEvent(25445, 4, "NerubarCorpseHarvester_OnDied")