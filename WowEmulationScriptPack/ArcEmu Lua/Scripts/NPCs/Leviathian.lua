function Leviathan_OnEnterCombat(Unit,Event)
   	Unit:SendChatMessage(12, 0, "I may look like a usual beast that you hunt, but having two heads can have it's uses!")
   	Unit:RegisterEvent("Leviathan_Morph1", 1000, 0)
   	Unit:CastSpell(15473)
   	Unit:RegisterEvent("Leviathan_Talk", 15000, 0)
   	Unit:RegisterEvent("Leviathan_Empowering", 20000, 0)
   	Unit:RegisterEvent("Leviathan_SpellCrushing", 14000, 0)
   	Unit:RegisterEvent("Leviathan_SpellBolt", 15000, 0)
   	Unit:RegisterEvent("Leviathan_SpellPain", 17000, 0)
end
--Phase/Morph Specific Spells--
--ShadowPhase, 100 to 75 percent--
function Leviathan_Empowering(Unit,Event)
   	Unit:CastSpell(33783)
end

function Leviathan_SpellCrushing(Unit,Event)
   	Unit:CastSpellOnTarget(40243,Unit:GetRandomPlayer(0))
end

function Leviathan_SpellBolt(Unit,Event)
   	Unit:CastSpellOnTarget(27209,Unit:GetRandomPlayer(0))
end

function Leviathan_SpellPain(Unit,Event)
       	Unit:CastSpellOnTarget(25368,Unit:GetRandomPlayer(0))
       	Unit:CastSpellOnTarget(25368,Unit:GetMainTank())
end
--FirePhase, 75 to 50 percent--
function Leviathan_SpellFirecone(Unit,Event)
       	Unit:CastSpellOnTarget(19630,Unit:GetClosestPlayer())
end

function Leviathan_SpellFireball(Unit,Event)
       	Unit:CastSpellOnTarget(25306,Unit:GetMainTank())
end

function Leviathan_SpellFireRain(Unit,Event)
       	Unit:CastSpell(27212)
end

function Leviathan_SpellSteal(Unit,Event)
       	Unit:CastSpellOnTarget(30449,Unit:GetRandomPlayer(0))
end
--IceFrostPhase, 50 to 25 percent--
function Leviathan_SpellFrostbolt(Unit,Event)
       	Unit:CastSpellOnTarget(38697,Unit:GetRandomPlayer(0))
end

function Leviathan_SpellBreath(Unit,Event)
       	Unit:CastSpellOnTarget(44799,Unit:GetClosestPlayer())
end

function Leviathan_SpellClaw(Unit,Event)
       	Unit:CastSpellOnTarget(3130,Unit:GetMainTank())
end

function Leviathan_SpellCone(Unit,Event)
       	Unit:CastSpellOnTarget(10159,Unit:GetClosestPlayer())
end

function Leviathan_SpellPlague(Unit,Event)
       	Unit:CastSpellOnTarget(40351,Unit:GetRandomPlayer(0))
end
--WarriorPhase, 25 to 1 percent--
function Leviathan_SpellCleave(Unit,Event)
       	Unit:CastSpellOnTarget(25231,Unit:GetMainTank())
end

function Leviathan_SpellBlackCleave(Unit,Event)
       	Unit:CastSpellOnTarget(33480,Unit:GetClosestPlayer())
end

function Leviathan_SpellClap(Unit,Event)
       	Unit:CastSpellOnTarget(6343,Unit:GetMainTank())
end

function Leviathan_SpellRend(Unit,Event)
       	Unit:CastSpellOnTarget(25208,Unit:GetRandomPlayer(0))
end

function Leviathan_SpellAgony(Unit,Event)
       	Unit:CastSpellOnTarget(36836,Unit:GetRandomPlayer(0))
end

function Leviathan_SpellAgony(Unit,Event)
       	Unit:CastSpellOnTarget(36836,Unit:GetRandomPlayer(0))
end
--Morphs and Phases--
--Morph one, Al'Ah display ID, FirePhase enabled, 75 to 50 percent--
function Leviathan_Morph1(Unit,Event)
 if	Unit:GetHealthPct() <= 75 then
   	Unit:RemoveEvents()
   	Unit:SetModel(18945)
   	Unit:SendChatMessage(12, 0, "You think you are a match for me? Pfft, what about if I do.... THIS?")
   	Unit:SetScale(0.3)
   	Unit:CastSpell(25431)
   	Unit:RegisterEvent("Leviathan_Talk", 15000, 0)
   	Unit:RegisterEvent("Leviathan_SpellFirecone", 18000, 0)
   	Unit:RegisterEvent("Leviathan_SpellFireball", 15000, 0)
   	Unit:RegisterEvent("Leviathan_SpellFireRain", 8000, 0)
   	Unit:RegisterEvent("Leviathan_SpellSteal", 20000, 0)
   	Unit:RegisterEvent("Leviathan_Morph2", 1000, 0)  
