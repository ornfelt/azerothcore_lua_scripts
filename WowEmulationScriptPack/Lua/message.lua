
local Colors =  { -- 职业颜色设置
        [1] = "|cffC79C6E", -- 战士
        [2] = "|cffF58CBA", -- 圣骑士
        [3] = "|cffabd473", -- 猎人
        [4] = "|cffFFF569", -- 盗贼
        [5] = "|cffFFFFFF", -- 牧师
        [6] = "|cffC41F3B", -- 死亡骑士
        [7] = "|cff0070de", -- 萨满
        [8] = "|cff69CCF0", -- 法师
        [9] = "|cff9482C9", -- 术士
        [10] = "|cff999999", -- UNKNOWN
        [11] = "|cffFF7D0A", -- 德鲁伊
}

local Classes1 =  { -- 职业
        [1] = "战士",
        [2] = "骑士",
        [3] = "猎人",
        [4] = "盗贼",
        [5] = "牧师",
        [6] = "xxx",
        [7] = "萨满",
        [8] = "法师",
        [9] = "术士",
        [10] = "UNKNOWN",
        [11] = "小德",
}

local Zones1 = { -- 地区
[14] = "杜隆塔尔",
[215] = "莫高雷",
[17] = "贫瘠之地",
[36] = "奥特兰克",
[45] = "阿拉希",
[3] = "荒芜之地",
[4] = "诅咒之地",
[85] = "提瑞斯法林地",
[130] = "银松森林",
[28] = "西瘟疫之地",
[139] = "东瘟疫之地",
[267] = "希尔斯布莱德",
[47] = "辛特兰",
[1] = "丹莫罗",
[51] = "灼热峡谷",
[46] = "燃烧平原",
[12] = "艾尔文森林",
[41] = "逆风小径",
[10] = "暮色森林",
[38] = "洛克莫丹",
[44] = "赤脊山",
[33] = "荆棘谷",
[8] = "悲伤沼泽",
[40] = "西部荒野",
[11] = "湿地",
[141] = "泰达希尔",
[148] = "黑海岸",
[331] = "灰谷",
[400] = "千针石林",
[406] = "石爪山脉",
[405] = "凄凉之地",
[357] = "菲拉斯",
[15] = "尘泥沼泽",
[440] = "塔纳利斯",
[16] = "艾萨拉",
[361] = "费伍德森林",
[490] = "安戈洛环形山",
[493] = "月光林地",
[1377] = "希利苏斯",
[618] = "冬泉谷",
[1519] = "暴风城",
[1637] = "奥格瑞玛",
[1537] = "铁炉堡",
[1638] = "雷霆崖",
[1657] = "达纳苏斯",
[1497] = "幽暗城",
[0] = "艾泽拉斯",
[0] = "卡利姆多",
[2597] = "奥特兰克山谷",
[2557] = "厄运之槌",
[3277] = "战歌峡谷",
[3358] = "阿拉希盆地",
[796] = "血色修道院",
[612] = "灰谷战歌伐木营地",
[648] = "山巅之塔",
[721] = "诺莫瑞根",
--1,0,卡利姆多
}
 
