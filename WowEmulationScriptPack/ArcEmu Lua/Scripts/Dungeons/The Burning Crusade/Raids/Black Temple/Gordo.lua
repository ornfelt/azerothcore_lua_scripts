--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   Gordo.lua
   Original Code by DARKI
   Version 1
========================================]]--

function NPCNAME_OnEnterCombat(pUnit,Event)
pUnit:SendChatMessage(12, 0, "Ha, you actually think that puny, weak gypsys like you can even affect an immortal such as myself? I am Omniscient!")
pUnit:SendChatMessage(14, 0, "Trust me, you stand no chance against my full power!")
pUnit:RegisterEvent("NPCNAME_ClassPick", 5000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
pUnit:CastSpell(20217)
pUnit:CastSpell(23948)
end


-- Random talk, 1-4 every ?? seconds.--


function NPCNAME_Talk(pUnit, Event)
Choice=math.random(1, 4)
if Choice==1 then
pUnit:SendChatMessage(14, 0, "You try so hard, yet fail so much...")
end
if Choice==2 then
pUnit:SendChatMessage(14, 0, "Your attacks do nothing to me! I am an immortal!")
end
if Choice==3 then
pUnit:SendChatMessage(14, 0, "Oh, how I wish you actually tried!")
end
if Choice==4 then
pUnit:SendChatMessage(14, 0, "You have one class, I have a choice of 8 classes at any moment. Who do YOU think will triumph?")
end 
end

function NPCNAME_TalkShaman(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Shamans, guardians of Thunder and Lightning!")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The elements run strong in the Shaman class...")
end
end

function NPCNAME_TalkPaladin(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Paladins, guardians of the Holy powers and the true defenders of the Alliance.")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The Holy Power runs strong in the Paladin class...")
end
end

function NPCNAME_TalkDruid(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Druids, guardians of Nature and all things living.")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The Natural Forces run strong in the Druid class...")
end
end

function NPCNAME_TalkPriest(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Priests, Masters of the Holy power and Spiritual Focus.")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The Priest Class makes me feel alive!")
end
end

function NPCNAME_TalkRogue(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Rogues, masters of Subtley and Hidden Movement.")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The Rogue Class brings me new opportinities...")
end
end

function NPCNAME_TalkWarrior(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Warriors, fearful tanks, body inpenetrable!")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The might of the Warrior, feel it!")
end
end

function NPCNAME_TalkWarlock(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Warlocks, guardians of Dark magic and hidden secrets.")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The shadows that surround the Warlock Class will always remain a mystery...")
end
end
--credits to nymphx of mmowned--
function NPCNAME_TalkMage(pUnit, Event)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Ah Mages, guardians of the 3 Magic fields: Frost, Fire and Arcane.")
end
if Choice==2 then
pUnit:SendChatMessage(12, 0, "The Mage class is very versatile, I may use this again sometime...")
end
end

-- This picks the class, random 1-8, can be the same class again if unlucky. Varys the fight. --


function NPCNAME_ClassPick(pUnit, Event)
pUnit:RemoveEvents()
Choice=math.random(1, 8)
if Choice==1 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Shaman!")
pUnit:RegisterEvent("NPCNAME_Shaman", 1000, 0)
pUnit:CastSpellOnTarget(34353,pUnit:GetRandomPlayer(0))
end 
if Choice==2 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Paladin!")
pUnit:RegisterEvent("NPCNAME_Paladin", 1000, 0)
pUnit:CastSpellOnTarget(27174,pUnit:GetRandomPlayer(0))
end
if Choice==3 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Druid!")
pUnit:RegisterEvent("NPCNAME_Druid", 1000, 0)
pUnit:CastSpell(33763)
pUnit:CastSpell(33763)
pUnit:CastSpell(33763)
end
if Choice==4 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Priest!")
pUnit:RegisterEvent("NPCNAME_Priest", 1000, 0)
pUnit:CastSpellOnTarget(25364,pUnit:GetRandomPlayer(0))
end
if Choice==5 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Rogue!")
pUnit:RegisterEvent("NPCNAME_Rogue", 1000, 0)
pUnit:CastSpellOnTarget(36554,pUnit:GetRandomPlayer(0))
pUnit:CastSpell(43547)
end
if Choice==6 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Warrior!")
pUnit:RegisterEvent("NPCNAME_Warrior", 1000, 0)
pUnit:CastSpellOnTarget(25264,pUnit:GetMainTank())
end
if Choice==7 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Warlock!")
pUnit:RegisterEvent("NPCNAME_Warlock", 1000, 0)
pUnit:CastSpell(27212)
end
if Choice==8 then
pUnit:SendChatMessage(14, 0, "Feel the power of the Mage!")
pUnit:RegisterEvent("NPCNAME_Mage", 1000, 0)
pUnit:CastSpellOnTarget(6131,pUnit:GetMainTank())
end
end


--SHAMAN OPTION 1--


function NPCNAME_Shaman(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellShamanChain", 11000, 0) --16033--
pUnit:RegisterEvent("NPCNAME_SpellShamanEarth", 13000, 0) --47071--
pUnit:RegisterEvent("NPCNAME_SpellShamanFrost", 14000, 0) --34353--
pUnit:RegisterEvent("NPCNAME_SpellShamanBuff", 5000, 0) --57802--
pUnit:SetModel(20681)
pUnit:SetScale(2)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkShaman", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end

function NPCNAME_SpellShamanChain(pUnit,Event)
pUnit:CastSpellOnTarget(16033,pUnit:GetMainTank())
end

function NPCNAME_SpellShamanEarth(pUnit,Event)
pUnit:CastSpellOnTarget(47071,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellShamanFrost(pUnit,Event)
pUnit:CastSpellOnTarget(34353,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellShamanBuff(pUnit,Event)
pUnit:CastSpell(49284)
end


--PALADIN OPTION 2--


function NPCNAME_Paladin(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellPaladinCons", 10000, 0) --27173--
pUnit:RegisterEvent("NPCNAME_SpellPaladinReckoning", 13500, 0) --20178--
pUnit:RegisterEvent("NPCNAME_SpellPaladinSeal", 30000, 0) --31801--
pUnit:RegisterEvent("NPCNAME_SpellPaladinShock", 15000, 0) --27174--
pUnit:RegisterEvent("NPCNAME_SpellPaladinShield", 12000, 0) --642--
pUnit:SetModel(6198)
pUnit:SetScale(2)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkPaladin", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end

function NPCNAME_SpellPaladinCons(pUnit,Event)
pUnit:CastSpell(27173)
end

function NPCNAME_SpellPaladinReckoning(pUnit,Event)
pUnit:CastSpell(20178)
end

function NPCNAME_SpellPaladinSeal(pUnit,Event)
pUnit:CastSpell(31801)
end

function NPCNAME_SpellPaladinShock(pUnit,Event)
pUnit:CastSpellOnTarget(27174,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellPaladinShield(pUnit,Event)
pUnit:CastSpell(642)
end

--DRUID OPTION 3--


function NPCNAME_Druid(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellDruidStarfire", 10000, 0) --26986--
pUnit:RegisterEvent("NPCNAME_SpellDruidCripple", 12000, 0) --20812--
pUnit:RegisterEvent("NPCNAME_SpellDruidLifebloom", 7000, 0) --33763--
pUnit:RegisterEvent("NPCNAME_SpellDruidNatures", 19000, 0) --27009--
pUnit:SetModel(5927)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkDruid", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end

function NPCNAME_SpellDruidStarfire(pUnit,Event)
pUnit:CastSpellOnTarget(26986,pUnit:GetMainTank())
end

function NPCNAME_SpellDruidCripple(pUnit,Event)
pUnit:CastSpellOnTarget(20812,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellDruidLifebloom(pUnit,Event)
pUnit:CastSpell(33763)
pUnit:CastSpell(33763)
pUnit:CastSpell(33763)
end

function NPCNAME_SpellDruidNatures(pUnit,Event)
pUnit:CastSpell(27009)
end


--PRIEST OPTION 4--


function NPCNAME_Priest(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellPriestNova", 8000, 0) --48078--
pUnit:RegisterEvent("NPCNAME_SpellPriestSmite", 10000, 0) --25364--
pUnit:RegisterEvent("NPCNAME_SpellPriestDispel", 19000, 0) --32375--
pUnit:RegisterEvent("NPCNAME_SpellPriestPain", 15000, 0) --25368--
pUnit:SetModel(5072)
pUnit:SetScale(1)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkPriest", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end

function NPCNAME_SpellPriestNova(pUnit,Event)
pUnit:CastSpellOnTarget(48078,pUnit:GetMainTank())
end
--credits to nymphx of mmowned--
function NPCNAME_SpellPriestSmite(pUnit,Event)
pUnit:CastSpellOnTarget(25364,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellPriestDispel(pUnit,Event)
pUnit:CastSpell(32375)
end

function NPCNAME_SpellPriestPain(pUnit,Event)
pUnit:CastSpellOnTarget(25368,pUnit:GetRandomPlayer(0))
pUnit:CastSpellOnTarget(25368,pUnit:GetMainTank())
end


--ROGUE OPTION 5--


function NPCNAME_Rogue(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellRogueBlind", 11000, 0) --2094--
pUnit:RegisterEvent("NPCNAME_SpellRogueGhostly", 6000, 0) --14278--
pUnit:RegisterEvent("NPCNAME_SpellRogueSStep", 15000, 0) --36554--
pUnit:SetModel(3618)
pUnit:SetScale(2)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkRogue", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end
--credits to nymphx of mmowned--
function NPCNAME_SpellRogueBlind(pUnit,Event)
pUnit:CastSpellOnTarget(2094,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellRogueGhostly(pUnit,Event)
pUnit:CastSpellOnTarget(14278,pUnit:GetMainTank())
end

function NPCNAME_SpellRogueSStep(pUnit,Event)
pUnit:CastSpellOnTarget(36554,pUnit:GetRandomPlayer(0))
end


--WARRIOR OPTION 6--


function NPCNAME_Warrior(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellWarriorClap", 15000, 0) --25264--
pUnit:RegisterEvent("NPCNAME_SpellWarriorRend", 9000, 0) --25208--
pUnit:RegisterEvent("NPCNAME_SpellWarriorMortal", 13000, 0) --30330--
pUnit:RegisterEvent("NPCNAME_SpellWarriorCharge", 16000, 0) --11578--
pUnit:SetModel(19536)
pUnit:SetScale(2)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkWarrior", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end

function NPCNAME_SpellWarriorClap(pUnit,Event)
pUnit:CastSpellOnTarget(25264,pUnit:GetMainTank())
end

function NPCNAME_SpellWarriorRend(pUnit,Event)
pUnit:CastSpellOnTarget(25208,pUnit:GetMainTank())
end

function NPCNAME_SpellWarriorMortal(pUnit,Event)
pUnit:CastSpellOnTarget(30330,pUnit:GetMainTank())
end

function NPCNAME_SpellWarriorCharge(pUnit,Event)
pUnit:CastSpellOnTarget(11578,pUnit:GetRandomPlayer(0))
end


--WARLOCK OPTION 7--


function NPCNAME_Warlock(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellWarlockRain", 16000, 0) --27212--
pUnit:RegisterEvent("NPCNAME_SpellWarlockAgony", 10000, 0) --11712--
pUnit:RegisterEvent("NPCNAME_SpellWarlockIdiocy", 9000, 0) --1010--
pUnit:RegisterEvent("NPCNAME_SpellWarlockCoil", 11000, 0) --17926--
pUnit:SetModel(4462)
pUnit:SetScale(2)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkWarlock", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end
--credits to nymphx of mmowned--
function NPCNAME_SpellWarlockRain(pUnit,Event)
pUnit:CastSpell(27212)
end

function NPCNAME_SpellWarlockAgony(pUnit,Event)
pUnit:CastSpellOnTarget(11712,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellWarlockIdiocy(pUnit,Event)
pUnit:CastSpellOnTarget(1010,pUnit:GetRandomPlayer(0))
end

function NPCNAME_SpellWarlockCoil(pUnit,Event)
pUnit:CastSpellOnTarget(17926,pUnit:GetRandomPlayer(0))
end


--MAGE OPTION 8--


function NPCNAME_Mage(pUnit, Event)
pUnit:RemoveEvents()
pUnit:RegisterEvent("NPCNAME_SpellMageExplosion", 10000, 0) --27082--
pUnit:RegisterEvent("NPCNAME_SpellMageCone", 15000, 0) --10161--
pUnit:RegisterEvent("NPCNAME_SpellMageNova", 12000, 0) --6131--
pUnit:RegisterEvent("NPCNAME_SpellMageLance", 8000, 0) --30455--
pUnit:SetModel(1484)
pUnit:SetScale(2)
pUnit:RegisterEvent("NPCNAME_ClassPick", 30000, 0)
pUnit:RegisterEvent("NPCNAME_TalkMage", 15000, 0)
pUnit:RegisterEvent("NPCNAME_Talk", 10000, 0)
end
--credits to nymphx of mmowned--
function NPCNAME_SpellMageExplosion(pUnit,Event)
pUnit:CastSpell(27082)
end

function NPCNAME_SpellMageCone(pUnit,Event)
pUnit:CastSpellOnTarget(10161,pUnit:GetMainTank())
end

function NPCNAME_SpellMageNova(pUnit,Event)
pUnit:CastSpellOnTarget(6131,pUnit:GetMainTank())
end

function NPCNAME_SpellMageLance(pUnit,Event)
pUnit:CastSpellOnTarget(30455,pUnit:GetRandomPlayer(0))
end


--Rest of Script--


function NPCNAME_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function NPCNAME_OnKilledTarget(pUnit)
pUnit:SendChatMessage(12, 0, "Feel my Wrath!")
pUnit:PlaySoundToSet(9250)
end


function NPCNAME_Death(pUnit)
pUnit:SendChatMessage(14, 0, "H...How can it be? I have nothing to say to you...")
pUnit:SendChatMessage(12, 0, "Boss Made By Nymphs, WoWImpulse Developer/Gm")
pUnit:RemoveEvents()
end

RegisterUnitEvent(22884, 1, "NPCNAME_OnEnterCombat")
RegisterUnitEvent(22884, 2, "NPCNAME_OnLeaveCombat")
RegisterUnitEvent(22884, 3, "NPCNAME_OnKilledTarget")
RegisterUnitEvent(22884, 4, "NPCNAME_Death")