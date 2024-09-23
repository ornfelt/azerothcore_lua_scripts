local UI = {}
UI.__index = UI

local Database = require(workspace.DatabaseHandler)
local AH = require(script.Parent.MainGui.AuraHandler)
local m_time = game:service'RunService'.Heartbeat
local pGUI = game.Players.LocalPlayer.PlayerGui
function UI.new(player, player_frame, target_frame, actionbar, castbar, Login)
	local new_UI = {}
	setmetatable(new_UI, UI)
	
	new_UI.link = player
	new_UI.player_frame = player_frame
	new_UI.target_frame = target_frame
	new_UI.actionbar = actionbar
	new_UI.error_frame = player_frame.Parent.Parent["Error Frame"]
	new_UI.errors = 0;
	new_UI.castbar = castbar
	new_UI.targetCastBar = target_frame.CastBarMain
	new_UI.Login = Login
	new_UI.Menu = pGUI.MenuGui
	new_UI.SpellBook = new_UI.Menu.SpellBook;
	new_UI.m_castTime = 0
	new_UI.DuelFrame = script.Parent.MainGui.Frame.DuelFrame
	new_UI.m_Spell = nil
	new_UI.m_isAlive = true
	new_UI.m_unitState = nil
	new_UI.m_isMoving = false
	new_UI.m_cbarProgress = 0
	new_UI.m_targetcbarProgress = 0
	new_UI.m_targetcanceledCast = false;
	new_UI.m_target = nil
	new_UI.m_targetHealthPool = nil
	new_UI.m_targetAuraList = {}
	new_UI.m_playerAuraList = {}
	new_UI.m_canceledCast = false;
	new_UI.wipeTarAuras = false;
	new_UI.m_targetCastTime = 0;
	new_UI.m_duelBox = script.Parent.MainGui.DuelFrame;
	new_UI.m_duelTimer = 0;
	new_UI.m_targetSpell = nil
	new_UI.m_BBG = game.ReplicatedStorage.UnitObjects.HealthPool:Clone()
	new_UI.m_labelNum = 0;
	new_UI.m_BBG.Parent = new_UI.link.Character:findFirstChild'Head';
	new_UI.m_BBG.Adornee = new_UI.link.Character:findFirstChild'Head';
	new_UI.m_spellList = nil;
	
	return new_UI
end

function UI:LoadSpellBook()
	local specItr = 0;
	local classItr = 0;
	if self.m_spellList ~= nil then
		for i,v in next, self.m_spellList do
			local spellId = v.m_spellId
			local spellImage = v.spellImage;
			local spellDesc = v.spellDesc;
			local sb = self.SpellBook
			local cspells1 = sb.ClassSpells1
			local cspells2 = sb.ClassSpells2
			local sspells1 = sb.SpecSpells1
			local sspells2 = sb.SpecSpells2
			local spellSpot = v.spellSpot;
			local inBook = v.m_inBook;
			if inBook == true then
				local nextSpell = sb.SpellTemp:Clone();
				local parent;
				if spellSpot == "Spec" then
					specItr = specItr + 1;
					if specItr <= 12 then
						nextSpell.Parent = sspells1
					else
						nextSpell.Parent = sspells2
					end
				elseif spellSpot == "Class" then
					classItr = classItr + 1;
					if classItr <= 12 then
						nextSpell.Parent = cspells1
					else
						nextSpell.Parent = cspells2
					end
				end
				nextSpell.ImageButton.Image = spellImage;
				nextSpell.SpellId.Value = spellId;
				nextSpell.Description.Text = spellDesc;
				nextSpell.SpellName.TextLabel.Text = v.spellName;
				if v.Charges ~= nil then
					nextSpell.SpellCharges.Text = tostring(v.Charges);
				end
				nextSpell.Visible = true;
			end
		end
	end
end

function UI:CancelCast()
	self.m_canceledCast = true;
end

