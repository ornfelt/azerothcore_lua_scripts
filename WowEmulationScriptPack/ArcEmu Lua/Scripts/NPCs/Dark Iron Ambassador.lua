--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Dark_IA_minions_summon(Unit)
	Unit:FullCastSpell(35275)
	Unit:SendChatMessage(12, 0, "I am not alone!...")
end

function Dark_IA_arcane_blast(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(35314,Unit:GetClosestPlayer(1))
end

function Dark_IA_knockback(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(37317,Unit:GetClosestPlayer(1))	
end

function Dark_IA_frost_attack(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(35263,Unit:GetClosestPlayer(1))	
end

function Dark_IA_dragons_breath(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(35250,Unit:GetClosestPlayer(1))
	Unit:SendChatMessage(12, 0, "Think you can take the heat?...")
end

function Dark_IA_OnCombat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("Dark_IA_minions_summon",20000,0)
	Unit:RegisterEvent("Dark_IA_arcane_blast",18000,0)
	Unit:RegisterEvent("Dark_IA_knockback",8000,0)
	Unit:RegisterEvent("Dark_IA_frost_attack",10000,0)
	Unit:RegisterEvent("Dark_IA_dragons_breath",15000,0)
end

function Dark_IA_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Dark_IA_OnKilledTarget(Unit)
	Unit:SendChatMessage(12, 0, "Hahaha!")
end

function Dark_IA_OnDied(Unit)
	Unit:SendChatMessage(12, 0, "Do..not..Interfear!")
	Unit:RemoveEvents()
end

RegisterUnitEvent(66771, 1, "Dark_IA_OnCombat")
RegisterUnitEvent(66771, 2, "Dark_IA_OnLeaveCombat")
RegisterUnitEvent(66771, 3, "Dark_IA_OnKilledTarget")
RegisterUnitEvent(66771, 4, "Dark_IA_OnDied")