-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

math.randomseed(os.time())

function Hound_Cleave(pUnit, Event)
	pUnit:FullCastSpellOnTarget(38260, pUnit:GetMainTank()) 
end

function Hound_Claw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13737, pUnit:GetClosestPlayer())
end

function Hound_Bash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(36205, pUnit:GetClosestPlayer()) 
end

function Hound_Roar(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10968, pUnit:GetMainTank()) 
end

function Scarlet_Tracking_Hound_Spawn(pUnit, Event) 
	pUnit:SpawnCreature(4304, 123.9871, -259.8943, 18.5445, 0.3783, 67, 1000)
end

function HoundmasterLoksey_Enrage(pUnit)
    if pUnit:GetHealthPct() <= 25 then
		pUnit:RemoveEvents()
		pUnit:FullCastSpell(28747)
	end
end

function HoundmasterLoksey_OnCombat(Unit)
	Unit:SendChatMessage(12,0,"Release the hounds!")
	Unit:PlaySoundToSet(5841)
	Unit:RegisterEvent("Hound_Cleave",math.random(15000,30000),0)
	Unit:RegisterEvent("HoundmasterLoksey_Enrage",1000,0)
	Unit:RegisterEvent("Hound_Cleave", 70000, 10)
	Unit:RegisterEvent("Hound_Claw", 60000, 10)
	Unit:RegisterEvent("Hound_Bash", 100000, 10)
	Unit:RegisterEvent("Hound_Roar", 100000, 10)
	Unit:RegisterEvent("Scarlet_Tracking_Hound_Spawn",1000,0)
end

function HoundmasterLoksey_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
    --collectgarbage();
end

function HoundmasterLoksey_OnDied(pUnit)
    pUnit:RemoveEvents() 
end

RegisterUnitEvent(3974, 1, "HoundmasterLoksey_OnCombat")
RegisterUnitEvent(3974, 2, "HoundmasterLoksey_LeaveCombat")
RegisterUnitEvent(3974, 4, "HoundmasterLoksey_OnDied")