function UI:LoadBars()
	local ABH = require(self.actionbar.ActionBarHandler)
	local button_set = ABH.new(self.actionbar, self)

	self.button_set = button_set
end

function UI:CancelTargetCast()
	self.m_targetcanceledCast = true;
end

function UI:UpdateCharacter(charName)
	self.player_frame.NameBar.TextButton.Text = charName
end

function UI:LockSchool(school)
	self.button_set:LockSchool(school);
end

function UI:LoadClass(Name, SpellList)
	self.m_spellList = SpellList;
	self.m_className = Name;
end

function UI:GetSpellList()
	return self.m_spellList;
end

function UI:HandleError(err)
	local errorFrame = self.error_frame
	local label = errorFrame.Template.TextLabel
	local scr = label.LocalScript
	
	-- Shift all others
	for _,v in next, errorFrame:GetChildren() do
		if v:IsA("TextLabel") then
			if v.Position == UDim2.new(0, 0, 0, -50) then
				v.LocalScript.Disabled = true
				v:Destroy();
			else
				v.Position = v.Position + UDim2.new(0, 0, 0, -25);
			end
		end
	end
	
	local new_label = label:Clone()
	new_label.Parent = errorFrame
	new_label.Text = err;
	new_label.LocalScript.Disabled = false;
	new_label.Visible = true;
end

function UI:UpdateElectives(data)
	local spellId1 = data.SpellId1
	local spellId2 = data.SpellId2
	local set = self.button_set
	set:UpdateElectives(spellId1, spellId2);
end

function UI:FindTargetAuraByKey(key)
	for _,v in next,self.m_targetAuraList do
		if v.key == key then
			return v;
		end
	end
end

function UI:FindPlayerAuraByKey(key)
	for _,v in next, self.m_playerAuraList do
		if v.key == key then
			return v;
		end
	end
end

function UI:UpdateStat(data)
	local target = data.Target
	local health = data.Health
	local maxHealth = data.MaxHealth
	if target == self:GetTarget() then
		if health == 0 then
			self.wipeTarAuras = true;
		end
		local stat = data.Stat
		if stat == "Health" then
			local bar=pGUI.MainGui.Frame.Target.HealthBar
			bar.Size=UDim2.new(0,(health/maxHealth)*220,0,37)
			if self:GetTarget() ~= nil then
				local bar2 = self:GetTargetBB().Bar.HealthBar
				bar2.Size = UDim2.new(0, (health/maxHealth)*192, 0, 13);
				local text = bar2.Parent.HealthLeft
				text.Text = "Health: "..tostring(math.floor((health/maxHealth)*100)).."%";
			end
		elseif stat == "Mana" then
			local bar = pGUI.MainGui.Frame.Target.ManaBar
			bar.Size=UDim2.new(0,(health/maxHealth)*220,0,37)
		end
	end
	if target == self.link then
		local stat = data.Stat
		if stat == "Health" then
			local bar = pGUI.MainGui.Frame.Player.HealthBar
			bar.Size = UDim2.new(0, (health/maxHealth)*220, 0, 37);
		elseif stat == "Mana" then
			local bar = pGUI.MainGui.Frame.Player.ManaBar
			bar.Size = UDim2.new(0, (health/maxHealth)*220, 0, 37);
		end
	end
end

function UI:DisplayCharacters(list)
	local leng = #list
	self.Login.Frame.SelectFolder.CharList.CharSet:ClearAllChildren();
	for i,v in next,list do
		local offset = 0.16
		local temp = self.Login.Frame.SelectFolder.CharList.CharTemp:Clone()
		temp.Parent = self.Login.Frame.SelectFolder.CharList.CharSet;
		temp.Name = v[1]
		temp.Position = UDim2.new(0.026, 0, 0.02 + (offset * (i - 1)), 0)
		temp.CharName.Text = v[1];
		temp.Visible = true;
		temp.LocalScript.Enabled = true;
	end
end

