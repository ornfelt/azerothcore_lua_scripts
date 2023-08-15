function Leviathan_OnEnterCombat(pUnit,Event)
    pUnit:SendChatMessage(12, 0, "I may look like a usual beast that you hunt, but having two heads can have it's uses!")
    pUnit:RegisterEvent("Leviathan_Morph1", 1000, 0)
    pUnit:CastSpell(15473)
    pUnit:RegisterEvent("Leviathan_Talk", 15000, 0)
    pUnit:RegisterEvent("Leviathan_Empowering", 20000, 0)
    pUnit:RegisterEvent("Leviathan_SpellCrushing", 14000, 0)
    pUnit:RegisterEvent("Leviathan_SpellBolt", 15000, 0)
    pUnit:RegisterEvent("Leviathan_SpellPain", 17000, 0)
end
--Phase/Morph Specific Spells--
--ShadowPhase, 100 to 75 percent--
function Leviathan_Empowering(pUnit,Event)
    pUnit:CastSpell(33783)
end

function Leviathan_SpellCrushing(pUnit,Event)
    pUnit:CastSpellOnTarget(40243,pUnit:GetRandomPlayer(0))
end

function Leviathan_SpellBolt(pUnit,Event)
    pUnit:CastSpellOnTarget(27209,pUnit:GetRandomPlayer(0))
end

function Leviathan_SpellPain(pUnit,Event)
        pUnit:CastSpellOnTarget(25368,pUnit:GetRandomPlayer(0))
        pUnit:CastSpellOnTarget(25368,pUnit:GetMainTank())
end
--FirePhase, 75 to 50 percent--
function Leviathan_SpellFirecone(pUnit,Event)
        pUnit:CastSpellOnTarget(19630,pUnit:GetClosestPlayer())
end

function Leviathan_SpellFireball(pUnit,Event)
        pUnit:CastSpellOnTarget(25306,pUnit:GetMainTank())
end

function Leviathan_SpellFireRain(pUnit,Event)
        pUnit:CastSpell(27212)
end

function Leviathan_SpellSteal(pUnit,Event)
        pUnit:CastSpellOnTarget(30449,pUnit:GetRandomPlayer(0))
end
--IceFrostPhase, 50 to 25 percent--
function Leviathan_SpellFrostbolt(pUnit,Event)
        pUnit:CastSpellOnTarget(38697,pUnit:GetRandomPlayer(0))
end

function Leviathan_SpellBreath(pUnit,Event)
        pUnit:CastSpellOnTarget(44799,pUnit:GetClosestPlayer())
end

function Leviathan_SpellClaw(pUnit,Event)
        pUnit:CastSpellOnTarget(3130,pUnit:GetMainTank())
end

function Leviathan_SpellCone(pUnit,Event)
        pUnit:CastSpellOnTarget(10159,pUnit:GetClosestPlayer())
end

function Leviathan_SpellPlague(pUnit,Event)
        pUnit:CastSpellOnTarget(40351,pUnit:GetRandomPlayer(0))
end
--WarriorPhase, 25 to 1 percent--
function Leviathan_SpellCleave(pUnit,Event)
        pUnit:CastSpellOnTarget(25231,pUnit:GetMainTank())
end

function Leviathan_SpellBlackCleave(pUnit,Event)
        pUnit:CastSpellOnTarget(33480,pUnit:GetClosestPlayer())
end

function Leviathan_SpellClap(pUnit,Event)
        pUnit:CastSpellOnTarget(6343,pUnit:GetMainTank())
end

function Leviathan_SpellRend(pUnit,Event)
        pUnit:CastSpellOnTarget(25208,pUnit:GetRandomPlayer(0))
end

function Leviathan_SpellAgony(pUnit,Event)
        pUnit:CastSpellOnTarget(36836,pUnit:GetRandomPlayer(0))
end

function Leviathan_SpellAgony(pUnit,Event)
        pUnit:CastSpellOnTarget(36836,pUnit:GetRandomPlayer(0))
end
--Morphs and Phases--
--Morph one, Al'Ah display ID, FirePhase enabled, 75 to 50 percent--
function Leviathan_Morph1(pUnit,Event)
 if pUnit:GetHealthPct() <= 75 then
    print "Group through stage 1"
    pUnit:RemoveEvents()
    pUnit:SetModel(18945)
    pUnit:SendChatMessage(12, 0, "You think you are a match for me? Pfft, what about if I do.... THIS?")
    pUnit:SetScale(0.3)
    pUnit:CastSpell(25431)
    pUnit:RegisterEvent("Leviathan_Talk", 15000, 0)
    pUnit:RegisterEvent("Leviathan_SpellFirecone", 18000, 0)
    pUnit:RegisterEvent("Leviathan_SpellFireball", 15000, 0)
    pUnit:RegisterEvent("Leviathan_SpellFireRain", 8000, 0)
    pUnit:RegisterEvent("Leviathan_SpellSteal", 20000, 0)
    pUnit:RegisterEvent("Leviathan_Morph2", 1000, 0)  
