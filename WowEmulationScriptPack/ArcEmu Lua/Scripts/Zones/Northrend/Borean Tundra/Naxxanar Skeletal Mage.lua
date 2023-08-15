--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NaxxanarSkeletalMage_OnCombat(Unit, Event)
Unit:RegisterEvent("NaxxanarSkeletalMage_Fireball", 7000, 0)
Unit:RegisterEvent("NaxxanarSkeletalMage_Frostbolt", 10000, 0)
end

function NaxxanarSkeletalMage_Fireball(Unit, Event) 
Unit:FullCastSpellOnTarget(9053, Unit:GetMainTank()) 
end

function NaxxanarSkeletalMage_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9672, Unit:GetMainTank()) 
end

function NaxxanarSkeletalMage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NaxxanarSkeletalMage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NaxxanarSkeletalMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25396, 1, "NaxxanarSkeletalMage_OnCombat")
RegisterUnitEvent(25396, 2, "NaxxanarSkeletalMage_OnLeaveCombat")
RegisterUnitEvent(25396, 3, "NaxxanarSkeletalMage_OnKilledTarget")
RegisterUnitEvent(25396, 4, "NaxxanarSkeletalMage_OnDied")