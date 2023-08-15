--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
--http://wotlk.wowhead.com/?npc=25353#abilities
--Beryl Treasure Hunter
function BerylTreasureHunter_OnEnterCombat(Unit,Event)
		Unit:RegisterEvent("BerylTreasureHunter_Beam", 2000, 0) --2 Seconds timer :) not Blizzlike(still beta :) 
end

function BerylTreasureHunter_Beam(Unit,Event)
		Unit:FullCastSpellOnTarget(50658,	Unit:GetClosestPlayer())
end

function BerylTreasureHunter_OnLeaveCombat(Unit,Event)
		Unit:RemoveEvents()
end

function BerylTreasureHunter_OnDied(Unit,Event)
		Unit:RemoveEvents()
end

--http://wotlk.wowhead.com/?npc=25316#abilities
--Beryl Sorcerer
function BerylSorcerer_OnEnterCombat(Unit,Event)
		Unit:RegisterEvent("BerylSorcerer_Beam", 3200, 3) --3 Second Cast Time Should do from 3 to 4 Times Random :)
end

function BerylSorcerer_Beam(Unit,Event)
		Unit:FullCastSpellOnTarget(9672,	Unit:GetRandomPlayer()) --Loled at Damage its from wowhead :) i will Change it When BLizzard Release WotlK and i Get Better info :P
end

function BerylSorcerer_OnLeaveCombat(Unit,Event)
		Unit:RemoveEvents()
end

function BerylSorcerer_OnDied(Unit,Event)
		Unit:RemoveEvents()
end

RegisterUnitEvent (25353, 1, "BerylTreasureHunter_OnEnterCombat")
RegisterUnitEvent (25353, 2, "BerylTreasureHunter_OnLeaveCombat")
RegisterUnitEvent (25353, 4, "BerylTreasureHunter_OnDied")
RegisterUnitEvent (25316, 1, "BerylSorcerer_OnEnterCombat")
RegisterUnitEvent (25316, 2, "BerylSorcerer_OnLeaveCombat")
RegisterUnitEvent (25316, 4, "BerylSorcerer_OnDied")

