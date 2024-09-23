local Class = {}
Class.__index = Class

local Opcodes = require(workspace.Opcodes)
local Bit = require(workspace.Bit);
function Class.new(name, unit)
	local self = {}
	setmetatable(self, Class)
	
	self.name = name
	self.unit = unit
	self.spec = "Arcane";
	self.m_spellList = {};
	self.m_keyBindings = {
		
		["1"] = { -- Row 1
			"1", "2", "3", "4", "5", "6", "7", "8", "f"
		},
		["2"] = { -- Row 2
			"q", "e", "c", "g"
		}
	}
	
	return self
end

function Class:UpdateBinds(binds)
	for _,v in next, binds do
		local spellId = v.spellId;
		local spell = self.m_spellList[tostring(spellId)];
		if spell ~= nil then
			spell.m_keyBinding = v.bind;
			print(v.bind, spell.m_keyBinding);
		end
	end
	self:UpdateClient();
end

function Class:UpdateBind(spellId, bind)
	self.m_spellList[tostring(spellId)].m_keyBinding = bind;
	self:UpdateClient();
end

function Class:Load()
	local classSpells = workspace.Database.characters.character_classspells:findFirstChild(self.name).Base;
	if classSpells then
		-- Now we need spec
		local specSpells = workspace.Database.characters.character_classspells[self.name]:findFirstChild(self.spec);
		if specSpells ~= nil then
			local spells = {}
			for _,v in next, specSpells:GetChildren() do
				table.insert(spells, {spell = v, spot = "Spec"});
			end
			
			for _,v in next,classSpells:GetChildren() do
				table.insert(spells, {spell = v, spot = "Class"});
			end
			for i,v in next, spells do
				local spell = v.spell
				local spellId = tostring(spell.Value)
				local spellInfo = game.Lighting.Spells:findFirstChild(spellId)
				self.m_spellList[spellId] = {};
				self.m_spellList[spellId].m_cooldownTime = 0;
				self.m_spellList[spellId].spellInfo = spellInfo;
				self.m_spellList[spellId].m_spellId = tonumber(spellId);
				self.m_spellList[spellId].m_keyBinding = "nil";
				self.m_spellList[spellId].spellImage = spellInfo.ImageButton.Image;
				self.m_spellList[spellId].spellName = spellInfo.SpellName.Value;
				self.m_spellList[spellId].m_castable = true
				self.m_spellList[spellId].m_interruptFlags = 0;
				self.m_spellList[spellId].m_spellAttributes = 0;
				self.m_spellList[spellId].m_inBook = true;
				self.m_spellList[spellId].spellDesc = spellInfo.Description.Value;
				self.m_spellList[spellId].spellSpot = v.spot;
				
				local InterruptFlagsFolder = spellInfo:FindFirstChild("InterruptFlags")
				if InterruptFlagsFolder then
					for _, interruptFlag in next, InterruptFlagsFolder:GetChildren() do
						if interruptFlag:IsA("IntValue") then
							self.m_spellList[spellId].m_interruptFlags = Bit.OR(self.m_spellList[spellId].m_interruptFlags, interruptFlag.Value)
						end
					end
				end
				
				local SpellAttributesFolder = spellInfo:FindFirstChild("SpellAttributes")
				if SpellAttributesFolder then
					for _, spellAttr in next, SpellAttributesFolder:GetChildren() do
						if spellAttr:IsA("IntValue") then
							self.m_spellList[spellId].m_spellAttributes = Bit.OR(self.m_spellList[spellId].m_spellAttributes, spellAttr.Value)
							
							if spellAttr.Name == "SPELL_ATTR_NOT_IN_SPELLBOOK" then
								self.m_spellList[spellId].m_inBook = false;
							end
						end
					end
				end
				
				
				
				local success, charges = pcall(function()
					return spellInfo.Charges
				end)
				
				local success2, customGCD = pcall(function()
					return spellInfo.CustomGCD
				end)
				
				if success then
					self.m_spellList[spellId].Charges = spellInfo:findFirstChild'Charges'.Value;
				end
				if success2 then
					self.m_spellList[spellId].CustomGCD = 0;
				end
			end
		end
	end
	
	-- Update client binds
	self:UpdateClient();
	self:UpdateBook();
end

function Class:UpdateBook()
	if self.unit.link:IsA("Player") then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_LOAD_SPELLBOOK");
		packet:FireClient(self.unit.link, data);
	end
end

function Class:UpdateClient()
	-- Send update class opcode
	if self.unit.link:IsA("Player") then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_LOAD_CLASS");
		data.SpellList = self.m_spellList;
		data.Name = self.name
		packet:FireClient(self.unit.link, data);
	end
end

function Class:GetSpellList()
	return self.m_spellList
end

function Class:GetSpellData(spellId)
	return self.m_spellList(tostring(spellId));
end

return Class
