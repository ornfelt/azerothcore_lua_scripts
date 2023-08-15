--[[

	This is created by zdroid9770  :D

	© Copyright 2012

   Please if you share this elsewhere include me in the Credits for makeing this Script.
   You can learn to make your own here:
   "http://www.ac-web.org/forums/showthread.php?t=58843"
   
]]



function Boss_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Another pesky Horde...")
pUnit:RegisterEvent("Boss_Spell", 1000, 0)
end

function Boss_Spell(pUnit, Event)
pUnit:CastSpellOnTarget(5, pUnit:GetMainTank())
end

function Boss_OnLeaveCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "ughhh")
pUnit:RemoveEvents()
end

function Boss_OnKilledTarget(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "Don't come again or your banned by my GM skillz!")
		pUnit:PlaySoundToSet(11466)
        pUnit:CastSpell(36300)
end

function Boss_OnDeath(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "Oh Crap :(")
        pUnit:RemoveEvents()
end

RegisterUnitEvent(100000, 1, "Boss_OnCombat")
RegisterUnitEvent(100000, 2, "Boss_OnLeaveCombat")
RegisterUnitEvent(100000, 3, "Boss_OnKilledTarget")
RegisterUnitEvent(100000, 4, "Boss_OnDeath")