---by ljq5555
local itemcd = 50000 --物品ID
local systemname = '红包系统' --功能名称
local people_num = 1 --红包最少可抢的人数
local people_MaxNum = 100 --红包最大可抢的人数
local Fname = '|cFF1BE6B8[' .. systemname .. ']|r' --广播前缀
local senditem = 22528 --可发货币--暂用黑铁碎片
local minItemCount = 1 --最少发送物品数量
local maxItemCount = 100--最多发送物品数量
local minMoney = 1 --最少发送金币数量 单位金
local maxMoney = 1000 --最多发送金币数量 单位金
local Levelexp = {5, 1}
local paihangbang = 10 --排行榜显示最大人数
local minlevel = 8 --抢红包的最低等级
--每最小单位积累的经验值 影响排行榜
local level = {
    [1] = {'|cFFFF0000小气鬼|r', 0},
    [2] = {'|cFFFF0000财|r|cFFAA1655助|r', 1},
    [3] = {'|cFFFF0000大|r|cFF0041FF财|r|cFF1BE6B8主|r', 50},
    [4] = {'|cFFFF0000壕|r|cFFCC0D33无|r|cFF991A66人|r|cFF662799性|r', 100}
}

local playerinfo = {}
local rediteminfo = {}
local redSendingDic = {}
local Maxid = 0
CharDBExecute(
    [[
        CREATE TABLE IF NOT EXISTS `_player_red` (
          `guid` bigint(20) DEFAULT NULL,
          `name` text,
          `exp` int(11) DEFAULT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
]]
)
CharDBExecute(
    [[
        CREATE TABLE IF NOT EXISTS `_player_red_list` (
            `Remarks` text,
            `guild` int(11) NOT NULL DEFAULT '0',
            `yue` int(11) NOT NULL DEFAULT '0',
            `yx` int(11) NOT NULL DEFAULT '1',
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `itemid` int(11) NOT NULL DEFAULT '0',
            `nums` int(11) NOT NULL DEFAULT '0',
            `fenpei` text,
            `redCount` int(11) NOT NULL DEFAULT '0',
            PRIMARY KEY (`id`)
          ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
]]
)

local text = CharDBQuery('select guid,name,exp from _player_Red')
if (text) then
    repeat
        playerinfo[tonumber(text:GetString(0))] = {
            text:GetString(1),
            tonumber(text:GetString(2))
        }
    until not text:NextRow()
end
text = CharDBQuery('select id,Remarks,guild,yue,itemid,nums,fenpei,redCount from _player_red_list WHERE YX=1 order by id')
if (text) then
    repeat
        rediteminfo[tonumber(text:GetString(0))] = {
            ['Remarks'] = text:GetString(1),
            ['guild'] = tonumber(text:GetString(2)),
            ['yue'] = tonumber(text:GetString(3)),
            ['itemid'] = tonumber(text:GetString(4)),
            ['nums'] = tonumber(text:GetString(5)),
            ['id'] = tonumber(text:GetString(0)),
            ['fenpei'] = text:GetString(6),
            ['redCount'] = tonumber(text:GetString(7))
        }
    until not text:NextRow()
end
text = CharDBQuery("SELECT `AUTO_INCREMENT`  FROM  INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME  = '_player_red_list'")
if (text) then
    Maxid = tonumber(text:GetString(0))
end
function Red_Book(event, player, item)
    --player:MoveTo(0, player:GetX() + 0.01, player:GetY(), player:GetZ())
    player:MoveTo(0,player:GetX(),player:GetY(),player:GetZ()+0.01)--移动就停止当前施法
    if (player:IsInCombat() == true) then
        player:SendAreaTriggerMessage(Fname .. '你不能在战斗中使用!')
        player:SendBroadcastMessage(Fname .. '你不能在战斗中使用')
    else
        if (player:GetLevel() < minlevel) then
            player:SendAreaTriggerMessage(Fname .. '你还不能使用此功能!需要达到等级' .. minlevel .. '级')
            player:SendBroadcastMessage(Fname .. '你还不能使用此功能!需要达到等级' .. minlevel .. '级')
        else
            Red_Menu(item, player)
        end
    end
    return false
end
function Red_Menu(item, player)
    player:GossipMenuAddItem(5, '|cFFFF0000------------------' .. systemname .. '------------------|r', 0, 998)
    player:GossipMenuAddItem(6, '|cFFFF0000我壕无人性-我要发红包|r', 0, 2)
    player:GossipMenuAddItem(6, '|cFF000000我穷我有理-我要抢红包|r', 0, 3)
    player:GossipMenuAddItem(6, '|cFFCC0099壕排行榜|r', 0, 4)
    player:GossipSendMenu(1, item)
end
function Get_levelName(levelexp)
    if levelexp >= level[4][2] then
        return level[4][1]
    elseif levelexp >= level[3][2] then
        return level[3][1]
    elseif levelexp >= level[2][2] then
        return level[2][1]
    elseif levelexp >= level[1][2] then
        return level[1][1]
    end
end
function StrSplit(str, reps)
    local StrList = {}
    string.gsub(
        str,
        '[^' .. reps .. ']+',
        function(F)
            table.insert(StrList, F)
        end
    )
    return StrList
end
function CheckRight(playerid, intid, player)
    if rediteminfo[intid]['yue'] == rediteminfo[intid]['redCount'] then
        rediteminfo[intid]['Remarks'] = tostring(playerid)
        rediteminfo[intid]['yue'] = rediteminfo[intid]['yue']-1
        Updateredinfo(rediteminfo[intid]['id'], rediteminfo[intid]['yue'], rediteminfo[intid]['Remarks'], player)
        return true
    end
    local list = StrSplit(rediteminfo[intid]['Remarks'], '|')
    for i, v in pairs(list) do
        if tostring(v) == tostring(playerid) then
            player:SendBroadcastMessage(Fname .. '这个红包你已经抢过啦')
            return false
        end
    end
    rediteminfo[intid]['Remarks'] = rediteminfo[intid]['Remarks'] .. '|' .. tostring(playerid)
    rediteminfo[intid]['yue'] = rediteminfo[intid]['yue'] - 1
    Updateredinfo(rediteminfo[intid]['id'], rediteminfo[intid]['yue'], rediteminfo[intid]['Remarks'], player)
    return true
end

--判断是否已经领过此红包
function CheckLeft(playerid, intid)
    if rediteminfo[intid]['yue'] == rediteminfo[intid]['redCount'] then
        return true
    end
    local list = StrSplit(rediteminfo[intid]['Remarks'], '|')
    for i, v in pairs(list) do
        if tostring(v) == tostring(playerid) then
            return false
        end
    end
    return true
end
function Updateredinfo(id, yue, Remarks, player)
    local x = StrSplit(rediteminfo[id]['fenpei'], '|')
    if yue > 0 then
        CharDBQuery('update _player_Red_list set yue=' .. yue .. ",remarks='" .. Remarks .. "' where id =" .. id)
    else
        CharDBQuery('update _player_Red_list set yue=' .. yue .. ",remarks='" .. Remarks .. "',yx=0 where id =" .. id)
    end
    local y = tonumber(x[yue + 1])
    local sendstr
    if (rediteminfo[id]['itemid'] == 0) then
        sendstr = '|cFFFF0000' .. y .. ' 金币|r'
        y = y * 100 * 100
        player:ModifyMoney(y)
        player:SendBroadcastMessage(Fname .. '|cFFFF0000你抢到了一个红包获得|r' .. sendstr)
    else
        sendstr = GetItemLink(rediteminfo[id]['itemid'],4) .. '|cFFFF0000X' .. y .. '个|r'
        player:SendBroadcastMessage(Fname .. '|cFFFF0000你抢到了一个红包获得|r' .. sendstr)
        player:AddItem(rediteminfo[id]['itemid'], y)
    end
    if (yue == 0) then
        rediteminfo[id] = nil
    end
    SendWorldMessage(Fname .. '[' .. player:GetName() .. ']|cFFFF0000抢到了一个红包,获得了|r' .. sendstr)
end
function Updateinfo(guid, name, exp, item_id, guild, itemcount)
    if playerinfo[guid] == nil then
        CharDBQuery(
            "INSERT INTO `_player_Red` (`guid`,`name`,`exp`) VALUES ('" ..
                tostring(guid) .. "','" .. name .. "','" .. exp .. "')"
        )
        playerinfo[guid] = {name, exp}
    else
        playerinfo[guid] = {name, playerinfo[guid][2] + exp}
        CharDBQuery('update _player_Red set exp=' .. playerinfo[guid][2] .. ' where guid=' .. guid)
    end
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))

    --获取当前红包数据
    local redSending = redSendingDic[guid]
    if redSending == nil then
        print("Red Envelopers error:".."Updateinfo")
    end

    local data = splitX(tonumber(itemcount), redSending.redCount)
    CharDBQuery(
        "INSERT INTO `_player_red_list` (`guild`,`itemid`,`nums`,`yue`,`fenpei`,`redCount`) VALUES ('" ..
            guild .. "','" .. item_id .. "','" .. itemcount .. "','" .. redSending.redCount .. "','" .. data .. "','" .. redSending.redCount .. "')"
    )
    rediteminfo[Maxid] = {
        ['Remarks'] = '',
        ['guild'] = guild,
        ['yue'] = redSending.redCount,--红包数量
        ['itemid'] = item_id,
        ['nums'] = itemcount,         --总金额、数量
        ['id'] = Maxid,
        ['fenpei'] = data,
        ['redCount'] = redSending.redCount
    }
    Maxid = Maxid + 1

    redSendingDic[guid] = nil
