-----------------------------------------
--------------Malygos Events-------------
-----------------------------------------

-------------------
-------Combat------
-------------------

function Malygos_OnCombat(unit, event)
unit:SendChatMessage(14, 0, "Lesser beings, intruding here! A shame that your excess courage does not compensate for your stupidity!")
unit:SendChatMessage(14, 0, "None but the blue dragonflight are welcome here! Perhaps this is the work of Alexstrasza? Well then, she has sent you to your deaths!")
unit:SendChatMessage(14, 0, "What could you hope to accomplish? To storm brazenly into my domain... to employ magic... against ME? <Laughs>")
unit:SendChatMessage(14, 0, "I am without limits here... the rules of your cherished reality do not apply... in this realm, I am in control...")
unit:SendChatMessage(14, 0, "I give you one chance. Pledge fealty to me, and perhaps I won't slaughter you for your insolence!")
unit:RegisterEvent("Malygos_Phase1", 1000, 0)

end

RegisterUnitEvent(28859, 1, "Malygos_OnCombat")

-------------------
--------Dead-------
-------------------

function Malygos_OnDead(unit, event)
unit:RemoveEvents()
unit:SendChatMessage(14, 0, "UNTHINKABLE! The mortals will destroy... everything... my sister... what have you...")
x = GetX()
y = GetY()
z = GetZ()
o = GetO()
unit:SpawnCreature(32295, x, y, z, 0, 0, 600000)
unit:RegisterEvent("Alextraza_AfterMalygosDead", 1000, 0)
end

function Alextraza_AfterMalygosDead(unit, event)
unit:SendChatMessage(14, 0, "I did what I had to, brother. You gave me no alternative." )
unit:SendChatMessage(14, 0, "And so ends the Nexus war.")
unit:SendChatMessage(14, 0, "This resolution pains me deeply, but the destruction - the monumental loss of life - had to end. Regardless of Malygos's recent transgressions, I will mourn his loss. He was once a guardian, a protector. This day, one of the world's mightiests, has fallen.")
unit:SendChatMessage(14, 0, "The Red Dragonflight will take on the burden of mending the devastation brought on Azeroth. Return home to your people and rest. Tomorrow will bring you new challenges, and you must be ready to face them. Life, goes on.")
end

RegisterUnitEvent(28859, 4, "Malygos_OnDead")
RegisterUnitEvent(32295, 1, "Alextraza_AfterMalygosDead")

-------------------
-------Leave-------
-------------------

function Malygos_OnLeave(unit, event)
unit:RemoveEvents()
end

RegisterUnitEvent(28859, 2, "Malygos_OnLeave")

-------------------
----PlayerDead-----
-------------------

function Malygos_OnPlayerDeath(unit, event)
unit:RemoveEvent()
local vchoice = math.random(1, 3)
	if vchoice == 1 then
unit:SendChatMessage(14, 0, "Alexstrasza! Another of your brood falls!")
unit:SendChatMessage(14, 0, "Little more then gnats!")
unit:SendChatMessage(14, 0, "Your red allies will share your fate...")
	elseif vchoice == 2 then
unit:SendChatMessage(14, 0, "Your energy will be put to good use!")
unit:SendChatMessage(14, 0, "I am the spell-weaver! My power is infinite!")
unit:SendChatMessage(14, 0, "Your spirit will linger here forever!")
	elseif vchoice == 3 then
unit:SendChatMessage(14, 0, "Your stupidity has finally caught up to you!")
unit:SendChatMessage(14, 0, "More artifacts to confiscate...")
unit:SendChatMessage(14, 0, "Laughs> How very... naïve...") -- Need to add emote
	end
end

RegisterUnitEvent(28859, 3, "Malygos_OnPlayerDeath")

-----------------------------------------
--------------Malygos Spells-------------
-----------------------------------------

----------------------------
-----------Vortex-----------
----------------------------

function Malygos_Vortex(unit, event)
unit:CastSpellOnTarget(56105, unit:GetRandomPlayer(0))
end

----------------------------
--------Arcane Pulse--------
----------------------------

