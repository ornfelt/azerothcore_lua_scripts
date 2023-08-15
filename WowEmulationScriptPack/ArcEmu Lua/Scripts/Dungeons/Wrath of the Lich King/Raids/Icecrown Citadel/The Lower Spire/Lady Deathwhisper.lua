--[[
17268	IC_Deathwhisper_Event01B
17269	IC_Deathwhisper_Event01C
17270	IC_Deathwhisper_Event02A
17271	IC_Deathwhisper_Event02B
17272	IC_Deathwhisper_Event03A
17273	IC_Deathwhisper_Event03B
16868	IC_Deathwhisper_Aggro01
16869	IC_Deathwhisper_Slay01
16870	IC_Deathwhisper_Slay02
16871	IC_Deathwhisper_Death01
16872	IC_Deathwhisper_Berserk01
16873	IC_Deathwhisper_SP01
16874	IC_Deathwhisper_SP02
16875	IC_Deathwhisper_SP03
16876	IC_Deathwhisper_SP04
16877	IC_Deathwhisper_P2
16878	IC_Deathwhisper_Event01A
16879	IC_Deathwhisper_Event02
16880	IC_Deathwhisper_Event03
16881	IC_Deathwhisper_Attack
16882	IC_Deathwhisper_Wound
16883	IC_Deathwhisper_WoundCrit
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Lady Deathwhisper yells: All part of the Master's plan.... Your end is inevitable....
Lady Deathwhisper yells: Arise, and exult in your pure form!
Lady Deathwhisper yells: Do you yet grasp the futility of your actions?
Lady Deathwhisper yells: Embrace the darkness... darkness eternal.
Lady Deathwhisper yells: Enough! I see I must take matters into my own hands!
Lady Deathwhisper yells: Fix your eyes upon your crude hands: the sinew, the soft meat, the dark blood coursing within.
Lady Deathwhisper yells: I release you from the curse of flesh!
Lady Deathwhisper yells: It is a weakness; a crippling flaw.... A joke played by the Creators upon their own creations.
Lady Deathwhisper yells: Take this blessing and show these intruders a taste of the Master's power!
Lady Deathwhisper yells: The sooner you come to accept your condition as a defect, the sooner you will find yourselves in a position to transcend it.
Lady Deathwhisper yells: This charade has gone on long enough!
Lady Deathwhisper yells: Those who oppose him will be destroyed utterly, and those who serve -- who serve wholly, unquestioningly, with utter devotion of mind and soul -- elevated to heights beyond your ken.
Lady Deathwhisper yells: Through our Master, all things are possible. His power is without limit, and his will unbending.
Lady Deathwhisper yells: What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!
Lady Deathwhisper yells: You are weak, powerless to resist my will!
Lady Deathwhisper yells: You can see through the fog that hangs over this world like a shroud, and grasp where true power lies.
Lady Deathwhisper yells: You have found your way here, because you are among the few gifted with true vision in a world cursed with blindness.
]]--

function Ladydeathwhisper_OnCombat (pUnit, Event)
	pUnit:SendChatMessage(14, 0, "What is this Disturbance? You dare trespass on this hallowed ground? This shall be your final resting place!")
	pUnit:Root()
	pUnit:FullCastSpell(70842)
	pUnit:RegisterEvent("Ladydeathwhisper_Shadowbolt", 3000, 0)
	pUnit:RegisterEvent("Ladydeathwhisper_Deathdecay", 15000, 0)
	pUnit:RegisterEvent("Ladydeathwhisper_Adds", 60000, 0)
	pUnit:RegisterEvent("Ladydeathwhisper_Changeover", 1000, 0)
end

function Ladydeathwhisper_Shadowbolt (pUnit, Event)
	pUnit:FullCastSpellOnTarget(71254,pUnit:GetRandomPlayer(0))
end

function Ladydeathwhisper_Deathdecay(pUnit, Event)
local plr = pUnit:GetRandomPlayer(0)
local x = plr:GetX()
local y = plr:GetY()
local z = plr:GetZ()
	pUnit:CastSpellAoF(x, y, z,71001)
