function Kaelthas_Fireball(Unit, Event)
      Unit:FullCastSpellOnTarget(44189, Unit:GetRandomPlayer(0))
end

function Kaelthas_FlameStrike(Unit, Event)
Unit:CastSpellOnTarget(44192, Unit:GetRandomPlayer(0))
end


function Kaelthas_Phoenix(Unit, Event)
   local x = Unit:GetX()
   local y = Unit:GetY()
   local z = Unit:GetZ()
   local o = Unit:GetO()
        Unit:RemoveEvents()
   Unit:SpawnCreature(24674, x-1, y, z, o, 16, o)
end

function Kaelthas_phaseone(Unit, Event)
     if Unit:GetHealthPct() <= 100 then
     Unit:RemoveEvents()
     Unit:RegisterEvent("Kaelthas_Fireball",4000,0)
     Unit:RegisterEvent("Kaelthas_Phoenix", 20000,0)
     Unit:RegisterEvent("Kaelthas_FlameStrike",10000,0)
end
end

function Kaelthas_PowerFeedback(Unit, Event)
Unit:CastSpell(44265)
end

function Kaelthas_SummonArcaneSphere(Unit, Event)
Unit:CastSpell(44233)
end

function Kaelthas_phasetwo(Unit, Event)
    if Unit:GetHealthPct() <= 50 then
     Unit:RemoveEvents()
     Unit:RegisterEvent("Kaelthas_PowerFeedback",60000,0)
     Unit:RegisterEvent("Kaelthas_SummonArcaneSphere",3000,0)
  end
end

function Kaelthas_OnEnterCombat(Unit, Event)
Unit:RegisterEvent("Kaelthas_phaseone",1000,0)
Unit:RegisterEvent("Kaelthas_phasetwo",1000,0)
Unit:SendChatMessage(14, 0, " ")
Unit:PlaySoundToSet(12413)
end

function Kaelthas_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Kaelthas_OnKilledTarget(Unit, Event)
Unit:SendChatMessage(14, 0, " ")
Unit:PlaySoundToSet(12412)
Unit:RemoveEvents()
end

function Kaelthas_OnDied(Unit, Event)
Unit:SendChatMessage(14, 0, " ")
Unit:PlaySoundToSet(12421)
Unit:RemoveEvents()
end

RegisterUnitEvent(24664, 1, "Kaelthas_OnEnterCombat")
RegisterUnitEvent(24664, 2, "Kaelthas_OnLeaveCombat")
RegisterUnitEvent(24664, 3, "Kaelthas_OnKilledTarget")
RegisterUnitEvent(24664, 4, "Kaelthas_OnDied")


--Phoenix
function kealthasPhoenix_Burn(Unit, Event)
if Unit:GetHealthPct() <= 100 then
Unit:CastSpell(44197)
end
end

function kealthasPhoenix_OnCombat(Unit, Event)
Unit:RegisterEvent("kealthasPhoenix_Burn", 1000, 1)
end

function kealthasPhoenix_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function kealthasPhoenix_Died(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(24674, 1, "kealthasPhoenix_OnCombat")
RegisterUnitEvent(24674, 2, "kealthasPhoenix_LeaveCombat")
RegisterUnitEvent(24674, 4, "kealthasPhoenix_Died")

--FlameStrike
function kealthasFlameStrike_FlameStrike_1(Unit, Event)
if Unit:GetHealthPct() <= 100 then
Unit:CastSpell(44191)
Unit:CastSpell(44190)
end
end


function kealthasFlameStrike_OnCombat(Unit, Event)
Unit:RegisterEvent("kealthasFlameStrike_FlameStrike_1", 1000, 1)
--Unit:RegisterEvent("kealthasFlameStrike_FlameStrike_2", 1000, 1)
Unit:SetCombatCapable(0)
Unit:Despawn(10000, 0)
end


function kealthasFlameStrike_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function kealthasFlameStrike_Died(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(24666, 1, "kealthasFlameStrike_OnCombat")
RegisterUnitEvent(24666, 2, "kealthasFlameStrike_LeaveCombat")
RegisterUnitEvent(24666, 4, "kealthasFlameStrike_Died")

--Arcane Sphere Passive
function kealthasPArcaneSphere_Passive(Unit, Event)
if Unit:GetHealthPct() <= 100 then
Unit:CastSpell(44263)
end
end

function kealthasPArcaneSphere_OnCombat(Unit, Event)
Unit:RegisterEvent("kealthasPArcaneSphere_Passive", 1000, 1)
Unit:Despawn(35000, 0)
end

function kealthasPArcaneSphere_onLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


function kealthasPArcaneSphere_onDied(Unit, Event)
Unit:RemoveEvents()
end



RegisterUnitEvent(24708, 1, "kealthasPArcaneSphere_OnCombat")
RegisterUnitEvent(24708, 2, "kealthasPArcaneSphere_onLeaveCombat")
RegisterUnitEvent(24708, 4, "kealthasPArcaneSphere_onDied")