function Malygos_ArcanePulse(unit, event)
unit:SendChatMessage(14, 0, "Watch helplessly as your hopes are swept away...")
unit:CastSpellOnTarget(57432, unit:GetRandomPlayer(0))
end

----------------------------
-------Arcane Breath--------
----------------------------

function Malygos_ArcaneBreath(unit, event)
unit:SendChatMessage(42, 0, "Malygos takes a deep breath...")
unit:SendChatMessage(14, 0, "YOU WILL NOT SUCCEED WHILE I DRAW BREATH!")
unit:CastSpellOnTarget(56272, unit:GetRandomPlayer(0))
end

----------------------------
--------Arcane Storm--------
----------------------------

function Malygos_ArcaneStorm(unit, event)
unit:CastSpellOnTarget(61693, unit:GetMainTank())
end

----------------------------
--------Static Field--------
----------------------------

function Malygos_StaticField(unit, event)
unit:CastSpellOnTarget(57430, unit:GetRandomPlayer(0))
end

----------------------------
-------Surge of Power-------
----------------------------

function Malygos_SurgeOfPower(unit, event)
unit:SendChatMessage(14, 0, "The powers at work here exceed anything you could possibly imagine!")
unit:CastSpellOnTarget(56505, unit:GetRandomPlayer(0))
end

----------------------------
---------Power Spark--------
----------------------------

function Malygos_PowerSpark(unit, event)
x = unit:GetX()
y = unit:GetY()
z = unit:GetZ()
o = unit:GetO()
unit:SpawnCreature(30084, x, y, z, o, 2, 60000)
unit:SpawnCreature(30084, x, y, z, o, 2, 60000)
end

----------------------------
---------Nexus Lord---------
----------------------------

function Malygos_NexusLord(unit, event)
x = unit:GetX()
y = unit:GetY()
z = unit:GetZ()
o = unit:GetO()
unit:SpawnCreature(30245, x, y, z, o, 2, 60000)
unit:SpawnCreature(30245, x, y, z, o, 2, 60000)
end

-----------------------------------------
--------------Malygos Phases-------------
-----------------------------------------

----------------------------
-----------Phase 1----------
----------------------------

function Malygos_Phase1(unit, event)
if unit:GetHealtPct() <= 98 then
unit:SendChatMessage(14, 0, "My patience has reached its limit, I will be rid of you!")
unit:RegisterEvent("Malygos_ArcaneBreath", 5000, 0)
unit:RegisterEvent("Malygos_PowerSpark", 60000, 0)
unit:RegisterEvent("Malygos_Vortex", 50000, 1)
unit:RegisterEvent("I had hoped to end your lives quickly, but you have proven more...resilient then I had anticipated. Nonetheless, your efforts are in vain, it is you reckless, careless mortals who are to blame for this war! I do what I must...And if it means your...extinction...THEN SO BE IT!")
unit:RegisterEvent("Malygos_Phase2", 1000, 0)
end
end

----------------------------
-----------Phase 2----------
----------------------------

function Malygos_Phase2(unit, event)
if unit:GetHealthPct() <= 50 then
unit:SendChatMessage(14, 0, "Few have experienced the pain I will now inflict upon you!")
unit:RegisterEvent("Malygos_ArcanePulse", 10000, 0)
unit:RegisterEvent("Malygos_NexusLord", 60000, 2)
unit:RegisterEvent("Malygos_ArcaneStorm", 25000, 0)
unit:RegisterEvent("ENOUGH! If you intend to reclaim Azeroth's magic, then you shall have it...")
unit:RegisterEvent("Malygos_Phase3", 1000, 0)
end
end

----------------------------
-----------Phase 3----------
----------------------------

function Malygos_Phase3(unit, event)
if unit:GetHealthPct() <= 10 then
unit:SendChatMessage(14, 0, "Now your benefactors make their appearance...But they are too late. The powers contained here are sufficient to destroy the world ten times over! What do you think they will do to you?")
unit:SendChatMessage(14, 0, "SUBMIT!")
unit:RegisterEvent("Malygos_ArcanePulse", 10000, 0)
unit:RegisterEvent("Malygos_StaticField", 10000, 0)
unit:RegisterEvent("Malygos_SurgeOfPower", 10000, 0)
end
end