end
	
function Ladydeathwhisper_Adds (pUnit, Event)
local Addsspawn = math.random (1, 2)
	if (Addsspawn== 1) then
		pUnit:SpawnCreature(37890, -578.671448, 2159.502441, 50.848782, o, 14,80000)
		pUnit:SpawnCreature(37890, -619.650757, 2156.278076, 50.847198, o, 14,80000)
		pUnit:SpawnCreature(37949, -598.325012, 2157.934570, 50.848740, o, 14,80000)
		pUnit:SendChatMessage(42, 0, "Two Cult Fanatics and a Cult Adherent join the fight!")
	elseif (Addsspawn== 2) then
		pUnit:SpawnCreature(37949,-578.049744,2264.405518,50.848717, o, 14,80000)
		pUnit:SpawnCreature(37890,-598.825073,2264.582764,50.848755, o, 14,80000)
		pUnit:SpawnCreature(37949,-619.350220,2263.978516,50.848755, o, 14,80000)
		pUnit:SendChatMessage(42, 0, "Two Cult Adherents and a Cult Fanatic join the fight!")
	end
end

function Ladydeathwhisper_Changeover(pUnit, Event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:SendChatMessage(42, 0, "The Mana Barrier fades!")
		pUnit:SendChatMessage(14, 0, "This charade has gone on long enough!")
		pUnit:RemoveEvents()
		pUnit:RemoveAllAuras()
		pUnit:SetHealthPct(100)
		pUnit:SetMana(0)
		pUnit:Unroot()
		pUnit:RegisterEvent("Ladydeathwhisper_Deathdecay2", 10000, 0)
		pUnit:RegisterEvent("Ladydeathwhisper_Frostbolt", 15000, 0)
		pUnit:RegisterEvent("Ladydeathwhisper_Agrocurse", 25000, 0)
	end
end

	
	
function Ladydeathwhisper_Deathdecay2(pUnit, Event)
local plr = pUnit:GetRandomPlayer(0)
local x = plr:GetX()
local y = plr:GetY()
local z = plr:GetZ()
	pUnit:CastSpellAoF(x, y, z,71001)
end

function Ladydeathwhisper_Frostbolt (pUnit, Event)
	pUnit:FullCastSpellOnTarget(71420,pUnit:GetMainTank())
end	

function Ladydeathwhisper_Agrocurse(pUnit, Event)
	pUnit:FullCastSpellOnTarget(71204,pUnit:GetMainTank())
end 

function Ladydeathwhisper_OnKillPlr (pUnit, Event)
local chance = math.random(1, 2)
	if (chance == 1) then
		pUnit:SendChatMessage(14, 0, "Embrace the darkness... darkness eternal.")
		pUnit:PlaySoundToSet(16942)
	else
		pUnit:SendChatMessage(14, 0, "Do you get grasp the futility of your actions?")
	end
end
	
function Ladydeathwhisper_OnDeath (pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:RemoveAllAuras()
	pUnit:SendChatMessage(14, 0, "All part of the Master's plan.... Your end is inevitable....")
end

function Ladydeathwhisper_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:RemoveAllAuras()
	pUnit:SetMana(3346800)
end

function Deathwhisper_ManaBarrier(pUnit, Event, player, damage)
local mana = pUnit:GetMana()
local hp = pUnit:GetHealth()
	if pUnit:HasAura(70842) then --Checks if she has Mana Barrier
		pUnit:SetHealth(hp + damage)
		pUnit:SetMana(mana - damage)
		if pUnit:GetManaPct() == 0 then
			pUnit:RemoveAura(70842)
		end
	end
end

RegisterUnitEvent(36855, 23, "Deathwhisper_ManaBarrier")
RegisterUnitEvent(36855, 1, "Ladydeathwhisper_OnCombat")
RegisterUnitEvent(36855, 2, "Ladydeathwhisper_OnLeaveCombat")
RegisterUnitEvent(36855, 3, "Ladydeathwhisper_OnKillPlr")
RegisterUnitEvent(36855, 4, "Ladydeathwhisper_OnDeath")