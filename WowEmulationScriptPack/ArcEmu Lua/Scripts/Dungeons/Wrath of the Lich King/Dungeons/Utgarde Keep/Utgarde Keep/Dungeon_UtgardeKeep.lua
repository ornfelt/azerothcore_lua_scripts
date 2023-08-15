--//////////////////////////////////
--//// © Holystone Productions  ////
--////  Blizzlike Repack v 2.5  ////
--////  	Instance Scripts    ////
--///	   - Utgarde Keep -	    ////
--//////////////////////////////////

-- Frost Tomb
function FrostTomb_OnSpawn (Unit, Event)
		Unit:DisableMelee(true)
end

function FrostTomb_OnCombat (Unit, Event)
end

function FrostTomb_OnLeaveCombat (Unit, Event)
		Unit:Despawn(1500, 0)
		Unit:RemoveEvents()
end

function FrostTomb_OnDeath (Unit, Event, plr)
	if plr:HasNegativeAura(48400) == true then
		plr:RemoveAura(48400)
		Unit:Despawn(1500, 0)
		plr:Unroot()
end
end

function FrostTomb_OnKillPlr (Unit, Event)
		Unit:Despawn(1500, 0)
end

RegisterUnitEvent(23965, 18, "FrostTomb_OnSpawn")
RegisterUnitEvent(23965, 1, "FrostTomb_OnCombat")
RegisterUnitEvent(23965, 2, "FrostTomb_OnLeaveCombat")
RegisterUnitEvent(23965, 3, "FrostTomb_OnKillPlr")
RegisterUnitEvent(23965, 4, "FrostTomb_OnDeath")

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////     Prince Keleseth		////
--////  					    ////
--///	       					////
--//////////////////////////////////
-- Issues: Frost Tomb is bugged(Major), Summon Skeletons is suppose to be revived not despawn/respawn(Minor)

function PrinceKeleseth_OnCombat (Unit, Event)
		Unit:SendChatMessage(14, 0, "Your blood is mine!")
		Unit:PlaySoundToSet(13221)
		Unit:RegisterEvent("PrinceKeleseth_ShadowBolt", 4300, 0)
		Unit:RegisterEvent("PrinceKeleseth_Skeletons", 20000, 0)
		Unit:RegisterEvent("PrinceKeleseth_FrostTomb", 23000, 0)
end

function PrinceKeleseth_ShadowBolt (Unit, Event)
	local player = Unit:GetMainTank()
		Unit:FullCastSpellOnTarget(43667, player)
end

function PrinceKeleseth_Skeletons (Unit, Event)
-- Here Keleseth will spawn 5 undead skeletons
		Unit:SendChatMessage(14, 0, "Aranal, ledel! Their fate shall be yours!")
		Unit:PlaySoundToSet(13224)
		local X = Unit:GetX()
		local Y = Unit:GetY()
		local Z = Unit:GetZ()
		local O = Unit:GetO()
		Unit:SpawnCreature(23970, X+2, Y, Z, O, 14, 19000)
		Unit:SpawnCreature(23970, X, Y+2, Z, O, 14, 19000)
		Unit:SpawnCreature(23970, X, Y, Z+2, O, 14, 19000)
		Unit:SpawnCreature(23970, X+3, Y, Z, O, 14, 19000)
		Unit:SpawnCreature(23970, X, Y, Z+3, O, 14, 19000)
end

function PrinceKeleseth_FrostTomb (Unit, Event)
		Unit:SendChatMessage(14, 0, "Not so fast!")
		Unit:PlaySoundToSet(13222)
		local randomplayer = Unit:GetRandomPlayer(0)
		Unit:CastSpellOnTarget(48400, randomplayer)
		local X = plr:GetX()
		local Y = plr:GetY()
		local Z = plr:GetZ()
		local O = plr:GetO()
		Unit:SpawnCreature(23965, X, Y, Z, O, 14, 20000)
end

function PrinceKeleseth_OnLeaveCombat (Unit, Event)
		Unit:Despawn(1100, 10000)
		Unit:RemoveEvents()
end

function PrinceKeleseth_OnDeath (Unit, Event)
		Unit:SendChatMessage(14, 0, "I join... the night.")
		Unit:PlaySoundToSet(13225)
		Unit:RemoveEvents()
