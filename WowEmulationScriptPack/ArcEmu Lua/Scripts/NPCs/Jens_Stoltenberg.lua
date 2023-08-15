function Jens_Spell1(Unit)
Unit:CastSpell(39658)
end

function Jens_Spell2(Unit)
Unit:CastSpell(29951)
end

function Jens_Spell3(Unit)
Unit:CastSpell(29388)
end

function Jens_Spell4(Unit)
Unit:CastSpell(12151)
end

function Jens_Phase1(Unit, event)
if Unit:GetHealthPct() < 90 then
Unit:RemoveEvents()
Unit:SendChatMessage(12, 0, "You've wasted enough of my political time..LET THESE GAMES BE FINISHED!")
Unit:PlaySoundToSet(9247)
Unit:RegisterEvent("Jens_Spell1",1000, 1)
Unit:RegisterEvent("Jens_Phase2",1000, 0)
end
end

function Jens_Phase2(Unit, event)
if Unit:GetHealthPct() < 60 then
Unit:RemoveEvents()
Unit:SendChatMessage(12, 0, "Where'd you get that?! Did Bondevik send you?!")
Unit:PlaySoundToSet(9249)
Unit:RegisterEvent("Jens_Spell2",1000, 1)
Unit:RegisterEvent("Jens_Phase3",1000, 0)
end
end

function Jens_Phase3(Unit, event)
if Unit:GetHealthPct() < 40 then
Unit:RemoveEvents()
Unit:SendChatMessage(12, 0, "I'll show you! This beaten dog still has front teeth!!")
Unit:PlaySoundToSet(9245)
Unit:RegisterEvent("Jens_Spell4",1000, 5)
Unit:RegisterEvent("Jens_Phase4",1000, 0)
end
end

function Jens_Phase4(Unit, event)
if Unit:GetHealthPct() < 10 then
Unit:RemoveEvents()
Unit:SendChatMessage(12, 0, "I want this nightmare to be over!!")
Unit:PlaySoundToSet(9250)
Unit:RegisterEvent("Jens_Spell3",1000, 1)
Unit:RegisterEvent("Jens_Phase5",1000, 0)
end
end

function Jens_OnCombat(Unit, event)
Unit:PlaySoundToSet(9242)
Unit:SendChatMessage(12, 0, "Yes yes! Bondevik is quite powerful!..But I have powers of my own!!")
Unit:RegisterEvent("Jens_Phase1",1000, 0)
Unit:RegisterEvent("Jens_Phase2",1000, 0)
Unit:RegisterEvent("Jens_Phase3",1000, 0)
Unit:RegisterEvent("Jens_Phase4",1000, 0)
end

function Jens_OnLeaveCombat(Unit, event)
Unit:RemoveEvents()
end

function Jens_OnKilledTarget(Unit)
Unit:SendChatMessage(12, 0, "I want this nightmare to be over!!")
Unit:PlaySoundToSet(9250)
Unit:RegisterEvent("Jens_Spell3",1000, 1)
end

function Jens_Death(Unit)
Unit:SendChatMessage(12, 0, "At last..the night mare is over..")
Unit:PlaySoundToSet(9244)
Unit:RemoveEvents()
end

RegisterUnitEvent(877623, 1, "Jens_OnCombat")
RegisterUnitEvent(877623, 2, "Jens_OnLeaveCombat")
RegisterUnitEvent(877623, 3, "Jens_OnKilledTarget")
RegisterUnitEvent(877623, 4, "Jens_Death")