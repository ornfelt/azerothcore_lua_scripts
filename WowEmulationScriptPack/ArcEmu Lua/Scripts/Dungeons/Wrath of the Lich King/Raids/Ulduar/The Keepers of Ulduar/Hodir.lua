function Hodir_OnEnterCombat(pUnit, Event)
pUnit:SendChatMessage(12, 0, "You dont know what your getting yourself into!")
pUnit:RegisterEvent("Hodir_p1",1000, 0)
end

function Hodir_p1(pUnit, Event)
if pUnit:GetHealthPct() < 95 then
pUnit:RemoveEvents()
pUnit:SendChatMessage (12, 0, "Dont even try, you mortals are making a big mistake.")
pUnit:FullCastSpell(16803, pUnit:GetRandomPlayer(0))
pUnit:FullCastSpell(16803, pUnit:GetRandomPlayer(0))
pUnit:RegisterEvent("Hodir_p2",1000, 0)
end
end

function Hodir_p2(pUnit, Event)
if pUnit:GetHealthPct() < 85 then
pUnit:RemoveEvents()
pUnit:SendChatMessage (12, 0, "Hah! Your hits and spells dont even hurt, I am the great titan at all!")
pUnit:FullCastSpell(16803)
pUnit:RegisterEvent("Hodir_p3",1000, 0)
end
end

function Hodir_p3(pUnit, Event)
if pUnit:GetHealthPct() < 75 then
pUnit:RemoveEvents()
pUnit:SendChatMessage (12, 0, "Why? Why are you even trying? I am sick of this!")
Choice=math.random(1, 3)
if Choice==1 then
pUnit:CastSpellOnTarget(16803,pUnit:GetRandomPlaye (0))
end
if Choice==2 then
pUnit:CastSpellOnTarget(3129,pUnit:GetRandomPlayer (0))
end
if Choice==3 then
pUnit:CastSpellOnTarget(16803,pUnit:GetRandomPlaye (0))
end
pUnit:RegisterEvent("Hodir_p4",1000, 0)
end
end

function Hodir_p4(pUnit, Event)
if pUnit:GetHealthPct() < 45 then
pUnit:RemoveEvents()
pUnit:SendChatMessage (12, 0, "Fall to the ground!")
pUnit:CastSpellOnTarget(16803, pUnit:GetRandomPlayer(0))
pUnit:CastSpellOnTarget(3131, pUnit:GetRandomPlayer(0))
pUnit:RegisterEvent("Hodir_p5",1000, 0)
end
end

function Hodir_p5(pUnit, Event)
if pUnit:GetHealthPct() < 25 then
pUnit:RemoveEvents()
pUnit:SendChatMessage (12, 0, "WHY? HOW? HOW IS THIS POSSIBLE! YOU CANNOT DEFEAT ME!")
pUnit:CastSpellOnTarget(16803, pUnit:GetRandomPlayer(0))
pUnit:RegisterEvent("Hodir_p6",1000, 0)
end
end

function Hodir_p6(pUnit, Event)
if pUnit:GetHealthPct() <= 1 then
pUnit:RemoveEvents()
pUnit:SendChatMessage (12, 0, "You shall see the power of ice!")
pUnit:CastSpellOnTarget(16803, pUnit:GetRandomPlayer(0))
pUnit:RegisterEvent("Hodir_Died",1000, 0)
end
end

function Hodir_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

function Hodir_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(199879, 1, "Hodir_OnEnterCombat")
RegisterUnitEvent(199879, 2, "Hodir_OnLeaveCombat")
RegisterUnitEvent(199879, 4, "Hodir_OnDeath")