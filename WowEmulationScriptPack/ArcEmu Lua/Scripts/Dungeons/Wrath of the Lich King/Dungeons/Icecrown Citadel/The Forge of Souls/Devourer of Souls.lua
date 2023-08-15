--[[
16884	FS_DevourerMale01_Aggro01
16885	FS_DevourerMale01_Slay01
16886	FS_DevourerMale01_Slay02
16887	FS_DevourerMale01_Death01
16888	FS_DevourerMale01_SoulAttack01
16889	FS_DevourerMale01_DarkGlare01
16890	FS_DevourerFemale01_Aggro01
16891	FS_DevourerFemale01_Slay01
16892	FS_DevourerFemale01_Slay02
16893	FS_DevourerFemale01_Death01
16894	FS_DevourerFemale01_SoulAttack01
16895	FS_DevourerFemale01_DarkGlare01
16896	FS_DevourerMale02_Slay01
16897	FS_DevourerMale02_Slay02
16898	FS_DevourerMale02_Death01
16899	FS_DevourerMale02_SoulAttack01
16900	FS_DevourerExert_Attack
]]--

function Devourer_OnCombat (pUnit, Event)
	pUnit:SendChatMessage(12, 0, "You dare look upon the host of souls? I SHALL DEVOUR YOU WHOLE!")
	pUnit:RegisterEvent("Devourer_Phantomblast", 3000, 0)
	pUnit:RegisterEvent("Devourer_Mirrored", 20500, 0)
	pUnit:RegisterEvent("Devourer_Wellsouls", 10500, 0)
	pUnit:RegisterEvent("Devourer_Phase1", 45000, 1)
end

function Devourer_Phantomblast (pUnit, Event)
	pUnit:FullCastSpellOnTarget(68982, pUnit:GetMainTank())
end

function Devourer_Mirrored (pUnit, Event)
	pUnit:FullCastSpellOnTarget (69051, pUnit:GetRandomPlayer(0))
	pUnit:SendChatMessage(42, 0, "Devourer of Souls begins to cast Mirrored Soul.")
end

function Devourer_Wellsouls (pUnit, Event)
	pUnit:FullCastSpellOnTarget (68863, pUnit:GetMainTank())
end

function Devourer_Phase1(pUnit, Event)
	pUnit:SendChatMessage(42, 0, "Devourer of Souls begins to Unleash Souls!")
	pUnit:RegisterEvent("Devourer_Souls", 1000, 1)
end

function Devourer_Souls(pUnit, Event)
	pUnit:FullCastSpellOnTarget(68939, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Devourer_Wailingsoul", 45000, 1)
end

function Devourer_Wailingsoul(pUnit, Event)
	pUnit:FullCastSpellOnTarget (68863, pUnit:GetMainTank())
	pUnit:SendChatMessage(42, 0, "Devourer of Souls begins to Wailing Souls!")
	pUnit:SendChatMessage(12, 0, "Stare into the abyss and see your end!")
	pUnit:RegisterEvent("Devourer_Phase1", 45000, 1)
end

function Devourer_Shadowbolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(70043, pUnit:GetMainTank())
end

function Devourer_OnDeath (pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage (12, 0, "SUFFERING! ANGUISH! CHAOS! RISE AND FEED!")
end

function Devourer_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(36502, 1, "Devourer_OnCombat")
RegisterUnitEvent(36502, 2, "Devourer_OnLeaveCombat")
RegisterUnitEvent(36502, 4, "Devourer_OnDeath")
