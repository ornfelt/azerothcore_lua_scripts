--[[
16912	PS_Garfrost_Aggro01
16913	PS_Garfrost_Slay01
16914	PS_Garfrost_Slay02
16915	PS_Garfrost_Death01
16916	PS_Garfrost_SP01
16917	PS_Garfrost_SP02
16918	PS_Garfrost_Attack
16919	PS_Garfrost_Wound
16920	PS_Garfrost_WoundCrit
]]--

function ForgemasterGarfrost_OnCombat (pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Tiny creatures under feet, you bring Garfrost something good to eat!")
	pUnit:PlaySoundToSet(16912)
	pUnit:RegisterEvent("ForgemasterGarfrost_Permafrost", 1000, 1)
	pUnit:RegisterEvent("ForgemasterGarfrost_Phase1", 1000, 1)
end

function ForgemasterGarfrost_Permafrost (pUnit, Event)
	pUnit:CastSpell(70326)
end

function ForgemasterGarfrost_Phase1 (pUnit, Event)
if pUnit:GetHealthPct() < 70 then
pUnit:SendChatMessage (12, 0, "Axe too weak. Garfrost make better weapon and CRUSH YOU.")
pUnit:PlaySoundToSet(16916)
pUnit:FullCastSpell(68774)
pUnit:RegisterEvent("ForgemasterGarfrost_Phase2", 1000, 1)
end
end

function ForgemasterGarfrost_Phase2 (pUnit, Event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:SendChatMessage(12, 0, "Garfrost tired of puny mortals. Now your bones will freeze!")
		pUnit:PlaySoundToSet(16917)
		pUnit:FullCastSpell(70334)
	end
end

function ForgemasterGarfrost_OnKillPlr (pUnit, Event)
local RandomTalk=math.random(1, 2);
	if OnKillPlr== 1 then
		pUnit:SendChatMessage(12, 0, "That one maybe not so good to eat now. Stupid Garfrost! BAD! BAD!")
		pUnit:PlaySoundToSet(16913)
	elseif OnKillPlr== 2 then
		pUnit:SendChatMessage(14, 0, "Will save for snack. For later.")
		pUnit:PlaySoundToSet(16914)
	end
end

function ForgemasterGarfrost_OnDeath (pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(12, 0, "Garfrost hope giant underpants clean. Save boss great shame. For later.")
	pUnit:PlaySoundToSet(16915)
end

function ForgemasterGarfrost_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(36494, 1, "ForgemasterGarfrost_OnCombat")
RegisterUnitEvent(36494, 2, "ForgemasterGarfrost_OnLeaveCombat")
RegisterUnitEvent(36494, 3, "ForgemasterGarfrost_OnKillPlr")
RegisterUnitEvent(36494, 4, "ForgemasterGarfrost_OnDeath")