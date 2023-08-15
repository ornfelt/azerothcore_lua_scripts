--[[ Gastric - SlaveScripts.lua
Provides spells, events, and movement for mobs between
entries 70005 and 70007. Designed for the ACDB
project!
-- By Gastricpenguin ]]

-- Master's Slave
function mSlave_Plague(Unit)
	player = Unit:getClosestPlayer ()
	Unit:CastSpellOnTarget (16458, player)
end

function mSlave_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function mSlave_OnCombat(Unit, Event)
	Unit:RegisterEvent("mSlave_Plague",10000, 0)
end
RegisterUnitEvent(70005, 1, "mSlave_OnCombat")
RegisterUnitEvent(70005, 2, "mSlave_OnLeaveCombat") 


--Slave Driver
function dSlave_Buff(Unit)
	Unit:CastSpell(42084)
end

function dSlave_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function dSlave_OnCombat(Unit, Event)
	Unit:CastSpell(33079)
	Unit:RegisterEvent("dSlave_Buff",10000, 0)
end
RegisterUnitEvent(70006, 1, "dSlave_OnCombat")
RegisterUnitEvent(70006, 2, "dSlave_OnLeaveCombat") 


--Pet Fido : CHECK TO SEE IF THIS FIGHT WORKS!
function FidoCheckA(Unit)
	if Unit:GetHealthPct() < 75 then
	Unit:RemoveEvents()
	Unit:CastSpell(32651)
	end
end

function Fido_Bite(Unit)
	player = Unit:getClosestPlayer ()
	Unit:CastSpellOnTarget (30113, player)
end

function Fido_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Fido_OnCombat(Unit, Event)
	Unit:RegisterEvent("FidoCheckA",1000, 0)
	Unit:RegisterEvent("Fido_Bite",10000, 0)
end
RegisterUnitEvent(70008, 1, "Fido_OnCombat")
RegisterUnitEvent(70008, 2, "Fido_OnLeaveCombat") 

--Slave Overlord
function OverlordCheckA(Unit)
	x = Unit:GetX()
	y = Unit:GetY()
	z = Unit:GetZ()
	o = Unit:GetO()
	if Unit:GetHealthPct() < 40 then
	Unit:SpawnCreature(70005, x, y, z, o, 17, 10000);
	end
end

function Overlord_Cleave(Unit)
	player = Unit:getClosestPlayer ()
	Unit:CastSpellOnTarget (15579, player)
end

function Overlord_OnCombat(Unit, Event)
	Unit:SendChatMessage (12, 0, "Taste my blade!")
	Unit:RegisterEvent("OverlordCheckA",12000, 0)
	Unit:RegisterEvent("Overlord_Cleave",10000, 0)
end

function Overlord_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Overlord_OnDeath(Unit)
	Unit:SendChatMessage (12, 0, "What? Impossible!")
	Unit:RemoveEvents()
end

RegisterUnitEvent(70007, 1, "Overlord_OnCombat") 
RegisterUnitEvent(70007, 4, "Overlord_OnDeath") 
RegisterUnitEvent(70007, 2, "Overlord_OnLeaveCombat") 