end
end
--Morph two, Ahune The Frost Lord display ID, IceFrostPhase enabled, 50 to 25 percent--
function Leviathan_Morph2(Unit,Event)
 if	Unit:GetHealthPct() <= 50 then
   	Unit:RemoveEvents()
   	Unit:SetModel(23344)
   	Unit:SendChatMessage(12, 0, "Hah, you think that you may triumph over me, but you are only halfway through this igneous shell of steel!")
   	Unit:SetScale(0.3)
   	Unit:CastSpell(7301)
   	Unit:RegisterEvent("Leviathan_Talk", 15000, 0)
   	Unit:RegisterEvent("Leviathan_SpellFrostbolt", 11000, 0)
   	Unit:RegisterEvent("Leviathan_SpellBreath", 20000, 0)
   	Unit:RegisterEvent("Leviathan_SpellClaw", 8000, 0)
   	Unit:RegisterEvent("Leviathan_SpellCone", 15000, 0)
   	Unit:RegisterEvent("Leviathan_SpellPlague", 17000, 0)
   	Unit:RegisterEvent("Leviathan_Morph3", 1000, 0) 
end
end
--Morph three, Doom Lord Kazzak display ID, WarriorPhase enabled, 25 to 1 percent--
function Leviathan_Morph3(Unit,Event)
 if	Unit:GetHealthPct() <= 25 then
   	Unit:RemoveEvents()
   	Unit:SetModel(17887)
   	Unit:SendChatMessage(12, 0, "I might be growing weaker with every fist thrown against my tattered skin, but you have now unleased the might of my vengence!")
   	Unit:SetScale(0.15)
   	Unit:CastSpell(43716)
   	Unit:RegisterEvent("Leviathan_Talk", 15000, 0)
   	Unit:RegisterEvent("Leviathan_SpellCleave", 11000, 0)
   	Unit:RegisterEvent("Leviathan_SpellBlackCleave", 13000, 0)
   	Unit:RegisterEvent("Leviathan_SpellClap", 12000, 0)
   	Unit:RegisterEvent("Leviathan_SpellRend", 19000, 0)
   	Unit:RegisterEvent("Leviathan_SpellAgony", 17000, 0)
   	Unit:RegisterEvent("Leviathan_Morph4", 1000, 0)  
end
end
--Last 1 percent--
function Leviathan_Morph4(Unit,Event)
 if	Unit:GetHealthPct() <= 1 then
   	Unit:RemoveEvents()
   	Unit:SendChatMessage(12, 0, "The pain, the agony.. Please spare of me! I beg you!")
   	Unit:SetScale(0.3)
   	Unit:CastSpell(1020)
   	Unit:SendChatMessage(12, 0, "Oh! Spare me such pain?") 
end
end

function Leviathan_Death(Unit)
   	Unit:SendChatMessage(12, 0, "Master, please forgive me...")
   	Unit:RemoveEvents()
end

function Leviathan_Talk(Unit, Event)
Choice=math.random(1, 3)
if Choice==1 then
Unit:SendChatMessage(14, 0, "You are quite strong my friend! Feel the power of the elements!")
Unit:CastSpell(31895)
end 
if Choice==2 then
Unit:SendChatMessage(14, 0, "If you run, I might just spare your lives!")
Unit:CastSpell(31895)
end
if Choice==3 then
Unit:SendChatMessage(14, 0, "The elements that my Master, Supremus, has given me.. They will blow you away!")
Unit:CastSpell(31895)
end 
end

function Leviathan_OnLeaveCombat(Unit, event)
Unit:RemoveEvents()
end

function Leviathan_OnKilledTarget(Unit)
Unit:SendChatMessage(12, 0, "Feel my Wrath!")
Unit:PlaySoundToSet(9250)
end


function Leviathan_Death(Unit)
Unit:SendChatMessage(12, 0, "Supremus, my master... Please forgive me!")
Unit:RemoveEvents()
end

RegisterUnitEvent(22884, 1, "Leviathan_OnEnterCombat")
RegisterUnitEvent(22884, 2, "Leviathan_OnLeaveCombat")
RegisterUnitEvent(22884, 3, "Leviathan_OnKilledTarget")
RegisterUnitEvent(22884, 4, "Leviathan_Death")