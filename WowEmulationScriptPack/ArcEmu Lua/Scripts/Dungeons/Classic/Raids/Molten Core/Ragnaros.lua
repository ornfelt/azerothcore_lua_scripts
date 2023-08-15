function Agonizing_Flames(Unit, event)
	Unit:FullCastSpellOnTarget(40932, Unit:GetRandomPlayer(0))
	Unit:FullCastSpellOnTarget(40932, Unit:GetRandomPlayer(0))
	Unit:FullCastSpellOnTarget(40932, Unit:GetRandomPlayer(0))
end

function Agonizing_Armor(Unit, event)
local ArmorChoice = math.random(1, 2)
	if (ArmorChoice == 1) then
		Unit:SendChatMessage(12, 0, "I will make you melt...")
		Unit:FullCastSpellOnTarget(36836, Unit:GetMainTank())
	end
	if (ArmorChoice == 2) then
		Unit:SendChatMessage(12, 0, "Feel the Armor disappear!")
		Unit:FullCastSpellOnTarget(36836, Unit:GetMainTank())
	end
end

function Fire_Cone(Unit, event)
	Unit:FullCastSpellOnTarget(36876, Unit:GetClosestPlayer())
end

function Fire_Debuff(Unit, event)
	Unit:FullCastSpellOnTarget(38010, Unit:GetClosestPlayer())
	Unit:FullCastSpellOnTarget(38010, Unit:GetClosestPlayer())
	Unit:FullCastSpellOnTarget(38010, Unit:GetClosestPlayer())
end

function Meteor_Slash(Unit, event)
	Unit:FullCastSpellOnTarget(45150, Unit:GetMainTank())
end

function Combat_Talk(Unit, event)
local TalkChoice = math.random(1, 10)
	if (TalkChoice == 1) then
		Unit:SendChatMessage(12, 0, "I've waited for this chance to strike!")
	end
	if (TalkChoice == 2) then
		Unit:SendChatMessage(12, 0, "You can't defeat the god of flames and fire!")
	end
	if (TalkChoice == 3) then
		Unit:SendChatMessage(12, 0, "I will never let you win!")
	end
	if (TalkChoice == 4) then
		Unit:SendChatMessage(12, 0, "Feel the power of Ragnaros!")
	end
	if (TalkChoice == 5) then
		Unit:SendChatMessage(12, 0, "My fires will consume you..")
	end
	if (TalkChoice == 6) then
		Unit:SendChatMessage(12, 0, "By Fire be purged!")
	end
	if (TalkChoice == 7) then
		Unit:SendChatMessage(12, 0, "Let my Fury rain upon you!")
	end
	if (TalkChoice == 8) then
		Unit:SendChatMessage(12, 0, "Ha Ha Ha!")
	end
	if (TalkChoice == 9) then
		Unit:SendChatMessage(12, 0, "You are no match for me..")
	end
	if (TalkChoice == 10) then
		Unit:SendChatMessage(12, 0, "I will win this battle!")
	end
end

function Rag_OnCombat(Unit, event)
local CombatChoice = math.random(1, 3)
	Unit:RegisterEvent("Combat_Talk", 20000, 0)
	Unit:RegisterEvent("Agonizing_Flames", 20000, 0)
	Unit:RegisterEvent("Agonizing_Armor", 28000, 0)
	Unit:RegisterEvent("Fire_Cone", 28000, 0)
	Unit:RegisterEvent("Fire_Debuff", 25000, 0)
	Unit:RegisterEvent("Meteor_Slash", 60000, 0)
	if (CombatChoice == 1) then
		Unit:SendChatMessage(12, 0, "I've returned stronger than ever before! Ha Ha Ha!")
	end
	if (CombatChoice == 2) then
		Unit:SendChatMessage(12, 0, "You should have sealed me while you had the chance!")
	end
	if (CombatChoice == 3) then
		Unit:SendChatMessage(12, 0, "Who dares to conquer me?!")
	end
end

function Rag_OnLeaveCombat(Unit, event)
	Unit:RemoveEvents()
end

function Rag_OnKilledTarget(Unit, event)
local KillTargChoice = math.random(1, 3)
	if (KillTargChoice == 1) then
		Unit:SendChatMessage(12, 0, "Feel Eternal Agony!")
	elseif (KillTargChoice == 2) then
		Unit:SendChatMessage(12, 0, "Your body is now made to ashes..")
	elseif (KillTargChoice == 3) then
		Unit:SendChatMessage(12, 0, "Revenge is mine!")
	end
end

function Rag_OnDied(Unit, event)
	Unit:SendChatMessage(12, 0, "No...NOOO! You will pay for this another time mortals! I will RETUUUUUURN!")
	Unit:RemoveEvents()
end

RegisterUnitEvent(11502, 1, "Rag_OnCombat")
RegisterUnitEvent(11502, 2, "Rag_OnLeaveCombat")
RegisterUnitEvent(11502, 3, "Rag_OnKilledTarget")
RegisterUnitEvent(11502, 4, "Rag_OnDied")