--[==[
]==]
print(">> TimeMorph")
-- Include sc_default
require "base/sc_default"

local TimeMorph = {}

TimeMorph.Settings = {
    Name = "|CFF1CB619[Morph System]|r",
    NpcActive = true,
    NpcEntry = 823,
    ItemActive = false,
    ItemEntry = 41003,
    MorphTime = 25,
};

-- Icon, Name, DisplayID, Scale
TimeMorph.Displays = {
    [1] = { " ", "暴风城卫兵", 2072, 1 },
    [2] = { " ", "大领主泰兰·弗丁", 10341, 1 },
    [3] = { " ", "纳兹格雷尔", 1872, 1 },
    [4] = { " ", "泰兰德·语风", 7274, 1 },
    [5] = { " ", "格鲁尔·黑刃", 9761, 1 },
    [6] = { " ", "妖术师金度", 11311, 1 },
    [7] = { " ", "德米提雅", 10507, 1 },
    [8] = { " ", "德米提恩", 14395, 1 },
    [9] = { " ", "弗兰扎尔", 14394, 1 },
	[10] = { " ", "维维尔博士", 15557, 1 },

    -- [1] = { "ico", "Kael Sunstrider", 20023, 0.3 },
    -- [2] = { " ", "Maiev Shadowsong", 20628, 0.7 },
    -- [3] = { " ", "Rexxar Champion of the Horde ", 20918, 0.5 },
    -- [4] = { " ", "Archmond", 18292, 0.03 },
    -- [5] = { " ", "Lady Sinestra", 21401, 0.2 },
    -- [6] = { " ", "Champion Sunstrike", 17261, 1 },
    -- [7] = { " ", "Champion Swiftblade", 17260, 1 },
    -- [8] = { " ", "Illidan Storimrage", 21135, 0.3 },
    -- [9] = { " ", "Al'ar", 18945, 0.2 },
};

function TimeMorph.OnGossipHello(event, player, unit)
    if player:GetLuaCooldown(3) == 0 then
        player:GossipSetText(string.format("Welcome %s in %s\n\nYou will Morph for |CFFFF0000%s|r sconds", player:GetName(), TimeMorph.Settings.Name, TimeMorph.Settings.MorphTime))
        for i, v in ipairs(TimeMorph.Displays) do
            player:GossipMenuAddItem(0, ""..v[1]..""..v[2].."", i, 1)
        end
    else
        player:GossipSetText(string.format("Welcome %s in %s\n\nYou are Morphed you must DeMorph befor you can add a new Morph", player:GetName(), TimeMorph.Settings.Name))
        player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-15:0|tDeMorph Me", 0, 2)
        player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_Spy:30:30:-15:0|tClose Menue", 0, 3)
    end
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function TimeMorph.OnGossipSelect(event, player, unit, sender, intid, code)
    if (intid == 1) then
        local Icon, Name, DisplayID, Scale = table.unpack(TimeMorph.Displays[sender])
        player:SetDisplayId(DisplayID)
        player:SetScale(Scale)
        player:SetLuaCooldown(TimeMorph.Settings.MorphTime, 3)
        player:RegisterEvent(TimeMorph.CooldownCheck, 1000, player:GetLuaCooldown(3))
        player:SendBroadcastMessage(string.format("%s You Morph you will DeMorph in %s seconds!", TimeMorph.Settings.Name, player:GetLuaCooldown(3)))
        player:PlayDirectSound(888, player)
        player:GossipClearMenu()
        TimeMorph.OnGossipHello(event, player, unit)
    elseif (intid == 2) then
        player:DeMorph()
        player:SetScale(1)
        player:SetLuaCooldown(0, 3)
        player:RemoveEvents()
        player:SendBroadcastMessage(string.format("%s You DeMorph", TimeMorph.Settings.Name))
        player:GossipClearMenu()
        TimeMorph.OnGossipHello(event, player, unit)
    elseif (intid == 3) then
        player:GossipComplete()
    end
end

function TimeMorph.CooldownCheck(event, delay, repeats, player)
    if player:GetLuaCooldown(3) == 0 then
        player:DeMorph()
        player:SetScale(1)
        player:PlayDirectSound(1435, player)
        player:RemoveEvents()
        player:SendBroadcastMessage(string.format("%s You DeMorph", TimeMorph.Settings.Name))
    elseif player:GetLuaCooldown(3) <= 10 then
        player:SendBroadcastMessage(string.format("%s You will DeMorph in %s seconds!", TimeMorph.Settings.Name, player:GetLuaCooldown(3)))
    end
end

function TimeMorph.OnElunaReload(event)
    for _, v in pairs(GetPlayersInWorld()) do
        v:DeMorph()
        v:SetLuaCooldown(0, 3)
        v:SetScale(1)
    end
end

function TimeMorph.OnLogout(event, player)
    player:DeMorph()
    player:SetLuaCooldown(0, 3)
    player:SetScale(1)
end

if TimeMorph.Settings.NpcActive == false and TimeMorph.Settings.ItemActive == false then
   print("----------------------------------------------")
   print(" Time Morph: Script not loaded check settings ")
   print("               Script by Salja                ")
   print("----------------------------------------------")
end

if TimeMorph.Settings.NpcActive == true then
    RegisterCreatureGossipEvent(TimeMorph.Settings.NpcEntry, 1, TimeMorph.OnGossipHello)
    RegisterCreatureGossipEvent(TimeMorph.Settings.NpcEntry, 2, TimeMorph.OnGossipSelect)

   print("----------------------------------------------")
   print("        Time Morph: NPC Script loaded         ")
   print("               Script by Salja                ")
   print("----------------------------------------------")
end

if TimeMorph.Settings.ItemActive == true then
    RegisterItemGossipEvent(TimeMorph.Settings.ItemEntry, 1, TimeMorph.OnGossipHello)
    RegisterItemGossipEvent(TimeMorph.Settings.ItemEntry, 2, TimeMorph.OnGossipSelect)

   print("----------------------------------------------")
   print("        Time Morph: ITEM Script loaded        ")
   print("               Script by Salja                ")
   print("----------------------------------------------")
end

RegisterPlayerEvent(4, TimeMorph.OnLogout)
RegisterServerEvent(16, TimeMorph.OnElunaReload)