end

function PrinceKeleseth_OnKillPlr (Unit, Event)
end

RegisterUnitEvent(23953, 1, "PrinceKeleseth_OnCombat")
RegisterUnitEvent(23953, 2, "PrinceKeleseth_OnLeaveCombat")
RegisterUnitEvent(23953, 3, "PrinceKeleseth_OnKillPlr")
RegisterUnitEvent(23953, 4, "PrinceKeleseth_OnDeath")

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////     Skarvald & Dalronn	////
--////  					    ////
--///	       					////
--//////////////////////////////////
-- Issues: Skarvald's Charge is bugged and will crash the server.

local Skarvald = 24200

function Skarvald_OnCombat (Unit, Event)
	Skarvald = Unit
		Skarvald:SendChatMessage(14, 0, "Dalronn! See if you can muster the nerve to join my attack!")
		Skarvald:PlaySoundToSet(13229)
		Skarvald:RegisterEvent("Skarvald_StoneStrike", 7000, 0)
end

function Skarvald_StoneStrike (Unit, Event)
	local player = Unit:GetMainTank()
	Skarvald:FullCastSpellOnTarget(48583, player)
end

function Skarvald_OnLeaveCombat (Unit, Event)
	Skarvald:Despawn(1100, 10000)
	Skarvald:RemoveEvents()
end

function Skarvald_OnDeath (Unit, Event)
	Skarvald:SendChatMessage(14, 0, "A warrior's death.")
	Skarvald:PlaySoundToSet(13231)
	Skarvald:RemoveEvents()
end

function Skarvald_OnKillPlr (Unit, Event)
end

RegisterUnitEvent(24200, 1, "Skarvald_OnCombat")
RegisterUnitEvent(24200, 2, "Skarvald_OnLeaveCombat")
RegisterUnitEvent(24200, 3, "Skarvald_OnKillPlr")
RegisterUnitEvent(24200, 4, "Skarvald_OnDeath")

local Dalronn = 24200

function Dalronn_OnCombat (Unit, Event)
	Dalronn = Unit
		Dalronn:RegisterEvent("Dalronn_ShadowBolt", 5600, 0)
		Dalronn:RegisterEvent("Dalronn_Chat1", 9000, 1)
end

function Dalronn_ShadowBolt (Unit, Event)
	local randomplayer = Unit:GetRandomPlayer(0)
	Dalronn:FullCastSpellOnTarget(48583, randomplayer)
end

function Dalronn_Chat1 (Unit, Event)
		Dalronn:SendChatMessage(14, 0, "By all means, don't assess the situation, you halfwit! Just jump into the fray!")
		Dalronn:PlaySoundToSet(13199)
end

function Dalronn_OnLeaveCombat (Unit, Event)
	Dalronn:Despawn(1100, 10000)
	Dalronn:RemoveEvents()
end

function Dalronn_OnDeath (Unit, Event)
	-- Missing Sound ID here if anyone knows post on forums!
	Dalronn:SendChatMessage(14, 0, "Not... over... yet")
	Dalronn:RemoveEvents()
end

function Dalronn_OnKillPlr (Unit, Event)
end

RegisterUnitEvent(24201, 1, "Dalronn_OnCombat")
RegisterUnitEvent(24201, 2, "Dalronn_OnLeaveCombat")
RegisterUnitEvent(24201, 3, "Dalronn_OnKillPlr")
RegisterUnitEvent(24201, 4, "Dalronn_OnDeath")

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////   Ingvar the Plunderer	////
--////  					    ////
--///	       					////
--//////////////////////////////////
-- Issues: Some spells do not function correctly

function Ingvar_OnCombat (Unit, Event)
		Unit:SendChatMessage(14, 0, "I'll paint my face with your blood!")
		Unit:PlaySoundToSet(13207)
		Unit:RegisterEvent("Ingvar_Cleave", 7000, 0)
		Unit:RegisterEvent("Ingvar_Enrage", 16000, 0)
		Unit:RegisterEvent("Ingvar_Roar", 20000, 0)
		Unit:RegisterEvent("Ingvar_Smash", 12000, 0)
end

