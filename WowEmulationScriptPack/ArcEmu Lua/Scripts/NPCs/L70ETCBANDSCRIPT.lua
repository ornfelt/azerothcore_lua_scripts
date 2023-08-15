-- ==================== time to Define Locals! oh boy! ===========================================================

local Manager = 986766
local Stagespell = 986767
local Stagespellx = 986768
local Stageobject = 986769
local Belfetc = 986765
local Orcetc = 986761
local Undeadetc = 986764
local Trolletc = 986763
local Drumetc = 986762

-- =============================== Starter ================================================================

function L70ETC_OnGossipTalk(pUnit, event, player, pMisc)
   pUnit:GossipCreateMenu(50, player, 0)
   pUnit:GossipMenuAddItem(9, "Play [The Power Of the Horde]", 1, 0)
   pUnit:GossipMenuAddItem(0, "Never Mind", 2, 0)
   pUnit:GossipSendMenu(player)
end

function L70ETC_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
-----------------------LOCAL------X-Cords------Y-Cords---Z-Cords-O-Cords-Faction-Time-------
   pUnit:SpawnCreature(Belfetc, -3697.369873, -2280.434570, 170, 1.620911, 35, 0); ---Belf Lead Guitar Spawn
   pUnit:SpawnCreature(Orcetc, -3692.539063, -2280.956299, 170, 1.620911, 35, 0); ---Orc Singer Spawn
   pUnit:SpawnCreature(Undeadetc, -3690.457764, -2280.225342, 170, 1.620911, 35, 0); ---Undead Guitar Spawn
   pUnit:SpawnCreature(Trolletc, -3687.972412, -2280.902100, 170, 1.620911, 35, 0); ---Troll Bass Spawn
   pUnit:SpawnCreature(Drumetc, -3692.6251758, -2285.317734, 173.5, 1.620911, 35, 0); ---Tauren Drummer Spawn
   pUnit:SpawnCreature(Stagespell, -3705.934570, -2277.15250, 166.5, 1.620911, 35, 0); ---StageSpell caster (recomended to spawn UNDER the Stage, but not through the world.)
   pUnit:SpawnCreature(Stagespellx, -3709.523926, -2277.397217, 166.5, 1.620911, 35, 0); ---StageSpell2 caster (recomended to spawn to a hidden spot near the stage)
   pUnit:SpawnCreature(Stageobject, -3713.583496, -2277.610352, 166.5, 1.620911, 35, 0); ---GameObject Spawner (recomended to spawn to a hidden spot near the stage)
   pUnit:Despawn(1,0)
   pUnit:GossipComplete(player)
end


if (intid == 2) then
   pUnit:GossipComplete(player)
   player:SendBroadcastMessage("No Music For You!")
   player:SendAreaTriggerMessage("No Music For You!")
end
end

RegisterUnitGossipEvent(Manager, 1, "L70ETC_OnGossipTalk")
RegisterUnitGossipEvent(Manager, 2, "L70ETC_OnGossipSelect")


-------------ORC----------------

function Orca(pUnit, Event)
       pUnit:RemoveEvents()
	   print "Let's Rock!" ---Delete this if you want
	   pUnit:CastSpell(35341)
       pUnit:SendChatMessage(14, 0, "1")
       pUnit:RegisterEvent("Orcb", 1000, 0)
end

function Orcb(pUnit, Event)
       pUnit:RemoveEvents()
	   print "Enjoy the show!" ---Delete this is you want
       pUnit:SendChatMessage(14, 0, "2")
       pUnit:RegisterEvent("Orcc", 1000, 0)
end

function Orcc(pUnit, Event)
       pUnit:RemoveEvents()
       pUnit:SendChatMessage(14, 0, "3")
       pUnit:RegisterEvent("Orcd", 1000, 0)
end

function Orcd(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:PlaySoundToSet(11803)
	   pUnit:SendChatMessage(14, 0, "Storm, Earth and Fire Heed my call!")
       pUnit:RegisterEvent("Orcf", 46000, 0)
end

function Orcf(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "I am the son of the wind and rain, Thunder beckons and I heed the call.")
       pUnit:RegisterEvent("Orcg", 5000, 0)
end

function Orcg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "If i die upon this day In battle I will fall.")
       pUnit:RegisterEvent("Orch", 7000, 0)
end

