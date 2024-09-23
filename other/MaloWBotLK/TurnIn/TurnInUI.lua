function TI_PopulateOptions(arg)
	TI_debug(arg);
	local CurrOpts;
	local last=1;
	if(TI_status and TI_status.options) then
		if(TI_LoadedNPCIndex > 0) then
			CurrOpts = TI_NPCDB[TI_NPCIndex[TI_LoadedNPCIndex]];
		else
			CurrOpts = TI_status.options;
		end
		
		for i,v in ipairs(CurrOpts) do
			local entry = "TI_OptionsPriority" .. i;
			local entrybutton = getglobal(entry);
			local entrytext = getglobal("TI_OptionsPriority"..i.."_Text");
			local iconpath;
			if(v.name == nil) then TI_debug("oh noes") end;
			entrytext:SetText(v.name);
			if(v.type == "activequest") then
				if(v.icon) then
					iconpath = v.icon;
				else
					iconpath = "Interface\\GossipFrame\\ActiveQuestIcon";
				end
			elseif(v.type == "availquest") then
				if(v.icon) then
					iconpath = v.icon;
				else
					iconpath = "Interface\\GossipFrame\\AvailableQuestIcon";
				end
			else
				iconpath = "Interface\\GossipFrame\\" .. v.type .. "GossipIcon";
			end
			getglobal(entry .. "_Icon"):SetTexture(iconpath);
			getglobal(entry .. "_Check"):SetChecked(v.state);
			entrytext:SetWidth(156); --make sure to change this if you change the anchors in the XML
			entrybutton:SetHeight( entrytext:GetHeight() + 6);
			entrybutton:Show();
			last = last+1;
		end
		for j=last, 16, 1 do
			getglobal("TI_OptionsPriority" .. j):Hide();
		end
		TI_OptionsPriorityScrollFrame:SetVerticalScroll(0);
		TI_OptionsPriorityScrollFrame:UpdateScrollChildRect();
		TI_StatusIndicatorUpdate();
	end
	TI_NPCListScrollBarUpdate();
	TI_SettingCheckboxUpdate();
end

--[[
function TI_PopulateOptions(arg)
	TI_debug(arg);
	if(TI_status and TI_status.options) then
		for i,v in ipairs(TI_status.options) do
			local entry = "TI_OptionsPriority" .. i;
			local iconpath;
			if(v.name == nil) then TI_debug("oh noes") end;
			if(getglobal(entry .. "_Text") == nil) then TI_debug("wtf "..entry .. "_Text") end;
			getglobal(entry .. "_Text"):SetText(v.name);
			if(v.type == "activequest") then
				iconpath = "Interface\\GossipFrame\\ActiveQuestIcon";
			elseif(v.type == "availquest") then
				iconpath = "Interface\\GossipFrame\\AvailableQuestIcon";
			else
				iconpath = "Interface\\GossipFrame\\" .. v.type .. "GossipIcon";
			end
			getglobal(entry .. "_Icon"):SetTexture(iconpath);
			getglobal(entry .. "_Check"):SetChecked(v.state);
			getglobal(entry):Show();
		end
	end
	TI_NPCListScrollBarUpdate();
end
]]--

function TI_NPCListScrollBarUpdate()
	if(TI_NPCIndex) then
		FauxScrollFrame_Update(TI_NPCListScrollFrame,table.getn(TI_NPCIndex),8,20);
	-- arg2 is max entries, arg3 is number of lines, arg4 is pixel height of each line
	
		local line; -- 1 through 8 of our window to scroll
		local lineplusoffset; -- an index into our data calculated from the scroll offset
		local offset = FauxScrollFrame_GetOffset(TI_NPCListScrollFrame);
		local i=1;
		local j=1;
	--~ 	for k, v in pairs(TI_NPCDB) do
	--~ 			if(offset <= i and i < offset+8) then
	--~ 				if(i <= table.getn(TI_NPCDB)) then
	--~ 					getglobal("TI_OptionsNPCContainer"..j.."_Text"):SetText(k);
	--~ 					getglobal("TI_OptionsNPCContainer"..j.."_Check"):SetChecked(v.state);
	--~ 					getglobal("TI_OptionsNPCContainer"..j):Show();
	--~ 				else
	--~ 					getglobal("TI_OptionsNPCContainer"..j):Hide();
	--~ 				end
	--~ 				j = j + 1;
	--~ 			end
	--~ 			i = i + 1;
	--~ 	end
		
		for line=1,8 do
			lineplusoffset = line + FauxScrollFrame_GetOffset(TI_NPCListScrollFrame);
			if(lineplusoffset <= table.getn(TI_NPCIndex)) then
				getglobal("TI_OptionsNPCContainer"..line):SetID(lineplusoffset);
				getglobal("TI_OptionsNPCContainer"..line.."_Text"):SetText(TI_NPCIndex[lineplusoffset]);
				getglobal("TI_OptionsNPCContainer"..line.."_Check"):SetChecked(TI_NPCDB[TI_NPCIndex[lineplusoffset]].state);
				if(lineplusoffset == TI_LoadedNPCIndex) then
					getglobal("TI_OptionsNPCContainer"..line):LockHighlight();
				else
					getglobal("TI_OptionsNPCContainer"..line):UnlockHighlight();
				end
				getglobal("TI_OptionsNPCContainer"..line):Show();
			else
				getglobal("TI_OptionsNPCContainer"..line):Hide();
			end
		end
	end