function Ingvar_Cleave (Unit, Event)
		local tank = Unit:GetMainTank()
		Unit:FullCastSpellOnTarget(42724, tank)
end

function Ingvar_Enrage (Unit, Event)
		Unit:CastSpell(59707)
end

function Ingvar_Roar (Unit, Event)
	local tank = Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(42708, tank)
	end
	
function Ingvar_Smash (Unit, Event)
	local tank = Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(42669, tank)
	end
	
function Ingvar_OnKillPlr (Unit, Event)
		Unit:SendChatMessage(14, 0, "Mjul orm agn gjor!")
		Unit:PlaySoundToSet(13212)	
end

function Ingvar_OnLeaveCombat (Unit, Event)
		Unit:Despawn(1500, 10000)
		Unit:RemoveEvents()
end

function Ingvar_OnDeath (Unit, Event)
		Unit:SendChatMessage(14, 0, "My life for the... death god!")
		Unit:PlaySoundToSet(13213)
		Unit:SpawnCreature(24068, Unit:GetX(), Unit:GetY(), Unit:GetZ(), Unit:GetO(), 35, 0, 35576)
		Unit:Despawn(20000, 0)
end
		
		
RegisterUnitEvent(23954, 1, "Ingvar_OnCombat")
RegisterUnitEvent(23954, 2, "Ingvar_OnLeaveCombat")
RegisterUnitEvent(23954, 3, "Ingvar_OnKillPlr")
RegisterUnitEvent(23954, 4, "Ingvar_OnDeath")

function Ingvaru_OnCombat (Unit, Event)
		Unit:SendChatMessage(14, 0, "I return a second chance to carve your skulls!")
		Unit:PlaySoundToSet(13209)
		Unit:RegisterEvent("Ingvaru_Cleave", 7000, 0)
		Unit:RegisterEvent("Ingvaru_Roar", 20000, 0)
		Unit:RegisterEvent("Ingvaru_Smash", 12000, 0)
end

function Ingvaru_Cleave (Unit, Event)
		local tank = Unit:GetMainTank()
		Unit:FullCastSpellOnTarget(42724, tank)
end

function Ingvaru_Roar (Unit, Event)
	local tank = Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(42729, tank)
	end
	
function Ingvaru_Smash (Unit, Event)
	local tank = Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(42723, tank)
	end
	
function Ingvaru_OnKillPlr (Unit, Event)
		Unit:SendChatMessage(14, 0, "Mjul orm agn gjor!")
		Unit:PlaySoundToSet(13212)	
end

function Ingvaru_OnLeaveCombat (Unit, Event)
		Unit:SpawnCreature(23954, Unit:GetX(), Unit:GetY(), Unit:GetZ(), Unit:GetO(), 14, 0, 35576)
		Unit:Despawn(1500, 0)
		Unit:RemoveEvents()
end

function Ingvaru_OnDeath (Unit, Event)
		Unit:SendChatMessage(14, 0, "No! I can do... better! I can...")
		Unit:PlaySoundToSet(13211)
end
		
		
RegisterUnitEvent(23980, 1, "Ingvaru_OnCombat")
RegisterUnitEvent(23980, 2, "Ingvaru_OnLeaveCombat")
RegisterUnitEvent(23980, 3, "Ingvaru_OnKillPlr")
RegisterUnitEvent(23980, 4, "Ingvaru_OnDeath")

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////   Annhylde the Caller	////
--////  					    ////
--///	       					////
--//////////////////////////////////
-- Issues: No sound IDs.
		
function Caller_OnSpawn (Unit, Event)
		Unit:CastSpell(50236)
		Unit:SendChatMessage(14, 0, "Ingvar! Your pathetic failure will serve as a warning to all... you are damned! Arise and carry out the master's will!")
		Unit:PlaySoundToSet(13754)
		Unit:RegisterEvent("Caller_Chat", 15000, 1)
end	

function Caller_Chat (Unit, Event)
		Unit:SpawnCreature(23980, Unit:GetX(), Unit:GetY(), Unit:GetZ(), Unit:GetO(), 14, 0, 35576)
		Unit:Despawn(1200, 0)
end

RegisterUnitEvent(24068, 18, "Caller_OnSpawn")		