local function Loot_money1(event, player, amount)
   if (player:IsInGroup()) then --不要删除此句，并发过高会宕机
   else 
   if (player:GetGMRank()<1)then
       local i = player:GetClass() 
       local head1 = "|cffffc0c0[1. 综合] "..Colors[i].."[|Hplayer:"..player:GetName().."|h"..player:GetName().."]|r|cffffc0c0： "
       local head2 = "|cffffc0c0[2. 交易] "..Colors[i].."[|Hplayer:"..player:GetName().."|h"..player:GetName().."]|r|cffffc0c0： "
       local head3 = "|cffffc0c0[5. 寻求组队] "..Colors[i].."[|Hplayer:"..player:GetName().."|h"..player:GetName().."]|r|cffffc0c0： "
       local plv = player:GetLevel()
       local z2 = player:GetZoneId()

		--print("zone:".. z2 .. " level:".. plv)

		if (Zones1[z2] == nil) then
        SendWorldMessage(""..head1.."请问我在哪，我是谁，我在做什么。。。|r")
        else
             
		  if (plv>55) then
			local m1 = math.random(400)
			if (m1 == 1) then
			  SendWorldMessage(""..head3.."黑上求组，开荒队速度来人手红的来！|r")
			end
			if (m1 == 2) then
			  SendWorldMessage(""..head3.."求组TL，速度刷~~求带队~~！|r")
			end
			if (m1 == 3) then
			  SendWorldMessage(""..head3.."黑下速刷效率队随便来人！！！|r")
			end
			if (m1 == 4) then
			  SendWorldMessage(""..head3.."厄运完美贡品来的组~~！！！|r")
			end
			if (m1 == 5) then
			  SendWorldMessage(""..head1.."野外PK的组起！！！野外PK的组起！！！|r")
			end
			if (m1 == 6) then
			  SendWorldMessage(""..head3.."扭木来人，速度开了！！！|r")
			end
			if (m1 == 7) then
			  SendWorldMessage(""..head3.."求组通灵，不打院长的组！！|r")
			end
			if (m1 == 8) then
			  SendWorldMessage(""..head1.."点卡在燃烧，刷斯坦索姆XS的来！|r")
			end
			if (m1 == 9) then
			  SendWorldMessage(""..head1.."黑上全通团 打完只要3个半小时！ 因为人员不稳定现在招收稳定职业！稳定一周后擦装备公会和谐！指挥疯骚！人品不好的不要！|r")
			end
			if (m1 == 10) then
			  SendWorldMessage(""..head3.."STSM求组，能打通的速度加，新手勿扰。|r")
			end
			if (m1 == 11) then
			  SendWorldMessage(""..head1.."求一MC公会，稳定8小时在线，能过老9的加 ！！|r")
			end
			if (m1 == 12) then
			  SendWorldMessage(""..head1.."BWL开荒，求老手带路~~~|r")
			end
			if (m1 == 13) then
			  SendWorldMessage(""..head1.."求大佬带STSM后门！|r")
			end
			if (m1 == 14) then
			  SendWorldMessage(""..head1.."厄运任务的来人啊！在线等~~~|r")
			end
			if (m1 == 15) then
			  SendWorldMessage(""..head3.."通灵自立队，来菜刀和奶妈！！有意直接加！！|r")
			end
			if (m1 == 16) then
			  SendWorldMessage(""..head1.."STSM刷DK马的组起，求带！|r")
			end
			if (m1 == 17) then
			  SendWorldMessage(""..head3.."ZG老虎队，来MT FS MS DZ LR.............|r")
			end
			if (m1 == 18) then
			  SendWorldMessage(""..head1.."求稳定RAID公会，开荒ZG的直接加！！|r")
			end
			if (m1 == 19) then
			  SendWorldMessage(""..head1.."~~暮光任务组个~~！！|r")
			end
			if (m1 == 20) then
			  SendWorldMessage(""..head1.."橙杖队来熟练工！！！|r")
			end
			if (m1 == 21) then
			  SendWorldMessage(""..head1.."XLSS开风石，会开的来，来熟练工！！！|r")
			end
			if (m1 == 22) then
			  SendWorldMessage(""..head1.."时光之穴任务的来，速度开组！|r")
			end
			if (m1 == 23) then
			  SendWorldMessage(""..head3.."一等四求组黑下，全刷的来，效率的来~~|r")
			end
			if (m1 == 24) then
			  SendWorldMessage(""..head1.."强力牛B工会正式招收会员，我们会里有N尖端战士，会做可乐的法师，圣光过敏的骑士，养不活BB的猎人，除了人什么都会变的小D，忘学潜行的盗贼，爱护树木的萨满，杀人无数的牧师，近战无敌的SS，就差你了！|r")
			end
			if (m1 == 25) then
			  SendWorldMessage(""..head3.."求组MC门任务，速度组起，来强力人士。|r")
			end
			if (m1 == 26) then
			  SendWorldMessage(""..head1.."公会进度ZG老二，每天晚上6点半活动！希望有志人士积极参与，公会加入办法，单击我名字然后在对话框中键入：我要加入！每天的前几名有奖励哦。。|r")
			end
			if (m1 == 27) then
			  SendWorldMessage(""..head1.."职业T装速刷队，懂得M，效率开组。|r")
			end
			if (m1 == 28) then
			  SendWorldMessage(""..head3.."求组废墟老一开荒团，野人金团勿扰。。。。谢谢。。。|r")
			end
			if (m1 == 29) then
			  SendWorldMessage(""..head1.."求带TL任务，小白一个，直接拉走|r")
			end
			if (m1 == 30) then
			  SendWorldMessage(""..head3.."求组三本速刷旅游队，每天定时刷的组。。。|r")
			end
			if (m1 == 31) then
			  SendWorldMessage(""..head1.."。。。ZG老1稳定开荒团，来MT治疗，环保勿扰。。。。。。|r")
			end
			if (m1 == 32) then
			  SendWorldMessage(""..head1.."带刷STSM后门，5G一次，还有位。。。。|r")
			end
			if (m1 == 33) then
			  SendWorldMessage(""..head1.."屠城团有没啊，加我+++++！！|r")
			end
			if (m1 == 34) then
			  SendWorldMessage(""..head1.."每日上线没事干，想下副本装备烂，战场全是奥特曼，出门到躺三秒半。无可奈何铁桥站，采草挖矿本行干，5G一刀不计算|r")
			end
			if (m1 == 35) then
			  SendWorldMessage(""..head1.."还有木有苍天啊大地啊，抚摩这行不容易啊；材料啊金币啊，客户算得比你细啊；痛苦啊流涕啊，恶性竞争真憋闷啊!|r")
			end
			if (m1 == 36) then
			  SendWorldMessage(""..head1.."人在江湖飘，哪能不挨刀，上马不喊话，那是没文化，喊话不上马，那是哥很卡！|r")
			end
			if (m1 == 37) then
			  SendWorldMessage(""..head1.."带刷XS，2G一位，随便来老板！速度走起！！|r")
			end
			if (m1 == 38) then
			  SendWorldMessage(""..head2.."收克罗"..GetItemLink(2244)..""..GetItemLink(2244).."|cffffc0c0一把，不黑人的M！！|r")
			end
			if (m1 == 39) then
			  SendWorldMessage(""..head2.."代收乔丹"..GetItemLink(873)..""..GetItemLink(873)..""..GetItemLink(873).."|cffffc0c0有的带价M。。。。|r")
			end
			if (m1 == 40) then
			  SendWorldMessage(""..head1..""..GetItemLink(12344)..""..GetItemLink(12344).."|cffffc0c0哪里弄啊，小白求带。。。。|r")
			end
			if (m1 == 41) then
			  SendWorldMessage(""..head1.."求做黑龙MM"..GetItemLink(16309)..""..GetItemLink(16309).."|cffffc0c0门任务，会做的组起。。。。|r")
			end
			if (m1 == 42) then
			  SendWorldMessage(""..head1.."求组厄运王子队。。。。厄运王子速度来菜刀，新手勿扰。。。。|r")
			end
			if (m1 == 43) then
			  SendWorldMessage(""..head2.."收大卡一张，有的带价密。。。。有担保可以先金。。。|r")
			end
			if (m1 == 44) then
			  if (i == 4) or (i == 11) then
			  SendWorldMessage(""..head1.."无聊组队深渊刷酒吧凶器"..GetItemLink(12791)..""..GetItemLink(12791).."|cffffc0c0DZXD们组起！！！|r")
			  else
			  end
			end
			if (m1 == 45) then
			  SendWorldMessage(""..head1.."有会做"..GetItemLink(12784)..""..GetItemLink(12784).."|cffffc0c0的没，会的大神请带价M，自带材料！！！|r")
			end
			if (m1 == 46) then
			  SendWorldMessage(""..head1.."恶魔布哪里出啊，知道的告诉下。。。|r")
			end
			if (m1 == 47) then
			  SendWorldMessage(""..head1.."收一张"..GetItemLink(9294)..""..GetItemLink(9294).."|cffffc0c0，有的M。。。|r")
			end
			if (m1 == 48) then
			  SendWorldMessage(""..head1.."求抚摸"..GetItemLink(16252)..""..GetItemLink(16252).."|cffffc0c0，会的直接加我交易。。。价格好说。。。自带材料也行。|r")
			end
			if (m1 == 49) then
			  SendWorldMessage(""..head1.."请问这个服LM和BL比例是多少。。。和谐么？？|r")
			end
			if (m1 == 50) then
			  SendWorldMessage(""..head1.."完了。。。又被盗号，几百金全没了。。。气死了。。。。。。|r")
			end
			if (m1 > 50) then 
			end
		  end

		  if (plv>45 and plv<56) then
			local m2 = math.random(400)
			if (m2 == 1) then
			  SendWorldMessage(""..head2.."出售点卡一张，先金的M。。。骗子死远点。。。|r")
			end
			if (m2 == 2) then
			  SendWorldMessage(""..head3.."求组SM,自立队来的M,速度开组~~！|r")
			end
			if (m2 == 3) then
			  SendWorldMessage(""..head1.."神庙刷龙之召唤"..GetItemLink(10847)..""..GetItemLink(10847).."|cffffc0c0的组起！！！|r")
			end
			if (m2 == 4) then
			  SendWorldMessage(""..head1.."SM任务的开组啦~~！！！"..GetItemLink(10845)..""..GetItemLink(10845)..""..GetItemLink(13067).."|r|cffffc0c0叶基娜任务的组起！！|r")
			end
			if (m2 == 5) then
			  SendWorldMessage(""..head2.."50G一组长期收美味风蛇，有的直接邮寄，信用保证！！|r")
			end
			if (m2 == 6) then
			   if (i == 4) or (i == 11) then
			   SendWorldMessage(""..head3.."无聊组队MLD潜行队DZ，XD速度来！！！|r")
			   else
			   end
			end
			if (m2 == 7) then
			  SendWorldMessage(""..head3.."求组MLD，直接公主的M！！|r")
			end
			if (m2 == 8) then
			  SendWorldMessage(""..head1.."点卡在燃烧，老婆在发飙，速刷SM的来。。。！|r")
			end
			if (m2 == 9) then
			  SendWorldMessage(""..head1.."祖尔百人速刷队，只刷百人，不要面具的来。。。|r")
			end
			if (m2 == 10) then
			  SendWorldMessage(""..head1.."新人求组ZUL，做任务刷督军剑的来。。。|r")
			end
			if (m2 == 11) then
			  SendWorldMessage(""..head1.."求一MC公会，稳定8小时在线，能过老9的加 ！！|r")
			end
			if (m2 == 12) then
			  SendWorldMessage(""..head1.."深渊开荒队，5G求DZ开门老手带路~~~|r")
			end
			if (m2 == 13) then
			  SendWorldMessage(""..head3.."求组ZUL MLD 求不环保的来！！！！|r")
			end
			if (m2 == 14) then
			  SendWorldMessage(""..head1.."速刷ADM,来的M，随便来不小白的野人~~~|r")
			end
			if (m2 == 15) then
			  SendWorldMessage(""..head1.."SM自立队，来菜刀和奶妈！！有意直接加！！|r")
			end
			if (m2 == 16) then
			  SendWorldMessage(""..head1.."ZUL求带！！！！会打百人！！！|r")
			end
			if (m2 == 17) then
			  SendWorldMessage(""..head3.."求组MLD公主！！本人熟练工来的+++|r")
			end
			if (m2 == 18) then
			  SendWorldMessage(""..head1.."MLD前门任务，随便刷下|r"..GetItemLink(17742)..""..GetItemLink(17742)..""..GetItemLink(17741).."|r|cffffc0c0不墨迹的来！！|r")
			end
			if (m2 == 19) then
			  SendWorldMessage(""..head2.."~~公会长期20G代收奥水|r"..GetItemLink(12363)..""..GetItemLink(12363).."|cffffc0c030G一组山鼠梦叶20G一组黄金参，有的直接邮寄~~！！|r")
			end
			if (m2 == 20) then
			  SendWorldMessage(""..head1.."MLD速度来刷|r"..GetItemLink(11746)..""..GetItemLink(11746).."|cffffc0c0的ZSMT！！！过时不候！！|r")
			end
			if (m2 == 21) then
			  SendWorldMessage(""..head2.."收太阳草，幽灵菇，高价求购黑莲花，有的带价M！！！|r")
			end
			if (m2 == 22) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."做任务组起，速度开组！！|r")
			end
			if (m2 == 23) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."打架来~~速度，打1进组~~|r")
			end
			if (m2 == 24) then
			  SendWorldMessage(""..head1.."速度杀SM绿龙来强力牛B人士！|r")
			end
			if (m2 == 25) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."组队做任务的来，速度开搞，来强力治疗菜刀。。。|r")
			end
			if (m2 == 26) then
			  SendWorldMessage(""..head3..""..Zones1[z2].."任务组起。。最好是能打的。。|r")
			end
			if (m2 == 27) then
			  SendWorldMessage(""..head3..""..Zones1[z2].."打架的组起来。。。|r")
			end
			if (m2 == 28) then
			  SendWorldMessage(""..head1.."求带"..Zones1[z2].."任务，新手小白。。。谢谢。。。|r")
			end
			if (m2 == 29) then
			  SendWorldMessage(""..head1.."求带SM任务，本人新手，求组队|r")
			end
			if (m2 == 30) then
			  SendWorldMessage(""..head3.."求组ADM速刷旅游观光队，熟练工。。。|r")
			end
			if (m2 == 31) then
			  SendWorldMessage(""..head1.."。。。ZUL速度来人，不开最后BOSS，来MT治疗，环保勿扰。。。。。。|r")
			end
			if (m2 == 32) then
			  SendWorldMessage(""..head1.."3G一次带刷XS修道院，全部刷速度走起，还有位。。。。|r")
			end
			if (m2 == 33) then
			  SendWorldMessage(""..head1.."ZUL不要双剑的来，直接组！！|r")
			end
			if (m2 == 34) then
			  SendWorldMessage(""..head1.."野人求组ADM女人放电影。。。|r")
			end
			if (m2 == 35) then
			  SendWorldMessage(""..head1.."大哥们你们卡么，我这怎么快掉线了。。。这什么破服务器。。。|r")
			end
			if (m2 == 36) then
			  SendWorldMessage(""..head1.."ADM刷戒指武器|r"..GetItemLink(11118)..""..GetItemLink(11118)..""..GetItemLink(9418).."|cffffc0c0的来人啊！！！|r")
			end
			if (m2 == 37) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."任务队开组，来的M！！|r")
			end
			if (m2 == 38) then
			  SendWorldMessage(""..head3.."求组"..Zones1[z2].."任务，来各系菜刀速度效率队！！|r")
			end
			if (m2 == 39) then
			  SendWorldMessage(""..head2.."诚心收黑口鱼油，精确瞄准镜，奥金锭有的带价M。。。。|r")
			end
			if (m2 == 40) then
			  SendWorldMessage(""..head2.."收|r"..GetItemLink(16206)..""..GetItemLink(16206).."|cffffc0c0一个有的带价M。。。。|r")
			end
			if (m2 == 41) then
			  SendWorldMessage(""..head1.."尼玛挖个矿又被偷袭了。。卧艹。。。|r")
			end
			if (m2 == 42) then
			  SendWorldMessage(""..head3.."求组"..Classes1[i].."职业任务队，一起做的M。。。。|r")
			end
			if (m2 == 43) then
			  SendWorldMessage(""..head2.."求购|r"..GetItemLink(2099)..""..GetItemLink(2099).."|cffffc0c0一把有的带价M。。。。黑人的勿扰。。。。谢谢！！|r")
			end
			if (m2 == 44) then
			  SendWorldMessage(""..head1.."玛拉顿的副本入口在哪啊，已经迷路跑N次尸了！！|r")
			end
			if (m2 == 45) then
			  SendWorldMessage(""..head1.."这版本PK哪个职业最厉害啊，知道的告诉下。。。|r")
			end
			if (m2 > 45) then 
			end
		  end
		  
		  if (plv>35 and plv<46) then
			local m3 = math.random(400)
			if (m3 == 1) then
			  SendWorldMessage(""..head3.."ADM自立队走起。。。来MT,MS,DPS|r")
			end
			if (m3 == 2) then
			  SendWorldMessage(""..head3.."求组剃刀高地,自立队来的M,速度开组~~！|r")
			end
			if (m3 == 3) then
			  SendWorldMessage(""..head3.."剃刀高地刷"..GetItemLink(10758)..""..GetItemLink(10758)..""..GetItemLink(10775).."|cffffc0c0的速度组起！！！|r")
			end
			if (m3 == 4) then
			  SendWorldMessage(""..head3.."求组TDGD~~！！！"..GetItemLink(14340)..""..GetItemLink(14340)..""..GetItemLink(10761).."|r|cffffc0c0顺道做任务的组起！！|r")
			end
			if (m3 == 5) then
			  SendWorldMessage(""..head2.."求组ADM刷装备，小白求带，有补贴！！|r")
			end
			if (m3 == 6) then
			  SendWorldMessage(""..head3.."剃刀沼泽开组，速度来人，随便来，DPS奶妈优先！！！|r")
			end
			if (m3 == 7) then
			  SendWorldMessage(""..head3.."求组XS,狗男女通刷的加我！！|r")
			end
			if (m3 == 8) then
			  SendWorldMessage(""..head1.."XS图书馆钥匙不需求"..GetItemLink(7714)..""..GetItemLink(7714).."|cffffc0c0的速度来。。。！|r")
			end
			if (m3 == 9) then
			  SendWorldMessage(""..head1.."血色来人。。。只刷军械库。。。刷头肩膀斧头"..GetItemLink(7718)..""..GetItemLink(7718)..""..GetItemLink(7717)..""..GetItemLink(7719).."|cffffc0c0的速度。。。。|r")
			end
			if (m3 == 10) then
			  SendWorldMessage(""..head3.."新人求组XS图书馆，做钥匙任务刷BOSS的来。。。|r")
			end
			if (m3 == 11) then
			  SendWorldMessage(""..head3.."求组XS墓园，做任务的来 ！！|r")
			end
			if (m3 == 12) then
			  SendWorldMessage(""..head1.."XS狗男女速度来人啊~~~在线等~~~|r")
			end
			if (m3 == 13) then
			  SendWorldMessage(""..head1.."萌新求带刷血色军械库，哪位好心的大哥带带啊！！！！|r")
			end
			if (m3 == 14) then
			  SendWorldMessage(""..head1.."速刷XS图书馆,来的M，随便来野人和不小白的~~~|r")
			end
			if (m3 == 15) then
			  SendWorldMessage(""..head3.."XS自立队，来菜刀和奶妈！！老手直接加！！|r")
			end
			if (m3 == 16) then
			  SendWorldMessage(""..head1.."血色求带！！！！会开BOSS！！！|r")
			end
			if (m3 == 17) then
			  SendWorldMessage(""..head3.."求组XS修道院！！来熟练工，速度开了+++|r")
			end
			if (m3 == 18) then
			  SendWorldMessage(""..head1.."血色钥匙，再组队刷下|r"..GetItemLink(7721)..""..GetItemLink(7721)..""..GetItemLink(7720).."|r|cffffc0c0会打BOSS的来！！|r")
			end
			if (m3 == 19) then
			  SendWorldMessage(""..head2.."~~收|r"..GetItemLink(2825)..""..GetItemLink(2825).."|cffffc0c0一把，有的直接带价密~~！！|r")
			end
			if (m3 == 20) then
			  SendWorldMessage(""..head1.."XS教堂速度来刷|r"..GetItemLink(7726)..""..GetItemLink(7726).."|cffffc0c0的ZSMT！！！过时不候！！|r")
			end
			if (m3 == 21) then
			  SendWorldMessage(""..head2.."收太阳草，黄金参，金珍珠，有的带价M！！！|r")
			end
			if (m3 == 22) then
			  SendWorldMessage(""..head3..""..Zones1[z2].."做任务组起，速度开组，来各种DPS！！|r")
			end
			if (m3 == 23) then
			  SendWorldMessage(""..head3..""..Zones1[z2].."PK的开组~~速刷任务顺道PK~~~来PVP牛人~~~|r")
			end
			if (m3 == 24) then
			  SendWorldMessage(""..head1.."收荆棘谷的青山，1G一张或者换的M~~~~~~|r")
			end
			if (m3 == 25) then
			  SendWorldMessage(""..head1.."凄凉之地组队做任务的来，有高端任务插件，做"..GetItemLink(17705)..""..GetItemLink(17705).."|cffffc0c0的兄弟速度，来强力治疗菜刀。。。|r")
			end
			if (m3 == 26) then
			  SendWorldMessage(""..head3.."联盟本诺莫瑞根有开组的没。。最好是能刷BOSS的。。|r")
			end
			if (m3 == 27) then
			  SendWorldMessage(""..head3.."诺莫瑞根的组起来。。。求MT带路大哥和奶妈|r")
			end
			if (m3 == 28) then
			  SendWorldMessage(""..head1.."求组侏儒副本"..GetItemLink(9456)..""..GetItemLink(9456)..""..GetItemLink(9459).."|cffffc0c0路熟打过的来。。。|r")
			end
			if (m3 == 29) then
			  SendWorldMessage(""..head1.."有做"..GetItemLink(2820)..""..GetItemLink(2820)..""..GetItemLink(11122).."|cffffc0c0的没，速度组个~~~~|r")
			end
			if (m3 == 30) then
			  SendWorldMessage(""..head2.."高价收"..GetItemLink(1982)..""..GetItemLink(1982).."|cffffc0c0，有的速度带价M。。。|r")
			end
			if (m3 == 31) then
			  SendWorldMessage(""..head2.."。。。求做"..GetItemLink(7961)..""..GetItemLink(7961).."|cffffc0c0，会做的快M我。。。。。。|r")
			end
			if (m3 == 32) then
			  SendWorldMessage(""..head1.."组队开荒刷XS修道院，全部刷速度走起，MT已就位来治疗DPS。。。。|r")
			end
			if (m3 == 33) then
			  SendWorldMessage(""..head1.."血色不要"..GetItemLink(7723)..""..GetItemLink(7723).."|cffffc0c0的来，直接组！！|r")
			end
			if (m3 == 34) then
			  SendWorldMessage(""..head3.."新人求组血色教堂。。。来MT治疗。。。|r")
			end
			if (m3 == 35) then
			  SendWorldMessage(""..head1.."大哥们你们卡么，我这怎么快掉线了。。。这什么破服务器。。。|r")
			end
			if (m3 == 36) then
			  SendWorldMessage(""..head1.."ADM刷戒指武器|r"..GetItemLink(11118)..""..GetItemLink(11118)..""..GetItemLink(9418).."|cffffc0c0的来人啊！！！|r")
			end
			if (m3 == 37) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."做任务的有没组起，来的M！！|r")
			end
			if (m3 == 38) then
			  SendWorldMessage(""..head1.."求组做"..GetItemLink(6802)..""..GetItemLink(6802)..""..GetItemLink(6829).."|cffffc0c0任务的速度M。。。|r")
			end
			if (m3 == 39) then
			  SendWorldMessage(""..head2.."收本"..GetItemLink(16084)..""..GetItemLink(16084).."|cffffc0c0便宜的M。。。。|r")
			end
			if (m3 == 40) then
			  SendWorldMessage(""..head2.."收根魔杖|r"..GetItemLink(13064)..""..GetItemLink(13064).."|cffffc0c0有的带价M。。。。|r")
			end
			if (m3 == 41) then
			  SendWorldMessage(""..head1.."尼玛草了，又被偷袭了。。一次来2个DZ真牛B啊。。。|r")
			end
			if (m3 == 42) then
			  SendWorldMessage(""..head1.."收大包一个会做的M。。。。|r")
			end
			if (m3 == 43) then
			  SendWorldMessage(""..head2.."求代做|r"..GetItemLink(10021)..""..GetItemLink(10021)..""..GetItemLink(10019).."|cffffc0c0，有材料。。。。会做的M。。。。谢谢！！|r")
			end
			if (m3 == 44) then
			  SendWorldMessage(""..head1.."请问|r"..GetItemLink(18083)..""..GetItemLink(18083).."|cffffc0c0，哪里出啊。。。。！！|r")
			end
			if (m3 == 45) then
			  SendWorldMessage(""..head3..""..Zones1[z2].."。。。"..Zones1[z2].."任务的M。。。！！|r")
			end
			if (m3 == 46) then
			  SendWorldMessage(""..head1.."吉兹洛克在哪里啊。。。人都转晕了急死了。。。！！|r")
			end
			if (m3 == 47) then
			  SendWorldMessage(""..head1.."问下需要学魔杖吗。。。！！|r")
			end
			if (m3 == 48) then
			  SendWorldMessage(""..head1.."》》》》问下老司机奥术水晶哪里挖啊》》》》|r")
			end
			if (m3 > 48) then 
			end
		  end
		  
		  if (plv>1 and plv<36) then
			local m4 = math.random(400)
			if (m4 == 1) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."有一起做任务的没，组个。。。|r")
			end
			if (m4 == 2) then
			  SendWorldMessage(""..head1.."求组剃刀沼泽,自立队来的M,速度开组~~！|r")
			end
			if (m4 == 3) then
			  SendWorldMessage(""..head1.."求组矿井"..GetItemLink(7230)..""..GetItemLink(7230)..""..GetItemLink(5201).."|cffffc0c0的速度组起！！！|r")
			end
			if (m4 == 4) then
			  SendWorldMessage(""..head1.."新手求组暴风监狱~~！！！刷"..GetItemLink(2941)..""..GetItemLink(2941).."|r|cffffc0c0做任务的组起！！|r")
			end
			if (m4 == 5) then
			  SendWorldMessage(""..head2.."死矿的来，速度开组！！|r")
			end
			if (m4 == 6) then
			  SendWorldMessage(""..head1.."剃刀沼泽开组，速度来人，随便来，DPS奶妈优先！！！|r")
			end
			if (m4 == 7) then
			  SendWorldMessage(""..head1.."求组监狱，加我个！！|r")
			end
			if (m4 == 8) then
			  SendWorldMessage(""..head1.."矿井速度来。。。随便来人开搞了！|r")
			end
			if (m4 == 9) then
			  SendWorldMessage(""..head1.."新人求问哪里学骑术买马啊。。。。|r")
			end
			if (m4 == 10) then
			  SendWorldMessage(""..head1.."新人求助部落恐龙哪里买啊。。。|r")
			end
			if (m4 == 11) then
			  SendWorldMessage(""..head1.."1G求法爷开个门 ！！|r")
			end
			if (m4 == 12) then
			  SendWorldMessage(""..head1.."新人求带矿井~~~哪个大哥带下啊~~~|r")
			end
			if (m4 == 13) then
			  SendWorldMessage(""..head1.."萌新求助沼泽怎么走？？|r")
			end
			if (m4 == 14) then
			  SendWorldMessage(""..head1.."刚才的SS哥拉下我，我在"..Zones1[z2].."迷路了~~~|r")
			end
			if (m4 == 15) then
			  SendWorldMessage(""..head1.."骑术哪里学啊，求大神告诉一下！！|r")
			end
			if (m4 == 16) then
			  SendWorldMessage(""..head1.."新手请教怒焰裂谷怎么去？？？|r")
			end
			if (m4 == 17) then
			  SendWorldMessage(""..head1.."组队杀霍格，杀霍格的速度了~~~|r")
			end
			if (m4 == 18) then
			  SendWorldMessage(""..head1.."做副本任务，组队刷下哀嚎洞穴|r"..GetItemLink(6627)..""..GetItemLink(6627)..""..GetItemLink(6469).."|r|cffffc0c0会打BOSS的来！！|r")
			end
			if (m4 == 19) then
			  SendWorldMessage(""..head2.."~~收|r"..GetItemLink(21341)..""..GetItemLink(21341).."|cffffc0c0一个，价格合适的带价密~~！！|r")
			end
			if (m4 == 20) then
			  SendWorldMessage(""..head2.."大量收|r"..GetItemLink(2592)..""..GetItemLink(2592)..""..GetItemLink(2840).."|cffffc0c0有的M，支持邮寄！！|r")
			end
			if (m4 == 21) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."做任务的有没！组个！|r")
			end
			if (m4 == 22) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."做任务的开组！随便来人！|r")
			end
			if (m4 == 23) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."PK~~~来PVP大神~~~|r")
			end
			if (m4 == 24) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."做任务的密~~~~~~|r")
			end
			if (m4 == 25) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."任务的组个啊，来的兄弟速度M啊，来强力PK菜刀和治疗。。。|r")
			end
			if (m4 == 26) then
			  SendWorldMessage(""..head1.."联盟本诺莫瑞根有开组的没。。最好是能刷BOSS的。。|r")
			end
			if (m4 == 27) then
			  SendWorldMessage(""..head1.."诺莫瑞根的组起来。。。求MT带路大哥和奶妈|r")
			end
			if (m4 == 28) then
			  SendWorldMessage(""..head1.."求组侏儒副本任务队"..GetItemLink(9279)..""..GetItemLink(9279).."|cffffc0c0会走后门的来。。。|r")
			end
			if (m4 == 29) then
			  SendWorldMessage(""..head1.."有做"..Classes1[i].."职业任务的没，速度组个~~~~|r")
			end
			if (m4 == 30) then
			  SendWorldMessage(""..head2.."高价收"..GetItemLink(1982)..""..GetItemLink(1982).."|cffffc0c0，有的速度带价M。。。|r")
			end
			if (m4 == 31) then
			  SendWorldMessage(""..head2.."。。。求做"..GetItemLink(22246)..""..GetItemLink(22246).."|cffffc0c0，会做的快M我。。。。。。|r")
			end
			if (m4 == 32) then
			  SendWorldMessage(""..head1.."组队开荒刷XS修道院，全部刷速度走起，MT已就位来治疗DPS。。。。|r")
			end
			if (m4 == 33) then
			  SendWorldMessage(""..head1.."有"..Zones1[z2].."做任务的没！组一下！|r")
			end
			if (m4 == 34) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."做任务的组。。。|r")
			end
			if (m4 == 35) then
			  SendWorldMessage(""..head1.."星期几维护啊，有知道的没。。。|r")
			end
			if (m4 == 36) then
			  SendWorldMessage(""..head1.."坐骑哪里买啊！啊啊。。。|r")
			end
			if (m4 == 37) then
			  SendWorldMessage(""..head1.."小白请问中立拍卖行在哪里啊？|r")
			end
			if (m4 == 38) then
			  SendWorldMessage(""..head1.."地铁怎么走啊。。。|r")
			end
			if (m4 == 39) then
			  SendWorldMessage(""..head2.."收几组"..GetItemLink(4306)..""..GetItemLink(4306)..""..GetItemLink(3575).."|cffffc0c0便宜的M。。。。|r")
			end
			if (m4 == 40) then
			  SendWorldMessage(""..head2.."请问锡矿在哪里挖啊。。。。|r")
			end
			if (m4 == 41) then
			  SendWorldMessage(""..head1.."幽暗城飞艇在哪啊？？|r")
			end
			if (m4 == 42) then
			  SendWorldMessage(""..head1.."萌新请问大神怎么去藏宝海湾啊？？|r")
			end
			if (m4 == 43) then
			  SendWorldMessage(""..head2.."请问|r"..GetItemLink(13397)..""..GetItemLink(13397).."|cffffc0c0哪里出啊。。。。谢谢！！|r")
			end
			if (m4 == 44) then
			  SendWorldMessage(""..head1.."影牙的组起啊！！！菜刀速度来！！！|r")
			end
			if (m4 == 45) then
			  SendWorldMessage(""..head1.."影牙开组。。。。菜刀奶妈直接进。。。|r")
			end
			if (m4 == 46) then
			  SendWorldMessage(""..head1.."YY城堡开组。。。|r"..GetItemLink(6220)..""..GetItemLink(6220)..""..GetItemLink(6324).."|cffffc0c0！菜刀奶妈直接进。。。|r")
			end
			if (m4 == 47) then
			  SendWorldMessage(""..head1..""..Zones1[z2].."做任务的组起。。。速度开打。。。|r")
			end
			if (m4 == 48) then
			  SendWorldMessage(""..head1.."怎么去黑海岸啊。。。求指教。。。|r")
			end
			if (m4 == 49) then
			  SendWorldMessage(""..head1.."要SS拉人的请点确认。。。|r")
			end
			if (m4 == 50) then
			  SendWorldMessage(""..head1.."请问"..Zones1[z2].."飞行点在哪里啊。。。|r")
			end
			if (m4 == 51) then
			  SendWorldMessage(""..head1.."请问"..GetItemLink(3358)..""..GetItemLink(3358).."|cffffc0c0哪里多啊。。。|r")
			end
			if (m4 == 52) then
			  SendWorldMessage(""..head1.."GM在吗，能带我练练级吗。。。|r")
			end
			if (m4 == 53) then
			  SendWorldMessage(""..head1.."无聊人士组起。。。任务刷本PK随意。。。|r")
			end
			if (m4 > 53) then 
			end
		  end

		end
    end
  end
