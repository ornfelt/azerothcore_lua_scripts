-- gazlowe creature ID
GAZLOWE = 1000022

array_classes = {
{"Arms", "Fury", "Protection"}, -- player:GetClass() == 1, warrior
{"Holy ", "Protection ", "Retribution"}, -- pally
{"Beast Mastery", "Marksmanship", "Survival"}, -- hunter`
{"Assassination", "Combat", "Subtlety"}, -- rogue
{"Discipline", "Holy", "Shadow"}, -- priest
{"DEATH KNIGHT PLACEHOLDER, DEATH KNIGHT PLACEHOLDER, DEATH KNIGHT PLACEHOLDER"}, -- placeholder for dks
{"Elemental", "Enhancement", "Restoration "}, -- shaman
{"Arcane", "Fire", "Frost"}, -- mage
{"Affliction", "Demonology", "Destruction"}, -- warlock
{"MONK PLACEHOLDER", "MONK PLACEHOLDER", "MONK PLACEHOLDER"}, -- placeholder for monks lmao
{"Balance", "Feral Combat", "Restoration"}, -- druid
}


-- holds the talents for each spec from talent.dbc
array_talents = {
-- warr
["Arms"] = {124, 127, 641, 128, 131, 662, 121, 136, 2232, 132, 133, 134, 1859, 129, 161, 1663, 135, 1862, 1824, 1860, 2283, 1662, 1661, 1664, 2231, 1863, 2250, 158, 157, 160, 661}, -- list of talents for arms. MUST BE IN CHRONOLOGICAL ORDER.
["Fury"] = {124, 130, 641, 128, 662, 121, 136, 2250, 158, 157, 160, 661, 154, 1581, 155, 165, 1543, 156, 167, 1655, 1865, 1658, 1868, 1659, 1866, 2234, 1867},
["Protection"] = {130, 127, 126, 641, 128, 662, 2250, 142, 1601, 141, 153, 147, 1654, 140, 2247, 151, 150, 152, 149, 702, 1652, 1660, 1653, 2236, 1666, 1893, 1871, 2246, 1872},
-- pally
["Holy "] = {1432, 1444, 1449, 1628, 1435, 1461, 1450, 1433, 1465, 1627, 1502, 1744, 2190, 1746, 1747, 2199, 2193, 2191, 2192, 1442, 1748, 1425, 2280, 1501, 1423, 2281, 1521}, -- we add a space here, because the talents would overlap with priest holy talents otherwise
["Protection "] = {2185, 1748, 1425, 2280, 1501, 1423, 2281, 1521, 1422, 1431, 1426, 1429, 2282, 1430, 1751, 1421, 1753, 2195, 1754, 2194, 2204, 2200, 2196, 1407, 1631, 1464, 1411, 1755}, -- we add a space here, because the talents would overlap with warrior protection talents otherwise
["Retribution"] = {2185, 1748, 1425, 2280, 1501, 1423, 2281, 1521, 1407, 1631, 1464, 1411, 1755, 1633, 1634, 1761, 1410, 1756, 1402, 1757, 2176, 1441, 1758, 1759, 2147, 1823, 2179, 2149, 2150},
-- hunter
["Beast Mastery"] = {1382, 1389, 1624, 1625, 2138, 1396, 1393, 1388, 1387, 1390, 1799, 1397, 1800, 1386, 1802, 2140, 1803, 2227, 1341, 1344, 1806, 1349, 1818, 1346, 1345, 1353},
["Marksmanship"] = {1344, 1806, 1349, 1818, 1345, 1348, 1342, 1351, 1353, 1347, 1804, 1362, 2130, 1361, 1807, 2131, 2132, 1808, 2134, 2135, 1623, 1820, 1310, 1304, 1810, 1814, 1309},
["Survival"] = {1344, 1806, 1349, 1818, 1345, 1623, 1820, 1310, 1304, 1305, 1810, 1622, 1814, 1309, 2229, 1306, 2228, 1321, 1303, 1809, 1812, 1325, 1813, 1322, 2145},
-- rogue
["Assassination"] = {270, 273, 277, 382, 269, 682, 268, 1721, 280, 1762, 283, 274, 2065, 281, 2069, 1718, 1715, 1719, 2244, 241, 261, 262, 244, 247, 1123, 284, 265},
["Combat"] = {276, 2244, 241, 262, 244, 247, 1123, 201, 221, 1827, 181, 204, 206, 222, 1122, 242, 1706, 1705, 205, 1707, 2072, 1825, 2073, 1709, 2074, 2075, 2076},
["Subtlety"] = {2244, 241, 261, 262, 244, 247, 1123, 245, 263, 284, 265, 681, 1702, 381, 1722, 1712, 2077, 2078, 1714, 2079, 2080, 2081, 203, 276, 270, 273, 277, 382},
-- priest
["Discipline"] = {342, 352, 346, 347, 348, 343, 1769, 341, 350, 1201, 351, 1771, 1772, 1858, 322, 2235, 1896, 1894, 1895, 1774, 1901, 1202, 1897, 410, 401, 1181, 442, 361},
["Holy"] = {342, 352, 346, 347, 348, 410, 406, 401, 1181, 442, 361, 403, 1561, 402, 1766, 404, 1768, 1637, 1765, 2279, 1767, 1904, 1902, 1815, 1905, 1911},
["Shadow"] = {462, 466, 482, 463, 542, 481, 501, 483, 881, 461, 541, 484, 1638, 2267, 521, 1906, 1816, 1908, 1779, 1909, 1907, 1910, 342, 352, 346, 344, 347, 348, 341},
-- shaman
["Elemental"] = {563, 561, 1640, 575, 574, 565, 1642, 1641, 562, 1682, 721, 573, 2052, 2262, 2049, 1686, 2050, 1687, 2051, 2252, 2053, 2101, 614, 613, 605, 617},
["Enhancement"] = {2101, 614, 613, 605, 611, 617, 601, 602, 616, 2083, 1689, 1643, 2263, 1690, 901, 2055, 2249, 2054, 1691, 1693, 2056, 2057, 2058, 563, 1640, 1645, 575, 574},
["Restoration "] = {586, 1646, 593, 583, 587, 582, 581, 588, 1648, 591, 1695, 592, 1699, 590, 2084, 2060, 1696, 2061, 1698, 2059, 2063, 2064, 2101, 614, 609, 605, 607, 617},
-- mage
["Arcane"] = {74, 76, 85, 1650, 82, 81, 83, 88, 1142, 2222, 1724, 86, 77, 1726, 421, 1725, 1727, 87, 1844, 1843, 1728, 1729, 2209, 1846, 1826, 1847},
["Fire"] = {27, 1141, 34, 2212, 28, 30, 29, 25, 24, 33, 32, 1731, 35, 1733, 36, 1848, 1734, 1735, 1850, 1851, 1852, 74, 76, 85, 1650, 82, 1845, 2211, 88, 1142},
["Frost"] = {74, 76, 85, 1650, 82, 81, 2211, 88, 2222, 38, 37, 62, 73, 70, 65, 61, 69, 741, 67, 72, 1737, 68, 71, 2214, 1740, 1853, 1854, 1741, 1855, 1856, 1857},
-- warlock
["Affliction"] = {1005, 1003, 1007, 1004, 2205, 1001, 1061, 1021, 1002, 1764, 1763, 1041, 1081, 1042, 1878, 1669, 1668, 1667, 1670, 2245, 1876, 2041, 1223, 1883, 1224, 1242, 1282, 1226, 1671, 1227},
["Demonology"] = {1221, 1223, 1883, 1225, 1242, 1243, 1282, 1226, 1671, 1262, 1227, 1261, 1283, 1680, 1263, 1673, 2261, 1672, 1884, 1885, 1886, 944, 943, 1887, 963, 967},
["Destruction"] = {943, 982, 1887, 963, 967, 985, 964, 1817, 961, 981, 1679, 966, 968, 1677, 1888, 1676, 1890, 1891, 1223, 1883, 1224, 1242, 1243, 1282, 1226, 1671, 1227},
-- druid
["Balance"] = {762, 783, 1822, 763, 789, 2240, 764, 792, 1782, 788, 2239, 1784, 790, 1783, 793, 1913, 1786, 1924, 1923, 1787, 1925, 1928, 1926, 823, 822, 841, 829, 827},
["Feral Combat"] = {796, 795, 805, 807, 1162, 798, 802, 803, 801, 797, 804, 1792, 808, 1794, 809, 1798, 1793, 1795, 1919, 1921, 1796, 1918, 2266, 1927, 822, 824, 826, 827},
["Restoration"] = {2238, 783, 1822, 2240, 764, 821, 823, 841, 826, 829, 827, 1915, 830, 831, 828, 1788, 825, 1797, 844, 1790, 1789, 1922, 1929, 1791, 1930, 2264, 1916, 1917},
}

-- holds the ranks according to each talent. ex: the first entry, 2, is rank 3 for talentID 124 for Arms.
array_talents_ranks = {
-- warr
["Arms"] = {2, 1, 1, 2, 1, 1, 2, 2, 2, 4, 0, 1, 1, 1, 0, 1, 0, 1, 2, 1, 0, 1, 0, 1, 4, 0, 2, 1, 4, 0, 2},
["Fury"]= {2, 1, 2, 1, 1, 2, 2, 2, 1, 4, 0, 2, 0, 4, 3, 0, 1, 4, 0, 1, 1, 4, 0, 0, 2, 4, 0},
["Protection"] = {2, 1, 1, 2, 2, 1, 2, 1, 4, 2, 0, 1, 1, 4, 1, 1, 1, 0, 1, 4, 1, 2, 2, 0, 0, 2, 2, 1, 0},
-- pally
["Holy "] = {4, 2, 2, 1, 0, 4, 2, 0, 2, 4, 0, 2, 2, 2, 0, 4, 1, 1, 0, 4, 2, 1, 0, 2, 0, 1, 1},
["Protection "] = {4, 2, 1, 0, 2, 0, 1, 1, 2, 0, 3, 2, 0, 0, 2, 2, 2, 2, 0, 1, 2, 1, 0, 4, 1, 2, 4, 2},
["Retribution"] = {4, 2, 1, 0, 2, 0, 1, 1, 4, 1, 2, 4, 2, 0, 1, 2, 2, 0, 2, 1, 1, 0, 2, 2, 1, 0, 2, 2, 0},
-- hunter
["Beast Mastery"] = {0, 4, 1, 1, 0, 4, 4, 1, 0, 1, 1, 3, 2, 0, 4, 2, 0, 4, 0, 4, 2, 4, 1, 2, 0, 0},
["Marksmanship"] = {4, 2, 4, 0, 0, 2, 1, 1, 0, 2, 1, 2, 2, 0, 4, 1, 2, 0, 4, 0, 4, 2, 2, 2, 1, 0, 1},
["Survival"] = {4, 2, 4, 0, 0, 2, 2, 2, 2, 2, 1, 4, 0, 1, 2, 2, 2, 2, 4, 2, 2, 0, 4, 0, 0},
-- rogue
["Assassination"] = {4, 2, 2, 0, 4, 2, 4, 1, 0, 1, 4, 1, 1, 0, 2, 0, 2, 0, 4, 2, 1, 1, 2, 1, 2, 0, 1},
["Combat"] = {2, 4, 2, 1, 1, 1, 2, 1, 4, 0, 4, 1, 1, 1, 4, 4, 1, 2, 0, 1, 1, 4, 1, 0, 1, 0, 0},
["Subtlety"] = {4, 2, 1, 1, 1, 1, 2, 2, 1, 0, 1, 0, 4, 0, 2, 4, 1, 2, 0, 1, 4, 0, 2, 2, 1, 2, 2, 0},
-- priest
["Discipline"] = {4, 2, 2, 2, 0, 2, 2, 2, 1, 4, 0, 1, 2, 2, 0, 0, 2, 1, 0, 0, 1, 4, 0, 1, 2, 4, 0, 2},
["Holy"] = {4, 1, 2, 2, 0, 1, 2, 3, 4, 0, 2, 1, 0, 4, 1, 2, 2, 0, 2, 1, 4, 2, 2, 0, 3, 0},
["Shadow"] = {4, 2, 1, 2, 1, 3, 0, 1, 1, 2, 0, 0, 1, 2, 0, 1, 2, 0, 0, 2, 4, 0, 4, 2, 2, 1, 2, 0, 2},
-- shaman
["Elemental"] = {4, 2, 2, 4, 0, 4, 2, 1, 0, 2, 4, 0, 2, 1, 1, 2, 2, 0, 2, 4, 0, 1, 2, 2, 1, 0},
["Enhancement"] = {1, 2, 4, 1, 2, 0, 2, 4, 0, 2, 2, 2, 1, 0, 0, 2, 0, 1, 2, 0, 1, 4, 0, 4, 1, 2, 3, 0},
["Restoration "] = {4, 2, 1, 2, 2, 0, 2, 2, 2, 0, 2, 4, 3, 0, 0, 1, 2, 2, 0, 1, 4, 0, 1, 2, 1, 1, 2, 0},
-- mage
["Arcane"] = {1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 1, 0, 2, 2, 2, 1, 2, 0, 2, 1, 1, 0, 3, 2, 1, 0},
["Fire"] = {1, 2, 4, 1, 1, 2, 0, 0, 1, 2, 0, 1, 4, 2, 0, 1, 2, 0, 2, 4, 0, 1, 2, 2, 1, 0, 2, 0, 1, 2},
["Frost"] = {1, 2, 2, 1, 1, 1, 0, 1, 2, 2, 4, 2, 2, 1, 2, 1, 0, 1, 2, 0, 1, 2, 0, 1, 1, 1, 2, 0, 0, 4, 0},
-- warlock
["Affliction"] = {2, 4, 0, 1, 0, 2, 0, 1, 1, 2, 2, 0, 0, 4, 2, 4, 1, 2, 0, 0, 4, 0, 2, 1, 1, 2, 0, 0, 2, 1},
["Demonology"] = {1, 2, 1, 2, 2, 2, 0, 0, 2, 4, 1, 1, 2, 2, 2, 4, 1, 0, 2, 4, 0, 4, 3, 2, 0, 1},
["Destruction"] = {4, 1, 2, 0, 4, 1, 1, 2, 2, 0, 2, 4, 0, 4, 2, 0, 4, 0, 2, 1, 1, 2, 2, 0, 0, 2, 1},
-- druid
["Balance"] = {4, 1, 1, 1, 2, 0, 1, 4, 2, 0, 2, 2, 2, 1, 0, 2, 4, 2, 0, 0, 1, 2, 0, 2, 3, 2, 2, 0},
["Feral Combat"] = {4, 2, 1, 1, 0, 2, 1, 2, 1, 1, 0, 1, 4, 2, 0, 1, 2, 0, 2, 2, 0, 4, 0, 0, 4, 4, 2, 0},
["Restoration"] = {4, 2, 1, 0, 1, 1, 2, 2, 2, 2, 0, 1, 2, 0, 4, 1, 1, 2, 0, 2, 4, 0, 2, 0, 2, 1, 4, 0},
}

-- glyphs to give based on spec. glyphs are really difficult to auto apply, so we just give them a box of glyphs.
array_talents_glyphs = {
-- warr
["Arms"] = {1999992},
["Fury"] = {1999991},
["Protection"] = {1999990},
-- pally
["Holy "] = {1999989},
["Protection "] = {1999988},
["Retribution"] = {1999987},
-- hunter
["Beast Mastery"] = {1999986},
["Marksmanship"] = {1999985},
["Survival"] = {1999984},
-- rogue
["Assassination"] = {1999983},
["Combat"] = {1999982},
["Subtlety"] = {1999981},
-- priest
["Discipline"] = {1999980},
["Holy"] = {1999979},
["Shadow"] = {1999978},
-- shaman
["Elemental"] = {1999977},
["Enhancement"] = {1999976},
["Restoration "] = {1999975},
-- mage
["Arcane"] = {1999974},
["Fire"] = {1999973},
["Frost"] = {1999972},
-- warlock
["Affliction"] = {1999971},
["Demonology"] = {1999970},
["Destruction"] = {1999969},
-- druid
["Balance"] = {1999968},
["Feral Combat"] = {1999967},
["Restoration"] = {1999966},
}

-- items to give based on spec. if overlap happens, make sure there is only one entry for enchants/equip slot below.
array_talents_items = {
-- warr
["Arms"] = {1000387, 42034, 1000393, 1000503, 1000383, 1000398, 1000384, 1000396, 1000390, 1000397, 42117, 49000, 45522, 45286, 1000529, 1000560},
["Fury"] = {1000387, 42034, 1000393, 1000503, 1000383, 1000398, 1000384, 1000396, 1000390, 1000397, 42117, 49000, 45522, 45286, 1000529, 1000559, 1000558},
["Protection"] = {1000387, 42034, 1000393, 1000503, 1000383, 1000398, 1000384, 1000396, 1000390, 1000397, 42117, 49000, 45522, 45286, 1000529, 1000568, 1000539},
-- pally
["Holy "] = {1000401, 42040, 1000403, 1000501, 1000399, 1000406, 1000400, 1000404, 1000402, 1000405, 42116, 48999, 45535, 44912, 42615, 1000580, 1000541},
["Protection "] = {1000389, 42034, 1000395, 1000503, 1000382, 1000398, 1000385, 1000396, 1000392, 1000397, 49000, 42117, 45286, 45522, 42615, 1000568, 1000539},
["Retribution"] = {1000389, 42034, 1000395, 1000503, 1000382, 1000398, 1000385, 1000396, 1000392, 1000397, 49000, 42117, 45286, 45522, 42615, 1000559},
-- hunter
["Beast Mastery"] = {1000428, 42034, 1000432, 1000503, 1000424, 1000433, 1000426, 1000435, 1000430, 1000434, 42117, 49000, 45286, 45522, 1000566, 1000569, 1000555},
["Marksmanship"] = {1000428, 42034, 1000432, 1000503, 1000424, 1000433, 1000426, 1000435, 1000430, 1000434, 42117, 49000, 45286, 45522, 1000566, 1000569, 1000555},
["Survival"] = {1000428, 42034, 1000432, 1000503, 1000424, 1000433, 1000426, 1000435, 1000430, 1000434, 42117, 49000, 45286, 45522, 1000566, 1000569, 1000555},
-- rogue
["Assassination"] = {1000456, 42034, 1000458, 1000503, 1000452, 1000464, 1000460, 1000462, 1000453, 1000463, 49000, 42117, 45522, 45286, 1000529, 1000567, 1000571},
["Combat"] = {1000456, 42034, 1000458, 1000503, 1000452, 1000464, 1000460, 1000462, 1000453, 1000463, 49000, 42117, 45522, 45286, 1000569, 1000574, 1000529},
["Subtlety"] = {1000456, 42034, 1000458, 1000503, 1000452, 1000464, 1000460, 1000462, 1000453, 1000463, 49000, 42117, 45522, 45286, 1000529, 1000567, 1000571},
-- priest
["Discipline"] = {1000465, 42037, 1000468, 1000500, 1000466, 1000599, 1000469, 1000470, 1000467, 1000471, 42116, 48999, 45535, 44912, 1000580, 1000538, 1000535},
["Holy"] = {1000465, 42037, 1000468, 1000500, 1000466, 1000599, 1000469, 1000470, 1000467, 1000471, 42116, 48999, 45535, 44912, 1000580, 1000538, 1000535},
["Shadow"] = {1000476, 42037, 1000479, 1000500, 1000477, 1000475, 1000480, 1000473, 1000478, 1000474, 42116, 48999, 40255, 45490, 1000579, 1000538, 1000535},
-- shaman
["Elemental"] = {1000412, 42037, 1000416, 1000500, 1000408, 1000420, 1000410, 1000421, 1000414, 1000422, 48999, 42116, 40255, 45490, 1000579, 1000540, 42603},
["Enhancement"] = {1000427, 42034, 1000431, 1000504, 1000423, 1000433, 1000425, 1000435, 1000429, 1000434, 49000, 42117, 45286, 45522, 1000513, 1000514, 42608},
["Restoration "] = {1000411, 42040, 1000415, 1000501, 1000407, 1000419, 1000409, 1000417, 1000413, 1000418, 48999, 42116, 45535, 44912, 1000580, 1000541, 42598},
-- mage
["Arcane"] = {1000481, 42037, 1000484, 1000500, 1000482, 1000475, 1000485, 1000473, 1000483, 1000474, 48999, 42116, 45490, 40255, 1000538, 1000579, 1000535},
["Fire"] = {1000481, 42037, 1000484, 1000500, 1000482, 1000475, 1000485, 1000473, 1000483, 1000474, 48999, 42116, 45490, 40255, 1000538, 1000579, 1000535},
["Frost"] = {1000481, 42037, 1000484, 1000500, 1000482, 1000475, 1000485, 1000473, 1000483, 1000474, 48999, 42116, 45490, 40255, 1000538, 1000579, 1000535},
-- warlock
["Affliction"] = {1000486, 42037, 1000489, 1000500, 1000487, 1000475, 1000490, 1000473, 1000488, 1000474, 48999, 42116, 45490, 40255, 1000538, 1000579, 1000535},
["Demonology"] = {1000486, 42037, 1000489, 1000500, 1000487, 1000475, 1000490, 1000473, 1000488, 1000474, 48999, 42116, 45490, 40255, 1000538, 1000579, 1000535},
["Destruction"] = {1000486, 42037, 1000489, 1000500, 1000487, 1000475, 1000490, 1000473, 1000488, 1000474, 48999, 42116, 45490, 40255, 1000538, 1000579, 1000535},
-- druid
["Balance"] = {0},
["Feral Combat"] = {0},
["Restoration"] = {0},
}



-- USE DB TABLE: `eluna_build_a_character`

-- talent function so we dont have to copy/paste all the time
local function SetTalents(player, spec)
	player:ResetTalents()
	-- give talents
	for x=1,#array_talents[spec],1 do
--		player:SendBroadcastMessage(array_talents[spec][x].. ":" ..array_talents_ranks[spec][x] )
		player:LearnTalent(array_talents[spec][x], array_talents_ranks[spec][x])
	end
	player:SetFreeTalentPoints(0)
	player:AddItem(array_talents_glyphs[spec][1], 1)
end

local function SetGear(player, spec)
-- remove all equipped items because we dont want to unequip them and play with counting inventory slots.
	for m=0,19,1 do
		remove_item = player:GetEquippedItemBySlot(m)
		if (remove_item ~= nil) then
			player:RemoveItem(remove_item, 1)
		end
	end

	local Build_A_Character_Query1 = WorldDBQuery("SELECT `head`,`head_enchant`,`neck`,`neck_enchant`,`shoulder`,`shoulder_enchant`,`shirt`,`shirt_enchant`,`chest`,`chest_enchant`,`waist`,`waist_enchant`,`legs`,`legs_enchant`,`feet`,`feet_enchant`,`wrist`,`wrist_enchant`,`hand`,`hand_enchant`,`finger1`,`finger1_enchant`,`finger2`,`finger2_enchant`,`trinket1`,`trinket1_enchant`,`trinket2`,`trinket2_enchant`,`back`,`back_enchant`,`mainhand`,`mainhand_enchant`,`offhand`,`offhand_enchant`,`ranged`,`ranged_enchant` FROM eluna_build_a_character  WHERE class = ".. player:GetClass() .. " AND spec = '".. spec .. "'")

	local inventory_type_counter = 0
		
    if Build_A_Character_Query1 == nil then
        player:SendBroadcastMessage("[Build-A-Character]: This class does not have an equipment template yet. Please make a ticket on the Discord!")
		return false
    end		

	for x=0,Build_A_Character_Query1:GetColumnCount()-1,2 do -- Assign items
		local entry = Build_A_Character_Query1:GetInt32(x)
		local enchantsSQL = Build_A_Character_Query1:GetString(x+1)
		local enchants = {}	
		local enchants = getCommandParameters(enchantsSQL)
		local inventory_type = 0
		if x ~= 0 then -- we can't divide by 0 so, we make a separate if statement for values that are not zero. 
			inventory_type = math.floor(x/2) -- using math.floor to remove decimals. This is the inventory slot/2 if we've ordered the select query properly.
		end
		
		if entry ~= 0 then -- We want to skip slots where we're not equipping anything.
			if (player:IsAlliance() == false) then -- some items have to be converted if the player is Horde.
				local factionItem = FactionChangeItemFromAlliance(entry)
				if (factionItem ~= 0) then
					entry = factionItem
				end
			end
				
			local item = player:EquipItem(entry, inventory_type)
			if item == nil then -- If equip failed
				player:SendBroadcastMessage("[Build-A-Character]: Something went wrong when equipping an item with entry ID: " .. GetItemLink(entry) .. ". Do you already have this item in your inventory?")
			else -- If equip was successful
				for z=0,#enchants,1 do
					if (enchants[z+1] == nil) then -- Break if nothing left to enchant
						break
					else
						--print(enchants[z+1], z)
						item:SetEnchantment(enchants[z+1], z)
					end
				end
			end
		end
	end
	player:SendBroadcastMessage("[Build-A-Character]: Outfit generation completed!")
end

local function GazloweHello(event, player, creature)
	player:GossipMenuAddItem(0, "Let's start with talents!", 65017, 1)
	player:GossipMenuAddItem(0, "Give me stats!", 65017, 2)
	player:GossipMenuAddItem(0, "I think I'm capable of choosing these things myself", 65017, 0)
	player:GossipSendMenu(65017, creature, MenuId)
end



local function GazloweSelect(event, player, creature, sender, intid, code)
	player:GossipClearMenu()
	if (intid == 0) then
		player:GossipComplete()
	elseif (intid == 1) then
		-- generates spec options based on array. options will always be 3, so it doesnt matter if we hardcode this.
		-- intid here is 10 to indicate we have nested intids.
		player:GossipMenuAddItem(0, array_classes[player:GetClass()][1], 65018, 10, false, "Accepting will remove all your current talent points and generate new ones. Accept?")
		player:GossipMenuAddItem(0, array_classes[player:GetClass()][2], 65018, 11, false, "Accepting will remove all your current talent points and generate new ones. Accept?")
		player:GossipMenuAddItem(0, array_classes[player:GetClass()][3], 65018, 12, false, "Accepting will remove all your current talent points and generate new ones. Accept?")
		player:GossipSendMenu(65018, creature, MenuId)
	elseif (intid == 2) then
		player:GossipMenuAddItem(0, array_classes[player:GetClass()][1], 65018, 30, false, "Accepting will remove all your currently equipped gear and generate new ones. Continue?")
		player:GossipMenuAddItem(0, array_classes[player:GetClass()][2], 65018, 31, false, "Accepting will remove all your currently equipped gear and generate new ones. Continue?")
		player:GossipMenuAddItem(0, array_classes[player:GetClass()][3], 65018, 32, false, "Accepting will remove all your currently equipped gear and generate new ones. Continue?")
		player:GossipSendMenu(65018, creature, MenuId)		
	elseif (intid >= 10) and (intid <= 12) then
		if (intid == 10) then
			spec = array_classes[player:GetClass()][1]
			SetTalents(player, spec)
		elseif (intid == 11) then
			spec = array_classes[player:GetClass()][2]
			SetTalents(player, spec)
		elseif (intid == 12) then
			spec = array_classes[player:GetClass()][3]
			SetTalents(player, spec)
		end
---		player:GossipMenuAddItem(0, "Suit me up!", 65019, 20, false, "Accepting will remove all equipped items and generate new ones. Accept?")
---		player:GossipMenuAddItem(0, "I think I can pick my own gear", 65019, 0)
---		player:GossipSendMenu(65019, creature, MenuId)
		player:GossipComplete()
	elseif (intid >= 30) and (intid <= 32) then
		for m=0,19,1 do
			remove_item = player:GetEquippedItemBySlot(m)
			if (remove_item ~= nil) then
				player:RemoveItem(remove_item, 1)
			end
		end

		if (intid == 30) then
			spec = array_classes[player:GetClass()][1]
			SetGear(player, spec)
		elseif (intid == 31) then
			spec = array_classes[player:GetClass()][2]
			SetGear(player, spec)
		elseif (intid == 32) then
			spec = array_classes[player:GetClass()][3]
			SetGear(player, spec)
		end
		player:GossipComplete()
	end
end

RegisterCreatureGossipEvent(GAZLOWE, 1, GazloweHello)
RegisterCreatureGossipEvent(GAZLOWE, 2, GazloweSelect)


-- TOOLS FOR ARRAY INSERTING


