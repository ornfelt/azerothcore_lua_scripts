--[[

     This Statue Lua is brought to you by zdroid9770
     
                © Copyright 2011
]]



local NPCID = STATUE NPC ID HERE!

local OBJECT_END = 0x0006
local UNIT_FIELD_FLAGS = OBJECT_END + 0x0035 -- Size: 1, Type: INT, Flags: PUBLIC
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000 -- 26    33554432  cannot select the unit


function Statue_OnSpawn(pUnit, event)
	pUnit:FullCastSpell(15533)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(*NPC_ID*, 18, "Statue_OnSpawn")