function UI:DisplayTargetBB()
	local target = self:GetTarget()
	if target ~= nil then
		if target:IsA("Player") then
			target = target.Character
		end
		
		local head = target:findFirstChild'Head';
		if head then
			local bbg = head:findFirstChild("HealthPool");
			if bbg then
				self.m_targetHealthPool = bbg
				bbg.Enabled = true;
			end
		end
	end
end

function UI:GetTargetBB()
	return self.m_targetHealthPool;
end

function UI:GetTarget()
	return self.m_target;
end

function UI:EnableCharCreation()
	self.Login.Frame.SelectFolder.CreateFrame.CreateChar.Visible = true;
end

function UI:DisableCharCreation()
	self.Login.Frame.SelectFolder.CreateFrame.CreateChar.Visible = false;
end

function UI:AskDuel(target)
	if target then
		local tar_name = target.Name
		local frame = self.DuelFrame;
		frame.Visible = true
		frame.TextLabel.Text = target.Name.." has challenged you to a duel."
	end
end

function UI:UpdateTarget(data)
	local player = self.link
	local pGUI = player.PlayerGui
	--local manaScript = pGUI.MainGui.Frame.Target.ManaBar.ManaScript
	
	-- Update Name before visible so not buggy transition
	if data == nil then
		self.m_target = nil;
		pGUI.MainGui.Frame.Target.Visible = false;
	end
	if data.m_Health == 0 then
		pGUI.MainGui.Frame.Target.NameBar.TextButton.Text=data.Name.."(Dead)"
	else
		pGUI.MainGui.Frame.Target.NameBar.TextButton.Text=data.Name
	end
	
	pGUI.MainGui.Frame.Target.Debuffs.DebuffFolder:ClearAllChildren();
	self.m_targetAuraList = {};
	coroutine.resume(coroutine.create(function()
		local CurrentHealth=data.m_Health
		self.targetHP = data.m_Health;
		local MaxHealth=data.m_maxHealth
		local bar=pGUI.MainGui.Frame.Target.HealthBar
		local maxSize=220
		local SizeX=bar.AbsoluteSize.X
		bar.Size=UDim2.new(0,(CurrentHealth/MaxHealth)*maxSize,0,37)
	end))
	--manaScript.Disabled=true
	local CurrentMana=data.m_Mana
	local MaxMana=data.m_maxMana
	local bar=pGUI.MainGui.Frame.Target.ManaBar
	local maxSize=220
	local SizeX=bar.AbsoluteSize.X
	bar.Size=UDim2.new(0,(CurrentMana/MaxMana)*maxSize,0,37)
	--manaScript.Disabled=false
	print(data.link);
	self.target_frame.Target.Value = data.link
	pGUI.MainGui.Frame.Target.Visible = true; -- do this at the end so it doesn't show it updating
	local old_target = self:GetTarget();
	print(old_target);
	if old_target ~= nil then
		if old_target:IsA("Player") then
			old_target = old_target.Character
		end
		local old_head = old_target:findFirstChild("Head")
		if old_head then
			old_head.HealthPool.Enabled = false;
		end
	end
	self.m_target = data.link
	self:DisplayTargetBB();

end

function UI:UpdateAura(caster, target, auraInfo, key, spot, Duration, Stacks) -- checks if aura exists, if it does, update the data for the aura (duration, charges, etc.)
	local aura;
	if target == self.link then -- Check if aura is for the local player
		aura = self:FindPlayerAuraByKey(key)
		if aura then
			aura:UpdateInfo(auraInfo, Duration, Stacks)
			return true;
		end
	else -- Aura not for local player, must be for target
		aura = self:FindTargetAuraByKey(key)
		if aura then
			aura:UpdateInfo(auraInfo, Duration, Stacks)
			return true;
		end
	end
	
	--Aura does not exist anywhere, make new one
	self:AddAura(caster, target, auraInfo, key, spot, Duration, Stacks);
end