end


local function Money_Change1(event, player)
    if (player:IsInGroup()) then --不要删除此句，并发过高会宕机
    else
	    if (player:GetGMRank()<1)then
		local i2 = player:GetClass()
		local head4 = "|cffffc0c0[2. 交易] "..Colors[i2].."[|Hplayer:"..player:GetName().."|h"..player:GetName().."]|r|cffffc0c0： "

		    for slot = 23, 38 do
			local item = player:GetItemByPos( 255, slot )
				if item then 
					if (item:GetQuality()>2) and (item:IsSoulBound()==false) then
					local itk = item:GetItemLink(4)
					local m6 = math.random(500)
						if (m6 == 1) then
						SendWorldMessage(""..head4.."有要"..itk..""..itk.."|cffffc0c0的没，速度了，太低了不回！！！|r")
						end
						if (m6 == 2) then
						SendWorldMessage(""..head4..""..itk..""..itk.."|cffffc0c0要的带价M~~~|r")
						end
						if (m6 == 3) then
						SendWorldMessage(""..head4.."有要"..itk..""..itk.."|cffffc0c0的没，需要的老板速度了，价格面议！！！|r")
						end
						if (m6 == 4) then
						SendWorldMessage(""..head4.."有需要"..itk..""..itk.."|cffffc0c0的么，进组交易，价格好说！！！|r")
					    end
						if (m6 == 5) then
					    SendWorldMessage(""..head4.."机会！机会！忍痛甩卖"..itk..""..itk.."|cffffc0c0组我直接面谈交谈，价格私聊！！|r")
						end
						if (m6 == 6) then
						SendWorldMessage(""..head4.."极品出售"..itk..""..itk.."|cffffc0c0组我面谈交易！！|r")
						end
						if (m6 == 7) then
						SendWorldMessage(""..head4.."。。。。。。。挥泪甩卖"..itk..""..itk.."|cffffc0c0，需要的老板组我交易。。。。。。。|r")
						end
						if (m6 == 8) then
						SendWorldMessage(""..head4.."。。。转让"..itk..""..itk.."|cffffc0c0，需要的组我交易，价格合适就出了。。。。|r")
						end
						if (m6 > 8) then
						end
					end
				end
		    end
		end
    end
