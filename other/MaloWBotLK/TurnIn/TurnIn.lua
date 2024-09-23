--[[
	Turn-In Mod
	version 2.1
	Authored by Ian Friedman
		Sabindeus of Smolderthorn (Alliance)
	The repeatable quest turn in automating machine.
	
	Thanks to Arcanemagus of Hyjal for extra bug fixes and coding input
]]

TI_VersionString = "2.0";
local TI_slashtable;
TI_gossipclosed = false;
TI_LoadedNPCIndex = 0;
TI_activenumber = 1;
TI_availnumber = 1;
TI_specnum = 0;
TI_gossipopts = {};

TI_TempNPCList = {};
TI_TempNPCListMaxSize = 5;

TI_NPCInQuestion = nil;

local TI_GossipDefaults = {
	availquest ="Available Quests",
	activequest = "Active Quests",
	gossip = "Gossip",
	vendor = "Vendor",
	taxi = "Taxi",
	trainer = "Trainer",
	battlemaster = "Battlemaster",
	binder = "Hearthstone Binder",
	healer = "Spirit Healer",
	banker = "Bank"
};

local TI_FunctionList = {
	g = {
		availquest = SelectGossipAvailableQuest,
		activequest = SelectGossipActiveQuest,
		default = SelectGossipOption
	},
	q = {
		availquest = SelectAvailableQuest,
		activequest = SelectActiveQuest
	}
};


local TI_DefaultStatus = {
	state = false,
	version = TI_VersionString,
	options = {},
	debugstate = false,
	usedefault=true,
	autoadd=false
};

local TI_events = {
	"GOSSIP_SHOW",
	"GOSSIP_CLOSED",
	"QUEST_DETAIL",
	"QUEST_COMPLETE",
	"QUEST_PROGRESS",
	"QUEST_GREETING",
	"QUEST_FINISHED"
};

TI_TempNPCList = {};

function TI_message(...)
	local x = {...};
	for k,v in pairs(x) do
		DEFAULT_CHAT_FRAME:AddMessage(tostring(v));
	end
end

function TI_debug(...)
	if(TI_status.debugstate) then
		TI_message(...)
	end
end

function TI_OnLoad()
	SlashCmdList["TI"]=TI_SlashCmdHandler;
	SLASH_TI1="/turnin";
	SLASH_TI2="/ti";
	tinsert(UISpecialFrames,"TI_OptionsFrame");
	TI_message("Turn In loaded");
	TI_slashtable = {};
	TI_gossipopts = {};
	TI_gossipclosed = false;
	TurnIn:RegisterEvent("VARIABLES_LOADED");
	TI_activenumber = 1;
	TI_availnumber = 1;
	TI_specnum = 0;
	
	StaticPopupDialogs["TI_NPCINQUESTION"] = {
		text = "The NPC %s is already in your NPC Database. Do you wish to replace his gossip options with the current ones? (Note: This will overwrite your settings for this NPC.)",
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			TI_AddNPCToList(TI_NPCInQuestion.list, TI_NPCInQuestion.name, true);
		end,
		timeout=0,
		whileDead = 1,
		hideOnEscape = 1
	};
end

