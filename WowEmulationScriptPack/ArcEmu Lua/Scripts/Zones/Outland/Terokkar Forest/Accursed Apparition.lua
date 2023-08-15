--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 27th, 2008. ]]

--Dont Know if this will work sometimes invisibility doesn't work with LUA
--Here it goes

function AccursedApparition_OnSpawn(Unit) -- Initiates On Spawn Function
	Unit:CastSpell(16380) -- Instant Cast Greater Invisibility
end 

RegisterUnitEvent(21941, 6, "AccursedApparition_OnSpawn") -- Registering to Mob 21941 Which is [from wowhead] http://www.wowhead.com/?npc=21941