function UI:RemoveAura(where, key)
	if where == "target" then
		for i,v in next, self.m_targetAuraList do
			if v.key == key then
				table.remove(self.m_targetAuraList, i)
				v.link:Destroy()
			end
		end
	end
	if where == "player" then
		for i,v in next, self.m_playerAuraList do
			if v.key == key then
				print(v.info.Name);
				table.remove(self.m_playerAuraList, i)
				v.link:Destroy()
			end
		end
	end
end

function UI:AddAura(caster, target, auraInfo, key, spot, Duration)
	if target ~= self.link then -- Check if aura is not for the local player
		local new_aura = AH.new(self, auraInfo, key, spot, Duration)
		table.insert(self.m_targetAuraList, new_aura);
	else
		local new_aura = AH.new(self, auraInfo, key, spot, Duration)
		table.insert(self.m_playerAuraList, new_aura);
	end
end

function UI:SetCasting(ctime)
	self.m_castTime = ctime;
end

function UI:SetTargetCasting()
	self.m_targetCasting = true
end

function UI:UpdateSpell(spell)
	self.m_Spell = spell
end

function UI:UpdateTargetSpell(spell)
	self.m_targetSpell = spell;
end

function UI:SetOnGCD(m_time)
	self.button_set:SetOnGCD(m_time)
end

function UI:SetCustomGCD(spell)
	local gcdTime = tonumber(spell.SpellFlags:findFirstChild'SPELL_FLAG_CUSTOM_GCD'.Value)
	if gcdTime > 0 then
		for _,v in next,self.button_set.m_set do
			if tonumber(spell.Name) == v.spellId then
				v:SetOnGCD(gcdTime);
			end
		end
	end
end

function UI:SetOnCooldown(spell)
	local spellId = tonumber(spell.Name)
	for _,v in next,self.button_set.m_set do
		if spellId == v.spellId then
			v:SetOnCD();
			break;
		end
	end
end

function UI:ResetCooldown(spell)
	local spellId = tonumber(spell.Name);
	for _,v in next, self.button_set.m_set do
		if spellId == v.spellId then
			v:ResetCD();
			break;
		end
	end
end

function UI:IsOnCooldown(spell)
	local spellId = tonumber(spell.Name);
	for _,v in next, self.button_set.m_set do
		if spellId == v.spellId then
			return v:IsOnCD();
		end
	end
end

function UI:UpdateCharges(spell, charges)
	local spellId = tonumber(spell.Name);
	for _,v in next, self.button_set.m_set do
		if spellId == v.spellId then
			v:UpdateCharges(charges);
			break;
		end
	end
end

function UI:DuelAccepted()
	if self.m_duelBox.Visible == false then
		self.m_duelBox.Visible = true
	end
	self.m_duelTimer = 3;
end

