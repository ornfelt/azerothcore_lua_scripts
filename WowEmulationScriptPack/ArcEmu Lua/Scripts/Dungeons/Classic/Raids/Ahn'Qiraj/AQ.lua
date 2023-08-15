--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   AQ.lua
   Original Code by DARKI
   Version 1
========================================]]--

--Anubisath Defender by Project eXa
function Defender_ExplodeTwo(pUnit, event) --Fix for broken spell.
	pUnit:CastSpell(25699)
end

function Defender_Explode(pUnit, Event)
	if (pUnit:GetHealthPct() < 10) then
		pUnit:RemoveEvents()
		pUnit:FullCastSpell(25698)
		pUnit:StopMovement(7100)
		pUnit:RegisterEvent("Defender_ExplodeTwo", 7000, 1)
	end
end

function Defender_Enrage(pUnit, Event)
	if (pUnit:GetHealthPct() < 10) then
		pUnit:CastSpell(44779)
		pUnit:RemoveEvents()
	end
end

function Defender_Thunderclap(pUnit, Event)
	pUnit:CastSpell(2834)
	local TcTimer = math.random(45000, 65000)
	pUnit:RegisterEvent("Defender_Thunderclap2", TcTimer, 1)
end

function Defender_Thunderclap2(pUnit, Event)
	pUnit:CastSpell(2834)
	local TcTimer = math.random(45000, 65000)
	pUnit:RegisterEvent("Defender_Thunderclap", TcTimer, 1)
end

function Defender_ShadowStorm(pUnit, Event)
	pUnit:CastSpell(2148)
	local SsTimer = math.random(45000, 65000)
	pUnit:RegisterEvent("Defender_ShadowStorm2", SsTimer, 1)
end

function Defender_ShadowStorm2(pUnit, Event)
	pUnit:CastSpell(2148)
	local SsTimer = math.random(45000, 65000)
	pUnit:RegisterEvent("Defender_ShadowStorm", SsTimer, 1)
end

function Defender_Plague(pUnit, Event) --No extreme issues here so I won't comment it out. It is supposed to affect players within 5yards of the affected player, this can be fixed. Please do so by checking the distance from the affected players to nearby players, if it's less than 5yards have the boss cast the spell on them.
	pUnit:CastSpellOnTarget(22997, pUnit:GetRandomPlayer(0))
	local PTimer = math.random(45000, 65000)
	pUnit:RegisterEvent("Defender_Plague2", PTimer, 1)
end

function Defender_Plague2(pUnit, Event) --No extreme issues here so I won't comment it out. It is supposed to affect players within 5yards of the affected player, this can be fixed. Please do so by checking the distance from the affected players to nearby players, if it's less than 5yards have the boss cast the spell on them.
	pUnit:CastSpellOnTarget(22997, pUnit:GetRandomPlayer(0))
	local PTimer = math.random(45000, 65000)
	pUnit:RegisterEvent("Defender_Plague", PTimer, 1)
end

function Defender_OnCombat(pUnit, Event)
	GeneralTimer = math.random(45000, 65000)
	Flip1 = math.random(1, 2)
	Flip2 = math.random(1, 2)
	Flip3 = math.random(1, 2)
	Flip4 = math.random(1, 2)
	if (Flip1 == 1) then
		pUnit:RegisterEvent("Defender_Plague", GeneralTimer, 1)
	end
	if (Flip2 == 1) then
		pUnit:RegisterEvent("Defender_ShadowStorm", GeneralTimer, 1)
	else
		pUnit:RegisterEvent("Defender_Thunderclap", GeneralTimer, 1)
	end
	if (Flip3 == 1) then
		pUnit:RegisterEvent("Defender_Enrage", 1000, 0)
	else
		pUnit:RegisterEvent("Defender_Explode", 1000, 0)
	end
	if (Flip4 == 1) then
		pUnit:CastSpell(13022)
	else
		pUnit:CastSpell(19595)
	end
end

function Defender_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