end

function Red_Select(event, player, item, sender, intid, code, menu_id)
    print(string.format("event:%s player:%s object:%s sender:%s intid:%s code:%s menu_id:%s", event,  tostring(player:GetGUIDLow()), tostring(item), tostring(sender), intid, code, menu_id))
    if intid == 1 or intid == 21 then
        player:SendAreaTriggerMessage(Fname .. '土豪，发个红包，我们就是朋友啦')
        player:SendBroadcastMessage(Fname .. '土豪，发个红包，我们就是朋友啦')
    elseif intid > 10000 then
        local last = true
        if (rediteminfo[intid - 10000] == nil) then
            last = false
        end
        if last and rediteminfo[intid - 10000]['yue'] > 0 and CheckRight(player:GetGUID(), intid - 10000, player) then
            player:GossipMenuAddItem(6, '|cff0000ff', 0, 3)
            player:GossipMenuAddItem(6, '|cFF000000返回上一层|r',0,3)
        else
            player:SendAreaTriggerMessage(Fname .. '你下手慢啦，被别人抢走了')
            player:SendBroadcastMessage(Fname .. '你下手慢啦，被别人抢走了')
            player:GossipMenuAddItem(6, '|cff0000ff', 0, 3)
            player:GossipMenuAddItem(6, '|cFF000000返回上一层|r',0,3)
        end
        player:GossipSendMenu(1, item)
    elseif intid == 31 or intid == 32 then
        local keys = {}
        for k, v in pairs(rediteminfo) do
            table.insert(keys, k)
        end
        table.sort(
            keys,
            function(a, b)
                return a > b
            end
        )
        local menucdadd = 10000
        local Guild = 0
        if intid == 32 and not player:IsInGuild() then
            player:SendBroadcastMessage(Fname .. '请您先加入一个工会！')
            player:GossipComplete()
            return true
        end
        Guild = player:GetGuildId()
        local jz = false --is red vailable?
        local nums = 0
        for i, v in pairs(keys) do
            if rediteminfo[v]['guild'] > 0 then
                if (not player:IsInGuild()) or (not (Guild == rediteminfo[v]['guild'])) or (intid == 31) then
                    jz = false
                else
                    jz = true
                end
            else
                if intid == 32 then
                    jz = false
                else
                    jz = true
                end
            end
            if jz and CheckLeft(player:GetGUID(), rediteminfo[v]['id']) then
                if rediteminfo[v]['itemid'] > 0 then
                    player:GossipMenuAddItem(6, '|TInterface\\ICONS\\red\\read.blp:20|t ' ..
                            GetItemLink(rediteminfo[v]['itemid'],4) ..
                                'X' .. rediteminfo[v]['nums'] .. '     [' .. rediteminfo[v]['id'] .. ']',0,menucdadd + rediteminfo[v]['id']
                    )
                else
                    player:GossipMenuAddItem(6, '|cFF0041FF金币X' ..
                            rediteminfo[v]['nums'] .. '     [' .. rediteminfo[v]['id'] .. ']',0,menucdadd + rediteminfo[v]['id']
                    )
                end
                nums = nums + 1
            end
        end
        if (nums == 0) then
            player:SendBroadcastMessage(Fname .. '没有可以抢的红包！您可以自己发一个哦！')
            player:SendAreaTriggerMessage(Fname .. '没有可以抢的红包！您可以自己发一个哦！')
            player:GossipComplete()
            return true
        end
        player:GossipMenuAddItem(6, '|cFF000000返回上一层|r',0,3)
        player:GossipSendMenu(1, item)
    elseif intid == 3 then
        player:GossipMenuAddItem(6, '|cFF0041FF世界红包|r', 0, 31)
        player:GossipMenuAddItem(6, '|cFF0041FF工会红包|r', 0, 32)
        player:GossipMenuAddItem(6, '|cFF000000返回主菜单|r', 0, 99)
        player:GossipSendMenu(1, item)
    elseif intid == 4 then
        local keys = {}
        for k, v in pairs(playerinfo) do
            table.insert(keys, k)
        end
        table.sort(
            keys,
            function(a, b)
                return a < b
            end
        )

        local qishu = 0
        for i, v in pairs(keys) do
            qishu = qishu + 1
            if (qishu > paihangbang) then
                break
            else
                if (qishu % 2 == 0) then
                    player:GossipMenuAddItem(
                        6,
                        '|cFFFF0000' ..
                            playerinfo[v][1] .. '-富豪值：' .. playerinfo[v][2] .. '|r',
                        0,
                        99
                    )
                else
                    player:GossipMenuAddItem(
                        6,
                        '|cFF0041FF' ..
                            playerinfo[v][1] .. '-富豪值：' .. playerinfo[v][2] .. '|r',
                        0,
                        99
                    )
                end
            end
        end
        player:GossipMenuAddItem(
            6,
            '|cFF000000返回主菜单|r',
            0,
            99
        )
        player:GossipSendMenu(1, item)
    elseif intid == 2 then
        player:GossipMenuAddItem(6, '|cFFFF0000' .. GetItemLink(senditem,4) .. '红包雨-所有人可见|r',0,22)
        player:GossipMenuAddItem(6, '|cFFFF0000' .. GetItemLink(senditem,4) .. '工会红包|r',0,23)
        player:GossipMenuAddItem(6, '|cFFFF0000金币红包雨-所有人可见|r',0,24)
        player:GossipMenuAddItem(6, '|cFFFF0000金币-工会红包|r',0,25)
        player:GossipMenuAddItem(6, '|cFF000000返回主菜单|r',0,99)
        player:GossipSendMenu(1, item)
    elseif intid == 99 then
        Red_Menu(item, player)
    elseif intid == 22 or intid == 23 or intid == 24 or intid == 25 then
        --存储当前红包数据
        local redSending = redSendingDic[player:GetGUIDLow()]
        if redSending == nil then
            redSending = {type=intid,redCount=0,totalCount=0}
            redSendingDic[player:GetGUIDLow()] = redSending;
        else
            redSending.type = intid
            redSending.redCount = 0
            redSending.totalCount = 0
        end
        
        if (intid == 23 or intid == 25) then
            if not player:IsInGuild() then
                player:SendBroadcastMessage(Fname .. '请您先加入一个工会！')
                player:GossipComplete()
                return true
            end
        end

        player:GossipMenuAddItem(6, '|cFFFF0000要发多少个红包？|r',0,201,true)
        player:GossipSendMenu(1, item)

    elseif intid == 201 then
        --获取当前红包数据
        local redSending = redSendingDic[player:GetGUIDLow()]
        if redSending == nil then
            print("Red Envelopers error:"..intid)
        end
        local redCount = tonumber(code)
        if (redCount == nil) then
            player:SendBroadcastMessage(Fname .. '请输入正确的红包个数！')
            player:GossipComplete()
            return true
        elseif(redCount<people_num) then
            player:SendBroadcastMessage(Fname .. '最少要发'..people_num..'个红包！')
            player:GossipComplete()
            return true
        elseif(redCount>people_MaxNum) then
            player:SendBroadcastMessage(Fname .. '最大只能发'..people_MaxNum..'个红包！')
            player:GossipComplete()
            return true
        end

        redSending.redCount = redCount;

        player:GossipMenuAddItem(6, '|cFFFF0000总共要发多少钱/数量？|r',0,202,true)
        player:GossipSendMenu(1, item)

    elseif intid == 202 then
        --获取当前红包数据
        local redSending = redSendingDic[player:GetGUIDLow()]
        if redSending == nil then
            print("Red Envelopers error:"..intid)
        end
        local redType = redSending.type

        local itemcount = tonumber(code)
        if (itemcount == nil) then
            player:SendBroadcastMessage(Fname .. '请输入正确的数字！')
            player:GossipComplete()
            return true
        elseif(itemcount < redSending.redCount) then
            player:SendBroadcastMessage(Fname .. '总数量/金额要大于或等于红包数量！')
            player:GossipComplete()
            return true
        end

        redSending.totalCount = itemcount

        local Worldmessagestr = ''
        local Kind = ''
        local Guild = 0
        if (redType == 23 or redType == 25) then
            if not player:IsInGuild() then
                player:SendBroadcastMessage(Fname .. '请您先加入一个工会！')
                player:GossipComplete()
                return true
            end
            Kind = '|cFFE55AAF工|r|cFFCA6EA7会|r'
            Guild = player:GetGuildId()
        end
        local m = false
        local playerexp = 50

        if (redType == 22 or redType == 23) then
            if (minItemCount > itemcount) then
                player:SendBroadcastMessage(
                    Fname .. '土豪，红包最少需要发送' .. minItemCount .. '个' .. GetItemLink(senditem,4) .. '哦！'
                )
                player:GossipComplete()
                return true
            elseif(itemcount > maxItemCount) then
                player:SendBroadcastMessage(
                    Fname .. '土豪，红包最多只能发送' .. maxItemCount .. '个' .. GetItemLink(senditem,4) .. '哦！'
                )
                player:GossipComplete()
                return true
            end
            if (player:HasItem(senditem, itemcount)) then
                player:RemoveItem(senditem, itemcount)
                player:SendBroadcastMessage(
                    Fname .. '|cFF33CC33你失去了|r ' .. GetItemLink(senditem,4) .. ' |cFF33CC33x ' .. itemcount .. ' 个|r'
                )
            else
                player:SendBroadcastMessage(Fname .. '对不起.你没有' .. GetItemLink(senditem,4) .. 'X' .. itemcount .. '.无法发红包')
                player:SendAreaTriggerMessage(
                    Fname .. '对不起.你没有' .. GetItemLink(senditem,4) .. 'X' .. itemcount .. '.无法发红包'
                )
            end
        else
            if (minMoney > itemcount) then
                player:SendBroadcastMessage(Fname .. '土豪，红包最少需要发送' .. minMoney .. '金币哦！')
                player:GossipComplete()
                return true
            elseif(itemcount > maxMoney) then
                player:SendBroadcastMessage(Fname .. '土豪，红包最多只能发送' .. minMoney .. '金币哦！')
                player:GossipComplete()
                return true
            end
            if player:GetCoinage() < itemcount * 100 * 100 then
                player:SendBroadcastMessage(Fname .. '你的钱不够哦，单位是金币')
                player:GossipComplete()
                return true
            else
                player:ModifyMoney(itemcount * 100 * 100 * -1)
                player:SendBroadcastMessage(Fname .. '|cFF33CC33你失去了 ' .. itemcount .. ' 金币|r')
                m = true
            end
        end
        local p_exp = 0
        if m then
            Worldmessagestr =
                Fname ..
                '|cFFCC6633壕|r|cFF665499无|r|cFF0041FF人|r|cFF0E94DC性|r|cFF1BE6B8的|r[' ..
                Get_levelName(playerexp) ..
                '-' ..
                player:GetName() ..
                ']|cFFFF0000发|r|cFFAA1655送|r|cFF552BAA了|r|cFF0041FF一|r|cFF0978E7个|r|cFF12AFD0金|r|cFF1BE6B8币|r|cFFFFFF00x|r|cFF00FF99' ..
                itemcount ..
                '|r|cFF8C5555的|r' ..
                Kind ..
                '|cFFFFDF48红|r|cFFFEBF90包|r|cFFFE9FD8，|r|cFFB4AA90哇|r|cFF69B448塞|r|cFF1FBF00，|r|cFF619D3A这|r|cFFA37C75个|r|cFFE55AAF工|r|cFFCA6EA7会|r|cFFAF819E好|r|cFF949596多|r|cFF8CA3B4土|r|cFF85B0D3豪|r|cFF7DBEF1，|r|cFF589FB8我|r|cFF34807E要|r|cFF0F6145入|r|cFF24723F会|r|cFF388338！|r'
            p_exp = itemcount / minItemCount * Levelexp[2]
            Updateinfo(tonumber(tostring(player:GetGUID())), player:GetName(), p_exp, 0, Guild, itemcount)
        else
            Worldmessagestr =
                Fname ..
                '|cFFCC6633壕|r|cFF665499无|r|cFF0041FF人|r|cFF0E94DC性|r|cFF1BE6B8的|r[' ..
                Get_levelName(playerexp) ..
                '-' ..
                player:GetName() ..
                ']|cFFFF0000发|r|cFFF3030C送|r|cFFE80617了|r|cFFDC0923一|r|cFFD10C2E个|r' ..
                GetItemLink(senditem,4) ..
                '|cFFFFFF00x|r|cFF00FF99' ..
                itemcount ..
                '|r|cFF8B1E74的|r' ..
                Kind ..
                '|cFF7F2080红|r|cFF74238B包|r|cFF682697，|r|cFF5D29A2大|r|cFF512CAE家|r|cFF462FB9赶|r|cFF3A32C5紧|r|cFF2E35D1抢|r|cFF2338DC啦|r|cFF173BE8！|r'
            p_exp = itemcount / minMoney * Levelexp[1]
            Updateinfo(tonumber(tostring(player:GetGUID())), player:GetName(), p_exp, senditem, Guild, itemcount)
        end

        player:SendBroadcastMessage(Fname .. '红包发送成功！')
        player:SendAreaTriggerMessage(Fname .. '红包发送成功！')
        SendWorldMessage(Worldmessagestr)

        player:GossipComplete()
        return true
    end
