local ABH = {}
ABH.__index = ABH

local SB = require(script.Parent.SpellButton)
local player = game.Players.LocalPlayer

function ABH.new(link, UI)
	local button_set = {}
	setmetatable(button_set, ABH)
	
	button_set.link = link
	button_set.UI = UI
	button_set.m_set = {}
	button_set.m_spellList = button_set.UI:GetSpellList();
	
	for _,v in next,button_set.link:GetDescendants() do
		if v:IsA("Frame") and v.Name ~= "Set" and v.Name ~= "Set2" then
			local spellId, keyBinding, cdVal;
			if tonumber(v.Name) == nil then continue end
			if tonumber(v.Name) >= 1 and tonumber(v.Name) <= 50 then
				for i,g in next, button_set.m_spellList do
					if g.m_spellId == v.SpellId.Value then
						spellId = tonumber(i);
						keyBinding = g.m_keyBinding
					end
				end
				if spellId then
					cdVal = game.Lighting.Spells[tostring(spellId)].CooldownValue.Value
				end
				local new_button = SB.new(v, spellId, cdVal)
				table.insert(button_set.m_set, new_button)
			end
		end
	end
	
	return button_set
	
end

function ABH:LockSchool(school)
	for _,v in next,self.m_set do
		if v.spellLink.SpellSchoolMask.Value == school then
			v:Lock();
		end
	end
end

function ABH:UpdateSpellList(num, spellId)
	self.m_spellList[num].m_spellId = spellId
end

function ABH:Update(deltaTime)
	for _,v in next,self.m_set do
		v:Update(deltaTime)
	end
end

function ABH:SetOnGCD(m_time)
	for _,v in next,self.m_set do
		local spellId = v.spellId
		local spell = game.Lighting.Spells:findFirstChild(tostring(spellId));
		if spell then
			if not spell.SpellFlags:findFirstChild("SPELL_FLAG_CUSTOM_GCD") then
				v:SetOnGCD(m_time)
			end
		end
	end
end

function ABH:SetOnCooldown(data)
	local spell = data.Spell -- Spell Id
	local cd = game.Lighting.Spells:findFirstChild(tostring(spell)).CooldownValue.Value;
	-- For now we set spell on cooldown using DBC value (TODO: Change this to receive cooldown value from data)
	for _,v in next, self.m_set do
		if v.spellId == spell then
			v.coolTime = cd;
		end
	end
	
end

return ABH