function Defender_OnDied(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(15277, 1, "Defender_OnCombat")
RegisterUnitEvent(15277, 2, "Defender_OnLeaveCombat")
RegisterUnitEvent(15277, 4, "Defender_OnDied")


--Anubisath Sentinel by Project eXa

function Sentinel_OnCombat(Unit, event)
local CoinFlip = math.random(1, 9)
	if (CoinFlip == 1) then
		Unit:CastSpell(28747)
		Mending = 1
	elseif (CoinFlip == 2) then
		Unit:CastSpell(21737)
		KnockAway = 1
	elseif (CoinFlip == 3) then
		Unit:CastSpell(25777)
		Thorns = 1
	elseif (CoinFlip == 4) then
		Unit:CastSpell(2834)
		ThunderClap = 1
	elseif (CoinFlip == 5) then
		Unit:CastSpell(13022)
		ReflectArcFire = 1
	elseif (CoinFlip == 6) then
		Unit:CastSpell(19595)
		ReflectShadFrost = 1
	elseif (CoinFlip == 7) then
		Unit:CastSpell(2148)
		ShadowStorm = 1
	elseif (CoinFlip == 8) then
		Unit:CastSpell(812)
		ManaBurn = 1
	elseif (CoinFlip == 9 )then
		Unit:CastSpell(9347)
		MortalStrike = 1
	end
	Unit:RegisterEvent("DeathCheck",1000,0)
end

function DeathCheck(Unit, event)
	if (Mending == 2) then
		Unit:CastSpell(28747)
		Mending = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (KnockAway == 2) then
		Unit:CastSpell(21737)
		KnockAway = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (Thorns == 2) then
		Unit:CastSpel(25777)
		Thorns = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (ThunderClap == 2) then
		Unit:CastSpell(2834)
		ThunderClap = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (ReflectArcFire == 2) then
		Unit:CastSpell(13022)
		ReflectArcFire = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (ReflectShadFrost == 2) then
		Unit:CastSpell(19595)
		ReflectShadFrost = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (ShadowStorm == 2) then
		Unit:CastSpell(2148)
		ShadowStorm = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (ManaBurn == 2) then
		Unit:CastSpell(812)
		ManaBurn = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	elseif (MortalStrike == 2) then
		Unit:CastSpell(9347)
		MortalStrike = 1
		MaxHp = Unit:GetMaxHealth()
		SetHp = Unit:GetHealth() + (MaxHp / 2)
		Unit:SetHealth(SetHp)
	end
end

function Sentinel_OnDeath(Unit, event)
	if(Mending == 1) then
		Mending = 2
	elseif (KnockAway == 1) then
		KnockAway = 2
	elseif (Thorns == 1) then
		Thorns = 2
	elseif (ThunderClap == 1) then
		ThunderClap = 2
	elseif (ReflectArcFire == 1) then
		ReflectArcFire = 2
	elseif (ReflectShadFrost == 1) then
		ReflectShadFrost = 2
	elseif (ShadowStorm == 1) then
		ShadowStorm = 2
	elseif (ManaBurn == 1) then
		ManaBurn = 2
	elseif (MortalStrike == 1) then
		MortalStrike = 2
	end
	Unit:RemoveEvents()
end

function Sentinel_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(15264, 1, "Sentinel_OnCombat")
RegisterUnitEvent(15264, 2, "Sentinel_OnLeaveCombat")
RegisterUnitEvent(15264, 4, "Sentinel_OnDeath")

--Anubisath Warder by Project eXa
function Warder_Root(Unit, event)
local RootTimer = math.random(15000, 30000)
	Unit:CastSpell(20699)
	Unit:RegisterEvent("Warder_Root2", RootTimer, 1)
end

function Warder_Root2(Unit, event)
local RootTimer = math.random(15000, 30000)
	Unit:CastSpell(20699)
	Unit:RegisterEvent("Warder_Root", RootTimer, 1)
end

function Warder_Fear(Unit, event)
local FearTimer = math.random(15000, 30000)
	Unit:CastSpell(30584)
	Unit:RegisterEvent("Warder_Fear2", FearTimer, 1)
end

function Warder_Fear2(Unit, event)
local FearTimer = math.random(15000, 30000)
	Unit:CastSpell(30584)
	Unit:RegisterEvent("Warder_Fear", FearTimer, 1)
end

function Warder_Cloud(Unit, event)
local CloudTimer = math.random(12000, 25000)
	Unit:FullCastSpell(26072)
	Unit:RegisterEvent("Warder_Cloud2", CloudTimer, 1)
end

function Warder_Cloud2(Unit, event)
local CloudTimer = math.random(12000, 25000)
	Unit:FullCastSpell(26072)
	Unit:RegisterEvent("Warder_Cloud", CloudTimer, 1)
end

function Warder_Silence(Unit, event)
local SilenceTimer = math.random(12000, 25000)
	Unit:FullCastSpell(12528)
	Unit:RegisterEvent("Warder_Silence2", SilenceTimer, 1)
end

function Warder_Silence2(Unit, event)
local SilenceTimer = math.random(12000, 25000)
	Unit:FullCastSpell(12528)
	Unit:RegisterEvent("Warder_Silence", SilenceTimer, 1)
end

function Warder_Nova(Unit, event)
local NovaTimer = math.random(25000, 45000)
	Unit:CastSpell(18432)
	Unit:RegisterEvent("Warder_Nova2", NovaTimer, 1)
end

function Warder_Nova2(Unit, event)
local NovaTimer = math.random(25000, 45000)
	Unit:CastSpell(18432)
	Unit:RegisterEvent("Warder_Nova", NovaTimer, 1)
end

function Warder_OnCombat(Unit, event)
local RootOrFear = math.random(1, 2)
local DustOrSilence = math.random(1, 2)
	if (RootOrFear == 1) then
		Unit:CastSpell(20699)
		local RootTimer = math.random(15000, 30000)
		Unit:RegisterEvent("Warder_Root", RootTimer, 1)
	else
		Unit:CastSpell(30584)
		local FearTimer = math.random(15000, 30000)
		Unit:RegisterEvent("Warder_Fear", FearTimer, 1)
	end
	if (DustOrSilence == 1) then
		Unit:FullCastSpell(26072)
		local CloudTimer = math.random(12000, 25000)
		Unit:RegisterEvent("Warder_Cloud", CloudTimer, 1)
	else
		Unit:FullCastSpell(12528)
		local SilenceTimer = math.random(12000, 25000)
		Unit:RegisterEvent("Warder_Silence", SilenceTimer, 1)
	end
	local NovaTimer = math.random(25000, 45000)
	Unit:RegisterEvent("Warder_Nova", NovaTimer, 1)
end

function Warder_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Warder_OnDied(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(15311,1,"Warder_OnCombat")
RegisterUnitEvent(15311,2,"Warder_OnLeaveCombat")
RegisterUnitEvent(15311,4,"Warder_OnDied")

--Obsidian Nullifier by Project eXa
function Nullifier_ShockBlast(pUnit, event)
	if (pUnit:GetManaPct() > 99) then
		pUnit:CastSpell(26458)
		pUnit:SetMana(0)
	end
end

function Nullifier_Siphon(pUnit, event) --Not blizzlike but it will work until I can get a better idea.
local b = pUnit:GetMaxHealth() /(10);
	if (pUnit:GetManaPct() > 89) then
		pUnit:FullCastSpell(27287)
		pUnit:SetMana(pUnit:GetMana() + pUnit:GetMana()) --I know it will go over 100% mana, but it's okay cause it get's reset to 0. Plus this prevents glitches.
	else
		pUnit:FullCastSpell(27287)
		pUnit:SetMana(pUnit:GetMana() + b)
	end
end

function Nullifier_OnCombat(Unit, event) --There isnt a :SetManaPct() function.
	Unit:SetMana(0)
	Unit:SetMaxMana(50000)
	Unit:RegisterEvent("Nullifier_Siphon",2000,0)
	Unit:RegisterEvent("Nullifier_ShockBlast",1000,0)
end

function Nullifier_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Nullifier_OnDied(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(15312,1,"Nullifier_OnCombat")
RegisterUnitEvent(15312,2,"Nullifier_OnLeaveCombat")
RegisterUnitEvent(15312,4,"Nullifier_OnDied")

--Obsidian Eradicator by Project eXa 
function Eradicator_Siphon(pUnit, event) --Not blizzlike but it will work until I can get a better idea.
local a = pUnit:GetMaxHealth() /(10);
	if pUnit:GetManaPct() > 89 then
		pUnit:FullCastSpell(27287)
		pUnit:SetMana(pUnit:GetMana() + pUnit:GetMana())  --I know it will go over 100% mana, but it's okay cause it get's reset to 0. Plus this prevents glitches.
	else
		pUnit:FullCastSpell(27287)
		pUnit:SetMana(pUnit:GetMana() + a)
	end
end

function Eradicator_ShockBlast(pUnit, event)
	if (pUnit:GetManaPct() > 99) then
		pUnit:CastSpell(26458)
		pUnit:SetMana(0)
	end
end

function Eradicator_OnCombat(Unit, event) --There isnt a :SetManaPct() function.
	Unit:SetMana(0)
	Unit:SetMaxMana(24000)
	Unit:RegisterEvent("Eradicator_Siphon",2000,0)
	Unit:RegisterEvent("Eradicator_ShockBlast",1000,0)
end

function Eradicator_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Eradicator_OnDied(Unit)
local ex = Unit:GetX()
local ey = Unit:GetY()
local ez = Unit:GetZ()
local eo = Unit:GetO()
	Unit:SpawnGameObject(181068, ex, ey, ez, eo, 300000)
end

RegisterUnitEvent(15262,1,"Eradicator_OnCombat")
RegisterUnitEvent(15262,2,"Eradicator_OnLeaveCombat")
RegisterUnitEvent(15262,4,"Eradicator_OnDied")

--Qiraji Champion by Ikillonyxia. Couldnt find correct hp% for enrage so didnt include that, along with the nature dot which no info is available for.
function Champion_Cleave(pUnit, event)
    pUnit:FullCastSpellOnTarget(31043, pUnit:GetMainTank())
end

function Champion_Fear(pUnit, event)
    pUnit:FullCastSpell(19134)
end

function Champion_OnEnterCombat(pUnit, event)
    pUnit:RegisterEvent("Champion_Cleave", 15000, 0)
    pUnit:RegisterEvent("Champion_Fear", 27000, 0)
end

function Champion_OnWipe(pUnit, event)
    pUnit:RemoveEvents()
end

function Champion_OnDie(pUnit, event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(15252, 4, "Champion_OnDie")
RegisterUnitEvent(15252, 2, "Champion_OnWipe")
RegisterUnitEvent(15252, 1, "Champion_OnEnterCombat")

--Qiraji Brainwasher by Ikillonyxia. Only spell that I can guess on is the Mind Flay, the rest of his spells are to technical to be making guesses on.

function Brainwasher_MindFlay(pUnit, event) --No info on who it targets, so going to do random target(seems logical).
    pUnit:FullCastSpellOnTarget(26044, pUnit:GetRandomPlayer(0))
end

function Brainwasher_OnEnterCombat(pUnit, event)
    pUnit:RegisterEvent("Brainwasher_MindFlay", 32000, 0)
end

function Brainwasher_OnWipe(pUnit, event)
    pUnit:RemoveEvents()
end

function Brainwasher_OnDie(pUnit, event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(15247, 4, "Brainwasher_OnDie")
RegisterUnitEvent(15247, 2, "Brainwasher_OnWipe")
RegisterUnitEvent(15247, 1, "Brainwasher_OnEnterCombat")


--Qiraji Mindslayer by Ikillonyxia.
function Mindslayer_CleaveRepeat(pUnit, event)
    pUnit:FullCastSpellOnTarget(31043, pUnit:GetMainTank())
    pUnit:RegisterEvent("Mindslayer_Cleave", math.random(15000, 18000), 1)
end

function Mindslayer_Cleave(pUnit, event)
    pUnit:FullCastSpellOnTarget(31043, pUnit:GetMainTank())
    pUnit:RegisterEvent("Mindslayer_CleaveRepeat", math.random(15000, 18000), 1)
end

function Mindslayer_MindFlay(pUnit, event)
    pUnit:FullCastSpellOnTarget(26044, pUnit:GetRandomPlayer(0))
end

function Mindslayer_OnEnterCombat(pUnit, event)
    pUnit:RegisterEvent("Mindslayer_Cleave", math.random(15000, 18000), 1)
    pUnit:RegisterEvent("Mindslayer_MindFlay", 32000, 0)
end

function Mindslayer_OnWipe(pUnit, event)
    pUnit:RemoveEvents()
end

function Mindslayer_OnDie(pUnit, event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(15246, 4, "Mindslayer_OnDie")
RegisterUnitEvent(15246, 2, "Mindslayer_OnWipe")
RegisterUnitEvent(15246, 1, "Mindslayer_OnEnterCombat")


--::BOSSESS:--


--Twin Emperors by Project eXa

--::Emperor Vek'nilash: Swings a big sword, immune to all magical damage (except holy)::--
--Uppercut(18072) - Knocks back a single random target in melee range. 
--Unbalancing Strike(26613) - Inflicts 350% weapon damage and leaves the target unbalanced, reducing their defense skill by 100 for 6 sec. 
--Mutate Bug - Mutates a bug every 10-15 sec or so making it grow to a gigantic size and attack the raid. 

--::Emperor Vek'lor: Caster, immune to all physical damage, has a mana bar.::--
--Shadow Bolt - Spams on his aggro target, hits for 3000-4000. Partially resistible. 
--Blizzard - Slows and damages everyone within its area of effect. 1500 damage/tick. 
--Arcane Burst - 4000-4950 arcane damage AoE counterattack whenever a player is within melee range.
--Explode Bug - Every 7-10 secs Emperor Vek'lor forces a nearby bug to explode, blowing it up

--::Both Emperors::-- 
--Heal Brother - Whenever the twins get within 60 yards of one another, they will spam heal each other.
--Twin Teleport - the two twins will switch places. The twins will be rooted for 2 seconds. There is a complete aggro wipe.
--Berserk(45078) - After 15 minutes, the Emperors will go berserk dramatically increasing damage and wiping the raid.
--Combined Health - The Emperors share health. Damage to one emperor hurts the other emperor as well.

--===SPELLS===--
--[[Emperor Vek'nilash yells: Oh so much pain...
Emperor Vek'nilash yells: The feast of souls begins now...
Emperor Vek'nilash yells: Vek'lor, I feel your pain!
Emperor Vek'nilash yells: Where are your manners, brother. Let us properly welcome our guests.
Emperor Vek'nilash yells: Your fate is sealed!

Emperor Vek'lor yells: Come, little ones.
Emperor Vek'lor yells: My brother, no!
Emperor Vek'lor yells: Only flesh and bone. Mortals are such easy prey...
Emperor Vek'lor yells: There will be pain...
Emperor Vek'lor yells: You will not escape death!]]--

function Brothers_Berserk(Unit)
	Unit:CastSpell(45078)
end

function Veknilash_Uppercut(pUnit, event)
	pUnit:CastSpellOnTarget(18072, pUnit:GetRandomPlayer(1))
end

function Veknilash_Unbalancing(pUnit, event)
	pUnit:CastSpellOnTarget(26613, pUnit:GetMainTank())
end


function Veknilash_OnCombat(Unit, event)
local Veknilash = Unit
	--Define Boss as a Unit, set max health to 2 mil and set first NewHp for shared hp calculations
	Unit:SetMaxHealth(2000000)
	NNewHp=2000000
	--Start the registers
	Veknilash:RegisterEvent("SharedHealth",1500,0)
	Veknilash:RegisterEvent("Brothers_Berserk",900000,0)
end

function Veklor_OnCombat(Unit, event)
local Veklor = Unit
	--Define Boss as a Unit, set max health to 2 mil and set first NewHp for shared hp calculations
	Unit:SetMaxHealth(20000000)
	LNewHp=2000000
	--Start the registers
	Veklor:RegisterEvent("SharedHealth",1000,0)
	Veklor:RegisterEvent("Brothers_Berserk",900000,0)
end

function SharedHealth(Unit, event)
	--Get each of their health
	NilashHealth = Veknilash:GetHealth()
	LorHealth = Veklor:GetHealth()
	Veklor:SendChatMessage(11,0,LorHealth)
	--Figure out how much Dmg was taken since last check.
	NDmgTaken = NNewHp - NilashHealth
	LDmgTaken = LNewHp - LorHealth
	Veklor:SendChatMessage(11,0,NDmgTaken)
	--Share the Dmg between the brothers
	NNewHp = NilashHealth - LDmgTaken
	LNewHp = LorHealth - NDmgTaken
	Veklinash:SendChatMessage(11,0,NNewHp)
	--Set the health
	Veknilash:SetHealth(NNewHp)
	Veklor:SetHealth(LNewHp)
end

RegisterUnitEvent(15275,1,"Veknilash_OnCombat")
RegisterUnitEvent(15276,1,"Veklor_OnCombat")