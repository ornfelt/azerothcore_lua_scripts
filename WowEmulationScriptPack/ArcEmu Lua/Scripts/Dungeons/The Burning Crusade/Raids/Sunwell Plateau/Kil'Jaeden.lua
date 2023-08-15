--[[ Boss - Kil'Jaeden.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, August 27, 2008. ]]

function Kil_OnEnterCombat(pUnit,Event)
	pUnit:GetX()
	pUnit:GetY()
	pUnit:GetZ()
	pUnit:GetO()
	pUnit:Root()
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Kil_Emerge", 0001, 1)
end

function Kil_Emerge(pUnit,Event)
	pUnit:Root()
	pUnit:SendChatMessage(14, 0, "The expendible have perished... So be it! Now I shall succeed where Sargeras could not! I will bleed this wretched world and secure my place as the true master of the Burning Legion. The end has come! Let the unraveling of this world commence!")
	pUnit:PlaySoundToSet(12500)
	pUnit:CastSpell(35177)
	pUnit:RegisterEvent("Kil_Phase1", 13000, 1) -- Takes 10 sec. to Emerge
end

function Kil_OnKill(pUnit,Event)
	pUnit:Root()
	pUnit:RemoveEvents()
	local Choice=math.random(1, 2)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "Another step towards destruction!")
			pUnit:PlaySoundToSet(12501)
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Anak'Kiri.")
			pUnit:PlaySoundToSet(12502)
end
end

function Kil_Phase1(pUnit,Event)
	pUnit:Root()
	pUnit:RegisterEvent("Kil_SF",4000, 0) -- Soul Flay
	pUnit:RegisterEvent("Kil_LL",16000, 0) -- Legion Lightning 
	pUnit:RegisterEvent("Kil_FB",5000, 0) -- Fire Bloom
	pUnit:RegisterEvent("Kil_Orbs", 21000, 1)
	pUnit:RegisterEvent("Kil_Phase2", 1000, 1)
end
	
function Kil_SF(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45442,pUnit:GetClosestPlayer())
end
	
function Kil_LL(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45664,pUnit:GetClosestPlayer())
end
	
function Kil_FB(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45641,pUnit:GetClosestPlayer())
end

function Kil_Phase2(pUnit,Event)
 if pUnit:GetHealthPct() == 85 then
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:SendChatMessage(14, 0, "I will not be denied! This world shall fall!")
	pUnit:PlaySoundToSet(12508)
	pUnit:RegisterEvent("Kil_SR",42000, 0) -- Sinister Reflection
	pUnit:RegisterEvent("Kil_SS",55000, 0) -- Shadow Spike
	pUnit:RegisterEvent("Kil_FD",3000, 0) -- Flame Dart
	pUnit:RegisterEvent("Kil_DOATS",10000, 0) -- Darkness of a Thousand Souls
	pUnit:RegisterEvent("Kil_Orbs2", 25000, 0)
	pUnit:RegisterEvent("Kil_Phase3", 1000, 1)
end
end

function Kil_SR(pUnit,Event)
pUnit:FullCastSpellOnTarget(45892,pUnit:GetClosestPlayer())
	local Choice=math.random(1, 2)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "Who can you trust?")
			pUnit:PlaySoundToSet(12503)
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "The enemy is among you.")
			pUnit:PlaySoundToSet(12504)
end
end

function Kil_SS(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45892,pUnit:GetClosestPlayer())
end

function Kil_SR(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45892,pUnit:GetClosestPlayer())
end

function Kil_SR(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45892,pUnit:GetClosestPlayer())
end

function Kil_FD(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45641,pUnit:GetClosestPlayer())
end

function Kil_DOATS(pUnit,Event)
pUnit:FullCastSpellOnTarget(45657,pUnit:GetClosestPlayer())
	local Choice=math.random(1, 3)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "Chaos!")
			pUnit:PlaySoundToSet(12505)
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Destruction!")
			pUnit:PlaySoundToSet(12506)
		elseif Choice==3 then
			pUnit:SendChatMessage(14, 0, "Oblivion!")
			pUnit:PlaySoundToSet(12507)
end
end

function Kil_Orbs(pUnit,Event)
	pUnit:SpawnCreature(25502, x40, y, z20, o, 14, o)
end

function Kil_Orbs2(pUnit,Event)
	pUnit:SpawnCreature(25502, x40, y, z20, o, 14, o)
	pUnit:SpawnCreature(25502, x40, y, z20, o, 14, o)
end

function Kil_Orbs3(pUnit,Event)
 if pUnit:GetHealthPct() == 50 then
	pUnit:SpawnCreature(25502, x40, y, z20, o, 14, o)
	pUnit:SpawnCreature(25502, x40, y, z20, o, 14, o)
	pUnit:SpawnCreature(25502, x40, y, z20, o, 14, o)
end
end

function Kil_Phase3(pUnit,Event)
 if pUnit:GetHealthPct() == 50 then
	pUnit:Root()
	pUnit:SendChatMessage(14, 0, "Do not harbor false hope. You cannot win!")
	pUnit:PlaySoundToSet(12509)
	pUnit:RegisterEvent("Kil_MeteorStorm", 11000, 0)
	pUnit:RegisterEvent("Kil_Phase4", 1000, 1)
end
end

function Kil_MeteorStorm(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45915,pUnit:GetRandomPlayer(0))
end

function Kil_Phase4(pUnit,Event)
 if pUnit:GetHealthPct() == 25 then
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:SendChatMessage(14, 0, "Aggghh! The powers of the Sunwell... turn... against me! What have you done? What have you done???")
	pUnit:PlaySoundToSet(12510)
	pUnit:CastSpell(46474)
	pUnit:RegisterEvent("Kil_SR",21000, 0) -- Sinister Reflection
	pUnit:RegisterEvent("Kil_SS",27500, 0) -- Shadow Spike
	pUnit:RegisterEvent("Kil_FD",1500, 0) -- Flame Dart
	pUnit:RegisterEvent("Kil_DOATS",20000, 0) -- Darkness of a Thousand Souls
	pUnit:RegisterEvent("Kil_SF",4000, 0) -- Soul Flay
	pUnit:RegisterEvent("Kil_LL",8000, 0) -- Legion Lightning 
	pUnit:RegisterEvent("Kil_FB",2500, 0) -- Fire Bloom
end
end

function Kil_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end


function Kil_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25315, 1, "Kil_OnEnterCombat")
RegisterUnitEvent(25315, 2, "Kil_OnLeaveCombat")
RegisterUnitEvent(25315, 3, "Kil_OnKill")
RegisterUnitEvent(25315, 4, "Kil_OnDied")