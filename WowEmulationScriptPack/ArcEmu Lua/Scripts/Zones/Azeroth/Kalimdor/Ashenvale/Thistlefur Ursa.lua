--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistlefurUrsa_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistlefurUrsa_BattleStance", 1000, 1)
	Unit:RegisterEvent("ThistlefurUrsa_HeroicStrike", 6000, 0)
end

function ThistlefurUrsa_BattleStance(pUnit, Event) 
	pUnit:CastSpell(7165) 
end

function ThistlefurUrsa_HeroicStrike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(25712, 	pUnit:GetMainTank()) 
end

function ThistlefurUrsa_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistlefurUrsa_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3921, 1, "ThistlefurUrsa_OnCombat")
RegisterUnitEvent(3921, 2, "ThistlefurUrsa_OnLeaveCombat")
RegisterUnitEvent(3921, 4, "ThistlefurUrsa_OnDied")