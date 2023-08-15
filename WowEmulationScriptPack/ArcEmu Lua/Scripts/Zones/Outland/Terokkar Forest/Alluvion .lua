--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 27th, 2008. ]]

-- Note all the randomizations of my scripts
-- Randomizing to simulate the non garunteed spell casting
-- Such as the way blizzard npcs dont cast everything the 
-- ever 3 secs its always random


function Aluvion_FrostNova(Unit) -- Frost nova spell
	local casting = Unit:IsCasting()
	if(casting == false) then
		Unit:CastSpell(15063)
	end
	if(casting == true) then
		Unit:CancelSpell(38669) -- This may or may not work im unsure never used this command
	end
end

function Aluvion_WaterBolt(Unit) -- WaterBolt Spell
	local casting = Unit:IsCasting()
	if(casting == false) then
		Unit:FullCastSpellOnTarget(38669)
	end
	if(casting == true) then
		print("Spell Interupted due to Frostnova is casting")
		Unit:CancelSpell(38669)
	end
end

--Time to Randomize
function Aluvion_OnEnterCombat(Unit, event)
	local frost = math.random(5300,7200)
	local water = math.random(2600,5700)
	Unit:RegisterEvent("Aluvion_FrostNova", frost, 0)
	Unit:RegisterEvent("Aluvion_WaterBolt", water, 0)
	Unit:FullCastSpellOnTarget(38669)
end

RegisterUnitEvent(21730, 1, "Aluvion_OnEnterCombat")