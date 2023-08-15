--[[ Weapon Trainer By Reflexiz ]]--
 
local NPCID = 521512
 
function Trainer_OnGossip(unit, event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(0, "Learn Weapon Skills.", 0, 0)
unit:GossipMenuAddItem(0, "Advance All Weapon Skills", 1, 0)
 
unit:GossipSendMenu(player)
end
 
function Trainer_SubMenus(unit, event, player, id, intid, code)
if(intid == 0) then --[Learn Weapon Skills]--
unit:GossipCreateMenu(101, player, 0)
player:LearnSpell(201) -- One-Handed Swords
player:LearnSpell(202) -- Two-Handed Swords
player:LearnSpell(196) -- One-Handed Axes
player:LearnSpell(197) -- Two-Handed Axes
player:LearnSpell(227) -- Staves
player:LearnSpell(200) -- Polearms
player:LearnSpell(266) -- Guns
player:LearnSpell(264) -- Bows
player:LearnSpell(5011) -- Crossbows
player:LearnSpell(3018) -- Shoot (Bow, Crossbow or Gun)
player:LearnSpell(198) -- One-Handed Maces
player:LearnSpell(199) -- Two-Handed Maces
player:LearnSpell(1180) -- Daggers
player:LearnSpell(2567) -- Thrown
player:LearnSpell(2764) -- Throw (With Thrown)
player:LearnSpell(5009) -- Wands
player:LearnSpell(5019) -- Shoot (Wands)
player:GossipComplete()
end
 
if(intid == 1) then --[Advance Skills]--
unit:GossipCreateMenu(102, player, 0)
player:AdvanceSkill (43, 399)
player:AdvanceSkill (44, 399)
player:AdvanceSkill (45, 399)
player:AdvanceSkill (46, 399)
player:AdvanceSkill (54, 399)
player:AdvanceSkill (55, 399)  
player:AdvanceSkill (136, 399)
player:AdvanceSkill (160, 399)
player:AdvanceSkill (172, 399)
player:AdvanceSkill (173, 399)
player:AdvanceSkill (176, 399)
player:AdvanceSkill (226, 399)
player:AdvanceSkill (228, 399)
player:AdvanceSkill (229, 399)
player:AdvanceSkill (473, 399)
player:GossipComplete()
end
end
 
 
RegisterUnitGossipEvent(512512, 1,"Trainer_OnGossip")
RegisterUnitGossipEvent(512512, 2,"Trainer_SubMenus")