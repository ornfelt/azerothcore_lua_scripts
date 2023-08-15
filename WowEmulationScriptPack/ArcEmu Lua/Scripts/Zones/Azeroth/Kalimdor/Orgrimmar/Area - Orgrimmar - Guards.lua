--[[ Area - Orgrimmar - Guards.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 27th, 2008. ]]

-- Orgrimmar Grunt

function Grunt_OnEnterCombat(pUnit,Event)
    pUnit:SendChatMessage(11, 0,"For the Horde!")
    pUnit:RegisterEvent("Grunt_Cleave",6000,0)
end

function Grunt_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(40505,pUnit:GetMainTank())
end

function Grunt_OnLeaveCombat(pUnit,Event)
    pUnit:RemoveEvents()
end

function Grunt_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(3296,1,"Grunt_OnEnterCombat")
RegisterUnitEvent(3296,2,"Grunt_OnLeaveCombat")
RegisterUnitEvent(3296,4,"Grunt_OnDied")


-- Kor'kron Elite

function Elite_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Elite_Cleave",6000,0)
    pUnit:RegisterEvent("Elite_Enrage",30000,(1))
end

function Elite_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(40505,pUnit:GetMainTank())
end

function Elite_Enrage(pUnit,Event)
    pUnit:CastSpell(8599)
end

function Elite_OnLeaveCombat(pUnit,Event)
    pUnit:RemoveEvents()
end

function Elite_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(14304,1,"Elite_OnEnterCombat")
RegisterUnitEvent(14304,2,"Elite_OnLeaveCombat")
RegisterUnitEvent(14304,4,"Elite_OnDied")

-- Scout Manslayer & Stronghand & Tharr

function Scout_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Scout_Net",8000,0)
    pUnit:RegisterEvent("Scout_Armor",6000,0)
end

function Scout_Net(pUnit,Event)
    pUnit:FullCastSpellOnTarget(14030,pUnit:GetMainTank())
end

function Scout_Armor(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15572,pUnit:GetMainTank())
end

function Scout_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

function Scout_OnLeaveCombat(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(14376,1,"Scout_OnEnterCombat")
RegisterUnitEvent(14376,2,"Scout_OnLeaveCombat")
RegisterUnitEvent(14376,4,"Scout_OnDied")

RegisterUnitEvent(14375,1,"Scout_OnEnterCombat")
RegisterUnitEvent(14375,2,"Scout_OnLeaveCombat")
RegisterUnitEvent(14375,4,"Scout_OnDied")

RegisterUnitEvent(14377,1,"Scout_OnEnterCombat")
RegisterUnitEvent(14377,2,"Scout_OnLeaveCombat")
RegisterUnitEvent(14377,4,"Scout_OnDied")

-- Warchief Thrall

function Thrall_OnEnterCombat(pUnit,Event)
    pUnit:PlaySoundToSet (5880)
    pUnit:RegisterEvent("Thrall_Chain",11000,0)
    pUnit:RegisterEvent("Thrall_Shock",6000,0)
end

function Thrall_Chain(pUnit,Event)
    pUnit:FullCastSpellOnTarget(16033,pUnit:GetMainTank())
end

function Thrall_Shock(pUnit,Event)
    pUnit:FullCastSpellOnTarget(16034,pUnit:GetMainTank())
end
    
function Thrall_OnLeaveCombat(pUnit,Event)
    pUnit:RemoveEvents()
end

function Thrall_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(4949,1,"Thrall_OnEnterCombat")
RegisterUnitEvent(4949,2,"Thrall_OnLeaveCombat")
RegisterUnitEvent(4949,4,"Thrall_OnDied")

-- Troll Roof Stalker