end
function shuffle(t)
    if not t then
        return
    end
    local cnt = #t
    for i = 1, cnt do
        local j = math.random(i, cnt)
        t[i], t[j] = t[j], t[i]
    end
end

function splitX(m, n)
    print("splitX:m="..m.." n="..n)
    local mark = {}
    for i = 1, m - 1 do
        mark[i] = i
    end

    shuffle(mark)
    local validMark = {}
    for i = 1, n - 1 do
        validMark[i] = mark[i]
        print("splitX:validMark[".. i .."]="..mark[i].."")
    end

    table.sort(
        validMark,
        function(a, b)
            return a < b
        end
    )

    validMark[0] = 0
    validMark[n] = m
    local out = ''
    for i = 1, n do
        if (i == 1) then
            out = tostring(validMark[i] - validMark[i - 1])
        else
            out = out .. '|' .. tostring(validMark[i] - validMark[i - 1])
        end
    end
    return out
end
function RedOnLogin(event, player)
    if not player:HasItem(itemcd, 1) then
        player:AddItem(itemcd, 1)
        player:SendBroadcastMessage(Fname .. '|cFF33CC33你获得了|r ' .. GetItemLink(itemcd,4) .. ' |cFF33CC33x1个|r')
    end
    player:SendBroadcastMessage(
        '|cFFFF0066欢|r|cFF0041FF迎|r|cFF1BE6B8你|r' ..
            player:GetName() .. '|cFF0041FF你|r|cFF0041FF可|r|cFF0041FF以|r|cFF0E94DC使|r|cFF1BE6B8用|r' .. systemname .. '了'
    )
