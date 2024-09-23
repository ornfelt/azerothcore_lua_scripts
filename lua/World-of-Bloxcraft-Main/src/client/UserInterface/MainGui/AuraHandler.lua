local AuraHandler = {}
AuraHandler.__index = AuraHandler

local Database = require(workspace.DatabaseHandler)

function AuraHandler.new(UI, info, key, spot, Duration, stacks)
	local new_aura = {}
	setmetatable(new_aura, AuraHandler)
	
	new_aura.info = info
	new_aura.m_duration = Duration
	new_aura.key = key;
	new_aura.UI = UI;
	new_aura.spot = spot;
	new_aura.stacks = stacks;
	new_aura.targetDebuffFolder = script.Parent.Frame.Target.Debuffs.DebuffFolder;
	if spot == "target" then
		new_aura.link = script.Parent.Frame.Target.Debuffs.DebuffName:Clone();
		new_aura.link.Parent = script.Parent.Frame.Target.Debuffs.DebuffFolder;
	elseif spot == "player" then
		if info.PositiveNegative.Value == true then
			new_aura.link = script.Parent.Frame.BuffList.BuffName:Clone()
			new_aura.link.Parent = script.Parent.Frame.BuffList.BuffFolder;
		else
			new_aura.link = script.Parent.Frame.DebuffList.DebuffName:Clone()
			new_aura.link.Parent = script.Parent.Frame.DebuffList.DebuffFolder;
		end
	end
	new_aura.durationLink = new_aura.link.TimeLeft
	new_aura.stacksLink = nil;
	new_aura.stacksLink = new_aura.link.Stacks;
	local tac1,tac2 = Database.Access("world", "spell_script_decals", info.Name);
	new_aura.link.Name = info.AuraName.Value;
	new_aura.link.Aura.Image = tac1.Value;
	new_aura.link.Visible = true
	new_aura.link.Parent.Parent.Visible = true;
	new_aura.m_active = true;
	
	return new_aura;
end

function AuraHandler:UpdateInfo(new_info, Duration, stacks)
	self.info = new_info;
	self.m_duration = Duration;
	self.stacks = stacks;
end

function AuraHandler:Update(m_time)
	if self.m_active == true then
		if self.m_duration > 0.01 then
			if self.m_duration >= 10000 then
				self.durationLink.Text = "";
			else
				self.m_duration = self.m_duration - m_time;
				self.durationLink.Text = math.floor(self.m_duration)
				if self.stacks > 1 then
					self.stacksLink.Text = self.stacks;
					self.stacksLink.Visible = true;
				else
					self.stacksLink.Visible = false;
				end
			end
		else
			self.m_duration = 0;
		end
	end
end

return AuraHandler
