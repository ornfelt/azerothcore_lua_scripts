function Steelbreaker_OnEnterCombat(unit, event)
	Unit:PlaySoundToSet(15674)
	Unit:SendChatMessage(14, 0, "You will not defeat the Assembly of Iron so easily, invaders!")
	Unit:RegisterEvent("Steelbreaker_Highvoltage", 30000, 4)
	Unit:RegisterEvent("Steelbreaker_Fusion", 30000, 2)
	Unit:RegisterEvent("Steelbreaker_Meltdown", 25000, 4)
	Unit:RegisterEvent("Steelbreaker_Phase1", 60000, 0)
	Unit:RegisterEvent("Steelbreaker_Phase2", 1000, 1)
	Unit:RegisterEvent("Steelbreaker_Phase3", 1000, 1)
end
 
function Steelbreaker_Highvoltage(unit, event)
	Unit:PlaySoundToSet(15675)
	Unit:SendChatMessage("So fragile and weak!")
	Unit:CastSpell(61890)
end
 
function Steelbreaker_Fusion(unit,event)
	Unit:PlaySoundToSet(15677)
	Unit:SendChatMessage(14, 0, "You seek the secrets of Ulduar? Then take them!")
	Unit:CastSpellOnTarger(61902, Unit:GetMainTank())
end
 
--choice=math.random(1, 4)
function Steelbreaker_Phase1(unit, event)
	if unit:GetHealthPct() <= 95 then
	if choice==1 then
		Unit:CastSpellOnTarget(61903)
		end
	end
end

function Steelbreaker_Meltdown(unit, event)
	if choice==2 then
		Unit:CastSpell(61889)
	end
end
 
function Steelbreaker_Phase2(unit, event)
	if unit:GetHealthPct() <= 40 then
		Unit:CastSpellOnTarget(63494, Unit:GetRandomPlayer(2))
	end
end
 
function Steelbreaker_Phase3(unit, event)
	if unit:GetHealthPct() <= 35 then
		Unit:CastSpellOnTarget(61889, unit:GetRandomPlayer(0))
	end
end
 
function Steelbreaker_OnKilledTarget(unit, event)
	Unit:PlaySoundToSet(15676)
	Unit:SendChatMessage(14, 0, "Flesh, HAH! Such a hindrence!")
end
 
function Steelbreaker_OnLeaveCombat(unit, event)
	Unit:PlaySoundToSet(15680)
	Unit:SendChatMessage(14, 0, "This meeting of the Assembly of Iron is adjourned!")
	Unit:RemoveEvents()
end
 
function Steelbreaker_OnDeath(unit, event)
	Unit:PlaySoundToSet(15678)
	Unit:SendChatMessage(14, 0, "My death only serves to hasten your demise.")
	Unit:CastSpell(61920)
end
 
RegisterUnitEvent(32867, 1, "Steelbreaker_OnEnterCombat")
RegisterUnitEvent(32867, 2, "Steelbreaker_OnLeaveCombat")
RegisterUnitEvent(32867, 3, "Steelbreaker_OnKilledTarget")
RegisterUnitEvent(32867, 4, "Steelbreaker_OnDeath")
 
---------STORMCALLER BRUNDIR------------
 
function StormcallerBrundir_OnEnterCombat(unit, event)
    Unit:PlaySoundToSet(15684)
    Unit:SendChatMessage(14, 0, "Whether the world's greatest gnats or the world's greatest heroes, you're still only mortal!")
    Unit:RegisterEvent("StormcallerBrundir_ChainLightning", 30000, 0)
    Unit:RegisterEvent("StormcallerBrundir_LightningWhirl", 25000, 0)
    Unit:RegisterEvent("StormcallerBrundir_LightningTendrils", 15000, 0)
    Unit:RegisterEvent("StormcallerBrundir", 60000, 0)
    Unit:RegisterEvent("StormcallerBrundir", 60000, 0)
end
 
function StormcallerBrundir_ChainLightning(unit, event)
    Unit:PlaySoundToSet(15685)
    Unit:SendChatMessage(14, 0, "A merciful kill!")
    Unit:CastSpellOnTarget(63479, Unit:GetRandomPlayer(0))
end
 
 
--Choice=math.random(1, 2)
function StormcallerBrundir_Phase1(unit, event)
     if Unit:GetHealthPct() <= 90 then
     if choice==1 then
		Unit:CastSpell(63481)
		end
	end
end

function StormcallerBrundir_LightningWhirl(unit, event)
		Unit:PlaySoundToSet(15686)
		Unit:SendChatMessage(14, 0, "HAH")
    if choice==2 then
		Unit:CastSpellOnTarget(63483, Unit:GetRandomPlayer(0))
	end
