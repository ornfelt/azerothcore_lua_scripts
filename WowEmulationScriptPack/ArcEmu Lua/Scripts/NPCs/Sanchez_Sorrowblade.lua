--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Sanchez_Sorrowblade_OnCombat(Unit, Event) 
Unit:SendChatMessage(12, 0, "I will vanquish your soul!")
Unit:RegisterEvent("Sanchez_Sorrowblade_deathcount", 54000, 20)
Unit:RegisterEvent("Sanchez_Sorrowblade_phaseone",1000,0)
Unit:RegisterEvent("Sanchez_Sorrowblade_Shadowblast", 67000, 20)
Unit:RegisterEvent("Sanchez_Sorrowblade_Sleep", 72000, 10)
Unit:RegisterEvent("Sanchez_Sorrowblade_Drawsoul", 84000, 20)
Unit:RegisterEvent("Sanchez_Sorrowblade_FlameBurst", 41000, 20)
Unit:RegisterEvent("Sanchez_Sorrowblade_Fireball", 51000, 30)
Unit:RegisterEvent("Sanchez_Sorrowblade_Darkbarrage", 59000, 20)
Unit:RegisterEvent("Sanchez_Sorrowblade_NecroticAura", 810000, 2)
Unit:RegisterEvent("Sanchez_Sorrowblade_ShadowNova", 51000, 5)
Unit:RegisterEvent("Sanchez_Sorrowblade_Bonearm", 900000, 5)
Unit:RegisterEvent("Sanchez_Sorrowblade_CurseofExertion", 74000, 10)
Unit:RegisterEvent("Sanchez_Sorrowblade_Mindblast", 43000, 20)
Unit:RegisterEvent("Sanchez_Sorrowblade_EmpoweredArcaneExplosion", 73000, 10)
Unit:RegisterEvent("Sanchez_Sorrowblade_ArcaneStorm", 87000, 10)
Unit:RegisterEvent("Sanchez_Sorrowblade_SurgeofPower", 97000, 10)
Unit:RegisterEvent("Sanchez_Sorrowblade_AgonizingFlames", 60000, 10)
Unit:RegisterEvent("Sanchez_Sorrowblade_ArcingSmash", 10000, 50)
end

