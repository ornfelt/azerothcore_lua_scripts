--[[
Name: Temp Menu
Version: 1.0.0
Made by: MadBuffoon
Notes: Blank

]]

local enabled = true
local GossipID = 9920006
local MorphsTable = {
	{"Demorph", 0},
    {"Sally", 2043},
    {"New Thrall", 4527},
    {"Old Thrall", 27656},
    {"Cairne", 4307},
    {"Velen", 17822},
    {"Sylvanas", 28213},
    {"Vol'jin", 10357},
    {"Anduin", 11655},
    {"Magni", 3597},
    {"Tyrande", 7274},
    {"Jaina", 2970},
    {"Varian", 28127},
    {"Bolvar", 5566},
    {"Old Tirion", 9477},
    {"New Tirion", 31011},
    {"Vereesa", 28222},
    {"Rhonin", 16024},
    {"Putress", 27611},
    {"Alexstrasza", 28227},
    {"Chromie", 24877},
    {"Arthas", 24949},
    {"Lich King", 22234},
    {"Saurfang", 14732},
    {"Onyxia", 8570},
    {"Kloveriell", 1000179},
    {"Dark Ranger", 30073},
    {"Millhouse", 19942},
	{"Alleria", 70019}, -- remove me if not using my server
	{"Turalyon", 400018}, -- remove me if not using my server
}
--(Start) The Gossip Menu that shows Main Menu
function Morph_MenuMenuGossip(event, player)
	for i, v in ipairs(MorphsTable) do
            player:GossipMenuAddItem(0, v[1], v[2], 0)
    end

	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 9999)		
	player:GossipSendMenu(1, player, GossipID)
end
--(End)

--(Start)
local function OnSelect(event, player, _, sender, intid, code)
	if player:IsInCombat() then
        return
    end
	
	for i, v in ipairs(MorphsTable) do
		if sender == v[2] then
			if v[2] == 0 then
				-- Demorph
				player:SetDisplayId(player:GetNativeDisplayId())
			else
				-- Morph
				player:SetDisplayId(v[2])
				player:CastSpell(player, 51908, true) -- Cast the morph spell
			end
			player:GossipComplete()
			return
		end
    end
	
	if(intid == 9999) then --Back
		OtherMenuGossip(event, player)
		return false
	end
end
--(End)

if enabled then
RegisterPlayerGossipEvent(GossipID, 2, OnSelect)
end

