function Gur_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Darkness! Its a wonderful thing")
pUnit:RegisterEvent("Gur_agony", 3000, 1)
pUnit:RegisterEvent("Gur_phase2", 1000, 0)
end

function Gur_agony(pUnit, Event)
pUnit:FullCastSpellOnTarget(45034, pUnit:GetRandomPlayer(0))
end

function Gur_phase2(pUnit, Event)
if pUnit:GetHealthPct() <= 80 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "Meet My Blades!")
pUnit:RegisterEvent("Gur_Summon", 1000, 1)
end
end

function Gur_Summon(pUnit, Event)
local x = pUnit:GetX();
local y = pUnit:GetY();
local z = pUnit:GetZ();
local o = pUnit:GetO();
pUnit:SpawnCreature (942020, x, y, z, o, 14 ,0);
pUnit:SpawnCreature (942020, x, y, z, o, 14 ,0);
pUnit:SpawnCreature (942020, x, y, z, o, 14 ,0);
pUnit:SpawnCreature (942020, x, y, z, o, 14 ,0);
end



function Gur_OnLeaveCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "How is this possible?")
pUnit:RemoveEvents()
end

function Gur_OnKilledTarget(pUnit, Event)
pUnit:SendChatMessage(14, 0, "You are so weak! Your death only feeds me!")
end

function Gur_OnDeath(pUnit, Event)
pUnit:SendChatMessage(14, 0, "You will be cursed!")
pUnit:RemoveEvents()
end

RegisterUnitEvent(941004, 1, "Gur_OnCombat")
RegisterUnitEvent(941004, 2, "Gur_OnLeaveCombat")
RegisterUnitEvent(941004, 3, "Gur_OnKilledTarget")
RegisterUnitEvent(941004, 4, "Gur_OnDeath")
