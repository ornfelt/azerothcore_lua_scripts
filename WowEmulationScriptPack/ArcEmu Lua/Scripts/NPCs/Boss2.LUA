local NPC_ID = 200033

function boss_OnCombat(pUnit, Event)
        pUnit:SendChatMessage(14, 0, " ...Get out of here horde!!!..")
		pUnit:RegisterEvent(boss_rend, 20000, 1) -- start phase one
		pUnit:RegisterEvent(boss_bs, 1000, 1) 
		pUnit:RegisterEvent(boss_charge, 30000, 20) 
	        pUnit:RegisterEvent(boss_thunderclap, 32000, 5)
                pUnit:RegisterEvent(boss_whirlwind, 35000, 20) -- end of phase one 
		pUnit:RegisterEvent(boss_ds, 60000, 1) -- start phase two
		pUnit:RegisterEvent(boss_sunder, 62000, 0)
                pUnit:RegisterEvent(boss_shout, 61000, 0)
                pUnit:RegisterEvent(boss_shieldwall, 63000, 0)
                pUnit:RegisterEvent(boss_rend2, 64000, 1) -- end of phase two
                pUnit:RegisterEvent(boss_berserkst, 67000, 0)
                pUnit:RegisterEvent(boss_whirlwind2, 69000, 20)
                pUnit:RegisterEvent(boss_cleave, 73000, 0)
                pUnit:RegisterEvent(boss_bloodshirt, 75000, 0)
                pUnit:RegisterEvent(boss_Recklessness, 77000, 0)

end

function boss_rend(pUnit, Event)
        pUnit:CastSpell(42397)
end

function boss_bs(pUnit, Event)
        pUnit:CastSpell(2457)
end

function boss_charge(pUnit, Event)
        pUnit:FullCastSpellOnTarget(38907, pUnit:GetMainTank())
end

function boss_whirlwind(pUnit, Event)
        pUnit:FullCastSpellOnTarget(41399, pUnit:GetRandomPlayer(0))
end

function boss_thunderclap(pUnit, Event)
        pUnit:CastSpell(41399)
end

function boss_ds(pUnit, Event)
        pUnit:CastSpell(7376)
end


function boss_sunder(pUnit, Event)
        pUnit:CastSpell(30901)
end

function boss_shout(pUnit, Event)
        pUnit:CastSpell(29584)
end

function boss_shieldwall(pUnit, Event)
        pUnit:CastSpell(48819, pUnit:GetRandomPlayer(0))
end

function boss_rend2(pUnit, Event)
        pUnit:CastSpell(42397)
end

function boss_berserkst(pUnit, Event)
        pUnit:CastSpell(7381)
end

function boss_whirlwind2(pUnit, Event)
        pUnit:FullCastSpellOnTarget(41399, pUnit:GetRandomPlayer(0))
end

function boss_cleave(pUnit, Event)
        pUnit:CastSpell(31345, pUnit:GetRandomPlayer(0))
end

function boss_bloodthirst(pUnit, Event)
        pUnit:CastSpell(31996)
end

function boss_Recklessness(pUnit, Event)
        pUnit:CastSpell(13847)
end



function boss_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "...Too much for you? Think about coming back here again....")
end

function boss_OnKilledTarget(pUnit, Event)
        pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "...death is upon you...")
end

function boss_OnDied(pUnit, Event)
        pUnit:RemoveEvents()
		pUnit:SendChatMessage(14, 0, "...your too strong for me take the alliance area its all yours!! FOR NOW!!..")
end

RegisterUnitEvent(200033, 1, "boss_OnCombat")
RegisterUnitEvent(200033, 2, "boss_OnLeaveCombat")
RegisterUnitEvent(200033, 3, "boss_OnKilledTarget")
RegisterUnitEvent(200033, 4, "boss_OnDied")