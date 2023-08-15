-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
Plugger Spazzring yells: Hey! Get away from that!
Plugger Spazzring yells: Hey! Stop that!
Plugger Spazzring yells: Hey, my pockets were picked!
Plugger Spazzring yells: No stealing the goods!
Plugger Spazzring yells: That's it! No more beer until this mess is sorted out!
Plugger Spazzring yells: That's it! You're going down!
Plugger Spazzring yells: What are you doing over there?
Plugger Spazzring says: Drink up! There's more where that came from!
Plugger Spazzring says: Enjoy! You won't find better ale anywhere!
Plugger Spazzring says: Have you tried the Dark Iron Ale? It's the best!
Plugger Spazzring says: Try the boar! It's my new recipe!
----Spells-ID
Banish-8994
Curse of Tongues-13338
Demon Armor-13787
Immolate-12742
Shadow Bolt-12739
]]--

function PSR_OnSpawn(pUnit, Event)
local chance = math.random(1,4)
	if ( chance == 1) then
		pUnit:SendChatMessage(11, 0, "Drink up! There's more where that came from!")
	end
	if ( chance == 2) then
		pUnit:SendChatMessage(11, 0, "Enjoy! You won't find better ale anywhere!")
	end
	if ( chance == 3) then
		pUnit:SendChatMessage(11, 0, "Have you tried the Dark Iron Ale? Its the best!")
	end
	if ( chance == 4) then
		pUnit:SendChatMessage(11, 0, "Try the boar! It's my new recipe!")
	end
end

function PSR_OnCombat(pUnit, Event)
local chance = math.random(1,7)
	if ( chance == 1) then
		pUnit:SendChatMessage(12, 0, "That's it! No more beer until this mess is sorted out!")
	end
	if ( chance == 2) then
		pUnit:SendChatMessage(12, 0, "That's it! You're going donw!")
	end
	if ( chance == 3) then
		pUnit:SendChatMessage(12, 0, "What are you doing over there?")
	end
	if ( chance == 4) then
		pUnit:SendChatMessage(12, 0, "No Stealing the goods!")
	end
	if ( chance == 5) then
	pUnit:SendChatMessage(12, 0, "Hey, my pockets were picked!")
	end
	if ( chance == 6) then
	pUnit:SendChatMessage(12, 0, "Hey! Stop that!")
	end
	if ( chance == 7) then
		pUnit:SendChatMessage(12, 0, "Hey! Get away from that!")
	end
	pUnit:RegisterEvent("PSR_CurseofTongues", 5000, 0) --Time could be wrong
	pUnit:RegisterEvent("PSR_DemonArmor", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("PSR_ShadowBolt", 25000, 0) --Time could be wrong
	pUnit:RegisterEvent("PSR_Immolate", 30000, 0) --Time could be wrong
	pUnit:RegisterEvent("PSR_Banish", 35000, 0) --Time could be wrong
end

function PSR_CurseofTongues(pUnit, Event)
	pUnit:CastSpellOnTarget(13338)
end

function PSR_Banish(pUnit, Event)
	pUnit:FullCastSpellonTarget(8994)
end

function PSR_DemonArmor(pUnit, Event)
	pUnit:CastSpell(13787)
end

function PSR_Immolate(pUnit, Event)
	pUnit:FullCastSpellonTarget(12742)
end

function PSR_ShadowBolt(pUnit, Event)
	pUnit:FullCastSpellonTarget(12739)
end

function PSR_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function PSR_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9499, 1, "PSR_OnCombat")
RegisterUnitEvent(9499, 2, "PSR_OnLeaveCombat")
RegisterUnitEvent(9499, 4, "PSR_OnDeath")
RegisterUnitEvent(9499, 5, "PSR_OnSpawn")