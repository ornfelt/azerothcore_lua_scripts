--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Skill_OnGossip(Unit, Event, player)
Unit:GossipCreateMenu(3544, player, 0)
Unit:GossipMenuAddItem(6, "Teach me all", 1, 0)
Unit:GossipMenuAddItem(1, "Server is Live and hosted", 2, 0)
Unit:GossipSendMenu(player)
 end

function Skill_onselect(Unit, event, player, id, intid, code)

if(intid == 1) then
Unit:SendChatMessage(12, 0, "You have Maxed out your Skills.")
        player:LearnSpell(201)
	player:LearnSpell(202)
	player:LearnSpell(196)
	player:LearnSpell(197)
	player:LearnSpell(264)
	player:LearnSpell(5011)
	player:LearnSpell(266)
	player:LearnSpell(198)
	player:LearnSpell(199)
	player:LearnSpell(674)
	player:LearnSpell(227)
	player:LearnSpell(1180)
	player:LearnSpell(2567)
	player:LearnSpell(750)
	player:LearnSpell(200)
	player:LearnSpell(15590)
	player:LearnSpell(8737)
	player:AdvanceSkill (43, 399)
        player:AdvanceSkill (55, 399)
        player:AdvanceSkill (44, 399)
        player:AdvanceSkill (172, 399)
        player:AdvanceSkill (54, 399)
        player:AdvanceSkill (160, 399)
        player:AdvanceSkill (136, 399)
        player:AdvanceSkill (162, 399)
        player:AdvanceSkill (176, 399)
        player:AdvanceSkill (228, 399)
        player:AdvanceSkill (173, 399)
        player:AdvanceSkill (46, 399)
        player:AdvanceSkill (45, 399)
        player:AdvanceSkill (226, 399)
        player:AdvanceSkill (473, 399)
        player:AdvanceSkill (229, 399)
        player:AdvanceSkill (171, 399)
        player:AdvanceSkill (755, 399)
        player:AdvanceSkill (164, 399)
        player:AdvanceSkill (165, 399)
        player:AdvanceSkill (333, 399)
        player:AdvanceSkill (186, 399)
        player:AdvanceSkill (202, 399)
        player:AdvanceSkill (773, 399)
        player:AdvanceSkill (182, 399)
        player:AdvanceSkill (393, 399)
        player:AdvanceSkill (197, 399)
        player:AdvanceSkill (185, 399)
        player:AdvanceSkill (356, 399)
        player:AdvanceSkill (129, 399)
Unit:GossipComplete(player)
end

if(intid == 2) then
player:GossipComplete(player)
end
end



RegisterUnitGossipEvent(900000, 1, "Skill_OnGossip")
RegisterUnitGossipEvent(900000, 2, "Skill_onselect")