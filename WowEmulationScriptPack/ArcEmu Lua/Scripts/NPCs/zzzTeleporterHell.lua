--************************************************************
--*                                                          *
--*               ******************************             *                   
--*               *                            *             *
--*               *   The FrostTeam Project    *             *     
--*               *        stoneharry          *             *
--*               ******************************             *            
--*                                                          *
--*                                                          *
--*      --FrostTeam SVN consists of the latest WotLK        *   
--*      scripts, both Lua and C++. Some will be our own,    *
--*      some will be others with credits attatched. Our     *
--*      Svn includes all scripts that you may need          *
--*      to help make your server a more fun environment.--  *
--*                                                          *
--************************************************************


local menunum = 33310
local menuicon = 4
local teleicon = 2
local menu =
{
    {"Random Places",
        {
            {"Worst Place Ever", 13, 0, 0, 0},
            {"Top of the world!", 0, -4794, -1002, 898},
            {"oh no... It's Hell!", 0, -6425, -1398, 142},
            {"A huge cave!", 1, -10653, 2095, -43},
            {"Why am I here again?", 1, -8159, -489, 5},
            {"Hot Springs... ", 1, -7192, -645, -236},
        }
    },
    {"Boxes?!?!",
        {
            {"Small Box", 13, 0, 0, 0},
            {"Medium Box", 13, 0, 0, -140},
            {"Huge Box", 13, 0, 0, -400},
        }
    },
    {"Do not press here.",
        {
            {"You were Warned", 1, -5000, 5000, 1000000},
            {"I told you not to press here", 1, -5000, 5000, 1000000},
            {"Touch this you die", 1, -5000, 5000, 1000000},
        }
    },
}
 
function TeleNPC_MainMenu(Unit, Player)
    local i = 0
    Unit:GossipCreateMenu(menunum, Player, 0)
    for k,v in pairs(menu) do
        i = i + 1
        if type(v[2]) == "table" then
            Unit:GossipMenuAddItem(menuicon, v[1], i, 0)
            i = i + #(v[2])
        else
            Unit:GossipMenuAddItem(teleicon, v[1], i, 0)
        end
    end
    Unit:GossipSendMenu(Player)
end
function TeleNPC_SubMenu(Unit, Player, i, Submenu)
    Unit:GossipCreateMenu(menunum-i, Player, 0)
    Unit:GossipMenuAddItem(7, "<--Back", 0, 0)
    for k,v in pairs(Submenu) do
        i = i + 1
        Unit:GossipMenuAddItem(teleicon, v[1], i, 0)
    end
    Unit:GossipSendMenu(Player)
end
function TeleNPC_OnGossipTalk(Unit, Event, Player)
    TeleNPC_MainMenu(Unit, Player)
end
function TeleNPC_OnGossipSelect(Unit, Event, Player, MenuId, Id, Code)
    local i = 0
    if(Id == 0) then
        TeleNPC_MainMenu(Unit,Player)
    else
        for k,v in pairs(menu) do
            i = i + 1
            if (Id == i) then
                if type(v[2]) == "table" then
                    TeleNPC_SubMenu(Unit, Player, i, v[2])
                else
                    if Player:IsInCombat() then
                        Unit:SendChatMessage(12, 0, "You can't teleport while in combat!")
                    else
                        Player:Teleport(v[2], v[3], v[4], v[5])
                    end
                    Unit:GossipComplete(Player)
                end
                return
            elseif (type(v[2]) == "table") then
                for j,w in pairs(v[2]) do
                    i = i + 1
                    if (Id == i) then
                        if Player:IsInCombat() then
                            Unit:SendChatMessage(12, 0, "You can't teleport while in combat!")
                        else
                            Player:Teleport(w[2], w[3], w[4], w[5])
                        end
                        Unit:GossipComplete(Player)
                        return
                    end
                end
            end
        end
    end
end
RegisterUnitGossipEvent(50, 1, "TeleNPC_OnGossipTalk")
RegisterUnitGossipEvent(50, 2, "TeleNPC_OnGossipSelect")
