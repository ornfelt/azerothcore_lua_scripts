local positions = {
    {x = 839.37, y = -787.032, z = -227.45, o = 1.678}, 
    {x = 805.319, y = -808.98, z = -228.176, o = 2.75}, 
    {x = 847.4, y = -847.4, z = -229.12, o = 5.034}, 
    {x = 849.7, y = -912.85, z = -227.85, o = 4.88}, 
    {x = 897.17, y = -783.51, z = -228.29, o = 0.168},
    {x = 907.66, y = -823.255, z = -228.336, o = 0.23},
    {x = 811.47, y = -911.095, z = -226.18, o = 4.48},
    {x = 757.92, y = -856.6, z = -224.29, o = 3.4},
    {x = 747.76, y = -803.45, z = -226.14, o = 2.97},
    {x = 771.34, y = -679, z = -213.04, o = 0.771},
    {x = 770.67, y = -754.96, z = -220.55, o = 2.67},
}

local function EggsonCommand(event, player, command)
    if command == "eggs" then
        for _, position in ipairs(positions) do
            player:SpawnCreature(20279, position.x, position.y, position.z, position.o, 1, 60000)
        end
        return false
    end
end

RegisterPlayerEvent(42, EggsonCommand)
