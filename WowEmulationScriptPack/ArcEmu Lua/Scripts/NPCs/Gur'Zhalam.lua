--Scripted by Olabvii
--For http://www.cna-wow.com/

function Gur_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Darkness! Its a wonderful thing")
pUnit:RegisterEvent("Gur_agony", 3000, 1)
pUnit:RegisterEvent("Gur_flame", 6000, 0)
pUnit:RegisterEvent("Gur_phase2", 1000, 0)
end

function Gur_agony(pUnit, Event)
pUnit:FullCastSpellOnTarget(45034, pUnit:GetRandomPlayer(0))
end

function Gur_flame(pUnit, Event)
pUnit:CastSpellOnTarget(57570, pUnit:GetMainTank())
end


function Gur_phase2(pUnit, Event)
if pUnit:GetHealthPct() <= 80 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "Meet My Blades!")
pUnit:RegisterEvent("Gur_Summon", 1000, 1)
pUnit:RegisterEvent("Gur_shadowstrike", 10000, 1)
pUnit:RegisterEvent("Gur_flame", 6000, 0)
pUnit:RegisterEvent("Gur_phase3", 1000, 0)
end
end

function Gur_Summon(pUnit, Event)
local x = pUnit:GetX();
local y = pUnit:GetY();
local z = pUnit:GetZ();
local o = pUnit:GetO();
pUnit:SpawnCreature (942020, x, y, z, o, 14 ,0);
end

function Gur_shadowstrike(pUnit, Event)
pUnit:CastSpellOnTarget(40685, pUnit:GetMainTank())
end

function Gur_flame(pUnit, Event)
pUnit:CastSpellOnTarget(57570, pUnit:GetMaintank())
end


function Gur_phase3(pUnit, Event)
if pUnit:GetHealthPct() <=60 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "I Will Cut You In Two!")
pUnit:RegisterEvent("Gur_flame", 8000, 0)
pUnit:RegisterEvent("Gur_cleave", 4000, 0)
pUnit:RegisterEvent("Gur_phase4", 1000, 0)
end
end

function Gur_flame(pUnit, Event)
pUnit:CastSpellOnTarget(57570, pUnit:GetMainTank())
end

function Gur_cleave(pUnit, Event)
pUnit:CastSpellOnTarget(19983, pUnit:GetMainTank())
end


function Gur_phase4(pUnit, Event)
if pUnit:GetHealthPct() <=40 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "BURN! SCUM...")
pUnit:RegisterEvent("Gur_cleave", 3000, 0)
pUnit:RegisterEvent("Gur_hellfire", 10000, 1)
pUnit:RegisterEvent("Gur_lavaburst", 8000, 3)
pUnit:RegisterEvent("Gur_phase5", 1000, 0)
end
end

function Gur_cleave(pUnit, Event)
pUnit:CastSpellOnTarget(19983, pUnit:GetMainTank())
end

function Gur_hellfire(pUnit, Event)
pUnit:ChannelSpell(1949)
end

function Gur_lavaburst(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Feel My Heat!")
pUnit:FullCastSpellOnTarget(51505, pUnit:GetMainTank())
end


function Gur_phase5(pUnit, Event)
if pUnit:GetHealthPct() <=20 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "Your Stronger Then I Though!")
pUnit:RegisterEvent("Gur_flame", 2000, 2)
pUnit:RegisterEvent("Gur_cleave", 4000, 0)
pUnit:RegisterEvent("Gur_shield", 10000, 1)
end
end

function Gur_flame(pUnit, Event)
pUnit:CastSpellOnTarget(57570, pUnit:GetMainTank())
end

function Gur_cleave(pUnit, Event)
pUnit:CastSpellOntarget(19983, pUnit:GetMainTank())
end

function Gur_shield(pUnit, Event)
pUnit:CastSpell(36300)
end


function Gur_OnLeaveCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "How is this possible?")
pUnit:RemoveEvents()
end

function Gur_OnKilledTarget(pUnit, Event)
pUnit:SendChatMessage(14, 0, "You are so weak! Your death only feeds me!")
end

function Gur_OnDeath(pUnit, Event)
pUnit:SendChatMessage(14, 0, "You will be cursed...")
pUnit:RemoveEvents()
end

RegisterUnitEvent(941004, 1, "Gur_OnCombat")
RegisterUnitEvent(941004, 2, "Gur_OnLeaveCombat")
RegisterUnitEvent(941004, 3, "Gur_OnKilledTarget")
RegisterUnitEvent(941004, 4, "Gur_OnDeath")