function TI_VarInit()
	if(not TI_status or TI_status.version ~= TI_VersionString) then
		TI_status = TI_copyTable(TI_DefaultStatus);
		TI_OptionsInit();
	end
	if(not TI_status.options or #TI_status.options == 0) then
		TI_OptionsInit();
	end
	if(not TI_NPCDB) then
		TI_NPCDB = {};
	end
	if(not TI_NPCIndex) then
		TI_NPCIndexGenerate();
	end
	TI_PopulateOptions("vars loaded");
end

function TI_OptionsInit()
	TI_status.options = {};
	for k,v in pairs(TI_GossipDefaults) do
		local temp = {};
		temp.name = v;
		temp.type = k;
		temp.state = false;
		table.insert(TI_status.options, temp);
	end
end

function TI_NPCIndexGenerate()
	TI_NPCIndex = {};
	for k,v in pairs(TI_NPCDB) do
		table.insert(TI_NPCIndex, k);
	end
	table.sort(TI_NPCIndex);
end

function TI_LoadEvents() 
	for k,v in pairs(TI_events) do 
		TurnIn:RegisterEvent(v);
	end
end

function TI_ResetPointers()
	TI_activenumber = 1;
	TI_availnumber = 1;
	TI_specnum = 0;
end

function TI_UnloadEvents() 
	for k,v in pairs(TI_events) do 
		TurnIn:UnregisterEvent(v);
	end
end

function TI_Switch(state)
	if(state=="on") then
		TI_status.state = true;
		TI_LoadEvents();
		TI_message("Turn In On");
	elseif(state=="off") then
		TI_ResetPointers();
		TI_status.state = false;
		TI_UnloadEvents();
		TI_message("Turn In Off");
	elseif(state=="toggle") then
		if(TI_status.state) then
			TI_Switch("off");
		else
			TI_Switch("on");
		end
	end
	TI_StatusIndicatorUpdate();
end


function TI_SlashCmdHandler(cmd)
	cmdlist = {strsplit(" ", cmd)};
	
	local commands = {
		on = function ()
			TI_Switch("on");
		end,
		off = function ()
			TI_Switch("off");
		end,
		toggle = function ()
			TI_Switch("toggle");
		end,
		status = function ()
			if(TI_status.state) then
				TI_message("Turn In On");
			else
				TI_message("Turn In Off");
			end
		end,
		window = function ()
			TI_OptionsFrame:Show();
		end,
		recent = function ()
			TI_TempNPCListWindow:Show();
		end,
		debug = function ()
			if(TI_status.debugstate) then
				TI_status.debugstate = false;
				TI_message("debug mode off");
			else
				TI_status.debugstate = true;
				TI_message("debug mode on");
			end
		end
	};
	
	if(commands[cmdlist[1]]) then
		commands[cmdlist[1]](cmdlist[2], cmdlist[3], cmdlist[4]);
	else
		TI_message("Turn In 2.1 Help", "--------------", "/ti on - turns Turn In on", "/ti off - turns Turn In off", "/ti toggle - toggles Turn In on or off", "/ti window - shows the options window", "/ti recent - shows the recently visited NPCs");
	end
	
	
end

function TI_IsNPCOn(npcname, type)
	local opton = false;
	if(type ~= nil) then
		for k,v in pairs(TI_status.options) do
			if(v.type == type and v.state == true) then
				opton = true;
			end
		end
	else
		opton = true;
	end
	if(TI_NPCDB[npcname] == nil and TI_status.usedefault == true and opton == true) then
		TI_debug("case 1");
		return true;
	elseif(TI_NPCDB[npcname] ~= nil and TI_NPCDB[npcname].state) then
		TI_debug("case 2");
		return true;
	elseif(TI_NPCDB[npcname] ~= nil and TI_status.usedefault == true and not TI_NPCDB[npcname].state and opton == true) then
		TI_debug("case 4");
		return true;
	else
		TI_debug("case 3");
		return false;
	end
	
end


function TI_OnEvent(self, event, ...)
	if(event == "VARIABLES_LOADED") then
		TI_VarInit();
		if(TI_status.state) then 
			TI_LoadEvents();
		end
	end
	if(TI_status.state and not IsShiftKeyDown()) then 
		if(event == "QUEST_GREETING") then
			TI_debug("Quest Greeting");
			TI_lastquestframe = "greeting";
			if(QuestFrame:IsVisible()) then
				if(TI_gossipclosed) then
					TI_debug("resetting pointers");
					TI_gossipclosed = false;
					TI_ResetPointers();
				end
				TI_HandleGossipWindow("q");
			end
		end
		if(event == "GOSSIP_SHOW") then
			TI_debug("Gossip Show");
			if(GossipFrame:IsVisible()) then
				if(TI_gossipclosed) then
					TI_debug("resetting pointers");
					TI_gossipclosed = false;
					TI_ResetPointers();
				end
				TI_HandleGossipWindow("g");
			end
		end
		if(event == "GOSSIP_CLOSED") then
			TI_debug("Gossip Closed");
			if(not GossipFrame:IsVisible()) then
				TI_gossipclosed = true;
			end;
		end
		if(event == "QUEST_COMPLETE") then
			TI_debug("Quest Complete");
			if(TI_IsNPCOn(UnitName("npc"), "activequest")) then
				if(not (GetNumQuestChoices() > 1)) then
					GetQuestReward(1);
				end
			end
			TI_ResetPointers();
		end
		if(event == "QUEST_PROGRESS") then
			TI_debug("Quest Progress");
			TI_gossipclosed = false;
			TI_lastquestframe = "progress";
			TI_HandleQuestProgress();
		end
		if(event == "QUEST_DETAIL") then
			TI_debug("Quest Detail");
			TI_gossipclosed = false;
			if(TI_IsNPCOn(UnitName("npc"), "availquest")) then
				AcceptQuest();
			end
			TI_ResetPointers();
		end
		if(event == "QUEST_FINISHED") then
			TI_debug("Quest Finished");
			if(not QuestFrame:IsVisible() and TI_lastquestframe == "greeting") then
				TI_debug("looks like the quest frame closed, resetting pointers on next open");
				TI_gossipclosed = true;
			end
		end
	end
end

function TI_HandleQuestProgress()
	
	local questname = GetTitleText();
	local npcname = UnitName("npc");
	if(QuestFrame:IsVisible()) then
		if(TI_NPCDB[npcname]) then
			local thisnpc = TI_NPCDB[npcname];
				if(thisnpc.state) then
					for i,current in ipairs(thisnpc) do
						if(current.name == questname and current.state) then
							TI_CompleteQuest();
						end
					end
				else
					if(TI_IsNPCOn(UnitName("npc"), "activequest")) then
						TI_CompleteQuest();
					end
				end
		else
			if(TI_IsNPCOn(UnitName("npc"), "activequest")) then
				TI_CompleteQuest();
			end
		end
		
	end
end

function TI_CompleteQuest()
	if(IsQuestCompletable()) then
		CompleteQuest();
		TI_ResetPointers();
	else
		DeclineQuest();
	end
end

function TI_GetQuests(type)
	local numQuests = (getglobal("GetNum"..type.."Quests"))();
	local qfn = getglobal("Get"..type.."Title");
	local ret = {};
	local qname;
	local i=1;
	for i=1,numQuests do
		qname = qfn(i);
		ret[i] = {name=qname};
	end
	return ret;
end

function TI_HandleGossipWindow(gorq)
	local SAcQ;
	local SAvQ;
	local AvailableQuests;
	local ActiveQuests;
	local GossipOptions;
	if(gorq == "g") then
		AvailableQuests = TI_TabulateGossipAvailableQuests(GetGossipAvailableQuests());
		ActiveQuests = TI_TabulateGossipActiveQuests(GetGossipActiveQuests());
		GossipOptions = TI_TabulateGossipOptions(GetGossipOptions());
		SAcQ = SelectGossipActiveQuest;
		SAvQ = SelectGossipAvailableQuest;
	elseif(gorq == "q") then
		AvailableQuests = TI_GetQuests("Available");
		ActiveQuests = TI_GetQuests("Active");
		GossipOptions = {};
		SAcQ=SelectActiveQuest;
		SAvQ=SelectAvailableQuest;
	end
	
	
	
	local ListEntry = {};
	for i,v in ipairs(AvailableQuests) do
		local x={};
		x.name = v.name;
		x.gorq = gorq;
		x.args = i;
		x.type = "availquest";
		x.icon = v.icon;
		x.state = false;
		table.insert(ListEntry, x);
	end
	for i,v in ipairs(ActiveQuests) do
		local x={};
		x.name = v.name;
		x.gorq = gorq;
		x.args = i;
		x.type = "activequest";
		x.icon = v.icon;
		x.state = false;
		table.insert(ListEntry, x);
	end
	for i,v in ipairs(GossipOptions) do
		local x={};
		x.name = v.name;
		x.gorq = gorq;
		x.args = i;
		x.type = v.type;
		x.state = false;
		table.insert(ListEntry, x);
	end
	ListEntry.state = false;
	
	
	local TotalOptions = #AvailableQuests+#ActiveQuests+#GossipOptions;
	--if(TI_activenumber > ActiveQuests.getn()) TI_activenumber = 1;
	if(TotalOptions < 1) then
		return;
	end
	
	
	local npcname = UnitName("npc");
	TI_AddNPCToTempList(npcname, ListEntry);
	
	if(TI_status.autoadd and (not TI_NPCDB[npcname])) then
		TI_debug("autoadd on, adding this NPC", TI_status.autoadd, TI_NPCDB[npcname]);
		TI_AddNPCToList(ListEntry, npcname);
	end	
	
	-- If a NPC is in the Database but a new dialog option has appeared (new daily/completed quest) then add it to the DB
	if (TI_NPCDB[npcname]) then
		for k1, v1 in ipairs(ListEntry) do
			local found = false;
			for k2, v2 in ipairs(TI_NPCDB[npcname]) do
				if (v2.type == v1.type and v2.name == v1.name) then
					found = true;
				end
			end
			if (not found) then
				table.insert(TI_NPCDB[npcname], v1)
				TI_PopulateOptions("npclist updated");
			end
		end
	end
	
	if(TI_availnumber > TotalOptions or TI_activenumber > TotalOptions) then
		TI_ResetPointers();
		return;
	end
	
	
	TI_debug(npcname);
	if(TI_NPCDB[npcname]) then
		local thisnpc = TI_NPCDB[npcname];
		if(thisnpc.state) then
			TI_debug("npc is active, using his options");
			for i1,current in ipairs(thisnpc) do
				if (current.state == true) then
					TI_debug("Current Quest: "..current.name);
					if (TI_specnum == 0 or i1 > TI_specnum) then
						TI_specnum = i1;
						if (current.type == "availquest") then
							for i2,v2 in ipairs(AvailableQuests) do
								if (v2.name == current.name) then
									TI_debug(i1.."-Available Match Found: "..current.name);
									TI_FunctionList[current.gorq]["availquest"](i2);
									return;
								end
							end
						elseif (current.type == "activequest") then
							for i2,v2 in ipairs(ActiveQuests) do
								if (v2.name == current.name) then
									TI_debug(i1.."-Active Match Found: "..current.name..", "..current.type);
									TI_FunctionList[current.gorq]["activequest"](i2);
									return;
								end
							end
						elseif (current.type == "gossip") then
							for i2,v2 in ipairs(GossipOptions) do
								if (v2.name == current.name) then
									SelectGossipOption(i2);
									return;
								end
							end
						end
					end
				end
			end
			return;
		else
			TI_debug("npc in list, but not active");
		end
	else
		TI_debug("npc not in list");
	end
	if(TI_status.usedefault == false) then
		TI_debug("npc not in list, default set to off, returning.");
		return;
	end;
	TI_debug("using default config");
	for i,current in ipairs(TI_status.options) do
		if(current.state) then
			if(current.type == "availquest" and #AvailableQuests > 0 and TI_availnumber <= #AvailableQuests) then
				TI_availnumber = TI_availnumber + 1;
				SAvQ(TI_availnumber-1);
				TI_debug("Selecting Available Quest ".. TI_availnumber-1);
				return;
			elseif(current.type == "activequest" and #ActiveQuests > 0 and TI_activenumber <= #ActiveQuests) then
				TI_activenumber = TI_activenumber + 1;
				SAcQ(TI_activenumber-1);
				TI_debug("Selecting Active Quest ".. TI_activenumber-1);
				return;
			elseif(#GossipOptions > 0) then
				for j,val in ipairs(GossipOptions) do
					if(val.type == current.type) then
						TI_ResetPointers();
						SelectGossipOption(j);
						return;
					end
				end
			end
		end
	end
	
end

function TI_AddNPCToList(OptList, npcname, confirminquestion)	
	if (npcname == nil) then
		npcname = UnitName("npc");
	end
	if(#OptList > 0) then
		if(TI_NPCDB[npcname] == nil) then
			TI_NPCDB[npcname] = TI_copyTable(OptList);
			table.insert(TI_NPCIndex, npcname);
			table.sort(TI_NPCIndex);
			TI_PopulateOptions("npclist updated");
		elseif(confirminquestion == true) then
			TI_NPCDB[npcname] = TI_copyTable(OptList);
			TI_PopulateOptions("npclist updated");
		else
			TI_NPCInQuestion = {name=npcname, list=OptList};
			StaticPopup_Show("TI_NPCINQUESTION", npcname);
		end
	end
end


function TI_AddNPCToTempList(name, list)
	local temp = {};
	temp.name = name;
	temp.list = list;
	temp.location = GetSubZoneText() .. ", " .. GetRealZoneText();
	table.insert(TI_TempNPCList, 1, temp);
	if(#TI_TempNPCList > TI_TempNPCListMaxSize) then
		table.remove(TI_TempNPCList, TI_TempNPCListMaxSize);
	end
	TI_TempNPCListUpdate();
end

function TI_DeleteTempNPCIndex(index)
	table.remove(TI_TempNPCList, index);
	TI_TempNPCListUpdate();
end

function TI_AddTempNPCIndex(index)
	TI_AddNPCToList(TI_TempNPCList[index].list, TI_TempNPCList[index].name);
end

function TI_DeleteNPC(index)
	local name = TI_NPCIndex[index];
	table.remove(TI_NPCIndex, index);
	TI_NPCDB[name] = nil;
end

function TI_StripDescriptors(...)
	local x = {};
	local arg = {...};
	for i=1, #arg, 2 do
		table.insert(x,arg[i]);
	end
	return x;
end

function TI_TabulateGossipOptions(...)
	local x = {};
	local arg = {...};
	for i=1, #arg, 2 do
		local temp = {};
		temp.name = arg[i];
		temp.type = arg[i+1];
		table.insert(x, temp);
	end
	return x;
end

function TI_TabulateGossipAvailableQuests(...)
	local x = {};
	
	for i=1, select("#", ...), 5 do
		local temp = {};
		temp.name = select(i, ...);
		
		isTrivial = select(i+2, ...);
		isDaily = select(i+3, ...);
		isRepeatable = select(i+4, ...);
		if ( isDaily ) then
			temp.icon = "Interface\\GossipFrame\\DailyQuestIcon";
		elseif ( isRepeatable ) then
			temp.icon = "Interface\\GossipFrame\\DailyActiveQuestIcon";
		else
			temp.icon = "Interface\\GossipFrame\\AvailableQuestIcon";
		end
		
		table.insert(x, temp);
	end
	return x;
end

function TI_TabulateGossipActiveQuests(...)
	local x = {};
	
	for i=1, select("#", ...), 4 do
		local temp = {};
		temp.name = select(i, ...);
		
		isComplete = select(i+3, ...);
		if(isComplete) then
			temp.icon = "Interface\\GossipFrame\\ActiveQuestIcon";
		else
			temp.icon = "Interface\\GossipFrame\\IncompleteQuestIcon";
		end
		
		table.insert(x, temp);
	end
	return x;
end
	
--[[this function stolen from WhisperCast by Sarris, whom I love dearly for his contribution to Paladins everywhere. 
]]
function TI_copyTable( src )
    local copy = {}
    for k1,v1 in pairs(src) do
        if ( type(v1) == "table" ) then
            copy[k1]=TI_copyTable(v1)
        else
            copy[k1]=v1
        end
    end
    
    return copy
end


function toggle(arg)
	if(arg) then
		return false;
	else
		return true;
	end
end