function Orch(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Hear me brothers gather up the wolves to battle we will ride.")
       pUnit:RegisterEvent("Orci", 6000, 0)
end

function Orci(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Wardrums echo the beating heart, pounding from inside.")
       pUnit:RegisterEvent("Orcj", 7000, 0)
end

function Orcj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM! Black clouds fill the sky!")
       pUnit:RegisterEvent("Orck", 3000, 0)
end

function Orck(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH! I hear my battle cry!")
       pUnit:RegisterEvent("Orcl", 3000, 0)
end

function Orcl(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE! Thunder will bring forth!")
       pUnit:RegisterEvent("Orcm", 4000, 0)
end

function Orcm(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH! From The Power of the Horde!")
       pUnit:RegisterEvent("Orcn", 16000, 0)
end

function Orcn(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Farseer to the warsong clan to no matter will I kneel.")
       pUnit:RegisterEvent("Orco", 6000, 0)
end

function Orco(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Feel the power and the energy for the black blood, honor and steel.")
       pUnit:RegisterEvent("Orcp", 7000, 0)
end

function Orcp(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "I feel the fire burning in my veins lightning strikes at my command.")
       pUnit:RegisterEvent("Orcq", 7000, 0)
end

function Orcq(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "By storm and earth, axe and fire we come to claim this land.")
       pUnit:RegisterEvent("Orcr", 7000, 0)
end

function Orcr(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM! Black clouds fill the sky!")
       pUnit:RegisterEvent("Orcs", 4000, 0)
end

function Orcs(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH! I hear my battle cry!")
       pUnit:RegisterEvent("Orct", 3000, 0)
end

function Orct(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE! Thunder will bring forth!")
       pUnit:RegisterEvent("Orcu", 3000, 0)
end

function Orcu(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH! From The Power of the Horde!")
       pUnit:RegisterEvent("Orcv", 66000, 0)
end

function Orcv(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "YEAHHH!")
       pUnit:RegisterEvent("Orcw", 4000, 0)
end

function Orcw(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Surrounded by the enemy the wolf among the hounds.")
       pUnit:RegisterEvent("Orcx", 7000, 0)
end

function Orcx(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Thunder turns to silence it took the hundred to bring me down.")
       pUnit:RegisterEvent("Orcy", 6000, 0)
end

function Orcy(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Wolf brothers falling at my side with honor I will die.")
       pUnit:RegisterEvent("Orcz", 8000, 0)
end

function Orcz(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "Upon the altar of the storms I will be reborn.")
       pUnit:RegisterEvent("Orcaa", 5000, 0)
end

function Orcaa(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM! Black clouds fill the sky!")
       pUnit:RegisterEvent("Orcbb", 4000, 0)
end

function Orcbb(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH! I hear my battle cry!")
       pUnit:RegisterEvent("Orccc", 3000, 0)
end

function Orccc(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE! Thunder will bring forth!")
       pUnit:RegisterEvent("Orcdd", 3000, 0)
end

function Orcdd(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH! For I have been reborn!")
       pUnit:RegisterEvent("Orcee", 4000, 0)
end

function Orcee(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Orcff", 3000, 0)
end

function Orcff(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Orcgg", 3000, 0)
end

function Orcgg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Orchh", 3000, 0)
end

function Orchh(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Orcii", 5000, 0)
end

function Orcii(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "THE POWER OF THE HORDE!")
       pUnit:RegisterEvent("Orcjj", 20000, 0)
end

function Orcjj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SpawnCreature(Manager, -3692.405762, -2275.817139, 166.5, 1.444250, 35, 0); ---Manager Spawn (Spawn next to Stage)
	   pUnit:Despawn(1,0)
end

RegisterUnitEvent(Orcetc, 18, "Orca")

---TROLL---

function Trolla(pUnit, Event)
       pUnit:CastSpell(35341)
       pUnit:RegisterEvent("Trollb", 74000, 0)
end


function Trollb(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Trollc", 3000, 0)
end

function Trollc(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Trolld", 3000, 0)
end

function Trolld(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Trolle", 4000, 0)
end

function Trolle(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Trollf", 43000, 0)
end
---------------------------------------------------
function Trollf(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Trollg", 4000, 0)
end

function Trollg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Trollh", 3000, 0)
end

function Trollh(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Trolli", 3000, 0)
end

function Trolli(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Trollsolo", 5000, 0)
end
----------------------------------------------------

---Solo Fire Hands stays on NPC for some reason, Fix this if u want but keep the timing right---
function Trollsolo(pUnit, Event)
	   pUnit:CastSpell(45984)
       pUnit:RegisterEvent("Trollj", 91000, 0)
end

-----------------------------------------------------
function Trollj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Trollk", 4000, 0)
end

function Trollk(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Trolll", 3000, 0)
end

function Trolll(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Trollm", 3000, 0)
end

function Trollm(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Trolln", 4000, 0)
end

function Trolln(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Trollo", 3000, 0)
end

function Trollo(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Trollp", 3000, 0)
end

function Trollp(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Trollq", 3000, 0)
end

function Trollq(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Trollr", 25000, 0)
end

function Trollr(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:Despawn(1,0)
end

RegisterUnitEvent(Trolletc, 18, "Trolla")

-------UNDEAD-------

function Undeada(pUnit, Event)
       pUnit:CastSpell(35341)
       pUnit:RegisterEvent("Undeadb", 74000, 0)
end


function Undeadb(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Undeadc", 3000, 0)
end

function Undeadc(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Undeadd", 3000, 0)
end

function Undeadd(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Undeade", 4000, 0)
end

function Undeade(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Undeadf", 43000, 0)
end
---------------------------------------------------
function Undeadf(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Undeadg", 4000, 0)
end

function Undeadg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Undeadh", 3000, 0)
end

function Undeadh(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Undeadi", 3000, 0)
end

function Undeadi(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Undeadsolo", 5000, 0)
end
-----------------------------------------------------
---Solo Fire Hands stays on NPC for some reason, Fix this if u want but keep the timing right---
function Undeadsolo(pUnit, Event)
	   pUnit:CastSpell(45984)
       pUnit:RegisterEvent("Undeadj", 91000, 0)
end

-----------------------------------------------------
function Undeadj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Undeadk", 4000, 0)
end

function Undeadk(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Undeadl", 3000, 0)
end

function Undeadl(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Undeadm", 3000, 0)
end

function Undeadm(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Undeadn", 4000, 0)
end

function Undeadn(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Undeado", 3000, 0)
end

function Undeado(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Undeadp", 3000, 0)
end

function Undeadp(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Undeadq", 3000, 0)
end

function Undeadq(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Undeadr", 25000, 0)
end

function Undeadr(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:Despawn(1,0)
end

RegisterUnitEvent(Undeadetc, 18, "Undeada")

-----BELF----

function Belfa(pUnit, Event)
       pUnit:CastSpell(35341)
       pUnit:RegisterEvent("Belfb", 74000, 0)
end


function Belfb(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Belfc", 3000, 0)
end

function Belfc(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Belfd", 3000, 0)
end

function Belfd(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Belfe", 4000, 0)
end

function Belfe(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Belff", 43000, 0)
end
---------------------------------------------------
function Belff(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Belfg", 4000, 0)
end

function Belfg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Belfh", 3000, 0)
end

function Belfh(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Belfi", 3000, 0)
end

function Belfi(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Belfsolo", 5000, 0)
end
-----------------------------------------------------


---Solo Fire Hands stays on NPC for some reason, Fix this if u want but keep the timing right---
function Belfsolo(pUnit, Event)
	   pUnit:CastSpell(45984)
       pUnit:RegisterEvent("Belfj", 91000, 0)
end

-----------------------------------------------------
function Belfj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Belfk", 4000, 0)
end

function Belfk(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Belfl", 3000, 0)
end

function Belfl(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Belfm", 3000, 0)
end

function Belfm(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Belfn", 4000, 0)
end

function Belfn(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Belfo", 3000, 0)
end

function Belfo(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Belfp", 3000, 0)
end

function Belfp(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Belfq", 3000, 0)
end

function Belfq(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Belfr", 25000, 0)
end

function Belfr(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:Despawn(1,0)
end

RegisterUnitEvent(Belfetc, 18, "Belfa")

------DRUMS------

function Drumsa(pUnit, Event)
       pUnit:CastSpell(35341)
       pUnit:RegisterEvent("Drumsb", 74000, 0)
end


function Drumsb(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Drumsc", 3000, 0)
end

function Drumsc(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Drumsd", 3000, 0)
end

function Drumsd(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Drumse", 4000, 0)
end

function Drumse(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Drumsf", 43000, 0)
end
---------------------------------------------------
function Drumsf(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Drumsg", 4000, 0)
end

function Drumsg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Drumsh", 3000, 0)
end

function Drumsh(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Drumsi", 3000, 0)
end

function Drumsi(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Drumsj", 96000, 0)
end
-----------------------------------------------------
function Drumsj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Drumsk", 4000, 0)
end

function Drumsk(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Drumsl", 3000, 0)
end

function Drumsl(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Drumsm", 3000, 0)
end

function Drumsm(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Drumsn", 4000, 0)
end

function Drumsn(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "STORM!")
       pUnit:RegisterEvent("Drumso", 3000, 0)
end

function Drumso(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "EARTH!")
       pUnit:RegisterEvent("Drumsp", 3000, 0)
end

function Drumsp(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "FIRE!")
       pUnit:RegisterEvent("Drumsq", 3000, 0)
end

function Drumsq(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:SendChatMessage(14, 0, "DEATH!")
       pUnit:RegisterEvent("Drumsr", 25000, 0)
end

function Drumsr(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:Despawn(1,0)
end

RegisterUnitEvent(Drumetc, 18, "Drumsa")

-----SPELLS-----

function Sspella(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspellb", 20000, 0)
end

function Sspellb(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3697.611816,-2281.782227,169.629089,42023)
       pUnit:RegisterEvent("Sspellc", 20000, 0)
end

function Sspellc(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3697.611816,-2281.782227,169.629089,42023)
       pUnit:RegisterEvent("Sspelld", 20000, 0)
end

function Sspelld(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspelle", 20000, 0)
end

function Sspelle(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3697.611816,-2281.782227,169.629089,42023)
       pUnit:RegisterEvent("Sspellf", 20000, 0)
end

function Sspellf(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspellg", 20000, 0)
end

function Sspellg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3697.611816,-2281.782227,169.629089,42023)
       pUnit:RegisterEvent("Sspellh", 20000, 0)
end

function Sspellh(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspelli", 20000, 0)
end

function Sspelli(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspellj", 20000, 0)
end

function Sspellj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3697.611816,-2281.782227,169.629089,42023)
	   pUnit:RegisterEvent("Sspelll", 20000, 0)
end

function Sspelll(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspellm", 20000, 0)
end

function Sspellm(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspelln", 10000, 0)
end

function Sspelln(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3689.554443,-2282.156738,169.629089,41482)
       pUnit:RegisterEvent("Sspellend", 49000, 0)
end
--------------The BIG Explosion at the end----------------
function Sspellend(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpellAoF(-3693.386230,-2283.631836,169.644255,59084)
	   pUnit:CastSpellAoF(-3693.386230,-2283.631836,169.644255,59084)
       pUnit:RegisterEvent("Sspello", 7000, 0)
end
----------------------------------------------------------
function Sspello(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:Despawn(1,0)
end

RegisterUnitEvent(Stagespell, 18, "Sspella")

--------------Spells2-------
-----ALL of these are Earthquakes------


function Sspellxa(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxb", 20000, 0)
end


function Sspellxb(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxc", 20000, 0)
end


function Sspellxc(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxd", 20000, 0)
end


function Sspellxd(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxe", 20000, 0)
end


function Sspellxe(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxf", 20000, 0)
end


function Sspellxf(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxg", 20000, 0)
end


function Sspellxg(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxh", 20000, 0)
end


function Sspellxh(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxi", 20000, 0)
end


function Sspellxi(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxj", 20000, 0)
end


function Sspellxj(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxl", 20000, 0)
end


function Sspellxl(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxm", 20000, 0)
end


function Sspellxm(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxn", 20000, 0)
end


function Sspellxn(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspello", 20000, 0)
end


function Sspellxo(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:CastSpell(37764)
       pUnit:RegisterEvent("Sspellxend", 1000, 0)
end

function Sspellxend(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:Despawn(1,0)
end


RegisterUnitEvent(Stagespellx, 18, "Sspellxa")

----------Light Effects-------
----------Light effects from the solo-----------

function Sobjecta(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:RegisterEvent("Sobjectb", 137000, 0)
end

function Sobjectb(pUnit, Event)
       pUnit:RemoveEvents()
       pUnit:SpawnGameObject(177415, -3696.622314, -2281.748535, 169.633362, 1.370520, 50000)
	   pUnit:SpawnGameObject(177415, -3690.072754, -2281.977539, 169.633362, 1.370520, 50000)
	   pUnit:SpawnGameObject(177415, -3693.756592, -2288.288330, 173.271744, 1.370520, 50000)
	   pUnit:RegisterEvent("Sobjectend", 1000, 0)
end

function Sobjectend(pUnit, Event)
       pUnit:RemoveEvents()
	   pUnit:Despawn(1,0)
end


RegisterUnitEvent(Stageobject, 18, "Sobjecta")


-----------END-----------
