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

function bomb_CheckA(Unit)
	if Unit:GetHealthPct() < 95 then
                Unit:StopMovement(999999999)
                Unit:SetCombatCapable(1)
                Unit:SetScale(2)
	        x = Unit:GetX();
	        y = Unit:GetY();
	        z = Unit:GetZ();
	        o = Unit:GetO();
                x = x + 10
                y = y + 10
		Unit:SpawnCreature(98881, x, y, z, o, 17, 15000);
	end
end

function bomb_CheckB(Unit)
	if Unit:GetHealthPct() < 66 then
		Unit:SetScale(2)
                Unit:StopMovement(999999999)
                Unit:SetCombatCapable(1)
                Unit:SetScale(3)
	        x = Unit:GetX();
	        y = Unit:GetY();
	        z = Unit:GetZ();
	        o = Unit:GetO();
                x = x - 10
                y = y - 10
		Unit:SpawnCreature(98881, x, y, z, o, 17, 15000);
	end
end

function bomb_CheckC(Unit)
	if Unit:GetHealthPct() < 77 then
                Unit:SetScale(2)
                Unit:StopMovement(999999999)
                Unit:SetCombatCapable(1)
                Unit:SetScale(2)
	        x = Unit:GetX();
	        y = Unit:GetY();
	        z = Unit:GetZ();
	        o = Unit:GetO();
                x = x + 10
                y = y + 10
		Unit:SpawnCreature(98881, x, y, z, o, 17, 15000);
	end
end

function bomb_CheckD(Unit)
	if Unit:GetHealthPct() < 85 then
                Unit:StopMovement(999999999)
                Unit:SetCombatCapable(1)
                Unit:SetScale(2)
	        x = Unit:GetX();
	        y = Unit:GetY();
	        z = Unit:GetZ();
	        o = Unit:GetO();
                x = x - 10
                y = y - 10
		Unit:SpawnCreature(98881, x, y, z, o, 17, 15000);
	end
end

function bomb_Shadow(Unit)
                Unit:StopMovement(999999999)
                Unit:SetCombatCapable(1)
	        x = Unit:GetX();
	        y = Unit:GetY();
	        z = Unit:GetZ();
	        o = Unit:GetO();
                x = x + 10
                y = y + 10
		Unit:SpawnCreature(98881, x, y, z, o, 17, 15000);
end

function bomb_OnCombat(Unit, Event)
        Unit:StopMovement(999999999)
        Unit:SetCombatCapable(1)
	Unit:RegisterEvent("bomb_CheckA",25000, 0)
	Unit:RegisterEvent("bomb_CheckB",20000, 0)
	Unit:RegisterEvent("bomb_CheckC",25000, 0)
	Unit:RegisterEvent("bomb_CheckD",20000, 0)
	Unit:RegisterEvent("bomb_Shadow",31000, 0)
end

function bomb_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function bomb_KilledTarget(Unit)
                Unit:StopMovement(999999999)
                Unit:SetCombatCapable(1)
	        x = Unit:GetX();
	        y = Unit:GetY();
	        z = Unit:GetZ();
	        o = Unit:GetO();
                x = x - 10
                y = y - 10
		Unit:SpawnCreature(98881, x, y, z, o, 17, 15000);
end

function bomb_OnDied(Unit)
        Unit:SetScale(1)
        Unit:CastSpell(36722)
	Unit:RemoveEvents()
end

RegisterUnitEvent(444444, 1, "bomb_OnCombat")
RegisterUnitEvent(444444, 2, "bomb_OnLeaveCombat")
RegisterUnitEvent(444444, 3, "bomb_OnKilledTarget")
RegisterUnitEvent(444444, 4, "bomb_OnDied") 

function bombminion_onDied (pUnit, Event)
    pUnit:Despawn(1,0)
end

function bombminion_OnCombat(pUnit, Event)
    pUnit:FullCastSpell(5010)
end

RegisterUnitEvent(98881, 1, "bombminion_OnCombat")
RegisterUnitEvent(98881, 2, "bombminion_OnDied")