end   
 
local function Kill_1(event, killer, killed)
    local i3 = killer:GetClass()
    local le = killer:GetLevel()
    local string1 = ""..killer:GetName().."的BL"..Classes1[i3]..""
    local string2 = ""..killer:GetName().."的LM"..Classes1[i3]..""
    local i4 = killed:GetClass()
    if (killed:IsInGroup()) then 
    else
		if (killer == killed) then 
        else
			if (killed:GetGMRank()<1)then
			local z1 = killed:GetZoneId()
 
                if (Zones1[z1] == nil) then
                SendWorldMessage("|cffffc0c0[1. 综合] "..Colors[i4].."[|Hplayer:"..killed:GetName().."|h"..killed:GetName().."]|r|cffffc0c0： 呼叫GM，请告诉我这是哪里，我传错地图了吗????????????????????|r")
                else

					if (killed:GetTeam()==0) then
					local m7 = math.random(40)
					local head5 = "|cffffc0c0[1. 综合] "..Colors[i4].."[|Hplayer:"..killed:GetName().."|h"..killed:GetName().."]|r|cffffc0c0： "
						if (m7 == 1) then
						SendWorldMessage(""..head5..""..Zones1[z1].."有BL~~~~呼叫大侠，快来~~~~给我报仇~~~~|r")
						end
						if (m7 == 2) then
						SendWorldMessage(""..head5.."有来"..Zones1[z1].."杀BL的吗。。。速度来人。。|r")
						end
						if (m7 == 3) then
						SendWorldMessage(""..head5..""..Zones1[z1].."发现BL。。。速度来强力人士！！|r")
						end
						if (m7 == 4) then
						SendWorldMessage(""..head5.."没心思做任务了，有来"..Zones1[z1].."打架的吗？开组打BL了！！！|r")
						end
						if (m7 == 5) then
						SendWorldMessage(""..head5.."惨啊，我在"..Zones1[z1].."被叫"..string1.."守尸了，求大神救命。。。。|r")
						end
						if (m7 == 6) then
						SendWorldMessage(""..head5..""..Zones1[z1].."有个"..le.."级的BL到处杀人，做不了任务，有一起来PK的么？|r")
						end
						if (m7 == 7) then
						SendWorldMessage(""..head5.."我在"..Zones1[z1].."被一个叫"..string1.."打死几次了，有PVP大神帮我报仇吗？？|r")
						end
						if (m7 == 8) then
						SendWorldMessage(""..head5.."。。这什么情况。。杀我人算了，还要守我的尸？？|r")
						end
						if (m7 == 9) then
						SendWorldMessage(""..head5.."。。"..Zones1[z1].."做任务又被打死了。。叫"..string1.."你等着，我马上叫大号来。。|r")
						end
						if (m7 == 10) then
						SendWorldMessage(""..head5.."我天真的以为我很强大。。直到我出门就遇见了个"..le.."级的BL杀手。。|r")
						end
						if (m7 == 11) then
						SendWorldMessage(""..head5.."。。"..Zones1[z1].."寻求支援。。有大号的赶紧上啊。。|r")
						end
						if (m7 == 12) then
						   if (le==60) then
						   SendWorldMessage(""..head5..""..Zones1[z1].."有个叫"..string1.."大号到处杀小号。。求LM大号快来。。|r")
						   end
						end
						if (m7 > 12) then
						end
					end

					if (killed:GetTeam()==1) then
					local m8 = math.random(40)
					local head6 = "|cffffc0c0[1. 综合] "..Colors[i4].."[|Hplayer:"..killed:GetName().."|h"..killed:GetName().."]|r|cffffc0c0： "
						if (m8 == 1) then
						SendWorldMessage(""..head6..""..Zones1[z1].."这有LM。。。快来人。。。没事干杀LM的来。。。。|r")
						end
						if (m8 == 2) then
						SendWorldMessage(""..head6.."兄弟们快来"..Zones1[z1].."杀LM啊。。。顺便帮我报仇啊！！|r")
						end
						if (m8 == 3) then
						SendWorldMessage(""..head6..""..Zones1[z1].."有一个"..le.."级的叫"..string2.."到处杀人。。。PK牛人快来啊！！|r")
						end
						if (m8 == 4) then
						SendWorldMessage(""..head6.."有来"..Zones1[z1].."打架的吗？组起打跑LM再做任务！！！|r")
						end
						if (m8 == 5) then
						SendWorldMessage(""..head6.."我在"..Zones1[z1].."被叫"..string2.."守尸，气人啊，快来各路武林高手。。。|r")
						end
						if (m8 == 6) then
						SendWorldMessage(""..head6..""..Zones1[z1].."貌似又有架打了，有开组来PK的么？|r")
						end
						if (m8 == 7) then
						SendWorldMessage(""..head6.."我在"..Zones1[z1].."被个"..le.."级的叫"..string2.."打死了，有大佬可以飞过来报仇么。。|r")
						end
						if (m8 == 8) then
						SendWorldMessage(""..head6.."尼玛。。居然打不过。。。这服LM真牛B啊。。。|r")
						end
						if (m8 == 9) then
						SendWorldMessage(""..head6.."。。这还让人活吗。。。PVP服务器就是凶残啊。。。|r")
						end
						if (m8 == 10) then
						SendWorldMessage(""..head6.."。。又被联盟欺负了。。。大神们你们在哪里。。。|r")
						end
                        if (m8 == 11) then
						SendWorldMessage(""..head6.."|cffffc0c0我怎么又死了，大家帮忙看看这是什么地方。。。怎么查看坐标啊。。|r")
						end
						if (m8 == 12) then
						SendWorldMessage(""..head6.."。。"..Zones1[z1].."发现LM活动。。打架兼做任务的组起。。。|r")
						end
						if (m8 == 13) then
						   if (le==60) then
						   SendWorldMessage(""..head6..""..Zones1[z1].."有个叫"..string2.."大号到处捣乱。。求BL大佬快来帮忙。。|r")
						   end
						end
						if (m8 > 13) then
						end
					end

				end
			end
        end
    end
end

RegisterPlayerEvent(14, Money_Change1)
RegisterPlayerEvent(37, Loot_money1)
RegisterPlayerEvent(6, Kill_1)