end

function TI_SelectNPCIndex(self) 
	local index = self:GetID();
	if(TI_LoadedNPCIndex == index) then
		TI_LoadedNPCIndex = 0;
	else
		TI_LoadedNPCIndex = index;
	end
	
	TI_PopulateOptions("select npc");
end

function TI_DeleteNPCIndex(self)
	local index = self:GetParent():GetID();
	TI_DeleteNPC(index);
	if(TI_LoadedNPCIndex == index) then
		TI_LoadedNPCIndex = 0;
	end
	TI_PopulateOptions("npclist update");
end

function TI_NPCToggle(self)
	local index = self:GetParent():GetID();
	TI_NPCDB[TI_NPCIndex[index]].state = self:GetChecked();
	
	if(TI_NPCDB[TI_NPCIndex[index]].state) then
		TI_LoadedNPCIndex = index;
	else
		if(TI_LoadedNPCIndex == index) then
			TI_LoadedNPCIndex = 0;
		end
	end
	TI_PopulateOptions("select npc");
end

function TI_OptionMove(self, offset)
	local CurrOpts;
	if(TI_LoadedNPCIndex > 0) then
		CurrOpts = TI_NPCDB[TI_NPCIndex[TI_LoadedNPCIndex]];
	else
		CurrOpts = TI_status.options;
	end
	local id = self:GetParent():GetID();
	local newid = id + offset;
	
	if(newid < 1 or newid > table.getn(CurrOpts)) then
		return;
	end
	
	local temp = CurrOpts[newid];
	CurrOpts[newid] = CurrOpts[id];
	CurrOpts[id] = temp;
	
	TI_PopulateOptions("move");
end

function TI_OptionToggle(self)
	local CurrOpts;
	if(TI_LoadedNPCIndex > 0) then
		CurrOpts = TI_NPCDB[TI_NPCIndex[TI_LoadedNPCIndex]];
	else
		CurrOpts = TI_status.options;
	end
	local id = self:GetParent():GetID();
	if(self:GetChecked()) then
		CurrOpts[id].state=true;
	else
		CurrOpts[id].state=false;
	end
end

function TI_StatusIndicatorUpdate()
	if(TI_status) then
		if(TI_status.state) then
			TI_StatusIndicator_Status:SetText("On");
			TI_StatusIndicator_Status:SetTextColor(0,1,0);
		else
			TI_StatusIndicator_Status:SetText("Off");
			TI_StatusIndicator_Status:SetTextColor(1,0,0);
		end
		TI_StatusIndicator_Checkbox:SetChecked(TI_status.state);
	end
end


function TI_StatusIndicator_CheckFn(self)
	if(self:GetChecked()) then
		TI_Switch("on");
	else
		TI_Switch("off");
	end
end


function TI_TempNPCListTooltipShow(self)
	TI_Tooltip:SetOwner(self, ANCHOR_PRESERVE);
	TI_Tooltip:ClearLines();
	local id = self:GetID();
	TI_Tooltip:AddLine(TI_TempNPCList[id].location);
	for i,v in ipairs(TI_TempNPCList[id].list) do
		TI_Tooltip:AddLine("- " .. v.name);
	end
	
	--TI_Tooltip:SetText(text);
	TI_Tooltip:Show();
end

function TI_TooltipHide()
	TI_Tooltip:Hide();
end

function TI_TooltipMessage(self, msg)
	TI_Tooltip:SetOwner(self, ANCHOR_PRESERVE);
	TI_Tooltip:ClearLines();
	TI_Tooltip:SetText(msg);
	TI_Tooltip:Show();
end

function TI_TempNPCListUpdate()
	local last = 1;
	for i,v in ipairs(TI_TempNPCList) do
		local tempbuttontext = _G["TI_TempNPCListWindow"..i.."_Text"];
		tempbuttontext:SetText(v.name);
		tempbuttontext:GetParent():Show();
		last = last+1;
	end
	for j=last, TI_TempNPCListMaxSize, 1 do
		_G["TI_TempNPCListWindow" .. j]:Hide();
	end
end

function TI_NPCListCheckboxTooltip(self)
	if(self:GetChecked()) then
		TI_TooltipMessage(self, "NPC is using specific settings.");
	else
		TI_TooltipMessage(self, "NPC is using default settings.");
	end
end

function TI_OptionListCheckboxTooltip(self)
	if(self:GetChecked()) then
		TI_TooltipMessage(self, "This option is enabled.");
	else
		TI_TooltipMessage(self, "This option is disabled.");
	end
end

function TI_SettingCheckboxFn(self, var)
	if(self:GetChecked()) then
		TI_status[var] = true;
	else
		TI_status[var] = false;
	end
end

function TI_SettingCheckboxUpdate()
	if(TI_status) then
		TI_SettingCheckboxes_UseDefault:SetChecked(TI_status.usedefault);
		TI_SettingCheckboxes_AddAutomatically:SetChecked(TI_status.autoadd);
	end
end