end
end
--Morph two, Ahune The Frost Lord display ID, IceFrostPhase enabled, 50 to 25 percent--
function Leviathan_Morph2(pUnit,Event)
 if pUnit:GetHealthPct() <= 50 then
    print "Group through stage 2"
    pUnit:RemoveEvents()
    pUnit:SetModel(23344)
    pUnit:SendChatMessage(12, 0, "Hah, you think that you may triumph over me, but you are only halfway through this igneous shell of steel!")
    pUnit:SetScale(0.3)
    pUnit:CastSpell(7301)
    pUnit:RegisterEvent("Leviathan_Talk", 15000, 0)
    pUnit:RegisterEvent("Leviathan_SpellFrostbolt", 11000, 0)
    pUnit:RegisterEvent("Leviathan_SpellBreath", 20000, 0)
    pUnit:RegisterEvent("Leviathan_SpellClaw", 8000, 0)
    pUnit:RegisterEvent("Leviathan_SpellCone", 15000, 0)
    pUnit:RegisterEvent("Leviathan_SpellPlague", 17000, 0)
    pUnit:RegisterEvent("Leviathan_Morph3", 1000, 0) 
end
end
--Morph three, Doom Lord Kazzak display ID, WarriorPhase enabled, 25 to 1 percent--
function Leviathan_Morph3(pUnit,Event)
 if pUnit:GetHealthPct() <= 25 then
    print "Group through stage 3, final stage."
    pUnit:RemoveEvents()
    pUnit:SetModel(17887)
    pUnit:SendChatMessage(12, 0, "I might be growing weaker with every fist thrown against my tattered skin, but you have now unleased the might of my vengence!")
    pUnit:SetScale(0.15)
    pUnit:CastSpell(43716)
    pUnit:RegisterEvent("Leviathan_Talk", 15000, 0)
    pUnit:RegisterEvent("Leviathan_SpellCleave", 11000, 0)
    pUnit:RegisterEvent("Leviathan_SpellBlackCleave", 13000, 0)
    pUnit:RegisterEvent("Leviathan_SpellClap", 12000, 0)
    pUnit:RegisterEvent("Leviathan_SpellRend", 19000, 0)
    pUnit:RegisterEvent("Leviathan_SpellAgony", 17000, 0)
    pUnit:RegisterEvent("Leviathan_Morph4", 1000, 0)  
end
end
--Last 1 percent--
function Leviathan_Morph4(pUnit,Event)
 if pUnit:GetHealthPct() <= 1 then
    print "Group through stage 4, Boss at 1%."
    pUnit:RemoveEvents()
    pUnit:SendChatMessage(12, 0, "The pain, the agony.. Please spare of me! I beg you!")
    pUnit:SetScale(0.3)
    pUnit:CastSpell(1020)
    pUnit:SendChatMessage(12, 0, "Oh! Spare me such pain?") 
end
end

function Leviathan_Death(pUnit)
    print "Group killed Leviathan"
    pUnit:SendChatMessage(12, 0, "Master, please forgive me...")
    pUnit:RemoveEvents()
end

function Leviathan_Talk(pUnit, Event)
Choice=math.random(1, 3)
if Choice==1 then
pUnit:SendChatMessage(14, 0, "You are quite strong my friend! Feel the power of the elements!")
pUnit:CastSpell(31895)
end 
if Choice==2 then
pUnit:SendChatMessage(14, 0, "If you run, I might just spare your lives!")
pUnit:CastSpell(31895)
end
if Choice==3 then
pUnit:SendChatMessage(14, 0, "The elements that my Master, Supremus, has given me.. They will blow you away!")
pUnit:CastSpell(31895)
end 
end

function Leviathan_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()

end

function Leviathan_OnKilledTarget(pUnit)
pUnit:SendChatMessage(12, 0, "Feel my Wrath!")
pUnit:PlaySoundToSet(9250)
end


function Leviathan_Death(pUnit)
pUnit:SendChatMessage(12, 0, "Supremus, my master... Please forgive me!")
pUnit:RemoveEvents()

end

RegisterUnitEvent(22884, 1, "Leviathan_OnEnterCombat")
RegisterUnitEvent(22884, 2, "Leviathan_OnLeaveCombat")
RegisterUnitEvent(22884, 3, "Leviathan_OnKilledTarget")
RegisterUnitEvent(22884, 4, "Leviathan_Death")
