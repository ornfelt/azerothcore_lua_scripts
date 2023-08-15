--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas

sw_started = 0
sw_spawn_done = 0

RegisterUnitEvent(10002641, 18, "reg_sw_firework")
RegisterGameObjectEvent(5000083, 4, "portal_tower1")

function firework_sw(pUnit, Event)
if (sw_started == 1) then
pUnit:SpawnGameObject(180860, -8869.37, 587.529, 143.852, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180861, -8852.61, 586.75, 147.617, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180862, -8845.52, 605.821, 141.326, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180864, -8871.6, 613.383, 146.972, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180865, -8872.16, 628.716, 137.919, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180720, -8845.02, 629.029, 128.032, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180722, -8963.83, 551.737, 174.723, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180724, -8955.32, 534.169, 172.603, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180726, -8916.26, 519.639, 195.115, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180741, -8959.47, 507.923, 157.386, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180703, -8998.88, 463.423, 199.7, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180728, -9030.05, 474.075, 206.314, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180729, -9035.19, 443.946, 202.33, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180736, -9009.94, 439.251, 192.769, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180737, -9024.21, 427.91, 191.712, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180707, -9040.61, 448.305, 194.481, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180721, -9018.48, 508.366, 164.586, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180723, -8983.66, 458.063, 176.628, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180727, -8947.07, 486.445, 176.634, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180725, -8942.42, 449.021, 176.624, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180740, -8995.6, 437.139, 185.599, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180733, -9018.99, 435.432, 183.072, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180704, -9051.75, 478.216, 170.943, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180730, -9019.89, 467.442, 171.841, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180731, -8995.74, 535.647, 161.067, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180738, -8887.14, 585.985, 150.403, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180739, -8856.12, 564.912, 145.417, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))
pUnit:SpawnGameObject(180708, -8881.63, 562.621, 160.8, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(500, 4000))

pUnit:SpawnGameObject(180703, -8869.37, 587.529, 143.852, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180704, -8852.61, 586.75, 147.617, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180707, -8845.52, 605.821, 141.326, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180708, -8871.6, 613.383, 146.972, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180720, -8872.16, 628.716, 137.919, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180721, -8845.02, 629.029, 128.032, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180722, -8963.83, 551.737, 174.723, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180723, -8955.32, 534.169, 172.603, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180724, -8916.26, 519.639, 195.115, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180725, -8959.47, 507.923, 157.386, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180726, -8998.88, 463.423, 199.7, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180727, -9030.05, 474.075, 206.314, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180728, -9035.19, 443.946, 202.33, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180729, -9009.94, 439.251, 192.769, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180730, -9024.21, 427.91, 191.712, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180731, -9040.61, 448.305, 194.481, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180733, -9018.48, 508.366, 164.586, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180736, -8983.66, 458.063, 176.628, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180737, -8947.07, 486.445, 176.634, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180738, -8942.42, 449.021, 176.624, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180739, -8995.6, 437.139, 185.599, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180740, -9018.99, 435.432, 183.072, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180741, -9051.75, 478.216, 170.943, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180860, -9019.89, 467.442, 171.841, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180861, -8995.74, 535.647, 161.067, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180862, -8887.14, 585.985, 150.403, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180864, -8856.12, 564.912, 145.417, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
pUnit:SpawnGameObject(180865, -8881.63, 562.621, 160.8, string.format("%s.%s",math.random(0, 6),math.random(0, 9999)), math.random(5000, 9000))
end
end

function sw_firework(pUnit, Event)
if (sw_started == 1) and (sw_spawn_done == 0) then
sw_spawn_done = 1
pUnit:RegisterEvent("sw_end", 900000, 1)
pUnit:RegisterEvent("firework_sw", 1000, 0)
pUnit:SpawnGameObject(5000083, -9060.14, 456.705, 93.2953, 0, 900000)
end
end

function reg_sw_firework(pUnit, Event)
pUnit:RegisterEvent("sw_firework", 10, 0)
end

function sw_end(pUnit, Event)
sw_started = 0
sw_spawn_done = 0
end

function portal_tower1(pUnit, Event, pMisc)
pMisc:Teleport (0, -9110.54, 472.422, 137.24)
end