end
RegisterPlayerEvent(3, RedOnLogin)
RegisterItemGossipEvent(itemcd, 1, Red_Book)
RegisterItemGossipEvent(itemcd, 2, Red_Select)

--INSERT INTO `mangos`.`item_template` (`entry`, `patch`, `class`, `subclass`, `name`, `description`, `display_id`, `quality`, `flags`, `buy_count`, `buy_price`, `sell_price`, `inventory_type`, `allowable_class`, `allowable_race`, `item_level`, `required_level`, `required_skill`, `required_skill_rank`, `required_spell`, `required_honor_rank`, `required_city_rank`, `required_reputation_faction`, `required_reputation_rank`, `max_count`, `stackable`, `container_slots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `delay`, `range_mod`, `ammo_type`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `block`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmrate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmrate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmrate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmrate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmrate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `page_text`, `page_language`, `page_material`, `start_quest`, `lock_id`, `material`, `sheath`, `random_property`, `set_id`, `max_durability`, `area_bound`, `map_bound`, `duration`, `bag_family`, `disenchant_id`, `food_type`, `min_money_loot`, `max_money_loot`, `wrapped_gift`, `extra_flags`, `other_team_entry`) VALUES (50000, 0, 15, 0, 'Red Envelopes', '', 34508, 1, 64, 1, 0, 0, 0, -1, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8690, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);