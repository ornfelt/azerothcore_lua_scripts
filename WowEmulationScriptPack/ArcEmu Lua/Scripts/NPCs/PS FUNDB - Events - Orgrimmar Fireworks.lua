--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas

org_started = 0
org_spawn_done = 0

RegisterUnitEvent(10002642, 18, "reg_org_firework")

function firework_org(pUnit, Event)
if (org_started == 1) then
pUnit:SpawnGameObject(180860, 1517.25, -4425.87, 102.732, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180861, 1529.42, -4390.5, 112.23, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180862, 1528.1, -4414.58, 97.8993, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180864, 1501.44, -4396.74, 89.5475, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180865, 1556.96, -4398.48, 87.1814, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180720, 1575.63, -4412.35, 96.9656, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180722, 1587.45, -4378.88, 91.8125, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180724, 1586.07, -4407.79, 89.499, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180726, 1628.15, -4363.28, 116.256, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180741, 1635, -4399.43, 110.699, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180703, 1611.91, -4393.33, 117.281, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180728, 1571.57, -4378.94, 95.0406, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180729, 1540.31, -4392.29, 94.1489, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180736, 1546.88, -4404.96, 88.7651, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180737, 1541.6, -4380.36, 76.3635, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180707, 1593.59, -4358.91, 94.8835, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180721, 1575.03, -4397.62, 111.3, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180723, 1555.4, -4422.45, 88.7664, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180727, 1561.25, -4387.37, 99.7968, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180725, 1510.12, -4443.02, 76.1336, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180740, 1533.93, -4444.19, 93.2844, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180733, 1562.9, -4424.29, 100.037, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180704, 1621.9, -4381.51, 100.291, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180730, 1610.79, -4342.52, 100.74, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180731, 1584.23, -4352.93, 105.556, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180738, 1555.47, -4373.41, 91.5336, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180739, 1518.13, -4381.1, 84.3002, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180708, 1511.92, -4412.87, 79.9857, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))

pUnit:SpawnGameObject(180703, 1517.25, -4425.87, 102.732, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180704, 1529.42, -4390.5, 112.23, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180707, 1528.1, -4414.58, 97.8993, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180708, 1501.44, -4396.74, 89.5475, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180720, 1556.96, -4398.48, 87.1814, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180721, 1575.63, -4412.35, 96.9656, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180722, 1587.45, -4378.88, 91.8125, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180723, 1586.07, -4407.79, 89.499, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180724, 1628.15, -4363.28, 116.256, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180725, 1635, -4399.43, 110.699, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180726, 1611.91, -4393.33, 117.281, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180727, 1571.57, -4378.94, 95.0406, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180728, 1540.31, -4392.29, 94.1489, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180729, 1546.88, -4404.96, 88.7651, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180730, 1541.6, -4380.36, 76.3635, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180731, 1593.59, -4358.91, 94.8835, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180733, 1575.03, -4397.62, 111.3, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180736, 1555.4, -4422.45, 88.7664, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180737, 1561.25, -4387.37, 99.7968, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180738, 1510.12, -4443.02, 76.1336, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180739, 1533.93, -4444.19, 93.2844, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180740, 1562.9, -4424.29, 100.037, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180741, 1621.9, -4381.51, 100.291, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180860, 1610.79, -4342.52, 100.74, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180861, 1584.23, -4352.93, 105.556, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180862, 1555.47, -4373.41, 91.5336, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180864, 1518.13, -4381.1, 84.3002, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180865, 1511.92, -4412.87, 79.9857, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
end
end

function org_firework(pUnit, Event)
if (org_started == 1) and (org_spawn_done == 0) then
org_spawn_done = 1
pUnit:RegisterEvent("org_end", 900000, 1)
pUnit:RegisterEvent("firework_org", 1000, 0)
end
end

function reg_org_firework(pUnit, Event)
pUnit:RegisterEvent("org_firework", 10, 0)
end

function org_end(pUnit, Event)
org_started = 0
org_spawn_done = 0
end