function UI:Update(deltaTime)
	--[[Cast Bar]]--
	--local player = self.link
	if self.m_castTime > 0 then
		local cbm = self.castbar.CastBarMain
		local cbp = self.castbar.CastBarMain.ImageLabel
		cbp.Image = self.m_Spell.ImageButton.Image;
		local cbc = cbm.CastBarCenter
		local ob = cbc.OrangeBar
		ob.BackgroundColor3 = Color3.new(0.917647, 0.611765, 0);
		local tl = ob.TextLabel
		local scr = tl.HandleFade;
		scr.Disabled = true;
		local cancel = false;
		cancel = true;
		cbm.Visible=true;
		local castTime = self.m_castTime;
		local rate = 1 / (castTime - 0.2); -- account for strange delay, need to find cause as it wasn't there before
		local SizeX=190
		local timePassed = 0;
		local numTimes = 0;
		local renderstepped;
		ob.Size = UDim2.new(0, 0, 0, 15);
		tl.TextTransparency = 0;
		ob.BackgroundTransparency = 0;
		cbc.BackgroundTransparency = 0;
		--cbm.BackgroundTransparency = 0;
		tl.Text=self.m_Spell.SpellName.Value;
		if self.m_cbarProgress >= 1 or self.m_canceledCast == true then
			self.m_cbarProgress = 1;
			cancel = false;
			--bar.Visible=false;
			scr.Disabled = false;
			if self.m_canceledCast == false then
				ob.BackgroundColor3 = Color3.new(0,255,0);
			else
				ob.BackgroundColor3 = Color3.new(255, 0, 0);
			end
			self.m_castTime = 0
			self.m_cbarProgress = 0;
			self.m_canceledCast = false;
		else
			ob.Size=UDim2.new(0,0,0,15):Lerp(UDim2.new(0,190,0,15),self.m_cbarProgress);
			self.m_cbarProgress = self.m_cbarProgress + (rate * deltaTime);
		end
	end
	
	if self.m_targetCastTime > 0 then
		local cbm = self.targetCastBar
		local cbc = cbm.CastBarCenter
		local cbp = cbm.ImageLabel
		cbp.Image = self.m_targetSpell.ImageButton.Image;
		local ob = cbc.OrangeBar
		ob.BackgroundColor3 = Color3.new(255, 170, 0);
		local tl = ob.TextLabel
		local scr = tl.HandleFade;
		scr.Disabled = true;
		local cancel = false;
		cancel = true;
		cbm.Visible=true;
		local castTime = self.m_targetSpell.CastTime.Value
		local rate = 1 / (castTime - 0.2); -- account for strange delay, need to find cause as it wasn't there before
		local SizeX=190
		local timePassed = 0;
		local numTimes = 0;
		local renderstepped;
		ob.Size = UDim2.new(0, 0, 0, 15);
		tl.TextTransparency = 0;
		ob.BackgroundTransparency = 0;
		cbc.BackgroundTransparency = 0;
		--cbm.BackgroundTransparency = 0;
		tl.Text=self.m_targetSpell.SpellName.Value;
		if self.m_targetcbarProgress >= 1 or self.m_targetcanceledCast == true then
			self.m_targetcbarProgress = 1;
			cancel = false;
			--bar.Visible=false;
			scr.Disabled = false;
			if self.m_targetcanceledCast == false then
				ob.BackgroundColor3 = Color3.new(0,255,0);
			else
				ob.BackgroundColor3 = Color3.new(255, 0, 0);
			end
			self.m_targetCastTime = 0
			self.m_targetcbarProgress = 0;
			self.m_targetcanceledCast = false;
		else
			ob.Size=UDim2.new(0,0,0,15):Lerp(UDim2.new(0,190,0,15),self.m_targetcbarProgress);
			self.m_targetcbarProgress = self.m_targetcbarProgress + (rate * deltaTime);
		end
	end
	
	-- Target Death
	if self.wipeTarAuras == true then
		for _,v in next, self.m_targetAuraList do
			self:RemoveAura(v.spot, v.key);
			v:Update(deltaTime);
		end
	end
	
	-- Duel Timer
	if self.m_duelTimer > 0 then
		self.m_duelTimer = self.m_duelTimer - m_time
		self.m_duelBox.TextLabel.Text = math.ceil(self.m_duelTimer);
	else
		self.m_duelTimer = 0;
		self.m_duelBox.Visible = false;
	end
	
	--GCD
	if self.button_set ~= nil then
		self.button_set:Update(deltaTime)
	end
	
	--Auras
	if #self.m_targetAuraList > 0 then
		for _,v in next,self.m_targetAuraList do
			if v.m_duration == 0 then
				self:RemoveAura(v.spot, v.key);
				continue;
			end
			v:Update(deltaTime);
		end
		
		for i = 1, #self.m_targetAuraList do
			if self.m_targetAuraList[i] then
				if i == 1 then
					self.m_targetAuraList[i].link.Position = UDim2.new(0, 0, 0, 0);
				else
					self.m_targetAuraList[i].link.Position = UDim2.new(0, 30*(i - 1), 0, 0);
				end
			end
		end
	end
	if #self.m_playerAuraList > 0 then
		for _,v in next,self.m_playerAuraList do
			if v.m_duration == 0 then
				self:RemoveAura(v.spot, v.key);
				continue;
			end
			v:Update(deltaTime);
		end

		for i = 1, #self.m_playerAuraList do
			if self.m_playerAuraList[i] then
				if i == 1 then
					self.m_playerAuraList[i].link.Position = UDim2.new(0, 0, 0, 0);
				else
					self.m_playerAuraList[i].link.Position = UDim2.new(0, 30*(i - 1), 0, 0);
				end
			end
		end
	end
	
