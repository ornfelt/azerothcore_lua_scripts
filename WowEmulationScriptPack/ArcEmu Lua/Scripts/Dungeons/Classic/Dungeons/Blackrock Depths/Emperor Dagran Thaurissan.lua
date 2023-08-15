-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Emperor Dagran Thaurissan yells: Ha! You can't even begin to imagine the futility of your efforts.
Emperor Dagran Thaurissan yells: Hail to the king, baby!
Emperor Dagran Thaurissan yells: I will crush you into little tiny pieces!
Emperor Dagran Thaurissan yells: Is that the best you can do? Do you really expect that you could defeat someone as awe inspiring as me?
Emperor Dagran Thaurissan yells: Thank you for clearing out those foolish senators. Now prepare to meet your doom at the hands of Ragnaros' most powerful servant.
Emperor Dagran Thaurissan yells: They were just getting in the way anyways.
Emperor Dagran Thaurissan yells: Your efforts are utterly pointless, fools! You will never be able to defeat me!
----Spells-ID
Avatar of Flame-15636
Hand of Thaurissan-17492
]]--
function EDT_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "I will crush you into little tiny pieces!")
	pUnit:RegisterEvent("EDT_AvatarofFlame", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("EDT_HandOfThaurissan", 5000, 0) --Time could be wrong
end

function EDT_AvatarofFlame(pUnit,Event)
	pUnit:CastSpell(15636)
end

function EDT_HandOfThaurissan(pUnit, Event)
	pUnit:CastSpell(17492)
end

--[[ 

Aggro encounter will go here.

What he say to start aggro: Come to aid the Throne!

What he say after aggro (killing Shadowforge Senate): Thank you for clearing out those foolish senators. Now prepare to meet your doom at the hands of Ragnaros' most powerful servant.
They were just getting in the way anyways.

--]]

function EDT_OnKilledTarget(pUnit, Event)
local npcsay = math.random(1, 3)
	if(npcsay == 1) then
		pUnit:SendChatMessage(12, 0, "Hail to the King, baby!")
	end
	if(npcsay == 2) then
		pUnit:SendChatMessage(12, 0, "Is that the best you can do? Do you really expect that you could defeat someone as awe inspiring as me?")
	end
	if(npcsay == 3) then
		pUnit:SendChatMessage(12, 0, "Your efforts are utterly pointless, fools! You will never be able to defeat me!")
	end
end

function EDT_OnLeaveCombat(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "They were just getting in the way anyways.")
	pUnit:RemoveEvents()
end

function EDT_OnDeath(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9019, 1, "EDT_OnCombat")
RegisterUnitEvent(9019, 2, "EDT_OnLeaveCombat")
RegisterUnitEvent(9019, 3, "EDT_OnKilledTarget")
RegisterUnitEvent(9019, 4, "EDT_OnDeath")