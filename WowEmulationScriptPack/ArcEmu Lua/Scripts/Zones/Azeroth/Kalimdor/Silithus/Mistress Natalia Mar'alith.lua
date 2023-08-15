--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MistressNataliaMaralith_OnCombat(Unit, Event)
	Unit:RegisterEvent("MistressNataliaMaralith_Blackout", 9000, 0)
	Unit:RegisterEvent("MistressNataliaMaralith_GreaterHeal", 15000, 0)
	Unit:RegisterEvent("MistressNataliaMaralith_MindFlay", 7000, 0)
	Unit:RegisterEvent("MistressNataliaMaralith_PsychicScream", 16000, 0)
	Unit:RegisterEvent("MistressNataliaMaralith_ShadowWordPain", 2000, 2)
end

function MistressNataliaMaralith_Blackout(Unit, Event) 
	Unit:FullCastSpellOnTarget(44415, 	Unit:GetMainTank()) 
end

function MistressNataliaMaralith_GreaterHeal(Unit, Event) 
	Unit:CastSpell(35096) 
end

function MistressNataliaMaralith_MindFlay(Unit, Event) 
	Unit:FullCastSpellOnTarget(16568, 	Unit:GetRandomPlayer(0)) 
end

function MistressNataliaMaralith_PsychicScream(Unit, Event) 
	Unit:FullCastSpellOnTarget(13704, 	Unit:GetRandomPlayer(0)) 
end

function MistressNataliaMaralith_ShadowWordPain(Unit, Event) 
	Unit:FullCastSpellOnTarget(11639, 	Unit:GetMainTank()) 
end

function MistressNataliaMaralith_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MistressNataliaMaralith_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function MistressNataliaMaralith_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15215, 1, "MistressNataliaMaralith_OnCombat")
RegisterUnitEvent(15215, 2, "MistressNataliaMaralith_OnLeaveCombat")
RegisterUnitEvent(15215, 3, "MistressNataliaMaralith_OnKilledTarget")
RegisterUnitEvent(15215, 4, "MistressNataliaMaralith_OnDied")