function On_GossipMenu(unit, event, player)

    if (player:IsInCombat() == true) then
    unit:SendChatMessage(12, 0, "I'm afraid I can't help you. If i healed you in combat, it would be cheating!")
    else
    unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(4,"Heals", 1, 0)
    unit:GossipMenuAddItem(4,"Buffs", 2, 0)
    unit:GossipMenuAddItem(4,"Morphs", 3, 0)
    unit:GossipSendMenu(player)
    end
end

function On_GossipSelect(unit, event, player, id, intid, code)

    if (intid == 1) then
    unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(5,"Cast: Holy Light", 10, 0)
    unit:GossipMenuAddItem(5,"Cast: Healing Wave", 11, 0)
    unit:GossipMenuAddItem(5,"Cast: Renew", 12, 0)
    unit:GossipMenuAddItem(5,"Remove Resurrection Sickness", 13, 0)
    unit:GossipMenuAddItem(4,"[Back to Main Menu]", 999, 0)
    unit:GossipSendMenu(player)
    end

    if (intid == 10) then
    unit:FullCastSpellOnTarget(27136, player)
    player:GossipComplete()
    end

    if (intid == 11) then
    unit:FullCastSpellOnTarget(25396, player)
    player:GossipComplete()
    end

    if (intid == 12) then
    unit:FullCastSpellOnTarget(25222, player)
    player:GossipComplete()
    end

    if (intid == 13) then
    player:LearnSpell(15007)
    player:UnlearnSpell(15007)
    player:GossipComplete()
    end

    if (intid == 2) then
    unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(5,"Strength", 20, 0)
    unit:GossipMenuAddItem(5,"Stamina", 21, 0)
    unit:GossipMenuAddItem(5,"Agility", 22, 0)
    unit:GossipMenuAddItem(5,"Intellect", 23, 0)
    unit:GossipMenuAddItem(5,"Protection", 24, 0)
    unit:GossipMenuAddItem(5,"Spirit", 25, 0)
    unit:GossipMenuAddItem(5,"Songflower Serenade", 26, 0)
    unit:GossipMenuAddItem(5,"Blessing of Kings (10% Stats)", 27, 0)
    unit:GossipMenuAddItem(4,"[Back to Main Menu]", 999, 0)
    unit:GossipSendMenu(player)
    end

    if (intid == 20) then
    unit:FullCastSpellOnTarget(33082, player)
    player:GossipComplete()
    end

    if (intid == 21) then
    unit:FullCastSpellOnTarget(33081, player)
    player:GossipComplete()
    end

    if (intid == 22) then
    unit:FullCastSpellOnTarget(33077, player)
    player:GossipComplete()
    end

    if (intid == 23) then
    unit:FullCastSpellOnTarget(33078, player)
    player:GossipComplete()
    end

    if (intid == 24) then
    unit:FullCastSpellOnTarget(33079, player)
    player:GossipComplete()
    end

    if (intid == 25) then
    unit:FullCastSpellOnTarget(33080, player)
    player:GossipComplete()
    end

    if (intid == 26) then
    unit:FullCastSpellOnTarget(15366, player)
    player:GossipComplete()
    end

    if (intid == 27) then
    unit:FullCastSpellOnTarget(20217, player)
    player:GossipComplete()
    end

    if (intid == 3) then
    unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(5,"Benny Questgiver", 50, 0)
    unit:GossipMenuAddItem(5,"Illidan", 51, 0)
    unit:GossipMenuAddItem(5,"Hogger", 52, 0)
    unit:GossipMenuAddItem(5,"Pit Commander", 53, 0)
    unit:GossipMenuAddItem(5,"Wrath Master", 54, 0)
    unit:GossipMenuAddItem(5,"Tagar Spinebreaker", 55, 0)
    unit:GossipMenuAddItem(5,"Merciles Dragon", 56, 0)
    unit:GossipMenuAddItem(5,"Ravager", 57, 0)
    unit:GossipMenuAddItem(5,"Tauren", 58, 0)
    unit:GossipMenuAddItem(5,"Worm", 59, 0)
    unit:GossipMenuAddItem(5,"A Hydra!", 60, 0)
    unit:GossipMenuAddItem(4,"[Next]", 997, 0)
    unit:GossipMenuAddItem(4,"[Demorph]", 998, 0)
    unit:GossipMenuAddItem(4,"[Back to Main Menu]", 999, 0)
    unit:GossipSendMenu(player)
    end

    if (intid == 50) then
    player:SetModel(6074)
    player:GossipComplete()
    end

    if (intid == 51) then
    player:SetModel(21135)
    player:GossipComplete()
    end

    if (intid == 52) then
    player:SetModel(384)
    player:GossipComplete()
    end

    if (intid == 53) then
    player:SetModel(18622)
    player:GossipComplete()
    end

    if (intid == 54) then
    player:SetModel(18531)
    player:GossipComplete()
    end

    if (intid == 55) then
    player:SetModel(21025)
    player:GossipComplete()
    end

    if (intid == 56) then
    player:SetModel(22620)
    player:GossipComplete()
    end

    if (intid == 57) then
    player:SetModel(741)
    player:GossipComplete()
    end

    if (intid == 58) then
    player:SetModel(20618)
    player:GossipComplete()
    end

    if (intid == 59) then
    player:SetModel(13009)
    player:GossipComplete()
    end

    if (intid == 60) then
    player:SetModel(6737)
    player:GossipComplete()
    end

    if (intid == 997) then
    unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(5,"Onyxia", 61, 0)
    unit:GossipMenuAddItem(5,"VanCleef", 62, 0)
    unit:GossipMenuAddItem(5,"Prince Malchezaar", 63, 0)
    unit:GossipMenuAddItem(5,"Zul'jin", 64, 0)
    unit:GossipMenuAddItem(5,"Gruul the Dragonkiller", 65, 0)
    unit:GossipMenuAddItem(5,"Al'ar", 66, 0)
    unit:GossipMenuAddItem(5,"Kael'thas", 67, 0)
    unit:GossipMenuAddItem(5,"Magtheridon", 68, 0)
    unit:GossipMenuAddItem(5,"Lady Vashj", 69, 0)
    unit:GossipMenuAddItem(4,"[Demorph]", 998, 0)
    unit:GossipMenuAddItem(4,"[Back to last Menu]", 1000, 0)
    unit:GossipMenuAddItem(4,"[Back to Main Menu]", 999, 0)
    unit:GossipSendMenu(player)
    end

    if (intid == 61) then
    player:SetModel(8570)
    player:GossipComplete()
    end

    if (intid == 62) then
    player:SetModel(2029)
    player:GossipComplete()
    end

    if (intid == 63) then
    player:SetModel(19274)
    player:GossipComplete()
    end

    if (intid == 64) then
    player:SetModel(21899)
    player:GossipComplete()
    end

    if (intid == 65) then
    player:SetModel(18698)
    player:GossipComplete()
    end

    if (intid == 66) then
    player:SetModel(18945)
    player:GossipComplete()
    end

    if (intid == 67) then
    player:SetModel(20023)
    player:GossipComplete()
    end

    if (intid == 68) then
    player:SetModel(18527)
    player:GossipComplete()
    end

    if (intid == 69) then
    player:SetModel(20748)
    player:GossipComplete()
    end

    if (intid == 998) then
    unit:SendChatMessage(12, 0, "To DeMorph you must relog!")
    player:SetModel(0)
    player:GossipComplete()
    end

    if (intid == 1000) then
    unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(5,"Benny Questgiver", 50, 0)
    unit:GossipMenuAddItem(5,"Illidan", 51, 0)
    unit:GossipMenuAddItem(5,"Hogger", 52, 0)
    unit:GossipMenuAddItem(5,"Pit Commander", 53, 0)
    unit:GossipMenuAddItem(5,"Wrath Master", 54, 0)
    unit:GossipMenuAddItem(5,"Tagar Spinebreaker", 55, 0)
    unit:GossipMenuAddItem(5,"Merciles Dragon", 56, 0)
    unit:GossipMenuAddItem(5,"Ravager", 57, 0)
    unit:GossipMenuAddItem(5,"Tauren", 58, 0)
    unit:GossipMenuAddItem(5,"Worm", 59, 0)
    unit:GossipMenuAddItem(5,"A Hydra!", 60, 0)
    unit:GossipMenuAddItem(4,"[Next]", 997, 0)
    unit:GossipMenuAddItem(4,"[Demorph]", 998, 0)
    unit:GossipMenuAddItem(4,"[Back to Main Menu]", 999, 0)
    unit:GossipSendMenu(player)
    end

    if (intid == 999) then
    unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(4,"Heals", 1, 0)
    unit:GossipMenuAddItem(4,"Buffs", 2, 0)
    unit:GossipMenuAddItem(4,"Morphs", 3, 0)
    unit:GossipSendMenu(player)
    end
end

RegisterUnitGossipEvent(*NPC ID*, 1, "On_GossipMenu")
RegisterUnitGossipEvent(*NPC ID*, 2, "On_GossipSelect")
    

 



