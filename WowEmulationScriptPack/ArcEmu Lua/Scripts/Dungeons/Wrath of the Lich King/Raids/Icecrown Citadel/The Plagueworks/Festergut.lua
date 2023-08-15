--[[
16566	Festergut_BlightSpore_Impact
16567	Festergut_BlightSpore_Impact (Putricide)
16570	Festergut_Inhale_gas_Loop
16571	Festergut_PlagueCloudLoop
16572	Festergut_BlightSpore_Impact (Low Volume)
16901	IC_Festergut_Aggro01
16902	IC_Festergut_Slay01
16903	IC_Festergut_Slay02
16904	IC_Festergut_Death01
16905	IC_Festergut_Beserk01
16906	IC_Festergut_ExpungeBlight01
16907	IC_Festergut_RotfaceDies01
16908	IC_Festergut_Attack
16909	IC_Festergut_Wound
16910	IC_Festergut_WoundCrit
16911	IC_Festergut_GasSpore01
]]--
-- If Stinky is dead- Yells :No! You killed Stinky! You Pay!

function gut_OnCombat(pUnit, Event)
local chance = math.random(1,2)
	if(chance == 1) then
		pUnit:SendChatMessage(12, 0, "Dead, dead, dead!")
	elseif(chance == 2) then
		pUnit:SendChatMessage(12, 0, "Fun Time?")
	end
	pUnit:RegisterEvent("Rage", 10000, 0)
end

function Rage(pUnit, Event)
	pUnit:CastSpell(47008)
	pUnit:SendChatMessage(12, 0, "Fun time over!")
end

function gut_OnTargetDied(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Daddy, I did it!")
end

function gut_OnLeave(pUnit, Event)
	pUnit:RemoveEvent()
end

function gut_OnDied(pUnit, Event)
local chance = math.random(1,3)
	if(chance == 1) then
		pUnit:SendChatMessage(12, 0, "Da...Ddy...")
	elseif(chance == 2) then
		pUnit:SendChatMessage(12, 0, "I not feel so good.")
	elseif(chance == 3)then
		pUnit:SendChatMessage(12, 0, "Fun Time?")
	end
end

RegisterUnitEvent(36626, 1, "gut_OnCombat")
RegisterUnitEvent(36626, 2, "gut_OnLeave")
RegisterUnitEvent(36626, 4, "gut_OnDied")
RegisterUnitEvent(36626, 3, "gut_OnTargetDied")