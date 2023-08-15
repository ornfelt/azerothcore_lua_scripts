--[[

     This Lua is brought to you by zdroid9770
     Some Credit goes to: Rochet2 for helping me a part on the "OnKilledTarget" Part.
     © Copyright 2011
]]

-- Add spawn and Despawn for Time Keeper(Search on wowhead [Time keeper])




function Aeonus_OnCombat(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "The time has come to shatter this clockwork universe forever! Let us no longer be slaves of the hourglass! I warn you: those who do not embrace the greater path shall become victims of its passing!")
	    pUnit:RegisterEvent("Aeonus_Spell1", 20000, 0)
end

function Aeonus_Spell1(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "Let us see what fate lays in store...")
        pUnit:CastSpellOnTarget(31422, pUnit:GetMainTank())
		pUnit:RegisterEvent("Aeonus_Spell2", 30000, 0)
end

function Aeonus_Spell2(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "Your time is up, slave of the past!(This part is being worked on)")
        pUnit:CastSpellOnTarget(31473, pUnit:GetMainTank())
		pUnit:Castspell(37853)
end
		
function Aeonus_OnLeaveCombat(pUnit, Event)
        pUnit:Castspell(37853)
end

function Aeonus_OnKilledTarget(pUnit, Event)
        if(math.random(1,2) == 1) then
                pUnit:SendChatMessage(14, 0, "No one can stop us! No one!")
        else
                pUnit:SendChatMessage(14, 0, "One less obstacle in our way!")
        end
end
function Aeonus_OnDeath(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "We will triumph.. It is only a matter...of time.")
end


RegisterUnitEvent(17881, 1, "Aeonus_OnCombat")
RegisterUnitEvent(17881, 2, "Aeonus_OnLeaveCombat")
RegisterUnitEvent(17881, 3, "Aeonus_OnKilledTarget")
RegisterUnitEvent(17881, 4, "Aeonus_OnDeath")