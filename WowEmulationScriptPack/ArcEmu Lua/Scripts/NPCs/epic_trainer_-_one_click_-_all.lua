local TrainerEntryID = ENTRYID -- Change with your NPC EntryID
 
function TrainerLocal(pUnit, event)
        Trainer = pUnit
end
 
RegisterUnitEvent(TrainerEntryID, 18, "TrainerLocal")
 
function Trainer_OnTalk(pUnit, event, player)
Trainer:GossipCreateMenu(1, player, 0)
Trainer:GossipMenuAddItem(5, "Learn Class Spells.", 100, 0)
Trainer:GossipMenuAddItem(5, "Maxim Weapon Skills.", 200, 0)
Trainer:GossipMenuAddItem(5, "Learn Talent Spells.", 300, 0)
Trainer:GossipMenuAddItem(5, "Reset All Talent Points.", 400, 0)
Trainer:GossipMenuAddItem(5, "I was looking for something else.", 485, 0)
Trainer:GossipSendMenu(player)
end
 
function Trainer_OnSubmenus(pUnit, event, player, id, intid, code)
 
if(intid == 100) then
    Trainer:GossipCreateMenu(54, player, 0)
        if (player:GetPlayerClass() == "Warrior") then
                Trainer:GossipMenuAddItem(0, "Learn all Warrior Spells.", 50, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
                                
        end
        if (player:GetPlayerClass() == "Paladin") then
                Trainer:GossipMenuAddItem(0, "Learn all Paladin Spells.", 51, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Hunter") then
                Trainer:GossipMenuAddItem(0, "Learn all Hunter Spells.", 52, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Rogue") then
                Trainer:GossipMenuAddItem(0, "Learn all Rogue Spells.", 53, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Priest") then
                Trainer:GossipMenuAddItem(0, "Learn all Priest Spells.", 54, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Death Knight") then
                Trainer:GossipMenuAddItem(0, "Learn all Death Knight Spells.", 55, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Shaman") then
                Trainer:GossipMenuAddItem(0, "Learn all Shaman Spells.", 56, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Mage") then
                Trainer:GossipMenuAddItem(0, "Learn all Mage Spells.", 57, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Warlock") then
                Trainer:GossipMenuAddItem(0, "Learn all Warlock Spells.", 58, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Druid") then
                Trainer:GossipMenuAddItem(0, "Learn all Druid Spells.", 59, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        Trainer:GossipSendMenu(player)
end
 
--[Warrior Spells]--
if (intid == 50) then
        player:LearnSpell(6673) -- Battle Shout [Rank 1]
        player:LearnSpell(5242) -- Battle Shout [Rank 2]
        player:LearnSpell(6192) -- Battle Shout [Rank 3]
        player:LearnSpell(11549) -- Battle Shout [Rank 4]
        player:LearnSpell(11550) -- Battle Shout [Rank 5]
        player:LearnSpell(11551) -- Battle Shout [Rank 6]
        player:LearnSpell(25289) -- Battle Shout [Rank 7]
        player:LearnSpell(2048) -- Battle Shout [Rank 8]
        player:LearnSpell(47436) -- Battle Shout  [Rank 9]
        player:LearnSpell(18499) -- Beserker Rage
        player:LearnSpell(2458) -- Beserker Stance
        player:LearnSpell(2687) -- Bloodrage
        player:LearnSpell(1161) -- Challenging Shout
        player:LearnSpell(100) -- Charge [Rank 1]
        player:LearnSpell(6178) -- Charge [Rank 2]
        player:LearnSpell(11578) -- Charge [Rank 3]
        player:LearnSpell(845) -- Cleave [Rank 1]
        player:LearnSpell(7369) -- Cleave [Rank 2]
        player:LearnSpell(11608) -- Cleave [Rank 3]
        player:LearnSpell(11609) -- Cleave [Rank 4]
        player:LearnSpell(20569) -- Cleave [Rank 5]
        player:LearnSpell(25231) -- Cleave [Rank 6]
        player:LearnSpell(47519) -- Cleave [Rank 7]
        player:LearnSpell(47520) -- Cleave [Rank 8]
        player:LearnSpell(469) -- Commanding Shout [Rank 1]
        player:LearnSpell(47439) -- Commanding Shout [Rank 2]
        player:LearnSpell(47440) -- Commanding Shout  [Rank 3]
        player:LearnSpell(71) -- Defensive Stance
        player:LearnSpell(1160) -- Demoralizing Shout [Rank 1]
        player:LearnSpell(6190) -- Demoralizing Shout [Rank 2]
        player:LearnSpell(11554) -- Demoralizing Shout [Rank 3]
        player:LearnSpell(11555) -- Demoralizing Shout [Rank 4]
        player:LearnSpell(11556) -- Demoralizing Shout [Rank 5]
        player:LearnSpell(25202) -- Demoralizing Shout [Rank 6]
        player:LearnSpell(25203) -- Demoralizing Shout [Rank 7]
        player:LearnSpell(47437) -- Demoralizing Shout [Rank 8]
        player:LearnSpell(676) -- Disarm
        player:LearnSpell(55694) -- Enraged Regeneration
        player:LearnSpell(5308) -- Execute [Rank 1]
        player:LearnSpell(20658) -- Execute [Rank 2]
        player:LearnSpell(20660) -- Execute [Rank 3]
        player:LearnSpell(20661) -- Execute [Rank 4]
        player:LearnSpell(20662) -- Execute [Rank 5]
        player:LearnSpell(25234) -- Execute [Rank 6]
        player:LearnSpell(25236) -- Execute [Rank 7]
        player:LearnSpell(47470) -- Execute [Rank 8]
        player:LearnSpell(47471) -- Execute [Rank 9]
        player:LearnSpell(1715) -- Hamstring
        player:LearnSpell(284) -- Heroic Strike [Rank 2]
        player:LearnSpell(1608) -- Heroic Strike [Rank 4]
        player:LearnSpell(11564) -- Heroic Strike [Rank 5]
        player:LearnSpell(11565) -- Heroic Strike [Rank 6]
        player:LearnSpell(11566) -- Heroic Strike [Rank 7]
        player:LearnSpell(11567) -- Heroic Strike [Rank 8]
        player:LearnSpell(25286) -- Heroic Strike [Rank 9]
        player:LearnSpell(29707) -- Heroic Strike [Rank 10]
        player:LearnSpell(30324) -- Heroic Strike [Rank 11]
        player:LearnSpell(47449) -- Heroic STrike [Rank 12]
        player:LearnSpell(47450) -- Heroic Strike [Rank 13]
        player:LearnSpell(57755) -- Heroic Throw
        player:LearnSpell(20252) -- Intercept
        player:LearnSpell(3411) -- Intervene
        player:LearnSpell(5246) -- Intimidating Shout
        player:LearnSpell(694) -- Mocking Blow
        player:LearnSpell(7384) -- Overpower
        player:LearnSpell(6552) -- Pummel
        player:LearnSpell(1719) -- Recklessness
        player:LearnSpell(772) -- Rend [Rank 1]
        player:LearnSpell(6546) -- Rend [Rank 2]
        player:LearnSpell(6547) -- Rend [Rank 3]
        player:LearnSpell(6548) -- Rend [Rank 4]
        player:LearnSpell(11572) -- Rend [Rank 5]
        player:LearnSpell(11573) -- Rend [Rank 6]
        player:LearnSpell(11574) -- Rend [Rank 7]
        player:LearnSpell(25208) -- Rend [Rank 8]
        player:LearnSpell(46845) -- Rend [Rank 9]
        player:LearnSpell(47471) -- Rend [Rank 10]
        player:LearnSpell(20230) -- Retaliation
        player:LearnSpell(6572) -- Revenge [Rank 1]
        player:LearnSpell(6574) -- Revenge [Rank 2]
        player:LearnSpell(7379) -- Revenge [Rank 3]
        player:LearnSpell(11600) -- Revenge [Rank 4]
        player:LearnSpell(11601) -- Revenge [Rank 5]
        player:LearnSpell(25288) -- Revenge [Rank 6]
        player:LearnSpell(25269) -- Revenge [Rank 7]
        player:LearnSpell(30357) -- Revenge [Rank 8]
        player:LearnSpell(57823) -- Revenge  [Rank 9]
        player:LearnSpell(64382) -- Shattering Throw
        player:LearnSpell(72) -- Shield Bash
        player:LearnSpell(2565) -- Shield Block
        player:LearnSpell(23922) -- Shield Slam [Rank 1]
        player:LearnSpell(23923) -- Shield Slam [Rank 2]
        player:LearnSpell(23924) -- Shield Slam [Rank 3]
        player:LearnSpell(23925) -- Shield Slam [Rank 4]
        player:LearnSpell(25258) -- Shield Slam [Rank 5]
        player:LearnSpell(30356) -- Shield Slam [Rank 6]
        player:LearnSpell(47487) -- Shield Slam [Rank 7]
        player:LearnSpell(47488) -- Shield Slam [Rank 8]
        player:LearnSpell(871) -- Shield Wall
        player:LearnSpell(1464) -- Slam [Rank 1]
        player:LearnSpell(8820) -- Slam [Rank 2]
        player:LearnSpell(11604) -- Slam [Rank 3]
        player:LearnSpell(11605) -- Slam [Rank 4]
        player:LearnSpell(25241) -- Slam [Rank 5]
        player:LearnSpell(25242) -- Slam [Rank 6]
        player:LearnSpell(47474) -- Slam [Rank 7]
        player:LearnSpell(47475) -- Slam [Rank 8]
        player:LearnSpell(23920) -- Spell Reflection
        player:LearnSpell(12678) -- Stance Mastery
        player:LearnSpell(7386) -- Sunder Armor
        player:LearnSpell(355) -- Taunt
        player:LearnSpell(6343) -- Thunder Clap [Rank 1]
        player:LearnSpell(8198) -- Thunder Clap [Rank 2]
        player:LearnSpell(8204) -- Thunder Clap [Rank 3]
        player:LearnSpell(8205) -- Thunder Clap [Rank 4]
        player:LearnSpell(11580) -- Thunder Clap [Rank 5]
        player:LearnSpell(11581) -- Thunder Clap [Rank 6]
        player:LearnSpell(25264) -- Thunder Clap [Rank 7]
        player:LearnSpell(47501) -- Thunder Clap [Rank 8]
        player:LearnSpell(47502) -- Thunder Clap [Rank 9]
        player:LearnSpell(34428) -- Victory Rush
        player:LearnSpell(1680) -- Whirlwind
        player:GossipComplete()
end -- End Warrior Spells
 
if (intid == 51) then
--[Paladin Spells]--
        player:LearnSpell(31884) -- Avenging Wrath
        player:LearnSpell(20217) -- Blessing of Kings
        player:LearnSpell(19740) -- Blessing of Might [Rank 1]
        player:LearnSpell(19834) -- Blessing of Might [Rank 2]
        player:LearnSpell(19835) -- Blessing of Might [Rank 3]
        player:LearnSpell(19836) -- Blessing of Might [Rank 4]
        player:LearnSpell(10937) -- Blessing of Might [Rank 5]
        player:LearnSpell(19838) -- Blessing of Might [Rank 6]
        player:LearnSpell(25291) -- Blessing of Might [Rank 7]
        player:LearnSpell(27140) -- Blessing of Might [Rank 8]
        player:LearnSpell(48931) -- Blessing of Might [Rank 9]
        player:LearnSpell(48932) -- Blessing of Might [Rank 10]
        player:LearnSpell(19742) -- Blessing of Wisdom [Rank 1]
        player:LearnSpell(19850) -- Blessing of Wisdom [Rank 2]
        player:LearnSpell(19852) -- Blessing of Wisdom [Rank 3]
        player:LearnSpell(19853) -- Blessing of Wisdom [Rank 4]
        player:LearnSpell(19854) -- Blessing of Wisdom [Rank 5]
        player:LearnSpell(25290) -- Blessing of Wisdom [Rank 6]
        player:LearnSpell(48935) -- Blessing of Wisdom [Rank 8]
        player:LearnSpell(48936) -- Blessing of Wisdom [Rank 9]
                local race = player:GetPlayerRace()
                if race == 10 then
                        player:LearnSpell(34767) -- Summon Charger Horde
                elseif race == 1 or race == 3 or race == 11 then
                        player:LearnSpell(23214) -- Summon Charger Alliance
                end
        player:LearnSpell(4987) -- Cleanse
        player:LearnSpell(19746) -- Concentration Aura
        player:LearnSpell(26573) -- Consecration [Rank 1]
        player:LearnSpell(20116) -- Consecration [Rank 2]
        player:LearnSpell(20922) -- Consecration [Rank 3]
        player:LearnSpell(20923) -- Consecration [Rank 4]
        player:LearnSpell(20924) -- Consecration [Rank 5]
        player:LearnSpell(27173) -- Consecration [Rank 6]
        player:LearnSpell(48818) -- Consecration [Rank 7]
        player:LearnSpell(48810) -- Consecration [Rank 8]
        player:LearnSpell(32223) -- Crusader Aura
        player:LearnSpell(48942) -- Devotion Aura [Rank 10]
        player:LearnSpell(19752) -- Divine Intervention
        player:LearnSpell(54428) -- Divine Plea
        player:LearnSpell(498) -- Divine Protection
        player:LearnSpell(642) -- Divine Shield
        player:LearnSpell(879) -- Exorcism [Rank 1]
        player:LearnSpell(5614) -- Exorcism [Rank 2]
        player:LearnSpell(5615) -- Exorcism [Rank 3]
        player:LearnSpell(10312) -- Exorcism [Rank 4]
        player:LearnSpell(10313) -- Exorcism [Rank 5]
        player:LearnSpell(10314) -- Exorcism [Rank 6]
        player:LearnSpell(27138) -- Exorcism [Rank 7]
        player:LearnSpell(48800) -- Exorcism [Rank 8]
        player:LearnSpell(48801) -- Exorcism [Rank 9]
        player:LearnSpell(48947) -- Fire Resistance Aura [Rank 5]
        player:LearnSpell(19750) -- Flash of Light [Rank 1]
        player:LearnSpell(19939) -- Flash of Light [Rank 2]
        player:LearnSpell(19940) -- Flash of Light [Rank 3]
        player:LearnSpell(19941) -- Flash of Light [Rank 4]
        player:LearnSpell(19942) -- Flash of Light [Rank 5]
        player:LearnSpell(19943) -- Flash of Light [Rank 6]
        player:LearnSpell(27137) -- Flash of Light [Rank 7]
        player:LearnSpell(48784) -- Flash of Light [Rank 8]
        player:LearnSpell(48785) -- Flash of Light [Rank 9]
        player:LearnSpell(48945) -- Frost Resistance Aura [Rank 5]
        player:LearnSpell(25898) -- Greater Blessing of Kings
        player:LearnSpell(25782) -- Greater Blessing of Might [Rank 1]
        player:LearnSpell(25916) -- Greater Blessing of Might [Rank 2]
        player:LearnSpell(27141) -- Greater Blessing of Might [Rank 3]
        player:LearnSpell(48933) -- Greater Blessing of Might [Rank 4]
        player:LearnSpell(48934) -- Greater Blessing of Might [Rank 5]
        player:LearnSpell(25899) -- Greater Blessing of Sanctuary
        player:LearnSpell(25894) -- Greater Blessing of Wisdom [Rank 1]
        player:LearnSpell(25918) -- Greater Blessing of Wisdom [Rank 2]
        player:LearnSpell(27143) -- Greater Blessing of Wisdom [Rank 3]
        player:LearnSpell(48937) -- Greater Blessing of Wisdom [Rank 4]
        player:LearnSpell(48938) -- Greater Blessing of Wisdom [Rank 5]
        player:LearnSpell(853) -- Hammer of Justice [Rank 1]
        player:LearnSpell(5588) -- Hammer of Justice [Rank 2]
        player:LearnSpell(5589) -- Hammer of Justice [Rank 3]
        player:LearnSpell(10308) -- Hammer of Justice [Rank 4]
        player:LearnSpell(24275) -- Hammer of Wrath [Rank 1]
        player:LearnSpell(24274) -- Hammer of Wrath [Rank 2]
        player:LearnSpell(24239) -- Hammer of Wrath [Rank 3]
        player:LearnSpell(27180) -- Hammer of Wrath [Rank 4]
        player:LearnSpell(48805) -- Hammer of Wrath [Rank 5]
        player:LearnSpell(48806) -- Hammer of Wrath [Rank 6]
        player:LearnSpell(1044) -- Hand of Freedom
        player:LearnSpell(1022) -- Hand of Protection [Rank 1]
        player:LearnSpell(5599) -- Hand of Protection [Rank 2]
        player:LearnSpell(10278) -- Hand of Protection [Rank 3]
        player:LearnSpell(62124) -- Hand of Reckoning
        player:LearnSpell(6940) -- Hand of Sacrifice
        player:LearnSpell(1038) -- Hand of Salvation
        player:LearnSpell(639) -- Holy Light [Rank 2]
        player:LearnSpell(647) -- Holy Light [Rank 3]
        player:LearnSpell(1026) -- Holy Light [Rank 4]
        player:LearnSpell(1042) -- Holy Light [Rank 5]
        player:LearnSpell(3472) -- Holy Light [Rank 6]
        player:LearnSpell(10328) -- Holy Light [Rank 7]
        player:LearnSpell(10329) -- Holy Light [Rank 8]
        player:LearnSpell(25292) -- Holy Light [Rank 9]
        player:LearnSpell(27135) -- Holy Light [Rank 10]
        player:LearnSpell(27136) -- Holy Light [Rank 11]
        player:LearnSpell(48781) -- Holy Light [Rank 12]
        player:LearnSpell(48782) -- Holy Light [Rank 13]
        player:LearnSpell(2812) -- Holy Wrath [Rank 1]
        player:LearnSpell(10318) -- Holy Wrath [Rank 2]
        player:LearnSpell(27139) -- Holy Wrath [Rank 3]
        player:LearnSpell(48816) -- Holy Wrath [Rank 4]
        player:LearnSpell(48817) -- Holy Wrath [Rank 5]
        player:LearnSpell(53407) -- Judgement of Justice
        player:LearnSpell(20271) -- Judgement of Light
        player:LearnSpell(53408) -- Judgement of Wisdom
        player:LearnSpell(633) -- Lay on Hands [Rank 1]
        player:LearnSpell(2800) -- Lay on Hands [Rank 2]        
        player:LearnSpell(10310) -- Lay on Hands [Rank 3]
        player:LearnSpell(27154) -- Lay on Hands [Rank 4]
        player:LearnSpell(48788) -- Lay on Hands [Rank 5]
        player:LearnSpell(1152) -- Purify
        player:LearnSpell(7328) -- Redemption [Rank 1]
        player:LearnSpell(10322) -- Redemption [Rank 2]
        player:LearnSpell(10324) -- Redemption [Rank 3]
        player:LearnSpell(20772) -- Redemption [Rank 4]
        player:LearnSpell(20773) -- Redemption [Rank 5]
        player:LearnSpell(48949) -- Redemption [Rank 6]
        player:LearnSpell(48950) -- Redemption [Rank 7]
        player:LearnSpell(54043) -- Retribution Aura [Rank 7]
        player:LearnSpell(31789) -- Righteous Defense
        player:LearnSpell(25780) -- Righteous Fury
        player:LearnSpell(53601) -- Sacred Shield [Rank 1]
                local race = player:GetPlayerRace()
                if race == 10 then
                        player:LearnSpell(2825) -- Seal of Corruption
                elseif race == 1 or race == 3 or race == 11 then
                        player:LearnSpell(32182) -- Seal of Vengeance
                end
        player:LearnSpell(20164) -- Seal of Justice
        player:LearnSpell(20165) -- Seal of Light
        player:LearnSpell(21084) -- Seal of Righteousness
        player:LearnSpell(20166) -- Seal of Wisdom
        player:LearnSpell(48943) -- Shadow Resistance Aura [Rank 5]
        player:LearnSpell(5502) -- Sense Undead
        player:LearnSpell(53600) -- Shield of Righteousness [Rank 1]
        player:LearnSpell(61411) -- Shield of Righteousness [Rank 2]
        player:LearnSpell(10326) -- Turn Evil
                local race = player:GetPlayerRace()
                if race == 10 then
                        player:LearnSpell(34769) -- Summon Warhorse Horde
                elseif race == 1 or race == 3 or race == 11 then
                        player:LearnSpell(13819) -- Summon Warhorse Alliance
                end
        player:GossipComplete()
end -- End Paladin Spells
 
--[Hunter Spells]--
if (intid == 52) then
        player:LearnSpell(3044) -- Arcane Shot [Rank 1]
        player:LearnSpell(14281) -- Arcane Shot [Rank 2]
        player:LearnSpell(14281) -- Arcane Shot [Rank 2]
        player:LearnSpell(14282) -- Arcane Shot [Rank 3]
        player:LearnSpell(14283) -- Arcane Shot [Rank 4]
        player:LearnSpell(14284) -- Arcane Shot [Rank 5]
        player:LearnSpell(14285) -- Arcane Shot [Rank 6]
        player:LearnSpell(14286) -- Arcane Shot [Rank 7]
        player:LearnSpell(14287) -- Arcane Shot [Rank 8]
        player:LearnSpell(27019) -- Arcane Shot [Rank 9]
        player:LearnSpell(49044) -- Arcane Shot [Rank 10]
        player:LearnSpell(49045) -- Arcane Shot [Rank 11]
        player:LearnSpell(13161) -- Aspect of the Beast
        player:LearnSpell(5118) -- Aspect of the Cheetah
        player:LearnSpell(61846) -- Aspect of the Dragonhawk [Rank 1]
        player:LearnSpell(61847) -- Aspect of the Dragonhawk [Rank 2]
        player:LearnSpell(13165) -- Aspect of the Hawk [Rank 1]
        player:LearnSpell(14318) -- Aspect of the Hawk [Rank 2]
        player:LearnSpell(14319) -- Aspect of the Hawk [Rank 3]
        player:LearnSpell(14320) -- Aspect of the Hawk [Rank 4]
        player:LearnSpell(14321) -- Aspect of the Hawk [Rank 5]
        player:LearnSpell(14322) -- Aspect of the Hawk [Rank 6]
        player:LearnSpell(25296) -- Aspect of the Hawk [Rank 7]
        player:LearnSpell(27044) -- Aspect of the Hawk [Rank 8]
        player:LearnSpell(13163) -- Aspect of the Monkey
        player:LearnSpell(13159) -- Aspect of the Pack
        player:LearnSpell(34074) -- Aspect of the Viper
        player:LearnSpell(20043) -- Aspect of the Wild [Rank 1]
        player:LearnSpell(20190) -- Aspect of the Wild [Rank 2]
        player:LearnSpell(27045) -- Aspect of the Wild [Rank 3]
        player:LearnSpell(49071) -- Aspect of the Wild [Rank 4]
        player:LearnSpell(1462) -- Beast Lore
        player:LearnSpell(883) -- Call Pet
        player:LearnSpell(62757) -- Call Stabled Pet
        player:LearnSpell(5116) -- Concussive Shot
        player:LearnSpell(19263) -- Deterrence
        player:LearnSpell(781) -- Disengage
        player:LearnSpell(2641) -- Dismiss Pet
        player:LearnSpell(20736) -- Distracting Shot [Rank 1]
        player:LearnSpell(6197) -- Eagle Eye
        player:LearnSpell(13813) -- Explosive Trap [Rank 1]
        player:LearnSpell(14316) -- Explosive Trap [Rank 2]
        player:LearnSpell(14317) -- Explosive Trap [Rank 3]
        player:LearnSpell(27025) -- Explosive Trap [Rank 4]
        player:LearnSpell(49066) -- Explosive Trap [Rank 5]
        player:LearnSpell(49067) -- Explosive Trap [Rank 6]
        player:LearnSpell(1002) -- Eyes of the Beast
        player:LearnSpell(6991) -- Feed Pet
        player:LearnSpell(5384) -- Feign Death
        player:LearnSpell(1543) -- Flare
        player:LearnSpell(60192) -- Freezing Arrow [Rank 1]
        player:LearnSpell(1499) -- Freezing Trap [Rank 1]
        player:LearnSpell(14310) -- Freezing Trap [Rank 2]
        player:LearnSpell(14311) -- Freezing Trap [Rank 3]
        player:LearnSpell(13809) -- Frost Trap
        player:LearnSpell(1130) -- Hunter's Mark [Rank 1]
        player:LearnSpell(14323) -- Hunter's Mark [Rank 2]
        player:LearnSpell(14324) -- Hunter's Mark [Rank 3]
        player:LearnSpell(14325) -- Hunter's Mark [Rank 4]
        player:LearnSpell(53338) -- Hunter's Mark [Rank 5]
        player:LearnSpell(13795) -- Immolation Trap [Rank 1]
        player:LearnSpell(14302) -- Immolation Trap [Rank 2]
        player:LearnSpell(14303) -- Immolation Trap [Rank 3]
        player:LearnSpell(14304) -- Immolation Trap [Rank 4]
        player:LearnSpell(14305) -- Immolation Trap [Rank 5]
        player:LearnSpell(27023) -- Immolation Trap [Rank 6]
        player:LearnSpell(49055) -- Immolation Trap [Rank 7]
        player:LearnSpell(49056) -- Immolation Trap [Rank 8]
        player:LearnSpell(34026) -- Kill Command
        player:LearnSpell(53351) -- Kill Shot [Rank 1]
        player:LearnSpell(61005) -- Kill Shot [Rank 2]
        player:LearnSpell(61006) -- Kill Shot [Rank 3]
        player:LearnSpell(53271) -- Master's Call
        player:LearnSpell(136) -- Mend Pet [Rank 1]
        player:LearnSpell(3111) -- Mend Pet [Rank 2]
        player:LearnSpell(3661) -- Mend Pet [Rank 3]
        player:LearnSpell(3662) -- Mend Pet [Rank 4]
        player:LearnSpell(13542) -- Mend Pet [Rank 5]
        player:LearnSpell(13543) -- Mend Pet [Rank 6]
        player:LearnSpell(13544) -- Mend Pet [Rank 7]
        player:LearnSpell(27046) -- Mend Pet [Rank 8]
        player:LearnSpell(48989) -- Mend Pet [Rank 9]
        player:LearnSpell(48990) -- Mend Pet [Rank 10]
        player:LearnSpell(34477) -- Misdirection
        player:LearnSpell(1495) -- Mongoose Bite [Rank 1]
        player:LearnSpell(14269) -- Mongoose Bite [Rank 2]
        player:LearnSpell(14270) -- Mongoose Bite [Rank 3]
        player:LearnSpell(14271) -- Mongoose Bite [Rank 4]
        player:LearnSpell(36916) -- Mongoose Bite [Rank 5]
        player:LearnSpell(53339) -- Mongoose Bite [Rank 6]
        player:LearnSpell(2643) -- Multi-Shot [Rank 1]
        player:LearnSpell(14288) -- Multi-Shot [Rank 2]
        player:LearnSpell(14289) -- Multi Shot [Rank 3]
        player:LearnSpell(14290) -- Multi-Shot [Rank 4]
        player:LearnSpell(25204) -- Multi-Shot [Rank 5]
        player:LearnSpell(27021) -- Multi-Shot [Rank 6]
        player:LearnSpell(49047) -- Multi-Shot [Rank 7]
        player:LearnSpell(49048) -- Multi-Shot [Rank 8]
        player:LearnSpell(3045) -- Rapid Fire
        player:LearnSpell(14260) -- Raptor Strike [Rank 2]
        player:LearnSpell(14261) -- Raptor Strike [Rank 3]
        player:LearnSpell(14262) -- Raptor Strike [Rank 4]
        player:LearnSpell(14263) -- Raptor Strike [Rank 5]
        player:LearnSpell(14264) -- Raptor Strike [Rank 6]
        player:LearnSpell(14265) -- Raptor Strike [Rank 7]
        player:LearnSpell(14266) -- Raptor Strike [Rank 8]
        player:LearnSpell(27014) -- Raptor Strike [Rank 9]
        player:LearnSpell(48995) -- Raptor Strike [Rank 10]
        player:LearnSpell(48996) -- Raptor Strike [Rank 11]
        player:LearnSpell(982) -- Revive Pet
        player:LearnSpell(1513) -- Scare Beast [Rank 1]
        player:LearnSpell(14326) -- Scare Beast [Rank 2]
        player:LearnSpell(14327) -- Scare Beast [Rank 3]
        player:LearnSpell(3043) -- Scorpid Sting
        player:LearnSpell(1978) -- Serpent Sting [Rank 1]
        player:LearnSpell(13549) -- Serpent Sting [Rank 2]
        player:LearnSpell(13550) -- Serpent Sting [Rank 3]
        player:LearnSpell(13551) -- Serpent Sting [Rank 4]
        player:LearnSpell(13552) -- Serpent Sting [Rank 5]
        player:LearnSpell(13553) -- Serpent Sting [Rank 6]
        player:LearnSpell(13554) -- Serpent Sting [Rank 7]
        player:LearnSpell(13555) -- Serpent Sting [Rank 8]
        player:LearnSpell(25295) -- Serpent Sting [Rank 9]
        player:LearnSpell(27016) -- Serpent Sting [Rank 10]
        player:LearnSpell(49000) -- Serpent Sting [Rank 11]
        player:LearnSpell(49001) -- Serpent Sting [Rank 12]
        player:LearnSpell(34600) -- Snake Trap
        player:LearnSpell(56641) -- Steady Shot [Rank 1]
        player:LearnSpell(34120) -- Steady Shot [Rank 2]
        player:LearnSpell(49051) -- Steady Shot [Rank 3]
        player:LearnSpell(49052) -- Steady Shot [Rank 4]
        player:LearnSpell(1515) -- Tame Beast
        player:LearnSpell(1494) -- Track Beasts
        player:LearnSpell(19878) -- Track Demons
        player:LearnSpell(19879) -- Track Dragonkin
        player:LearnSpell(19880) -- Track Elementals
        player:LearnSpell(19882) -- Track Giants
        player:LearnSpell(19885) -- Track Hidden
        player:LearnSpell(19883) -- Track Humanoids
        player:LearnSpell(19884) -- Track Undead
        player:LearnSpell(19801) -- Tranquilizing Shot
        player:LearnSpell(3034) -- Viper Sting
        player:LearnSpell(1510) -- Volley [Rank 1]
        player:LearnSpell(14294) -- Volley [Rank 2]
        player:LearnSpell(14295) -- Volley [Rank 3]
        player:LearnSpell(27022) -- Volley [Rank 4]
        player:LearnSpell(58431) -- Volley [Rank 5]
        player:LearnSpell(58434) -- Volley [Rank 6]
        player:LearnSpell(2974) -- Wing Clip
        player:GossipComplete()
end -- End Hunter Spells
 
--[Rogue Spells]--
if (intid == 53) then
        player:LearnSpell(8676) -- Ambush [Rank 1]
        player:LearnSpell(8724) -- Ambush [Rank 2]
        player:LearnSpell(8725) -- Ambush [Rank 3]
        player:LearnSpell(11267) -- Ambush [Rank 4]
        player:LearnSpell(11268) -- Ambush [Rank 5]
        player:LearnSpell(11269) -- Ambush [Rank 6]
        player:LearnSpell(27441) -- Ambush [Rank 7]
        player:LearnSpell(48689) -- Ambush [Rank 8]
        player:LearnSpell(48690) -- Ambush [Rank 9]
        player:LearnSpell(48691) -- Ambush [Rank 10]
        player:LearnSpell(53) -- Backstab [Rank 1]
        player:LearnSpell(2589) -- Backstab [Rank 2]
        player:LearnSpell(2590) -- Backstab [Rank 3]
        player:LearnSpell(2591) -- Backstab [Rank 4]
        player:LearnSpell(8721) -- Backstab [Rank 5]
        player:LearnSpell(11279) -- Backstab [Rank 6]
        player:LearnSpell(11280) -- Backstab [Rank 7]
        player:LearnSpell(11281) -- Backstab [Rank 8]
        player:LearnSpell(25300) -- Backstab [Rank 9]
        player:LearnSpell(26863) -- Backstab [Rank 10]
        player:LearnSpell(48656) -- Backstab [Rank 11]
        player:LearnSpell(48657) -- Backstab [Rank 12]
        player:LearnSpell(2094) -- Blind
        player:LearnSpell(1833) -- Cheap Shot
        player:LearnSpell(31224) -- Cloak of Shadows
        player:LearnSpell(26679) -- Deadly Throw [Rank 1]
        player:LearnSpell(48673) -- Deadly Throw [Rank 2]
        player:LearnSpell(48674) -- Deadly Throw [Rank 3]
        player:LearnSpell(2836) -- Detect Traps
        player:LearnSpell(1842) -- Disarm Trap
        player:LearnSpell(51722) -- Dismantle
        player:LearnSpell(1725) -- Distract
        player:LearnSpell(32645) -- Envenom [Rank 1]
        player:LearnSpell(32684) -- Envenom [Rank 2]
        player:LearnSpell(57992) -- Envenom [Rank 3]
        player:LearnSpell(57993) -- Envenom [Rank 4]
        player:LearnSpell(5277) -- Evasion [Rank 1]
        player:LearnSpell(26669) -- Evasion [Rank 2]
        player:LearnSpell(6760) -- Eviscerate [Rank 2]
        player:LearnSpell(6761) -- Eviscerate [Rank 3]
        player:LearnSpell(6762) -- Eviscerate [Rank 4]
        player:LearnSpell(8623) -- Eviscerate [Rank 5]
        player:LearnSpell(8624) -- Eviscerate [Rank 6]
        player:LearnSpell(11299) -- Eviscerate [Rank 7]
        player:LearnSpell(11300) -- Eviscerate [Rank 8]
        player:LearnSpell(31016) -- Eviscerate [Rank 9]
        player:LearnSpell(26865) -- Eviscerate [Rank 10]
        player:LearnSpell(48667) -- Eviscerate [Rank 11]
        player:LearnSpell(48668) -- Eviscerate [Rank 12]
        player:LearnSpell(8647) -- Expose Armor
        player:LearnSpell(51723) -- Fan of Knives
        player:LearnSpell(1966) -- Feint [Rank 1]
        player:LearnSpell(6768) -- Feint [Rank 2]
        player:LearnSpell(8637) -- Feint [Rank 3]
        player:LearnSpell(11303) -- Feint [Rank 4]
        player:LearnSpell(25302) -- Feint [Rank 5]
        player:LearnSpell(27448) -- Feint [Rank 6]
        player:LearnSpell(48658) -- Feint [Rank 7]
        player:LearnSpell(48659) -- Feint [Rank 8]
        player:LearnSpell(703) -- Garrote [Rank 1]
        player:LearnSpell(8631) -- Garrote [Rank 2]
        player:LearnSpell(8632) -- Garrote [Rank 3]
        player:LearnSpell(8633) -- Garrote [Rank 4]
        player:LearnSpell(11289) -- Garrote [Rank 5]
        player:LearnSpell(11290) -- Garrote [Rank 6]
        player:LearnSpell(26839) -- Garrote [Rank 7]
        player:LearnSpell(26884) -- Garrote [Rank 8]
        player:LearnSpell(48675) -- Garrote [Rank 9]
        player:LearnSpell(48676) -- Garrote [Rank 10]
        player:LearnSpell(1776) -- Gouge
        player:LearnSpell(1766) -- Kick
        player:LearnSpell(408) -- Kidney Shot [Rank 1]
        player:LearnSpell(8643) -- Kidney Shot [Rank 2]
        player:LearnSpell(1804) -- Pick Lock
        player:LearnSpell(921) -- Pick Pocket
        player:LearnSpell(1943) -- Rupture [Rank 1]
        player:LearnSpell(8639) -- Rupture [Rank 2]
        player:LearnSpell(8640) -- Rupture [Rank 3]
        player:LearnSpell(11273) -- Rupture [Rank 4]
        player:LearnSpell(11274) -- Rupture [Rank 5]
        player:LearnSpell(11275) -- Rupture [Rank 6]
        player:LearnSpell(26867) -- Rupture [Rank 7]
        player:LearnSpell(48671) -- Rupture [Rank 8]
        player:LearnSpell(48672) -- Rupture [Rank 9]
        player:LearnSpell(1860) -- Safe Fall
        player:LearnSpell(6770) -- Sap [Rank 1]
        player:LearnSpell(2070) -- Sap [Rank 2]
        player:LearnSpell(11297) -- Sap [Rank 3]
        player:LearnSpell(51724) -- Sap [Rank 4]
        player:LearnSpell(5938) -- Shiv
        player:LearnSpell(1757) -- Sinister Strike [Rank 2]
        player:LearnSpell(1758) -- Sinister Strike [Rank 3]
        player:LearnSpell(1759) -- Sinister Strike [Rank 4]
        player:LearnSpell(1760) -- Sinister Strike [Rank 5]
        player:LearnSpell(8621) -- Sinister Strike [Rank 6]
        player:LearnSpell(11293) -- Sinister Strike [Rank 7]
        player:LearnSpell(11294) -- Sinister Strike [Rank 8]
        player:LearnSpell(26861) -- Sinister Strike [Rank 9]
        player:LearnSpell(26862) -- Sinister Strike [Rank 10]
        player:LearnSpell(48637) -- Sinister Strike [Rank 11]
        player:LearnSpell(48638) -- Sinister Strike [Rank 12]
        player:LearnSpell(5171) -- Slice and Dice [Rank 1]
        player:LearnSpell(6774) -- Slice and Dice [Rank 2]
        player:LearnSpell(2983) -- Sprint [Rank 1]
        player:LearnSpell(8696) -- Sprint [Rank 2]
        player:LearnSpell(11305) -- Sprint [Rank 3]
        player:LearnSpell(1787) -- Stealth [Rank 4]
        player:LearnSpell(57934) -- Tricks of the Trade
        player:LearnSpell(1856) -- Vanish [Rank 1]
        player:LearnSpell(1857) -- Vanish [Rank 2]
        player:LearnSpell(26889) -- Vanish [Rank 3]
        player:GossipComplete()
end -- End Rogue Spells
 
--[Priest Spells]--
if (intid == 54) then
        player:LearnSpell(552) -- Abolish Disease
        player:LearnSpell(32546) -- Binding Heal [Rank 1]
        player:LearnSpell(48119) -- Binding Heal [Rank 2]
        player:LearnSpell(48120) -- Binding Heal [Rank 2]
        player:LearnSpell(528) -- Cure Disease
        player:LearnSpell(2944) -- Devouring Plague [Rank 1]
        player:LearnSpell(19276) -- Devouring Plague [Rank 2]
        player:LearnSpell(19277) -- Devouring Plague [Rank 3]
        player:LearnSpell(19278) -- Devouring Plague [Rank 4]
        player:LearnSpell(19279) -- Devouring Plague [Rank 5]
        player:LearnSpell(19280) -- Devouring Plague [Rank 6]
        player:LearnSpell(25467) -- Devouring Plague [Rank 7]
        player:LearnSpell(48299) -- Devouring Plague [Rank 8]
        player:LearnSpell(48300) -- Devouring Plague [Rank 9]
        player:LearnSpell(527) -- Dispel Magic [Rank 1]
        player:LearnSpell(988) -- Dispel Magic [Rank 2]
        player:LearnSpell(64843) -- Divine Hymn
        player:LearnSpell(14752) -- Divine Spirit [Rank 1]
        player:LearnSpell(14818) -- Divine Spirit [Rank 2]
        player:LearnSpell(14819) -- Divine Spirit [Rank 3]
        player:LearnSpell(27841) -- Divine Spirit [Rank 4]
        player:LearnSpell(25312) -- Divine Spirit [Rank 5]
        player:LearnSpell(48073) -- Divine Spirit [Rank 6]
        player:LearnSpell(586) -- Fade
        player:LearnSpell(6346) -- Fear Ward
        player:LearnSpell(2061) -- Flash Heal [Rank 1]
        player:LearnSpell(9472) -- Flash Heal [Rank 2]
        player:LearnSpell(9473) -- Flash Heal [Rank 3]
        player:LearnSpell(9474) -- Flash Heal [Rank 4]
        player:LearnSpell(10915) -- Flash Heal [Rank 5]
        player:LearnSpell(10916) -- Flash Heal [Rank 6]
        player:LearnSpell(10917) -- Flash Heal [Rank 7]
        player:LearnSpell(25233) -- Flash Heal [Rank 8]
        player:LearnSpell(25235) -- Flash Heal [Rank 9]
        player:LearnSpell(48070) -- Flash Heal [Rank 10]
        player:LearnSpell(48071) -- Flash Heal [Rank 11]
        player:LearnSpell(2060) -- Greater Heal [Rank 1]
        player:LearnSpell(10963) -- Greater Heal [Rank 2]
        player:LearnSpell(10964) -- Greater Heal [Rank 3]
        player:LearnSpell(10965) -- Greater Heal [Rank 4]
        player:LearnSpell(25314) -- Greater Heal [Rank 5]
        player:LearnSpell(25210) -- Greater Heal [Rank 6]
        player:LearnSpell(25213) -- Greater Heal [Rank 7]
        player:LearnSpell(48062) -- Greater Heal [Rank 8]
        player:LearnSpell(48063) -- Greater Heal [Rank 9]
        player:LearnSpell(2054) -- Heal [Rank 1]
        player:LearnSpell(2055) -- Heal [Rank 2]
        player:LearnSpell(6063) -- Heal [Rank 3]
        player:LearnSpell(6064) -- Heal [Rank 4]
        player:LearnSpell(14914) -- Holy Fire [Rank 1]
        player:LearnSpell(15262) -- Holy Fire [Rank 2]
        player:LearnSpell(15263) -- Holy Fire [Rank 3]
        player:LearnSpell(15264) -- Holy Fire [Rank 4]
        player:LearnSpell(15265) -- Holy Fire [Rank 5]
        player:LearnSpell(15266) -- Holy Fire [Rank 6]
        player:LearnSpell(15267) -- Holy Fire [Rank 7]
        player:LearnSpell(15261) -- Holy Fire [Rank 8]
        player:LearnSpell(25384) -- Holy Fire [Rank 9]
        player:LearnSpell(48134) -- Holy Fire [Rank 10]
        player:LearnSpell(48135) -- Holy Fire [Rank 11]
        player:LearnSpell(15237) -- Holy Nova [Rank 1]
        player:LearnSpell(15430) -- Holy Nova [Rank 2]
        player:LearnSpell(15431) -- Holy Nova [Rank 3]
        player:LearnSpell(27799) -- Holy Nova [Rank 4]
        player:LearnSpell(27800) -- Holy Nova [Rank 5]
        player:LearnSpell(27801) -- Holy Nova [Rank 6]
        player:LearnSpell(25331) -- Holy Nova [Rank 7]
        player:LearnSpell(48077) -- Holy Nova [Rank 8]
        player:LearnSpell(48078) -- Holy Nova [Rank 9]
        player:LearnSpell(64901) -- Hymn of Hope
        player:LearnSpell(588) -- Inner Fire [Rank 1]
        player:LearnSpell(7128) -- Inner Fire [Rank 2]
        player:LearnSpell(602) -- Inner Fire [Rank 3]
        player:LearnSpell(1006) -- Inner Fire [Rank 4]
        player:LearnSpell(10951) -- Inner Fire [Rank 5]
        player:LearnSpell(10952) -- Inner Fire [Rank 6]
        player:LearnSpell(25431) -- Inner Fire [Rank 7]
        player:LearnSpell(48040) -- Inner Fire [Rank 8]
        player:LearnSpell(48168) -- Inner Fire [Rank 9]
        player:LearnSpell(2052) -- Lesser Heal [Rank 2]
        player:LearnSpell(2053) -- Lesser Heal [Rank 3]
        player:LearnSpell(1706) -- Levitate
        player:LearnSpell(8129) -- Mana Burn
        player:LearnSpell(32375) -- Mass Dispel
        player:LearnSpell(8092) -- Mind Blast [Rank 1]
        player:LearnSpell(8102) -- Mind Blast [Rank 2]
        player:LearnSpell(8103) -- Mind Blast [Rank 3]
        player:LearnSpell(8104) -- Mind Blast [Rank 4]
        player:LearnSpell(8105) -- Mind Blast [Rank 5]
        player:LearnSpell(8106) -- Mind Blast [Rank 6]
        player:LearnSpell(10945) -- Mind Blast [Rank 7]
        player:LearnSpell(10946) -- Mind Blast [Rank 8]
        player:LearnSpell(10947) -- Mind Blast [Rank 9]
        player:LearnSpell(25372) -- Mind Blast [Rank 10]
        player:LearnSpell(25375) -- Mind Blast [Rank 11]
        player:LearnSpell(48126) -- Mind Blast [Rank 12]
        player:LearnSpell(48127) -- Mind Blast [Rank 13]
        player:LearnSpell(605) -- Mind Control
        player:LearnSpell(48045) -- Mind Sear [Rank 1]
        player:LearnSpell(53023) -- Mind Sear [Rank 2]
        player:LearnSpell(453) -- Mind Soothe
        player:LearnSpell(2096) -- Mind Vision [Rank 1]
        player:LearnSpell(10909) -- Mind Vision [Rank 2]
        player:LearnSpell(1243) -- Power Word: Fortitude [Rank 1]
        player:LearnSpell(1244) -- Power Word: Fortitude [Rank 2]
        player:LearnSpell(1245) -- Power Word: Fortitude [Rank 3]
        player:LearnSpell(2791) -- Power Word: Fortitude [Rank 4]
        player:LearnSpell(10937) -- Power Word: Fortitude [Rank 5]
        player:LearnSpell(10938) -- Power Word: Fortitude [Rank 6]
        player:LearnSpell(25389) -- Power Word: Fortitude [Rank 7]
        player:LearnSpell(48161) -- Power Word: Fortitude [Rank 8]
        player:LearnSpell(17) -- Power Word: Shield [Rank 1]
        player:LearnSpell(592) -- Power Word: Shield [Rank 2]
        player:LearnSpell(600) -- Power Word: Shield [Rank 3]
        player:LearnSpell(3747) -- Power Word: Shield [Rank 4]
        player:LearnSpell(6065) -- Power Word: Shield [Rank 5]
        player:LearnSpell(6066) -- Power Word: Shield [Rank 6]
        player:LearnSpell(10898) -- Power Word: Shield [Rank 7]
        player:LearnSpell(10899) -- Power Word: Shield [Rank 8]
        player:LearnSpell(10900) -- Power Word: Shield [Rank 9]
        player:LearnSpell(10901) -- Power Word: Shield [Rank 10]
        player:LearnSpell(25217) -- Power Word: Shield [Rank 11]
        player:LearnSpell(25218) -- Power Word: Shield [Rank 12]
        player:LearnSpell(48065) -- Power Word: Shield [Rank 13]
        player:LearnSpell(48066) -- Power Word: Shield [Rank 14]
        player:LearnSpell(21562) -- Prayer of Fortitude [Rank 1]
        player:LearnSpell(21564) -- Prayer of Fortitude [Rank 2]
        player:LearnSpell(25392) -- Prayer of Fortitude [Rank 3]
        player:LearnSpell(48162) -- Prayer of Fortitude [Rank 4]
        player:LearnSpell(596) -- Prayer of Healing [Rank 1]
        player:LearnSpell(996) -- Prayer of Healing [Rank 2]
        player:LearnSpell(10960) -- Prayer of Healing [Rank 3]
        player:LearnSpell(10961) -- Prayer of Healing [Rank 4]
        player:LearnSpell(25316) -- Prayer of Healing [Rank 5]
        player:LearnSpell(25308) -- Prayer of Healing [Rank 6]
        player:LearnSpell(48072) -- Prayer of Healing [Rank 7]
        player:LearnSpell(33076) -- Prayer of Mending [Rank 1]
        player:LearnSpell(48112) -- Prayer of Mending [Rank 2]
        player:LearnSpell(48113) -- Prayer of Mending [Rank 3]
        player:LearnSpell(27683) -- Prayer of Shadow Protection [Rank 1]
        player:LearnSpell(39374) -- Prayer of Shadow Protection [Rank 2]
        player:LearnSpell(48170) -- Prayer of Shadow Protection [Rank 3]
        player:LearnSpell(27681) -- Prayer of Spirit [Rank 1]
        player:LearnSpell(32999) -- Prayer of Spirit [Rank 2]
        player:LearnSpell(48074) -- Prayer of Spirit [Rank 3]
        player:LearnSpell(8122) -- Psychic Scream [Rank 1]
        player:LearnSpell(8124) -- Psychic Scream [Rank 2]
        player:LearnSpell(10888) -- Psychic Scream [Rank 3]
        player:LearnSpell(10890) -- Psychic Scream [Rank 4]
        player:LearnSpell(139) -- Renew [Rank 1]
        player:LearnSpell(6074) -- Renew [Rank 2]
        player:LearnSpell(6075) -- Renew [Rank 3]
        player:LearnSpell(6076) -- Renew [Rank 4]
        player:LearnSpell(6077) -- Renew [Rank 5]
        player:LearnSpell(6078) -- Renew [Rank 6]
        player:LearnSpell(10927) -- Renew [Rank 7]
        player:LearnSpell(10928) -- Renew [Rank 8]
        player:LearnSpell(10929) -- Renew [Rank 9]
        player:LearnSpell(25315) -- Renew [Rank 10]
        player:LearnSpell(25221) -- Renew [Rank 11]
        player:LearnSpell(25222) -- Renew [Rank 12]
        player:LearnSpell(48067) -- Renew [Rank 13]
        player:LearnSpell(48068) -- Renew [Rank 14]
        player:LearnSpell(2006) -- Resurrection [Rank 1]
        player:LearnSpell(2010) -- Resurrection [Rank 2]
        player:LearnSpell(10880) -- Resurrection [Rank 3]
        player:LearnSpell(10881) -- Resurrection [Rank 4]
        player:LearnSpell(20770) -- Resurrection [Rank 5]
        player:LearnSpell(25435) -- Resurrection [Rank 6]
        player:LearnSpell(48171) -- Resurrection [Rank 7]
        player:LearnSpell(9484) -- Shackle Undead [Rank 1]
        player:LearnSpell(9485) -- Shackle Undead [Rank 2]
        player:LearnSpell(10955) -- Shackle Undead [Rank 3]
        player:LearnSpell(976) -- Shadow Protection [Rank 1]
        player:LearnSpell(10957) -- Shadow Protection [Rank 2]
        player:LearnSpell(10958) -- Shadow Protection [Rank 3]
        player:LearnSpell(25433) -- Shadow Protection [Rank 4]
        player:LearnSpell(48169) -- Shadow Protection [Rank 5]
        player:LearnSpell(32379) -- Shadow Word: Death [Rank 1]
        player:LearnSpell(32996) -- Shadow Word: Death [Rank 2]
        player:LearnSpell(48157) -- Shadow Word: Death [Rank 3]
        player:LearnSpell(48158) -- Shadow Word: Death [Rank 4]
        player:LearnSpell(589) -- Shadow Word: Pain [Rank 1]
        player:LearnSpell(594) -- Shadow Word: Pain [Rank 2]
        player:LearnSpell(970) -- Shadow Word: Pain [Rank 3]
        player:LearnSpell(992) -- Shadow Word: Pain [Rank 4]
        player:LearnSpell(2767) -- Shadow Word: Pain [Rank 5]
        player:LearnSpell(10892) -- Shadow Word: Pain [Rank 6]
        player:LearnSpell(10893) -- Shadow Word: Pain [Rank 7]
        player:LearnSpell(10894) -- Shadow Word: Pain [Rank 8]
        player:LearnSpell(25367) -- Shadow Word: Pain [Rank 9]
        player:LearnSpell(25368) -- Shadow Word: Pain [Rank 10]
        player:LearnSpell(48124) -- Shadow Word: Pain [Rank 11]
        player:LearnSpell(48125) -- Shadow Word: Pain [Rank 12]
        player:LearnSpell(34433) -- Shadowfiend
        player:LearnSpell(591) -- Smite [Rank 2]
        player:LearnSpell(598) -- Smite [Rank 3]
        player:LearnSpell(984) -- Smite [Rank 4]
        player:LearnSpell(1004) -- Smite [Rank 5]
        player:LearnSpell(6060) -- Smite [Rank 6]
        player:LearnSpell(10933) -- Smite [Rank 7]
        player:LearnSpell(10934) -- Smite [Rank 8]
        player:LearnSpell(25363) -- Smite [Rank 9]
        player:LearnSpell(25364) -- Smite [Rank 10]
        player:LearnSpell(48122) -- Smite [Rank 11]
        player:LearnSpell(48123) -- Smite [Rank 12]
        player:GossipComplete()
end -- End Priest Spells
 
--[Death Knight Spells]--
if (intid == 55) then
        player:LearnSpell(48778) -- Acherus Deathcharger
        player:LearnSpell(48707) -- Anti-Magic Shell
        player:LearnSpell(42650) -- Army of the Dead
        player:LearnSpell(48721) -- Blood Boil [Rank 1]
        player:LearnSpell(49939) -- Blood Boil [Rank 2]
        player:LearnSpell(49940) -- Blood Boil [Rank 3]
        player:LearnSpell(49941) -- Blood Boil [Rank 4]
        player:LearnSpell(49926) -- Blood Strike [Rank 2]
        player:LearnSpell(49927) -- Blood Strike [Rank 3]
        player:LearnSpell(49928) -- Blood Strike [Rank 4]
        player:LearnSpell(49929) -- Blood Strike [Rank 5]
        player:LearnSpell(49930) -- Blood Strike [Rank 6]
        player:LearnSpell(45529) -- Blood Tap
        player:LearnSpell(45524) -- Chains of Ice
        player:LearnSpell(56222) -- Dark Command
        player:LearnSpell(43265) -- Death and Decay [Rank 1]
        player:LearnSpell(49963) -- Death and Decay [Rank 2]
        player:LearnSpell(49937) -- Death and Decay [Rank 3]
        player:LearnSpell(49938) -- Death and Decay [Rank 4]
        player:LearnSpell(49892) -- Death Coil [Rank 2]
        player:LearnSpell(49893) -- Death Coil [Rank 3]
        player:LearnSpell(62903) -- Death Coil [Rank 4]
        player:LearnSpell(62904) -- Death Coil [Rank 5]
        player:LearnSpell(50977) -- Death Gate
        player:LearnSpell(48743) -- Death Pact
        player:LearnSpell(49998) -- Death Strike [Rank 1]
        player:LearnSpell(49999) -- Death Strike [Rank 2]
        player:LearnSpell(45463) -- Death Strike [Rank 3]
        player:LearnSpell(49923) -- Death Strike [Rank 4]
        player:LearnSpell(49924) -- Death Strike [Rank 5]
        player:LearnSpell(43265) -- Death and Decay [Rank 1]
        player:LearnSpell(49936) -- Death and Decay [Rank 2]
        player:LearnSpell(49937) -- Death and Decay [Rank 3]
        player:LearnSpell(49938) -- Death and Decay [Rank 4]
        player:LearnSpell(47568) -- Empower Rune Weapon
        player:LearnSpell(48263) -- Frost Presence
        player:LearnSpell(57330) -- Horn of Winter [Rank 1]
        player:LearnSpell(57623) -- Horn of Winter [Rank 2]
        player:LearnSpell(48792) -- Icebound Fortitude
        player:LearnSpell(49896) -- Icy Touch [Rank 2]
        player:LearnSpell(49903) -- Icy Touch [Rank 3]
        player:LearnSpell(49904) -- Icy Touch [Rank 4]
        player:LearnSpell(49909) -- Icy Touch [Rank 5]
        player:LearnSpell(47528) -- Mind Freeze
        player:LearnSpell(49020) -- Obliterate [Rank 1]
        player:LearnSpell(51423) -- Obliterate [Rank 2]
        player:LearnSpell(51424) -- Obliterate [Rank 3]
        player:LearnSpell(51425) -- Obliterate [Rank 4]
        player:LearnSpell(3714) -- Path of Frost
        player:LearnSpell(50842) -- Pestilence
        player:LearnSpell(49917) -- Plague Strike [Rank 2]
        player:LearnSpell(49918) -- Plague Strike [Rank 3]
        player:LearnSpell(49919) -- Plague Strike [Rank 4]
        player:LearnSpell(49920) -- Plague Strike [Rank 5]
        player:LearnSpell(49221) -- Plague Strike [Rank 6]
        player:LearnSpell(61999) -- Raise Ally
        player:LearnSpell(46584) -- Raise Dead
        player:LearnSpell(56815) -- Rune Strike
        player:LearnSpell(53428) -- Runeforging
        player:LearnSpell(47476) -- Strangulate
        player:LearnSpell(48265) -- Unholy Presence
        player:GossipComplete()
end -- End Death Knight Spells
 
--[Shaman Spells]--
if (intid == 56) then
        player:LearnSpell(2008) -- Ancestral Spirit [Rank 1]
        player:LearnSpell(20609) -- Ancestral Spirit [Rank 2]
        player:LearnSpell(20610) -- Ancestral Spirit [Rank 3]
        player:LearnSpell(20776) -- Ancestral Spirit [Rank 4]
        player:LearnSpell(20777) -- Ancestral Spirit [Rank 5]
        player:LearnSpell(25590) -- Ancestral Spirit [Rank 6]
        player:LearnSpell(49277) -- Ancestral Spirit [Rank 7]
        player:LearnSpell(556) -- Astral Recall
                local race = player:GetPlayerRace()
                if race == 2 or race == 6 or race == 8 then
                        player:LearnSpell(2825) -- Bloodlust
                elseif race == 11 then
                        player:LearnSpell(32182) -- Heroism
                end
        player:LearnSpell(66843) -- Call of the Ancestors
        player:LearnSpell(66842) -- Call of the Elements
        player:LearnSpell(66844) -- Call of the Spirits
        player:LearnSpell(1064) -- Chain Heal [Rank 1]
        player:LearnSpell(10622) -- Chain Heal [Rank 2]
        player:LearnSpell(10623) -- Chain Heal [Rank 3]
        player:LearnSpell(25422) -- Chain Heal [Rank 4]
        player:LearnSpell(25423) -- Chain Heal [Rank 5]
        player:LearnSpell(55458) -- Chain Heal [Rank 6]
        player:LearnSpell(55459) -- Chain Heal [Rank 7]
        player:LearnSpell(421) -- Chain Lightning [Rank 1]
        player:LearnSpell(930) -- Chain Lightning [Rank 2]
        player:LearnSpell(2860) -- Chain Lightning [Rank 3]
        player:LearnSpell(10605) -- Chain Lightning [Rank 4]
        player:LearnSpell(25439) -- Chain Lightning [Rank 5]
        player:LearnSpell(25442) -- Chain Lightning [Rank 6]
        player:LearnSpell(49270) -- Chain Lightning [Rank 7]
        player:LearnSpell(49271) -- Chain Lightning [Rank 8]
        player:LearnSpell(8170) -- Cleansing Totem
        player:LearnSpell(526) -- Cure Toxins
        player:LearnSpell(2062) -- Earth Elemental Totem
        player:LearnSpell(8042) -- Earth Shock [Rank 1]
        player:LearnSpell(8044) -- Earth Shock [Rank 2]
        player:LearnSpell(8045) -- Earth Shock [Rank 3]
        player:LearnSpell(8046) -- Earth Shock [Rank 4]
        player:LearnSpell(10412) -- Earth Shock [Rank 5]
        player:LearnSpell(10413) -- Earth Shock [Rank 6]
        player:LearnSpell(10414) -- Earth Shock [Rank 7]
        player:LearnSpell(25454) -- Earth Shock [Rank 8]
        player:LearnSpell(49230) -- Earth Shock [Rank 9]
        player:LearnSpell(49231) -- Earth Shock [Rank 10]
        player:LearnSpell(2484) -- Earthbind Totem
        player:LearnSpell(51730) -- Earthliving Weapon [Rank 1]
        player:LearnSpell(51988) -- Earthliving Weapon [Rank 2]
        player:LearnSpell(51991) -- Earthliving Weapon [Rank 3]
        player:LearnSpell(51992) -- Earthliving Weapon [Rank 4]
        player:LearnSpell(51993) -- Earthliving Weapon [Rank 5]
        player:LearnSpell(51994) -- Earthliving Weapon [Rank 6]
        player:LearnSpell(6196) -- Far Sight
        player:LearnSpell(2894) -- Fire Elemental Totem
        player:LearnSpell(1535) -- Fire Nova Totem [Rank 1]
        player:LearnSpell(8498) -- Fire Nova Totem [Rank 2]
        player:LearnSpell(8499) -- Fire Nova Totem [Rank 3]
        player:LearnSpell(11314) -- Fire Nova Totem [Rank 4]
        player:LearnSpell(11315) -- Fire Nova Totem [Rank 5]
        player:LearnSpell(25546) -- Fire Nova Totem [Rank 6]
        player:LearnSpell(25547) -- Fire Nova Totem [Rank 7]
        player:LearnSpell(61649) -- Fire Nova Totem [Rank 8]
        player:LearnSpell(61657) -- Fire Nova Totem [Rank 9]
        player:LearnSpell(8184) -- Fire Resistance Totem [Rank 1]
        player:LearnSpell(10537) -- Fire Resistance Totem [Rank 2]
        player:LearnSpell(10538) -- Fire Resistance Totem [Rank 3]
        player:LearnSpell(25563) -- Fire Resistance Totem [Rank 4]
        player:LearnSpell(58737) -- Fire Resistance Totem [Rank 5]
        player:LearnSpell(58739) -- Fire Resistance Totem [Rank 6]
        player:LearnSpell(8050) -- Flame Shock [Rank 1]
        player:LearnSpell(8052) -- Flame Shock [Rank 2]
        player:LearnSpell(8053) -- Flame Shock [Rank 3]
        player:LearnSpell(10447) -- Flame Shock [Rank 4]
        player:LearnSpell(10448) -- Flame Shock [Rank 5]
        player:LearnSpell(29228) -- Flame Shock [Rank 6]
        player:LearnSpell(25457) -- Flame Shock [Rank 7]
        player:LearnSpell(49232) -- Flame Shock [Rank 8]
        player:LearnSpell(49233) -- Flame Shock [Rank 9]
        player:LearnSpell(8227) -- Flametongue Totem [Rank 1]
        player:LearnSpell(8249) -- Flametongue Totem [Rank 2]
        player:LearnSpell(10526) -- Flametongue Totem [Rank 3]
        player:LearnSpell(16387) -- Flametongue Totem [Rank 4]
        player:LearnSpell(25557) -- Flametongue Totem [Rank 5]
        player:LearnSpell(58649) -- Flametongue Totem [Rank 6]
        player:LearnSpell(58652) -- Flametongue Totem [Rank 7]
        player:LearnSpell(58656) -- Flametongue Totem [Rank 8]
        player:LearnSpell(8024) -- Flametongue Weapon [Rank 1]
        player:LearnSpell(8027) -- Flametongue Weapon [Rank 2]
        player:LearnSpell(8030) -- Flametongue Weapon [Rank 3]
        player:LearnSpell(16339) -- Flametongue Weapon [Rank 4]
        player:LearnSpell(16341) -- Flametongue Weapon [Rank 5]
        player:LearnSpell(16342) -- Flametongue Weapon [Rank 6]
        player:LearnSpell(25489) -- Flametongue Weapon [Rank 7]
        player:LearnSpell(58785) -- Flametongue Weapon [Rank 8]
        player:LearnSpell(58789) -- Flametongue Weapon [Rank 9]
        player:LearnSpell(58790) -- Flametongue Weapon [Rank 10]
        player:LearnSpell(8181) -- Frost Resistance Totem [Rank 1]
        player:LearnSpell(10478) -- Frost Resistance Totem [Rank 2]
        player:LearnSpell(10479) -- Frost Resistance Totem [Rank 3]
        player:LearnSpell(25560) -- Frost Resistance Totem [Rank 4]
        player:LearnSpell(58741) -- Frost Resistance Totem [Rank 5]
        player:LearnSpell(58745) -- Frost Resistance Totem [Rank 6]
        player:LearnSpell(8056) -- Frost Shock [Rank 1]
        player:LearnSpell(8058) -- Frost Shock [Rank 2]
        player:LearnSpell(10472) -- Frost Shock [Rank 3]
        player:LearnSpell(10473) -- Frost Shock [Rank 4]
        player:LearnSpell(25464) -- Frost Shock [Rank 5]
        player:LearnSpell(49235) -- Frost Shock [Rank 6]
        player:LearnSpell(49236) -- Frost Shock [Rank 7]
        player:LearnSpell(8033) -- Frostbrand Weapon [Rank 1]
        player:LearnSpell(8038) -- Frostbrand Weapon [Rank 2]
        player:LearnSpell(10456) -- Frostbrand Weapon [Rank 3]
        player:LearnSpell(16355) -- Frostbrand Weapon [Rank 4]
        player:LearnSpell(16356) -- Frostbrand Weapon [Rank 5]
        player:LearnSpell(25500) -- Frostbrand Weapon [Rank 6]
        player:LearnSpell(58794) -- Frostbrand Weapon [Rank 7]
        player:LearnSpell(58795) -- Frostbrand Weapon [Rank 8]
        player:LearnSpell(58796) -- Frostbrand Weapon [Rank 9]
        player:LearnSpell(2645) -- Ghost Wolf
        player:LearnSpell(8177) -- Grounding Totem
        player:LearnSpell(5394) -- Healing Stream Totem [Rank 1]
        player:LearnSpell(6375) -- Healing Stream Totem [Rank 2]
        player:LearnSpell(6377) -- Healing Stream Totem [Rank 3]
        player:LearnSpell(10462) -- Healing Stream Totem [Rank 4]
        player:LearnSpell(10463) -- Healing Stream Totem [Rank 5]
        player:LearnSpell(25567) -- Healing Stream Totem [Rank 6]
        player:LearnSpell(58755) -- Healing Stream Totem [Rank 7]
        player:LearnSpell(58756) -- Healing Stream Totem [Rank 8]
        player:LearnSpell(58757) -- Healing Stream Totem [Rank 9]
        player:LearnSpell(332) -- Healing Wave [Rank 2]
        player:LearnSpell(547) -- Healing Wave [Rank 3]
        player:LearnSpell(913) -- Healing Wave [Rank 4]
        player:LearnSpell(939) -- Healing Wave [Rank 5]
        player:LearnSpell(959) -- Healing Wave [Rank 6]
        player:LearnSpell(8005) -- Healing Wave [Rank 7]
        player:LearnSpell(10395) -- Healing Wave [Rank 8]
        player:LearnSpell(10396) -- Healing Wave [Rank 9]
        player:LearnSpell(25357) -- Healing Wave [Rank 10]
        player:LearnSpell(25391) -- Healing Wave [Rank 11]
        player:LearnSpell(25396) -- Healing Wave [Rank 12]
        player:LearnSpell(49272) -- Healing Wave [Rank 13]
        player:LearnSpell(49273) -- Healing Wave [Rank 14]
        player:LearnSpell(51514) -- Hex
        player:LearnSpell(51505) -- Lava Burst [Rank 1]
        player:LearnSpell(60043) -- Lava Burst [Rank 2]
        player:LearnSpell(8004) -- Lesser Healing Wave [Rank 1]
        player:LearnSpell(8008) -- Lesser Healing Wave [Rank 2]
        player:LearnSpell(8010) -- Lesser Healing Wave [Rank 3]
        player:LearnSpell(10466) -- Lesser Healing Wave [Rank 4]
        player:LearnSpell(10467) -- Lesser Healing Wave [Rank 5]
        player:LearnSpell(10468) -- Lesser Healing Wave [Rank 6]
        player:LearnSpell(25420) -- Lesser Healing Wave [Rank 7]
        player:LearnSpell(49275) -- Lesser Healing Wave [Rank 8]
        player:LearnSpell(49276) -- Lesser Healing Wave [Rank 9]
        player:LearnSpell(529) -- Lightning Bolt [Rank 2]
        player:LearnSpell(548) -- Lightning Bolt [Rank 3]
        player:LearnSpell(915) -- Lightning Bolt [Rank 4]
        player:LearnSpell(943) -- Lightning Bolt [Rank 5]
        player:LearnSpell(6041) -- Lightning Bolt [Rank 6]
        player:LearnSpell(10391) -- Lightning Bolt [Rank 7]
        player:LearnSpell(10392) -- Lightning Bolt [Rank 8]
        player:LearnSpell(15207) -- Lightning Bolt [Rank 9]
        player:LearnSpell(15208) -- Lightning Bolt [Rank 10]
        player:LearnSpell(25448) -- Lightning Bolt [Rank 11]
        player:LearnSpell(25449) -- Lightning Bolt [Rank 12]
        player:LearnSpell(49237) -- Lightning Bolt [Rank 13]
        player:LearnSpell(49238) -- Lightning Bolt [Rank 14]
        player:LearnSpell(324) -- Lightning Shield [Rank 1]
        player:LearnSpell(325) -- Lightning Shield [Rank 2]
        player:LearnSpell(905) -- Lightning Shield [Rank 3]
        player:LearnSpell(945) -- Lightning Shield [Rank 4]
        player:LearnSpell(8134) -- Lightning Shield [Rank 5]
        player:LearnSpell(10431) -- Lightning Shield [Rank 6]
        player:LearnSpell(10432) -- Lightning Shield [Rank 7]
        player:LearnSpell(25469) -- Lightning Shield [Rank 8]
        player:LearnSpell(25472) -- Lightning Shield [Rank 9]
        player:LearnSpell(49280) -- Lightning Shield [Rank 10]
        player:LearnSpell(49281) -- Lightning Shield [Rank 11]
        player:LearnSpell(8190) -- Magma Totem [Rank 1]
        player:LearnSpell(10585) -- Magma Totem [Rank 2]
        player:LearnSpell(10586) -- Magma Totem [Rank 3]
        player:LearnSpell(10587) -- Magma Totem [Rank 4]
        player:LearnSpell(25552) -- Magma Totem [Rank 5]
        player:LearnSpell(58731) -- Magma Totem [Rank 6]
        player:LearnSpell(58734) -- Magma Totem [Rank 7]
        player:LearnSpell(5675) -- Mana Spring Totem [Rank 1]
        player:LearnSpell(10495) -- Mana Spring Totem [Rank 2]
        player:LearnSpell(10496) -- Mana Spring Totem [Rank 3]
        player:LearnSpell(10497) -- Mana Spring Totem [Rank 4]
        player:LearnSpell(25570) -- Mana Spring Totem [Rank 5]
        player:LearnSpell(58771) -- Mana Spring Totem [Rank 6]
        player:LearnSpell(58773) -- Mana Spring Totem [Rank 7]
        player:LearnSpell(58774) -- Mana Spring Totem [Rank 8]
        player:LearnSpell(10595) -- Nature Resistance Totem [Rank 1]
        player:LearnSpell(10600) -- Nature Resistance Totem [Rank 2]
        player:LearnSpell(10601) -- Nature Resistance Totem [Rank 3]
        player:LearnSpell(25574) -- Nature Resistance Totem [Rank 4]
        player:LearnSpell(58746) -- Nature Resistance Totem [Rank 5]
        player:LearnSpell(58749) -- Nature Resistance Totem [Rank 6]
        player:LearnSpell(370) -- Purge [Rank 1]
        player:LearnSpell(8012) -- Purge [Rank 2]
        player:LearnSpell(20608) -- Reincarnation
        player:LearnSpell(8017) -- Rockbiter Weapon [Rank 1]
        player:LearnSpell(8018) -- Rockbiter Weapon [Rank 2]
        player:LearnSpell(8019) -- Rockbiter Weapon [Rank 3]
        player:LearnSpell(10399) -- Rockbiter Weapon [Rank 4]
        player:LearnSpell(3599) -- Searing Totem [Rank 1]
        player:LearnSpell(6363) -- Searing Totem [Rank 2]
        player:LearnSpell(6364) -- Searing Totem [Rank 3]
        player:LearnSpell(6365) -- Searing Totem [Rank 4]
        player:LearnSpell(10437) -- Searing Totem [Rank 5]
        player:LearnSpell(10438) -- Searing Totem [Rank 6]
        player:LearnSpell(25533) -- Searing Totem [Rank 7]
        player:LearnSpell(58699) -- Searing Totem [Rank 8]
        player:LearnSpell(58703) -- Searing Totem [Rank 9]
        player:LearnSpell(58704) -- Searing Totem [Rank 10]
        player:LearnSpell(6495) -- Sentry Totem
        player:LearnSpell(5730) -- Stoneclaw Totem [Rank 1]
        player:LearnSpell(6390) -- Stoneclaw Totem [Rank 2]
        player:LearnSpell(6391) -- Stoneclaw Totem [Rank 3]
        player:LearnSpell(6392) -- Stoneclaw Totem [Rank 4]
        player:LearnSpell(10427) -- Stoneclaw Totem [Rank 5]
        player:LearnSpell(10428) -- Stoneclaw Totem [Rank 6]
        player:LearnSpell(25525) -- Stoneclaw Totem [Rank 7]
        player:LearnSpell(58580) -- Stoneclaw Totem [Rank 8]
        player:LearnSpell(58581) -- Stoneclaw Totem [Rank 9]
        player:LearnSpell(58582) -- Stoneclaw Totem [Rank 10]
        player:LearnSpell(8071) -- Stoneskin Totem [Rank 1]
        player:LearnSpell(8154) -- Stoneskin Totem [Rank 2]
        player:LearnSpell(8155) -- Stoneskin Totem [Rank 3]
        player:LearnSpell(10406) -- Stoneskin Totem [Rank 4]
        player:LearnSpell(10407) -- Stoneskin Totem [Rank 5]
        player:LearnSpell(10408) -- Stoneskin Totem [Rank 6]
        player:LearnSpell(25508) -- Stoneskin Totem [Rank 7]
        player:LearnSpell(25509) -- Stoneskin Totem [Rank 8]
        player:LearnSpell(58751) -- Stoneskin Totem [Rank 9]
        player:LearnSpell(58753) -- Stoneskin Totem [Rank 10]
        player:LearnSpell(8075) -- Strength of Earth Totem [Rank 1]
        player:LearnSpell(8160) -- Strength of Earth Totem [Rank 2]
        player:LearnSpell(8161) -- Strength of Earth Totem [Rank 3]
        player:LearnSpell(10442) -- Strength of Earth Totem [Rank 4]
        player:LearnSpell(25361) -- Strength of Earth Totem [Rank 5]
        player:LearnSpell(25528) -- Strength of Earth Totem [Rank 6]
        player:LearnSpell(57622) -- Strength of Earth Totem [Rank 7]
        player:LearnSpell(58643) -- Strength of Earth Totem [Rank 8]
        player:LearnSpell(36936) -- Totemic Recall
        player:LearnSpell(8143) -- Tremor Totem
        player:LearnSpell(131) -- Water Breathing
        player:LearnSpell(52127) -- Water Shield [Rank 1]
        player:LearnSpell(52129) -- Water Shield [Rank 2]
        player:LearnSpell(52131) -- Water Shield [Rank 3]
        player:LearnSpell(52134) -- Water Shield [Rank 4]
        player:LearnSpell(52136) -- Water Shield [Rank 5]
        player:LearnSpell(52138) -- Water Shield [Rank 6]
        player:LearnSpell(24398) -- Water Shield [Rank 7]
        player:LearnSpell(33736) -- Water Shield [Rank 8]
        player:LearnSpell(57960) -- Water Shield [Rank 9]
        player:LearnSpell(546) -- Water Walking
        player:LearnSpell(57994) -- Wind Shear
        player:LearnSpell(8512) -- Windfury Totem
        player:LearnSpell(8232) -- Windfury Weapon [Rank 1]
        player:LearnSpell(8235) -- Windfury Weapon [Rank 2]
        player:LearnSpell(10486) -- Windfury Weapon [Rank 3]
        player:LearnSpell(16362) -- Windfury Weapon [Rank 4]
        player:LearnSpell(25505) -- Windfury Weapon [Rank 5]
        player:LearnSpell(58801) -- Windfury Weapon [Rank 6]
        player:LearnSpell(58803) -- Windfury Weapon [Rank 7]
        player:LearnSpell(58804) -- Windfury Weapon [Rank 8]
        player:GossipComplete()
end -- End Shaman Spells
 
--[Mage Spells]--
if (intid == 57) then
        player:LearnSpell(1008) -- Amplify Magic [Rank 1]
        player:LearnSpell(8455) -- Amplify Magic [Rank 2]
        player:LearnSpell(10169) -- Amplify Magic [Rank 3]
        player:LearnSpell(10170) -- Amplify Magic [Rank 4]
        player:LearnSpell(27130) -- Amplify Magic [Rank 5]
        player:LearnSpell(33946) -- Amplify Magic [Rank 6]
        player:LearnSpell(43017) -- Amplify Magic [Rank 7]
        player:LearnSpell(30451) -- Arcane Blast [Rank 1]
        player:LearnSpell(42894) -- Arcane Blast [Rank 2]
        player:LearnSpell(42896) -- Arcane Blast [Rank 3]
        player:LearnSpell(42897) -- Arcane Blast [Rank 4]
        player:LearnSpell(23028) -- Arcane Brilliance [Rank 1]
        player:LearnSpell(27127) -- Arcane Brilliance [Rank 2]
        player:LearnSpell(43002) -- Arcane Brilliance [Rank 3]
        player:LearnSpell(1449) -- Arcane Explosion [Rank 1]
        player:LearnSpell(8437) -- Arcane Explosion [Rank 2]
        player:LearnSpell(8438) -- Arcane Explosion [Rank 3]
        player:LearnSpell(8439) -- Arcane Explosion [Rank 4]
        player:LearnSpell(10201) -- Arcane Explosion [Rank 5]
        player:LearnSpell(10202) -- Arcane Explosion [Rank 6]
        player:LearnSpell(27080) -- Arcane Explosion [Rank 7]
        player:LearnSpell(27082) -- Arcane Explosion [Rank 8]
        player:LearnSpell(42920) -- Arcane Explosion [Rank 9]
        player:LearnSpell(42921) -- Arcane Explosion [Rank 10]
        player:LearnSpell(1459) -- Arcane Intellect [Rank 1]
        player:LearnSpell(1460) -- Arcane Intellect [Rank 2]
        player:LearnSpell(1461) -- Arcane Intellect [Rank 3]
        player:LearnSpell(10156) -- Arcane Intellect [Rank 4]
        player:LearnSpell(10157) -- Arcane Intellect [Rank 5]
        player:LearnSpell(27126) -- Arcane Intellect [Rank 6]
        player:LearnSpell(42995) -- Arcane Intellect [Rank 7]
        player:LearnSpell(5143) -- Arcane Missles [Rank 1]
        player:LearnSpell(5144) -- Arcane Missles [Rank 2]
        player:LearnSpell(5145) -- Arcane Missles [Rank 3]
        player:LearnSpell(8416) -- Arcane Missles [Rank 4]
        player:LearnSpell(8417) -- Arcane Missles [Rank 5]
        player:LearnSpell(10211) -- Arcane Missles [Rank 6]
        player:LearnSpell(10212) -- Arcane Missles [Rank 7]
        player:LearnSpell(25345) -- Arcane Missles [Rank 8]
        player:LearnSpell(27075) -- Arcane Missles [Rank 9]
        player:LearnSpell(38699) -- Arcane Missles [Rank 10]
        player:LearnSpell(38704) -- Arcane Missles [Rank 11]
        player:LearnSpell(42842) -- Arcane Missles [Rank 12]
        player:LearnSpell(42846) -- Arcane Missles [Rank 13]
        player:LearnSpell(1953) -- Blink
        player:LearnSpell(10) -- Blizzard [Rank 1]
        player:LearnSpell(6141) -- Blizzard [Rank 2]
        player:LearnSpell(8427) -- Blizzard [Rank 3]
        player:LearnSpell(10185) -- Blizzard [Rank 4]
        player:LearnSpell(10186) -- Blizzard [Rank 5]
        player:LearnSpell(10187) -- Blizzard [Rank 6]
        player:LearnSpell(27085) -- Blizzard [Rank 7]
        player:LearnSpell(42939) -- Blizzard [Rank 8]
        player:LearnSpell(42940) -- Blizzard [Rank 9]
        player:LearnSpell(120) -- Cone of Cold [Rank 1]
        player:LearnSpell(8492) -- Cone of Cold [Rank 2]
        player:LearnSpell(10159) -- Cone of Cold [Rank 3]
        player:LearnSpell(10160) -- Cone of Cold [Rank 4]
        player:LearnSpell(10161) -- Cone of Cold [Rank 5]
        player:LearnSpell(27087) -- Cone of Cold [Rank 6]
        player:LearnSpell(42930) -- Cone of Cold [Rank 7]
        player:LearnSpell(42931) -- Cone of Cold [Rank 8]
        player:LearnSpell(587) -- Conjure Food [Rank 1]
        player:LearnSpell(597) -- Conjure Food [Rank 2]
        player:LearnSpell(990) -- Conjure Food [Rank 3]
        player:LearnSpell(6129) -- Conjure Food [Rank 4]
        player:LearnSpell(10144) -- Conjure Food [Rank 5]
        player:LearnSpell(10145) -- Conjure Food [Rank 6]
        player:LearnSpell(28612) -- Conjure Food [Rank 7]
        player:LearnSpell(33717) -- Conjure Food [Rank 8]
        player:LearnSpell(759) -- Conjure Mana Gem [Rank 1]
        player:LearnSpell(3552) -- Conjure Mana Gem [Rank 2]
        player:LearnSpell(10053) -- Conjure Mana Gem [Rank 3]
        player:LearnSpell(10054) -- Conjure Mana Gem [Rank 4]
        player:LearnSpell(27101) -- Conjure Mana Gem [Rank 5]
        player:LearnSpell(42985) -- Conjure Mana Gem [Rank 6]
        player:LearnSpell(42955) -- Conjure Refreshment [Rank 1]
        player:LearnSpell(42956) -- Conjure Refreshment [Rank 2]
        player:LearnSpell(5504) -- Conjure Water [Rank 1]
        player:LearnSpell(5505) -- Conjure Water [Rank 2]
        player:LearnSpell(5506) -- Conjure Water [Rank 3]
        player:LearnSpell(6127) -- Conjure Water [Rank 4]
        player:LearnSpell(10138) -- Conjure Water [Rank 5]
        player:LearnSpell(10139) -- Conjure Water [Rank 6]
        player:LearnSpell(10140) -- Conjure Water [Rank 7]
        player:LearnSpell(37420) -- Conjure Water [Rank 8]
        player:LearnSpell(27090) -- Conjure Water [Rank 9]
        player:LearnSpell(2139) -- Counterspell
        player:LearnSpell(61316) -- Dalaran Brilliance [Rank 3]
        player:LearnSpell(61024) -- Dalaran Intellect [Rank 7]
        player:LearnSpell(604) -- Dampen Magic [Rank 1]
        player:LearnSpell(8450) -- Dampen Magic [Rank 2]
        player:LearnSpell(8451) -- Dampen Magic [Rank 3]
        player:LearnSpell(10173) -- Dampen Magic [Rank 4]
        player:LearnSpell(10174) -- Dampen Magic [Rank 5]
        player:LearnSpell(33944) -- Dampen Magic [Rank 6]
        player:LearnSpell(43015) -- Dampen Magic [Rank 7]
        player:LearnSpell(12051) -- Evocation
        player:LearnSpell(2136) -- Fire Blast [Rank 1]
        player:LearnSpell(2137) -- Fire Blast [Rank 2]
        player:LearnSpell(2138) -- Fire Blast [Rank 3]
        player:LearnSpell(8412) -- Fire Blast [Rank 4]
        player:LearnSpell(8413) -- Fire Blast [Rank 5]
        player:LearnSpell(10197) -- Fire Blast [Rank 6]
        player:LearnSpell(10199) -- Fire Blast [Rank 7]
        player:LearnSpell(27078) -- Fire Blast [Rank 8]
        player:LearnSpell(27079) -- Fire Blast [Rank 9]
        player:LearnSpell(42872) -- Fire Blast [Rank 10]
        player:LearnSpell(42873) -- Fire Blast [Rank 11]
        player:LearnSpell(543) -- Fire Ward [Rank 1]
        player:LearnSpell(8457) -- Fire Ward [Rank 2]
        player:LearnSpell(8458) -- Fire Ward [Rank 3]
        player:LearnSpell(10223) -- Fire Ward [Rank 4]
        player:LearnSpell(10225) -- Fire Ward [Rank 5]
        player:LearnSpell(27128) -- Fire Ward [Rank 6]
        player:LearnSpell(43010) -- Fire Ward [Rank 7]
        player:LearnSpell(143) -- Fireball [Rank 2]
        player:LearnSpell(145) -- Fireball [Rank 3]
        player:LearnSpell(3140) -- Fireball [Rank 4]
        player:LearnSpell(8400) -- Fireball [Rank 5]
        player:LearnSpell(8401) -- Fireball [Rank 6]
        player:LearnSpell(8402) -- Fireball [Rank 7]
        player:LearnSpell(10148) -- Fireball [Rank 8]
        player:LearnSpell(10149) -- Fireball [Rank 9]
        player:LearnSpell(10150) -- Fireball [Rank 10]
        player:LearnSpell(10151) -- Fireball [Rank 11]
        player:LearnSpell(25306) -- Fireball [Rank 12]
        player:LearnSpell(27070) -- Fireball [Rank 13]
        player:LearnSpell(38692) -- Fireball [Rank 14]
        player:LearnSpell(42832) -- Fireball [Rank 15]
        player:LearnSpell(42833) -- Fireball [Rank 16]
        player:LearnSpell(2120) -- Flamestrike [Rank 1]
        player:LearnSpell(2121) -- Flamestrike [Rank 2]
        player:LearnSpell(8422) -- Flamestrike [Rank 3]
        player:LearnSpell(8423) -- Flamestrike [Rank 4]
        player:LearnSpell(10215) -- Flamestrike [Rank 5]
        player:LearnSpell(10216) -- Flamestrike [Rank 6]
        player:LearnSpell(27086) -- Flamestrike [Rank 7]
        player:LearnSpell(42925) -- Flamestrike [Rank 8]
        player:LearnSpell(42926) -- Flamestrike [Rank 9]
        player:LearnSpell(7300) -- Frost Armor [Rank 2]
        player:LearnSpell(7301) -- Frost Armor [Rank 3]
        player:LearnSpell(122) -- Frost Nova [Rank 1]
        player:LearnSpell(865) -- Frost Nova [Rank 2]
        player:LearnSpell(6131) -- Frost Nova [Rank 3]
        player:LearnSpell(10230) -- Frost Nova [Rank 4]
        player:LearnSpell(27088) -- Frost Nova [Rank 5]
        player:LearnSpell(42917) -- Frost Nova [Rank 6]
        player:LearnSpell(6143) -- Frost Ward [Rank 1]
        player:LearnSpell(8461) -- Frost Ward [Rank 2]
        player:LearnSpell(8462) -- Frost Ward [Rank 3]
        player:LearnSpell(10177) -- Frost Ward [Rank 4]
        player:LearnSpell(28609) -- Frost Ward [Rank 5]
        player:LearnSpell(32796) -- Frost Ward [Rank 6]
        player:LearnSpell(43012) -- Frost Ward [Rank 7]
        player:LearnSpell(116) -- Frostbolt [Rank 1]
        player:LearnSpell(205) -- Frostbolt [Rank 2]
        player:LearnSpell(837) -- Frostbolt [Rank 3]
        player:LearnSpell(7322) -- Frostbolt [Rank 4]
        player:LearnSpell(8406) -- Frostbolt [Rank 5]
        player:LearnSpell(8407) -- Frostbolt [Rank 6]
        player:LearnSpell(8408) -- Frostbolt [Rank 7]
        player:LearnSpell(10179) -- Frostbolt [Rank 8]
        player:LearnSpell(10180) -- Frostbolt [Rank 9]
        player:LearnSpell(10181) -- Frostbolt [Rank 10]
        player:LearnSpell(25304) -- Frostbolt [Rank 11]
        player:LearnSpell(27071) -- Frostbolt [Rank 12]
        player:LearnSpell(27072) -- Frostbolt [Rank 13]
        player:LearnSpell(38697) -- Frostbolt [Rank 14]
        player:LearnSpell(42841) -- Frostbolt [Rank 15]
        player:LearnSpell(42842) -- Frostbolt [Rank 16]
        player:LearnSpell(44614) -- Frostfire Bolt [Rank 1]
        player:LearnSpell(47610) -- Frostfire Bolt [Rank 2]
        player:LearnSpell(7302) -- Ice Armor [Rank 1]
        player:LearnSpell(7320) -- Ice Armor [Rank 2]
        player:LearnSpell(10219) -- Ice Armor [Rank 3]
        player:LearnSpell(10220) -- Ice Armor [Rank 4]
        player:LearnSpell(27124) -- Ice Armor [Rank 5]
        player:LearnSpell(43008) -- Ice Armor [Rank 6]
        player:LearnSpell(45438) -- Ice Block
        player:LearnSpell(30455) -- Ice Lance [Rank 1]
        player:LearnSpell(42913) -- Ice Lance [Rank 2]
        player:LearnSpell(42914) -- Ice Lance [Rank 3]
        player:LearnSpell(66) -- Invisibility
        player:LearnSpell(6117) -- Mage Armor [Rank 1]
        player:LearnSpell(22782) -- Mage Armor [Rank 2]
        player:LearnSpell(22783) -- Mage Armor [Rank 3]
        player:LearnSpell(27125) -- Mage Armor [Rank 4]
        player:LearnSpell(43023) -- Mage Armor [Rank 5]
        player:LearnSpell(43024) -- Mage Armor [Rank 6]
        player:LearnSpell(1463) -- Mana Shield [Rank 1]
        player:LearnSpell(8494) -- Mana Shield [Rank 2]
        player:LearnSpell(8495) -- Mana Shield [Rank 3]
        player:LearnSpell(10191) -- Mana Shield [Rank 4]
        player:LearnSpell(10192) -- Mana Shield [Rank 5]
        player:LearnSpell(10193) -- Mana Shield [Rank 6]
        player:LearnSpell(27131) -- Mana Shield [Rank 7]
        player:LearnSpell(43019) -- Mana Shield [Rank 8]
        player:LearnSpell(43020) -- Mana Shield [Rank 9]
        player:LearnSpell(55342) -- Mirror Image
        player:LearnSpell(30482) -- Molten Armor [Rank 1]
        player:LearnSpell(43045) -- Molten Armor [Rank 2]
        player:LearnSpell(43046) -- Molten Armor [Rank 3]
        player:LearnSpell(118) -- Polymorph [Rank 1]
        player:LearnSpell(12824) -- Polymorph [Rank 2]
        player:LearnSpell(12825) -- Polymorph [Rank 3]
        player:LearnSpell(12826) -- Polymorph [Rank 4]
        player:LearnSpell(61305) -- Polymorph: Black Cat
        player:LearnSpell(28272) -- Polymorph: Pig
        player:LearnSpell(61721) -- Polymorph: Rabbit
        player:LearnSpell(61780) -- Polymorph: Turkey
        player:LearnSpell(28271) -- Polymorph: Turtle
        player:LearnSpell(53142) -- Portal: Dalaran
                local race = player:GetPlayerRace()
                if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
                        player:LearnSpell(11419) -- Portal: Darnassus
                        player:LearnSpell(32266) -- Portal: Exodar
                        player:LearnSpell(11416) -- Portal: Ironforge
                        player:LearnSpell(33691) -- Portal: Shattrath
                        player:LearnSpell(11059) -- Portal: Stormwind
                        player:LearnSpell(49360) -- Portal: Theramore
                elseif race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
                        player:LearnSpell(11417) -- Portal: Orgrimmar
                        player:LearnSpell(35717) -- Portal: Shattrath
                        player:LearnSpell(32267) -- Portal: Silvermoon
                        player:LearnSpell(49361) -- Portal: Stonard
                        player:LearnSpell(11420) -- Portal: Thunder Bluff
                        player:LearnSpell(11418) -- Portal: Undercity
                end
        player:LearnSpell(475) -- Remove Curse
        player:LearnSpell(43987) -- Ritual of Refreshment [Rank 1]
        player:LearnSpell(58659) -- Ritual of Refreshment [Rank 2]
        player:LearnSpell(2948) -- Scorch [Rank 1]
        player:LearnSpell(8444) -- Scorch [Rank 2]
        player:LearnSpell(8445) -- Scorch [Rank 3]
        player:LearnSpell(8446) -- Scorch [Rank 4]
        player:LearnSpell(10205) -- Scorch [Rank 5]
        player:LearnSpell(10206) -- Scorch [Rank 6]
        player:LearnSpell(10207) -- Scorch [Rank 7]
        player:LearnSpell(27073) -- Scorch [Rank 8]
        player:LearnSpell(27074) -- Scorch [Rank 9]
        player:LearnSpell(42858) -- Scorch [Rank 10]
        player:LearnSpell(42859) -- Scorch [Rank 11]
        player:LearnSpell(130) -- Slow Fall
        player:LearnSpell(30449) -- Spellsteal
        player:LearnSpell(53140) -- Teleport: Dalaran
                local race = player:GetPlayerRace()
                if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
                        player:LearnSpell(3565) -- Teleport: Darnassus
                        player:LearnSpell(32271) -- Teleport: Exodar
                        player:LearnSpell(3562) -- Teleport: Ironforge
                        player:LearnSpell(33690) -- Teleport: Shattrath
                        player:LearnSpell(3561) -- Teleport: Stormwind
                        player:LearnSpell(49359) -- Teleport: Theramore
                elseif race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
                        player:LearnSpell(3567) -- Teleport: Orgrimmar
                        player:LearnSpell(35715) -- Teleport: Shattrath
                        player:LearnSpell(32272) -- Teleport: Silvermoon
                        player:LearnSpell(49358) -- Teleport: Stonard
                        player:LearnSpell(3566) -- Teleport: Thunder Bluff
                        player:LearnSpell(3563) -- Teleport: Undercity
                end
        player:GossipComplete()
end -- End Mage Spells
 
--[Warlock Spells]--
if (intid == 58) then
        player:LearnSpell(6366) -- Create Firestone [Rank 1]
        player:LearnSpell(17951) -- Create Firestone [Rank 2]
        player:LearnSpell(17952) -- Create Firestone [Rank 3]
        player:LearnSpell(17953) -- Create Firestone [Rank 4]
        player:LearnSpell(27250) -- Create Firestone [Rank 5]
        player:LearnSpell(60219) -- Create Firestone [Rank 6]
        player:LearnSpell(60220) -- Create Firestone [Rank 7]
        player:LearnSpell(693) -- Create Soulstone [Rank 1]
        player:LearnSpell(20752) -- Create Soulstone [Rank 2]
        player:LearnSpell(20755) -- Create Soulstone [Rank 3]
        player:LearnSpell(20756) -- Create Soulstone [Rank 4]
        player:LearnSpell(20757) -- Create Soulstone [Rank 5]
        player:LearnSpell(27238) -- Create Soulstone [Rank 6]
        player:LearnSpell(47884) -- Create Soulstone [Rank 7]
        player:LearnSpell(2362) -- Create Spellstone [Rank 1]
        player:LearnSpell(17727) -- Create Spellstone [Rank 2]
        player:LearnSpell(17728) -- Create Spellstone [Rank 3]
        player:LearnSpell(28172) -- Create Spellstone [Rank 4]
        player:LearnSpell(47886) -- Create Spellstone [Rank 5]
        player:LearnSpell(47888) -- Create Spellstone [Rank 6]
        player:LearnSpell(710) -- Banish [Rank 1]
        player:LearnSpell(18647) -- Banish [Rank 2]
        player:LearnSpell(172) -- Corruption [Rank 1]
        player:LearnSpell(6222) -- Corruption [Rank 2]
        player:LearnSpell(6223) -- Corruption [Rank 3]
        player:LearnSpell(7648) -- Corruption [Rank 4]
        player:LearnSpell(11671) -- Corruption [Rank 5]
        player:LearnSpell(11672) -- Corruption [Rank 6]
        player:LearnSpell(25311) -- Corruption [Rank 7]
        player:LearnSpell(27216) -- Corruption [Rank 8]
        player:LearnSpell(47812) -- Corruption [Rank 9]
        player:LearnSpell(47813) -- Corruption [Rank 10]
        player:LearnSpell(6201) -- Create Healthstone [Rank 1]
        player:LearnSpell(6202) -- Create Healthstone [Rank 2]
        player:LearnSpell(5699) -- Create Healthstone [Rank 3]
        player:LearnSpell(11729) -- Create Healthstone [Rank 4]
        player:LearnSpell(11730) -- Create Healthstone [Rank 5]
        player:LearnSpell(27230) -- Create Healthstone [Rank 6]
        player:LearnSpell(47871) -- Create Healthstone [Rank 7]
        player:LearnSpell(47878) -- Create Healthstone [Rank 8]
        player:LearnSpell(980) -- Curse of Agony [Rank 1]
        player:LearnSpell(1014) -- Curse of Agony [Rank 2]
        player:LearnSpell(6217) -- Curse of Agony [Rank 3]
        player:LearnSpell(11711) -- Curse of Agony [Rank 4]
        player:LearnSpell(11712) -- Curse of Agony [Rank 5]
        player:LearnSpell(11713) -- Curse of Agony [Rank 6]
        player:LearnSpell(27218) -- Curse of Agony [Rank 7]
        player:LearnSpell(47863) -- Curse of Agony [Rank 8]
        player:LearnSpell(47864) -- Curse of Agony [Rank 9]
        player:LearnSpell(603) -- Curse of Doom [Rank 1]
        player:LearnSpell(30910) -- Curse of Doom [Rank 2]
        player:LearnSpell(47867) -- Curse of Doom [Rank 3]
        player:LearnSpell(1714) -- Curse of Tongues [Rank 1]
        player:LearnSpell(11719) -- Curse of Tongues [Rank 2]
        player:LearnSpell(702) -- Curse of Weakness [Rank 1]
        player:LearnSpell(1108) -- Curse of Weakness [Rank 2]
        player:LearnSpell(6205) -- Curse of Weakness [Rank 3]
        player:LearnSpell(7646) -- Curse of Weakness [Rank 4]
        player:LearnSpell(11707) -- Curse of Weakness [Rank 5]
        player:LearnSpell(11708) -- Curse of Weakness [Rank 6]
        player:LearnSpell(27224) -- Curse of Weakness [Rank 7]
        player:LearnSpell(30909) -- Curse of Weakness [Rank 8]
        player:LearnSpell(50511) -- Curse of Weakness [Rank 9]
        player:LearnSpell(1490) -- Curse of the Elements [Rank 1]
        player:LearnSpell(11721) -- Curse of the Elements [Rank 2]
        player:LearnSpell(11722) -- Curse of the Elements [Rank 3]
        player:LearnSpell(27228) -- Curse of the Elements [Rank 4]
        player:LearnSpell(47865) -- Curse of the Elements [Rank 5]
        player:LearnSpell(6789) -- Death Coil [Rank 1]
        player:LearnSpell(17925) -- Death Coil [Rank 2]
        player:LearnSpell(17926) -- Death Coil [Rank 3]
        player:LearnSpell(27223) -- Death Coil [Rank 4]
        player:LearnSpell(47859) -- Death Coil [Rank 5]
        player:LearnSpell(47860) -- Death Coil [Rank 6]
        player:LearnSpell(706) -- Demon Armor [Rank 1]
        player:LearnSpell(1086) -- Demon Armor [Rank 2]
        player:LearnSpell(11733) -- Demon Armor [Rank 3]
        player:LearnSpell(11734) -- Demon Armor [Rank 4]
        player:LearnSpell(11735) -- Demon Armor [Rank 5]
        player:LearnSpell(27260) -- Demon Armor [Rank 6]
        player:LearnSpell(47793) -- Demon Armor [Rank 7]
        player:LearnSpell(47889) -- Demon Armor [Rank 8]
        player:LearnSpell(687) -- Demon Skin [Rank 1]
        player:LearnSpell(696) -- Demon Skin [Rank 2]
        player:LearnSpell(48018) -- Demonic Circle: Summon
        player:LearnSpell(48020) -- Demonic Circle: Teleport
        player:LearnSpell(132) -- Detect Invisibility
        player:LearnSpell(689) -- Drain Life [Rank 1]
        player:LearnSpell(699) -- Drain Life [Rank 2]
        player:LearnSpell(709) -- Drain Life [Rank 3]
        player:LearnSpell(7651) -- Drain Life [Rank 4]
        player:LearnSpell(11699) -- Drain Life [Rank 5]
        player:LearnSpell(11700) -- Drain Life [Rank 6]
        player:LearnSpell(27219) -- Drain Life [Rank 7]
        player:LearnSpell(27220) -- Drain Life [Rank 8]
        player:LearnSpell(47857) -- Drain Life [Rank 9]
        player:LearnSpell(5138) -- Drain Mana
        player:LearnSpell(1120) -- Drain Soul [Rank 1]
        player:LearnSpell(8288) -- Drain Soul [Rank 2]
        player:LearnSpell(8289) -- Drain Soul [Rank 3]
        player:LearnSpell(11675) -- Drain Soul [Rank 4]
        player:LearnSpell(27217) -- Drain Soul [Rank 5]
        player:LearnSpell(47855) -- Drain Soul [Rank 6]
        player:LearnSpell(23161) -- Dreadsteed
        player:LearnSpell(1098) -- Enslave Demon [Rank 1]
        player:LearnSpell(11725) -- Enslave Demon [Rank 2]
        player:LearnSpell(11726) -- Enslave Demon [Rank 3]
        player:LearnSpell(61191) -- Enslave Demon [Rank 4]
        player:LearnSpell(126) -- Eye of Kilrogg
        player:LearnSpell(5782) -- Fear [Rank 1]
        player:LearnSpell(6213) -- Fear [Rank 2]
        player:LearnSpell(6215) -- Fear [Rank 3]
        player:LearnSpell(28176) -- Fel Armor [Rank 1]
        player:LearnSpell(28189) -- Fel Armor [Rank 2]
        player:LearnSpell(47892) -- Fel Armor [Rank 3]
        player:LearnSpell(47893) -- Fel Armor [Rank 4]
        player:LearnSpell(5784) -- Felsteed
        player:LearnSpell(755) -- Health Funnel [Rank 1]
        player:LearnSpell(3698) -- Health Funnel [Rank 2]
        player:LearnSpell(3699) -- Health Funnel [Rank 3]
        player:LearnSpell(3700) -- Health Funnel [Rank 4]
        player:LearnSpell(11693) -- Health Funnel [Rank 5]
        player:LearnSpell(11694) -- Health Funnel [Rank 6]
        player:LearnSpell(11695) -- Health Funnel [Rank 7]
        player:LearnSpell(27259) -- Health Funnel [Rank 8]
        player:LearnSpell(47856) -- Health Funnel [Rank 9]
        player:LearnSpell(1949) -- Hellfire [Rank 1]
        player:LearnSpell(11683) -- Hellfire [Rank 2]
        player:LearnSpell(11684) -- Hellfire [Rank 3]
        player:LearnSpell(27213) -- Hellfire [Rank 4]
        player:LearnSpell(47823) -- Hellfire [Rank 5]
        player:LearnSpell(5484) -- Howl of Terror [Rank 1]
        player:LearnSpell(17928) -- Howl of Terror [Rank 2]
        player:LearnSpell(348) -- Immolate [Rank 1]
        player:LearnSpell(707) -- Immolate [Rank 2]
        player:LearnSpell(1094) -- Immolate [Rank 3]
        player:LearnSpell(2941) -- Immolate [Rank 4]
        player:LearnSpell(11665) -- Immolate [Rank 5]
        player:LearnSpell(11667) -- Immolate [Rank 6]
        player:LearnSpell(11668) -- Immolate [Rank 7]
        player:LearnSpell(25309) -- Immolate [Rank 8]
        player:LearnSpell(27215) -- Immolate [Rank 9]
        player:LearnSpell(47810) -- Immolate [Rank 10]
        player:LearnSpell(47811) -- Immolate [Rank 11]
        player:LearnSpell(29722) -- Incinerate [Rank 1]
        player:LearnSpell(32231) -- Incinerate [Rank 2]
        player:LearnSpell(47837) -- Incinerate [Rank 3]
        player:LearnSpell(47838) -- Incinerate [Rank 4]
        player:LearnSpell(1454) -- Life Tap [Rank 1]
        player:LearnSpell(1455) -- Life Tap [Rank 2]
        player:LearnSpell(1456) -- Life Tap [Rank 3]
        player:LearnSpell(11687) -- Life Tap [Rank 4]
        player:LearnSpell(11688) -- Life Tap [Rank 5]
        player:LearnSpell(11689) -- Life Tap [Rank 6]
        player:LearnSpell(27222) -- Life Tap [Rank 7]
        player:LearnSpell(57946) -- Life Tap [Rank 8]
        player:LearnSpell(5740) -- Rain of Fire [Rank 1]
        player:LearnSpell(6219) -- Rain of Fire [Rank 2]
        player:LearnSpell(11677) -- Rain of Fire [Rank 3]
        player:LearnSpell(11678) -- Rain of Fire [Rank 4]
        player:LearnSpell(27212) -- Rain of Fire [Rank 5]
        player:LearnSpell(47819) -- Rain of Fire [Rank 6]
        player:LearnSpell(47820) -- Rain of Fire [Rank 7]
        player:LearnSpell(18540) -- Ritual of Doom
        player:LearnSpell(29893) -- Ritual of Souls [Rank 1]
        player:LearnSpell(58887) -- Ritual of Souls [Rank 2]
        player:LearnSpell(698) -- Ritual of Summoning
        player:LearnSpell(5676) -- Searing Pain [Rank 1]
        player:LearnSpell(17919) -- Searing Pain [Rank 2]
        player:LearnSpell(17920) -- Searing Pain [Rank 3]
        player:LearnSpell(17921) -- Searing Pain [Rank 4]
        player:LearnSpell(17922) -- Searing Pain [Rank 5]
        player:LearnSpell(17923) -- Searing Pain [Rank 6]
        player:LearnSpell(27210) -- Searing Pain [Rank 7]
        player:LearnSpell(30459) -- Searing Pain [Rank 8]
        player:LearnSpell(47814) -- Searing Pain [Rank 9]
        player:LearnSpell(47815) -- Searing Pain [Rank 10]
        player:LearnSpell(27243) -- Seed of Corruption [Rank 1]
        player:LearnSpell(47835) -- Seed of Corruption [Rank 2]
        player:LearnSpell(47836) -- Seed of Corruption [Rank 3]
        player:LearnSpell(5500) -- Sense Demons
        player:LearnSpell(695) -- Shadow Bolt [Rank 2]
        player:LearnSpell(705) -- Shadow Bolt [Rank 3]
        player:LearnSpell(1088) -- Shadow Bolt [Rank 4]
        player:LearnSpell(1106) -- Shadow Bolt [Rank 5]
        player:LearnSpell(7641) -- Shadow Bolt [Rank 6]
        player:LearnSpell(11659) -- Shadow Bolt [Rank 7]
        player:LearnSpell(11660) -- Shadow Bolt [Rank 8]
        player:LearnSpell(11661) -- Shadow Bolt [Rank 9]
        player:LearnSpell(25307) -- Shadow Bolt [Rank 10]
        player:LearnSpell(27209) -- Shadow Bolt [Rank 11]
        player:LearnSpell(47808) -- Shadow Bolt [Rank 12]
        player:LearnSpell(47809) -- Shadow Bolt [Rank 13]
        player:LearnSpell(6229) -- Shadow Ward [Rank 1]
        player:LearnSpell(11739) -- Shadow Ward [Rank 2]
        player:LearnSpell(11740) -- Shadow Ward [Rank 3]
        player:LearnSpell(28610) -- Shadow Ward [Rank 4]
        player:LearnSpell(47890) -- Shadow Ward [Rank 5]
        player:LearnSpell(47891) -- Shadow Ward [Rank 6]
        player:LearnSpell(47897) -- Shadowflame [Rank 1]
        player:LearnSpell(61290) -- Shadowflame [Rank 2]
        player:LearnSpell(6353) -- Soul Fire [Rank 1]
        player:LearnSpell(17924) -- Soul Fire [Rank 2]
        player:LearnSpell(27211) -- Soul Fire [Rank 3]
        player:LearnSpell(30545) -- Soul Fire [Rank 4]
        player:LearnSpell(47824) -- Soul Fire [Rank 5]
        player:LearnSpell(47825) -- Soul Fire [Rank 6]
        player:LearnSpell(29858) -- Soulshatter
        player:LearnSpell(691) -- Summon Felhunter
        player:LearnSpell(688) -- Summon Imp
        player:LearnSpell(712) -- Summon Succubus
        player:LearnSpell(697) -- Summon Voidwalker
        player:LearnSpell(5697) -- Unending Breath
        player:GossipComplete()
end -- End Warlock Spells
 
--[Druid Spells]--
-- Excluded Bear Form since Dire Bear Form replaces it --
if (intid == 59) then
        player:LearnSpell(2893) -- Abolish Poison
        player:LearnSpell(1066) -- Aquatic Form
        player:LearnSpell(22812) -- Barkskin
        player:LearnSpell(5211) -- Bash [Rank 1]
        player:LearnSpell(6798) -- Bash [Rank 2]
        player:LearnSpell(8983) -- Bash [Rank 3]
        player:LearnSpell(768) -- Cat Form
        player:LearnSpell(5209) -- Challenging Roar
        player:LearnSpell(1082) -- Claw [Rank 1]
        player:LearnSpell(3029) -- Claw [Rank 2]
        player:LearnSpell(5201) -- Claw [Rank 3]
        player:LearnSpell(9849) -- Claw [Rank 4]
        player:LearnSpell(9850) -- Claw [Rank 5]
        player:LearnSpell(27000) -- Claw [Rank 6]
        player:LearnSpell(48569) -- Claw [Rank 7]
        player:LearnSpell(48570) -- Claw [Rank 8]
        player:LearnSpell(8998) -- Cower [Rank 1]
        player:LearnSpell(9000) -- Cower [Rank 2]
        player:LearnSpell(9892) -- Cower [Rank 3]
        player:LearnSpell(31709) -- Cower [Rank 4]
        player:LearnSpell(27004) -- Cower [Rank 5]
        player:LearnSpell(48575) -- Cower [Rank 6]
        player:LearnSpell(8946) -- Cure Poison
        player:LearnSpell(33786) -- Cyclone
        player:LearnSpell(1850) -- Dash [Rank 1]
        player:LearnSpell(9821) -- Dash [Rank 2]
        player:LearnSpell(33357) -- Dash [Rank 3]
        player:LearnSpell(99) -- Demoralizing Roar [Rank 1]
        player:LearnSpell(1735) -- Demoralizing Roar [Rank 2]
        player:LearnSpell(9490) -- Demoralizing Roar [Rank 3]
        player:LearnSpell(9747) -- Demoralizing Roar [Rank 4]
        player:LearnSpell(9898) -- Demoralizing Roar [Rank 5]
        player:LearnSpell(26998) -- Demoralizing Roar [Rank 6]
        player:LearnSpell(48559) -- Demoralizing Roar [Rank 7]
        player:LearnSpell(48560) -- Demoralizing Roar [Rank 8]
        player:LearnSpell(9634) -- Dire Bear Form
        player:LearnSpell(5229) -- Enrage
        player:LearnSpell(339) -- Entangling Roots [Rank 1]
        player:LearnSpell(1062) -- Entangling Roots [Rank 2]
        player:LearnSpell(5195) -- Entangling Roots [Rank 3]
        player:LearnSpell(5196) -- Entangling Roots [Rank 4]
        player:LearnSpell(9852) -- Entangling Roots [Rank 5]
        player:LearnSpell(9853) -- Entangling Roots [Rank 6]
        player:LearnSpell(26989) -- Entangling Roots [Rank 7]
        player:LearnSpell(53308) -- Entangling Roots [Rank 8]
        player:LearnSpell(770) -- Faerie Fire
        player:LearnSpell(16857) -- Faerie Fire (Feral)
        player:LearnSpell(20719) -- Feline Grace 
        player:LearnSpell(16979) -- Feral Charge - Bear
        player:LearnSpell(49376) -- Feral Charge - Cat 
        player:LearnSpell(22568) -- Ferocious Bite [Rank 1]
        player:LearnSpell(22827) -- Ferocious Bite [Rank 2]
        player:LearnSpell(22828) -- Ferocious Bite [Rank 3]
        player:LearnSpell(22829) -- Ferocious Bite [Rank 4]
        player:LearnSpell(31018) -- Ferocious Bite [Rank 5]
        player:LearnSpell(24248) -- Ferocious Bite [Rank 6]
        player:LearnSpell(48576) -- Ferocious Bite [Rank 7]
        player:LearnSpell(48577) -- Ferocious Bite [Rank 8]
        player:LearnSpell(33943) -- Flight Form
        player:LearnSpell(22842) -- Frenzied Regeneration [Rank 1]
        player:LearnSpell(21849) -- Gift of the Wild [Rank 1]
        player:LearnSpell(21850) -- Gift of the Wild [Rank 2]
        player:LearnSpell(26991) -- Gift of the Wild [Rank 3]
        player:LearnSpell(48470) -- Gift of the Wild [Rank 4]
        player:LearnSpell(6795) -- Growl 
        player:LearnSpell(5186) -- Healing Touch [Rank 2]
        player:LearnSpell(5187) -- Healing Touch [Rank 3]
        player:LearnSpell(5188) -- Healing Touch [Rank 4]
        player:LearnSpell(5189) -- Healing Touch [Rank 5]
        player:LearnSpell(6778) -- Healing Touch [Rank 6]
        player:LearnSpell(8903) -- Healing Touch [Rank 7]
        player:LearnSpell(9758) -- Healing Touch [Rank 8]
        player:LearnSpell(9888) -- Healing Touch [Rank 9]
        player:LearnSpell(9889) -- Healing Touch [Rank 10]
        player:LearnSpell(25297) -- Healing Touch [Rank 11]
        player:LearnSpell(26978) -- Healing Touch [Rank 12]
        player:LearnSpell(26979) -- Healing Touch [Rank 13]
        player:LearnSpell(48377) -- Healing Touch [Rank 14]
        player:LearnSpell(48378) -- Healing Touch [Rank 15]
        player:LearnSpell(2637) -- Hibernate [Rank 1]
        player:LearnSpell(18657) -- Hibernate [Rank 2]
        player:LearnSpell(18658) -- Hibernate [Rank 3]
        player:LearnSpell(16914) -- Hurricane [Rank 1]
        player:LearnSpell(17401) -- Hurricane [Rank 2]
        player:LearnSpell(17402) -- Hurricane [Rank 3]
        player:LearnSpell(27012) -- Hurricane [Rank 4]
        player:LearnSpell(48467) -- Hurricane [Rank 5]
        player:LearnSpell(29166) -- Innervate
        player:LearnSpell(33745) -- Lacerate [Rank 1]
        player:LearnSpell(48567) -- Lacerate [Rank 2]
        player:LearnSpell(48568) -- Lacerate [Rank 3]
        player:LearnSpell(33763) -- Lifebloom [Rank 1]
        player:LearnSpell(48450) -- Lifebloom [Rank 2]
        player:LearnSpell(48451) -- Lifebloom [Rank 3]
        player:LearnSpell(22570) -- Maim [Rank 1]
        player:LearnSpell(49802) -- Maim [Rank 2]
        player:LearnSpell(33878) -- Mangle (Bear) [Rank 1]
        player:LearnSpell(33986) -- Mangle (Bear) [Rank 2]
        player:LearnSpell(33987) -- Mangle (Bear) [Rank 3]
        player:LearnSpell(48563) -- Mangle (Bear) [Rank 4]
        player:LearnSpell(48564) -- Mangle (Bear) [Rank 5]
        player:LearnSpell(33876) -- Mangle (Cat) [Rank 1]
        player:LearnSpell(33982) -- Mangle (Cat) [Rank 2]
        player:LearnSpell(33983) -- Mangle (Cat) [Rank 3]
        player:LearnSpell(48565) -- Mangle (Cat) [Rank 4]
        player:LearnSpell(48566) -- Mangle (Cat) [Rank 5]
        player:LearnSpell(1126) -- Mark of the Wild [Rank 1]
        player:LearnSpell(5232) -- Mark of the Wild [Rank 2]
        player:LearnSpell(6756) -- Mark of the Wild [Rank 3]
        player:LearnSpell(5234) -- Mark of the Wild [Rank 4]
        player:LearnSpell(8907) -- Mark of the Wild [Rank 5]
        player:LearnSpell(9884) -- Mark of the Wild [Rank 6]
        player:LearnSpell(9885) -- Mark of the Wild [Rank 7]
        player:LearnSpell(26990) -- Mark of the Wild [Rank 8]
        player:LearnSpell(48469) -- Mark of the Wild [Rank 9]
        player:LearnSpell(6807) -- Maul [Rank 1]
        player:LearnSpell(6808) -- Maul [Rank 2]
        player:LearnSpell(6809) -- Maul [Rank 3]
        player:LearnSpell(8972) -- Maul [Rank 4]
        player:LearnSpell(9745) -- Maul [Rank 5]
        player:LearnSpell(9880) -- Maul [Rank 6]
        player:LearnSpell(9881) -- Maul [Rank 7]
        player:LearnSpell(26996) -- Maul [Rank 8]
        player:LearnSpell(48479) -- Maul [Rank 9]
        player:LearnSpell(48480) -- Maul [Rank 10]
        player:LearnSpell(8921) -- Moonfire [Rank 1]
        player:LearnSpell(8924) -- Moonfire [Rank 2]
        player:LearnSpell(8925) -- Moonfire [Rank 3]
        player:LearnSpell(8926) -- Moonfire [Rank 4]
        player:LearnSpell(8927) -- Moonfire [Rank 5]
        player:LearnSpell(8928) -- Moonfire [Rank 6]
        player:LearnSpell(8929) -- Moonfire [Rank 7]
        player:LearnSpell(9833) -- Moonfire [Rank 8]
        player:LearnSpell(9834) -- Moonfire [Rank 9]
        player:LearnSpell(9835) -- Moonfire [Rank 10]
        player:LearnSpell(26987) -- Moonfire [Rank 11]
        player:LearnSpell(26988) -- Moonfire [Rank 12]
        player:LearnSpell(48462) -- Moonfire [Rank 13]
        player:LearnSpell(48463) -- Moonfire [Rank 14]
        player:LearnSpell(16689) -- Nature's Grasp [Rank 1]
        player:LearnSpell(16810) -- Nature's Grasp [Rank 2]
        player:LearnSpell(16811) -- Nature's Grasp [Rank 3]
        player:LearnSpell(16812) -- Nature's Grasp [Rank 4]
        player:LearnSpell(16813) -- Nature's Grasp [Rank 5]
        player:LearnSpell(17329) -- Nature's Grasp [Rank 6]
        player:LearnSpell(27009) -- Nature's Grasp [Rank 7]
        player:LearnSpell(53312) -- Nature's Grasp [Rank 8]
        player:LearnSpell(50464) -- Nourish [Rank 1]
        player:LearnSpell(9005) -- Pounce [Rank 1]
        player:LearnSpell(9823) -- Pounce [Rank 2]
        player:LearnSpell(9827) -- Pounce [Rank 3]
        player:LearnSpell(27006) -- Pounce [Rank 4]
        player:LearnSpell(49803) -- Pounce [Rank 5]
        player:LearnSpell(5215) -- Prowl [Rank 1]
        player:LearnSpell(6783) -- Prowl [Rank 2]
        player:LearnSpell(9913) -- Prowl [Rank 3]
        player:LearnSpell(1822) -- Rake [Rank 1]
        player:LearnSpell(1823) -- Rake [Rank 2]
        player:LearnSpell(1824) -- Rake [Rank 3]
        player:LearnSpell(9904) -- Rake [Rank 4]
        player:LearnSpell(27003) -- Rake [Rank 5]
        player:LearnSpell(48573) -- Rake [Rank 6]
        player:LearnSpell(48574) -- Rake [Rank 7]
        player:LearnSpell(6785) -- Ravage [Rank 1]
        player:LearnSpell(6787) -- Ravage [Rank 2]
        player:LearnSpell(9866) -- Ravage [Rank 3]
        player:LearnSpell(9867) -- Ravage [Rank 4]
        player:LearnSpell(27005) -- Ravage [Rank 5]
        player:LearnSpell(48578) -- Ravage [Rank 6]
        player:LearnSpell(48579) -- Ravage [Rank 7]
        player:LearnSpell(20484) -- Rebirth [Rank 1]
        player:LearnSpell(20739) -- Rebirth [Rank 2]
        player:LearnSpell(20742) -- Rebirth [Rank 3]
        player:LearnSpell(20747) -- Rebirth [Rank 4]
        player:LearnSpell(20748) -- Rebirth [Rank 5]
        player:LearnSpell(26994) -- Rebirth [Rank 6]
        player:LearnSpell(48477) -- Rebirth [Rank 7]
        player:LearnSpell(8936) -- Regrowth [Rank 1]
        player:LearnSpell(8938) -- Regrowth [Rank 2]
        player:LearnSpell(8939) -- Regrowth [Rank 3]
        player:LearnSpell(8940) -- Regrowth [Rank 4]
        player:LearnSpell(8941) -- Regrowth [Rank 5]
        player:LearnSpell(9750) -- Regrowth [Rank 6]
        player:LearnSpell(9856) -- Regrowth [Rank 7]
        player:LearnSpell(9857) -- Regrowth [Rank 8]
        player:LearnSpell(9858) -- Regrowth [Rank 9]
        player:LearnSpell(26980) -- Regrowth [Rank 10]
        player:LearnSpell(48442) -- Regrowth [Rank 11]
        player:LearnSpell(48443) -- Regrowth [Rank 12]
        player:LearnSpell(774) -- Rejuvenation [Rank 1]
        player:LearnSpell(1058) -- Rejuvenation [Rank 2]
        player:LearnSpell(1430) -- Rejuvenation [Rank 3]
        player:LearnSpell(2090) -- Rejuvenation [Rank 4]
        player:LearnSpell(2091) -- Rejuvenation [Rank 5]
        player:LearnSpell(3627) -- Rejuvenation [Rank 6]
        player:LearnSpell(8910) -- Rejuvenation [Rank 7]
        player:LearnSpell(9839) -- Rejuvenation [Rank 8]
        player:LearnSpell(9840) -- Rejuvenation [Rank 9]
        player:LearnSpell(9841) -- Rejuvenation [Rank 10]
        player:LearnSpell(25299) -- Rejuvenation [Rank 11]
        player:LearnSpell(26981) -- Rejuvenation [Rank 12]
        player:LearnSpell(26982) -- Rejuvenation [Rank 13]
        player:LearnSpell(48440) -- Rejuvenation [Rank 14]
        player:LearnSpell(48441) -- Rejuvenation [Rank 15]
        player:LearnSpell(2782) -- Remove Curse
        player:LearnSpell(50769) -- Revive [Rank 1]
        player:LearnSpell(50768) -- Revive [Rank 2]
        player:LearnSpell(50767) -- Revive [Rank 3]
        player:LearnSpell(50766) -- Revive [Rank 4]
        player:LearnSpell(50765) -- Revive [Rank 5]
        player:LearnSpell(50764) -- Revive [Rank 6]
        player:LearnSpell(50763) -- Revive [Rank 7]
        player:LearnSpell(1079) -- Rip [Rank 1]
        player:LearnSpell(9492) -- Rip [Rank 2]
        player:LearnSpell(9493) -- Rip [Rank 3]
        player:LearnSpell(9752) -- Rip [Rank 4]
        player:LearnSpell(9894) -- Rip [Rank 5]
        player:LearnSpell(9896) -- Rip [Rank 6]
        player:LearnSpell(27008) -- Rip [Rank 7]
        player:LearnSpell(49799) -- Rip [Rank 8]
        player:LearnSpell(49800) -- Rip [Rank 9]
        player:LearnSpell(62600) -- Savage Defense
        player:LearnSpell(52610) -- Savage Roar [Rank 1]
        player:LearnSpell(5221) -- Shred [Rank 1]
        player:LearnSpell(6800) -- Shred [Rank 2]
        player:LearnSpell(8992) -- Shred [Rank 3]
        player:LearnSpell(9829) -- Shred [Rank 4]
        player:LearnSpell(9830) -- Shred [Rank 5]
        player:LearnSpell(27001) -- Shred [Rank 6]
        player:LearnSpell(27002) -- Shred [Rank 7]
        player:LearnSpell(48571) -- Shred [Rank 8]
        player:LearnSpell(48572) -- Shred [Rank 9]
        player:LearnSpell(2908) -- Soothe Animal [Rank 1]
        player:LearnSpell(8955) -- Soothe Animal [Rank 2]
        player:LearnSpell(9901) -- Soothe Animal [Rank 3]
        player:LearnSpell(26995) -- Soothe Animal [Rank 4]
        player:LearnSpell(2912) -- Starfire [Rank 1]
        player:LearnSpell(8949) -- Starfire [Rank 2]
        player:LearnSpell(8950) -- Starfire [Rank 3]
        player:LearnSpell(8951) -- Starfire [Rank 4]
        player:LearnSpell(9875) -- Starfire [Rank 5]
        player:LearnSpell(9876) -- Starfire [Rank 6]
        player:LearnSpell(25298) -- Starfire [Rank 7]
        player:LearnSpell(26986) -- Starfire [Rank 8]
        player:LearnSpell(48464) -- Starfire [Rank 9]
        player:LearnSpell(48465) -- Starfire [Rank 10]
        player:LearnSpell(40120) -- Swift Flight Form
        player:LearnSpell(779) -- Swipe (Bear) [Rank 1]
        player:LearnSpell(780) -- Swipe (Bear) [Rank 2]
        player:LearnSpell(769) -- Swipe (Bear) [Rank 3]
        player:LearnSpell(9754) -- Swipe (Bear) [Rank 4]
        player:LearnSpell(9908) -- Swipe (Bear) [Rank 5]
        player:LearnSpell(26997) -- Swipe (Bear) [Rank 6]
        player:LearnSpell(48561) -- Swipe (Bear) [Rank 7]
        player:LearnSpell(48562) -- Swipe (Bear) [Rank 8]
        player:LearnSpell(62078) -- Swipe (Cat) [Rank 1]
        player:LearnSpell(18960) -- Teleport: Moonglade
        player:LearnSpell(467) -- Thorns [Rank 1]
        player:LearnSpell(782) -- Thorns [Rank 2]
        player:LearnSpell(1075) -- Thorns [Rank 3]
        player:LearnSpell(8914) -- Thorns [Rank 4]
        player:LearnSpell(9756) -- Thorns [Rank 5]
        player:LearnSpell(9910) -- Thorns [Rank 6]
        player:LearnSpell(26992) -- Thorns [Rank 7]
        player:LearnSpell(53307) -- Thorns [Rank 8]
        player:LearnSpell(5217) -- Tiger's Fury [Rank 1]
        player:LearnSpell(6793) -- Tiger's Fury [Rank 2]
        player:LearnSpell(9845) -- Tiger's Fury [Rank 3]
        player:LearnSpell(9846) -- Tiger's Fury [Rank 4]
        player:LearnSpell(50212) -- Tiger's Fury [Rank 5]
        player:LearnSpell(50213) -- Tiger's Fury [Rank 6]
        player:LearnSpell(5225) -- Track Humanoids
        player:LearnSpell(740) -- Tranquility [Rank 1]
        player:LearnSpell(8918) -- Tranquility [Rank 2]
        player:LearnSpell(9862) -- Tranquility [Rank 3]
        player:LearnSpell(9863) -- Tranquility [Rank 4]
        player:LearnSpell(26983) -- Tranquility [Rank 5]
        player:LearnSpell(48446) -- Tranquility [Rank 6]
        player:LearnSpell(48447) -- Tranquility [Rank 7]
        player:LearnSpell(783) -- Travel Form
        player:LearnSpell(5177) -- Wrath [Rank 2]
        player:LearnSpell(5178) -- Wrath [Rank 3]
        player:LearnSpell(5179) -- Wrath [Rank 4]
        player:LearnSpell(5180) -- Wrath [Rank 5]
        player:LearnSpell(6780) -- Wrath [Rank 6]
        player:LearnSpell(8905) -- Wrath [Rank 7]
        player:LearnSpell(9912) -- Wrath [Rank 8]
        player:LearnSpell(26984) -- Wrath [Rank 9]
        player:LearnSpell(26985) -- Wrath [Rank 10]
        player:LearnSpell(48459) -- Wrath [Rank 11]
        player:LearnSpell(48461) -- Wrath [Rank 12]
        player:GossipComplete()
end
 
if (intid == 200) then     
        player:AdvanceSkill (43, 399) 
        player:AdvanceSkill (44, 399) 
        player:AdvanceSkill (45, 399)
        player:AdvanceSkill (46, 399) 
        player:AdvanceSkill (54, 399) 
        player:AdvanceSkill (55, 399) 
        player:AdvanceSkill (95, 399) 
        player:AdvanceSkill (136, 399) 
        player:AdvanceSkill (160, 399) 
        player:AdvanceSkill (162, 399) 
        player:AdvanceSkill (172, 399)
        player:AdvanceSkill (173, 399) 
        player:AdvanceSkill (176, 399) 
        player:AdvanceSkill (226, 399) 
        player:AdvanceSkill (228, 399) 
        player:AdvanceSkill (229, 399) 
        player:AdvanceSkill (473, 399)
end
 
if (intid == 300) then
    Trainer:GossipCreateMenu(54, player, 0)
        if (player:GetPlayerClass() == "Warrior") then
                Trainer:GossipMenuAddItem(0, "Learn all Warrior Talent Spells.", 225, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
                                
        end
        if (player:GetPlayerClass() == "Paladin") then
                Trainer:GossipMenuAddItem(0, "Learn all Paladin Talent Spells.", 226, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Hunter") then
                Trainer:GossipMenuAddItem(0, "Learn all Hunter Talent Spells.", 227, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Rogue") then
                Trainer:GossipMenuAddItem(0, "Learn all Rogue Talent Spells.", 228, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Priest") then
                Trainer:GossipMenuAddItem(0, "Learn all Priest Talent Spells.", 229, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Death Knight") then
                Trainer:GossipMenuAddItem(0, "Learn all Death Knight Talent Spells.", 230, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Shaman") then
                Trainer:GossipMenuAddItem(0, "Learn all Shaman Talent Spells.", 231, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Mage") then
                Trainer:GossipMenuAddItem(0, "Learn all Mage Talent Spells.", 232, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Warlock") then
                Trainer:GossipMenuAddItem(0, "Learn all Warlock Talent Spells.", 233, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        if (player:GetPlayerClass() == "Druid") then
                Trainer:GossipMenuAddItem(0, "Learn all Druid Talent Spells.", 234, 0)
                                Trainer:GossipMenuAddItem(0, "I was looking for something else.", 485, 0)
        end
        Trainer:GossipSendMenu(player)
end
 
if (intid == 225) then
        if player:HasSpell(12294) then
                player:LearnSpell(21551)
                player:LearnSpell(21552)
                player:LearnSpell(21553)
                player:LearnSpell(25248)
                player:LearnSpell(30330)
                player:LearnSpell(47485)
                player:LearnSpell(47486)
        end
        if player:HasSpell(20243) then
                player:LearnSpell(30016)
                player:LearnSpell(30022)
                player:LearnSpell(47497)
                player:LearnSpell(47498)
        end
        player:GossipComplete()
end
 
if (intid == 226) then
        if player:HasSpell(31935) then
                player:LearnSpell(32699)
                player:LearnSpell(32700)
                player:LearnSpell(48826)
                player:LearnSpell(48827)
        end
        if player:HasSpell(20925) then
                player:LearnSpell(20927)
                player:LearnSpell(20928)
                player:LearnSpell(27179)
                player:LearnSpell(48951)
                player:LearnSpell(48952)
        end
        if player:HasSpell(20473) then
                player:LearnSpell(20929)
                player:LearnSpell(20930)
                player:LearnSpell(27174)
                player:LearnSpell(33072)
                player:LearnSpell(48824)
                player:LearnSpell(48825)
        end
        player:GossipComplete()
end
 
if (intid == 227) then
        if player:HasSpell(19434) then
                player:LearnSpell(20900)
                player:LearnSpell(20901)
                player:LearnSpell(20902)
                player:LearnSpell(20903)
                player:LearnSpell(20904)
                player:LearnSpell(27065)
                player:LearnSpell(49049)
                player:LearnSpell(49050)
        end
        if player:HasSpell(19306) then
                player:LearnSpell(20909)
                player:LearnSpell(20910)
                player:LearnSpell(27067)
                player:LearnSpell(48998)
                player:LearnSpell(48999)
        end
        if player:HasSpell(53301) then
                player:LearnSpell(60051)
                player:LearnSpell(60052)
                player:LearnSpell(60053)
        end
        if player:HasSpell(19386) then
                player:LearnSpell(24132)
                player:LearnSpell(24133)
                player:LearnSpell(27068)
                player:LearnSpell(49011)
                player:LearnSpell(49012)
        end
        player:GossipComplete()
end
 
if (intid == 228) then
        if player:HasSpell(16511) then
                player:LearnSpell(17347)
                player:LearnSpell(17348)
                player:LearnSpell(26864)
                player:LearnSpell(48660)
        end
        if player:HasSpell(1329) then
                player:LearnSpell(34411)
                player:LearnSpell(34412)
                player:LearnSpell(34413)
                player:LearnSpell(48663)
                player:LearnSpell(48666)
        end
        player:GossipComplete()
end
 
if (intid == 229) then
        if player:HasSpell(34861) then
                player:LearnSpell(34863)
                player:LearnSpell(34864)
                player:LearnSpell(34865)
                player:LearnSpell(34866)
                player:LearnSpell(48088)
                player:LearnSpell(48089)
        end
        if player:HasSpell(19236) then
                player:LearnSpell(19238)
                player:LearnSpell(19240)
                player:LearnSpell(19241)
                player:LearnSpell(19242)
                player:LearnSpell(19243)
                player:LearnSpell(25437)
                player:LearnSpell(48172)
                player:LearnSpell(48173)
        end
        if player:HasSpell(724) then
                player:LearnSpell(27870)
                player:LearnSpell(27871)
                player:LearnSpell(28275)
                player:LearnSpell(48086)
                player:LearnSpell(48087)
        end
        if player:HasSpell(15407) then
                player:LearnSpell(17311)
                player:LearnSpell(17312)
                player:LearnSpell(17313)
                player:LearnSpell(17314)
                player:LearnSpell(18807)
                player:LearnSpell(25387)
                player:LearnSpell(48155)
                player:LearnSpell(48156)
        end
        if player:HasSpell(47540) then
                player:LearnSpell(53005)
                player:LearnSpell(53006)
                player:LearnSpell(53007)
        end
        if player:HasSpell(34914) then
                player:LearnSpell(34916)
                player:LearnSpell(34917)
                player:LearnSpell(48159)
                player:LearnSpell(48160)
        end
        player:GossipComplete()
end
 
if (intid == 230) then
        if player:HasSpell(49158) then
                player:LearnSpell(51325)
                player:LearnSpell(51326)
                player:LearnSpell(51327)
                player:LearnSpell(51328)
        end
        if player:HasSpell(49143) then
                player:LearnSpell(51416)
                player:LearnSpell(51417)
                player:LearnSpell(51418)
                player:LearnSpell(51419)
                player:LearnSpell(55268)
        end
        if player:HasSpell(55050) then
                player:LearnSpell(55258)
                player:LearnSpell(55259)
                player:LearnSpell(55260)
                player:LearnSpell(55261)
                player:LearnSpell(55262)
        end
        if player:HasSpell(49184) then
                player:LearnSpell(51409)
                player:LearnSpell(51410)
                player:LearnSpell(51411)
        end
        if player:HasSpell(55090) then
                player:LearnSpell(55265)
                player:LearnSpell(55270)
                player:LearnSpell(55271)
        end
        player:GossipComplete()
end
 
if (intid == 231) then
        if player:HasSpell(974) then
                player:LearnSpell(32593)
                player:LearnSpell(32594)
                player:LearnSpell(49283)
                player:LearnSpell(49284)
        end
        if player:HasSpell(61295) then
                player:LearnSpell(61299)
                player:LearnSpell(61300)
                player:LearnSpell(61301)
        end
        if player:HasSpell(51490) then
                player:LearnSpell(59156)
                player:LearnSpell(59158)
                player:LearnSpell(59159)
        end
        if player:HasSpell(30706) then
                player:LearnSpell(57720)
                player:LearnSpell(57721)
                player:LearnSpell(57722)
        end
        player:GossipComplete()
end
 
if (intid == 232) then
        if player:HasSpell(44425) then
                player:LearnSpell(44780)
                player:LearnSpell(44781)
        end
        if player:HasSpell(11113) then
                player:LearnSpell(13018)
                player:LearnSpell(13019)
                player:LearnSpell(13020)
                player:LearnSpell(13021)
                player:LearnSpell(27133)
                player:LearnSpell(33933)
                player:LearnSpell(42944)
                player:LearnSpell(42945)
        end
        if player:HasSpell(31611) then
                player:LearnSpell(33041)
                player:LearnSpell(33042)
                player:LearnSpell(33043)
                player:LearnSpell(42949)
                player:LearnSpell(42950)
        end
        if player:HasSpell(11426) then
                player:LearnSpell(13031)
                player:LearnSpell(13032)
                player:LearnSpell(13033)
                player:LearnSpell(27134)
                player:LearnSpell(33405)
                player:LearnSpell(43038)
                player:LearnSpell(43039)
        end
        if player:HasSpell(44457) then
                player:LearnSpell(55359)
                player:LearnSpell(55360)
        end
        if player:HasSpell(11366) then
                player:LearnSpell(12505)
                player:LearnSpell(12522)
                player:LearnSpell(12523)
                player:LearnSpell(12524)
                player:LearnSpell(12525)
                player:LearnSpell(12526)
                player:LearnSpell(18809)
                player:LearnSpell(27132)
                player:LearnSpell(33938)
                player:LearnSpell(42890)
                player:LearnSpell(42891)
        end
        player:GossipComplete()
end
 
if (intid == 233) then
        if player:HasSpell(50796) then
                player:LearnSpell(59170)
                player:LearnSpell(59171)
                player:LearnSpell(59172)
        end
        if player:HasSpell(18220) then
                player:LearnSpell(18937)
                player:LearnSpell(18938)
                player:LearnSpell(27265)
                player:LearnSpell(59092)
        end
        if player:HasSpell(48181) then
                player:LearnSpell(59161)
                player:LearnSpell(59163)
                player:LearnSpell(59164)
        end
        if player:HasSpell(17877) then
                player:LearnSpell(18867)
                player:LearnSpell(18868)
                player:LearnSpell(18869)
                player:LearnSpell(18870)
                player:LearnSpell(18871)
                player:LearnSpell(27263)
                player:LearnSpell(30546)
                player:LearnSpell(47826)
                player:LearnSpell(27827)
        end
        if player:HasSpell(30283) then
                player:LearnSpell(30413)
                player:LearnSpell(30414)
                player:LearnSpell(47846)
                player:LearnSpell(47847)
        end
        if player:HasSpell(30108) then
                player:LearnSpell(30404)
                player:LearnSpell(30405)
                player:LearnSpell(47841)
                player:LearnSpell(47843)
        end
        player:GossipComplete()
end
 
if (intid == 234) then
        if player:HasSpell(5570) then
                player:LearnSpell(24974)
                player:LearnSpell(24975)
                player:LearnSpell(24976)
                player:LearnSpell(24977)
                player:LearnSpell(27013)
                player:LearnSpell(48468)
        end
        if player:HasSpell(33878) then
                player:LearnSpell(33986)
                player:LearnSpell(33987)
                player:LearnSpell(48563)
                player:LearnSpell(48564)
        end
        if player:HasSpell(33876) then
                player:LearnSpell(33982)
                player:LearnSpell(33983)
                player:LearnSpell(48565)
                player:LearnSpell(48566)
        end
        if player:HasSpell(48505) then
                player:LearnSpell(53199)
                player:LearnSpell(53200)
                player:LearnSpell(53201)
        end
        if player:HasSpell(50516) then
                player:LearnSpell(53223)
                player:LearnSpell(53225)
                player:LearnSpell(53226)
                player:LearnSpell(61384)
        end
        if player:HasSpell(48438) then
                player:LearnSpell(53248)
                player:LearnSpell(53249)
                player:LearnSpell(53251)
        end
        player:GossipComplete()
end
 
if (intid == 400) then
        player:ResetTalents()
        player:GossipComplete(player)
end
 
if (intid == 485) then
        player:GossipComplete(player)
end
 
end
 
RegisterUnitGossipEvent(TrainerEntryID, 1, "Trainer_OnTalk")
RegisterUnitGossipEvent(TrainerEntryID, 2, "Trainer_OnSubmenus")