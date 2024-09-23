mb_BossModule_FlameLeviathan_ShouldDps = false
function mb_BossModule_FlameLeviathan_PreOnUpdate()
    if not UnitInVehicle("player") then
        return false
    end
    --TargetUnit("Flame Leviathan")
    mb_IWTDistanceClosingRangeCheckSpell = nil

    if (x==1) then
        mb_BossModule_FlameLeviathan_Chopper()
    elseif (x==2) then
        mb_BossModule_FlameLeviathan_Demolisher()
    else
        mb_BossModule_FlameLeviathan_SiegeEngine()
    end

    return true
end

function mb_BossModule_FlameLeviathan_Chopper()
    -- First Seat
    -- 1. Sonic Horn: 6.3-7.7k in cone 35 yard
    -- 2. Tar: Pool of tar for 45s slows enemies, can be ignited
    -- 3. Speed Boost: 100% speed for 5siege
    -- 4. First Aid Kit: Heal passenger fully over 4s

end

function mb_BossModule_FlameLeviathan_Demolisher()
    -- First Seat
    -- 1. Hurl Boulder: 27-33k damage
    -- 2. Hurl Pyrite Barrel: Stacking DoT
    -- 3. Ram: 19-21k + 2-2.5k siege damage
    -- 4. Throw Passenger: Launch a passenger into the distance
    if not mb_BossModule_FlameLeviathan_ShouldDps then
        return false
    end
    CastSpellByName("Hurl Boulder")
    return true
end

function mb_BossModule_FlameLeviathan_SiegeEngine()
    -- First Seat
    -- 1. Ram: 22-27k + knock-back, 2.8-3.1k siege damage
    -- 2. Electroshock: 25 yard AoE damage + interrupts
    -- 3. Steam Push: Charge attack + knock-back

    -- Second Seat
    -- 1. Fire Cannon: Hurls a boulder for damage
    -- 2. Anti-Air Rocket: Fast missile to knock pyrite down
    -- 3. Shield Generator: Absorbs limited amount of damage of all types for 5s.

end

function mb_BossModule_FlameLeviathan_OnLoad()
    mb_BossModule_PreOnUpdate = mb_BossModule_FlameLeviathan_PreOnUpdate
end

mb_BossModule_RegisterModule("flameleviathan", mb_BossModule_FlameLeviathan_OnLoad)
