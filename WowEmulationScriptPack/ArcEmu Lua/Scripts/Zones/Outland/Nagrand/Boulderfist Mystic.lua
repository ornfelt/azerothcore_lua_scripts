--[[ Nagrand - Boulderfist Mystic.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer/Performa of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Performa, August 25th, 2008. ]]

function Boulderfistmystic_LightningBolt(Unit, event, miscunit, misc)
    Unit:FullCastSpellOnTarget(9532,Unit:GetMainTank())
end

function Boulderfistmystic_EarthShock(Unit, event, miscunit, misc)
    Unit:FullCastSpellOnTarget(13281,Unit:GetMainTank())
end

function Boulderfistmystic_HealingTouch(Unit, event, miscunit, misc)
    if Unit:GetHealthPct() < 30 then
    Unit:FullCastSpell(11431)
	end
end

function Boulderfistmystic(Unit, event, miscunit, misc)
    Unit:RegisterEvent("Boulderfistmystic_LightningBolt",8500,0)
	Unit:RegisterEvent("Boulderfistmystic_Earthshock",6700,0)
	Unit:RegisterEvent("Boulderfistmystic_HealingTouch",3000,0)
end

function Boulderfistmystic_Death(Unit)
    Unit:RemoveEvents()
end

function Boulderfistmystic_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end

RegisterUnitEvent(17135,1,"Boulderfistmystic")
RegisterUnitEvent(17135,2,"Boulderfistmystic_OnLeaveCombat")
RegisterUnitEvent(17135,3,"Boulderfistmystic_Death")