end
 
Choice=math.random(1, 2)
function StormcallerBrundir_Phase2(unit, event)
    if Unit:GetHealthPct() <= 50 then
		Unit:PlaySoundToSet(15687)
		Unit:SendChatMessage(14, 0, "Stand still and stare into the light!")
		Unit:CastSpell(64187)
	end
end
 
function StormcallerBrundir_LightningTendrils(unit, event)
    if choice==2 then
		Unit:CastSpellOnTarget(63485, Unit:GetRandomPlayer(4))
		Unit:PlaySoundToSet(15688)
		Unit:SendChatMessage(14, 0, "Let the storm clouds rise and rain down death from above!")
	end
end
 
function StormcallerBrundir_OnLeaveCombat(unit, event)
	Unit:PlaySoundToSet(15689)
	Unit:SendChatMessage(14, 0, "The power of the storm lives on...")
	Unit:RemoveEvents()
end
 
function StormcallerBrundir_Death(unit, event) 
	Unit:PlaySoundToSet(15690)
	Unit:SendChatMessage(14, 0, "You rush headlong into the maw of madness!")
	Unit:RemoveEvents()
end

function StormcallerBrundir_OnKilledTarget(unit, event)
end
 
RegisterUnitEvent(32857, 1, "StormcallerBrundir_OnEnterCombat")
RegisterUnitEvent(32857, 2, "StormcallerBrundir_OnLeaveCombat")
RegisterUnitEvent(32857, 3, "StormcallerBrundir_OnKilledTarget")
RegisterUnitEvent(32857, 4, "StormcallerBrundir_Death")
 
------------RUNEMASTER MOLGEIN-------------
 
function RunemasterMolgein_OnEnterCombat(unit, event)
	Unit:PlaySoundToSet(15657)
	Unit:SendChatMessage(12, 0, "Nothing short of total decimation will suffice")
	Unit:RegisterEvent("RunemasterMolgein_Shieldofrunes", 1000, 1)
	Unit:RegisterEvent("RunemasterMolgein_Elemental", 10, 20000)
	Unit:RegisterEvent("RunemasterMolgein_LightningBlast", 1000, 1)
end
 
function RunemasterMolgein_Shieldofrunes(unit, event)
	Unit:CastSpell(63489)
end

--choice=math.random(1, 4)
function RunemasterMolgein_Phase1(unit, event)
	if unit:GetHealthPct() <= 90 then
		if choice==1 then
		Unit:CastSpell(61974)
		Unit:PlaySoundToSet(15658)
		Unit:SendChatMessage(14, 0, "The world suffers yet another insignificant loss.")
		end
	end
end

function RunemasterMolgein_Runeofdeath(unit, event)
	if choice==2 then
		Unit:CastSpell(63490)
		Unit:PlaySoundToSet(15660)
		Unit:SendChatMessage(14, 0, "Decipher this!")
	end
end

function RunemasterMolgein_Elemental(unit, event)
	if unit:GetHealthPct() <= 70 then
		Unit:SpawnCreature(34147, x, y, z, o, 10, 20000)
		Unit:PlaySoundToSet(15661)
		Unit:SendChatMessage(14, 0, "Face the lightning surge!")
	end
end
 
function RunemasterMolgein_LightningBlast(unit, event)
	if unit:GetHealthPct() <= 10 then
		Unit:CastSpell(63491)
		Unit:PlaySoundToSet(15664)
		Unit:SendChatMessage(14, 0, "This meeting of the Assembly of Iron is adjourned!")
	end
end
 
function RunemasterMolgein_OnLeaveCombat(unit, event)
	Unit:PlaySoundToSet(15662)
	Unit:SendChatMessage(14, 0, "The legacy of storms shall not be undone.")
	Unit:Despawn(1000, 0)
	Unit:RemoveEvents()
end
 
function RunemasterMolgein_Death(unit, event)
	Unit:PlaySoundToSet(15663)
	Unit:SendChatMessage(14, 0, "What have you gained from my defeat? You are no less doomed, mortals!")
	Unit:Despawn(1000, 0)
	Unit:RemoveEvents()
end

function RunemasterMolgein_OnKilledTarget(pUnit, Event)
end
 
RegisterUnitEvent(32927, 1, "RunemasterMolgein_OnEnterCombat")
RegisterUnitEvent(32927, 2, "RunemasterMolgein_OnLeaveCombat")
RegisterUnitEvent(32927, 3, "RunemasterMolgein_OnKilledTarget")
RegisterUnitEvent(32927, 4, "RunemasterMolgein_Death")