end

function UI:WipeTargetAuras()
	for _,v in next,self.m_targetAuraList do
		self:RemoveAura(v.spot, v.key);
	end
end

function UI:GetActionSpells()
	return self.m_actionBarButtons
end

function UI:ToPlayer()
	return self.link
end

function UI:AddTargetDebuff(spell)
	if spell then
		local targetUI = self.target_frame;
		local Debuffs = targetUI.Debuffs;
		local debuffFolder = Debuffs.DebuffFolder;
		for _,v in next,debuffFolder:GetChildren() do
			if v and v.Name == spell.Name then
				v.Spell.Value = spell;
				return true;
			end
		end
		Debuffs.DebuffNum.Value = Debuffs.DebuffNum.Value + 1;
		local dbName = Debuffs.DebuffName;
		local newBuff = dbName:Clone();
		local tac1,tac2 = Database.Access("world", "spell_script_decals", spell.Name);
		newBuff.Name = spell.Name;
		newBuff.Spell.Value = spell;
		newBuff.Debuff.Image = tac1.Value;
		newBuff.Parent = debuffFolder;
		newBuff.SpotNum.Value = Debuffs.DebuffNum.Value;
		newBuff.Visible = true
		newBuff.Script.Disabled = false;
		Debuffs.Visible = true;
	end
end

function UI:AddPlayerDebuff(spell)
	-- TODO: Add this
end

function UI:AddTargetBuff(spell)
	-- TODO: Add this
end

function UI:AddPlayerBuff(spell)
	-- TODO: Add this
end

function UI:CastTargetSpell(spell)
	local player = self.link
	local castbar = player.PlayerGui:WaitForChild'MainGui':WaitForChild'Frame':WaitForChild'Target':WaitForChild'CastBarMain';
	if castbar then
		local cbarMain = castbar;
		local cbarScript = cbarMain.CastBarCenter.OrangeBar.TextLabel.RunBar;
		if cbarScript.Disabled == true then
			cbarScript.Disabled = false;
			return true;
		end
	end
	return false;
end

function UI:CastPlacementSpell(spell)
	local placementUI = game:service'ReplicatedStorage'.MousePos:Clone();
	placementUI.Parent = game.Players.LocalPlayer.Backpack;
	local ls = placementUI.LocalScript;
	ls.Disabled = false;
end

function UI:PushCooldown(spell)
	local player = self.link
	if player and spell then
		for _,v in next,player:findFirstChild'Backpack':findFirstChild'Spell List':GetChildren() do
			if tostring(v.Value) == spell.Name then
				spell = v;
			end
		end
		if player.PlayerGui:findFirstChild'ActionBar' then
			for _,v in next,player.PlayerGui:findFirstChild'ActionBar':findFirstChild'Set':GetChildren() do
				if v:IsA("Frame") then
					if v.Name == spell.Name then
						if v:findFirstChild'Cooldown' then
							v.Cooldown.Disabled = true;
							wait()
							v.Cooldown.Disabled = false;
						end
					end
				end
			end
		end
	end
end

function UI:PushSilenced()
	local player = self.link
	if player then
		if player.PlayerGui:findFirstChild'ActionBar' then
			for _,v in next,player.PlayerGui:findFirstChild'ActionBar':findFirstChild'Set':GetChildren() do
				if v:IsA("Frame") then
					if v:findFirstChild'Silenced' then
						v.Silenced.Disabled = false;
					end
				end
			end
		end
	end
end

return UI