function Sanchez_Sorrowblade_deathcount(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38818, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Shadowblast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(41078, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Drawsoul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40904, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Sleep(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52721, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_FlameBurst(pUnit, Event) 
pUnit:CastSpell(41131, pUnit:GetClosestPlayer()) 
end

function Sanchez_Sorrowblade_Fireball(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40598, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_NecroticAura(pUnit, Event) 
pUnit:FullCastSpellOnTarget(55593, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_ShadowNova(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38627, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Bonearm(pUnit, Event) 
pUnit:CastSpell(55315, pUnit:GetClosestPlayer()) 
end

function Sanchez_Sorrowblade_deathcount(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38818, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Shadowblast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(41078, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Drawsoul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40904, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Sleep(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52721, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_ShadowNova(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38627, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Bonearm(pUnit, Event) 
pUnit:CastSpell(55315, pUnit:GetClosestPlayer()) 
end

function Sanchez_Sorrowblade_Darkbarrage(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40585, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_NecroticAura(pUnit, Event) 
pUnit:FullCastSpellOnTarget(55593, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_CurseofExertion(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52772, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Mindblast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(58850, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_EmpoweredArcaneExplosion(pUnit, Event) 
pUnit:CastSpell(59377, pUnit:GetClosestPlayer()) 
end

function Sanchez_Sorrowblade_ArcaneStorm(pUnit, Event) 
pUnit:FullCastSpellOnTarget(61694, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_SurgeofPower(pUnit, Event) 
pUnit:FullCastSpellOnTarget(60936, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_CurseofExertion(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52772, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_Mindblast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(58850, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_EmpoweredArcaneExplosion(pUnit, Event) 
pUnit:CastSpell(59377, pUnit:GetClosestPlayer()) 
end

function Sanchez_Sorrowblade_ArcaneStorm(pUnit, Event) 
pUnit:FullCastSpellOnTarget(61694, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_SurgeofPower(pUnit, Event) 
pUnit:FullCastSpellOnTarget(60936, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_AgonizingFlames(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40932, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_ArcingSmash(pUnit, Event) 
pUnit:CastSpell(40599, pUnit:GetClosestPlayer()) 
end

function Sanchez_Sorrowblade_AgonizingFlames(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40932, pUnit:GetRandomPlayer(0)) 
end

function Sanchez_Sorrowblade_ArcingSmash(pUnit, Event) 
pUnit:CastSpell(40599, pUnit:GetClosestPlayer()) 
end

function Sanchez_Sorrowblade_phaseone(pUnit, Event) 
if pUnit:GetHealthPct() < 100 then 
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(41078, 52721, 40904, 38818)
pUnit:RegisterEvent("Sanchez_Sorrowblade_ArcingSmash", 10000, 50)
pUnit:RegisterEvent("Sanchez_Sorrowblade_deathcount", 54000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Shadowblast", 67000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Drawsoul", 84000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Sleep", 72000, 10)
pUnit:RegisterEvent("Sanchez_Sorrowblade_phasetwo",1000,0)
end 
end

function Sanchez_Sorrowblade_phasetwo(pUnit, Event) 
if pUnit:GetHealthPct() < 75 then
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(41078, 40585, 40598)
pUnit:RegisterEvent("Sanchez_Sorrowblade_ArcingSmash", 10000, 50)
pUnit:RegisterEvent("Sanchez_Sorrowblade_FlameBurst", 41000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Fireball", 51000, 30)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Darkbarrage", 59000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Shadowblast", 67000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_phasethree",1000,0)
end 
end

function Sanchez_Sorrowblade_phasethree(pUnit, Event) 
if pUnit:GetHealthPct() < 60 then 
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(40585, 41078, 38627, 38818)
pUnit:RegisterEvent("Sanchez_Sorrowblade_ArcingSmash", 10000, 50)
pUnit:RegisterEvent("Sanchez_Sorrowblade_NecroticAura", 81000, 2)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Shadowblast", 67000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_ShadowNova", 51000, 5)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Bonearm", 90000, 5)
pUnit:RegisterEvent("Sanchez_Sorrowblade_deathcount", 54000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_phasefour",1000,0)
end 
end

function Sanchez_Sorrowblade_phasefour(pUnit, Event) 
if pUnit:GetHealthPct() < 40 then 
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(58850, 59377)
pUnit:RegisterEvent("Sanchez_Sorrowblade_ArcingSmash", 10000, 50)
pUnit:RegisterEvent("Sanchez_Sorrowblade_CurseofExertion", 74000, 10)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Mindblast", 43000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_EmpoweredArcaneExplosion", 73000, 10)
pUnit:RegisterEvent("Sanchez_Sorrowblade_phasefive",1000,0)
end 
end

function Sanchez_Sorrowblade_phasefive(pUnit, Event) 
if pUnit:GetHealthPct() < 20 then 
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(60936, 61694, 58850)
pUnit:RegisterEvent("Sanchez_Sorrowblade_AgonizingFlames", 60000, 10)
pUnit:RegisterEvent("Sanchez_Sorrowblade_ArcingSmash", 10000, 50)
pUnit:RegisterEvent("Sanchez_Sorrowblade_Mindblast", 43000, 20)
pUnit:RegisterEvent("Sanchez_Sorrowblade_ArcaneStorm", 70000, 10)
pUnit:RegisterEvent("Sanchez_Sorrowblade_SurgeofPower", 97000, 10)
end 
end

function Sanchez_Sorrowblade_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sanchez_Sorrowblade_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "This can't be.... you humans are not stronger then me!") 
end

function Sanchez_Sorrowblade_OnKilledTarget(Unit, Event) 
Unit:RemoveEvents()
 Choice=math.random(1,3)
if Choice == 1 then
pUnit:SendChatMessage(14, 0, "Don't be worried, your soul will be good use!")
end
if Choice == 2 then
pUnit:SendChatMessage(12, 0, "My Val'kyrs will take you to heaven.")
end
if Choice == 3 then
pUnit:SendChatMessage(12, 0, "Another soul for Me!")
end
end



RegisterUnitEvent(910841, 1, "Sanchez_Sorrowblade_OnCombat")
RegisterUnitEvent(910841, 2, "Sanchez_Sorrowblade_OnLeaveCombat")
RegisterUnitEvent(910841, 3, "Sanchez_Sorrowblade_OnKilledTarget")
RegisterUnitEvent(910841, 4, "Sanchez_Sorrowblade_OnDied")