--[[ Borean Tundra -- 55-D Collect-a-tron.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function DCollectatron_OnCombat(Unit, Event)
Unit:RegisterEvent("DCollectatron_DumpOil", 10000, 0)
end

function DCollectatron_DumpOil(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50269, pUnit:GetMainTank()) 
end

function DCollectatron_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DCollectatron_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DCollectatron_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25793, 1, "DCollectatron_OnCombat")
RegisterUnitEvent(25793, 2, "DCollectatron_OnLeaveCombat")
RegisterUnitEvent(25793, 3, "DCollectatron_OnKilledTarget")
RegisterUnitEvent(25793, 4, "DCollectatron_OnDied")


--[[ Borean Tundra -- Aged Magnataur.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function AgedMagnataur_OnCombat(Unit, Event)
Unit:RegisterEvent("AgedMagnataur_PlagueCloud", 2000, 2)
end

function AgedMagnataur_PlagueCloud(pUnit, Event) 
pUnit:CastSpell(50366) 
end

function AgedMagnataur_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AgedMagnataur_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AgedMagnataur_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24954, 1, "AgedMagnataur_OnCombat")
RegisterUnitEvent(24954, 2, "AgedMagnataur_OnLeaveCombat")
RegisterUnitEvent(24954, 3, "AgedMagnataur_OnKilledTarget")
RegisterUnitEvent(24954, 4, "AgedMagnataur_OnDied")


--[[ Borean Tundra -- Arcane Serpent.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ArcaneSerpent_OnCombat(Unit, Event)
Unit:RegisterEvent("ArcaneSerpent_ArcaneJolt", 8000, 0)
end

function ArcaneSerpent_ArcaneJolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50504, pUnit:GetMainTank()) 
end

function ArcaneSerpent_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ArcaneSerpent_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ArcaneSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25721, 1, "ArcaneSerpent_OnCombat")
RegisterUnitEvent(25721, 2, "ArcaneSerpent_OnLeaveCombat")
RegisterUnitEvent(25721, 3, "ArcaneSerpent_OnKilledTarget")
RegisterUnitEvent(25721, 4, "ArcaneSerpent_OnDied")


--[[ Borean Tundra -- Aspatha the Broodmother.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function AspathatheBroodmother_OnCombat(Unit, Event)
Unit:RegisterEvent("AspathatheBroodmother_Pollen", 8000, 0)
Unit:RegisterEvent("AspathatheBroodmother_WingBuffet", 9000, 0)
end

function AspathatheBroodmother_Pollen(pUnit, Event) 
pUnit:CastSpell(45610) 
end

function AspathatheBroodmother_WingBuffet(pUnit, Event) 
pUnit:CastSpell(32914) 
end

function AspathatheBroodmother_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AspathatheBroodmother_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AspathatheBroodmother_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25498, 1, "AspathatheBroodmother_OnCombat")
RegisterUnitEvent(25498, 2, "AspathatheBroodmother_OnLeaveCombat")
RegisterUnitEvent(25498, 3, "AspathatheBroodmother_OnKilledTarget")
RegisterUnitEvent(25498, 4, "AspathatheBroodmother_OnDied")


--[[ Borean Tundra -- Bane.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Bane_OnCombat(Unit, Event)
Unit:RegisterEvent("Bane_FoolsBane", 10000, 0)
end

function Bane_FoolsBane(pUnit, Event) 
pUnit:CastSpell(50332) 
end

function Bane_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bane_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25655, 1, "Bane_OnCombat")
RegisterUnitEvent(25655, 2, "Bane_OnLeaveCombat")
RegisterUnitEvent(25655, 3, "Bane_OnKilledTarget")
RegisterUnitEvent(25655, 4, "Bane_OnDied")


--[[ Borean Tundra -- Beryl Sorcerer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BerylSorcerer_OnCombat(Unit, Event)
Unit:RegisterEvent("BerylSorcerer_Blink", 11000, 0)
Unit:RegisterEvent("BerylSorcerer_Frostbolt", 8000, 0)
end

function BerylSorcerer_Blink(pUnit, Event) 
pUnit:CastSpell(50648) 
end

function BerylSorcerer_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9672, pUnit:GetMainTank()) 
end

function BerylSorcerer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BerylSorcerer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BerylSorcerer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25316, 1, "BerylSorcerer_OnCombat")
RegisterUnitEvent(25316, 2, "BerylSorcerer_OnLeaveCombat")
RegisterUnitEvent(25316, 3, "BerylSorcerer_OnKilledTarget")
RegisterUnitEvent(25316, 4, "BerylSorcerer_OnDied")


--[[ Borean Tundra -- Beryl Treasure Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BerylTreasureHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("BerylTreasureHunter_FocusBeam", 8000, 0)
end

function BerylTreasureHunter_FocusBeam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50658, pUnit:GetMainTank()) 
end

function BerylTreasureHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BerylTreasureHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BerylTreasureHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25353, 1, "BerylTreasureHunter_OnCombat")
RegisterUnitEvent(25353, 2, "BerylTreasureHunter_OnLeaveCombat")
RegisterUnitEvent(25353, 3, "BerylTreasureHunter_OnKilledTarget")
RegisterUnitEvent(25353, 4, "BerylTreasureHunter_OnDied")


--[[ Borean Tundra -- Bloodspore Firestarter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BloodsporeFirestarter_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodsporeFirestarter_Fireball", 8000, 0)
Unit:RegisterEvent("BloodsporeFirestarter_FlamingTouch", 3000, 1)
Unit:RegisterEvent("BloodsporeFirestarter_MoltenArmor", 6000, 1)
end

function BloodsporeFirestarter_Fireball(pUnit, Event) 
pUnit:FullCastSpellOnTarget(20793, pUnit:GetMainTank()) 
end

function BloodsporeFirestarter_FlamingTouch(pUnit, Event) 
pUnit:CastSpell(45985) 
end

function BloodsporeFirestarter_MoltenArmor(pUnit, Event) 
pUnit:CastSpell(35916) 
end

function BloodsporeFirestarter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodsporeFirestarter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodsporeFirestarter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25470, 1, "BloodsporeFirestarter_OnCombat")
RegisterUnitEvent(25470, 2, "BloodsporeFirestarter_OnLeaveCombat")
RegisterUnitEvent(25470, 3, "BloodsporeFirestarter_OnKilledTarget")
RegisterUnitEvent(25470, 4, "BloodsporeFirestarter_OnDied")


--[[ Borean Tundra -- Bloodspore Harvester.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BloodsporeHarvester_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodsporeHarvester_BloodsporeHaze", 10000, 0)
end

function BloodsporeHarvester_BloodsporeHaze(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50380, pUnit:GetMainTank()) 
end

function BloodsporeHarvester_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodsporeHarvester_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodsporeHarvester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25467, 1, "BloodsporeHarvester_OnCombat")
RegisterUnitEvent(25467, 2, "BloodsporeHarvester_OnLeaveCombat")
RegisterUnitEvent(25467, 3, "BloodsporeHarvester_OnKilledTarget")
RegisterUnitEvent(25467, 4, "BloodsporeHarvester_OnDied")


--[[ Borean Tundra -- Bloodspore Roaster.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BloodsporeRoaster_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodsporeRoaster_Roast", 8000, 0)
end

function BloodsporeRoaster_Roast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50402, pUnit:GetMainTank()) 
end

function BloodsporeRoaster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodsporeRoaster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodsporeRoaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25468, 1, "BloodsporeRoaster_OnCombat")
RegisterUnitEvent(25468, 2, "BloodsporeRoaster_OnLeaveCombat")
RegisterUnitEvent(25468, 3, "BloodsporeRoaster_OnKilledTarget")
RegisterUnitEvent(25468, 4, "BloodsporeRoaster_OnDied")


--[[ Borean Tundra -- Blue Drakonid Supplicant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BlueDrakonidSupplicant_OnCombat(Unit, Event)
Unit:RegisterEvent("BlueDrakonidSupplicant_PowerSap", 8000, 0)
end

function BlueDrakonidSupplicant_PowerSap(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50534, pUnit:GetMainTank()) 
end

function BlueDrakonidSupplicant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlueDrakonidSupplicant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlueDrakonidSupplicant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25713, 1, "BlueDrakonidSupplicant_OnCombat")
RegisterUnitEvent(25713, 2, "BlueDrakonidSupplicant_OnLeaveCombat")
RegisterUnitEvent(25713, 3, "BlueDrakonidSupplicant_OnKilledTarget")
RegisterUnitEvent(25713, 4, "BlueDrakonidSupplicant_OnDied")


--[[ Borean Tundra -- Boiling Spirit.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BoilingSpirit_OnCombat(Unit, Event)
Unit:RegisterEvent("BoilingSpirit_ScaldingSteam", 8000, 0)
end

function BoilingSpirit_ScaldingSteam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50206, pUnit:GetMainTank()) 
end

function BoilingSpirit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BoilingSpirit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BoilingSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25419, 1, "BoilingSpirit_OnCombat")
RegisterUnitEvent(25419, 2, "BoilingSpirit_OnLeaveCombat")
RegisterUnitEvent(25419, 3, "BoilingSpirit_OnKilledTarget")
RegisterUnitEvent(25419, 4, "BoilingSpirit_OnDied")


--[[ Borean Tundra -- Bone Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function BoneWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("BoneWarrior_SunderArmor", 6000, 0)
end

function BoneWarrior_SunderArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50370, pUnit:GetMainTank()) 
end

function BoneWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BoneWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BoneWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26126, 1, "BoneWarrior_OnCombat")
RegisterUnitEvent(26126, 2, "BoneWarrior_OnLeaveCombat")
RegisterUnitEvent(26126, 3, "BoneWarrior_OnKilledTarget")
RegisterUnitEvent(26126, 4, "BoneWarrior_OnDied")


--[[ Borean Tundra -- Captain Jacobs.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function CaptainJacobs_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainJacobs_BladeFlurry", 10000, 0)
Unit:RegisterEvent("CaptainJacobs_MortalStrike", 8000, 0)
end

function CaptainJacobs_BladeFlurry(pUnit, Event) 
pUnit:CastSpell(33735) 
end

function CaptainJacobs_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32736, pUnit:GetMainTank()) 
end

function CaptainJacobs_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainJacobs_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainJacobs_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26252, 1, "CaptainJacobs_OnCombat")
RegisterUnitEvent(26252, 2, "CaptainJacobs_OnLeaveCombat")
RegisterUnitEvent(26252, 3, "CaptainJacobs_OnKilledTarget")
RegisterUnitEvent(26252, 4, "CaptainJacobs_OnDied")


--[[ Borean Tundra -- Chieftain Gurgleboggle.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ChieftainGurgleboggle_OnCombat(Unit, Event)
Unit:RegisterEvent("ChieftainGurgleboggle_FlipAttack", 8000, 0)
end

function ChieftainGurgleboggle_FlipAttack(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50533, pUnit:GetMainTank()) 
end

function ChieftainGurgleboggle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ChieftainGurgleboggle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ChieftainGurgleboggle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25725, 1, "ChieftainGurgleboggle_OnCombat")
RegisterUnitEvent(25725, 2, "ChieftainGurgleboggle_OnLeaveCombat")
RegisterUnitEvent(25725, 3, "ChieftainGurgleboggle_OnKilledTarget")
RegisterUnitEvent(25725, 4, "ChieftainGurgleboggle_OnDied")


--[[ Borean Tundra -- Churn.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Churn_OnCombat(Unit, Event)
Unit:RegisterEvent("Churn_ScaldingSteam", 8000, 0)
end

function Churn_ScaldingSteam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50206, pUnit:GetMainTank()) 
end

function Churn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Churn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Churn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25418, 1, "Churn_OnCombat")
RegisterUnitEvent(25418, 2, "Churn_OnLeaveCombat")
RegisterUnitEvent(25418, 3, "Churn_OnKilledTarget")
RegisterUnitEvent(25418, 4, "Churn_OnDied")


--[[ Borean Tundra -- Clam Master K.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ClamMasterK_OnCombat(Unit, Event)
Unit:RegisterEvent("ClamMasterK_HookedNet", 8000, 0)
end

function ClamMasterK_HookedNet(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49711, pUnit:GetMainTank()) 
end

function ClamMasterK_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ClamMasterK_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ClamMasterK_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25800, 1, "ClamMasterK_OnCombat")
RegisterUnitEvent(25800, 2, "ClamMasterK_OnLeaveCombat")
RegisterUnitEvent(25800, 3, "ClamMasterK_OnKilledTarget")
RegisterUnitEvent(25800, 4, "ClamMasterK_OnDied")


--[[ Borean Tundra -- Claximus.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Claximus_OnCombat(Unit, Event)
Unit:RegisterEvent("Claximus_ArcaneBarrage", 8000, 0)
Unit:RegisterEvent("Claximus_StabilizedMagic", 2000, 1)
end

function Claximus_ArcaneBarrage(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50273, pUnit:GetMainTank()) 
end

function Claximus_StabilizedMagic(pUnit, Event) 
pUnit:CastSpell(50275) 
end

function Claximus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Claximus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Claximus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25209, 1, "Claximus_OnCombat")
RegisterUnitEvent(25209, 2, "Claximus_OnLeaveCombat")
RegisterUnitEvent(25209, 3, "Claximus_OnKilledTarget")
RegisterUnitEvent(25209, 4, "Claximus_OnDied")


--[[ Borean Tundra -- Coldarra Scalesworn.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ColdarraScalesworn_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraScalesworn_FrostNova", 10000, 0)
Unit:RegisterEvent("ColdarraScalesworn_Rend", 8000, 0)
end

function ColdarraScalesworn_FrostNova(pUnit, Event) 
pUnit:CastSpell(12748) 
end

function ColdarraScalesworn_Rend(pUnit, Event) 
pUnit:FullCastSpellOnTarget(11977, pUnit:GetMainTank()) 
end

function ColdarraScalesworn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraScalesworn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraScalesworn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25717, 1, "ColdarraScalesworn_OnCombat")
RegisterUnitEvent(25717, 2, "ColdarraScalesworn_OnLeaveCombat")
RegisterUnitEvent(25717, 3, "ColdarraScalesworn_OnKilledTarget")
RegisterUnitEvent(25717, 4, "ColdarraScalesworn_OnDied")


--[[ Borean Tundra -- Coldarra Spellbinder.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ColdarraSpellbinder_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraSpellbinder_Frostbolt", 8000, 0)
end

function ColdarraSpellbinder_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9672, pUnit:GetMainTank()) 
end

function ColdarraSpellbinder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraSpellbinder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraSpellbinder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25719, 1, "ColdarraSpellbinder_OnCombat")
RegisterUnitEvent(25719, 2, "ColdarraSpellbinder_OnLeaveCombat")
RegisterUnitEvent(25719, 3, "ColdarraSpellbinder_OnKilledTarget")
RegisterUnitEvent(25719, 4, "ColdarraSpellbinder_OnDied")


--[[ Borean Tundra -- Coldarra Spellweaver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ColdarraSpellweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraSpellweaver_ArcaneMissiles", 8000, 0)
end

function ColdarraSpellweaver_ArcaneMissiles(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34447, pUnit:GetMainTank()) 
end

function ColdarraSpellweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraSpellweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraSpellweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25722, 1, "ColdarraSpellweaver_OnCombat")
RegisterUnitEvent(25722, 2, "ColdarraSpellweaver_OnLeaveCombat")
RegisterUnitEvent(25722, 3, "ColdarraSpellweaver_OnKilledTarget")
RegisterUnitEvent(25722, 4, "ColdarraSpellweaver_OnDied")


--[[ Borean Tundra -- Coldarra Wyrmkin.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ColdarraWyrmkin_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraWyrmkin_FrostbiteWeapon", 8000, 0)
end

function ColdarraWyrmkin_FrostbiteWeapon(pUnit, Event) 
pUnit:CastSpell(50416) 
end

function ColdarraWyrmkin_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraWyrmkin_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraWyrmkin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25728, 1, "ColdarraWyrmkin_OnCombat")
RegisterUnitEvent(25728, 2, "ColdarraWyrmkin_OnLeaveCombat")
RegisterUnitEvent(25728, 3, "ColdarraWyrmkin_OnKilledTarget")
RegisterUnitEvent(25728, 4, "ColdarraWyrmkin_OnDied")


--[[ Borean Tundra -- Counselor Talbot.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function CounselorTalbot_OnCombat(Unit, Event)
Unit:RegisterEvent("CounselorTalbot_SoulBlast", 10000, 0)
Unit:RegisterEvent("CounselorTalbot_SoulDeflection", 12000, 0)
Unit:RegisterEvent("CounselorTalbot_VampiricBolt", 15000, 0)
end

function CounselorTalbot_SoulBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50992, pUnit:GetMainTank()) 
end

function CounselorTalbot_SoulDeflection(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51009, pUnit:GetMainTank()) 
end

function CounselorTalbot_VampiricBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51016, pUnit:GetMainTank()) 
end

function CounselorTalbot_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CounselorTalbot_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CounselorTalbot_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25301, 1, "CounselorTalbot_OnCombat")
RegisterUnitEvent(25301, 2, "CounselorTalbot_OnLeaveCombat")
RegisterUnitEvent(25301, 3, "CounselorTalbot_OnKilledTarget")
RegisterUnitEvent(25301, 4, "CounselorTalbot_OnDied")


--[[ Borean Tundra -- Crypt Crawler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function CryptCrawler_OnCombat(Unit, Event)
Unit:RegisterEvent("CryptCrawler_CryptScarabs", 6000, 1)
end

function CryptCrawler_CryptScarabs(pUnit, Event) 
pUnit:CastSpell(31600) 
end

function CryptCrawler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CryptCrawler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CryptCrawler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25227, 1, "CryptCrawler_OnCombat")
RegisterUnitEvent(25227, 2, "CryptCrawler_OnLeaveCombat")
RegisterUnitEvent(25227, 3, "CryptCrawler_OnKilledTarget")
RegisterUnitEvent(25227, 4, "CryptCrawler_OnDied")


--[[ Borean Tundra -- Cult Plaguebringer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function CultPlaguebringer_OnCombat(Unit, Event)
Unit:RegisterEvent("CultPlaguebringer_InjectPlague", 8000, 0)
end

function CultPlaguebringer_InjectPlague(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50356, pUnit:GetMainTank()) 
end

function CultPlaguebringer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CultPlaguebringer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CultPlaguebringer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24957, 1, "CultPlaguebringer_OnCombat")
RegisterUnitEvent(24957, 2, "CultPlaguebringer_OnLeaveCombat")
RegisterUnitEvent(24957, 3, "CultPlaguebringer_OnKilledTarget")
RegisterUnitEvent(24957, 4, "CultPlaguebringer_OnDied")


--[[ Borean Tundra -- Cultist Necrolyte.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function CultistNecrolyte_OnCombat(Unit, Event)
Unit:RegisterEvent("CultistNecrolyte_CurseofAgony", 10000, 0)
Unit:RegisterEvent("CultistNecrolyte_ShadowBolt", 7000, 0)
end

function CultistNecrolyte_CurseofAgony(pUnit, Event) 
pUnit:FullCastSpellOnTarget(18266, pUnit:GetMainTank()) 
end

function CultistNecrolyte_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function CultistNecrolyte_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CultistNecrolyte_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CultistNecrolyte_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25651, 1, "CultistNecrolyte_OnCombat")
RegisterUnitEvent(25651, 2, "CultistNecrolyte_OnLeaveCombat")
RegisterUnitEvent(25651, 3, "CultistNecrolyte_OnKilledTarget")
RegisterUnitEvent(25651, 4, "CultistNecrolyte_OnDied")


--[[ Borean Tundra -- Curator Insivius.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function CuratorInsivius_OnCombat(Unit, Event)
Unit:RegisterEvent("CuratorInsivius_Charge", 1000, 1)
Unit:RegisterEvent("CuratorInsivius_FrostNova", 10000, 0)
Unit:RegisterEvent("CuratorInsivius_MortalStrike", 8000, 0)
end

function CuratorInsivius_Charge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(22120, pUnit:GetMainTank()) 
end

function CuratorInsivius_FrostNova(pUnit, Event) 
pUnit:CastSpell(11831) 
end

function CuratorInsivius_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(39171, pUnit:GetMainTank()) 
end

function CuratorInsivius_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CuratorInsivius_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CuratorInsivius_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25448, 1, "CuratorInsivius_OnCombat")
RegisterUnitEvent(25448, 2, "CuratorInsivius_OnLeaveCombat")
RegisterUnitEvent(25448, 3, "CuratorInsivius_OnKilledTarget")
RegisterUnitEvent(25448, 4, "CuratorInsivius_OnDied")


--[[ Borean Tundra -- Darkfallen Bloodbearer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function DarkfallenBloodbearer_OnCombat(Unit, Event)
Unit:RegisterEvent("DarkfallenBloodbearer_DeathCoil", 8000, 0)
Unit:RegisterEvent("DarkfallenBloodbearer_IcyTouch", 10000, 0)
end

function DarkfallenBloodbearer_DeathCoil(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50668, pUnit:GetMainTank()) 
end

function DarkfallenBloodbearer_IcyTouch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50349, pUnit:GetMainTank()) 
end

function DarkfallenBloodbearer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DarkfallenBloodbearer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DarkfallenBloodbearer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26115, 1, "DarkfallenBloodbearer_OnCombat")
RegisterUnitEvent(26115, 2, "DarkfallenBloodbearer_OnLeaveCombat")
RegisterUnitEvent(26115, 3, "DarkfallenBloodbearer_OnKilledTarget")
RegisterUnitEvent(26115, 4, "DarkfallenBloodbearer_OnDied")


--[[ Borean Tundra -- Darkfallen Deathblade.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function DarkfallenDeathblade_OnCombat(Unit, Event)
Unit:RegisterEvent("DarkfallenDeathblade_DeathCoil", 8000, 0)
Unit:RegisterEvent("DarkfallenDeathblade_IcyTouch", 10000, 0)
end

function DarkfallenDeathblade_DeathCoil(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50668, pUnit:GetMainTank()) 
end

function DarkfallenDeathblade_IcyTouch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50349, pUnit:GetMainTank()) 
end

function DarkfallenDeathblade_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DarkfallenDeathblade_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DarkfallenDeathblade_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26103, 1, "DarkfallenDeathblade_OnCombat")
RegisterUnitEvent(26103, 2, "DarkfallenDeathblade_OnLeaveCombat")
RegisterUnitEvent(26103, 3, "DarkfallenDeathblade_OnKilledTarget")
RegisterUnitEvent(26103, 4, "DarkfallenDeathblade_OnDied")


--[[ Borean Tundra -- Defendo-tank 66D.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Defendotank66D_OnCombat(Unit, Event)
Unit:RegisterEvent("Defendotank66D_MachineGun", 8000, 0)
Unit:RegisterEvent("Defendotank66D_Shoot", 6000, 0)
end

function Defendotank66D_MachineGun(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49981, pUnit:GetMainTank()) 
end

function Defendotank66D_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49987, pUnit:GetMainTank()) 
end

function Defendotank66D_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Defendotank66D_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Defendotank66D_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25758, 1, "Defendotank66D_OnCombat")
RegisterUnitEvent(25758, 2, "Defendotank66D_OnLeaveCombat")
RegisterUnitEvent(25758, 3, "Defendotank66D_OnKilledTarget")
RegisterUnitEvent(25758, 4, "Defendotank66D_OnDied")


--[[ Borean Tundra -- Den Vermin.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function DenVermin_OnCombat(Unit, Event)
Unit:RegisterEvent("DenVermin_Thrash", 6000, 0)
end

function DenVermin_Thrash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(3391, pUnit:GetMainTank()) 
end

function DenVermin_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DenVermin_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DenVermin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24567, 1, "DenVermin_OnCombat")
RegisterUnitEvent(24567, 2, "DenVermin_OnLeaveCombat")
RegisterUnitEvent(24567, 3, "DenVermin_OnKilledTarget")
RegisterUnitEvent(24567, 4, "DenVermin_OnDied")


--[[ Borean Tundra -- En'kilah Abomination.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function EnkilahAbomination_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahAbomination_Cleave", 8000, 0)
Unit:RegisterEvent("EnkilahAbomination_ScourgeHook", 6000, 0)
end

function EnkilahAbomination_Cleave(pUnit, Event) 
pUnit:CastSpell(40504) 
end

function EnkilahAbomination_ScourgeHook(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50335, pUnit:GetMainTank()) 
end

function EnkilahAbomination_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahAbomination_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahAbomination_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25383, 1, "EnkilahAbomination_OnCombat")
RegisterUnitEvent(25383, 2, "EnkilahAbomination_OnLeaveCombat")
RegisterUnitEvent(25383, 3, "EnkilahAbomination_OnKilledTarget")
RegisterUnitEvent(25383, 4, "EnkilahAbomination_OnDied")


--[[ Borean Tundra -- En'kilah Crypt Fiend.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function EnkilahCryptFiend_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahCryptFiend_CryptScarabs", 6000, 1)
end

function EnkilahCryptFiend_CryptScarabs(pUnit, Event) 
pUnit:CastSpell(31600) 
end

function EnkilahCryptFiend_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahCryptFiend_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahCryptFiend_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25386, 1, "EnkilahCryptFiend_OnCombat")
RegisterUnitEvent(25386, 2, "EnkilahCryptFiend_OnLeaveCombat")
RegisterUnitEvent(25386, 3, "EnkilahCryptFiend_OnKilledTarget")
RegisterUnitEvent(25386, 4, "EnkilahCryptFiend_OnDied")


--[[ Borean Tundra -- En'kilah Gargoyle.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function EnkilahGargoyle_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahGargoyle_GargoyleStrike", 6000, 0)
end

function EnkilahGargoyle_GargoyleStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16564, pUnit:GetMainTank()) 
end

function EnkilahGargoyle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahGargoyle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahGargoyle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25387, 1, "EnkilahGargoyle_OnCombat")
RegisterUnitEvent(25387, 2, "EnkilahGargoyle_OnLeaveCombat")
RegisterUnitEvent(25387, 3, "EnkilahGargoyle_OnKilledTarget")
RegisterUnitEvent(25387, 4, "EnkilahGargoyle_OnDied")


--[[ Borean Tundra -- En'kilah Ghoul.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function EnkilahGhoul_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahGhoul_FleshRip", 8000, 0)
end

function EnkilahGhoul_FleshRip(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38056, pUnit:GetMainTank()) 
end

function EnkilahGhoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahGhoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahGhoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25393, 1, "EnkilahGhoul_OnCombat")
RegisterUnitEvent(25393, 2, "EnkilahGhoul_OnLeaveCombat")
RegisterUnitEvent(25393, 3, "EnkilahGhoul_OnKilledTarget")
RegisterUnitEvent(25393, 4, "EnkilahGhoul_OnDied")


--[[ Borean Tundra -- En'kilah Necrolord.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function EnkilahNecrolord_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahNecrolord_BoneArmor", 2000, 1)
Unit:RegisterEvent("EnkilahNecrolord_SharpenedBone", 6000, 0)
end

function EnkilahNecrolord_BoneArmor(pUnit, Event) 
pUnit:CastSpell(50324) 
end

function EnkilahNecrolord_SharpenedBone(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50323, pUnit:GetMainTank()) 
end

function EnkilahNecrolord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahNecrolord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahNecrolord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25609, 1, "EnkilahNecrolord_OnCombat")
RegisterUnitEvent(25609, 2, "EnkilahNecrolord_OnLeaveCombat")
RegisterUnitEvent(25609, 3, "EnkilahNecrolord_OnKilledTarget")
RegisterUnitEvent(25609, 4, "EnkilahNecrolord_OnDied")


--[[ Borean Tundra -- En'kilah Necromancer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function EnkilahNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahNecromancer_Corruption", 10000, 0)
Unit:RegisterEvent("EnkilahNecromancer_ShadowBolt", 7000, 0)
end

function EnkilahNecromancer_Corruption(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32063, pUnit:GetMainTank()) 
end

function EnkilahNecromancer_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function EnkilahNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25378, 1, "EnkilahNecromancer_OnCombat")
RegisterUnitEvent(25378, 2, "EnkilahNecromancer_OnLeaveCombat")
RegisterUnitEvent(25378, 3, "EnkilahNecromancer_OnKilledTarget")
RegisterUnitEvent(25378, 4, "EnkilahNecromancer_OnDied")


--[[ Borean Tundra -- Enraged Tempest.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function EnragedTempest_OnCombat(Unit, Event)
Unit:RegisterEvent("EnragedTempest_Enrage", 10000, 0)
Unit:RegisterEvent("EnragedTempest_Zephyr", 9000, 1)
end

function EnragedTempest_Enrage(pUnit, Event) 
pUnit:CastSpell(50420) 
end

function EnragedTempest_Zephyr(pUnit, Event) 
pUnit:CastSpell(50215) 
end

function EnragedTempest_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnragedTempest_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnragedTempest_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25415, 1, "EnragedTempest_OnCombat")
RegisterUnitEvent(25415, 2, "EnragedTempest_OnLeaveCombat")
RegisterUnitEvent(25415, 3, "EnragedTempest_OnKilledTarget")
RegisterUnitEvent(25415, 4, "EnragedTempest_OnDied")


--[[ Borean Tundra -- Festering Ghoul.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function FesteringGhoul_OnCombat(Unit, Event)
Unit:RegisterEvent("FesteringGhoul_RotArmor", 10000, 0)
end

function FesteringGhoul_RotArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50361, pUnit:GetMainTank()) 
end

function FesteringGhoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FesteringGhoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FesteringGhoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25660, 1, "FesteringGhoul_OnCombat")
RegisterUnitEvent(25660, 2, "FesteringGhoul_OnLeaveCombat")
RegisterUnitEvent(25660, 3, "FesteringGhoul_OnKilledTarget")
RegisterUnitEvent(25660, 4, "FesteringGhoul_OnDied")


--[[ Borean Tundra -- Force-Commander Steeljaw.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ForceCommanderSteeljaw_OnCombat(Unit, Event)
Unit:RegisterEvent("ForceCommanderSteeljaw_Cleave", 6000, 0)
Unit:RegisterEvent("ForceCommanderSteeljaw_PiercingHowl", 10000, 0)
Unit:RegisterEvent("ForceCommanderSteeljaw_SteelJaw", 12000, 0)
Unit:RegisterEvent("ForceCommanderSteeljaw_Whirlwind", 8000, 0)
end

function ForceCommanderSteeljaw_Cleave(pUnit, Event) 
pUnit:CastSpell(15284) 
end

function ForceCommanderSteeljaw_PiercingHowl(pUnit, Event) 
pUnit:CastSpell(38256) 
end

function ForceCommanderSteeljaw_SteelJaw(pUnit, Event) 
pUnit:CastSpell(50204) 
end

function ForceCommanderSteeljaw_Whirlwind(pUnit, Event) 
pUnit:CastSpell(41057) 
end

function ForceCommanderSteeljaw_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForceCommanderSteeljaw_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForceCommanderSteeljaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25359, 1, "ForceCommanderSteeljaw_OnCombat")
RegisterUnitEvent(25359, 2, "ForceCommanderSteeljaw_OnLeaveCombat")
RegisterUnitEvent(25359, 3, "ForceCommanderSteeljaw_OnKilledTarget")
RegisterUnitEvent(25359, 4, "ForceCommanderSteeljaw_OnDied")


--[[ Borean Tundra -- Frozen Elemental.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function FrozenElemental_OnCombat(Unit, Event)
Unit:RegisterEvent("FrozenElemental_IceSpike", 8000, 0)
end

function FrozenElemental_IceSpike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50094, pUnit:GetMainTank()) 
end

function FrozenElemental_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrozenElemental_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrozenElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25715, 1, "FrozenElemental_OnCombat")
RegisterUnitEvent(25715, 2, "FrozenElemental_OnLeaveCombat")
RegisterUnitEvent(25715, 3, "FrozenElemental_OnKilledTarget")
RegisterUnitEvent(25715, 4, "FrozenElemental_OnDied")


--[[ Borean Tundra -- Frozen Sphere.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function FrozenSphere_OnCombat(Unit, Event)
Unit:RegisterEvent("FrozenSphere_IceShard", 6000, 0)
end

function FrozenSphere_IceShard(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50578, pUnit:GetMainTank()) 
end

function FrozenSphere_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrozenSphere_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrozenSphere_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28066, 1, "FrozenSphere_OnCombat")
RegisterUnitEvent(28066, 2, "FrozenSphere_OnLeaveCombat")
RegisterUnitEvent(28066, 3, "FrozenSphere_OnKilledTarget")
RegisterUnitEvent(28066, 4, "FrozenSphere_OnDied")


--[[ Borean Tundra -- Fumblub Gearwind.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function FumblubGearwind_OnCombat(Unit, Event)
Unit:RegisterEvent("FumblubGearwind_MachineGun", 8000, 0)
end

function FumblubGearwind_MachineGun(pUnit, Event) 
pUnit:FullCastSpellOnTarget(60906, pUnit:GetMainTank()) 
end

function FumblubGearwind_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FumblubGearwind_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FumblubGearwind_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32358, 1, "FumblubGearwind_OnCombat")
RegisterUnitEvent(32358, 2, "FumblubGearwind_OnLeaveCombat")
RegisterUnitEvent(32358, 3, "FumblubGearwind_OnKilledTarget")
RegisterUnitEvent(32358, 4, "FumblubGearwind_OnDied")


--[[ Borean Tundra -- Gamel the Cruel.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GameltheCruel_OnCombat(Unit, Event)
Unit:RegisterEvent("GameltheCruel_MortalStrike", 6000, 0)
end

function GameltheCruel_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13737, pUnit:GetMainTank()) 
end

function GameltheCruel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GameltheCruel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GameltheCruel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26449, 1, "GameltheCruel_OnCombat")
RegisterUnitEvent(26449, 2, "GameltheCruel_OnLeaveCombat")
RegisterUnitEvent(26449, 3, "GameltheCruel_OnKilledTarget")
RegisterUnitEvent(26449, 4, "GameltheCruel_OnDied")


--[[ Borean Tundra -- Gammothra the Tormentor.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GammothratheTormentor_OnCombat(Unit, Event)
Unit:RegisterEvent("GammothratheTormentor_MagnataurCharge", 10000, 0)
Unit:RegisterEvent("GammothratheTormentor_TuskStrike", 8000, 0)
end

function GammothratheTormentor_MagnataurCharge(pUnit, Event) 
pUnit:CastSpell(50413) 
end

function GammothratheTormentor_TuskStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50410, pUnit:GetMainTank()) 
end

function GammothratheTormentor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GammothratheTormentor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GammothratheTormentor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25789, 1, "GammothratheTormentor_OnCombat")
RegisterUnitEvent(25789, 2, "GammothratheTormentor_OnLeaveCombat")
RegisterUnitEvent(25789, 3, "GammothratheTormentor_OnKilledTarget")
RegisterUnitEvent(25789, 4, "GammothratheTormentor_OnDied")


--[[ Borean Tundra -- General Cerulean.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GeneralCerulean_OnCombat(Unit, Event)
Unit:RegisterEvent("GeneralCerulean_FrostShock", 7000, 0)
end

function GeneralCerulean_FrostShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15499, pUnit:GetMainTank()) 
end

function GeneralCerulean_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GeneralCerulean_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GeneralCerulean_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25716, 1, "GeneralCerulean_OnCombat")
RegisterUnitEvent(25716, 2, "GeneralCerulean_OnLeaveCombat")
RegisterUnitEvent(25716, 3, "GeneralCerulean_OnKilledTarget")
RegisterUnitEvent(25716, 4, "GeneralCerulean_OnDied")


--[[ Borean Tundra -- Gerald Green.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GeraldGreen_OnCombat(Unit, Event)
Unit:RegisterEvent("GeraldGreen_Cleave", 7000, 0)
end

function GeraldGreen_Cleave(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40504, pUnit:GetMainTank()) 
end

function GeraldGreen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GeraldGreen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GeraldGreen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26083, 1, "GeraldGreen_OnCombat")
RegisterUnitEvent(26083, 2, "GeraldGreen_OnLeaveCombat")
RegisterUnitEvent(26083, 3, "GeraldGreen_OnKilledTarget")
RegisterUnitEvent(26083, 4, "GeraldGreen_OnDied")


--[[ Borean Tundra -- Ghostly Sage.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GhostlySage_OnCombat(Unit, Event)
Unit:RegisterEvent("GhostlySage_Moonfire", 6000, 0)
Unit:RegisterEvent("GhostlySage_Wrath", 8000, 0)
end

function GhostlySage_Moonfire(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15798, pUnit:GetMainTank()) 
end

function GhostlySage_Wrath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9739, pUnit:GetMainTank()) 
end

function GhostlySage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GhostlySage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GhostlySage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25351, 1, "GhostlySage_OnCombat")
RegisterUnitEvent(25351, 2, "GhostlySage_OnLeaveCombat")
RegisterUnitEvent(25351, 3, "GhostlySage_OnKilledTarget")
RegisterUnitEvent(25351, 4, "GhostlySage_OnDied")


--[[ Borean Tundra -- Glacial Ancient.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GlacialAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("GlacialAncient_FrostBreath", 8000, 0)
end

function GlacialAncient_FrostBreath(pUnit, Event) 
pUnit:CastSpell(50505) 
end

function GlacialAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GlacialAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GlacialAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25709, 1, "GlacialAncient_OnCombat")
RegisterUnitEvent(25709, 2, "GlacialAncient_OnLeaveCombat")
RegisterUnitEvent(25709, 3, "GlacialAncient_OnKilledTarget")
RegisterUnitEvent(25709, 4, "GlacialAncient_OnDied")


--[[ Borean Tundra -- Glimmer Bay Orca.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GlimmerBayOrca_OnCombat(Unit, Event)
Unit:RegisterEvent("GlimmerBayOrca_FlipperThwack", 8000, 0)
end

function GlimmerBayOrca_FlipperThwack(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50169, pUnit:GetMainTank()) 
end

function GlimmerBayOrca_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GlimmerBayOrca_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GlimmerBayOrca_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25204, 1, "GlimmerBayOrca_OnCombat")
RegisterUnitEvent(25204, 2, "GlimmerBayOrca_OnLeaveCombat")
RegisterUnitEvent(25204, 3, "GlimmerBayOrca_OnKilledTarget")
RegisterUnitEvent(25204, 4, "GlimmerBayOrca_OnDied")


--[[ Borean Tundra -- Glrggl.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Glrggl_OnCombat(Unit, Event)
Unit:RegisterEvent("Glrggl_FlipperThwack", 8000, 0)
end

function Glrggl_FlipperThwack(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50169, pUnit:GetMainTank()) 
end

function Glrggl_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Glrggl_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Glrggl_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25203, 1, "Glrggl_OnCombat")
RegisterUnitEvent(25203, 2, "Glrggl_OnLeaveCombat")
RegisterUnitEvent(25203, 3, "Glrggl_OnKilledTarget")
RegisterUnitEvent(25203, 4, "Glrggl_OnDied")


--[[ Borean Tundra -- Gorloc Dredger.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GorlocDredger_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocDredger_DeepDredge", 6000, 0)
Unit:RegisterEvent("GorlocDredger_Whirlwind", 9000, 0)
end

function GorlocDredger_DeepDredge(pUnit, Event) 
pUnit:CastSpell(50520) 
end

function GorlocDredger_Whirlwind(pUnit, Event) 
pUnit:CastSpell(15576) 
end

function GorlocDredger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocDredger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocDredger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25701, 1, "GorlocDredger_OnCombat")
RegisterUnitEvent(25701, 2, "GorlocDredger_OnLeaveCombat")
RegisterUnitEvent(25701, 3, "GorlocDredger_OnKilledTarget")
RegisterUnitEvent(25701, 4, "GorlocDredger_OnDied")


--[[ Borean Tundra -- Gorloc Gibberer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GorlocGibberer_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocGibberer_DeepDredge", 6000, 0)
Unit:RegisterEvent("GorlocGibberer_Whirlwind", 9000, 0)
end

function GorlocGibberer_DeepDredge(pUnit, Event) 
pUnit:CastSpell(50520) 
end

function GorlocGibberer_Whirlwind(pUnit, Event) 
pUnit:CastSpell(15576) 
end

function GorlocGibberer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocGibberer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocGibberer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25686, 1, "GorlocGibberer_OnCombat")
RegisterUnitEvent(25686, 2, "GorlocGibberer_OnLeaveCombat")
RegisterUnitEvent(25686, 3, "GorlocGibberer_OnKilledTarget")
RegisterUnitEvent(25686, 4, "GorlocGibberer_OnDied")


--[[ Borean Tundra -- Gorloc Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GorlocHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocHunter_ParalyzingSlime", 7000, 0)
end

function GorlocHunter_ParalyzingSlime(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50523, pUnit:GetMainTank()) 
end

function GorlocHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25700, 1, "GorlocHunter_OnCombat")
RegisterUnitEvent(25700, 2, "GorlocHunter_OnLeaveCombat")
RegisterUnitEvent(25700, 3, "GorlocHunter_OnKilledTarget")
RegisterUnitEvent(25700, 4, "GorlocHunter_OnDied")


--[[ Borean Tundra -- Gorloc Mud Splasher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GorlocMudSplasher_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocMudSplasher_GorlocStomp", 6000, 0)
end

function GorlocMudSplasher_GorlocStomp(pUnit, Event) 
pUnit:CastSpell(50522) 
end

function GorlocMudSplasher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocMudSplasher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocMudSplasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25699, 1, "GorlocMudSplasher_OnCombat")
RegisterUnitEvent(25699, 2, "GorlocMudSplasher_OnLeaveCombat")
RegisterUnitEvent(25699, 3, "GorlocMudSplasher_OnKilledTarget")
RegisterUnitEvent(25699, 4, "GorlocMudSplasher_OnDied")


--[[ Borean Tundra -- Gorloc Steam Belcher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GorlocSteamBelcher_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocSteamBelcher_BelchBlast", 7000, 0)
end

function GorlocSteamBelcher_BelchBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50538, pUnit:GetMainTank()) 
end

function GorlocSteamBelcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocSteamBelcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocSteamBelcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25687, 1, "GorlocSteamBelcher_OnCombat")
RegisterUnitEvent(25687, 2, "GorlocSteamBelcher_OnLeaveCombat")
RegisterUnitEvent(25687, 3, "GorlocSteamBelcher_OnKilledTarget")
RegisterUnitEvent(25687, 4, "GorlocSteamBelcher_OnDied")


--[[ Borean Tundra -- Gorloc Waddler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GorlocWaddler_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocWaddler_GorlocStomp", 7000, 0)
end

function GorlocWaddler_GorlocStomp(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50522, pUnit:GetMainTank()) 
end

function GorlocWaddler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocWaddler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocWaddler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25685, 1, "GorlocWaddler_OnCombat")
RegisterUnitEvent(25685, 2, "GorlocWaddler_OnLeaveCombat")
RegisterUnitEvent(25685, 3, "GorlocWaddler_OnKilledTarget")
RegisterUnitEvent(25685, 4, "GorlocWaddler_OnDied")


--[[ Borean Tundra -- Harold Lane.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function HaroldLane_OnCombat(Unit, Event)
Unit:RegisterEvent("HaroldLane_BearTrap", 2000, 1)
Unit:RegisterEvent("HaroldLane_ThrowBearPelt", 8000, 0)
end

function HaroldLane_BearTrap(pUnit, Event) 
pUnit:CastSpell(53432) 
end

function HaroldLane_ThrowBearPelt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53425, pUnit:GetMainTank()) 
end

function HaroldLane_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HaroldLane_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HaroldLane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25804, 1, "HaroldLane_OnCombat")
RegisterUnitEvent(25804, 2, "HaroldLane_OnLeaveCombat")
RegisterUnitEvent(25804, 3, "HaroldLane_OnKilledTarget")
RegisterUnitEvent(25804, 4, "HaroldLane_OnDied")


--[[ Borean Tundra -- Harvest Collector.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function HarvestCollector_OnCombat(Unit, Event)
Unit:RegisterEvent("HarvestCollector_ClawSlash", 6000, 0)
end

function HarvestCollector_ClawSlash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(54185, pUnit:GetMainTank()) 
end

function HarvestCollector_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HarvestCollector_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HarvestCollector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25623, 1, "HarvestCollector_OnCombat")
RegisterUnitEvent(25623, 2, "HarvestCollector_OnLeaveCombat")
RegisterUnitEvent(25623, 3, "HarvestCollector_OnKilledTarget")
RegisterUnitEvent(25623, 4, "HarvestCollector_OnDied")


--[[ Borean Tundra -- Heigarr the Horrible.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function HeigarrtheHorrible_OnCombat(Unit, Event)
Unit:RegisterEvent("HeigarrtheHorrible_Cleave", 7000, 0)
Unit:RegisterEvent("HeigarrtheHorrible_ConcussionBlow", 9000, 0)
end

function HeigarrtheHorrible_Cleave(pUnit, Event) 
pUnit:CastSpell(40504) 
end

function HeigarrtheHorrible_ConcussionBlow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32588, pUnit:GetMainTank()) 
end

function HeigarrtheHorrible_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HeigarrtheHorrible_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HeigarrtheHorrible_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26266, 1, "HeigarrtheHorrible_OnCombat")
RegisterUnitEvent(26266, 2, "HeigarrtheHorrible_OnLeaveCombat")
RegisterUnitEvent(26266, 3, "HeigarrtheHorrible_OnKilledTarget")
RegisterUnitEvent(26266, 4, "HeigarrtheHorrible_OnDied")


--[[ Borean Tundra -- High Priest Naferset.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function HighPriestNaferset_OnCombat(Unit, Event)
Unit:RegisterEvent("HighPriestNaferset_MindBlast", 6000, 0)
Unit:RegisterEvent("HighPriestNaferset_Renew", 13000, 0)
end

function HighPriestNaferset_MindBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15587, pUnit:GetMainTank()) 
end

function HighPriestNaferset_Renew(pUnit, Event) 
pUnit:CastSpell(11640) 
end

function HighPriestNaferset_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighPriestNaferset_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighPriestNaferset_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26076, 1, "HighPriestNaferset_OnCombat")
RegisterUnitEvent(26076, 2, "HighPriestNaferset_OnLeaveCombat")
RegisterUnitEvent(26076, 3, "HighPriestNaferset_OnKilledTarget")
RegisterUnitEvent(26076, 4, "HighPriestNaferset_OnDied")


--[[ Borean Tundra -- High Priest Talet-Kha.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function HighPriestTaletKha_OnCombat(Unit, Event)
Unit:RegisterEvent("HighPriestTaletKha_MindBlast", 6000, 0)
Unit:RegisterEvent("HighPriestTaletKha_Renew", 13000, 0)
end

function HighPriestTaletKha_MindBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15587, pUnit:GetMainTank()) 
end

function HighPriestTaletKha_Renew(pUnit, Event) 
pUnit:CastSpell(11640) 
end

function HighPriestTaletKha_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighPriestTaletKha_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighPriestTaletKha_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26073, 1, "HighPriestTaletKha_OnCombat")
RegisterUnitEvent(26073, 2, "HighPriestTaletKha_OnLeaveCombat")
RegisterUnitEvent(26073, 3, "HighPriestTaletKha_OnKilledTarget")
RegisterUnitEvent(26073, 4, "HighPriestTaletKha_OnDied")


--[[ Borean Tundra -- Icehorn.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Icehorn_OnCombat(Unit, Event)
Unit:RegisterEvent("Icehorn_Romp", 8000, 0)
end

function Icehorn_Romp(pUnit, Event) 
pUnit:CastSpell(57468) 
end

function Icehorn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icehorn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icehorn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32361, 1, "Icehorn_OnCombat")
RegisterUnitEvent(32361, 2, "Icehorn_OnLeaveCombat")
RegisterUnitEvent(32361, 3, "Icehorn_OnKilledTarget")
RegisterUnitEvent(32361, 4, "Icehorn_OnDied")


--[[ Borean Tundra -- Injured Warsong Engineer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function InjuredWarsongEngineer_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongEngineer_GoblinDragonGun", 8000, 0)
Unit:RegisterEvent("InjuredWarsongEngineer_SuperShrinkRay", 10000, 0)
end

function InjuredWarsongEngineer_GoblinDragonGun(pUnit, Event) 
pUnit:CastSpell(44273) 
end

function InjuredWarsongEngineer_SuperShrinkRay(pUnit, Event) 
pUnit:CastSpell(22742) 
end

function InjuredWarsongEngineer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongEngineer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongEngineer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27110, 1, "InjuredWarsongEngineer_OnCombat")
RegisterUnitEvent(27110, 2, "InjuredWarsongEngineer_OnLeaveCombat")
RegisterUnitEvent(27110, 3, "InjuredWarsongEngineer_OnKilledTarget")
RegisterUnitEvent(27110, 4, "InjuredWarsongEngineer_OnDied")


--[[ Borean Tundra -- Injured Warsong Mage.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function InjuredWarsongMage_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongMage_ArcaneExplosion", 6000, 0)
Unit:RegisterEvent("InjuredWarsongMage_Blizzard", 10000, 0)
Unit:RegisterEvent("InjuredWarsongMage_Pyroblast", 11000, 0)
end

function InjuredWarsongMage_ArcaneExplosion(pUnit, Event) 
pUnit:CastSpell(34933) 
end

function InjuredWarsongMage_Blizzard(pUnit, Event) 
pUnit:CastSpell(46195) 
end

function InjuredWarsongMage_Pyroblast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(17274, pUnit:GetMainTank()) 
end

function InjuredWarsongMage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongMage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27107, 1, "InjuredWarsongMage_OnCombat")
RegisterUnitEvent(27107, 2, "InjuredWarsongMage_OnLeaveCombat")
RegisterUnitEvent(27107, 3, "InjuredWarsongMage_OnKilledTarget")
RegisterUnitEvent(27107, 4, "InjuredWarsongMage_OnDied")


--[[ Borean Tundra -- Injured Warsong Shaman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function InjuredWarsongShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongShaman_ChainLightning", 8000, 0)
Unit:RegisterEvent("InjuredWarsongShaman_EarthShock", 6000, 0)
end

function InjuredWarsongShaman_ChainLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16033, pUnit:GetMainTank()) 
end

function InjuredWarsongShaman_EarthShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25025, pUnit:GetMainTank()) 
end

function InjuredWarsongShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27108, 1, "InjuredWarsongShaman_OnCombat")
RegisterUnitEvent(27108, 2, "InjuredWarsongShaman_OnLeaveCombat")
RegisterUnitEvent(27108, 3, "InjuredWarsongShaman_OnKilledTarget")
RegisterUnitEvent(27108, 4, "InjuredWarsongShaman_OnDied")


--[[ Borean Tundra -- Injured Warsong Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function InjuredWarsongWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredWarsongWarrior_Cleave", 6000, 0)
Unit:RegisterEvent("InjuredWarsongWarrior_HeroicStrike", 7000, 0)
end

function InjuredWarsongWarrior_Cleave(pUnit, Event) 
pUnit:CastSpell(39047) 
end

function InjuredWarsongWarrior_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(45026, pUnit:GetMainTank()) 
end

function InjuredWarsongWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredWarsongWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredWarsongWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27106, 1, "InjuredWarsongWarrior_OnCombat")
RegisterUnitEvent(27106, 2, "InjuredWarsongWarrior_OnLeaveCombat")
RegisterUnitEvent(27106, 3, "InjuredWarsongWarrior_OnKilledTarget")
RegisterUnitEvent(27106, 4, "InjuredWarsongWarrior_OnDied")


--[[ Borean Tundra -- Inquisitor Caleras.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function InquisitorCaleras_OnCombat(Unit, Event)
Unit:RegisterEvent("InquisitorCaleras_FrostNova", 10000, 0)
Unit:RegisterEvent("InquisitorCaleras_Frostbolt", 8000, 0)
end

function InquisitorCaleras_FrostNova(pUnit, Event) 
pUnit:CastSpell(32192) 
end

function InquisitorCaleras_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15043, pUnit:GetMainTank()) 
end

function InquisitorCaleras_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InquisitorCaleras_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InquisitorCaleras_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25720, 1, "InquisitorCaleras_OnCombat")
RegisterUnitEvent(25720, 2, "InquisitorCaleras_OnLeaveCombat")
RegisterUnitEvent(25720, 3, "InquisitorCaleras_OnKilledTarget")
RegisterUnitEvent(25720, 4, "InquisitorCaleras_OnDied")


--[[ Borean Tundra -- Ith'rix the Harvester.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function IthrixtheHarvester_OnCombat(Unit, Event)
Unit:RegisterEvent("IthrixtheHarvester_PoisonStinger", 7000, 0)
Unit:RegisterEvent("IthrixtheHarvester_StingerRage", 9000, 0)
Unit:RegisterEvent("IthrixtheHarvester_VenomSpit", 10000, 0)
end

function IthrixtheHarvester_PoisonStinger(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25748, pUnit:GetMainTank()) 
end

function IthrixtheHarvester_StingerRage(pUnit, Event) 
pUnit:CastSpell(34392) 
end

function IthrixtheHarvester_VenomSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(45592, pUnit:GetMainTank()) 
end

function IthrixtheHarvester_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IthrixtheHarvester_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IthrixtheHarvester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25453, 1, "IthrixtheHarvester_OnCombat")
RegisterUnitEvent(25453, 2, "IthrixtheHarvester_OnLeaveCombat")
RegisterUnitEvent(25453, 3, "IthrixtheHarvester_OnKilledTarget")
RegisterUnitEvent(25453, 4, "IthrixtheHarvester_OnDied")


--[[ Borean Tundra -- Justicar Julia Celeste.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function JusticarJuliaCeleste_OnCombat(Unit, Event)
Unit:RegisterEvent("JusticarJuliaCeleste_HammerofJustice", 10000, 0)
end

function JusticarJuliaCeleste_HammerofJustice(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13005, pUnit:GetMainTank()) 
end

function JusticarJuliaCeleste_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function JusticarJuliaCeleste_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function JusticarJuliaCeleste_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25264, 1, "JusticarJuliaCeleste_OnCombat")
RegisterUnitEvent(25264, 2, "JusticarJuliaCeleste_OnLeaveCombat")
RegisterUnitEvent(25264, 3, "JusticarJuliaCeleste_OnKilledTarget")
RegisterUnitEvent(25264, 4, "JusticarJuliaCeleste_OnDied")


--[[ Borean Tundra -- Kaganishu.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Kaganishu_OnCombat(Unit, Event)
Unit:RegisterEvent("Kaganishu_BlastWave", 9000, 0)
Unit:RegisterEvent("Kaganishu_FireNovaTotem", 2000, 1)
Unit:RegisterEvent("Kaganishu_Fireball", 7000, 0)
end

function Kaganishu_BlastWave(pUnit, Event) 
pUnit:CastSpell(15744) 
end

function Kaganishu_FireNovaTotem(pUnit, Event) 
pUnit:CastSpell(44257) 
end

function Kaganishu_Fireball(pUnit, Event) 
pUnit:FullCastSpellOnTarget(19816, pUnit:GetMainTank()) 
end

function Kaganishu_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Kaganishu_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Kaganishu_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25427, 1, "Kaganishu_OnCombat")
RegisterUnitEvent(25427, 2, "Kaganishu_OnLeaveCombat")
RegisterUnitEvent(25427, 3, "Kaganishu_OnKilledTarget")
RegisterUnitEvent(25427, 4, "Kaganishu_OnDied")


--[[ Borean Tundra -- Karen the Culler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function KarentheCuller_OnCombat(Unit, Event)
Unit:RegisterEvent("KarentheCuller_Cleave", 6000, 0)
Unit:RegisterEvent("KarentheCuller_Intercept", 1000, 1)
Unit:RegisterEvent("KarentheCuller_Whirlwind", 9000, 0)
end

function KarentheCuller_Cleave(pUnit, Event) 
pUnit:CastSpell(42724) 
end

function KarentheCuller_Intercept(pUnit, Event) 
pUnit:FullCastSpellOnTarget(27577, pUnit:GetMainTank()) 
end

function KarentheCuller_Whirlwind(pUnit, Event) 
pUnit:CastSpell(48281) 
end

function KarentheCuller_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KarentheCuller_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KarentheCuller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25803, 1, "KarentheCuller_OnCombat")
RegisterUnitEvent(25803, 2, "KarentheCuller_OnLeaveCombat")
RegisterUnitEvent(25803, 3, "KarentheCuller_OnKilledTarget")
RegisterUnitEvent(25803, 4, "KarentheCuller_OnDied")


--[[ Borean Tundra -- Kel'Thuzad.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function KelThuzad_OnCombat(Unit, Event)
Unit:RegisterEvent("KelThuzad_SoulFlay", 15000, 0)
Unit:RegisterEvent("KelThuzad_UnholyFrenzy", 20000, 0)
end

function KelThuzad_SoulFlay(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50319, pUnit:GetMainTank()) 
end

function KelThuzad_UnholyFrenzy(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50312, pUnit:GetMainTank()) 
end

function KelThuzad_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KelThuzad_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KelThuzad_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25465, 1, "KelThuzad_OnCombat")
RegisterUnitEvent(25465, 2, "KelThuzad_OnLeaveCombat")
RegisterUnitEvent(25465, 3, "KelThuzad_OnKilledTarget")
RegisterUnitEvent(25465, 4, "KelThuzad_OnDied")


--[[ Borean Tundra -- Kvaldir Mist Lord.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function KvaldirMistLord_OnCombat(Unit, Event)
Unit:RegisterEvent("KvaldirMistLord_WaveCrash", 8000, 0)
end

function KvaldirMistLord_WaveCrash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49922, pUnit:GetMainTank()) 
end

function KvaldirMistLord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KvaldirMistLord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KvaldirMistLord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25496, 1, "KvaldirMistLord_OnCombat")
RegisterUnitEvent(25496, 2, "KvaldirMistLord_OnLeaveCombat")
RegisterUnitEvent(25496, 3, "KvaldirMistLord_OnKilledTarget")
RegisterUnitEvent(25496, 4, "KvaldirMistLord_OnDied")


--[[ Borean Tundra -- Kvaldir Mistweaver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function KvaldirMistweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("KvaldirMistweaver_MistofStrangulation", 8000, 0)
end

function KvaldirMistweaver_MistofStrangulation(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49816, pUnit:GetMainTank()) 
end

function KvaldirMistweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KvaldirMistweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KvaldirMistweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25479, 1, "KvaldirMistweaver_OnCombat")
RegisterUnitEvent(25479, 2, "KvaldirMistweaver_OnLeaveCombat")
RegisterUnitEvent(25479, 3, "KvaldirMistweaver_OnKilledTarget")
RegisterUnitEvent(25479, 4, "KvaldirMistweaver_OnDied")


--[[ Borean Tundra -- Landing Crawler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function LandingCrawler_OnCombat(Unit, Event)
Unit:RegisterEvent("LandingCrawler_ClawGrasp", 10000, 0)
end

function LandingCrawler_ClawGrasp(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49978, pUnit:GetMainTank()) 
end

function LandingCrawler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LandingCrawler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LandingCrawler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25481, 1, "LandingCrawler_OnCombat")
RegisterUnitEvent(25481, 2, "LandingCrawler_OnLeaveCombat")
RegisterUnitEvent(25481, 3, "LandingCrawler_OnKilledTarget")
RegisterUnitEvent(25481, 4, "LandingCrawler_OnDied")


--[[ Borean Tundra -- Longrunner Proudhoof.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function LongrunnerProudhoof_OnCombat(Unit, Event)
Unit:RegisterEvent("LongrunnerProudhoof_DemoralizingShout", 2000, 2)
Unit:RegisterEvent("LongrunnerProudhoof_ForcefulCleave", 8000, 0)
end

function LongrunnerProudhoof_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function LongrunnerProudhoof_ForcefulCleave(pUnit, Event) 
pUnit:CastSpell(35473) 
end

function LongrunnerProudhoof_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LongrunnerProudhoof_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LongrunnerProudhoof_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25335, 1, "LongrunnerProudhoof_OnCombat")
RegisterUnitEvent(25335, 2, "LongrunnerProudhoof_OnLeaveCombat")
RegisterUnitEvent(25335, 3, "LongrunnerProudhoof_OnKilledTarget")
RegisterUnitEvent(25335, 4, "LongrunnerProudhoof_OnDied")


--[[ Borean Tundra -- Loot Crazed Diver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function LootCrazedDiver_OnCombat(Unit, Event)
Unit:RegisterEvent("LootCrazedDiver_Crazed", 5000, 1)
end

function LootCrazedDiver_Crazed(pUnit, Event) 
pUnit:CastSpell(5915) 
end

function LootCrazedDiver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LootCrazedDiver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LootCrazedDiver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25836, 1, "LootCrazedDiver_OnCombat")
RegisterUnitEvent(25836, 2, "LootCrazedDiver_OnLeaveCombat")
RegisterUnitEvent(25836, 3, "LootCrazedDiver_OnKilledTarget")
RegisterUnitEvent(25836, 4, "LootCrazedDiver_OnDied")


--[[ Borean Tundra -- Luthion the Vile.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function LuthiontheVile_OnCombat(Unit, Event)
Unit:RegisterEvent("LuthiontheVile_BloodPresence", 4000, 1)
Unit:RegisterEvent("LuthiontheVile_PlagueStrike", 9000, 0)
end

function LuthiontheVile_BloodPresence(pUnit, Event) 
pUnit:CastSpell(50689) 
end

function LuthiontheVile_PlagueStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50688, pUnit:GetMainTank()) 
end

function LuthiontheVile_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LuthiontheVile_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LuthiontheVile_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27860, 1, "LuthiontheVile_OnCombat")
RegisterUnitEvent(27860, 2, "LuthiontheVile_OnLeaveCombat")
RegisterUnitEvent(27860, 3, "LuthiontheVile_OnKilledTarget")
RegisterUnitEvent(27860, 4, "LuthiontheVile_OnDied")


--[[ Borean Tundra -- Magic-bound Ancient.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MagicboundAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("MagicboundAncient_MarkofDetonation", 6000, 0)
end

function MagicboundAncient_MarkofDetonation(pUnit, Event) 
pUnit:CastSpell(50506) 
end

function MagicboundAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagicboundAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagicboundAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25707, 1, "MagicboundAncient_OnCombat")
RegisterUnitEvent(25707, 2, "MagicboundAncient_OnLeaveCombat")
RegisterUnitEvent(25707, 3, "MagicboundAncient_OnKilledTarget")
RegisterUnitEvent(25707, 4, "MagicboundAncient_OnDied")


--[[ Borean Tundra -- Magmoth Crusher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MagmothCrusher_OnCombat(Unit, Event)
Unit:RegisterEvent("MagmothCrusher_MagnataurCharge", 8000, 0)
Unit:RegisterEvent("MagmothCrusher_TuskStrike", 7000, 0)
end

function MagmothCrusher_MagnataurCharge(pUnit, Event) 
pUnit:CastSpell(50413) 
end

function MagmothCrusher_TuskStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50410, pUnit:GetMainTank()) 
end

function MagmothCrusher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagmothCrusher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagmothCrusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25434, 1, "MagmothCrusher_OnCombat")
RegisterUnitEvent(25434, 2, "MagmothCrusher_OnLeaveCombat")
RegisterUnitEvent(25434, 3, "MagmothCrusher_OnKilledTarget")
RegisterUnitEvent(25434, 4, "MagmothCrusher_OnDied")


--[[ Borean Tundra -- Magmothregar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Magmothregar_OnCombat(Unit, Event)
Unit:RegisterEvent("Magmothregar_Fervor", 10000, 0)
Unit:RegisterEvent("Magmothregar_MagnataurCharge", 8000, 0)
end

function Magmothregar_Fervor(pUnit, Event) 
pUnit:CastSpell(50822) 
end

function Magmothregar_MagnataurCharge(pUnit, Event) 
pUnit:CastSpell(50413) 
end

function Magmothregar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Magmothregar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Magmothregar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25430, 1, "Magmothregar_OnCombat")
RegisterUnitEvent(25430, 2, "Magmothregar_OnLeaveCombat")
RegisterUnitEvent(25430, 3, "Magmothregar_OnKilledTarget")
RegisterUnitEvent(25430, 4, "Magmothregar_OnDied")


--[[ Borean Tundra -- Magnataur Huntress.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MagnataurHuntress_OnCombat(Unit, Event)
Unit:RegisterEvent("MagnataurHuntress_TuskStrike", 7000, 0)
Unit:RegisterEvent("MagnataurHuntress_WarStomp", 10000, 0)
end

function MagnataurHuntress_TuskStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50410, pUnit:GetMainTank()) 
end

function MagnataurHuntress_WarStomp(pUnit, Event) 
pUnit:CastSpell(11876) 
end

function MagnataurHuntress_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagnataurHuntress_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagnataurHuntress_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24469, 1, "MagnataurHuntress_OnCombat")
RegisterUnitEvent(24469, 2, "MagnataurHuntress_OnLeaveCombat")
RegisterUnitEvent(24469, 3, "MagnataurHuntress_OnKilledTarget")
RegisterUnitEvent(24469, 4, "MagnataurHuntress_OnDied")


--[[ Borean Tundra -- Mammoth Calf.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MammothCalf_OnCombat(Unit, Event)
Unit:RegisterEvent("MammothCalf_Trample", 6000, 0)
end

function MammothCalf_Trample(pUnit, Event) 
pUnit:CastSpell(15550) 
end

function MammothCalf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MammothCalf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MammothCalf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24613, 1, "MammothCalf_OnCombat")
RegisterUnitEvent(24613, 2, "MammothCalf_OnLeaveCombat")
RegisterUnitEvent(24613, 3, "MammothCalf_OnKilledTarget")
RegisterUnitEvent(24613, 4, "MammothCalf_OnDied")


--[[ Borean Tundra -- Marsh Caribou.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MarshCaribou_OnCombat(Unit, Event)
Unit:RegisterEvent("MarshCaribou_Gore", 8000, 0)
end

function MarshCaribou_Gore(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32019, pUnit:GetMainTank()) 
end

function MarshCaribou_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MarshCaribou_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MarshCaribou_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25680, 1, "MarshCaribou_OnCombat")
RegisterUnitEvent(25680, 2, "MarshCaribou_OnLeaveCombat")
RegisterUnitEvent(25680, 3, "MarshCaribou_OnKilledTarget")
RegisterUnitEvent(25680, 4, "MarshCaribou_OnDied")


--[[ Borean Tundra -- Marsh Fawn.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MarshFawn_OnCombat(Unit, Event)
Unit:RegisterEvent("MarshFawn_Gore", 8000, 0)
end

function MarshFawn_Gore(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32019, pUnit:GetMainTank()) 
end

function MarshFawn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MarshFawn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MarshFawn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25829, 1, "MarshFawn_OnCombat")
RegisterUnitEvent(25829, 2, "MarshFawn_OnLeaveCombat")
RegisterUnitEvent(25829, 3, "MarshFawn_OnKilledTarget")
RegisterUnitEvent(25829, 4, "MarshFawn_OnDied")


--[[ Borean Tundra -- Mate of Magmothregar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MateofMagmothregar_OnCombat(Unit, Event)
Unit:RegisterEvent("MateofMagmothregar_Enrage", 10000, 0)
end

function MateofMagmothregar_Enrage(pUnit, Event) 
pUnit:CastSpell(50420) 
end

function MateofMagmothregar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MateofMagmothregar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MateofMagmothregar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25432, 1, "MateofMagmothregar_OnCombat")
RegisterUnitEvent(25432, 2, "MateofMagmothregar_OnLeaveCombat")
RegisterUnitEvent(25432, 3, "MateofMagmothregar_OnKilledTarget")
RegisterUnitEvent(25432, 4, "MateofMagmothregar_OnDied")


--[[ Borean Tundra -- Minion of Kaw.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function MinionofKaw_OnCombat(Unit, Event)
Unit:RegisterEvent("MinionofKaw_DestructiveStrike", 8000, 0)
end

function MinionofKaw_DestructiveStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51430, pUnit:GetMainTank()) 
end

function MinionofKaw_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MinionofKaw_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MinionofKaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25880, 1, "MinionofKaw_OnCombat")
RegisterUnitEvent(25880, 2, "MinionofKaw_OnLeaveCombat")
RegisterUnitEvent(25880, 3, "MinionofKaw_OnKilledTarget")
RegisterUnitEvent(25880, 4, "MinionofKaw_OnDied")


--[[ Borean Tundra -- Naxxanar Skeletal Mage.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NaxxanarSkeletalMage_OnCombat(Unit, Event)
Unit:RegisterEvent("NaxxanarSkeletalMage_Fireball", 7000, 0)
Unit:RegisterEvent("NaxxanarSkeletalMage_Frostbolt", 10000, 0)
end

function NaxxanarSkeletalMage_Fireball(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9053, pUnit:GetMainTank()) 
end

function NaxxanarSkeletalMage_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9672, pUnit:GetMainTank()) 
end

function NaxxanarSkeletalMage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NaxxanarSkeletalMage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NaxxanarSkeletalMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25396, 1, "NaxxanarSkeletalMage_OnCombat")
RegisterUnitEvent(25396, 2, "NaxxanarSkeletalMage_OnLeaveCombat")
RegisterUnitEvent(25396, 3, "NaxxanarSkeletalMage_OnKilledTarget")
RegisterUnitEvent(25396, 4, "NaxxanarSkeletalMage_OnDied")


--[[ Borean Tundra -- Nedar Lord of Rhinos.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NedarLordofRhinos_OnCombat(Unit, Event)
Unit:RegisterEvent("NedarLordofRhinos_Shoot", 6000, 0)
end

function NedarLordofRhinos_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(41440, pUnit:GetMainTank()) 
end

function NedarLordofRhinos_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NedarLordofRhinos_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NedarLordofRhinos_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25801, 1, "NedarLordofRhinos_OnCombat")
RegisterUnitEvent(25801, 2, "NedarLordofRhinos_OnLeaveCombat")
RegisterUnitEvent(25801, 3, "NedarLordofRhinos_OnKilledTarget")
RegisterUnitEvent(25801, 4, "NedarLordofRhinos_OnDied")


--[[ Borean Tundra -- Nerub'ar Corpse Harvester.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NerubarCorpseHarvester_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarCorpseHarvester_VenomSpit", 8000, 0)
end

function NerubarCorpseHarvester_VenomSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(45577, pUnit:GetMainTank()) 
end

function NerubarCorpseHarvester_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarCorpseHarvester_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarCorpseHarvester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25445, 1, "NerubarCorpseHarvester_OnCombat")
RegisterUnitEvent(25445, 2, "NerubarCorpseHarvester_OnLeaveCombat")
RegisterUnitEvent(25445, 3, "NerubarCorpseHarvester_OnKilledTarget")
RegisterUnitEvent(25445, 4, "NerubarCorpseHarvester_OnDied")


--[[ Borean Tundra -- Nerubar Skitterer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NerubarSkitterer_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarSkitterer_PiercingBlow", 8000, 0)
end

function NerubarSkitterer_PiercingBlow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49749, pUnit:GetMainTank()) 
end

function NerubarSkitterer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarSkitterer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarSkitterer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24566, 1, "NerubarSkitterer_OnCombat")
RegisterUnitEvent(24566, 2, "NerubarSkitterer_OnLeaveCombat")
RegisterUnitEvent(24566, 3, "NerubarSkitterer_OnKilledTarget")
RegisterUnitEvent(24566, 4, "NerubarSkitterer_OnDied")


--[[ Borean Tundra -- Nerubar Sky Darkener.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NerubarSkyDarkener_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarSkyDarkener_VenomSpit", 8000, 0)
Unit:RegisterEvent("NerubarSkyDarkener_WebBolt", 10000, 0)
end

function NerubarSkyDarkener_VenomSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(45577, pUnit:GetMainTank()) 
end

function NerubarSkyDarkener_WebBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(45587, pUnit:GetMainTank()) 
end

function NerubarSkyDarkener_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarSkyDarkener_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarSkyDarkener_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25451, 1, "NerubarSkyDarkener_OnCombat")
RegisterUnitEvent(25451, 2, "NerubarSkyDarkener_OnLeaveCombat")
RegisterUnitEvent(25451, 3, "NerubarSkyDarkener_OnKilledTarget")
RegisterUnitEvent(25451, 4, "NerubarSkyDarkener_OnDied")


--[[ Borean Tundra -- Nerubar Tunneler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NerubarTunneler_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarTunneler_RockShield", 8000, 0)
end

function NerubarTunneler_RockShield(pUnit, Event) 
pUnit:CastSpell(50364) 
end

function NerubarTunneler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarTunneler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarTunneler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25622, 1, "NerubarTunneler_OnCombat")
RegisterUnitEvent(25622, 2, "NerubarTunneler_OnLeaveCombat")
RegisterUnitEvent(25622, 3, "NerubarTunneler_OnKilledTarget")
RegisterUnitEvent(25622, 4, "NerubarTunneler_OnDied")


--[[ Borean Tundra -- Nerubar Venomspitter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NerubarVenomspitter_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarVenomspitter_VenomSpit", 8000, 0)
end

function NerubarVenomspitter_VenomSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(45577, pUnit:GetMainTank()) 
end

function NerubarVenomspitter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarVenomspitter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarVenomspitter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24563, 1, "NerubarVenomspitter_OnCombat")
RegisterUnitEvent(24563, 2, "NerubarVenomspitter_OnLeaveCombat")
RegisterUnitEvent(24563, 3, "NerubarVenomspitter_OnKilledTarget")
RegisterUnitEvent(24563, 4, "NerubarVenomspitter_OnDied")


--[[ Borean Tundra -- Nerub'ar Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NerubarWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarWarrior_Rush", 8000, 0)
end

function NerubarWarrior_Rush(pUnit, Event) 
pUnit:CastSpell(50347) 
end

function NerubarWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25619, 1, "NerubarWarrior_OnCombat")
RegisterUnitEvent(25619, 2, "NerubarWarrior_OnLeaveCombat")
RegisterUnitEvent(25619, 3, "NerubarWarrior_OnKilledTarget")
RegisterUnitEvent(25619, 4, "NerubarWarrior_OnDied")


--[[ Borean Tundra -- Nerubar Web Lord.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NerubarWebLord_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarWebLord_BlindingSwarm", 8000, 0)
end

function NerubarWebLord_BlindingSwarm(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50284, pUnit:GetMainTank()) 
end

function NerubarWebLord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarWebLord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarWebLord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25294, 1, "NerubarWebLord_OnCombat")
RegisterUnitEvent(25294, 2, "NerubarWebLord_OnLeaveCombat")
RegisterUnitEvent(25294, 3, "NerubarWebLord_OnKilledTarget")
RegisterUnitEvent(25294, 4, "NerubarWebLord_OnDied")


--[[ Borean Tundra -- Nexus Drake Hatchling.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NexusDrakeHatchling_OnCombat(Unit, Event)
Unit:RegisterEvent("NexusDrakeHatchling_IntangiblePresence", 10000, 0)
Unit:RegisterEvent("NexusDrakeHatchling_Netherbreath", 7500, 0)
end

function NexusDrakeHatchling_IntangiblePresence(pUnit, Event) 
pUnit:CastSpell(36513) 
end

function NexusDrakeHatchling_Netherbreath(pUnit, Event) 
pUnit:CastSpell(36631) 
end

function NexusDrakeHatchling_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NexusDrakeHatchling_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NexusDrakeHatchling_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26127, 1, "NexusDrakeHatchling_OnCombat")
RegisterUnitEvent(26127, 2, "NexusDrakeHatchling_OnLeaveCombat")
RegisterUnitEvent(26127, 3, "NexusDrakeHatchling_OnKilledTarget")
RegisterUnitEvent(26127, 4, "NexusDrakeHatchling_OnDied")


--[[ Borean Tundra -- Nexus Watcher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NexusWatcher_OnCombat(Unit, Event)
Unit:RegisterEvent("NexusWatcher_IntangiblePresence", 10000, 0)
Unit:RegisterEvent("NexusWatcher_Netherbreath", 7500, 0)
end

function NexusWatcher_IntangiblePresence(pUnit, Event) 
pUnit:CastSpell(36513) 
end

function NexusWatcher_Netherbreath(pUnit, Event) 
pUnit:CastSpell(36631) 
end

function NexusWatcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NexusWatcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NexusWatcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24770, 1, "NexusWatcher_OnCombat")
RegisterUnitEvent(24770, 2, "NexusWatcher_OnLeaveCombat")
RegisterUnitEvent(24770, 3, "NexusWatcher_OnKilledTarget")
RegisterUnitEvent(24770, 4, "NexusWatcher_OnDied")


--[[ Borean Tundra -- Northsea Mercenary.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NorthseaMercenary_OnCombat(Unit, Event)
Unit:RegisterEvent("NorthseaMercenary_Crazed", 5000, 1)
end

function NorthseaMercenary_Crazed(pUnit, Event) 
pUnit:CastSpell(5915) 
end

function NorthseaMercenary_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NorthseaMercenary_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NorthseaMercenary_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25839, 1, "NorthseaMercenary_OnCombat")
RegisterUnitEvent(25839, 2, "NorthseaMercenary_OnLeaveCombat")
RegisterUnitEvent(25839, 3, "NorthseaMercenary_OnKilledTarget")
RegisterUnitEvent(25839, 4, "NorthseaMercenary_OnDied")


--[[ Borean Tundra -- Northsea Thug.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function NorthseaThug_OnCombat(Unit, Event)
Unit:RegisterEvent("NorthseaThug_Crazed", 5000, 1)
end

function NorthseaThug_Crazed(pUnit, Event) 
pUnit:CastSpell(5915) 
end

function NorthseaThug_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NorthseaThug_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NorthseaThug_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25843, 1, "NorthseaThug_OnCombat")
RegisterUnitEvent(25843, 2, "NorthseaThug_OnLeaveCombat")
RegisterUnitEvent(25843, 3, "NorthseaThug_OnKilledTarget")
RegisterUnitEvent(25843, 4, "NorthseaThug_OnDied")


--[[ Borean Tundra -- Old Crystalbark.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function OldCrystalbark_OnCombat(Unit, Event)
Unit:RegisterEvent("OldCrystalbark_ArcaneBreath", 8000, 0)
Unit:RegisterEvent("OldCrystalbark_MarkofDetonation", 6000, 0)
end

function OldCrystalbark_ArcaneBreath(pUnit, Event) 
pUnit:CastSpell(60903) 
end

function OldCrystalbark_MarkofDetonation(pUnit, Event) 
pUnit:CastSpell(50506) 
end

function OldCrystalbark_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OldCrystalbark_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OldCrystalbark_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32357, 1, "OldCrystalbark_OnCombat")
RegisterUnitEvent(32357, 2, "OldCrystalbark_OnLeaveCombat")
RegisterUnitEvent(32357, 3, "OldCrystalbark_OnKilledTarget")
RegisterUnitEvent(32357, 4, "OldCrystalbark_OnDied")


--[[ Borean Tundra -- Plagued Magnataur.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function PlaguedMagnataur_OnCombat(Unit, Event)
Unit:RegisterEvent("PlaguedMagnataur_PlagueCloud", 2000, 2)
end

function PlaguedMagnataur_PlagueCloud(pUnit, Event) 
pUnit:CastSpell(50366) 
end

function PlaguedMagnataur_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PlaguedMagnataur_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PlaguedMagnataur_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25615, 1, "PlaguedMagnataur_OnCombat")
RegisterUnitEvent(25615, 2, "PlaguedMagnataur_OnLeaveCombat")
RegisterUnitEvent(25615, 3, "PlaguedMagnataur_OnKilledTarget")
RegisterUnitEvent(25615, 4, "PlaguedMagnataur_OnDied")


--[[ Borean Tundra -- Plagued Scavenger.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function PlaguedScavengerr_OnCombat(Unit, Event)
Unit:RegisterEvent("PlaguedScavengerr_InfectedBite", 10000, 0)
end

function PlaguedScavengerr_InfectedBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49861, pUnit:GetMainTank()) 
end

function PlaguedScavengerr_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PlaguedScavengerr_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PlaguedScavengerr_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25650, 1, "PlaguedScavengerr_OnCombat")
RegisterUnitEvent(25650, 2, "PlaguedScavengerr_OnLeaveCombat")
RegisterUnitEvent(25650, 3, "PlaguedScavengerr_OnKilledTarget")
RegisterUnitEvent(25650, 4, "PlaguedScavengerr_OnDied")


--[[ Borean Tundra -- Raging Boiler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function RagingBoiler_OnCombat(Unit, Event)
Unit:RegisterEvent("RagingBoiler_BoilingBlood", 8000, 0)
end

function RagingBoiler_BoilingBlood(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50207, pUnit:GetMainTank()) 
end

function RagingBoiler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RagingBoiler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RagingBoiler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25417, 1, "RagingBoiler_OnCombat")
RegisterUnitEvent(25417, 2, "RagingBoiler_OnLeaveCombat")
RegisterUnitEvent(25417, 3, "RagingBoiler_OnKilledTarget")
RegisterUnitEvent(25417, 4, "RagingBoiler_OnDied")


--[[ Borean Tundra -- Ragnar Drakkarlund.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function RagnarDrakkarlund_OnCombat(Unit, Event)
Unit:RegisterEvent("RagnarDrakkarlund_Whirlwind", 8000, 0)
end

function RagnarDrakkarlund_Whirlwind(pUnit, Event) 
pUnit:CastSpell(41057) 
end

function RagnarDrakkarlund_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RagnarDrakkarlund_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RagnarDrakkarlund_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26451, 1, "RagnarDrakkarlund_OnCombat")
RegisterUnitEvent(26451, 2, "RagnarDrakkarlund_OnLeaveCombat")
RegisterUnitEvent(26451, 3, "RagnarDrakkarlund_OnKilledTarget")
RegisterUnitEvent(26451, 4, "RagnarDrakkarlund_OnDied")


--[[ Borean Tundra -- Rig Hauler AC-9.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function RigHaulerAC9_OnCombat(Unit, Event)
Unit:RegisterEvent("RigHaulerAC9_CrowdPummel", 10000, 0)
end

function RigHaulerAC9_CrowdPummel(pUnit, Event) 
pUnit:CastSpell(10887) 
end

function RigHaulerAC9_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RigHaulerAC9_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RigHaulerAC9_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25766, 1, "RigHaulerAC9_OnCombat")
RegisterUnitEvent(25766, 2, "RigHaulerAC9_OnLeaveCombat")
RegisterUnitEvent(25766, 3, "RigHaulerAC9_OnKilledTarget")
RegisterUnitEvent(25766, 4, "RigHaulerAC9_OnDied")


--[[ Borean Tundra -- Risen Longrunner.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function RisenLongrunner_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenLongrunner_GhostStrike", 8000, 0)
end

function RisenLongrunner_GhostStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36093, pUnit:GetMainTank()) 
end

function RisenLongrunner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenLongrunner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenLongrunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25350, 1, "RisenLongrunner_OnCombat")
RegisterUnitEvent(25350, 2, "RisenLongrunner_OnLeaveCombat")
RegisterUnitEvent(25350, 3, "RisenLongrunner_OnKilledTarget")
RegisterUnitEvent(25350, 4, "RisenLongrunner_OnDied")


--[[ Borean Tundra -- Rockfang.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Rockfang_OnCombat(Unit, Event)
Unit:RegisterEvent("Rockfang_ChillingHowl", 10000, 0)
end

function Rockfang_ChillingHowl(pUnit, Event) 
pUnit:CastSpell(32918) 
end

function Rockfang_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Rockfang_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Rockfang_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25774, 1, "Rockfang_OnCombat")
RegisterUnitEvent(25774, 2, "Rockfang_OnLeaveCombat")
RegisterUnitEvent(25774, 3, "Rockfang_OnKilledTarget")
RegisterUnitEvent(25774, 4, "Rockfang_OnDied")


--[[ Borean Tundra -- Rocknar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Rocknar_OnCombat(Unit, Event)
Unit:RegisterEvent("Rocknar_HardenSkin", 2000, 1)
Unit:RegisterEvent("Rocknar_IceSpike", 8000, 0)
end

function Rocknar_HardenSkin(pUnit, Event) 
pUnit:CastSpell(22693) 
end

function Rocknar_IceSpike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50094, pUnit:GetMainTank()) 
end

function Rocknar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Rocknar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Rocknar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25514, 1, "Rocknar_OnCombat")
RegisterUnitEvent(25514, 2, "Rocknar_OnLeaveCombat")
RegisterUnitEvent(25514, 3, "Rocknar_OnKilledTarget")
RegisterUnitEvent(25514, 4, "Rocknar_OnDied")


--[[ Borean Tundra -- Scalder.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Scalder_OnCombat(Unit, Event)
Unit:RegisterEvent("Scalder_ScaldingBlast", 8000, 0)
Unit:RegisterEvent("Scalder_WaterBolt", 5500, 0)
end

function Scalder_ScaldingBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50257, pUnit:GetMainTank()) 
end

function Scalder_WaterBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32011, pUnit:GetMainTank()) 
end

function Scalder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Scalder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Scalder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25226, 1, "Scalder_OnCombat")
RegisterUnitEvent(25226, 2, "Scalder_OnLeaveCombat")
RegisterUnitEvent(25226, 3, "Scalder_OnKilledTarget")
RegisterUnitEvent(25226, 4, "Scalder_OnDied")


--[[ Borean Tundra -- Scalesworn Elite.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ScaleswornElite_OnCombat(Unit, Event)
Unit:RegisterEvent("ScaleswornElite_ArcaneSurge", 15000, 0)
Unit:RegisterEvent("ScaleswornElite_IceShard", 10000, 0)
end

function ScaleswornElite_ArcaneSurge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(61272, pUnit:GetMainTank()) 
end

function ScaleswornElite_IceShard(pUnit, Event) 
pUnit:FullCastSpellOnTarget(61269, pUnit:GetMainTank()) 
end

function ScaleswornElite_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScaleswornElite_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScaleswornElite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32534, 1, "ScaleswornElite_OnCombat")
RegisterUnitEvent(32534, 2, "ScaleswornElite_OnLeaveCombat")
RegisterUnitEvent(32534, 3, "ScaleswornElite_OnKilledTarget")
RegisterUnitEvent(32534, 4, "ScaleswornElite_OnDied")


--[[ Borean Tundra -- Scavengebot 004A8.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Scavengebot004A8_OnCombat(Unit, Event)
Unit:RegisterEvent("Scavengebot004A8_CuttingLaser", 7000, 0)
end

function Scavengebot004A8_CuttingLaser(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49945, pUnit:GetMainTank()) 
end

function Scavengebot004A8_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Scavengebot004A8_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Scavengebot004A8_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25752, 1, "Scavengebot004A8_OnCombat")
RegisterUnitEvent(25752, 2, "Scavengebot004A8_OnLeaveCombat")
RegisterUnitEvent(25752, 3, "Scavengebot004A8_OnKilledTarget")
RegisterUnitEvent(25752, 4, "Scavengebot004A8_OnDied")


--[[ Borean Tundra -- Scavengebot 005B6.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Scavengebot005B6_OnCombat(Unit, Event)
Unit:RegisterEvent("Scavengebot005B6_CuttingLaser", 7000, 0)
end

function Scavengebot005B6_CuttingLaser(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49945, pUnit:GetMainTank()) 
end

function Scavengebot005B6_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Scavengebot005B6_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Scavengebot005B6_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25792, 1, "Scavengebot005B6_OnCombat")
RegisterUnitEvent(25792, 2, "Scavengebot005B6_OnLeaveCombat")
RegisterUnitEvent(25792, 3, "Scavengebot005B6_OnKilledTarget")
RegisterUnitEvent(25792, 4, "Scavengebot005B6_OnDied")


--[[ Borean Tundra -- Scourged Flamespitter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ScourgedFlamespitter_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgedFlamespitter_Incinerate", 7000, 0)
end

function ScourgedFlamespitter_Incinerate(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32707, pUnit:GetMainTank()) 
end

function ScourgedFlamespitter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgedFlamespitter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgedFlamespitter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25582, 1, "ScourgedFlamespitter_OnCombat")
RegisterUnitEvent(25582, 2, "ScourgedFlamespitter_OnLeaveCombat")
RegisterUnitEvent(25582, 3, "ScourgedFlamespitter_OnKilledTarget")
RegisterUnitEvent(25582, 4, "ScourgedFlamespitter_OnDied")


--[[ Borean Tundra -- Scourged Footman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ScourgedFootman_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgedFootman_BladeFlurry", 10000, 0)
Unit:RegisterEvent("ScourgedFootman_MortalStrike", 8000, 0)
end

function ScourgedFootman_BladeFlurry(pUnit, Event) 
pUnit:CastSpell(33735) 
end

function ScourgedFootman_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32736, pUnit:GetMainTank()) 
end

function ScourgedFootman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgedFootman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgedFootman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25981, 1, "ScourgedFootman_OnCombat")
RegisterUnitEvent(25981, 2, "ScourgedFootman_OnLeaveCombat")
RegisterUnitEvent(25981, 3, "ScourgedFootman_OnKilledTarget")
RegisterUnitEvent(25981, 4, "ScourgedFootman_OnDied")


--[[ Borean Tundra -- Scourged Mammoth.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ScourgedMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgedMammoth_Trample", 6000, 0)
end

function ScourgedMammoth_Trample(pUnit, Event) 
pUnit:CastSpell(15550) 
end

function ScourgedMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgedMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgedMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25452, 1, "ScourgedMammoth_OnCombat")
RegisterUnitEvent(25452, 2, "ScourgedMammoth_OnLeaveCombat")
RegisterUnitEvent(25452, 3, "ScourgedMammoth_OnKilledTarget")
RegisterUnitEvent(25452, 4, "ScourgedMammoth_OnDied")


--[[ Borean Tundra -- Scourged Mammoth.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ScoutTungok_OnCombat(Unit, Event)
Unit:RegisterEvent("ScoutTungok_Enrage", 10000, 0)
end

function ScoutTungok_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function ScoutTungok_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScoutTungok_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScoutTungok_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25440, 1, "ScoutTungok_OnCombat")
RegisterUnitEvent(25440, 2, "ScoutTungok_OnLeaveCombat")
RegisterUnitEvent(25440, 3, "ScoutTungok_OnKilledTarget")
RegisterUnitEvent(25440, 4, "ScoutTungok_OnDied")


--[[ Borean Tundra -- Skadir Mariner.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SkadirMariner_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirMariner_DemoralizingShout", 2000, 2)
Unit:RegisterEvent("SkadirMariner_Uppercut", 8000, 0)
end

function SkadirMariner_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function SkadirMariner_Uppercut(pUnit, Event)
pUnit:FullCastSpellOnTarget(10966, pUnit:GetMainTank())
end

function SkadirMariner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirMariner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirMariner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25523, 1, "SkadirMariner_OnCombat")
RegisterUnitEvent(25523, 2, "SkadirMariner_OnLeaveCombat")
RegisterUnitEvent(25523, 3, "SkadirMariner_OnKilledTarget")
RegisterUnitEvent(25523, 4, "SkadirMariner_OnDied")


--[[ Borean Tundra -- Skadir Mistweaver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SkadirMistweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirMistweaver_MistofStrangulation", 8000, 0)
end

function SkadirMistweaver_MistofStrangulation(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49816, pUnit:GetMainTank()) 
end

function SkadirMistweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirMistweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirMistweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25613, 1, "SkadirMistweaver_OnCombat")
RegisterUnitEvent(25613, 2, "SkadirMistweaver_OnLeaveCombat")
RegisterUnitEvent(25613, 3, "SkadirMistweaver_OnKilledTarget")
RegisterUnitEvent(25613, 4, "SkadirMistweaver_OnDied")


--[[ Borean Tundra -- Skadir Raider.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SkadirRaider_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirRaider_FreezingTrap", 1000, 1)
Unit:RegisterEvent("SkadirRaider_ThrowSpear", 6000, 0)
end

function SkadirRaider_FreezingTrap(pUnit, Event) 
pUnit:CastSpell(43414) 
end

function SkadirRaider_ThrowSpear(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43413, pUnit:GetMainTank()) 
end

function SkadirRaider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirRaider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirRaider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25522, 1, "SkadirRaider_OnCombat")
RegisterUnitEvent(25522, 2, "SkadirRaider_OnLeaveCombat")
RegisterUnitEvent(25522, 3, "SkadirRaider_OnKilledTarget")
RegisterUnitEvent(25522, 4, "SkadirRaider_OnDied")


--[[ Borean Tundra -- Skadir Runecaster.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SkadirRunecaster_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirRunecaster_LightningBolt", 8000, 0)
Unit:RegisterEvent("SkadirRunecaster_RuneofRetribution", 2000, 2)
end

function SkadirRunecaster_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9532, pUnit:GetMainTank()) 
end

function SkadirRunecaster_RuneofRetribution(pUnit, Event) 
pUnit:CastSpell(49871, pUnit:GetMainTank()) 
end

function SkadirRunecaster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirRunecaster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirRunecaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25520, 1, "SkadirRunecaster_OnCombat")
RegisterUnitEvent(25520, 2, "SkadirRunecaster_OnLeaveCombat")
RegisterUnitEvent(25520, 3, "SkadirRunecaster_OnKilledTarget")
RegisterUnitEvent(25520, 4, "SkadirRunecaster_OnDied")


--[[ Borean Tundra -- Snow Tracker Haloke.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SnowTrackerHaloke_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowTrackerHaloke_Shoot", 6000, 0)
end

function SnowTrackerHaloke_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SnowTrackerHaloke_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowTrackerHaloke_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowTrackerHaloke_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26768, 1, "SnowTrackerHaloke_OnCombat")
RegisterUnitEvent(26768, 2, "SnowTrackerHaloke_OnLeaveCombat")
RegisterUnitEvent(26768, 3, "SnowTrackerHaloke_OnKilledTarget")
RegisterUnitEvent(26768, 4, "SnowTrackerHaloke_OnDied")


--[[ Borean Tundra -- Steam Rager.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SteamRager_OnCombat(Unit, Event)
Unit:RegisterEvent("SteamRager_SteamBlast", 8000, 0)
end

function SteamRager_SteamBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50375, pUnit:GetMainTank()) 
end

function SteamRager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SteamRager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SteamRager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24601, 1, "SteamRager_OnCombat")
RegisterUnitEvent(24601, 2, "SteamRager_OnLeaveCombat")
RegisterUnitEvent(24601, 3, "SteamRager_OnKilledTarget")
RegisterUnitEvent(24601, 4, "SteamRager_OnDied")


--[[ Borean Tundra -- Storm Tempest.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function StormTempest_OnCombat(Unit, Event)
Unit:RegisterEvent("StormTempest_ChainLightning", 8000, 0)
Unit:RegisterEvent("StormTempest_WindShock", 6000, 0)
end

function StormTempest_ChainLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15659, pUnit:GetMainTank()) 
end

function StormTempest_WindShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(31272, pUnit:GetMainTank()) 
end

function StormTempest_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function StormTempest_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function StormTempest_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26045, 1, "StormTempest_OnCombat")
RegisterUnitEvent(26045, 2, "StormTempest_OnLeaveCombat")
RegisterUnitEvent(26045, 3, "StormTempest_OnKilledTarget")
RegisterUnitEvent(26045, 4, "StormTempest_OnDied")


--[[ Borean Tundra -- Talramas Abomination.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function TalramasAbomination_OnCombat(Unit, Event)
Unit:RegisterEvent("TalramasAbomination_PlagueCloud", 2000, 2)
end

function TalramasAbomination_PlagueCloud(pUnit, Event) 
pUnit:CastSpell(50366) 
end

function TalramasAbomination_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TalramasAbomination_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TalramasAbomination_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25684, 1, "TalramasAbomination_OnCombat")
RegisterUnitEvent(25684, 2, "TalramasAbomination_OnLeaveCombat")
RegisterUnitEvent(25684, 3, "TalramasAbomination_OnKilledTarget")
RegisterUnitEvent(25684, 4, "TalramasAbomination_OnDied")


--[[ Borean Tundra -- Taunkale Brave.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function TaunkaleBrave_OnCombat(Unit, Event)
Unit:RegisterEvent("TaunkaleBrave_GroundSlam", 8000, 0)
end

function TaunkaleBrave_GroundSlam(pUnit, Event) 
pUnit:CastSpell(52058) 
end

function TaunkaleBrave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TaunkaleBrave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TaunkaleBrave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26157, 1, "TaunkaleBrave_OnCombat")
RegisterUnitEvent(26157, 2, "TaunkaleBrave_OnLeaveCombat")
RegisterUnitEvent(26157, 3, "TaunkaleBrave_OnKilledTarget")
RegisterUnitEvent(26157, 4, "TaunkaleBrave_OnDied")


--[[ Borean Tundra -- Thassarian.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function Thassarian_OnCombat(Unit, Event)
Unit:RegisterEvent("Thassarian_EmpoweredBloodPresence", 1000, 1)
end

function Thassarian_EmpoweredBloodPresence(pUnit, Event) 
pUnit:CastSpell(50995) 
end

function Thassarian_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Thassarian_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Thassarian_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26170, 1, "Thassarian_OnCombat")
RegisterUnitEvent(26170, 2, "Thassarian_OnLeaveCombat")
RegisterUnitEvent(26170, 3, "Thassarian_OnKilledTarget")
RegisterUnitEvent(26170, 4, "Thassarian_OnDied")


--[[ Borean Tundra -- Tundra Wolf.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function TundraWolf_OnCombat(Unit, Event)
Unit:RegisterEvent("TundraWolf_InfectedBite", 8000, 0)
end

function TundraWolf_InfectedBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(7367, pUnit:GetMainTank()) 
end

function TundraWolf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TundraWolf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TundraWolf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25675, 1, "TundraWolf_OnCombat")
RegisterUnitEvent(25675, 2, "TundraWolf_OnLeaveCombat")
RegisterUnitEvent(25675, 3, "TundraWolf_OnKilledTarget")
RegisterUnitEvent(25675, 4, "TundraWolf_OnDied")


--[[ Borean Tundra -- Unliving Swine.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function UnlivingSwine_OnCombat(Unit, Event)
Unit:RegisterEvent("UnlivingSwine_SwineFlu", 8000, 0)
end

function UnlivingSwine_SwineFlu(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50303, pUnit:GetMainTank()) 
end

function UnlivingSwine_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnlivingSwine_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnlivingSwine_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25600, 1, "UnlivingSwine_OnCombat")
RegisterUnitEvent(25600, 2, "UnlivingSwine_OnLeaveCombat")
RegisterUnitEvent(25600, 3, "UnlivingSwine_OnKilledTarget")
RegisterUnitEvent(25600, 4, "UnlivingSwine_OnDied")


--[[ Borean Tundra -- Varidus the Flenser.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function VaridustheFlenser_OnCombat(Unit, Event)
Unit:RegisterEvent("VaridustheFlenser_ShadowNova", 6000, 0)
Unit:RegisterEvent("VaridustheFlenser_ShieldofSuffering", 4000, 1)
end

function VaridustheFlenser_ShadowNova(pUnit, Event) 
pUnit:CastSpell(32711) 
end

function VaridustheFlenser_ShieldofSuffering(pUnit, Event) 
pUnit:CastSpell(50329) 
end

function VaridustheFlenser_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VaridustheFlenser_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VaridustheFlenser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25618, 1, "VaridustheFlenser_OnCombat")
RegisterUnitEvent(25618, 2, "VaridustheFlenser_OnLeaveCombat")
RegisterUnitEvent(25618, 3, "VaridustheFlenser_OnKilledTarget")
RegisterUnitEvent(25618, 4, "VaridustheFlenser_OnDied")


--[[ Borean Tundra -- Warbringer Goredrak.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WarbringerGoredrak_OnCombat(Unit, Event)
Unit:RegisterEvent("WarbringerGoredrak_ArcaneBlast", 8000, 0)
Unit:RegisterEvent("WarbringerGoredrak_PowerSap", 10000, 0)
end

function WarbringerGoredrak_ArcaneBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50545, pUnit:GetMainTank()) 
end

function WarbringerGoredrak_PowerSap(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50534, pUnit:GetMainTank()) 
end

function WarbringerGoredrak_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarbringerGoredrak_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarbringerGoredrak_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25712, 1, "WarbringerGoredrak_OnCombat")
RegisterUnitEvent(25712, 2, "WarbringerGoredrak_OnLeaveCombat")
RegisterUnitEvent(25712, 3, "WarbringerGoredrak_OnKilledTarget")
RegisterUnitEvent(25712, 4, "WarbringerGoredrak_OnDied")


--[[ Borean Tundra -- Warsong Battleguard.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WarsongBattleguard_OnCombat(Unit, Event)
Unit:RegisterEvent("WarsongBattleguard_Enrage", 10000, 0)
end

function WarsongBattleguard_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function WarsongBattleguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarsongBattleguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarsongBattleguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25242, 1, "WarsongBattleguard_OnCombat")
RegisterUnitEvent(25242, 2, "WarsongBattleguard_OnLeaveCombat")
RegisterUnitEvent(25242, 3, "WarsongBattleguard_OnKilledTarget")
RegisterUnitEvent(25242, 4, "WarsongBattleguard_OnDied")


--[[ Borean Tundra -- Warsong Marksman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WarsongMarksman_OnCombat(Unit, Event)
Unit:RegisterEvent("WarsongMarksman_Enrage", 8000, 0)
Unit:RegisterEvent("WarsongMarksman_Shoot", 6000, 0)
end

function WarsongMarksman_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function WarsongMarksman_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(45578, pUnit:GetMainTank()) 
end

function WarsongMarksman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarsongMarksman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarsongMarksman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25244, 1, "WarsongMarksman_OnCombat")
RegisterUnitEvent(25244, 2, "WarsongMarksman_OnLeaveCombat")
RegisterUnitEvent(25244, 3, "WarsongMarksman_OnKilledTarget")
RegisterUnitEvent(25244, 4, "WarsongMarksman_OnDied")


--[[ Borean Tundra -- Winterfin Oracle.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WinterfinOracle_OnCombat(Unit, Event)
Unit:RegisterEvent("WinterfinOracle_LightningBolt", 8000, 0)
Unit:RegisterEvent("WinterfinOracle_UnstableMagic", 2000, 1)
end

function WinterfinOracle_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9532, pUnit:GetMainTank()) 
end

function WinterfinOracle_UnstableMagic(pUnit, Event) 
pUnit:CastSpell(50272) 
end

function WinterfinOracle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WinterfinOracle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WinterfinOracle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25216, 1, "WinterfinOracle_OnCombat")
RegisterUnitEvent(25216, 2, "WinterfinOracle_OnLeaveCombat")
RegisterUnitEvent(25216, 3, "WinterfinOracle_OnKilledTarget")
RegisterUnitEvent(25216, 4, "WinterfinOracle_OnDied")


--[[ Borean Tundra -- Winterfin Shorestriker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WinterfinShorestriker_OnCombat(Unit, Event)
Unit:RegisterEvent("WinterfinShorestriker_RushedAssault", 7000, 0)
end

function WinterfinShorestriker_RushedAssault(pUnit, Event) 
pUnit:CastSpell(50262) 
end

function WinterfinShorestriker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WinterfinShorestriker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WinterfinShorestriker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25215, 1, "WinterfinShorestriker_OnCombat")
RegisterUnitEvent(25215, 2, "WinterfinShorestriker_OnLeaveCombat")
RegisterUnitEvent(25215, 3, "WinterfinShorestriker_OnKilledTarget")
RegisterUnitEvent(25215, 4, "WinterfinShorestriker_OnDied")


--[[ Borean Tundra -- Winterfin Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WinterfinWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("WinterfinWarrior_DemoralizingMmmrrrggglll", 8000, 0)
end

function WinterfinWarrior_DemoralizingMmmrrrggglll(pUnit, Event) 
pUnit:CastSpell(50267) 
end

function WinterfinWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WinterfinWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WinterfinWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25217, 1, "WinterfinWarrior_OnCombat")
RegisterUnitEvent(25217, 2, "WinterfinWarrior_OnLeaveCombat")
RegisterUnitEvent(25217, 3, "WinterfinWarrior_OnKilledTarget")
RegisterUnitEvent(25217, 4, "WinterfinWarrior_OnDied")


--[[ Borean Tundra -- Wooly Mammoth.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WoolyMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("WoolyMammoth_Trample", 6000, 0)
end

function WoolyMammoth_Trample(pUnit, Event) 
pUnit:CastSpell(15550) 
end

function WoolyMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoolyMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoolyMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24614, 1, "WoolyMammoth_OnCombat")
RegisterUnitEvent(24614, 2, "WoolyMammoth_OnLeaveCombat")
RegisterUnitEvent(24614, 3, "WoolyMammoth_OnKilledTarget")
RegisterUnitEvent(24614, 4, "WoolyMammoth_OnDied")


--[[ Borean Tundra -- Wooly Rhino Matriarch.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WoolyRhinoMatriarch_OnCombat(Unit, Event)
Unit:RegisterEvent("WoolyRhinoMatriarch_ThickHide", 4000, 1)
end

function WoolyRhinoMatriarch_ThickHide(pUnit, Event) 
pUnit:CastSpell(50502) 
end

function WoolyRhinoMatriarch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoolyRhinoMatriarch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoolyRhinoMatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25487, 1, "WoolyRhinoMatriarch_OnCombat")
RegisterUnitEvent(25487, 2, "WoolyRhinoMatriarch_OnLeaveCombat")
RegisterUnitEvent(25487, 3, "WoolyRhinoMatriarch_OnKilledTarget")
RegisterUnitEvent(25487, 4, "WoolyRhinoMatriarch_OnDied")


--[[ Borean Tundra -- Wooly Rhino Bull.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function WoolyRhinoBull_OnCombat(Unit, Event)
Unit:RegisterEvent("WoolyRhinoBull_ThickHide", 4000, 1)
end

function WoolyRhinoBull_ThickHide(pUnit, Event) 
pUnit:CastSpell(50502) 
end

function WoolyRhinoBull_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoolyRhinoBull_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoolyRhinoBull_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25489, 1, "WoolyRhinoBull_OnCombat")
RegisterUnitEvent(25489, 2, "WoolyRhinoBull_OnLeaveCombat")
RegisterUnitEvent(25489, 3, "WoolyRhinoBull_OnKilledTarget")
RegisterUnitEvent(25489, 4, "WoolyRhinoBull_OnDied")


--[[ Crystalsong Forest -- Alanura Firecloud.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function AlanuraFirecloud_OnCombat(Unit, Event)
Unit:RegisterEvent("AlanuraFirecloud_FieryIntellect", 2000, 1)
end

function AlanuraFirecloud_FieryIntellect(pUnit, Event) 
pUnit:CastSpell(35917) 
end

function AlanuraFirecloud_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AlanuraFirecloud_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AlanuraFirecloud_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30239, 1, "AlanuraFirecloud_OnCombat")
RegisterUnitEvent(30239, 2, "AlanuraFirecloud_OnLeaveCombat")
RegisterUnitEvent(30239, 3, "AlanuraFirecloud_OnKilledTarget")
RegisterUnitEvent(30239, 4, "AlanuraFirecloud_OnDied")


--[[ Crystalsong Forest -- Ancient Watcher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function AncientWatcher_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientWatcher_EntanglingRoots", 10000, 0)
Unit:RegisterEvent("AncientWatcher_Trample", 6000, 0)
end

function AncientWatcher_EntanglingRoots(pUnit, Event) 
pUnit:FullCastSpellOnTarget(33844, pUnit:GetMainTank()) 
end

function AncientWatcher_Trample(pUnit, Event) 
pUnit:CastSpell(51944) 
end

function AncientWatcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientWatcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientWatcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31229, 1, "AncientWatcher_OnCombat")
RegisterUnitEvent(31229, 2, "AncientWatcher_OnLeaveCombat")
RegisterUnitEvent(31229, 3, "AncientWatcher_OnKilledTarget")
RegisterUnitEvent(31229, 4, "AncientWatcher_OnDied")


--[[ Crystalsong Forest -- Azure Manabeast.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function AzureManabeast_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureManabeast_ManaBite", 8000, 0)
end

function AzureManabeast_ManaBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(59105, pUnit:GetMainTank()) 
end

function AzureManabeast_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureManabeast_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureManabeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31404, 1, "AzureManabeast_OnCombat")
RegisterUnitEvent(31404, 2, "AzureManabeast_OnLeaveCombat")
RegisterUnitEvent(31404, 3, "AzureManabeast_OnKilledTarget")
RegisterUnitEvent(31404, 4, "AzureManabeast_OnDied")


--[[ Crystalsong Forest -- Azure Manashaper.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function AzureManashaper_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureManashaper_ArcaneBlast", 8000, 0)
Unit:RegisterEvent("AzureManashaper_Slow", 7000, 0)
end

function AzureManashaper_ArcaneBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(10833, pUnit:GetMainTank()) 
end

function AzureManashaper_Slow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25603, pUnit:GetMainTank()) 
end

function AzureManashaper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureManashaper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureManashaper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31401, 1, "AzureManashaper_OnCombat")
RegisterUnitEvent(31401, 2, "AzureManashaper_OnLeaveCombat")
RegisterUnitEvent(31401, 3, "AzureManashaper_OnKilledTarget")
RegisterUnitEvent(31401, 4, "AzureManashaper_OnDied")


--[[ Crystalsong Forest -- Azure Spellweaver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function AzureSpellweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureSpellweaver_ArcaneMissiles", 6000, 0)
end

function AzureSpellweaver_ArcaneMissiles(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34447, pUnit:GetMainTank()) 
end

function AzureSpellweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureSpellweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureSpellweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31403, 1, "AzureSpellweaver_OnCombat")
RegisterUnitEvent(31403, 2, "AzureSpellweaver_OnLeaveCombat")
RegisterUnitEvent(31403, 3, "AzureSpellweaver_OnKilledTarget")
RegisterUnitEvent(31403, 4, "AzureSpellweaver_OnDied")


--[[ Crystalsong Forest -- Crystal Wyrm.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function CrystalWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("CrystalWyrm_FrostBreath", 8000, 0)
end

function CrystalWyrm_FrostBreath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47425, pUnit:GetMainTank()) 
end

function CrystalWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrystalWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrystalWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31393, 1, "CrystalWyrm_OnCombat")
RegisterUnitEvent(31393, 2, "CrystalWyrm_OnLeaveCombat")
RegisterUnitEvent(31393, 3, "CrystalWyrm_OnKilledTarget")
RegisterUnitEvent(31393, 4, "CrystalWyrm_OnDied")


--[[ Crystalsong Forest -- Dappled Stag.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function DappledStag_OnCombat(Unit, Event)
Unit:RegisterEvent("DappledStag_Butt", 8000, 0)
end

function DappledStag_Butt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(59110, pUnit:GetMainTank()) 
end

function DappledStag_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DappledStag_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DappledStag_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31236, 1, "DappledStag_OnCombat")
RegisterUnitEvent(31236, 2, "DappledStag_OnLeaveCombat")
RegisterUnitEvent(31236, 3, "DappledStag_OnKilledTarget")
RegisterUnitEvent(31236, 4, "DappledStag_OnDied")


--[[ Crystalsong Forest -- Dispirited Ent.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function DispiritedEnt_OnCombat(Unit, Event)
Unit:RegisterEvent("DispiritedEnt_Rejuvenation", 12000, 0)
Unit:RegisterEvent("DispiritedEnt_Thorns", 2000, 1)
end

function DispiritedEnt_Rejuvenation(pUnit, Event) 
pUnit:CastSpell(15981) 
end

function DispiritedEnt_Thorns(pUnit, Event) 
pUnit:CastSpell(35361) 
end

function DispiritedEnt_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DispiritedEnt_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DispiritedEnt_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31041, 1, "DispiritedEnt_OnCombat")
RegisterUnitEvent(31041, 2, "DispiritedEnt_OnLeaveCombat")
RegisterUnitEvent(31041, 3, "DispiritedEnt_OnKilledTarget")
RegisterUnitEvent(31041, 4, "DispiritedEnt_OnDied")


--[[ Crystalsong Forest -- Grove Walker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function GroveWalker_OnCombat(Unit, Event)
Unit:RegisterEvent("GroveWalker_Rejuvenation", 12000, 0)
Unit:RegisterEvent("GroveWalker_Thorns", 2000, 1)
end

function GroveWalker_Rejuvenation(pUnit, Event) 
pUnit:CastSpell(15981) 
end

function GroveWalker_Thorns(pUnit, Event) 
pUnit:CastSpell(35361) 
end

function GroveWalker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GroveWalker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GroveWalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31228, 1, "GroveWalker_OnCombat")
RegisterUnitEvent(31228, 2, "GroveWalker_OnLeaveCombat")
RegisterUnitEvent(31228, 3, "GroveWalker_OnKilledTarget")
RegisterUnitEvent(31228, 4, "GroveWalker_OnDied")


--[[ Crystalsong Forest -- Lost Shandaral Spirit.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function LostShandaralSpirit_OnCombat(Unit, Event)
Unit:RegisterEvent("LostShandaralSpirit_Moonfire", 6000, 0)
Unit:RegisterEvent("LostShandaralSpirit_Regrowth", 13000, 0)
end

function LostShandaralSpirit_Moonfire(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15798, pUnit:GetMainTank()) 
end

function LostShandaralSpirit_Regrowth(pUnit, Event) 
pUnit:CastSpell(16561) 
end

function LostShandaralSpirit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LostShandaralSpirit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LostShandaralSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31231, 1, "LostLostShandaralSpirit_OnCombat")
RegisterUnitEvent(31231, 2, "LostShandaralSpirit_OnLeaveCombat")
RegisterUnitEvent(31231, 3, "LostShandaralSpirit_OnKilledTarget")
RegisterUnitEvent(31231, 4, "LostShandaralSpirit_OnDied")


--[[ Crystalsong Forest -- Shandaral Druid Spirit.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ShandaralDruidSpirit_OnCombat(Unit, Event)
Unit:RegisterEvent("ShandaralDruidSpirit_Moonfire", 6000, 0)
Unit:RegisterEvent("ShandaralDruidSpirit_Regrowth", 13000, 0)
end

function ShandaralDruidSpirit_Moonfire(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15798, pUnit:GetMainTank()) 
end

function ShandaralDruidSpirit_Regrowth(pUnit, Event) 
pUnit:CastSpell(16561) 
end

function ShandaralDruidSpirit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ShandaralDruidSpirit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ShandaralDruidSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30863, 1, "LostShandaralDruidSpirit_OnCombat")
RegisterUnitEvent(30863, 2, "ShandaralDruidSpirit_OnLeaveCombat")
RegisterUnitEvent(30863, 3, "ShandaralDruidSpirit_OnKilledTarget")
RegisterUnitEvent(30863, 4, "ShandaralDruidSpirit_OnDied")


--[[ Crystalsong Forest -- Shandaral Hunter Spirit.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ShandaralHunterSpirit_OnCombat(Unit, Event)
Unit:RegisterEvent("ShandaralHunterSpirit_AimedShot", 7000, 0)
Unit:RegisterEvent("ShandaralHunterSpirit_ImprovedWingClip", 10000, 0)
Unit:RegisterEvent("ShandaralHunterSpirit_Shoot", 6000, 0)
end

function ShandaralHunterSpirit_AimedShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(54615, pUnit:GetMainTank()) 
end

function ShandaralHunterSpirit_ImprovedWingClip(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47168, pUnit:GetMainTank()) 
end

function ShandaralHunterSpirit_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function ShandaralHunterSpirit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ShandaralHunterSpirit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ShandaralHunterSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30864, 1, "ShandaralHunterSpirit_OnCombat")
RegisterUnitEvent(30864, 2, "ShandaralHunterSpirit_OnLeaveCombat")
RegisterUnitEvent(30864, 3, "ShandaralHunterSpirit_OnKilledTarget")
RegisterUnitEvent(30864, 4, "ShandaralHunterSpirit_OnDied")


--[[ Crystalsong Forest -- Shandaral Spirit Wolf.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function ShandaralSpiritWolf_OnCombat(Unit, Event)
Unit:RegisterEvent("ShandaralSpiritWolf_TendonRip", 8000, 0)
end

function ShandaralSpiritWolf_TendonRip(pUnit, Event) 
pUnit:FullCastSpellOnTarget(3604, pUnit:GetMainTank()) 
end

function ShandaralSpiritWolf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ShandaralSpiritWolf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ShandaralSpiritWolf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31123, 1, "ShandaralSpiritWolf_OnCombat")
RegisterUnitEvent(31123, 2, "ShandaralSpiritWolf_OnLeaveCombat")
RegisterUnitEvent(31123, 3, "ShandaralSpiritWolf_OnKilledTarget")
RegisterUnitEvent(31123, 4, "ShandaralSpiritWolf_OnDied")


--[[ Crystalsong Forest -- Silver Covenant Horseman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SilverCovenantHorseman_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverCovenantHorseman_MultiShot", 8000, 0)
Unit:RegisterEvent("SilverCovenantHorseman_Shoot", 6000, 0)
end

function SilverCovenantHorseman_MultiShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14443, pUnit:GetMainTank()) 
end

function SilverCovenantHorseman_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SilverCovenantHorseman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverCovenantHorseman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverCovenantHorseman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30263, 1, "SilverCovenantHorseman_OnCombat")
RegisterUnitEvent(30263, 2, "SilverCovenantHorseman_OnLeaveCombat")
RegisterUnitEvent(30263, 3, "SilverCovenantHorseman_OnKilledTarget")
RegisterUnitEvent(30263, 4, "SilverCovenantHorseman_OnDied")


--[[ Crystalsong Forest -- Silver Covenant Scout.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]



function SilverCovenantScout_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverCovenantScout_MultiShot", 8000, 0)
Unit:RegisterEvent("SilverCovenantScout_Shoot", 6000, 0)
end

function SilverCovenantScout_MultiShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14443, pUnit:GetMainTank()) 
end

function SilverCovenantScout_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SilverCovenantScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverCovenantScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverCovenantScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30238, 1, "SilverCovenantScout_OnCombat")
RegisterUnitEvent(30238, 2, "SilverCovenantScout_OnLeaveCombat")
RegisterUnitEvent(30238, 3, "SilverCovenantScout_OnKilledTarget")
RegisterUnitEvent(30238, 4, "SilverCovenantScout_OnDied")

--[[ Crystalsong Forest -- Skymaster Baeric.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SkymasterBaeric_OnCombat(Unit, Event)
Unit:RegisterEvent("SkymasterBaeric_FieryIntellect", 2000, 1)
end

function SkymasterBaeric_FieryIntellect(pUnit, Event) 
pUnit:CastSpell(35917) 
end

function SkymasterBaeric_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkymasterBaeric_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkymasterBaeric_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30269, 1, "SkymasterBaeric_OnCombat")
RegisterUnitEvent(30269, 2, "SkymasterBaeric_OnLeaveCombat")
RegisterUnitEvent(30269, 3, "SkymasterBaeric_OnKilledTarget")
RegisterUnitEvent(30269, 4, "SkymasterBaeric_OnDied")


--[[ Crystalsong Forest -- Sinewy Wolf.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SkymasterBaeric_OnCombat(Unit, Event)
Unit:RegisterEvent("SkymasterBaeric_FieryIntellect", 2000, 1)
end

function SkymasterBaeric_FieryIntellect(pUnit, Event) 
pUnit:CastSpell(35917) 
end

function SkymasterBaeric_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkymasterBaeric_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkymasterBaeric_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30269, 1, "SkymasterBaeric_OnCombat")
RegisterUnitEvent(30269, 2, "SkymasterBaeric_OnLeaveCombat")
RegisterUnitEvent(30269, 3, "SkymasterBaeric_OnKilledTarget")
RegisterUnitEvent(30269, 4, "SkymasterBaeric_OnDied")


--[[ Crystalsong Forest -- Sunreaver Hawkrider.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SunreaverHawkrider_OnCombat(Unit, Event)
Unit:RegisterEvent("SunreaverHawkrider_Shoot", 6000, 0)
end

function SunreaverHawkrider_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SunreaverHawkrider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SunreaverHawkrider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SunreaverHawkrider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30265, 1, "SunreaverHawkrider_OnCombat")
RegisterUnitEvent(30265, 2, "SunreaverHawkrider_OnLeaveCombat")
RegisterUnitEvent(30265, 3, "SunreaverHawkrider_OnKilledTarget")
RegisterUnitEvent(30265, 4, "SunreaverHawkrider_OnDied")


--[[ Crystalsong Forest -- Sunreaver Scout.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function SunreaverScout_OnCombat(Unit, Event)
Unit:RegisterEvent("SunreaverScout_MultiShot", 8000, 0)
Unit:RegisterEvent("SunreaverScout_Shoot", 6000, 0)
end

function SunreaverScout_MultiShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14443, pUnit:GetMainTank()) 
end

function SunreaverScout_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SunreaverScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SunreaverScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SunreaverScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30233, 1, "SunreaverScout_OnCombat")
RegisterUnitEvent(30233, 2, "SunreaverScout_OnLeaveCombat")
RegisterUnitEvent(30233, 3, "SunreaverScout_OnKilledTarget")
RegisterUnitEvent(30233, 4, "SunreaverScout_OnDied")


--[[ Crystalsong Forest -- Unbound Ancient.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function UnboundAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundAncient_EntanglingRoots", 10000, 0)
Unit:RegisterEvent("UnboundAncient_Trample", 6000, 0)
end

function UnboundAncient_EntanglingRoots(pUnit, Event) 
pUnit:FullCastSpellOnTarget(33844, pUnit:GetMainTank()) 
end

function UnboundAncient_Trample(pUnit, Event) 
pUnit:CastSpell(51944) 
end

function UnboundAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30861, 1, "UnboundAncient_OnCombat")
RegisterUnitEvent(30861, 2, "UnboundAncient_OnLeaveCombat")
RegisterUnitEvent(30861, 3, "UnboundAncient_OnKilledTarget")
RegisterUnitEvent(30861, 4, "UnboundAncient_OnDied")


--[[ Crystalsong Forest -- Unbound Corrupter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function UnboundCorrupter_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundCorrupter_ArcaneBolt", 6000, 0)
Unit:RegisterEvent("UnboundCorrupter_LeyCurse", 5000, 1)
Unit:RegisterEvent("UnboundCorrupter_TransferredPower", 4000, 1)
end

function UnboundCorrupter_ArcaneBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38204, pUnit:GetMainTank()) 
end

function UnboundCorrupter_LeyCurse(pUnit, Event) 
pUnit:FullCastSpellOnTarget(58667, pUnit:GetMainTank()) 
end

function UnboundCorrupter_TransferredPower(pUnit, Event) 
pUnit:CastSpell(58270) 
end

function UnboundCorrupter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundCorrupter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundCorrupter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30868, 1, "UnboundCorrupter_OnCombat")
RegisterUnitEvent(30868, 2, "UnboundCorrupter_OnLeaveCombat")
RegisterUnitEvent(30868, 3, "UnboundCorrupter_OnKilledTarget")
RegisterUnitEvent(30868, 4, "UnboundCorrupter_OnDied")


--[[ Crystalsong Forest -- Unbound Dryad.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function UnboundDryad_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundDryad_ThrowSpear", 6000, 0)
end

function UnboundDryad_ThrowSpear(pUnit, Event) 
pUnit:FullCastSpellOnTarget(55217, pUnit:GetMainTank()) 
end

function UnboundDryad_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundDryad_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundDryad_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30860, 1, "UnboundDryad_OnCombat")
RegisterUnitEvent(30860, 2, "UnboundDryad_OnLeaveCombat")
RegisterUnitEvent(30860, 3, "UnboundDryad_OnKilledTarget")
RegisterUnitEvent(30860, 4, "UnboundDryad_OnDied")


--[[ Crystalsong Forest -- Unbound Ent.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function UnboundEnt_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundEnt_CorruptedRejuvenation", 8000, 0)
Unit:RegisterEvent("UnboundEnt_Thorns", 2000, 1)
end

function UnboundEnt_CorruptedRejuvenation(pUnit, Event) 
pUnit:FullCastSpellOnTarget(58624, pUnit:GetMainTank()) 
end

function UnboundEnt_Thorns(pUnit, Event) 
pUnit:CastSpell(35361) 
end

function UnboundEnt_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundEnt_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundEnt_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30862, 1, "UnboundEnt_OnCombat")
RegisterUnitEvent(30862, 2, "UnboundEnt_OnLeaveCombat")
RegisterUnitEvent(30862, 3, "UnboundEnt_OnKilledTarget")
RegisterUnitEvent(30862, 4, "UnboundEnt_OnDied")


--[[ Crystalsong Forest -- Unbound Trickster.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 30th, 2008. ]]


function UnboundTrickster_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundTrickster_FireBlast", 6000, 0)
Unit:RegisterEvent("UnboundTrickster_Ignite", 8000, 0)
end

function UnboundTrickster_FireBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13341, pUnit:GetMainTank()) 
end

function UnboundTrickster_Ignite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(58438, pUnit:GetMainTank()) 
end

function UnboundTrickster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundTrickster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundTrickster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30856, 1, "UnboundTrickster_OnCombat")
RegisterUnitEvent(30856, 2, "UnboundTrickster_OnLeaveCombat")
RegisterUnitEvent(30856, 3, "UnboundTrickster_OnKilledTarget")
RegisterUnitEvent(30856, 4, "UnboundTrickster_OnDied")


--[[ Dalaran -- Garl Grimgrizzle.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function GarlGrimgrizzle_OnCombat(Unit, Event)
Unit:RegisterEvent("GarlGrimgrizzle_ShootGun", 6000, 0)
end

function GarlGrimgrizzle_ShootGun(pUnit, Event) 
pUnit:FullCastSpellOnTarget(61353, pUnit:GetMainTank()) 
end

function GarlGrimgrizzle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GarlGrimgrizzle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GarlGrimgrizzle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32710, 1, "GarlGrimgrizzle_OnCombat")
RegisterUnitEvent(32710, 2, "GarlGrimgrizzle_OnLeaveCombat")
RegisterUnitEvent(32710, 3, "GarlGrimgrizzle_OnKilledTarget")
RegisterUnitEvent(32710, 4, "GarlGrimgrizzle_OnDied")


--[[ Dalaran -- Warp Huntress Kula.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function WarpHuntressKula_OnCombat(Unit, Event)
Unit:RegisterEvent("WarpHuntressKula_ShootGun", 6000, 0)
end

function WarpHuntressKula_ShootGun(pUnit, Event) 
pUnit:FullCastSpellOnTarget(61353, pUnit:GetMainTank()) 
end

function WarpHuntressKula_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarpHuntressKula_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarpHuntressKula_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32711, 1, "WarpHuntressKula_OnCombat")
RegisterUnitEvent(32711, 2, "WarpHuntressKula_OnLeaveCombat")
RegisterUnitEvent(32711, 3, "WarpHuntressKula_OnKilledTarget")
RegisterUnitEvent(32711, 4, "WarpHuntressKula_OnDied")


--[[ Dragonblight -- Wyrmbait.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Wyrmbait_OnCombat(Unit, Event)
Unit:RegisterEvent("Wyrmbait_Shoot", 6000, 0)
end

function Wyrmbait_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15620, pUnit:GetMainTank()) 
end

function Wyrmbait_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Wyrmbait_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Wyrmbait_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27843, 1, "Wyrmbait_OnCombat")
RegisterUnitEvent(27843, 2, "Wyrmbait_OnLeaveCombat")
RegisterUnitEvent(27843, 3, "Wyrmbait_OnKilledTarget")
RegisterUnitEvent(27843, 4, "Wyrmbait_OnDied")


--[[ Dragonblight -- 7th Legion Wyrm Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionWyrmHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionWyrmHunter_Shoot", 6000, 0)
end

function thLegionWyrmHunter_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15620, pUnit:GetMainTank()) 
end

function thLegionWyrmHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionWyrmHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionWyrmHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26779, 1, "thLegionWyrmHunter_OnCombat")
RegisterUnitEvent(26779, 2, "thLegionWyrmHunter_OnLeaveCombat")
RegisterUnitEvent(26779, 3, "thLegionWyrmHunter_OnKilledTarget")
RegisterUnitEvent(26779, 4, "thLegionWyrmHunter_OnDied")


--[[ Dragonblight -- 7th Legion Cavalier.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionCavalier_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionCavalier_MortalStrike", 8000, 0)
Unit:RegisterEvent("thLegionCavalier_SnapKick", 6000, 0)
end

function thLegionCavalier_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(19643, pUnit:GetMainTank()) 
end

function thLegionCavalier_SnapKick(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15618, pUnit:GetMainTank()) 
end

function thLegionCavalier_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionCavalier_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionCavalier_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27161, 1, "thLegionCavalier_OnCombat")
RegisterUnitEvent(27161, 2, "thLegionCavalier_OnLeaveCombat")
RegisterUnitEvent(27161, 3, "thLegionCavalier_OnKilledTarget")
RegisterUnitEvent(27161, 4, "thLegionCavalier_OnDied")


--[[ Dragonblight -- 7th Legion Cleric.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionCleric_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionCleric_Heal", 14000, 0)
Unit:RegisterEvent("thLegionCleric_HolySmite", 6000, 0)
end

function thLegionCleric_Heal(pUnit, Event) 
pUnit:CastSpell(31739) 
end

function thLegionCleric_HolySmite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25054, pUnit:GetMainTank()) 
end

function thLegionCleric_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionCleric_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionCleric_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26780, 1, "thLegionCleric_OnCombat")
RegisterUnitEvent(26780, 2, "thLegionCleric_OnLeaveCombat")
RegisterUnitEvent(26780, 3, "thLegionCleric_OnKilledTarget")
RegisterUnitEvent(26780, 4, "thLegionCleric_OnDied")


--[[ Dragonblight -- 7th Legion Elite.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionElite_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionElite_Net", 8000, 0)
Unit:RegisterEvent("thLegionElite_Shoot", 6000, 0)
end

function thLegionElite_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6533, pUnit:GetMainTank()) 
end

function thLegionElite_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50092, pUnit:GetMainTank()) 
end

function thLegionElite_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionElite_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionElite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27588, 1, "thLegionElite_OnCombat")
RegisterUnitEvent(27588, 2, "thLegionElite_OnLeaveCombat")
RegisterUnitEvent(27588, 3, "thLegionElite_OnKilledTarget")
RegisterUnitEvent(27588, 4, "thLegionElite_OnDied")


--[[ Dragonblight -- 7th Legion Elite2.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionElitetwo_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionElitetwo_Net", 8000, 0)
Unit:RegisterEvent("thLegionElitetwo_Shoot", 6000, 0)
end

function thLegionElitetwo_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6533, pUnit:GetMainTank()) 
end

function thLegionElitetwo_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50092, pUnit:GetMainTank()) 
end

function thLegionElitetwo_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionElitetwo_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionElitetwo_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27713, 1, "thLegionElitetwo_OnCombat")
RegisterUnitEvent(27713, 2, "thLegionElitetwo_OnLeaveCombat")
RegisterUnitEvent(27713, 3, "thLegionElitetwo_OnKilledTarget")
RegisterUnitEvent(27713, 4, "thLegionElitetwo_OnDied")


--[[ Dragonblight -- 7th Legion Rifleman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionRifleman_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionRifleman_Net", 8000, 0)
Unit:RegisterEvent("thLegionRifleman_Shoot", 6000, 0)
end

function thLegionRifleman_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6533, pUnit:GetMainTank()) 
end

function thLegionRifleman_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50092, pUnit:GetMainTank()) 
end

function thLegionRifleman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionRifleman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionRifleman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27791, 1, "thLegionRifleman_OnCombat")
RegisterUnitEvent(27791, 2, "thLegionRifleman_OnLeaveCombat")
RegisterUnitEvent(27791, 3, "thLegionRifleman_OnKilledTarget")
RegisterUnitEvent(27791, 4, "thLegionRifleman_OnDied")


--[[ Dragonblight -- 7th Legion Infantryman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionInfantryman_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionInfantryman_ConcussionBlow", 10000, 0)
Unit:RegisterEvent("thLegionInfantryman_DemoralizingShout", 2000, 1)
end

function thLegionInfantryman_ConcussionBlow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32588, pUnit:GetMainTank()) 
end

function thLegionInfantryman_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(16244) 
end

function thLegionInfantryman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionInfantryman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionInfantryman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27160, 1, "thLegionInfantryman_OnCombat")
RegisterUnitEvent(27160, 2, "thLegionInfantryman_OnLeaveCombat")
RegisterUnitEvent(27160, 3, "thLegionInfantryman_OnKilledTarget")
RegisterUnitEvent(27160, 4, "thLegionInfantryman_OnDied")


--[[ Dragonblight -- 7th Legion Sentinel.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function thLegionSentinel_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionSentinel_GlaiveThrow", 8000, 0)
Unit:RegisterEvent("thLegionSentinel_Shoot", 6000, 0)
Unit:RegisterEvent("thLegionSentinel_ShootMagicArrow", 7000, 0)
end

function thLegionSentinel_GlaiveThrow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49481, pUnit:GetMainTank()) 
end

function thLegionSentinel_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15547, pUnit:GetMainTank()) 
end

function thLegionSentinel_ShootMagicArrow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(48530, pUnit:GetMainTank()) 
end

function thLegionSentinel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionSentinel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionSentinel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27162, 1, "thLegionSentinel_OnCombat")
RegisterUnitEvent(27162, 2, "thLegionSentinel_OnLeaveCombat")
RegisterUnitEvent(27162, 3, "thLegionSentinel_OnKilledTarget")
RegisterUnitEvent(27162, 4, "thLegionSentinel_OnDied")


--[[ Dragonblight -- Admiral Barean Westwind.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AdmiralBareanWestwind_OnCombat(Unit, Event)
Unit:RegisterEvent("AdmiralBareanWestwind_ProtectionSphere", 15000, 0)
end

function AdmiralBareanWestwind_ProtectionSphere(pUnit, Event) 
pUnit:CastSpell(50161) 
end

function AdmiralBareanWestwind_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AdmiralBareanWestwind_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AdmiralBareanWestwind_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27951, 1, "AdmiralBareanWestwind_OnCombat")
RegisterUnitEvent(27951, 2, "AdmiralBareanWestwind_OnLeaveCombat")
RegisterUnitEvent(27951, 3, "AdmiralBareanWestwind_OnKilledTarget")
RegisterUnitEvent(27951, 4, "AdmiralBareanWestwind_OnDied")


--[[ Dragonblight -- Alliance Conscript.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AllianceConscript_OnCombat(Unit, Event)
Unit:RegisterEvent("AllianceConscript_HeroicStrike", 8000, 0)
Unit:RegisterEvent("AllianceConscript_ShieldBlock", 5000, 0)
Unit:RegisterEvent("AllianceConscript_Shoot", 6000, 0)
end

function AllianceConscript_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(29426, pUnit:GetMainTank()) 
end

function AllianceConscript_ShieldBlock(pUnit, Event) 
pUnit:CastSpell(32587) 
end

function AllianceConscript_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15620, pUnit:GetMainTank()) 
end

function AllianceConscript_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AllianceConscript_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AllianceConscript_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27564, 1, "AllianceConscript_OnCombat")
RegisterUnitEvent(27564, 2, "AllianceConscript_OnLeaveCombat")
RegisterUnitEvent(27564, 3, "AllianceConscript_OnKilledTarget")
RegisterUnitEvent(27564, 4, "AllianceConscript_OnDied")


--[[ Dragonblight -- Alystros the Verdant Keeper.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AlystrostheVerdantKeeper_OnCombat(Unit, Event)
Unit:RegisterEvent("AlystrostheVerdantKeeper_LapsingDream", 1000, 1)
Unit:RegisterEvent("AlystrostheVerdantKeeper_TalonStrike", 5000, 0)
Unit:RegisterEvent("AlystrostheVerdantKeeper_WingBeat", 8000, 0)
end

function AlystrostheVerdantKeeper_LapsingDream(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51922, pUnit:GetMainTank()) 
end

function AlystrostheVerdantKeeper_TalonStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51937, pUnit:GetMainTank()) 
end

function AlystrostheVerdantKeeper_WingBeat(pUnit, Event) 
pUnit:CastSpell(51938) 
end

function AlystrostheVerdantKeeper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AlystrostheVerdantKeeper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AlystrostheVerdantKeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27249, 1, "AlystrostheVerdantKeeper_OnCombat")
RegisterUnitEvent(27249, 2, "AlystrostheVerdantKeeper_OnLeaveCombat")
RegisterUnitEvent(27249, 3, "AlystrostheVerdantKeeper_OnKilledTarget")
RegisterUnitEvent(27249, 4, "AlystrostheVerdantKeeper_OnDied")


--[[ Dragonblight -- Angrathar Aberration.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AngratharAberration_OnCombat(Unit, Event)
Unit:RegisterEvent("AngratharAberration_Enrage", 1000, 1)
end

function AngratharAberration_Enrage(pUnit, Event) 
pUnit:CastSpell(31540) 
end

function AngratharAberration_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AngratharAberration_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AngratharAberration_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27631, 1, "AngratharAberration_OnCombat")
RegisterUnitEvent(27631, 2, "AngratharAberration_OnLeaveCombat")
RegisterUnitEvent(27631, 3, "AngratharAberration_OnKilledTarget")
RegisterUnitEvent(27631, 4, "AngratharAberration_OnDied")


--[[ Dragonblight -- Angrathar Necrolord.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AngratharNecrolord_OnCombat(Unit, Event)
Unit:RegisterEvent("AngratharNecrolord_ShadowBolt", 7000, 0)
end

function AngratharNecrolord_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function AngratharNecrolord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AngratharNecrolord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AngratharNecrolord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27603, 1, "AngratharNecrolord_OnCombat")
RegisterUnitEvent(27603, 2, "AngratharNecrolord_OnLeaveCombat")
RegisterUnitEvent(27603, 3, "AngratharNecrolord_OnKilledTarget")
RegisterUnitEvent(27603, 4, "AngratharNecrolord_OnDied")


--[[ Dragonblight -- Anokra the Manipulator.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AnokratheManipulator_OnCombat(Unit, Event)
Unit:RegisterEvent("AnokratheManipulator_MindBlast", 6000, 0)
Unit:RegisterEvent("AnokratheManipulator_MindFlay", 8000, 0)
Unit:RegisterEvent("AnokratheManipulator_WaveringWill", 2000, 1)
end

function AnokratheManipulator_MindBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13860, pUnit:GetMainTank()) 
end

function AnokratheManipulator_MindFlay(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16568, pUnit:GetMainTank()) 
end

function AnokratheManipulator_WaveringWill(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51676, pUnit:GetMainTank()) 
end

function AnokratheManipulator_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnokratheManipulator_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnokratheManipulator_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26769, 1, "AnokratheManipulator_OnCombat")
RegisterUnitEvent(26769, 2, "AnokratheManipulator_OnLeaveCombat")
RegisterUnitEvent(26769, 3, "AnokratheManipulator_OnKilledTarget")
RegisterUnitEvent(26769, 4, "AnokratheManipulator_OnDied")


--[[ Dragonblight -- Anubar Ambusher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AnubarAmbusher_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarAmbusher_Rush", 6000, 0)
end

function AnubarAmbusher_Rush(pUnit, Event) 
pUnit:CastSpell(50347) 
end

function AnubarAmbusher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarAmbusher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarAmbusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26402, 1, "AnubarAmbusher_OnCombat")
RegisterUnitEvent(26402, 2, "AnubarAmbusher_OnLeaveCombat")
RegisterUnitEvent(26402, 3, "AnubarAmbusher_OnKilledTarget")
RegisterUnitEvent(26402, 4, "AnubarAmbusher_OnDied")


--[[ Dragonblight -- Anubar Blightbeast.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AnubarBlightbeast_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarBlightbeast_BlightedShriek", 8000, 0)
Unit:RegisterEvent("AnubarBlightbeast_PoisonBolt", 6000, 0)
end

function AnubarBlightbeast_BlightedShriek(pUnit, Event) 
pUnit:CastSpell(47443) 
end

function AnubarBlightbeast_PoisonBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(21971, pUnit:GetMainTank()) 
end

function AnubarBlightbeast_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarBlightbeast_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarBlightbeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26607, 1, "AnubarBlightbeast_OnCombat")
RegisterUnitEvent(26607, 2, "AnubarBlightbeast_OnLeaveCombat")
RegisterUnitEvent(26607, 3, "AnubarBlightbeast_OnKilledTarget")
RegisterUnitEvent(26607, 4, "AnubarBlightbeast_OnDied")


--[[ Dragonblight -- Anubar Cultist.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AnubarCultist_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarCultist_Empower", 2000, 1)
Unit:RegisterEvent("AnubarCultist_ShadowBolt", 8000, 0)
Unit:RegisterEvent("AnubarCultist_Zeal", 3000, 1)
end

function AnubarCultist_Empower(pUnit, Event) 
pUnit:CastSpell(47257) 
end

function AnubarCultist_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function AnubarCultist_Zeal(pUnit, Event) 
pUnit:CastSpell(51605) 
end

function AnubarCultist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarCultist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarCultist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26319, 1, "AnubarCultist_OnCombat")
RegisterUnitEvent(26319, 2, "AnubarCultist_OnLeaveCombat")
RegisterUnitEvent(26319, 3, "AnubarCultist_OnKilledTarget")
RegisterUnitEvent(26319, 4, "AnubarCultist_OnDied")


--[[ Dragonblight -- Anubar Dreadweavert.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AnubarDreadweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarDreadweaver_Corruption", 5000, 1)
Unit:RegisterEvent("AnubarDreadweaver_ShadowBolt", 8000, 0)
end

function AnubarDreadweaver_Corruption(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32063, pUnit:GetMainTank()) 
end

function AnubarDreadweaver_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function AnubarDreadweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarDreadweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarDreadweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26413, 1, "AnubarDreadweaver_OnCombat")
RegisterUnitEvent(26413, 2, "AnubarDreadweaver_OnLeaveCombat")
RegisterUnitEvent(26413, 3, "AnubarDreadweaver_OnKilledTarget")
RegisterUnitEvent(26413, 4, "AnubarDreadweaver_OnDied")


--[[ Dragonblight -- Anubar Underlord.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AnubarUnderlord_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarUnderlord_RearingStomp", 8000, 0)
end

function AnubarUnderlord_RearingStomp(pUnit, Event) 
pUnit:CastSpell(51681) 
end

function AnubarUnderlord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarUnderlord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarUnderlord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26605, 1, "AnubarUnderlord_OnCombat")
RegisterUnitEvent(26605, 2, "AnubarUnderlord_OnLeaveCombat")
RegisterUnitEvent(26605, 3, "AnubarUnderlord_OnKilledTarget")
RegisterUnitEvent(26605, 4, "AnubarUnderlord_OnDied")


--[[ Dragonblight -- Arcane Wyrm.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ArcaneWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("ArcaneWyrm_ArcaneInfusion", 5000, 2)
end

function ArcaneWyrm_ArcaneInfusion(pUnit, Event) 
pUnit:CastSpell(51732) 
end

function ArcaneWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ArcaneWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ArcaneWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26322, 1, "ArcaneWyrm_OnCombat")
RegisterUnitEvent(26322, 2, "ArcaneWyrm_OnLeaveCombat")
RegisterUnitEvent(26322, 3, "ArcaneWyrm_OnKilledTarget")
RegisterUnitEvent(26322, 4, "ArcaneWyrm_OnDied")


--[[ Dragonblight -- Arcanimus.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Arcanimus_OnCombat(Unit, Event)
Unit:RegisterEvent("Arcanimus_ArcaneExplosion", 6000, 0)
end

function Arcanimus_ArcaneExplosion(pUnit, Event) 
pUnit:CastSpell(51820) 
end

function Arcanimus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Arcanimus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Arcanimus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26370, 1, "Arcanimus_OnCombat")
RegisterUnitEvent(26370, 2, "Arcanimus_OnLeaveCombat")
RegisterUnitEvent(26370, 3, "Arcanimus_OnKilledTarget")
RegisterUnitEvent(26370, 4, "Arcanimus_OnDied")


--[[ Dragonblight -- Arctic Ram.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ArcticRam_OnCombat(Unit, Event)
Unit:RegisterEvent("ArcticRam_Gore", 8000, 0)
end

function ArcticRam_Gore(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32019, pUnit:GetMainTank()) 
end

function ArcticRam_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ArcticRam_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ArcticRam_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26426, 1, "ArcticRam_OnCombat")
RegisterUnitEvent(26426, 2, "ArcticRam_OnLeaveCombat")
RegisterUnitEvent(26426, 3, "ArcticRam_OnKilledTarget")
RegisterUnitEvent(26426, 4, "ArcticRam_OnDied")


--[[ Dragonblight -- Azure Dragon.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AzureDragon_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureDragon_FrostBreath", 10000, 1)
end

function AzureDragon_FrostBreath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49111, pUnit:GetMainTank()) 
end

function AzureDragon_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureDragon_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureDragon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27608, 1, "AzureDragon_OnCombat")
RegisterUnitEvent(27608, 2, "AzureDragon_OnLeaveCombat")
RegisterUnitEvent(27608, 3, "AzureDragon_OnKilledTarget")
RegisterUnitEvent(27608, 4, "AzureDragon_OnDied")


--[[ Dragonblight -- Azure Drake.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function AzureDrake_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureDrake_FrostBreath", 10000, 1)
end

function AzureDrake_FrostBreath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49111, pUnit:GetMainTank()) 
end

function AzureDrake_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureDrake_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureDrake_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27682, 1, "AzureDrake_OnCombat")
RegisterUnitEvent(27682, 2, "AzureDrake_OnLeaveCombat")
RegisterUnitEvent(27682, 3, "AzureDrake_OnKilledTarget")
RegisterUnitEvent(27682, 4, "AzureDrake_OnDied")


--[[ Dragonblight -- Battered Drakkari Berserker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BatteredDrakkariBerserker_OnCombat(Unit, Event)
Unit:RegisterEvent("BatteredDrakkariBerserker_Enrage", 10000, 1)
Unit:RegisterEvent("BatteredDrakkariBerserker_Knockdown", 6000, 0)
end

function BatteredDrakkariBerserker_Enrage(pUnit, Event) 
pUnit:CastSpell(50420) 
end

function BatteredDrakkariBerserker_Knockdown(pUnit, Event) 
pUnit:FullCastSpellOnTarget(37592, pUnit:GetMainTank()) 
end

function BatteredDrakkariBerserker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BatteredDrakkariBerserker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BatteredDrakkariBerserker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26943, 1, "BatteredDrakkariBerserker_OnCombat")
RegisterUnitEvent(26943, 2, "BatteredDrakkariBerserker_OnLeaveCombat")
RegisterUnitEvent(26943, 3, "BatteredDrakkariBerserker_OnKilledTarget")
RegisterUnitEvent(26943, 4, "BatteredDrakkariBerserker_OnDied")


--[[ Dragonblight -- Bishop Street.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BishopStreet_OnCombat(Unit, Event)
Unit:RegisterEvent("BishopStreet_HolySmite", 5000, 0)
Unit:RegisterEvent("BishopStreet_PowerWordShield", 2000, 1)
end

function BishopStreet_HolySmite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(20820, pUnit:GetMainTank()) 
end

function BishopStreet_PowerWordShield(pUnit, Event) 
pUnit:CastSpell(11974) 
end

function BishopStreet_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BishopStreet_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BishopStreet_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27246, 1, "BishopStreet_OnCombat")
RegisterUnitEvent(27246, 2, "BishopStreet_OnLeaveCombat")
RegisterUnitEvent(27246, 3, "BishopStreet_OnKilledTarget")
RegisterUnitEvent(27246, 4, "BishopStreet_OnDied")


--[[ Dragonblight -- Blacksmith Goodman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BlacksmithGoodman_OnCombat(Unit, Event)
Unit:RegisterEvent("BlacksmithGoodman_CrushArmor", 6000, 0)
Unit:RegisterEvent("BlacksmithGoodman_SkullCrack", 8000, 0)
end

function BlacksmithGoodman_CrushArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(33661, pUnit:GetMainTank()) 
end

function BlacksmithGoodman_SkullCrack(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15621, pUnit:GetMainTank()) 
end

function BlacksmithGoodman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlacksmithGoodman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlacksmithGoodman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27234, 1, "BlacksmithGoodman_OnCombat")
RegisterUnitEvent(27234, 2, "BlacksmithGoodman_OnLeaveCombat")
RegisterUnitEvent(27234, 3, "BlacksmithGoodman_OnKilledTarget")
RegisterUnitEvent(27234, 4, "BlacksmithGoodman_OnDied")


--[[ Dragonblight -- Blighted Elk.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BlightedElk_OnCombat(Unit, Event)
Unit:RegisterEvent("BlightedElk_PlagueBlight", 8000, 0)
end

function BlightedElk_PlagueBlight(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43506, pUnit:GetMainTank()) 
end

function BlightedElk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlightedElk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlightedElk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26616, 1, "BlightedElk_OnCombat")
RegisterUnitEvent(26616, 2, "BlightedElk_OnLeaveCombat")
RegisterUnitEvent(26616, 3, "BlightedElk_OnKilledTarget")
RegisterUnitEvent(26616, 4, "BlightedElk_OnDied")


--[[ Dragonblight -- Bloodfeast.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Bloodfeast_OnCombat(Unit, Event)
Unit:RegisterEvent("Bloodfeast_InciteMaggots", 4000, 1)
end

function Bloodfeast_InciteMaggots(pUnit, Event) 
pUnit:CastSpell(52126) 
end

function Bloodfeast_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bloodfeast_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bloodfeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27008, 1, "Bloodfeast_OnCombat")
RegisterUnitEvent(27008, 2, "Bloodfeast_OnLeaveCombat")
RegisterUnitEvent(27008, 3, "Bloodfeast_OnKilledTarget")
RegisterUnitEvent(27008, 4, "Bloodfeast_OnDied")


--[[ Dragonblight -- Bloodpaw Shaman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BloodpawShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodpawShaman_Bloodlust", 4000, 1)
Unit:RegisterEvent("BloodpawShaman_EarthShock", 6000, 0)
Unit:RegisterEvent("BloodpawShaman_Stormstrike", 8000, 0)
end

function BloodpawShaman_Bloodlust(pUnit, Event) 
pUnit:CastSpell(6742) 
end

function BloodpawShaman_EarthShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13281, pUnit:GetMainTank()) 
end

function BloodpawShaman_Stormstrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51876, pUnit:GetMainTank()) 
end

function BloodpawShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodpawShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodpawShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27343, 1, "BloodpawShaman_OnCombat")
RegisterUnitEvent(27343, 2, "BloodpawShaman_OnLeaveCombat")
RegisterUnitEvent(27343, 3, "BloodpawShaman_OnKilledTarget")
RegisterUnitEvent(27343, 4, "BloodpawShaman_OnDied")


--[[ Dragonblight -- Bloodpaw Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BloodpawWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodpawWarrior_Maul", 5000, 0)
end

function BloodpawWarrior_Maul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51875, pUnit:GetMainTank()) 
end

function BloodpawWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodpawWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodpawWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27342, 1, "BloodpawWarrior_OnCombat")
RegisterUnitEvent(27342, 2, "BloodpawWarrior_OnLeaveCombat")
RegisterUnitEvent(27342, 3, "BloodpawWarrior_OnKilledTarget")
RegisterUnitEvent(27342, 4, "BloodpawWarrior_OnDied")


--[[ Dragonblight -- Bonesunder.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Bonesunder_OnCombat(Unit, Event)
Unit:RegisterEvent("Bonesunder_BoneCrack", 10000, 0)
end

function Bonesunder_BoneCrack(pUnit, Event) 
pUnit:CastSpell(52080) 
end

function Bonesunder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bonesunder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bonesunder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27006, 1, "Bonesunder_OnCombat")
RegisterUnitEvent(27006, 2, "Bonesunder_OnLeaveCombat")
RegisterUnitEvent(27006, 3, "Bonesunder_OnKilledTarget")
RegisterUnitEvent(27006, 4, "Bonesunder_OnDied")


--[[ Dragonblight -- Bronze Shrine Warden.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BronzeShrineWarden_OnCombat(Unit, Event)
Unit:RegisterEvent("BronzeShrineWarden_SandBreath", 8000, 0)
Unit:RegisterEvent("BronzeShrineWarden_StopTime", 15000, 0)
end

function BronzeShrineWarden_SandBreath(pUnit, Event) 
pUnit:CastSpell(20716) 
end

function BronzeShrineWarden_StopTime(pUnit, Event) 
pUnit:CastSpell(60077) 
end

function BronzeShrineWarden_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BronzeShrineWarden_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BronzeShrineWarden_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26277, 1, "BronzeShrineWarden_OnCombat")
RegisterUnitEvent(26277, 2, "BronzeShrineWarden_OnLeaveCombat")
RegisterUnitEvent(26277, 3, "BronzeShrineWarden_OnKilledTarget")
RegisterUnitEvent(26277, 4, "BronzeShrineWarden_OnDied")


--[[ Dragonblight -- Burning Depths Necrolyte.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BurningDepthsNecrolyte_OnCombat(Unit, Event)
Unit:RegisterEvent("BurningDepthsNecrolyte_DestructiveStrike", 6000, 0)
Unit:RegisterEvent("BurningDepthsNecrolyte_ObsidianEssence", 2000, 1)
end

function BurningDepthsNecrolyte_DestructiveStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51430, pUnit:GetMainTank()) 
end

function BurningDepthsNecrolyte_ObsidianEssence(pUnit, Event) 
pUnit:CastSpell(48616) 
end

function BurningDepthsNecrolyte_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BurningDepthsNecrolyte_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BurningDepthsNecrolyte_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27356, 1, "BurningDepthsNecrolyte_OnCombat")
RegisterUnitEvent(27356, 2, "BurningDepthsNecrolyte_OnLeaveCombat")
RegisterUnitEvent(27356, 3, "BurningDepthsNecrolyte_OnKilledTarget")
RegisterUnitEvent(27356, 4, "BurningDepthsNecrolyte_OnDied")


--[[ Dragonblight -- Burning Depths Necromancer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function BurningDepthsNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("BurningDepthsNecromancer_PowerRelease", 7000, 0)
end

function BurningDepthsNecromancer_PowerRelease(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51431, pUnit:GetMainTank()) 
end

function BurningDepthsNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BurningDepthsNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BurningDepthsNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27358, 1, "BurningDepthsNecromancer_OnCombat")
RegisterUnitEvent(27358, 2, "BurningDepthsNecromancer_OnLeaveCombat")
RegisterUnitEvent(27358, 3, "BurningDepthsNecromancer_OnKilledTarget")
RegisterUnitEvent(27358, 4, "BurningDepthsNecromancer_OnDied")


--[[ Dragonblight -- Captain Drayzen.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CaptainDrayzen_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainDrayzen_Cleave", 6000, 0)
Unit:RegisterEvent("CaptainDrayzen_MortalStrike", 8000, 0)
Unit:RegisterEvent("CaptainDrayzen_Whirlwind", 7000, 0)
end

function CaptainDrayzen_Cleave(pUnit, Event) 
pUnit:CastSpell(42724) 
end

function CaptainDrayzen_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15708, pUnit:GetMainTank()) 
end

function CaptainDrayzen_Whirlwind(pUnit, Event) 
pUnit:CastSpell(38619) 
end

function CaptainDrayzen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainDrayzen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainDrayzen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27751, 1, "CaptainDrayzen_OnCombat")
RegisterUnitEvent(27751, 2, "CaptainDrayzen_OnLeaveCombat")
RegisterUnitEvent(27751, 3, "CaptainDrayzen_OnKilledTarget")
RegisterUnitEvent(27751, 4, "CaptainDrayzen_OnDied")


--[[ Dragonblight -- Captain Emmy Malin.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CaptainEmmyMalin_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainEmmyMalin_FrostNova", 10000, 0)
Unit:RegisterEvent("CaptainEmmyMalin_Frostbolt", 8000, 0)
Unit:RegisterEvent("CaptainEmmyMalin_IceLance", 3000, 0)
end

function CaptainEmmyMalin_FrostNova(pUnit, Event) 
pUnit:CastSpell(11831) 
end

function CaptainEmmyMalin_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(20792, pUnit:GetMainTank()) 
end

function CaptainEmmyMalin_IceLance(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49906, pUnit:GetMainTank()) 
end

function CaptainEmmyMalin_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainEmmyMalin_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainEmmyMalin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26762, 1, "CaptainEmmyMalin_OnCombat")
RegisterUnitEvent(26762, 2, "CaptainEmmyMalin_OnLeaveCombat")
RegisterUnitEvent(26762, 3, "CaptainEmmyMalin_OnKilledTarget")
RegisterUnitEvent(26762, 4, "CaptainEmmyMalin_OnDied")


--[[ Dragonblight -- Captain Iskandar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CaptainIskandar_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainIskandar_Cleave", 6000, 0)
Unit:RegisterEvent("CaptainIskandar_MortalStrike", 8000, 0)
Unit:RegisterEvent("CaptainIskandar_Whirlwind", 7000, 0)
end

function CaptainIskandar_Cleave(pUnit, Event) 
pUnit:CastSpell(42724) 
end

function CaptainIskandar_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15708, pUnit:GetMainTank()) 
end

function CaptainIskandar_Whirlwind(pUnit, Event) 
pUnit:CastSpell(38619) 
end

function CaptainIskandar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainIskandar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainIskandar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27657, 1, "CaptainIskandar_OnCombat")
RegisterUnitEvent(27657, 2, "CaptainIskandar_OnLeaveCombat")
RegisterUnitEvent(27657, 3, "CaptainIskandar_OnKilledTarget")
RegisterUnitEvent(27657, 4, "CaptainIskandar_OnDied")


--[[ Dragonblight -- Captain Shely.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CaptainShely_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainShely_RunThrough", 5000, 1)
end

function CaptainShely_RunThrough(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50853, pUnit:GetMainTank()) 
end

function CaptainShely_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainShely_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainShely_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27232, 1, "CaptainShely_OnCombat")
RegisterUnitEvent(27232, 2, "CaptainShely_OnLeaveCombat")
RegisterUnitEvent(27232, 3, "CaptainShely_OnKilledTarget")
RegisterUnitEvent(27232, 4, "CaptainShely_OnDied")


--[[ Dragonblight -- Chilltusk.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Chilltusk_OnCombat(Unit, Event)
Unit:RegisterEvent("Chilltusk_IceSlash", 6000, 0)
Unit:RegisterEvent("Chilltusk_TuskStrike", 5000, 0)
end

function Chilltusk_IceSlash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51878, pUnit:GetMainTank()) 
end

function Chilltusk_TuskStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50410, pUnit:GetMainTank()) 
end

function Chilltusk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Chilltusk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Chilltusk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27005, 1, "Chilltusk_OnCombat")
RegisterUnitEvent(27005, 2, "Chilltusk_OnLeaveCombat")
RegisterUnitEvent(27005, 3, "Chilltusk_OnKilledTarget")
RegisterUnitEvent(27005, 4, "Chilltusk_OnDied")


--[[ Dragonblight -- Coldwind Waste Huntress.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ColdwindWasteHuntress_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdwindWasteHuntress_EyePeck", 6000, 0)
end

function ColdwindWasteHuntress_EyePeck(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49865, pUnit:GetMainTank()) 
end

function ColdwindWasteHuntress_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdwindWasteHuntress_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdwindWasteHuntress_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26575, 1, "ColdwindWasteHuntress_OnCombat")
RegisterUnitEvent(26575, 2, "ColdwindWasteHuntress_OnLeaveCombat")
RegisterUnitEvent(26575, 3, "ColdwindWasteHuntress_OnKilledTarget")
RegisterUnitEvent(26575, 4, "ColdwindWasteHuntress_OnDied")


--[[ Dragonblight -- Coldwind Witch.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ColdwindWitch_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdwindWitch_ColdwindBlast", 7000, 0)
end

function ColdwindWitch_ColdwindBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51877, pUnit:GetMainTank()) 
end

function ColdwindWitch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdwindWitch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdwindWitch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26577, 1, "ColdwindWitch_OnCombat")
RegisterUnitEvent(26577, 2, "ColdwindWitch_OnLeaveCombat")
RegisterUnitEvent(26577, 3, "ColdwindWitch_OnKilledTarget")
RegisterUnitEvent(26577, 4, "ColdwindWitch_OnDied")


--[[ Dragonblight -- Commander Jordan.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CommanderJordan_OnCombat(Unit, Event)
Unit:RegisterEvent("CommanderJordan_AvengingWrath", 6000, 1)
Unit:RegisterEvent("CommanderJordan_Consecration", 7000, 0)
end

function CommanderJordan_AvengingWrath(pUnit, Event) 
pUnit:CastSpell(50837) 
end

function CommanderJordan_Consecration(pUnit, Event) 
pUnit:CastSpell(32773) 
end

function CommanderJordan_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CommanderJordan_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CommanderJordan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27237, 1, "CommanderJordan_OnCombat")
RegisterUnitEvent(27237, 2, "CommanderJordan_OnLeaveCombat")
RegisterUnitEvent(27237, 3, "CommanderJordan_OnKilledTarget")
RegisterUnitEvent(27237, 4, "CommanderJordan_OnDied")


--[[ Dragonblight -- Corrupted Lothalor Ancient.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CorruptedLothalorAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("CorruptedLothalorAncient_ArcaneDischarge", 6000, 0)
Unit:RegisterEvent("CorruptedLothalorAncient_ArcaneExplosion", 5000, 0)
end

function CorruptedLothalorAncient_ArcaneDischarge(pUnit, Event) 
pUnit:CastSpell(51727) 
end

function CorruptedLothalorAncient_ArcaneExplosion(pUnit, Event) 
pUnit:CastSpell(51725) 
end

function CorruptedLothalorAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CorruptedLothalorAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CorruptedLothalorAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26333, 1, "CorruptedLothalorAncient_OnCombat")
RegisterUnitEvent(26333, 2, "CorruptedLothalorAncient_OnLeaveCombat")
RegisterUnitEvent(26333, 3, "CorruptedLothalorAncient_OnKilledTarget")
RegisterUnitEvent(26333, 4, "CorruptedLothalorAncient_OnDied")


--[[ Dragonblight -- Corrupted Rager.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CorruptedRager_OnCombat(Unit, Event)
Unit:RegisterEvent("CorruptedRager_CorrodeArmor", 8000, 0)
end

function CorruptedRager_CorrodeArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51613, pUnit:GetMainTank()) 
end

function CorruptedRager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CorruptedRager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CorruptedRager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21223, 1, "CorruptedRager_OnCombat")
RegisterUnitEvent(21223, 2, "CorruptedRager_OnLeaveCombat")
RegisterUnitEvent(21223, 3, "CorruptedRager_OnKilledTarget")
RegisterUnitEvent(21223, 4, "CorruptedRager_OnDied")


function CrazedInduleSurvivor_OnCombat(Unit, Event)
Unit:RegisterEvent("CrazedInduleSurvivor_Crazed", 4000, 1)
Unit:RegisterEvent("CrazedInduleSurvivor_MortalStrike", 7000, 0)
end

function CrazedInduleSurvivor_Crazed(pUnit, Event) 
pUnit:CastSpell(48139) 
end

function CrazedInduleSurvivor_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(39171, pUnit:GetMainTank()) 
end

function CrazedInduleSurvivor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrazedInduleSurvivor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrazedInduleSurvivor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32409, 1, "CrazedInduleSurvivor_OnCombat")
RegisterUnitEvent(32409, 2, "CrazedInduleSurvivor_OnLeaveCombat")
RegisterUnitEvent(32409, 3, "CrazedInduleSurvivor_OnKilledTarget")
RegisterUnitEvent(32409, 4, "CrazedInduleSurvivor_OnDied")


--[[ Dragonblight -- Crystalline Ice Elemental.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CrystallineIceElemental_OnCombat(Unit, Event)
Unit:RegisterEvent("CrystallineIceElemental_IceSlash", 6000, 0)
end

function CrystallineIceElemental_IceSlash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51878, pUnit:GetMainTank()) 
end

function CrystallineIceElemental_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrystallineIceElemental_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrystallineIceElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26316, 1, "CrystallineIceElemental_OnCombat")
RegisterUnitEvent(26316, 2, "CrystallineIceElemental_OnLeaveCombat")
RegisterUnitEvent(26316, 3, "CrystallineIceElemental_OnKilledTarget")
RegisterUnitEvent(26316, 4, "CrystallineIceElemental_OnDied")


--[[ Dragonblight -- Crystalline Ice Giant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function CrystallineIceGiant_OnCombat(Unit, Event)
Unit:RegisterEvent("CrystallineIceGiant_IceStalagmite", 8000, 0)
Unit:RegisterEvent("CrystallineIceGiant_IceBoulder", 5500, 0)
end

function CrystallineIceGiant_IceStalagmite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50597, pUnit:GetMainTank()) 
end

function CrystallineIceGiant_IceBoulder(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50588, pUnit:GetMainTank()) 
end

function CrystallineIceGiant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrystallineIceGiant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrystallineIceGiant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26291, 1, "CrystallineIceGiant_OnCombat")
RegisterUnitEvent(26291, 2, "CrystallineIceGiant_OnLeaveCombat")
RegisterUnitEvent(26291, 3, "CrystallineIceGiant_OnKilledTarget")
RegisterUnitEvent(26291, 4, "CrystallineIceGiant_OnDied")


--[[ Dragonblight -- Dahlia Suntouch.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DahliaSuntouch_OnCombat(Unit, Event)
Unit:RegisterEvent("DahliaSuntouch_BansheeCurse", 4000, 1)
Unit:RegisterEvent("DahliaSuntouch_BansheeScreech", 6000, 1)
Unit:RegisterEvent("DahliaSuntouch_BansheeWail", 7000, 0)
end

function DahliaSuntouch_BansheeCurse(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51899, pUnit:GetMainTank()) 
end

function DahliaSuntouch_BansheeScreech(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51897, pUnit:GetMainTank()) 
end

function DahliaSuntouch_BansheeWail(pUnit, Event) 
pUnit:FullCastSpellOnTarget(28993, pUnit:GetMainTank()) 
end

function DahliaSuntouch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DahliaSuntouch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DahliaSuntouch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27680, 1, "DahliaSuntouch_OnCombat")
RegisterUnitEvent(27680, 2, "DahliaSuntouch_OnLeaveCombat")
RegisterUnitEvent(27680, 3, "DahliaSuntouch_OnKilledTarget")
RegisterUnitEvent(27680, 4, "DahliaSuntouch_OnDied")


--[[ Dragonblight -- Darkspear Spear Thrower.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DarkspearSpearThrower_OnCombat(Unit, Event)
Unit:RegisterEvent("DarkspearSpearThrower_Net", 10000, 0)
Unit:RegisterEvent("DarkspearSpearThrower_Throw", 5000, 0)
end

function DarkspearSpearThrower_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12024, pUnit:GetMainTank()) 
end

function DarkspearSpearThrower_Throw(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38556, pUnit:GetMainTank()) 
end

function DarkspearSpearThrower_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DarkspearSpearThrower_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DarkspearSpearThrower_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27560, 1, "DarkspearSpearThrower_OnCombat")
RegisterUnitEvent(27560, 2, "DarkspearSpearThrower_OnLeaveCombat")
RegisterUnitEvent(27560, 3, "DarkspearSpearThrower_OnKilledTarget")
RegisterUnitEvent(27560, 4, "DarkspearSpearThrower_OnDied")


--[[ Dragonblight -- Death Knight Champion.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DeathKnightChampion_OnCombat(Unit, Event)
Unit:RegisterEvent("DeathKnightChampion_BloodPresence", 1000, 1)
Unit:RegisterEvent("DeathKnightChampion_PlagueStrike", 8000, 0)
end

function DeathKnightChampion_BloodPresence(pUnit, Event) 
pUnit:CastSpell(50689) 
end

function DeathKnightChampion_PlagueStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50688, pUnit:GetMainTank()) 
end

function DeathKnightChampion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DeathKnightChampion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DeathKnightChampion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27288, 1, "DeathKnightChampion_OnCombat")
RegisterUnitEvent(27288, 2, "DeathKnightChampion_OnLeaveCombat")
RegisterUnitEvent(27288, 3, "DeathKnightChampion_OnKilledTarget")
RegisterUnitEvent(27288, 4, "DeathKnightChampion_OnDied")


--[[ Dragonblight -- Deathbringer Revenant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DeathbringerRevenant_OnCombat(Unit, Event)
Unit:RegisterEvent("DeathbringerRevenant_Strangulate", 8000, 0)
end

function DeathbringerRevenant_Strangulate(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51131, pUnit:GetMainTank()) 
end

function DeathbringerRevenant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DeathbringerRevenant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DeathbringerRevenant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27382, 1, "DeathbringerRevenant_OnCombat")
RegisterUnitEvent(27382, 2, "DeathbringerRevenant_OnLeaveCombat")
RegisterUnitEvent(27382, 3, "DeathbringerRevenant_OnKilledTarget")
RegisterUnitEvent(27382, 4, "DeathbringerRevenant_OnDied")


--[[ Dragonblight -- Decrepit Necromancer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DecrepitNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("DecrepitNecromancer_ConversionBeam", 8000, 0)
Unit:RegisterEvent("DecrepitNecromancer_ShadowBolt", 5000, 0)
end

function DecrepitNecromancer_ConversionBeam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50659, pUnit:GetMainTank()) 
end

function DecrepitNecromancer_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function DecrepitNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DecrepitNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DecrepitNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26942, 1, "DecrepitNecromancer_OnCombat")
RegisterUnitEvent(26942, 2, "DecrepitNecromancer_OnLeaveCombat")
RegisterUnitEvent(26942, 3, "DecrepitNecromancer_OnKilledTarget")
RegisterUnitEvent(26942, 4, "DecrepitNecromancer_OnDied")


--[[ Dragonblight -- Deranged Indule Villager.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DerangedInduleVillager_OnCombat(Unit, Event)
Unit:RegisterEvent("DerangedInduleVillager_DerangedTantrum", 7000, 0)
end

function DerangedInduleVillager_DerangedTantrum(pUnit, Event) 
pUnit:CastSpell(51782) 
end

function DerangedInduleVillager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DerangedInduleVillager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DerangedInduleVillager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26411, 1, "DerangedInduleVillager_OnCombat")
RegisterUnitEvent(26411, 2, "DerangedInduleVillager_OnLeaveCombat")
RegisterUnitEvent(26411, 3, "DerangedInduleVillager_OnKilledTarget")
RegisterUnitEvent(26411, 4, "DerangedInduleVillager_OnDied")


--[[ Dragonblight -- Devout Bodyguard.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DevoutBodyguard_OnCombat(Unit, Event)
Unit:RegisterEvent("DevoutBodyguard_PiercingHowl", 8000, 0)
end

function DevoutBodyguard_PiercingHowl(pUnit, Event) 
pUnit:CastSpell(38256) 
end

function DevoutBodyguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DevoutBodyguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DevoutBodyguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27247, 1, "DevoutBodyguard_OnCombat")
RegisterUnitEvent(27247, 2, "DevoutBodyguard_OnLeaveCombat")
RegisterUnitEvent(27247, 3, "DevoutBodyguard_OnKilledTarget")
RegisterUnitEvent(27247, 4, "DevoutBodyguard_OnDied")


--[[ Dragonblight -- Dragonblight Mage Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DragonblightMageHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonblightMageHunter_ArcaneReflection", 9000, 1)
Unit:RegisterEvent("DragonblightMageHunter_FireReflection", 8000, 1)
Unit:RegisterEvent("DragonblightMageHunter_FrostReflection", 7000, 1)
Unit:RegisterEvent("DragonblightMageHunter_ShadowReflection", 6000, 1)
end

function DragonblightMageHunter_ArcaneReflection(pUnit, Event) 
pUnit:CastSpell(51766) 
end

function DragonblightMageHunter_FireReflection(pUnit, Event) 
pUnit:CastSpell(51758) 
end

function DragonblightMageHunter_FrostReflection(pUnit, Event) 
pUnit:CastSpell(51763) 
end

function DragonblightMageHunter_ShadowReflection(pUnit, Event) 
pUnit:CastSpell(51764) 
end

function DragonblightMageHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonblightMageHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonblightMageHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26280, 1, "DragonblightMageHunter_OnCombat")
RegisterUnitEvent(26280, 2, "DragonblightMageHunter_OnLeaveCombat")
RegisterUnitEvent(26280, 3, "DragonblightMageHunter_OnKilledTarget")
RegisterUnitEvent(26280, 4, "DragonblightMageHunter_OnDied")


--[[ Dragonblight -- Dragonblight Mage Huntertwo.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DragonblightMageHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonblightMageHunter_ArcaneReflection", 9000, 1)
Unit:RegisterEvent("DragonblightMageHunter_FireReflection", 8000, 1)
Unit:RegisterEvent("DragonblightMageHunter_FrostReflection", 7000, 1)
Unit:RegisterEvent("DragonblightMageHunter_ShadowReflection", 6000, 1)
end

function DragonblightMageHunter_ArcaneReflection(pUnit, Event) 
pUnit:CastSpell(51766) 
end

function DragonblightMageHunter_FireReflection(pUnit, Event) 
pUnit:CastSpell(51758) 
end

function DragonblightMageHunter_FrostReflection(pUnit, Event) 
pUnit:CastSpell(51763) 
end

function DragonblightMageHunter_ShadowReflection(pUnit, Event) 
pUnit:CastSpell(51764) 
end

function DragonblightMageHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonblightMageHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonblightMageHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32572, 1, "DragonblightMageHunter_OnCombat")
RegisterUnitEvent(32572, 2, "DragonblightMageHunter_OnLeaveCombat")
RegisterUnitEvent(32572, 3, "DragonblightMageHunter_OnKilledTarget")
RegisterUnitEvent(32572, 4, "DragonblightMageHunter_OnDied")


--[[ Dragonblight -- Dragonbone Condor.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DragonboneCondor_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonboneCondor_EvasiveManeuver", 6000, 0)
end

function DragonboneCondor_EvasiveManeuver(pUnit, Event) 
pUnit:CastSpell(51946) 
end

function DragonboneCondor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonboneCondor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonboneCondor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26483, 1, "DragonboneCondor_OnCombat")
RegisterUnitEvent(26483, 2, "DragonboneCondor_OnLeaveCombat")
RegisterUnitEvent(26483, 3, "DragonboneCondor_OnKilledTarget")
RegisterUnitEvent(26483, 4, "DragonboneCondor_OnDied")


--[[ Dragonblight -- Drakegore.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Drakegore_OnCombat(Unit, Event)
Unit:RegisterEvent("Drakegore_BurningFists", 2000, 1)
Unit:RegisterEvent("Drakegore_MagnataurCharge", 6000, 0)
end

function Drakegore_BurningFists(pUnit, Event) 
pUnit:CastSpell(52101) 
end

function Drakegore_MagnataurCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52088, pUnit:GetMainTank()) 
end

function Drakegore_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Drakegore_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Drakegore_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27009, 1, "Drakegore_OnCombat")
RegisterUnitEvent(27009, 2, "Drakegore_OnLeaveCombat")
RegisterUnitEvent(27009, 3, "Drakegore_OnKilledTarget")
RegisterUnitEvent(27009, 4, "Drakegore_OnDied")


--[[ Dragonblight -- Dreadbone Invader.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DreadboneInvader_OnCombat(Unit, Event)
Unit:RegisterEvent("DreadboneInvader_Soulthirst", 10000, 0)
end

function DreadboneInvader_Soulthirst(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51290, pUnit:GetMainTank()) 
end

function DreadboneInvader_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DreadboneInvader_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DreadboneInvader_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27286, 1, "DreadboneInvader_OnCombat")
RegisterUnitEvent(27286, 2, "DreadboneInvader_OnLeaveCombat")
RegisterUnitEvent(27286, 3, "DreadboneInvader_OnKilledTarget")
RegisterUnitEvent(27286, 4, "DreadboneInvader_OnDied")


--[[ Dragonblight -- Dregmar Runebrand.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DregmarRunebrand_OnCombat(Unit, Event)
Unit:RegisterEvent("DregmarRunebrand_RuneShield", 20000, 1)
end

function DregmarRunebrand_RuneShield(pUnit, Event) 
pUnit:CastSpell(48325) 
end

function DregmarRunebrand_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DregmarRunebrand_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DregmarRunebrand_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27003, 1, "DregmarRunebrand_OnCombat")
RegisterUnitEvent(27003, 2, "DregmarRunebrand_OnLeaveCombat")
RegisterUnitEvent(27003, 3, "DregmarRunebrand_OnKilledTarget")
RegisterUnitEvent(27003, 4, "DregmarRunebrand_OnDied")


--[[ Dragonblight -- Duke Vallenhal.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function DukeVallenhal_OnCombat(Unit, Event)
Unit:RegisterEvent("DukeVallenhal_BloodPresence", 1000, 1)
Unit:RegisterEvent("DukeVallenhal_Bloodworm", 4000, 1)
end

function DukeVallenhal_BloodPresence(pUnit, Event) 
pUnit:CastSpell(50689) 
end

function DukeVallenhal_Bloodworm(pUnit, Event) 
pUnit:CastSpell(51879) 
end

function DukeVallenhal_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DukeVallenhal_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DukeVallenhal_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26926, 1, "DukeVallenhal_OnCombat")
RegisterUnitEvent(26926, 2, "DukeVallenhal_OnLeaveCombat")
RegisterUnitEvent(26926, 3, "DukeVallenhal_OnKilledTarget")
RegisterUnitEvent(26926, 4, "DukeVallenhal_OnDied")


--[[ Dragonblight -- Emaciated Mammoth.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function EmaciatedMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("EmaciatedMammoth_Trample", 6000, 0)
end

function EmaciatedMammoth_Trample(pUnit, Event) 
pUnit:CastSpell(51944) 
end

function EmaciatedMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmaciatedMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmaciatedMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26272, 1, "EmaciatedMammoth_OnCombat")
RegisterUnitEvent(26272, 2, "EmaciatedMammoth_OnLeaveCombat")
RegisterUnitEvent(26272, 3, "EmaciatedMammoth_OnKilledTarget")
RegisterUnitEvent(26272, 4, "EmaciatedMammoth_OnDied")


--[[ Dragonblight -- Emaciated Mammoth Bull.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function EmaciatedMammothBull_OnCombat(Unit, Event)
Unit:RegisterEvent("EmaciatedMammothBull_Trample", 6000, 0)
end

function EmaciatedMammothBull_Trample(pUnit, Event) 
pUnit:CastSpell(51944) 
end

function EmaciatedMammothBull_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmaciatedMammothBull_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmaciatedMammothBull_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26271, 1, "EmaciatedMammothBull_OnCombat")
RegisterUnitEvent(26271, 2, "EmaciatedMammothBull_OnLeaveCombat")
RegisterUnitEvent(26271, 3, "EmaciatedMammothBull_OnKilledTarget")
RegisterUnitEvent(26271, 4, "EmaciatedMammothBull_OnDied")


--[[ Dragonblight -- Emerald Lasher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function EmeraldLasher_OnCombat(Unit, Event)
Unit:RegisterEvent("EmeraldLasher_DreamLash", 7000, 0)
end

function EmeraldLasher_DreamLash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51901, pUnit:GetMainTank()) 
end

function EmeraldLasher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmeraldLasher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmeraldLasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27254, 1, "EmeraldLasher_OnCombat")
RegisterUnitEvent(27254, 2, "EmeraldLasher_OnLeaveCombat")
RegisterUnitEvent(27254, 3, "EmeraldLasher_OnKilledTarget")
RegisterUnitEvent(27254, 4, "EmeraldLasher_OnDied")


--[[ Dragonblight -- Emerald Skytalon.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function EmeraldSkytalon_OnCombat(Unit, Event)
Unit:RegisterEvent("EmeraldSkytalon_Swoop", 8000, 0)
Unit:RegisterEvent("EmeraldSkytalon_TalonStrike", 6000, 0)
end

function EmeraldSkytalon_Swoop(pUnit, Event) 
pUnit:CastSpell(51919) 
end

function EmeraldSkytalon_TalonStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32909, pUnit:GetMainTank()) 
end

function EmeraldSkytalon_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmeraldSkytalon_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmeraldSkytalon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27244, 1, "EmeraldSkytalon_OnCombat")
RegisterUnitEvent(27244, 2, "EmeraldSkytalon_OnLeaveCombat")
RegisterUnitEvent(27244, 3, "EmeraldSkytalon_OnKilledTarget")
RegisterUnitEvent(27244, 4, "EmeraldSkytalon_OnDied")


--[[ Dragonblight -- Enraged Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function EnragedApparition_OnCombat(Unit, Event)
Unit:RegisterEvent("EnragedApparition_Enrage", 10000, 1)
end

function EnragedApparition_Enrage(pUnit, Event) 
pUnit:CastSpell(50420) 
end

function EnragedApparition_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnragedApparition_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnragedApparition_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27551, 1, "EnragedApparition_OnCombat")
RegisterUnitEvent(27551, 2, "EnragedApparition_OnLeaveCombat")
RegisterUnitEvent(27551, 3, "EnragedApparition_OnKilledTarget")
RegisterUnitEvent(27551, 4, "EnragedApparition_OnDied")


--[[ Dragonblight -- Focus Wizard.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FocusWizard_OnCombat(Unit, Event)
Unit:RegisterEvent("FocusWizard_ArcaneFocus", 1000, 1)
Unit:RegisterEvent("FocusWizard_FrostfireBolt", 5000, 1)
Unit:RegisterEvent("FocusWizard_LightningBolt", 8000, 0)
end

function FocusWizard_ArcaneFocus(pUnit, Event) 
pUnit:CastSpell(51777) 
end

function FocusWizard_FrostfireBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51779, pUnit:GetMainTank()) 
end

function FocusWizard_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49418, pUnit:GetMainTank()) 
end

function FocusWizard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FocusWizard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FocusWizard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26816, 1, "FocusWizard_OnCombat")
RegisterUnitEvent(26816, 2, "FocusWizard_OnLeaveCombat")
RegisterUnitEvent(26816, 3, "FocusWizard_OnKilledTarget")
RegisterUnitEvent(26816, 4, "FocusWizard_OnDied")


--[[ Dragonblight -- Fordragon Gryphon Rider.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FordragonGryphonRider_OnCombat(Unit, Event)
Unit:RegisterEvent("FordragonGryphonRider_Stormhammer", 9000, 0)
end

function FordragonGryphonRider_Stormhammer(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49482, pUnit:GetMainTank()) 
end

function FordragonGryphonRider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FordragonGryphonRider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FordragonGryphonRider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27521, 1, "FordragonGryphonRider_OnCombat")
RegisterUnitEvent(27521, 2, "FordragonGryphonRider_OnLeaveCombat")
RegisterUnitEvent(27521, 3, "FordragonGryphonRider_OnKilledTarget")
RegisterUnitEvent(27521, 4, "FordragonGryphonRider_OnDied")


--[[ Dragonblight -- Fordragon Knight.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FordragonKnight_OnCombat(Unit, Event)
Unit:RegisterEvent("FordragonKnight_RallyingCry", 2000, 1)
end

function FordragonKnight_RallyingCry(pUnit, Event) 
pUnit:CastSpell(31732) 
end

function FordragonKnight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FordragonKnight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FordragonKnight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27531, 1, "FordragonKnight_OnCombat")
RegisterUnitEvent(27531, 2, "FordragonKnight_OnLeaveCombat")
RegisterUnitEvent(27531, 3, "FordragonKnight_OnKilledTarget")
RegisterUnitEvent(27531, 4, "FordragonKnight_OnDied")


--[[ Dragonblight -- Fordragon Marksman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FordragonMarksman_OnCombat(Unit, Event)
Unit:RegisterEvent("FordragonMarksman_Shoot", 5000, 0)
Unit:RegisterEvent("FordragonMarksman_ExplodingShot", 7000, 0)
Unit:RegisterEvent("FordragonMarksman_RapidShot", 9000, 0)
end

function FordragonMarksman_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32103, pUnit:GetMainTank()) 
end

function FordragonMarksman_ExplodingShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(7896, pUnit:GetMainTank()) 
end

function FordragonMarksman_RapidShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49474, pUnit:GetMainTank()) 
end

function FordragonMarksman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FordragonMarksman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FordragonMarksman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27540, 1, "FordragonMarksman_OnCombat")
RegisterUnitEvent(27540, 2, "FordragonMarksman_OnLeaveCombat")
RegisterUnitEvent(27540, 3, "FordragonMarksman_OnKilledTarget")
RegisterUnitEvent(27540, 4, "FordragonMarksman_OnDied")


--[[ Dragonblight -- Fordragon Sentinel.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FordragonSentinel_OnCombat(Unit, Event)
Unit:RegisterEvent("FordragonSentinel_GlaiveThrow", 8000, 0)
end

function FordragonSentinel_GlaiveThrow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49481, pUnit:GetMainTank()) 
end

function FordragonSentinel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FordragonSentinel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FordragonSentinel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27576, 1, "FordragonSentinel_OnCombat")
RegisterUnitEvent(27576, 2, "FordragonSentinel_OnLeaveCombat")
RegisterUnitEvent(27576, 3, "FordragonSentinel_OnKilledTarget")
RegisterUnitEvent(27576, 4, "FordragonSentinel_OnDied")


--[[ Dragonblight -- Forgotten Captain.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ForgottenCaptain_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenCaptain_Stormhammer", 9000, 0)
end

function ForgottenCaptain_Stormhammer(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51591, pUnit:GetMainTank()) 
end

function ForgottenCaptain_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenCaptain_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenCaptain_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27220, 1, "ForgottenCaptain_OnCombat")
RegisterUnitEvent(27220, 2, "ForgottenCaptain_OnLeaveCombat")
RegisterUnitEvent(27220, 3, "ForgottenCaptain_OnKilledTarget")
RegisterUnitEvent(27220, 4, "ForgottenCaptain_OnDied")


--[[ Dragonblight -- Forgotten Footman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ForgottenFootman_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenFootman_ShieldBlock", 5000, 0)
end

function ForgottenFootman_ShieldBlock(pUnit, Event) 
pUnit:CastSpell(32587) 
end

function ForgottenFootman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenFootman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenFootman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27229, 1, "ForgottenFootman_OnCombat")
RegisterUnitEvent(27229, 2, "ForgottenFootman_OnLeaveCombat")
RegisterUnitEvent(27229, 3, "ForgottenFootman_OnKilledTarget")
RegisterUnitEvent(27229, 4, "ForgottenFootman_OnDied")


--[[ Dragonblight -- Forgotten Knight.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ForgottenKnight_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenKnight_Throw", 5000, 0)
end

function ForgottenKnight_Throw(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38556, pUnit:GetMainTank()) 
end

function ForgottenKnight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenKnight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenKnight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27224, 1, "ForgottenKnight_OnCombat")
RegisterUnitEvent(27224, 2, "ForgottenKnight_OnLeaveCombat")
RegisterUnitEvent(27224, 3, "ForgottenKnight_OnKilledTarget")
RegisterUnitEvent(27224, 4, "ForgottenKnight_OnDied")


--[[ Dragonblight -- Forgotten Peasant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ForgottenPeasant_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenPeasant_Bonk", 6000, 0)
end

function ForgottenPeasant_Bonk(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51601, pUnit:GetMainTank()) 
end

function ForgottenPeasant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenPeasant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenPeasant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27226, 1, "ForgottenPeasant_OnCombat")
RegisterUnitEvent(27226, 2, "ForgottenPeasant_OnLeaveCombat")
RegisterUnitEvent(27226, 3, "ForgottenPeasant_OnKilledTarget")
RegisterUnitEvent(27226, 4, "ForgottenPeasant_OnDied")


--[[ Dragonblight -- Forgotten Rifleman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function ForgottenRifleman_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenRifleman_ConcussiveShot", 7000, 0)
Unit:RegisterEvent("ForgottenRifleman_Shoot", 5000, 0)
end

function ForgottenRifleman_ConcussiveShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(17174, pUnit:GetMainTank()) 
end

function ForgottenRifleman_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15547, pUnit:GetMainTank()) 
end

function ForgottenRifleman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenRifleman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenRifleman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27225, 1, "ForgottenRifleman_OnCombat")
RegisterUnitEvent(27225, 2, "ForgottenRifleman_OnLeaveCombat")
RegisterUnitEvent(27225, 3, "ForgottenRifleman_OnKilledTarget")
RegisterUnitEvent(27225, 4, "ForgottenRifleman_OnDied")


--[[ Dragonblight -- Frenzied Gargoyle.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FrenziedGargoyle_OnCombat(Unit, Event)
Unit:RegisterEvent("FrenziedGargoyle_GargoyleStrike", 6500, 0)
end

function FrenziedGargoyle_GargoyleStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(31664, pUnit:GetMainTank()) 
end

function FrenziedGargoyle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrenziedGargoyle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrenziedGargoyle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27691, 1, "FrenziedGargoyle_OnCombat")
RegisterUnitEvent(27691, 2, "FrenziedGargoyle_OnLeaveCombat")
RegisterUnitEvent(27691, 3, "FrenziedGargoyle_OnKilledTarget")
RegisterUnitEvent(27691, 4, "FrenziedGargoyle_OnDied")


--[[ Dragonblight -- Frigid Abomination Attacker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FrigidAbominationAttacker_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidAbominationAttacker_Cleave", 8000, 0)
end

function FrigidAbominationAttacker_Cleave(pUnit, Event) 
pUnit:CastSpell(40504) 
end

function FrigidAbominationAttacker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidAbominationAttacker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidAbominationAttacker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27531, 1, "FrigidAbominationAttacker_OnCombat")
RegisterUnitEvent(27531, 2, "FrigidAbominationAttacker_OnLeaveCombat")
RegisterUnitEvent(27531, 3, "FrigidAbominationAttacker_OnKilledTarget")
RegisterUnitEvent(27531, 4, "FrigidAbominationAttacker_OnDied")


--[[ Dragonblight -- Frigid Ghoul.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FrigidGhoul_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidGhoul_RotArmor", 8000, 0)
end

function FrigidGhoul_RotArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50361, pUnit:GetMainTank()) 
end

function FrigidGhoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidGhoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidGhoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27534, 1, "FrigidGhoul_OnCombat")
RegisterUnitEvent(27534, 2, "FrigidGhoul_OnLeaveCombat")
RegisterUnitEvent(27534, 3, "FrigidGhoul_OnKilledTarget")
RegisterUnitEvent(27534, 4, "FrigidGhoul_OnDied")


--[[ Dragonblight -- Frigid Ghoul Attacker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FrigidGhoulAttacker_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidGhoulAttacker_RotArmor", 8000, 0)
end

function FrigidGhoulAttacker_RotArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50361, pUnit:GetMainTank()) 
end

function FrigidGhoulAttacker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidGhoulAttacker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidGhoulAttacker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27685, 1, "FrigidGhoulAttacker_OnCombat")
RegisterUnitEvent(27685, 2, "FrigidGhoulAttacker_OnLeaveCombat")
RegisterUnitEvent(27685, 3, "FrigidGhoulAttacker_OnKilledTarget")
RegisterUnitEvent(27685, 4, "FrigidGhoulAttacker_OnDied")


--[[ Dragonblight -- Frigid Necromancer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FrigidNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidNecromancer_BoneArmor", 2000, 1)
Unit:RegisterEvent("FrigidNecromancer_ShadowBolt", 7000, 0)
end

function FrigidNecromancer_BoneArmor(pUnit, Event) 
pUnit:CastSpell(50324) 
end

function FrigidNecromancer_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function FrigidNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27539, 1, "FrigidNecromancer_OnCombat")
RegisterUnitEvent(27539, 2, "FrigidNecromancer_OnLeaveCombat")
RegisterUnitEvent(27539, 3, "FrigidNecromancer_OnKilledTarget")
RegisterUnitEvent(27539, 4, "FrigidNecromancer_OnDied")


--[[ Dragonblight -- Frigid Necromancer Attacker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function FrigidNecromancerAttacker_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidNecromancerAttacker_BoneArmor", 2000, 1)
Unit:RegisterEvent("FrigidNecromancerAttacker_ShadowBolt", 7000, 0)
end

function FrigidNecromancerAttacker_BoneArmor(pUnit, Event) 
pUnit:CastSpell(50324) 
end

function FrigidNecromancerAttacker_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function FrigidNecromancerAttacker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidNecromancerAttacker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidNecromancerAttacker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27687, 1, "FrigidNecromancerAttacker_OnCombat")
RegisterUnitEvent(27687, 2, "FrigidNecromancerAttacker_OnLeaveCombat")
RegisterUnitEvent(27687, 3, "FrigidNecromancerAttacker_OnKilledTarget")
RegisterUnitEvent(27687, 4, "FrigidNecromancerAttacker_OnDied")


--[[ Dragonblight -- Gigantaur.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Gigantaur_OnCombat(Unit, Event)
Unit:RegisterEvent("Gigantaur_GiganticBlow", 6000, 0)
Unit:RegisterEvent("Gigantaur_Hamstring", 8000, 0)
end

function Gigantaur_GiganticBlow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52139, pUnit:GetMainTank()) 
end

function Gigantaur_Hamstring(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9080, pUnit:GetMainTank()) 
end

function Gigantaur_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Gigantaur_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Gigantaur_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26836, 1, "Gigantaur_OnCombat")
RegisterUnitEvent(26836, 2, "Gigantaur_OnLeaveCombat")
RegisterUnitEvent(26836, 3, "Gigantaur_OnKilledTarget")
RegisterUnitEvent(26836, 4, "Gigantaur_OnDied")


--[[ Dragonblight -- Goramosh.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Goramosh_OnCombat(Unit, Event)
Unit:RegisterEvent("Goramosh_ConeofCold", 6000, 0)
Unit:RegisterEvent("Goramosh_Frostbolt", 8000, 0)
end

function Goramosh_ConeofCold(pUnit, Event) 
pUnit:CastSpell(20828) 
end

function Goramosh_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9672, pUnit:GetMainTank()) 
end

function Goramosh_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Goramosh_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Goramosh_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26349, 1, "Goramosh_OnCombat")
RegisterUnitEvent(26349, 2, "Goramosh_OnLeaveCombat")
RegisterUnitEvent(26349, 3, "Goramosh_OnKilledTarget")
RegisterUnitEvent(26349, 4, "Goramosh_OnDied")


--[[ Dragonblight -- Grand Necrolord Antiok.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function GrandNecrolordAntiok_OnCombat(Unit, Event)
Unit:RegisterEvent("GrandNecrolordAntiok_ScreamofChaos", 15000, 1)
Unit:RegisterEvent("GrandNecrolordAntiok_ShadowBolt", 8000, 0)
Unit:RegisterEvent("GrandNecrolordAntiok_ShroudofLightning", 28000, 1)
end

function GrandNecrolordAntiok_ScreamofChaos(pUnit, Event) 
pUnit:CastSpell(50497) 
end

function GrandNecrolordAntiok_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(55984, pUnit:GetMainTank()) 
end

function GrandNecrolordAntiok_ShroudofLightning(pUnit, Event) 
pUnit:CastSpell(50494) 
end

function GrandNecrolordAntiok_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GrandNecrolordAntiok_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GrandNecrolordAntiok_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28006, 1, "GrandNecrolordAntiok_OnCombat")
RegisterUnitEvent(28006, 2, "GrandNecrolordAntiok_OnLeaveCombat")
RegisterUnitEvent(28006, 3, "GrandNecrolordAntiok_OnKilledTarget")
RegisterUnitEvent(28006, 4, "GrandNecrolordAntiok_OnDied")


--[[ Dragonblight -- Gromthar the Thunderbringer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function GromthartheThunderbringer_OnCombat(Unit, Event)
Unit:RegisterEvent("GromthartheThunderbringer_MagnataurCharge", 8000, 0)
Unit:RegisterEvent("GromthartheThunderbringer_Thunder", 10000, 0)
end

function GromthartheThunderbringer_MagnataurCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52169, pUnit:GetMainTank()) 
end

function GromthartheThunderbringer_Thunder(pUnit, Event) 
pUnit:CastSpell(52166) 
end

function GromthartheThunderbringer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GromthartheThunderbringer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GromthartheThunderbringer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27002, 1, "GromthartheThunderbringer_OnCombat")
RegisterUnitEvent(27002, 2, "GromthartheThunderbringer_OnLeaveCombat")
RegisterUnitEvent(27002, 3, "GromthartheThunderbringer_OnKilledTarget")
RegisterUnitEvent(27002, 4, "GromthartheThunderbringer_OnDied")


--[[ Dragonblight -- High Cultist Zangus.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function HighCultistZangus_OnCombat(Unit, Event)
Unit:RegisterEvent("HighCultistZangus_ShadowBolt", 7000, 0)
Unit:RegisterEvent("HighCultistZangus_Zeal", 2000, 1)
end

function HighCultistZangus_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function HighCultistZangus_Zeal(pUnit, Event) 
pUnit:CastSpell(51605) 
end

function HighCultistZangus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighCultistZangus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighCultistZangus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26655, 1, "HighCultistZangus_OnCombat")
RegisterUnitEvent(26655, 2, "HighCultistZangus_OnLeaveCombat")
RegisterUnitEvent(26655, 3, "HighCultistZangus_OnKilledTarget")
RegisterUnitEvent(26655, 4, "HighCultistZangus_OnDied")


--[[ Dragonblight -- High General Abbendis.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function HighGeneralAbbendis_OnCombat(Unit, Event)
Unit:RegisterEvent("HighGeneralAbbendis_JudgementofOnslaught", 4000, 1)
Unit:RegisterEvent("HighGeneralAbbendis_RagingConsecration", 6000, 1)
Unit:RegisterEvent("HighGeneralAbbendis_SealofOnslaught", 8000, 1)
end

function HighGeneralAbbendis_JudgementofOnslaught(pUnit, Event) 
pUnit:CastSpell(50905) 
end

function HighGeneralAbbendis_RagingConsecration(pUnit, Event) 
pUnit:CastSpell(50915) 
end

function HighGeneralAbbendis_SealofOnslaught(pUnit, Event) 
pUnit:CastSpell(50908) 
end

function HighGeneralAbbendis_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighGeneralAbbendis_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighGeneralAbbendis_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27210, 1, "HighGeneralAbbendis_OnCombat")
RegisterUnitEvent(27210, 2, "HighGeneralAbbendis_OnLeaveCombat")
RegisterUnitEvent(27210, 3, "HighGeneralAbbendis_OnKilledTarget")
RegisterUnitEvent(27210, 4, "HighGeneralAbbendis_OnDied")


--[[ Dragonblight -- High Shaman Bloodpaw.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function HighShamanBloodpaw_OnCombat(Unit, Event)
Unit:RegisterEvent("HighShamanBloodpaw_Bloodlust", 11000, 0)
Unit:RegisterEvent("HighShamanBloodpaw_ChainLightning", 10000, 0)
Unit:RegisterEvent("HighShamanBloodpaw_FrostShock", 6000, 0)
Unit:RegisterEvent("HighShamanBloodpaw_LightningBolt", 8000, 0)
end

function HighShamanBloodpaw_Bloodlust(pUnit, Event) 
pUnit:CastSpell(28902) 
end

function HighShamanBloodpaw_ChainLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(22355, pUnit:GetMainTank()) 
end

function HighShamanBloodpaw_FrostShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(19133, pUnit:GetMainTank()) 
end

function HighShamanBloodpaw_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(22414, pUnit:GetMainTank()) 
end

function HighShamanBloodpaw_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighShamanBloodpaw_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighShamanBloodpaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27762, 1, "HighShamanBloodpaw_OnCombat")
RegisterUnitEvent(27762, 2, "HighShamanBloodpaw_OnLeaveCombat")
RegisterUnitEvent(27762, 3, "HighShamanBloodpaw_OnKilledTarget")
RegisterUnitEvent(27762, 4, "HighShamanBloodpaw_OnDied")


--[[ Dragonblight -- Horde Conscript.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function HordeConscript_OnCombat(Unit, Event)
Unit:RegisterEvent("HordeConscript_HeroicStrike", 8000, 0)
Unit:RegisterEvent("HordeConscript_Shoot", 6000, 0)
end

function HordeConscript_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(29426, pUnit:GetMainTank()) 
end

function HordeConscript_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15620, pUnit:GetMainTank()) 
end

function HordeConscript_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HordeConscript_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HordeConscript_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27749, 1, "HordeConscript_OnCombat")
RegisterUnitEvent(27749, 2, "HordeConscript_OnLeaveCombat")
RegisterUnitEvent(27749, 3, "HordeConscript_OnKilledTarget")
RegisterUnitEvent(27749, 4, "HordeConscript_OnDied")


--[[ Dragonblight -- Hulking Atrocity.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function HulkingAtrocity_OnCombat(Unit, Event)
Unit:RegisterEvent("HulkingAtrocity_InfectedBite", 7000, 0)
end

function HulkingAtrocity_InfectedBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49861, pUnit:GetMainTank()) 
end

function HulkingAtrocity_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HulkingAtrocity_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HulkingAtrocity_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26948, 1, "HulkingAtrocity_OnCombat")
RegisterUnitEvent(26948, 2, "HulkingAtrocity_OnLeaveCombat")
RegisterUnitEvent(26948, 3, "HulkingAtrocity_OnKilledTarget")
RegisterUnitEvent(26948, 4, "HulkingAtrocity_OnDied")


--[[ Dragonblight -- Hulking Jormungar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function HulkingJormungar_OnCombat(Unit, Event)
Unit:RegisterEvent("HulkingJormungar_CorrosivePoison", 4000, 1)
Unit:RegisterEvent("HulkingJormungar_CorrosiveSpit", 6000, 1)
end

function HulkingJormungar_CorrosivePoison(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50293, pUnit:GetMainTank()) 
end

function HulkingJormungar_CorrosiveSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47611, pUnit:GetMainTank()) 
end

function HulkingJormungar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HulkingJormungar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HulkingJormungar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26293, 1, "HulkingJormungar_OnCombat")
RegisterUnitEvent(26293, 2, "HulkingJormungar_OnLeaveCombat")
RegisterUnitEvent(26293, 3, "HulkingJormungar_OnKilledTarget")
RegisterUnitEvent(26293, 4, "HulkingJormungar_OnDied")


--[[ Dragonblight -- Ice Heart Jormungar Feeder.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function IceHeartJormungarFeeder_OnCombat(Unit, Event)
Unit:RegisterEvent("IceHeartJormungarFeeder_CorrosiveSpit", 6000, 1)
end

function IceHeartJormungarFeeder_CorrosiveSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47447, pUnit:GetMainTank()) 
end

function IceHeartJormungarFeeder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceHeartJormungarFeeder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceHeartJormungarFeeder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26358, 1, "IceHeartJormungarFeeder_OnCombat")
RegisterUnitEvent(26358, 2, "IceHeartJormungarFeeder_OnLeaveCombat")
RegisterUnitEvent(26358, 3, "IceHeartJormungarFeeder_OnKilledTarget")
RegisterUnitEvent(26358, 4, "IceHeartJormungarFeeder_OnDied")


--[[ Dragonblight -- Ice Heart Jormungar Spawn.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function IceHeartJormungarSpawn_OnCombat(Unit, Event)
Unit:RegisterEvent("IceHeartJormungarSpawn_GutRip", 5000, 3)
end

function IceHeartJormungarSpawn_GutRip(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43358, pUnit:GetMainTank()) 
end

function IceHeartJormungarSpawn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceHeartJormungarSpawn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceHeartJormungarSpawn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26359, 1, "IceHeartJormungarSpawn_OnCombat")
RegisterUnitEvent(26359, 2, "IceHeartJormungarSpawn_OnLeaveCombat")
RegisterUnitEvent(26359, 3, "IceHeartJormungarSpawn_OnKilledTarget")
RegisterUnitEvent(26359, 4, "IceHeartJormungarSpawn_OnDied")


--[[ Dragonblight -- Ice Revenant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function IceRevenant_OnCombat(Unit, Event)
Unit:RegisterEvent("IceRevenant_IcyTorrent", 7000, 0)
end

function IceRevenant_IcyTorrent(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51584, pUnit:GetMainTank()) 
end

function IceRevenant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceRevenant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceRevenant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26283, 1, "IceRevenant_OnCombat")
RegisterUnitEvent(26283, 2, "IceRevenant_OnLeaveCombat")
RegisterUnitEvent(26283, 3, "IceRevenant_OnKilledTarget")
RegisterUnitEvent(26283, 4, "IceRevenant_OnDied")


--[[ Dragonblight -- Icefist.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Icefist_OnCombat(Unit, Event)
Unit:RegisterEvent("Icefist_IceSlash", 6000, 0)
Unit:RegisterEvent("Icefist_TuskStrike", 8000, 0)
end

function Icefist_IceSlash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51878, pUnit:GetMainTank()) 
end

function Icefist_TuskStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50410, pUnit:GetMainTank()) 
end

function Icefist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icefist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icefist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27004, 1, "Icefist_OnCombat")
RegisterUnitEvent(27004, 2, "Icefist_OnLeaveCombat")
RegisterUnitEvent(27004, 3, "Icefist_OnKilledTarget")
RegisterUnitEvent(27004, 4, "Icefist_OnDied")


--[[ Dragonblight -- Iceshatter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Iceshatter_OnCombat(Unit, Event)
Unit:RegisterEvent("Iceshatter_MagnataurCharge", 8000, 0)
Unit:RegisterEvent("Iceshatter_PulsingShards", 6000, 0)
end

function Iceshatter_MagnataurCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52088, pUnit:GetMainTank()) 
end

function Iceshatter_PulsingShards(pUnit, Event) 
pUnit:CastSpell(52118) 
end

function Iceshatter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Iceshatter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Iceshatter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27007, 1, "Iceshatter_OnCombat")
RegisterUnitEvent(27007, 2, "Iceshatter_OnLeaveCombat")
RegisterUnitEvent(27007, 3, "Iceshatter_OnKilledTarget")
RegisterUnitEvent(27007, 4, "Iceshatter_OnDied")


--[[ Dragonblight -- Icestorm.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Icestorm_OnCombat(Unit, Event)
Unit:RegisterEvent("Icestorm_FrostBreath", 7000, 0)
end

function Icestorm_FrostBreath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47428, pUnit:GetMainTank()) 
end

function Icestorm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icestorm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icestorm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26287, 1, "Icestorm_OnCombat")
RegisterUnitEvent(26287, 2, "Icestorm_OnLeaveCombat")
RegisterUnitEvent(26287, 3, "Icestorm_OnKilledTarget")
RegisterUnitEvent(26287, 4, "Icestorm_OnDied")


--[[ Dragonblight -- Indule Fisherman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InduleFisherman_OnCombat(Unit, Event)
Unit:RegisterEvent("InduleFisherman_ElectrifiedNet", 10000, 0)
end

function InduleFisherman_ElectrifiedNet(pUnit, Event) 
pUnit:FullCastSpellOnTarget(11820, pUnit:GetMainTank()) 
end

function InduleFisherman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InduleFisherman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InduleFisherman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26343, 1, "InduleFisherman_OnCombat")
RegisterUnitEvent(26343, 2, "InduleFisherman_OnLeaveCombat")
RegisterUnitEvent(26343, 3, "InduleFisherman_OnKilledTarget")
RegisterUnitEvent(26343, 4, "InduleFisherman_OnDied")


--[[ Dragonblight -- Indule Mystic.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InduleMystic_OnCombat(Unit, Event)
Unit:RegisterEvent("InduleMystic_MysticalBolt", 6000, 0)
end

function InduleMystic_MysticalBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51787, pUnit:GetMainTank()) 
end

function InduleMystic_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InduleMystic_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InduleMystic_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26336, 1, "InduleMystic_OnCombat")
RegisterUnitEvent(26336, 2, "InduleMystic_OnLeaveCombat")
RegisterUnitEvent(26336, 3, "InduleMystic_OnKilledTarget")
RegisterUnitEvent(26336, 4, "InduleMystic_OnDied")


--[[ Dragonblight -- Indule Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InduleWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("InduleWarrior_SpectralStrike", 6000, 0)
end

function InduleWarrior_SpectralStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51786, pUnit:GetMainTank()) 
end

function InduleWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InduleWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InduleWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26344, 1, "InduleWarrior_OnCombat")
RegisterUnitEvent(26344, 2, "InduleWarrior_OnLeaveCombat")
RegisterUnitEvent(26344, 3, "InduleWarrior_OnKilledTarget")
RegisterUnitEvent(26344, 4, "InduleWarrior_OnDied")


--[[ Dragonblight -- Indule Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InfiniteChronoMagus_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteChronoMagus_ShadowBlast", 9000, 0)
Unit:RegisterEvent("InfiniteChronoMagus_ShadowBolt", 6000, 0)
end

function InfiniteChronoMagus_ShadowBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38085, pUnit:GetMainTank()) 
end

function InfiniteChronoMagus_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function InfiniteChronoMagus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteChronoMagus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteChronoMagus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27898, 1, "InfiniteChronoMagus_OnCombat")
RegisterUnitEvent(27898, 2, "InfiniteChronoMagus_OnLeaveCombat")
RegisterUnitEvent(27898, 3, "InfiniteChronoMagus_OnKilledTarget")
RegisterUnitEvent(27898, 4, "InfiniteChronoMagus_OnDied")


--[[ Dragonblight -- Infinite Eradicator.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InfiniteEradicator_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteEradicator_Hasten", 2000, 1)
Unit:RegisterEvent("InfiniteEradicator_TemporalVortex", 6000, 0)
Unit:RegisterEvent("InfiniteEradicator_WingBuffet", 8000, 0)
end

function InfiniteEradicator_Hasten(pUnit, Event) 
pUnit:CastSpell(31458) 
end

function InfiniteEradicator_TemporalVortex(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52657, pUnit:GetMainTank()) 
end

function InfiniteEradicator_WingBuffet(pUnit, Event) 
pUnit:CastSpell(31475) 
end

function InfiniteEradicator_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteEradicator_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteEradicator_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32185, 1, "InfiniteEradicator_OnCombat")
RegisterUnitEvent(32185, 2, "InfiniteEradicator_OnLeaveCombat")
RegisterUnitEvent(32185, 3, "InfiniteEradicator_OnKilledTarget")
RegisterUnitEvent(32185, 4, "InfiniteEradicator_OnDied")


--[[ Dragonblight -- Infinite Eradicator.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InfiniteTimebreaker_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteTimebreaker_Enrage", 8000, 0)
Unit:RegisterEvent("InfiniteTimebreaker_TimeStop", 12000, 2)
end

function InfiniteTimebreaker_Enrage(pUnit, Event) 
pUnit:CastSpell(60075) 
end

function InfiniteTimebreaker_TimeStop(pUnit, Event) 
pUnit:FullCastSpellOnTarget(60074, pUnit:GetMainTank()) 
end

function InfiniteTimebreaker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteTimebreaker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteTimebreaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32186, 1, "InfiniteTimebreaker_OnCombat")
RegisterUnitEvent(32186, 2, "InfiniteTimebreaker_OnLeaveCombat")
RegisterUnitEvent(32186, 3, "InfiniteTimebreaker_OnKilledTarget")
RegisterUnitEvent(32186, 4, "InfiniteTimebreaker_OnDied")


--[[ Dragonblight -- Infinite Timerender.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InfiniteTimerender_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteTimerender_TimeLapse", 7000, 0)
end

function InfiniteTimerender_TimeLapse(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51020, pUnit:GetMainTank()) 
end

function InfiniteTimerender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteTimerender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteTimerender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27900, 1, "InfiniteTimerender_OnCombat")
RegisterUnitEvent(27900, 2, "InfiniteTimerender_OnLeaveCombat")
RegisterUnitEvent(27900, 3, "InfiniteTimerender_OnKilledTarget")
RegisterUnitEvent(27900, 4, "InfiniteTimerender_OnDied")


--[[ Dragonblight -- Infinite Timerendertwo.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InfiniteTimerender_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteTimerender_TimeLapse", 7000, 0)
end

function InfiniteTimerender_TimeLapse(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51020, pUnit:GetMainTank()) 
end

function InfiniteTimerender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteTimerender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteTimerender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27900, 1, "InfiniteTimerender_OnCombat")
RegisterUnitEvent(27900, 2, "InfiniteTimerender_OnLeaveCombat")
RegisterUnitEvent(27900, 3, "InfiniteTimerender_OnKilledTarget")
RegisterUnitEvent(27900, 4, "InfiniteTimerender_OnDied")


--[[ Dragonblight -- Injured Mammoth.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function InjuredMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredMammoth_Trample", 6000, 0)
end

function InjuredMammoth_Trample(pUnit, Event) 
pUnit:CastSpell(51944) 
end

function InjuredMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26711, 1, "InjuredMammoth_OnCombat")
RegisterUnitEvent(26711, 2, "InjuredMammoth_OnLeaveCombat")
RegisterUnitEvent(26711, 3, "InjuredMammoth_OnKilledTarget")
RegisterUnitEvent(26711, 4, "InjuredMammoth_OnDied")


--[[ Dragonblight -- Jormungar Tunneler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function JormungarTunneler_OnCombat(Unit, Event)
Unit:RegisterEvent("JormungarTunneler_CorrodeFlesh", 4000, 1)
end

function JormungarTunneler_CorrodeFlesh(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51879, pUnit:GetMainTank()) 
end

function JormungarTunneler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function JormungarTunneler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function JormungarTunneler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26467, 1, "JormungarTunneler_OnCombat")
RegisterUnitEvent(26467, 2, "JormungarTunneler_OnLeaveCombat")
RegisterUnitEvent(26467, 3, "JormungarTunneler_OnKilledTarget")
RegisterUnitEvent(26467, 4, "JormungarTunneler_OnDied")


--[[ Dragonblight -- Kiliua .lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function Kiliua_OnCombat(Unit, Event)
Unit:RegisterEvent("Kiliua_ClawGrasp", 9000, 0)
end

function Kiliua_ClawGrasp(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53442, pUnit:GetMainTank()) 
end

function Kiliua_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Kiliua_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Kiliua_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26521, 1, "Kiliua_OnCombat")
RegisterUnitEvent(26521, 2, "Kiliua_OnLeaveCombat")
RegisterUnitEvent(26521, 3, "Kiliua_OnKilledTarget")
RegisterUnitEvent(26521, 4, "Kiliua_OnDied")


--[[ Dragonblight -- Kreug Oathbreaker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function KreugOathbreaker_OnCombat(Unit, Event)
Unit:RegisterEvent("KreugOathbreaker_Backbreaker", 12000, 0)
Unit:RegisterEvent("KreugOathbreaker_BrokenOath", 13000, 0)
Unit:RegisterEvent("KreugOathbreaker_InciteHorror", 14000, 0)
end

function KreugOathbreaker_Backbreaker(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53437, pUnit:GetMainTank()) 
end

function KreugOathbreaker_BrokenOath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(56310) 
end

function KreugOathbreaker_InciteHorror(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53438, pUnit:GetMainTank()) 
end

function KreugOathbreaker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KreugOathbreaker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KreugOathbreaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27105, 1, "KreugOathbreaker_OnCombat")
RegisterUnitEvent(27105, 2, "KreugOathbreaker_OnLeaveCombat")
RegisterUnitEvent(27105, 3, "KreugOathbreaker_OnKilledTarget")
RegisterUnitEvent(27105, 4, "KreugOathbreaker_OnDied")


--[[ Dragonblight -- Lead Cannoneer Zierhut.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 1th, 2009. ]]


function LeadCannoneerZierhut_OnCombat(Unit, Event)
Unit:RegisterEvent("LeadCannoneerZierhut_TorchToss", 2000, 1)
end

function LeadCannoneerZierhut_TorchToss(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50832, pUnit:GetMainTank()) 
end

function LeadCannoneerZierhut_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LeadCannoneerZierhut_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LeadCannoneerZierhut_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27235, 1, "LeadCannoneerZierhut_OnCombat")
RegisterUnitEvent(27235, 2, "LeadCannoneerZierhut_OnLeaveCombat")
RegisterUnitEvent(27235, 3, "LeadCannoneerZierhut_OnKilledTarget")
RegisterUnitEvent(27235, 4, "LeadCannoneerZierhut_OnDied")


--[[ Dragonblight -- Legion Commander Tyralion.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function LegionCommanderTyralion_OnCombat(Unit, Event)
Unit:RegisterEvent("LegionCommanderTyralion_Shoot", 5000, 0)
end

function LegionCommanderTyralion_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15620, pUnit:GetMainTank()) 
end

function LegionCommanderTyralion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LegionCommanderTyralion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LegionCommanderTyralion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27844, 1, "LegionCommanderTyralion_OnCombat")
RegisterUnitEvent(27844, 2, "LegionCommanderTyralion_OnLeaveCombat")
RegisterUnitEvent(27844, 3, "LegionCommanderTyralion_OnKilledTarget")
RegisterUnitEvent(27844, 4, "LegionCommanderTyralion_OnDied")


--[[ Dragonblight -- Legion Commander Yorik.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function LegionCommanderYorik_OnCombat(Unit, Event)
Unit:RegisterEvent("LegionCommanderYorik_Shoot", 5000, 0)
end

function LegionCommanderYorik_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15620, pUnit:GetMainTank()) 
end

function LegionCommanderYorik_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LegionCommanderYorik_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LegionCommanderYorik_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27857, 1, "LegionCommanderYorik_OnCombat")
RegisterUnitEvent(27857, 2, "LegionCommanderYorik_OnLeaveCombat")
RegisterUnitEvent(27857, 3, "LegionCommanderYorik_OnKilledTarget")
RegisterUnitEvent(27857, 4, "LegionCommanderYorik_OnDied")


--[[ Dragonblight -- Leprous Servant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function LeprousServant_OnCombat(Unit, Event)
Unit:RegisterEvent("LeprousServant_LeprousTouch", 8000, 0)
end

function LeprousServant_LeprousTouch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51315, pUnit:GetMainTank()) 
end

function LeprousServant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LeprousServant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LeprousServant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27800, 1, "LeprousServant_OnCombat")
RegisterUnitEvent(27800, 2, "LeprousServant_OnLeaveCombat")
RegisterUnitEvent(27800, 3, "LeprousServant_OnKilledTarget")
RegisterUnitEvent(27800, 4, "LeprousServant_OnDied")


--[[ Dragonblight -- Lieutenant Tazinni.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function LieutenantTazinni_OnCombat(Unit, Event)
Unit:RegisterEvent("LieutenantTazinni_DragonsBreath", 7000, 0)
Unit:RegisterEvent("LieutenantTazinni_FrostfireBolt", 8000, 0)
end

function LieutenantTazinni_DragonsBreath(pUnit, Event) 
pUnit:CastSpell(35250) 
end

function LieutenantTazinni_FrostfireBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51779, pUnit:GetMainTank()) 
end

function LieutenantTazinni_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LieutenantTazinni_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LieutenantTazinni_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26815, 1, "LieutenantTazinni_OnCombat")
RegisterUnitEvent(26815, 2, "LieutenantTazinni_OnLeaveCombat")
RegisterUnitEvent(26815, 3, "LieutenantTazinni_OnKilledTarget")
RegisterUnitEvent(26815, 4, "LieutenantTazinni_OnDied")


--[[ Dragonblight -- Loguhn.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function Loguhn_OnCombat(Unit, Event)
Unit:RegisterEvent("Loguhn_Enrage", 10000, 1)
Unit:RegisterEvent("Loguhn_SunderArmor", 5000, 0)
end

function Loguhn_Enrage(pUnit, Event) 
pUnit:CastSpell(8599)
end

function Loguhn_SunderArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50370, pUnit:GetMainTank()) 
end

function Loguhn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Loguhn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Loguhn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26196, 1, "Loguhn_OnCombat")
RegisterUnitEvent(26196, 2, "Loguhn_OnLeaveCombat")
RegisterUnitEvent(26196, 3, "Loguhn_OnKilledTarget")
RegisterUnitEvent(26196, 4, "Loguhn_OnDied")


--[[ Dragonblight -- Magnataur Patriarch.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function MagnataurPatriarch_OnCombat(Unit, Event)
Unit:RegisterEvent("MagnataurPatriarch_Throw", 5000, 0)
end

function MagnataurPatriarch_Throw(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38556, pUnit:GetMainTank()) 
end

function MagnataurPatriarch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagnataurPatriarch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagnataurPatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26295, 1, "MagnataurPatriarch_OnCombat")
RegisterUnitEvent(26295, 2, "MagnataurPatriarch_OnLeaveCombat")
RegisterUnitEvent(26295, 3, "MagnataurPatriarch_OnKilledTarget")
RegisterUnitEvent(26295, 4, "MagnataurPatriarch_OnDied")


--[[ Dragonblight -- Magister Keldonus.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function MagisterKeldonus_OnCombat(Unit, Event)
Unit:RegisterEvent("MagisterKeldonus_ArcaneBlast", 10000, 0)
Unit:RegisterEvent("MagisterKeldonus_FuryoftheBlue", 15000, 0)
Unit:RegisterEvent("MagisterKeldonus_MightofMalygos", 6000, 1)
Unit:RegisterEvent("MagisterKeldonus_PowerFlux", 13000, 0)
Unit:RegisterEvent("MagisterKeldonus_PowerSiphon", 18000, 0)
end

function MagisterKeldonus_ArcaneBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51830, pUnit:GetMainTank()) 
end

function MagisterKeldonus_FuryoftheBlue(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51808, pUnit:GetMainTank()) 
end

function MagisterKeldonus_MightofMalygos(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51800, pUnit:GetMainTank()) 
end

function MagisterKeldonus_PowerFlux(pUnit, Event) 
pUnit:CastSpell(51806) 
end

function MagisterKeldonus_PowerSiphon(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51804, pUnit:GetMainTank()) 
end

function MagisterKeldonus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagisterKeldonus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagisterKeldonus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26828, 1, "MagisterKeldonus_OnCombat")
RegisterUnitEvent(26828, 2, "MagisterKeldonus_OnLeaveCombat")
RegisterUnitEvent(26828, 3, "MagisterKeldonus_OnKilledTarget")
RegisterUnitEvent(26828, 4, "MagisterKeldonus_OnDied")


--[[ Dragonblight -- Mindless Wight.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function MindlessWight_OnCombat(Unit, Event)
Unit:RegisterEvent("MindlessWight_Smash", 6000, 0)
end

function MindlessWight_Smash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51334, pUnit:GetMainTank()) 
end

function MindlessWight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MindlessWight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MindlessWight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27287, 1, "MindlessWight_OnCombat")
RegisterUnitEvent(27287, 2, "MindlessWight_OnLeaveCombat")
RegisterUnitEvent(27287, 3, "MindlessWight_OnKilledTarget")
RegisterUnitEvent(27287, 4, "MindlessWight_OnDied")


--[[ Dragonblight -- Mistress of the Coldwind.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function MistressoftheColdwind_OnCombat(Unit, Event)
Unit:RegisterEvent("MistressoftheColdwind_ArcticWinds", 6500, 0)
Unit:RegisterEvent("MistressoftheColdwind_Renew", 18000, 0)
end

function MistressoftheColdwind_ArcticWinds(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52814, pUnit:GetMainTank()) 
end

function MistressoftheColdwind_Renew(pUnit, Event) 
pUnit:CastSpell(38210) 
end

function MistressoftheColdwind_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MistressoftheColdwind_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MistressoftheColdwind_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26578, 1, "MistressoftheColdwind_OnCombat")
RegisterUnitEvent(26578, 2, "MistressoftheColdwind_OnLeaveCombat")
RegisterUnitEvent(26578, 3, "MistressoftheColdwind_OnKilledTarget")
RegisterUnitEvent(26578, 4, "MistressoftheColdwind_OnDied")


--[[ Dragonblight -- Moonrest Highborne.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function MoonrestHighborne_OnCombat(Unit, Event)
Unit:RegisterEvent("MoonrestHighborne_ShadowWordDeath", 6000, 0)
end

function MoonrestHighborne_ShadowWordDeath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51818, pUnit:GetMainTank()) 
end

function MoonrestHighborne_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MoonrestHighborne_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MoonrestHighborne_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26455, 1, "MoonrestHighborne_OnCombat")
RegisterUnitEvent(26455, 2, "MoonrestHighborne_OnLeaveCombat")
RegisterUnitEvent(26455, 3, "MoonrestHighborne_OnKilledTarget")
RegisterUnitEvent(26455, 4, "MoonrestHighborne_OnDied")


--[[ Dragonblight -- Moonrest Stalker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function MoonrestStalker_OnCombat(Unit, Event)
Unit:RegisterEvent("MoonrestStalker_ManaBurn", 4000, 0)
end

function MoonrestStalker_ManaBurn(pUnit, Event) 
pUnit:FullCastSpellOnTarget(2691, pUnit:GetRandomPlayer(4)) 
end

function MoonrestStalker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MoonrestStalker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MoonrestStalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26281, 1, "MoonrestStalker_OnCombat")
RegisterUnitEvent(26281, 2, "MoonrestStalker_OnLeaveCombat")
RegisterUnitEvent(26281, 3, "MoonrestStalker_OnKilledTarget")
RegisterUnitEvent(26281, 4, "MoonrestStalker_OnDied")


--[[ Dragonblight -- Naxxramas Necrolord.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function NaxxramasNecrolord_OnCombat(Unit, Event)
Unit:RegisterEvent("NaxxramasNecrolord_ChaosBolt", 6000, 0)
end

function NaxxramasNecrolord_ChaosBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51287, pUnit:GetMainTank()) 
end

function NaxxramasNecrolord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NaxxramasNecrolord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NaxxramasNecrolord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27289, 1, "NaxxramasNecrolord_OnCombat")
RegisterUnitEvent(27289, 2, "NaxxramasNecrolord_OnLeaveCombat")
RegisterUnitEvent(27289, 3, "NaxxramasNecrolord_OnKilledTarget")
RegisterUnitEvent(27289, 4, "NaxxramasNecrolord_OnDied")


--[[ Dragonblight -- Naxxramas Shade.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function NaxxramasShade_OnCombat(Unit, Event)
Unit:RegisterEvent("NaxxramasShade_BlinkStrike", 6000, 0)
Unit:RegisterEvent("NaxxramasShade_DarkStrike", 5500, 0)
end

function NaxxramasShade_BlinkStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49961, pUnit:GetMainTank()) 
end

function NaxxramasShade_DarkStrike(pUnit, Event) 
pUnit:CastSpell(38926) 
end

function NaxxramasShade_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NaxxramasShade_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NaxxramasShade_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27824, 1, "NaxxramasShade_OnCombat")
RegisterUnitEvent(27824, 2, "NaxxramasShade_OnLeaveCombat")
RegisterUnitEvent(27824, 3, "NaxxramasShade_OnKilledTarget")
RegisterUnitEvent(27824, 4, "NaxxramasShade_OnDied")


--[[ Dragonblight -- Necrolord Amarion.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function NecrolordAmarion_OnCombat(Unit, Event)
Unit:RegisterEvent("NecrolordAmarion_Decimate", 5500, 0)
end

function NecrolordAmarion_Decimate(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51339, pUnit:GetMainTank()) 
end

function NecrolordAmarion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NecrolordAmarion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NecrolordAmarion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27508, 1, "NecrolordAmarion_OnCombat")
RegisterUnitEvent(27508, 2, "NecrolordAmarion_OnLeaveCombat")
RegisterUnitEvent(27508, 3, "NecrolordAmarion_OnKilledTarget")
RegisterUnitEvent(27508, 4, "NecrolordAmarion_OnDied")


--[[ Dragonblight -- Necrolord Horus.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function NecrolordHorus_OnCombat(Unit, Event)
Unit:RegisterEvent("NecrolordHorus_CurseofImpotence", 4000, 1)
Unit:RegisterEvent("NecrolordHorus_ShadowBolt", 7000, 0)
end

function NecrolordHorus_CurseofImpotence(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51340, pUnit:GetMainTank()) 
end

function NecrolordHorus_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(20298, pUnit:GetMainTank()) 
end

function NecrolordHorus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NecrolordHorus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NecrolordHorus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27805, 1, "NecrolordHorus_OnCombat")
RegisterUnitEvent(27805, 2, "NecrolordHorus_OnLeaveCombat")
RegisterUnitEvent(27805, 3, "NecrolordHorus_OnKilledTarget")
RegisterUnitEvent(27805, 4, "NecrolordHorus_OnDied")


--[[ Dragonblight -- Necrolord Xavius.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function NecrolordXavius_OnCombat(Unit, Event)
Unit:RegisterEvent("NecrolordXavius_ShadowBolt", 7000, 0)
Unit:RegisterEvent("NecrolordXavius_Shadowflame", 6000, 0)
end

function NecrolordXavius_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(20298, pUnit:GetMainTank()) 
end

function NecrolordXavius_Shadowflame(pUnit, Event) 
pUnit:CastSpell(51337) 
end

function NecrolordXavius_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NecrolordXavius_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NecrolordXavius_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27826, 1, "NecrolordXavius_OnCombat")
RegisterUnitEvent(27826, 2, "NecrolordXavius_OnLeaveCombat")
RegisterUnitEvent(27826, 3, "NecrolordXavius_OnKilledTarget")
RegisterUnitEvent(27826, 4, "NecrolordXavius_OnDied")


--[[ Dragonblight -- Nexus Guardian.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function NexusGuardian_OnCombat(Unit, Event)
Unit:RegisterEvent("NexusGuardian_FrostBreath", 6500, 0)
Unit:RegisterEvent("NexusGuardian_FrostCleave", 8000, 0)
end

function NexusGuardian_FrostBreath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47425, pUnit:GetMainTank()) 
end

function NexusGuardian_FrostCleave(pUnit, Event) 
pUnit:CastSpell(51857) 
end

function NexusGuardian_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NexusGuardian_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NexusGuardian_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26276, 1, "NexusGuardian_OnCombat")
RegisterUnitEvent(26276, 2, "NexusGuardian_OnLeaveCombat")
RegisterUnitEvent(26276, 3, "NexusGuardian_OnKilledTarget")
RegisterUnitEvent(26276, 4, "NexusGuardian_OnDied")


--[[ Dragonblight -- Onslaught Bloodhound.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtBloodhound_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtBloodhound_Maul", 5000, 0)
end

function OnslaughtBloodhound_Maul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51875, pUnit:GetMainTank()) 
end

function OnslaughtBloodhound_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtBloodhound_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtBloodhound_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27329, 1, "OnslaughtBloodhound_OnCombat")
RegisterUnitEvent(27329, 2, "OnslaughtBloodhound_OnLeaveCombat")
RegisterUnitEvent(27329, 3, "OnslaughtBloodhound_OnKilledTarget")
RegisterUnitEvent(27329, 4, "OnslaughtBloodhound_OnDied")


--[[ Dragonblight -- Onslaught Commander Iustus.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtCommanderIustus_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtCommanderIustus_Bloodthirst", 6000, 0)
Unit:RegisterEvent("OnslaughtCommanderIustus_Whirlwind", 7000, 0)
end

function OnslaughtCommanderIustus_Bloodthirst(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35949, pUnit:GetMainTank()) 
end

function OnslaughtCommanderIustus_Whirlwind(pUnit, Event) 
pUnit:CastSpell(48281) 
end

function OnslaughtCommanderIustus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtCommanderIustus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtCommanderIustus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27334, 1, "OnslaughtCommanderIustus_OnCombat")
RegisterUnitEvent(27334, 2, "OnslaughtCommanderIustus_OnLeaveCombat")
RegisterUnitEvent(27334, 3, "OnslaughtCommanderIustus_OnKilledTarget")
RegisterUnitEvent(27334, 4, "OnslaughtCommanderIustus_OnDied")


--[[ Dragonblight -- Onslaught Death Knight.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtDeathKnight_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtDeathKnight_BloodPresence", 1000, 1)
Unit:RegisterEvent("OnslaughtDeathKnight_PlagueStrike", 8000, 0)
end

function OnslaughtDeathKnight_BloodPresence(pUnit, Event) 
pUnit:CastSpell(50689) 
end

function OnslaughtDeathKnight_PlagueStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50688, pUnit:GetMainTank()) 
end

function OnslaughtDeathKnight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtDeathKnight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtDeathKnight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27367, 1, "OnslaughtDeathKnight_OnCombat")
RegisterUnitEvent(27367, 2, "OnslaughtDeathKnight_OnLeaveCombat")
RegisterUnitEvent(27367, 3, "OnslaughtDeathKnight_OnKilledTarget")
RegisterUnitEvent(27367, 4, "OnslaughtDeathKnight_OnDied")


--[[ Dragonblight -- Onslaught Deckhand.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtDeckhand_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtDeckhand_SideKick", 6000, 0)
end

function OnslaughtDeckhand_SideKick(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50854, pUnit:GetMainTank()) 
end

function OnslaughtDeckhand_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtDeckhand_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtDeckhand_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27233, 1, "OnslaughtDeckhand_OnCombat")
RegisterUnitEvent(27233, 2, "OnslaughtDeckhand_OnLeaveCombat")
RegisterUnitEvent(27233, 3, "OnslaughtDeckhand_OnKilledTarget")
RegisterUnitEvent(27233, 4, "OnslaughtDeckhand_OnDied")


--[[ Dragonblight -- Onslaught Executioner.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtExecutioner_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtExecutioner_Hamstring", 8000, 0)
Unit:RegisterEvent("OnslaughtExecutioner_MightyBlow", 9000, 0)
end

function OnslaughtExecutioner_Hamstring(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9080, pUnit:GetMainTank()) 
end

function OnslaughtExecutioner_MightyBlow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43673, pUnit:GetMainTank()) 
end

function OnslaughtExecutioner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtExecutioner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtExecutioner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27211, 1, "OnslaughtExecutioner_OnCombat")
RegisterUnitEvent(27211, 2, "OnslaughtExecutioner_OnLeaveCombat")
RegisterUnitEvent(27211, 3, "OnslaughtExecutioner_OnKilledTarget")
RegisterUnitEvent(27211, 4, "OnslaughtExecutioner_OnDied")


--[[ Dragonblight -- Onslaught Mason.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtMason_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtMason_SlingMortar", 6500, 0)
Unit:RegisterEvent("OnslaughtMason_SunderArmor", 5500, 0)
end

function OnslaughtMason_SlingMortar(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50701, pUnit:GetMainTank()) 
end

function OnslaughtMason_SunderArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50370, pUnit:GetMainTank()) 
end

function OnslaughtMason_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtMason_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtMason_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27333, 1, "OnslaughtMason_OnCombat")
RegisterUnitEvent(27333, 2, "OnslaughtMason_OnLeaveCombat")
RegisterUnitEvent(27333, 3, "OnslaughtMason_OnKilledTarget")
RegisterUnitEvent(27333, 4, "OnslaughtMason_OnDied")


--[[ Dragonblight -- Onslaught Raven Archon.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtRavenArchon_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtRavenArchon_RavenFlock", 7000, 0)
Unit:RegisterEvent("OnslaughtRavenArchon_UnholyFrenzy", 4000, 1)
end

function OnslaughtRavenArchon_RavenFlock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50740, pUnit:GetMainTank()) 
end

function OnslaughtRavenArchon_UnholyFrenzy(pUnit, Event) 
pUnit:CastSpell(50743) 
end

function OnslaughtRavenArchon_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtRavenArchon_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtRavenArchon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27357, 1, "OnslaughtRavenArchon_OnCombat")
RegisterUnitEvent(27357, 2, "OnslaughtRavenArchon_OnLeaveCombat")
RegisterUnitEvent(27357, 3, "OnslaughtRavenArchon_OnKilledTarget")
RegisterUnitEvent(27357, 4, "OnslaughtRavenArchon_OnDied")


--[[ Dragonblight -- Onslaught Raven Priest.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtRavenPriest_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtRavenPriest_RavenFlock", 7000, 0)
Unit:RegisterEvent("OnslaughtRavenPriest_RavenHeal", 9000, 0)
end

function OnslaughtRavenPriest_RavenFlock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50740, pUnit:GetClosestPlayer()) 
end

function OnslaughtRavenPriest_RavenHeal(pUnit, Event) 
pUnit:CastSpell(50750) 
end

function OnslaughtRavenPriest_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtRavenPriest_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtRavenPriest_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27202, 1, "OnslaughtRavenPriest_OnCombat")
RegisterUnitEvent(27202, 2, "OnslaughtRavenPriest_OnLeaveCombat")
RegisterUnitEvent(27202, 3, "OnslaughtRavenPriest_OnKilledTarget")
RegisterUnitEvent(27202, 4, "OnslaughtRavenPriest_OnDied")


--[[ Dragonblight -- Onslaught Scout.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtScout_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtScout_Sprint", 4000, 1)
end

function OnslaughtScout_Sprint(pUnit, Event) 
pUnit:CastSpell(48594) 
end

function OnslaughtScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27332, 1, "OnslaughtScout_OnCombat")
RegisterUnitEvent(27332, 2, "OnslaughtScout_OnLeaveCombat")
RegisterUnitEvent(27332, 3, "OnslaughtScout_OnKilledTarget")
RegisterUnitEvent(27332, 4, "OnslaughtScout_OnDied")


--[[ Dragonblight -- Onslaught Workman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OnslaughtWorkman_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtWorkman_Chop", 7000, 0)
end

function OnslaughtWorkman_Chop(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43410, pUnit:GetMainTank()) 
end

function OnslaughtWorkman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtWorkman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtWorkman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27207, 1, "OnslaughtWorkman_OnCombat")
RegisterUnitEvent(27207, 2, "OnslaughtWorkman_OnLeaveCombat")
RegisterUnitEvent(27207, 3, "OnslaughtWorkman_OnKilledTarget")
RegisterUnitEvent(27207, 4, "OnslaughtWorkman_OnDied")


--[[ Dragonblight -- Overseer Deathgaze.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function OverseerDeathgaze_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerDeathgaze_ConversionBeam", 9100, 0)
Unit:RegisterEvent("OverseerDeathgaze_ShadowBolt", 6000, 0)
end

function OverseerDeathgaze_ConversionBeam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50659, pUnit:GetMainTank()) 
end

function OverseerDeathgaze_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12739, pUnit:GetMainTank()) 
end

function OverseerDeathgaze_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerDeathgaze_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerDeathgaze_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27122, 1, "OverseerDeathgaze_OnCombat")
RegisterUnitEvent(27122, 2, "OverseerDeathgaze_OnLeaveCombat")
RegisterUnitEvent(27122, 3, "OverseerDeathgaze_OnKilledTarget")
RegisterUnitEvent(27122, 4, "OverseerDeathgaze_OnDied")


--[[ Dragonblight -- Reconstructed Frost Wyrm.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function ReconstructedFrostWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("ReconstructedFrostWyrm_FrostBreath", 6500, 0)
end

function ReconstructedFrostWyrm_FrostBreath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47425, pUnit:GetMainTank()) 
end

function ReconstructedFrostWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReconstructedFrostWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReconstructedFrostWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27285, 1, "ReconstructedFrostWyrm_OnCombat")
RegisterUnitEvent(27285, 2, "ReconstructedFrostWyrm_OnLeaveCombat")
RegisterUnitEvent(27285, 3, "ReconstructedFrostWyrm_OnKilledTarget")
RegisterUnitEvent(27285, 4, "ReconstructedFrostWyrm_OnDied")


--[[ Dragonblight -- Plague Eruptor.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function PlagueEruptor_OnCombat(Unit, Event)
Unit:RegisterEvent("PlagueEruptor_PlagueCloud", 10000, 0)
end

function PlagueEruptor_PlagueCloud(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49350, pUnit:GetMainTank()) 
end

function PlagueEruptor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PlagueEruptor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PlagueEruptor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27611, 1, "PlagueEruptor_OnCombat")
RegisterUnitEvent(27611, 2, "PlagueEruptor_OnLeaveCombat")
RegisterUnitEvent(27611, 3, "PlagueEruptor_OnKilledTarget")
RegisterUnitEvent(27611, 4, "PlagueEruptor_OnDied")


--[[ Dragonblight -- Rabid Grizzly.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function RabidGrizzly_OnCombat(Unit, Event)
Unit:RegisterEvent("RabidGrizzly_Rabies", 8000, 0)
end

function RabidGrizzly_Rabies(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51951, pUnit:GetMainTank()) 
end

function RabidGrizzly_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RabidGrizzly_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RabidGrizzly_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26643, 1, "RabidGrizzly_OnCombat")
RegisterUnitEvent(26643, 2, "RabidGrizzly_OnLeaveCombat")
RegisterUnitEvent(26643, 3, "RabidGrizzly_OnKilledTarget")
RegisterUnitEvent(26643, 4, "RabidGrizzly_OnDied")


--[[ Dragonblight -- Rattlebore.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function Rattlebore_OnCombat(Unit, Event)
Unit:RegisterEvent("Rattlebore_CorrodedMind", 10000, 0)
Unit:RegisterEvent("Rattlebore_CorrosiveSpit", 9000, 0)
Unit:RegisterEvent("Rattlebore_PowerfulBite", 7000, 0)
end

function Rattlebore_CorrodedMind(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51203, pUnit:GetMainTank()) 
end

function Rattlebore_CorrosiveSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47447, pUnit:GetMainTank()) 
end

function Rattlebore_PowerfulBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(48287, pUnit:GetMainTank()) 
end

function Rattlebore_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Rattlebore_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Rattlebore_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26360, 1, "Rattlebore_OnCombat")
RegisterUnitEvent(26360, 2, "Rattlebore_OnLeaveCombat")
RegisterUnitEvent(26360, 3, "Rattlebore_OnKilledTarget")
RegisterUnitEvent(26360, 4, "Rattlebore_OnDied")


--[[ Dragonblight -- Reanimated Drakkari Tribesman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function ReanimatedDrakkariTribesman_OnCombat(Unit, Event)
Unit:RegisterEvent("ReanimatedDrakkariTribesman_Cannibalize", 10000, 0)
Unit:RegisterEvent("ReanimatedDrakkariTribesman_CrazedHunger", 6000, 0)
end

function ReanimatedDrakkariTribesman_Cannibalize(pUnit, Event) 
pUnit:CastSpell(50642) 
end

function ReanimatedDrakkariTribesman_CrazedHunger(pUnit, Event) 
pUnit:CastSpell(3151) 
end

function ReanimatedDrakkariTribesman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReanimatedDrakkariTribesman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReanimatedDrakkariTribesman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26946, 1, "ReanimatedDrakkariTribesman_OnCombat")
RegisterUnitEvent(26946, 2, "ReanimatedDrakkariTribesman_OnLeaveCombat")
RegisterUnitEvent(26946, 3, "ReanimatedDrakkariTribesman_OnKilledTarget")
RegisterUnitEvent(26946, 4, "ReanimatedDrakkariTribesman_OnDied")


--[[ Dragonblight -- Reanimated Frost Wyrm.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function ReanimatedFrostWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("ReanimatedFrostWyrm_FrostBreath", 6500, 0)
end

function ReanimatedFrostWyrm_FrostBreath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47425, pUnit:GetMainTank()) 
end

function ReanimatedFrostWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReanimatedFrostWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReanimatedFrostWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26841, 1, "ReanimatedFrostWyrm_OnCombat")
RegisterUnitEvent(26841, 2, "ReanimatedFrostWyrm_OnLeaveCombat")
RegisterUnitEvent(26841, 3, "ReanimatedFrostWyrm_OnKilledTarget")
RegisterUnitEvent(26841, 4, "ReanimatedFrostWyrm_OnDied")


--[[ Dragonblight -- Reanimated Noble.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function ReanimatedNoble_OnCombat(Unit, Event)
Unit:RegisterEvent("ReanimatedNoble_SanguineStrike", 8000, 0)
end

function ReanimatedNoble_SanguineStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51285, pUnit:GetMainTank()) 
end

function ReanimatedNoble_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReanimatedNoble_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReanimatedNoble_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27552, 1, "ReanimatedNoble_OnCombat")
RegisterUnitEvent(27552, 2, "ReanimatedNoble_OnLeaveCombat")
RegisterUnitEvent(27552, 3, "ReanimatedNoble_OnKilledTarget")
RegisterUnitEvent(27552, 4, "ReanimatedNoble_OnDied")


--[[ Dragonblight -- Risen Wintergarde Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function RisenWintergardeDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenWintergardeDefender_UnwaveringWill", 4000, 1)
end

function RisenWintergardeDefender_UnwaveringWill(pUnit, Event) 
pUnit:CastSpell(51307) 
end

function RisenWintergardeDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenWintergardeDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenWintergardeDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27284, 1, "RisenWintergardeDefender_OnCombat")
RegisterUnitEvent(27284, 2, "RisenWintergardeDefender_OnLeaveCombat")
RegisterUnitEvent(27284, 3, "RisenWintergardeDefender_OnKilledTarget")
RegisterUnitEvent(27284, 4, "RisenWintergardeDefender_OnDied")


--[[ Dragonblight -- Risen Wintergarde Mage.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function RisenWintergardeMage_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenWintergardeMage_FireBlast", 6000, 0)
Unit:RegisterEvent("RisenWintergardeMage_Frostbolt", 7000, 0)
end

function RisenWintergardeMage_FireBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13339, pUnit:GetMainTank()) 
end

function RisenWintergardeMage_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9672, pUnit:GetMainTank()) 
end

function RisenWintergardeMage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenWintergardeMage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenWintergardeMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27283, 1, "RisenWintergardeMage_OnCombat")
RegisterUnitEvent(27283, 2, "RisenWintergardeMage_OnLeaveCombat")
RegisterUnitEvent(27283, 3, "RisenWintergardeMage_OnKilledTarget")
RegisterUnitEvent(27283, 4, "RisenWintergardeMage_OnDied")


--[[ Dragonblight -- Risen Wintergarde Miner.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function RisenWintergardeMiner_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenWintergardeMiner_PunctureWound", 7000, 0)
end

function RisenWintergardeMiner_PunctureWound(pUnit, Event) 
pUnit:FullCastSpellOnTarget(48374, pUnit:GetMainTank()) 
end

function RisenWintergardeMiner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenWintergardeMiner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenWintergardeMiner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27401, 1, "RisenWintergardeMiner_OnCombat")
RegisterUnitEvent(27401, 2, "RisenWintergardeMiner_OnLeaveCombat")
RegisterUnitEvent(27401, 3, "RisenWintergardeMiner_OnKilledTarget")
RegisterUnitEvent(27401, 4, "RisenWintergardeMiner_OnDied")


--[[ Dragonblight -- Roanauk Icemist.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function RoanaukIcemist_OnCombat(Unit, Event)
Unit:RegisterEvent("RoanaukIcemist_GloryoftheAncestors", 5000, 1)
Unit:RegisterEvent("RoanaukIcemist_IcemistsBlessing", 10000, 0)
end

function RoanaukIcemist_GloryoftheAncestors(pUnit, Event) 
pUnit:CastSpell(47378) 
end

function RoanaukIcemist_IcemistsBlessing(pUnit, Event) 
pUnit:CastSpell(47379) 
end

function RoanaukIcemist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RoanaukIcemist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RoanaukIcemist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26654, 1, "RoanaukIcemist_OnCombat")
RegisterUnitEvent(26654, 2, "RoanaukIcemist_OnLeaveCombat")
RegisterUnitEvent(26654, 3, "RoanaukIcemist_OnKilledTarget")
RegisterUnitEvent(26654, 4, "RoanaukIcemist_OnDied")


--[[ Dragonblight -- Rothin the Decaying.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function RothintheDecaying_OnCombat(Unit, Event)
Unit:RegisterEvent("RothintheDecaying_AegisofNeltharion", 4000, 1)
Unit:RegisterEvent("RothintheDecaying_Shadowflame", 7000, 0)
Unit:RegisterEvent("RothintheDecaying_ShadowBolt", 8000, 0)
end

function RothintheDecaying_AegisofNeltharion(pUnit, Event) 
pUnit:CastSpell(51512) 
end

function RothintheDecaying_Shadowflame(pUnit, Event) 
pUnit:CastSpell(51337) 
end

function RothintheDecaying_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function RothintheDecaying_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RothintheDecaying_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RothintheDecaying_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27355, 1, "RothintheDecaying_OnCombat")
RegisterUnitEvent(27355, 2, "RothintheDecaying_OnLeaveCombat")
RegisterUnitEvent(27355, 3, "RothintheDecaying_OnKilledTarget")
RegisterUnitEvent(27355, 4, "RothintheDecaying_OnDied")


--[[ Dragonblight -- Sarendryana.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function Sarendryana_OnCombat(Unit, Event)
Unit:RegisterEvent("Sarendryana_FrostShock", 6000, 0)
end

function Sarendryana_FrostShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12548, pUnit:GetMainTank()) 
end

function Sarendryana_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sarendryana_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Sarendryana_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26837, 1, "Sarendryana_OnCombat")
RegisterUnitEvent(26837, 2, "Sarendryana_OnLeaveCombat")
RegisterUnitEvent(26837, 3, "Sarendryana_OnKilledTarget")
RegisterUnitEvent(26837, 4, "Sarendryana_OnDied")


--[[ Dragonblight -- Scourge Siegesmith.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function ScourgeSiegesmith_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgeSiegesmith_Bomb", 5500, 0)
end

function ScourgeSiegesmith_Bomb(pUnit, Event) 
pUnit:CastSpell(22334) 
end

function ScourgeSiegesmith_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgeSiegesmith_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgeSiegesmith_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27410, 1, "ScourgeSiegesmith_OnCombat")
RegisterUnitEvent(27410, 2, "ScourgeSiegesmith_OnLeaveCombat")
RegisterUnitEvent(27410, 3, "ScourgeSiegesmith_OnKilledTarget")
RegisterUnitEvent(27410, 4, "ScourgeSiegesmith_OnDied")


--[[ Dragonblight -- Scourge Technician.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function ScourgeTechnician_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgeTechnician_Lobotomize", 6000, 0)
end

function ScourgeTechnician_Lobotomize(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51316, pUnit:GetMainTank()) 
end

function ScourgeTechnician_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgeTechnician_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgeTechnician_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27799, 1, "ScourgeTechnician_OnCombat")
RegisterUnitEvent(27799, 2, "ScourgeTechnician_OnLeaveCombat")
RegisterUnitEvent(27799, 3, "ScourgeTechnician_OnKilledTarget")
RegisterUnitEvent(27799, 4, "ScourgeTechnician_OnDied")


--[[ Dragonblight -- Sinok the Shadowrager.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SinoktheShadowrager_OnCombat(Unit, Event)
Unit:RegisterEvent("SinoktheShadowrager_BlinkStrike", 6000, 0)
Unit:RegisterEvent("SinoktheShadowrager_RagingShadows", 8000, 0)
end

function SinoktheShadowrager_BlinkStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49961, pUnit:GetMainTank()) 
end

function SinoktheShadowrager_RagingShadows(pUnit, Event) 
pUnit:CastSpell(51622) 
end

function SinoktheShadowrager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SinoktheShadowrager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SinoktheShadowrager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26771, 1, "SinoktheShadowrager_OnCombat")
RegisterUnitEvent(26771, 2, "SinoktheShadowrager_OnLeaveCombat")
RegisterUnitEvent(26771, 3, "SinoktheShadowrager_OnKilledTarget")
RegisterUnitEvent(26771, 4, "SinoktheShadowrager_OnDied")


--[[ Dragonblight -- Smoldering Construct.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SmolderingConstruct_OnCombat(Unit, Event)
Unit:RegisterEvent("SmolderingConstruct_Backlash", 6000, 0)
end

function SmolderingConstruct_Backlash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51439, pUnit:GetMainTank()) 
end

function SmolderingConstruct_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SmolderingConstruct_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SmolderingConstruct_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27362, 1, "SmolderingConstruct_OnCombat")
RegisterUnitEvent(27362, 2, "SmolderingConstruct_OnLeaveCombat")
RegisterUnitEvent(27362, 3, "SmolderingConstruct_OnKilledTarget")
RegisterUnitEvent(27362, 4, "SmolderingConstruct_OnDied")


--[[ Dragonblight -- Smoldering Geist.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SmolderingGeist_OnCombat(Unit, Event)
Unit:RegisterEvent("SmolderingGeist_BurningBlaze", 6500, 0)
end

function SmolderingGeist_BurningBlaze(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51500, pUnit:GetMainTank()) 
end

function SmolderingGeist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SmolderingGeist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SmolderingGeist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27363, 1, "SmolderingGeist_OnCombat")
RegisterUnitEvent(27363, 2, "SmolderingGeist_OnLeaveCombat")
RegisterUnitEvent(27363, 3, "SmolderingGeist_OnKilledTarget")
RegisterUnitEvent(27363, 4, "SmolderingGeist_OnDied")


--[[ Dragonblight -- Smoldering Skeleton.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SmolderingSkeleton_OnCombat(Unit, Event)
Unit:RegisterEvent("SmolderingSkeleton_SmolderingBones", 8000, 0)
end

function SmolderingSkeleton_SmolderingBones(pUnit, Event) 
pUnit:CastSpell(51437) 
end

function SmolderingSkeleton_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SmolderingSkeleton_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SmolderingSkeleton_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27360, 1, "SmolderingSkeleton_OnCombat")
RegisterUnitEvent(27360, 2, "SmolderingSkeleton_OnLeaveCombat")
RegisterUnitEvent(27360, 3, "SmolderingSkeleton_OnKilledTarget")
RegisterUnitEvent(27360, 4, "SmolderingSkeleton_OnDied")


--[[ Dragonblight -- Snowfall Elk.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SnowfallElk_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowfallElk_Puncture", 5000, 0)
end

function SnowfallElk_Puncture(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15976, pUnit:GetMainTank()) 
end

function SnowfallElk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowfallElk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowfallElk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26615, 1, "SnowfallElk_OnCombat")
RegisterUnitEvent(26615, 2, "SnowfallElk_OnLeaveCombat")
RegisterUnitEvent(26615, 3, "SnowfallElk_OnKilledTarget")
RegisterUnitEvent(26615, 4, "SnowfallElk_OnDied")


--[[ Dragonblight -- Snowfall Glade Den Mother.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SnowfallGladeDenMother_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowfallGladeDenMother_Enrage", 10000, 1)
end

function SnowfallGladeDenMother_Enrage(pUnit, Event) 
pUnit:CastSpell(48193) 
end

function SnowfallGladeDenMother_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowfallGladeDenMother_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowfallGladeDenMother_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26199, 1, "SnowfallGladeDenMother_OnCombat")
RegisterUnitEvent(26199, 2, "SnowfallGladeDenMother_OnLeaveCombat")
RegisterUnitEvent(26199, 3, "SnowfallGladeDenMother_OnKilledTarget")
RegisterUnitEvent(26199, 4, "SnowfallGladeDenMother_OnDied")


--[[ Dragonblight -- Snowfall Glade Shaman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SnowfallGladeShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowfallGladeShaman_FrostShock", 6000, 0)
Unit:RegisterEvent("SnowfallGladeShaman_HealingWave", 10000, 0)
Unit:RegisterEvent("SnowfallGladeShaman_LightningShield", 5000, 0)
end

function SnowfallGladeShaman_FrostShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12548, pUnit:GetMainTank()) 
end

function SnowfallGladeShaman_HealingWave(pUnit, Event) 
pUnit:CastSpell(11986) 
end

function SnowfallGladeShaman_LightningShield(pUnit, Event) 
pUnit:CastSpell(12550) 
end

function SnowfallGladeShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowfallGladeShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowfallGladeShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26201, 1, "SnowfallGladeShaman_OnCombat")
RegisterUnitEvent(26201, 2, "SnowfallGladeShaman_OnLeaveCombat")
RegisterUnitEvent(26201, 3, "SnowfallGladeShaman_OnKilledTarget")
RegisterUnitEvent(26201, 4, "SnowfallGladeShaman_OnDied")


--[[ Dragonblight -- Snowfall Glade Wolvar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SnowfallGladeWolvar_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowfallGladeWolvar_Net", 8000, 0)
Unit:RegisterEvent("SnowfallGladeWolvar_ThrowSpear", 6000, 0)
end

function SnowfallGladeWolvar_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6533, pUnit:GetMainTank()) 
end

function SnowfallGladeWolvar_ThrowSpear(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43413, pUnit:GetMainTank()) 
end

function SnowfallGladeWolvar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowfallGladeWolvar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowfallGladeWolvar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26198, 1, "SnowfallGladeWolvar_OnCombat")
RegisterUnitEvent(26198, 2, "SnowfallGladeWolvar_OnLeaveCombat")
RegisterUnitEvent(26198, 3, "SnowfallGladeWolvar_OnKilledTarget")
RegisterUnitEvent(26198, 4, "SnowfallGladeWolvar_OnDied")


--[[ Dragonblight -- Snowplain Disciple.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SnowplainDisciple_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowplainDisciple_Frostbolt", 6500, 0)
Unit:RegisterEvent("SnowplainDisciple_RenewingBeam", 11000, 0)
end

function SnowplainDisciple_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(61730, pUnit:GetMainTank()) 
end

function SnowplainDisciple_RenewingBeam(pUnit, Event) 
pUnit:CastSpell(52011) 
end

function SnowplainDisciple_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowplainDisciple_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowplainDisciple_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26705, 1, "SnowplainDisciple_OnCombat")
RegisterUnitEvent(26705, 2, "SnowplainDisciple_OnLeaveCombat")
RegisterUnitEvent(26705, 3, "SnowplainDisciple_OnKilledTarget")
RegisterUnitEvent(26705, 4, "SnowplainDisciple_OnDied")


--[[ Dragonblight -- Snowplain Shaman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SnowplainShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowplainShaman_SearingTotem", 3000, 1)
end

function SnowplainShaman_SearingTotem(pUnit, Event) 
pUnit:CastSpell(39591) 
end

function SnowplainShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowplainShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowplainShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27279, 1, "SnowplainShaman_OnCombat")
RegisterUnitEvent(27279, 2, "SnowplainShaman_OnLeaveCombat")
RegisterUnitEvent(27279, 3, "SnowplainShaman_OnKilledTarget")
RegisterUnitEvent(27279, 4, "SnowplainShaman_OnDied")


--[[ Dragonblight -- Stars Rest Sentinel.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function StarsRestSentinel_OnCombat(Unit, Event)
Unit:RegisterEvent("StarsRestSentinel_FrostArrow", 8000, 0)
Unit:RegisterEvent("StarsRestSentinel_Shoot", 6000, 0)
end

function StarsRestSentinel_FrostArrow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47059, pUnit:GetMainTank()) 
end

function StarsRestSentinel_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(23337, pUnit:GetMainTank()) 
end

function StarsRestSentinel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function StarsRestSentinel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function StarsRestSentinel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26448, 1, "StarsRestSentinel_OnCombat")
RegisterUnitEvent(26448, 2, "StarsRestSentinel_OnLeaveCombat")
RegisterUnitEvent(26448, 3, "StarsRestSentinel_OnKilledTarget")
RegisterUnitEvent(26448, 4, "StarsRestSentinel_OnDied")


--[[ Dragonblight -- Surge Needle Sorcerer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function SurgeNeedleSorcerer_OnCombat(Unit, Event)
Unit:RegisterEvent("SurgeNeedleSorcerer_ArcaneBlast", 6500, 0)
end

function SurgeNeedleSorcerer_ArcaneBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51797, pUnit:GetMainTank()) 
end

function SurgeNeedleSorcerer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SurgeNeedleSorcerer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SurgeNeedleSorcerer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26257, 1, "SurgeNeedleSorcerer_OnCombat")
RegisterUnitEvent(26257, 2, "SurgeNeedleSorcerer_OnLeaveCombat")
RegisterUnitEvent(26257, 3, "SurgeNeedleSorcerer_OnKilledTarget")
RegisterUnitEvent(26257, 4, "SurgeNeedleSorcerer_OnDied")


--[[ Dragonblight -- Tattered Abomination.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TatteredAbomination_OnCombat(Unit, Event)
Unit:RegisterEvent("TatteredAbomination_ScourgeHook", 7000, 0)
end

function TatteredAbomination_ScourgeHook(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50335, pUnit:GetMainTank()) 
end

function TatteredAbomination_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TatteredAbomination_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TatteredAbomination_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27797, 1, "TatteredAbomination_OnCombat")
RegisterUnitEvent(27797, 2, "TatteredAbomination_OnLeaveCombat")
RegisterUnitEvent(27797, 3, "TatteredAbomination_OnKilledTarget")
RegisterUnitEvent(27797, 4, "TatteredAbomination_OnDied")


--[[ Dragonblight -- Taunka Windfury.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TaunkaWindfury_OnCombat(Unit, Event)
Unit:RegisterEvent("TaunkaWindfury_HealingTouch", 10000, 0)
Unit:RegisterEvent("TaunkaWindfury_Moonfire", 5500, 0)
end

function TaunkaWindfury_HealingTouch(pUnit, Event) 
pUnit:CastSpell(23381) 
end

function TaunkaWindfury_Moonfire(pUnit, Event) 
pUnit:FullCastSpellOnTarget(23380, pUnit:GetMainTank()) 
end

function TaunkaWindfury_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TaunkaWindfury_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TaunkaWindfury_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27571, 1, "TaunkaWindfury_OnCombat")
RegisterUnitEvent(27571, 2, "TaunkaWindfury_OnLeaveCombat")
RegisterUnitEvent(27571, 3, "TaunkaWindfury_OnKilledTarget")
RegisterUnitEvent(27571, 4, "TaunkaWindfury_OnDied")


--[[ Dragonblight -- Taunkale Brave.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TaunkaleBrave_OnCombat(Unit, Event)
Unit:RegisterEvent("TaunkaleBrave_GroundSlam", 7000, 0)
end

function TaunkaleBrave_GroundSlam(pUnit, Event) 
pUnit:CastSpell(52058) 
end

function TaunkaleBrave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TaunkaleBrave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TaunkaleBrave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26157, 1, "TaunkaleBrave_OnCombat")
RegisterUnitEvent(26157, 2, "TaunkaleBrave_OnLeaveCombat")
RegisterUnitEvent(26157, 3, "TaunkaleBrave_OnKilledTarget")
RegisterUnitEvent(26157, 4, "TaunkaleBrave_OnDied")


--[[ Dragonblight -- Tempest Revenant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TempestRevenant_OnCombat(Unit, Event)
Unit:RegisterEvent("TempestRevenant_SeethingFlames", 6000, 0)
end

function TempestRevenant_SeethingFlames(pUnit, Event) 
pUnit:FullCastSpellOnTarget(56620, pUnit:GetMainTank()) 
end

function TempestRevenant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TempestRevenant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TempestRevenant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30875, 1, "TempestRevenant_OnCombat")
RegisterUnitEvent(30875, 2, "TempestRevenant_OnLeaveCombat")
RegisterUnitEvent(30875, 3, "TempestRevenant_OnKilledTarget")
RegisterUnitEvent(30875, 4, "TempestRevenant_OnDied")


--[[ Dragonblight -- Tempus Wyrm.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TempusWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("TempusWyrm_TimeShock", 5000, 0)
end

function TempusWyrm_TimeShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(60076, pUnit:GetMainTank()) 
end

function TempusWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TempusWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TempusWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32180, 1, "TempusWyrm_OnCombat")
RegisterUnitEvent(32180, 2, "TempusWyrm_OnLeaveCombat")
RegisterUnitEvent(32180, 3, "TempusWyrm_OnKilledTarget")
RegisterUnitEvent(32180, 4, "TempusWyrm_OnDied")


--[[ Dragonblight -- Thelzan the Duskbringer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function ThelzantheDuskbringer_OnCombat(Unit, Event)
Unit:RegisterEvent("ThelzantheDuskbringer_ChainsofIce", 16000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_FrostArmor", 11000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_Frostbolt", 7000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_FrostboltVolley", 12000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_ScreamofChaos", 20000, 0)
end

function ThelzantheDuskbringer_ChainsofIce(pUnit, Event) 
pUnit:FullCastSpellOnTarget(39268, pUnit:GetRandomPlayer(0)) 
end

function ThelzantheDuskbringer_FrostArmor(pUnit, Event) 
pUnit:CastSpell(31256) 
end

function ThelzantheDuskbringer_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(42719, pUnit:GetMainTank()) 
end

function ThelzantheDuskbringer_FrostboltVolley(pUnit, Event) 
pUnit:CastSpell(22643) 
end

function ThelzantheDuskbringer_ScreamofChaos(pUnit, Event) 
pUnit:CastSpell(50497) 
end

function ThelzantheDuskbringer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ThelzantheDuskbringer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ThelzantheDuskbringer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27383, 1, "ThelzantheDuskbringer_OnCombat")
RegisterUnitEvent(27383, 2, "ThelzantheDuskbringer_OnLeaveCombat")
RegisterUnitEvent(27383, 3, "ThelzantheDuskbringer_OnKilledTarget")
RegisterUnitEvent(27383, 4, "ThelzantheDuskbringer_OnDied")


--[[ Dragonblight -- Tivax the Breaker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TivaxtheBreaker_OnCombat(Unit, Event)
Unit:RegisterEvent("TivaxtheBreaker_FireBlast", 5000, 0)
Unit:RegisterEvent("TivaxtheBreaker_Scorch", 6000, 0)
end

function TivaxtheBreaker_FireBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(20795, pUnit:GetMainTank()) 
end

function TivaxtheBreaker_Scorch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13878, pUnit:GetMainTank()) 
end

function TivaxtheBreaker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TivaxtheBreaker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TivaxtheBreaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26770, 1, "TivaxtheBreaker_OnCombat")
RegisterUnitEvent(26770, 2, "TivaxtheBreaker_OnLeaveCombat")
RegisterUnitEvent(26770, 3, "TivaxtheBreaker_OnKilledTarget")
RegisterUnitEvent(26770, 4, "TivaxtheBreaker_OnDied")


--[[ Dragonblight -- Tormented Drakkari.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TormentedDrakkari_OnCombat(Unit, Event)
Unit:RegisterEvent("TormentedDrakkari_Cannibalize", 12000, 0)
Unit:RegisterEvent("TormentedDrakkari_CrazedHunger", 6000, 1)
Unit:RegisterEvent("TormentedDrakkari_Kick", 7000, 0)
Unit:RegisterEvent("TormentedDrakkari_TormentedRoar", 8000, 0)
end

function TormentedDrakkari_Cannibalize(pUnit, Event) 
pUnit:CastSpell(50642) 
end

function TormentedDrakkari_CrazedHunger(pUnit, Event) 
pUnit:CastSpell(3151) 
end

function TormentedDrakkari_Kick(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43518, pUnit:GetMainTank()) 
end

function TormentedDrakkari_TormentedRoar(pUnit, Event) 
pUnit:CastSpell(50636) 
end

function TormentedDrakkari_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TormentedDrakkari_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TormentedDrakkari_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26965, 1, "TormentedDrakkari_OnCombat")
RegisterUnitEvent(26965, 2, "TormentedDrakkari_OnLeaveCombat")
RegisterUnitEvent(26965, 3, "TormentedDrakkari_OnKilledTarget")
RegisterUnitEvent(26965, 4, "TormentedDrakkari_OnDied")


--[[ Dragonblight -- Torturer LeCraft.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TorturerLeCraft_OnCombat(Unit, Event)
Unit:RegisterEvent("TorturerLeCraft_Hemorrhage", 5000, 0)
Unit:RegisterEvent("TorturerLeCraft_KidneyShot", 10000, 0)
end

function TorturerLeCraft_Hemorrhage(pUnit, Event) 
pUnit:FullCastSpellOnTarget(30478) 
end

function TorturerLeCraft_KidneyShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(30621, pUnit:GetMainTank()) 
end

function TorturerLeCraft_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TorturerLeCraft_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TorturerLeCraft_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27209, 1, "TorturerLeCraft_OnCombat")
RegisterUnitEvent(27209, 2, "TorturerLeCraft_OnLeaveCombat")
RegisterUnitEvent(27209, 3, "TorturerLeCraft_OnKilledTarget")
RegisterUnitEvent(27209, 4, "TorturerLeCraft_OnDied")


--[[ Dragonblight -- Tukemuth.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function Tukemuth_OnCombat(Unit, Event)
Unit:RegisterEvent("Tukemuth_Trample", 10000, 0)
Unit:RegisterEvent("Tukemuth_TuskStrike", 8000, 0)
end

function Tukemuth_Trample(pUnit, Event) 
pUnit:CastSpell(57066) 
end

function Tukemuth_TuskStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50410, pUnit:GetMainTank()) 
end

function Tukemuth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tukemuth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tukemuth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32400, 1, "Tukemuth_OnCombat")
RegisterUnitEvent(32400, 2, "Tukemuth_OnLeaveCombat")
RegisterUnitEvent(32400, 3, "Tukemuth_OnKilledTarget")
RegisterUnitEvent(32400, 4, "Tukemuth_OnDied")


--[[ Dragonblight -- Tundra Scavenger.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TundraScavenger_OnCombat(Unit, Event)
Unit:RegisterEvent("TundraScavenger_Maul", 5000, 0)
end

function TundraScavenger_Maul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51875, pUnit:GetMainTank()) 
end

function TundraScavenger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TundraScavenger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TundraScavenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27294, 1, "TundraScavenger_OnCombat")
RegisterUnitEvent(27294, 2, "TundraScavenger_OnLeaveCombat")
RegisterUnitEvent(27294, 3, "TundraScavenger_OnKilledTarget")
RegisterUnitEvent(27294, 4, "TundraScavenger_OnDied")


--[[ Dragonblight -- Turgid the Vile.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function TurgidtheVile_OnCombat(Unit, Event)
Unit:RegisterEvent("TurgidtheVile_ScourgeHook", 6000, 0)
Unit:RegisterEvent("TurgidtheVile_VileVommit", 8000, 0)
end

function TurgidtheVile_ScourgeHook(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50335, pUnit:GetMainTank()) 
end

function TurgidtheVile_VileVommit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51356, pUnit:GetMainTank()) 
end

function TurgidtheVile_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TurgidtheVile_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TurgidtheVile_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27808, 1, "TurgidtheVile_OnCombat")
RegisterUnitEvent(27808, 2, "TurgidtheVile_OnLeaveCombat")
RegisterUnitEvent(27808, 3, "TurgidtheVile_OnKilledTarget")
RegisterUnitEvent(27808, 4, "TurgidtheVile_OnDied")


--[[ Dragonblight -- Venomspite Deathguard.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function VenomspiteDeathguard_OnCombat(Unit, Event)
Unit:RegisterEvent("VenomspiteDeathguard_Revenge", 5000, 0)
Unit:RegisterEvent("VenomspiteDeathguard_ShieldBlock", 6000, 0)
end

function VenomspiteDeathguard_Revenge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12170, pUnit:GetMainTank()) 
end

function VenomspiteDeathguard_ShieldBlock(pUnit, Event) 
pUnit:CastSpell(12169) 
end

function VenomspiteDeathguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VenomspiteDeathguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VenomspiteDeathguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27035, 1, "VenomspiteDeathguard_OnCombat")
RegisterUnitEvent(27035, 2, "VenomspiteDeathguard_OnLeaveCombat")
RegisterUnitEvent(27035, 3, "VenomspiteDeathguard_OnKilledTarget")
RegisterUnitEvent(27035, 4, "VenomspiteDeathguard_OnDied")


--[[ Dragonblight -- Wailing Soul.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function WailingSoul_OnCombat(Unit, Event)
Unit:RegisterEvent("WailingSoul_TugSoul", 10000, 0)
end

function WailingSoul_TugSoul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50027, pUnit:GetMainTank()) 
end

function WailingSoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WailingSoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WailingSoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27836, 1, "WailingSoul_OnCombat")
RegisterUnitEvent(27836, 2, "WailingSoul_OnLeaveCombat")
RegisterUnitEvent(27836, 3, "WailingSoul_OnKilledTarget")
RegisterUnitEvent(27836, 4, "WailingSoul_OnDied")


--[[ Dragonblight -- Warsong Shaman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function WarsongShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("WarsongShaman_ChainHeal", 16000, 0)
Unit:RegisterEvent("WarsongShaman_ChainLightning", 9000, 0)
Unit:RegisterEvent("WarsongShaman_EarthShock", 12000, 0)
Unit:RegisterEvent("WarsongShaman_LesserHealingWave", 20000, 0)
Unit:RegisterEvent("WarsongShaman_WaterShield", 4000, 1)
end

function WarsongShaman_ChainHeal(pUnit, Event) 
pUnit:CastSpell(16367) 
end

function WarsongShaman_ChainLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(39945, pUnit:GetMainTank()) 
end

function WarsongShaman_EarthShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25025, pUnit:GetMainTank()) 
end

function WarsongShaman_LesserHealingWave(pUnit, Event) 
pUnit:CastSpell(49309) 
end

function WarsongShaman_WaterShield(pUnit, Event) 
pUnit:CastSpell(34827) 
end

function WarsongShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarsongShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarsongShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27678, 1, "WarsongShaman_OnCombat")
RegisterUnitEvent(27678, 2, "WarsongShaman_OnLeaveCombat")
RegisterUnitEvent(27678, 3, "WarsongShaman_OnKilledTarget")
RegisterUnitEvent(27678, 4, "WarsongShaman_OnDied")


--[[ Dragonblight -- Wastes Digger.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function WastesDigger_OnCombat(Unit, Event)
Unit:RegisterEvent("WastesDigger_CarnivorousBite", 4000, 0)
end

function WastesDigger_CarnivorousBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(30639, pUnit:GetMainTank()) 
end

function WastesDigger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WastesDigger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WastesDigger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26492, 1, "WastesDigger_OnCombat")
RegisterUnitEvent(26492, 2, "WastesDigger_OnLeaveCombat")
RegisterUnitEvent(26492, 3, "WastesDigger_OnKilledTarget")
RegisterUnitEvent(26492, 4, "WastesDigger_OnDied")


--[[ Dragonblight -- Wastes Scavenger.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function WastesScavenger_OnCombat(Unit, Event)
Unit:RegisterEvent("WastesScavenger_BoneToss", 5000, 0)
end

function WastesScavenger_BoneToss(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50403, pUnit:GetMainTank()) 
end

function WastesScavenger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WastesScavenger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WastesScavenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28005, 1, "WastesScavenger_OnCombat")
RegisterUnitEvent(28005, 2, "WastesScavenger_OnLeaveCombat")
RegisterUnitEvent(28005, 3, "WastesScavenger_OnKilledTarget")
RegisterUnitEvent(28005, 4, "WastesScavenger_OnDied")


--[[ Dragonblight -- Wastes Taskmaster.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function WastesTaskmaster_OnCombat(Unit, Event)
Unit:RegisterEvent("WastesTaskmaster_ShadowNova", 5000, 0)
Unit:RegisterEvent("WastesTaskmaster_ShadowShock", 6000, 0)
end

function WastesTaskmaster_ShadowNova(pUnit, Event) 
pUnit:CastSpell(32712) 
end

function WastesTaskmaster_ShadowShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16583, pUnit:GetMainTank()) 
end

function WastesTaskmaster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WastesTaskmaster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WastesTaskmaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26493, 1, "WastesTaskmaster_OnCombat")
RegisterUnitEvent(26493, 2, "WastesTaskmaster_OnLeaveCombat")
RegisterUnitEvent(26493, 3, "WastesTaskmaster_OnKilledTarget")
RegisterUnitEvent(26493, 4, "WastesTaskmaster_OnDied")


--[[ Dragonblight -- Wind Trader Mufah.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function WindTraderMufah_OnCombat(Unit, Event)
Unit:RegisterEvent("WindTraderMufah_Typhoon", 4000, 1)
end

function WindTraderMufah_Typhoon(pUnit, Event) 
pUnit:CastSpell(51817) 
end

function WindTraderMufah_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WindTraderMufah_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WindTraderMufah_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26496, 1, "WindTraderMufah_OnCombat")
RegisterUnitEvent(26496, 2, "WindTraderMufah_OnLeaveCombat")
RegisterUnitEvent(26496, 3, "WindTraderMufah_OnKilledTarget")
RegisterUnitEvent(26496, 4, "WindTraderMufah_OnDied")


--[[ Dragonblight -- Winters Sister.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 2th, 2009. ]]


function WintersSister_OnCombat(Unit, Event)
Unit:RegisterEvent("WintersSister_FrostShock", 6000, 0)
end

function WintersSister_FrostShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12548, pUnit:GetMainTank()) 
end

function WintersSister_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WintersSister_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WintersSister_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26456, 1, "WintersSister_OnCombat")
RegisterUnitEvent(26456, 2, "WintersSister_OnLeaveCombat")
RegisterUnitEvent(26456, 3, "WintersSister_OnKilledTarget")
RegisterUnitEvent(26456, 4, "WintersSister_OnDied")


--[[ Grizzly Hills -- Amberpine Scout.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function AmberpineScout_OnCombat(Unit, Event)
Unit:RegisterEvent("AmberpineScout_Deterrence", 10000, 0)
Unit:RegisterEvent("AmberpineScout_PunctureArmor", 2000, 1)
Unit:RegisterEvent("AmberpineScout_Shoot", 6000, 0)
end

function AmberpineScout_Deterrence(pUnit, Event) 
pUnit:CastSpell(31567) 
end

function AmberpineScout_PunctureArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35918, pUnit:GetMainTank()) 
end

function AmberpineScout_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15547, pUnit:GetMainTank()) 
end

function AmberpineScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AmberpineScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AmberpineScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27117, 1, "AmberpineScout_OnCombat")
RegisterUnitEvent(27117, 2, "AmberpineScout_OnLeaveCombat")
RegisterUnitEvent(27117, 3, "AmberpineScout_OnKilledTarget")
RegisterUnitEvent(27117, 4, "AmberpineScout_OnDied")


--[[ Grizzly Hills -- Ancient Drakkari King.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function AncientDrakkariKing_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientDrakkariKing_DrakkariCurse", 8000, 0)
end

function AncientDrakkariKing_DrakkariCurse(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52466, pUnit:GetMainTank()) 
end

function AncientDrakkariKing_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientDrakkariKing_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientDrakkariKing_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26871, 1, "AncientDrakkariKing_OnCombat")
RegisterUnitEvent(26871, 2, "AncientDrakkariKing_OnLeaveCombat")
RegisterUnitEvent(26871, 3, "AncientDrakkariKing_OnKilledTarget")
RegisterUnitEvent(26871, 4, "AncientDrakkariKing_OnDied")


--[[ Grizzly Hills -- Ancient Drakkari Soothsayer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function AncientDrakkariSoothsayer_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientDrakkariSoothsayer_HolySmite", 5000, 0)
Unit:RegisterEvent("AncientDrakkariSoothsayer_ProphecyofBlood", 9000, 0)
end

function AncientDrakkariSoothsayer_HolySmite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9734, pUnit:GetMainTank()) 
end

function AncientDrakkariSoothsayer_ProphecyofBlood(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52468, pUnit:GetMainTank()) 
end

function AncientDrakkariSoothsayer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientDrakkariSoothsayer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientDrakkariSoothsayer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26812, 1, "AncientDrakkariSoothsayer_OnCombat")
RegisterUnitEvent(26812, 2, "AncientDrakkariSoothsayer_OnLeaveCombat")
RegisterUnitEvent(26812, 3, "AncientDrakkariSoothsayer_OnKilledTarget")
RegisterUnitEvent(26812, 4, "AncientDrakkariSoothsayer_OnDied")


--[[ Grizzly Hills -- Ancient Drakkari Warmonger.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function AncientDrakkariWarmonger_OnCombat(Unit, Event)
Unit:RegisterEvent("AncientDrakkariWarmonger_SunderArmor", 6000, 0)
end

function AncientDrakkariWarmonger_SunderArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50370, pUnit:GetMainTank()) 
end

function AncientDrakkariWarmonger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AncientDrakkariWarmonger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AncientDrakkariWarmonger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26811, 1, "AncientDrakkariWarmonger_OnCombat")
RegisterUnitEvent(26811, 2, "AncientDrakkariWarmonger_OnLeaveCombat")
RegisterUnitEvent(26811, 3, "AncientDrakkariWarmonger_OnKilledTarget")
RegisterUnitEvent(26811, 4, "AncientDrakkariWarmonger_OnDied")


--[[ Grizzly Hills -- Bambina.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Bambina_OnCombat(Unit, Event)
Unit:RegisterEvent("Bambina_BambinasVengeance", 4000, 1)
end

function Bambina_BambinasVengeance(pUnit, Event) 
pUnit:CastSpell(48869) 
end

function Bambina_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bambina_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bambina_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27461, 1, "Bambina_OnCombat")
RegisterUnitEvent(27461, 2, "Bambina_OnLeaveCombat")
RegisterUnitEvent(27461, 3, "Bambina_OnKilledTarget")
RegisterUnitEvent(27461, 4, "Bambina_OnDied")


--[[ Grizzly Hills -- Blood of the Old God.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function BloodoftheOldGod_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodoftheOldGod_CorruptionoftheOldGod", 7000, 0)
end

function BloodoftheOldGod_CorruptionoftheOldGod(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52564, pUnit:GetMainTank()) 
end

function BloodoftheOldGod_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodoftheOldGod_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodoftheOldGod_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28854, 1, "BloodoftheOldGod_OnCombat")
RegisterUnitEvent(28854, 2, "BloodoftheOldGod_OnLeaveCombat")
RegisterUnitEvent(28854, 3, "BloodoftheOldGod_OnKilledTarget")
RegisterUnitEvent(28854, 4, "BloodoftheOldGod_OnDied")


--[[ Grizzly Hills -- Bloodmoon Cultist.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function BloodmoonCultist_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodmoonCultist_Enrage", 10000, 0)
Unit:RegisterEvent("BloodmoonCultist_InfectedWorgenBite", 4000, 3)
Unit:RegisterEvent("BloodmoonCultist_SinisterStrike", 6000, 0)
end

function BloodmoonCultist_Enrage(pUnit, Event) 
pUnit:CastSpell(32714) 
end

function BloodmoonCultist_InfectedWorgenBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53094, pUnit:GetMainTank()) 
end

function BloodmoonCultist_SinisterStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14873, pUnit:GetMainTank()) 
end

function BloodmoonCultist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodmoonCultist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodmoonCultist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27024, 1, "BloodmoonCultist_OnCombat")
RegisterUnitEvent(27024, 2, "BloodmoonCultist_OnLeaveCombat")
RegisterUnitEvent(27024, 3, "BloodmoonCultist_OnKilledTarget")
RegisterUnitEvent(27024, 4, "BloodmoonCultist_OnDied")


--[[ Grizzly Hills -- Bloodmoon Servant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function BloodmoonServant_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodmoonServant_Enrage", 10000, 0)
end

function BloodmoonServant_Enrage(pUnit, Event) 
pUnit:CastSpell(32714) 
end

function BloodmoonServant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodmoonServant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodmoonServant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(29082, 1, "BloodmoonServant_OnCombat")
RegisterUnitEvent(29082, 2, "BloodmoonServant_OnLeaveCombat")
RegisterUnitEvent(29082, 3, "BloodmoonServant_OnKilledTarget")
RegisterUnitEvent(29082, 4, "BloodmoonServant_OnDied")


--[[ Grizzly Hills -- Bloodmoon Worgen.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function BloodmoonWorgen_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodmoonWorgen_Enrage", 10000, 0)
Unit:RegisterEvent("BloodmoonWorgen_InfectedWorgenBite", 4000, 3)
Unit:RegisterEvent("BloodmoonWorgen_SinisterStrike", 6000, 0)
end

function BloodmoonWorgen_Enrage(pUnit, Event) 
pUnit:CastSpell(32714) 
end

function BloodmoonWorgen_InfectedWorgenBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53094, pUnit:GetMainTank()) 
end

function BloodmoonWorgen_SinisterStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14873, pUnit:GetMainTank()) 
end

function BloodmoonWorgen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodmoonWorgen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodmoonWorgen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27020, 1, "BloodmoonWorgen_OnCombat")
RegisterUnitEvent(27020, 2, "BloodmoonWorgen_OnLeaveCombat")
RegisterUnitEvent(27020, 3, "BloodmoonWorgen_OnKilledTarget")
RegisterUnitEvent(27020, 4, "BloodmoonWorgen_OnDied")


--[[ Grizzly Hills -- Camp Oneqwah Brave.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function CampOneqwahBrave_OnCombat(Unit, Event)
Unit:RegisterEvent("CampOneqwahBrave_Cleave", 8000, 0)
end

function CampOneqwahBrave_Cleave(pUnit, Event) 
pUnit:CastSpell(40505) 
end

function CampOneqwahBrave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CampOneqwahBrave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CampOneqwahBrave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27126, 1, "CampOneqwahBrave_OnCombat")
RegisterUnitEvent(27126, 2, "CampOneqwahBrave_OnLeaveCombat")
RegisterUnitEvent(27126, 3, "CampOneqwahBrave_OnKilledTarget")
RegisterUnitEvent(27126, 4, "CampOneqwahBrave_OnDied")


--[[ Grizzly Hills -- Commander Howser.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function CommanderHowser_OnCombat(Unit, Event)
Unit:RegisterEvent("CommanderHowser_BerserkerCharge", 6000, 0)
Unit:RegisterEvent("CommanderHowser_Whirlwind", 8000, 0)
end

function CommanderHowser_BerserkerCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16636, pUnit:GetMainTank()) 
end

function CommanderHowser_Whirlwind(pUnit, Event) 
pUnit:CastSpell(15589) 
end

function CommanderHowser_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CommanderHowser_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CommanderHowser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27759, 1, "CommanderHowser_OnCombat")
RegisterUnitEvent(27759, 2, "CommanderHowser_OnLeaveCombat")
RegisterUnitEvent(27759, 3, "CommanderHowser_OnKilledTarget")
RegisterUnitEvent(27759, 4, "CommanderHowser_OnDied")


--[[ Grizzly Hills -- Conqueror Krenna.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquerorKrenna_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquerorKrenna_Cleave", 8000, 0)
Unit:RegisterEvent("ConquerorKrenna_Fixate", 10000, 0)
Unit:RegisterEvent("ConquerorKrenna_Pummel", 17000, 0)
Unit:RegisterEvent("ConquerorKrenna_Slam", 12000, 0)
end

function ConquerorKrenna_Cleave(pUnit, Event) 
pUnit:CastSpell(15284) 
end

function ConquerorKrenna_Fixate(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34719, pUnit:GetMainTank()) 
end

function ConquerorKrenna_Pummel(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12555, pUnit:GetMainTank()) 
end

function ConquerorKrenna_Slam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(11430, pUnit:GetMainTank()) 
end

function ConquerorKrenna_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquerorKrenna_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquerorKrenna_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27727, 1, "ConquerorKrenna_OnCombat")
RegisterUnitEvent(27727, 2, "ConquerorKrenna_OnLeaveCombat")
RegisterUnitEvent(27727, 3, "ConquerorKrenna_OnKilledTarget")
RegisterUnitEvent(27727, 4, "ConquerorKrenna_OnDied")


--[[ Grizzly Hills -- Conquest Hold Berserker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquestHoldBerserker_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldBerserker_BattleShout", 4000, 1)
end

function ConquestHoldBerserker_BattleShout(pUnit, Event) 
pUnit:CastSpell(31403) 
end

function ConquestHoldBerserker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldBerserker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldBerserker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27500, 1, "ConquestHoldBerserker_OnCombat")
RegisterUnitEvent(27500, 2, "ConquestHoldBerserker_OnLeaveCombat")
RegisterUnitEvent(27500, 3, "ConquestHoldBerserker_OnKilledTarget")
RegisterUnitEvent(27500, 4, "ConquestHoldBerserker_OnDied")


--[[ Grizzly Hills -- Conquest Hold Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquestHoldDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldDefender_HeroicStrike", 5000, 0)
end

function ConquestHoldDefender_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(29426, pUnit:GetMainTank()) 
end

function ConquestHoldDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27748, 1, "ConquestHoldDefender_OnCombat")
RegisterUnitEvent(27748, 2, "ConquestHoldDefender_OnLeaveCombat")
RegisterUnitEvent(27748, 3, "ConquestHoldDefender_OnKilledTarget")
RegisterUnitEvent(27748, 4, "ConquestHoldDefender_OnDied")


--[[ Grizzly Hills -- Conquest Hold Grunt.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquestHoldGrunt_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldGrunt_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldGrunt_HeroicStrike", 5000, 0)
Unit:RegisterEvent("ConquestHoldGrunt_Intercept", 9000, 0)
end

function ConquestHoldGrunt_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function ConquestHoldGrunt_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25710, pUnit:GetMainTank()) 
end

function ConquestHoldGrunt_Intercept(pUnit, Event) 
pUnit:FullCastSpellOnTarget(27577, pUnit:GetMainTank()) 
end

function ConquestHoldGrunt_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldGrunt_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldGrunt_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27470, 1, "ConquestHoldGrunt_OnCombat")
RegisterUnitEvent(27470, 2, "ConquestHoldGrunt_OnLeaveCombat")
RegisterUnitEvent(27470, 3, "ConquestHoldGrunt_OnKilledTarget")
RegisterUnitEvent(27470, 4, "ConquestHoldGrunt_OnDied")


--[[ Grizzly Hills -- Conquest Hold Legionnaire.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquestHoldLegionnaire_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldLegionnaire_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldLegionnaire_Hamstring", 10000, 0)
end

function ConquestHoldLegionnaire_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(61044) 
end

function ConquestHoldLegionnaire_Hamstring(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9080, pUnit:GetMainTank()) 
end

function ConquestHoldLegionnaire_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldLegionnaire_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldLegionnaire_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26839, 1, "ConquestHoldLegionnaire_OnCombat")
RegisterUnitEvent(26839, 2, "ConquestHoldLegionnaire_OnLeaveCombat")
RegisterUnitEvent(26839, 3, "ConquestHoldLegionnaire_OnKilledTarget")
RegisterUnitEvent(26839, 4, "ConquestHoldLegionnaire_OnDied")


--[[ Grizzly Hills -- Conquest Hold Marauder.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquestHoldMarauder_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldMarauder_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldMarauder_HeroicStrike", 5000, 0)
Unit:RegisterEvent("ConquestHoldMarauder_Intercept", 9000, 0)
end

function ConquestHoldMarauder_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function ConquestHoldMarauder_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25710, pUnit:GetMainTank()) 
end

function ConquestHoldMarauder_Intercept(pUnit, Event) 
pUnit:FullCastSpellOnTarget(27577, pUnit:GetMainTank()) 
end

function ConquestHoldMarauder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldMarauder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldMarauder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27424, 1, "ConquestHoldMarauder_OnCombat")
RegisterUnitEvent(27424, 2, "ConquestHoldMarauder_OnLeaveCombat")
RegisterUnitEvent(27424, 3, "ConquestHoldMarauder_OnKilledTarget")
RegisterUnitEvent(27424, 4, "ConquestHoldMarauder_OnDied")


--[[ Grizzly Hills -- Conquest Hold Raider.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquestHoldRaider_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldRaider_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("ConquestHoldRaider_HeroicStrike", 5000, 0)
Unit:RegisterEvent("ConquestHoldRaider_Intercept", 9000, 0)
end

function ConquestHoldRaider_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function ConquestHoldRaider_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25710, pUnit:GetMainTank()) 
end

function ConquestHoldRaider_Intercept(pUnit, Event) 
pUnit:FullCastSpellOnTarget(27577, pUnit:GetMainTank()) 
end

function ConquestHoldRaider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldRaider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldRaider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27118, 1, "ConquestHoldRaider_OnCombat")
RegisterUnitEvent(27118, 2, "ConquestHoldRaider_OnLeaveCombat")
RegisterUnitEvent(27118, 3, "ConquestHoldRaider_OnKilledTarget")
RegisterUnitEvent(27118, 4, "ConquestHoldRaider_OnDied")


--[[ Grizzly Hills -- Conquest Hold Skirmisher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ConquestHoldSkirmisher_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldSkirmisher_Cleave", 8000, 0)
Unit:RegisterEvent("ConquestHoldSkirmisher_Hamstring", 10000, 0)
Unit:RegisterEvent("ConquestHoldSkirmisher_MortalStrike", 7000, 0)
end

function ConquestHoldSkirmisher_Cleave(pUnit, Event) 
pUnit:CastSpell(15496) 
end

function ConquestHoldSkirmisher_Hamstring(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9080, pUnit:GetMainTank()) 
end

function ConquestHoldSkirmisher_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32736, pUnit:GetMainTank()) 
end

function ConquestHoldSkirmisher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldSkirmisher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldSkirmisher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27456, 1, "ConquestHoldSkirmisher_OnCombat")
RegisterUnitEvent(27456, 2, "ConquestHoldSkirmisher_OnLeaveCombat")
RegisterUnitEvent(27456, 3, "ConquestHoldSkirmisher_OnKilledTarget")
RegisterUnitEvent(27456, 4, "ConquestHoldSkirmisher_OnDied")


--[[ Grizzly Hills -- Diseased Drakkari.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DiseasedDrakkari_OnCombat(Unit, Event)
Unit:RegisterEvent("DiseasedDrakkari_FeveredDisease", 10000, 0)
end

function DiseasedDrakkari_FeveredDisease(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34363, pUnit:GetMainTank()) 
end

function DiseasedDrakkari_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DiseasedDrakkari_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DiseasedDrakkari_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26457, 1, "DiseasedDrakkari_OnCombat")
RegisterUnitEvent(26457, 2, "DiseasedDrakkari_OnLeaveCombat")
RegisterUnitEvent(26457, 3, "DiseasedDrakkari_OnKilledTarget")
RegisterUnitEvent(26457, 4, "DiseasedDrakkari_OnDied")


--[[ Grizzly Hills -- Dragonflayer Flamebinder.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DragonflayerFlamebinder_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonflayerFlamebinder_FlamePatch", 10000, 0)
Unit:RegisterEvent("DragonflayerFlamebinder_InciteFlames", 7000, 0)
end

function DragonflayerFlamebinder_FlamePatch(pUnit, Event) 
pUnit:CastSpell(52208) 
end

function DragonflayerFlamebinder_InciteFlames(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52209, pUnit:GetMainTank()) 
end

function DragonflayerFlamebinder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonflayerFlamebinder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonflayerFlamebinder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27259, 1, "DragonflayerFlamebinder_OnCombat")
RegisterUnitEvent(27259, 2, "DragonflayerFlamebinder_OnLeaveCombat")
RegisterUnitEvent(27259, 3, "DragonflayerFlamebinder_OnKilledTarget")
RegisterUnitEvent(27259, 4, "DragonflayerFlamebinder_OnDied")


--[[ Grizzly Hills -- Dragonflayer Huscarl.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DragonflayerHuscarl_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonflayerHuscarl_Cleave", 8000, 0)
Unit:RegisterEvent("DragonflayerHuscarl_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("DragonflayerHuscarl_Disarm", 10000, 0)
Unit:RegisterEvent("DragonflayerHuscarl_Pummel", 15000, 0)
Unit:RegisterEvent("DragonflayerHuscarl_Squish", 5500, 0)
Unit:RegisterEvent("DragonflayerHuscarl_Whirlwind", 6500, 0)
end

function DragonflayerHuscarl_Cleave(pUnit, Event) 
pUnit:CastSpell(40505) 
end

function DragonflayerHuscarl_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function DragonflayerHuscarl_Disarm(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6713, pUnit:GetMainTank()) 
end

function DragonflayerHuscarl_Pummel(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12555, pUnit:GetMainTank()) 
end

function DragonflayerHuscarl_Squish(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52223, pUnit:GetMainTank()) 
end

function DragonflayerHuscarl_Whirlwind(pUnit, Event) 
pUnit:CastSpell(15578) 
end

function DragonflayerHuscarl_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonflayerHuscarl_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonflayerHuscarl_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27260, 1, "DragonflayerHuscarl_OnCombat")
RegisterUnitEvent(27260, 2, "DragonflayerHuscarl_OnLeaveCombat")
RegisterUnitEvent(27260, 3, "DragonflayerHuscarl_OnKilledTarget")
RegisterUnitEvent(27260, 4, "DragonflayerHuscarl_OnDied")


--[[ Grizzly Hills -- Drakaguul.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Drakaguul_OnCombat(Unit, Event)
Unit:RegisterEvent("Drakaguul_BerserkerCharge", 10000, 0)
Unit:RegisterEvent("Drakaguul_DrakaguulsSoldiers", 12000, 0)
end

function Drakaguul_BerserkerCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52460, pUnit:GetMainTank()) 
end

function Drakaguul_DrakaguulsSoldiers(pUnit, Event) 
pUnit:CastSpell(52457) 
end

function Drakaguul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Drakaguul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Drakaguul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26919, 1, "Drakaguul_OnCombat")
RegisterUnitEvent(26919, 2, "Drakaguul_OnLeaveCombat")
RegisterUnitEvent(26919, 3, "Drakaguul_OnKilledTarget")
RegisterUnitEvent(26919, 4, "Drakaguul_OnDied")


--[[ Grizzly Hills -- Drakkari Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DrakkariDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariDefender_Cleave", 8000, 0)
end

function DrakkariDefender_Cleave(pUnit, Event) 
pUnit:CastSpell(15496) 
end

function DrakkariDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26704, 1, "DrakkariDefender_OnCombat")
RegisterUnitEvent(26704, 2, "DrakkariDefender_OnLeaveCombat")
RegisterUnitEvent(26704, 3, "DrakkariDefender_OnKilledTarget")
RegisterUnitEvent(26704, 4, "DrakkariDefender_OnDied")


--[[ Grizzly Hills -- Drakkari Oracle.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DrakkariOracle_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariOracle_LightningBolt", 7000, 0)
Unit:RegisterEvent("DrakkariOracle_WarpedBody", 8000, 0)
Unit:RegisterEvent("DrakkariOracle_WarpedMind", 6000, 0)
end

function DrakkariOracle_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9532, pUnit:GetMainTank()) 
end

function DrakkariOracle_WarpedBody(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52431, pUnit:GetMainTank()) 
end

function DrakkariOracle_WarpedMind(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52430, pUnit:GetMainTank()) 
end

function DrakkariOracle_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariOracle_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariOracle_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26795, 1, "DrakkariOracle_OnCombat")
RegisterUnitEvent(26795, 2, "DrakkariOracle_OnLeaveCombat")
RegisterUnitEvent(26795, 3, "DrakkariOracle_OnKilledTarget")
RegisterUnitEvent(26795, 4, "DrakkariOracle_OnDied")


--[[ Grizzly Hills -- Drakkari Plague Spreader.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DrakkariPlagueSpreader_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariPlagueSpreader_PlagueInfected", 10000, 0)
end

function DrakkariPlagueSpreader_PlagueInfected(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52230, pUnit:GetMainTank()) 
end

function DrakkariPlagueSpreader_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariPlagueSpreader_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariPlagueSpreader_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27941, 1, "DrakkariPlagueSpreader_OnCombat")
RegisterUnitEvent(27941, 2, "DrakkariPlagueSpreader_OnLeaveCombat")
RegisterUnitEvent(27941, 3, "DrakkariPlagueSpreader_OnKilledTarget")
RegisterUnitEvent(27941, 4, "DrakkariPlagueSpreader_OnDied")


--[[ Grizzly Hills -- Drakkari Protector.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DrakkariProtector_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariProtector_HeadTrauma", 7000, 0)
end

function DrakkariProtector_HeadTrauma(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52425, pUnit:GetMainTank()) 
end

function DrakkariProtector_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariProtector_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariProtector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26797, 1, "DrakkariProtector_OnCombat")
RegisterUnitEvent(26797, 2, "DrakkariProtector_OnLeaveCombat")
RegisterUnitEvent(26797, 3, "DrakkariProtector_OnKilledTarget")
RegisterUnitEvent(26797, 4, "DrakkariProtector_OnDied")


--[[ Grizzly Hills -- Drakkari Shaman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DrakkariShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariShaman_LightningBolt", 7000, 0)
Unit:RegisterEvent("DrakkariShaman_MasteredElements", 10000, 0)
end

function DrakkariShaman_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9532, pUnit:GetMainTank()) 
end

function DrakkariShaman_MasteredElements(pUnit, Event) 
pUnit:CastSpell(52290) 
end

function DrakkariShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26447, 1, "DrakkariShaman_OnCombat")
RegisterUnitEvent(26447, 2, "DrakkariShaman_OnLeaveCombat")
RegisterUnitEvent(26447, 3, "DrakkariShaman_OnKilledTarget")
RegisterUnitEvent(26447, 4, "DrakkariShaman_OnDied")


--[[ Grizzly Hills -- Drakkari Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DrakkariWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariWarrior_WarriorsWill", 4000, 1)
end

function DrakkariWarrior_WarriorsWill(pUnit, Event) 
pUnit:CastSpell(52309) 
end

function DrakkariWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26425, 1, "DrakkariWarrior_OnCombat")
RegisterUnitEvent(26425, 2, "DrakkariWarrior_OnLeaveCombat")
RegisterUnitEvent(26425, 3, "DrakkariWarrior_OnKilledTarget")
RegisterUnitEvent(26425, 4, "DrakkariWarrior_OnDied")


--[[ Grizzly Hills -- Drakkari Witch Doctor.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DrakkariWitchDoctor_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariWitchDoctor_SuperiorHealingWard", 4000, 1)
Unit:RegisterEvent("DrakkariWitchDoctor_VoodooDoll", 7000, 0)
end

function DrakkariWitchDoctor_SuperiorHealingWard(pUnit, Event) 
pUnit:CastSpell(32194) 
end

function DrakkariWitchDoctor_VoodooDoll(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52695, pUnit:GetMainTank()) 
end

function DrakkariWitchDoctor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariWitchDoctor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariWitchDoctor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27555, 1, "DrakkariWitchDoctor_OnCombat")
RegisterUnitEvent(27555, 2, "DrakkariWitchDoctor_OnLeaveCombat")
RegisterUnitEvent(27555, 3, "DrakkariWitchDoctor_OnKilledTarget")
RegisterUnitEvent(27555, 4, "DrakkariWitchDoctor_OnDied")


--[[ Grizzly Hills -- Duskhowl Prowler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function DuskhowlProwler_OnCombat(Unit, Event)
Unit:RegisterEvent("DuskhowlProwler_Gore", 10000, 0)
end

function DuskhowlProwler_Gore(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32019, pUnit:GetMainTank()) 
end

function DuskhowlProwler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DuskhowlProwler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DuskhowlProwler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27408, 1, "DuskhowlProwler_OnCombat")
RegisterUnitEvent(27408, 2, "DuskhowlProwler_OnLeaveCombat")
RegisterUnitEvent(27408, 3, "DuskhowlProwler_OnKilledTarget")
RegisterUnitEvent(27408, 4, "DuskhowlProwler_OnDied")


--[[ Grizzly Hills -- Entropic Ooze.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function EntropicOoze_OnCombat(Unit, Event)
Unit:RegisterEvent("EntropicOoze_CrudeOoze", 7000, 0)
end

function EntropicOoze_CrudeOoze(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52334, pUnit:GetMainTank()) 
end

function EntropicOoze_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EntropicOoze_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EntropicOoze_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26366, 1, "EntropicOoze_OnCombat")
RegisterUnitEvent(26366, 2, "EntropicOoze_OnLeaveCombat")
RegisterUnitEvent(26366, 3, "EntropicOoze_OnKilledTarget")
RegisterUnitEvent(26366, 4, "EntropicOoze_OnDied")


--[[ Grizzly Hills -- Famished Scourge Troll.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function FamishedScourgeTroll_OnCombat(Unit, Event)
Unit:RegisterEvent("FamishedScourgeTroll_Suicide", 30000, 1)
end

function FamishedScourgeTroll_Suicide(pUnit, Event) 
pUnit:CastSpell(7) 
end

function FamishedScourgeTroll_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FamishedScourgeTroll_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FamishedScourgeTroll_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26570, 1, "FamishedScourgeTroll_OnCombat")
RegisterUnitEvent(26570, 2, "FamishedScourgeTroll_OnLeaveCombat")
RegisterUnitEvent(26570, 3, "FamishedScourgeTroll_OnKilledTarget")
RegisterUnitEvent(26570, 4, "FamishedScourgeTroll_OnDied")


--[[ Grizzly Hills -- Forgemaster Damrath.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ForgemasterDamrath_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgemasterDamrath_ForgeForce", 7000, 0)
end

function ForgemasterDamrath_ForgeForce(pUnit, Event) 
pUnit:CastSpell(52640) 
end

function ForgemasterDamrath_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgemasterDamrath_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgemasterDamrath_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26334, 1, "ForgemasterDamrath_OnCombat")
RegisterUnitEvent(26334, 2, "ForgemasterDamrath_OnLeaveCombat")
RegisterUnitEvent(26334, 3, "ForgemasterDamrath_OnKilledTarget")
RegisterUnitEvent(26334, 4, "ForgemasterDamrath_OnDied")


--[[ Grizzly Hills -- Frosthorn Ram.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function FrosthornRam_OnCombat(Unit, Event)
Unit:RegisterEvent("FrosthornRam_HoofStrike", 7000, 0)
end

function FrosthornRam_HoofStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(29577, pUnit:GetMainTank()) 
end

function FrosthornRam_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrosthornRam_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrosthornRam_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23740, 1, "FrosthornRam_OnCombat")
RegisterUnitEvent(23740, 2, "FrosthornRam_OnLeaveCombat")
RegisterUnitEvent(23740, 3, "FrosthornRam_OnKilledTarget")
RegisterUnitEvent(23740, 4, "FrosthornRam_OnDied")


--[[ Grizzly Hills -- Frostpaw Shaman.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function FrostpawShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("FrostpawShaman_ChainLightning", 6000, 0)
Unit:RegisterEvent("FrostpawShaman_LesserHealingWave", 13000, 0)
end

function FrostpawShaman_ChainLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12058, pUnit:GetMainTank()) 
end

function FrostpawShaman_LesserHealingWave(pUnit, Event) 
pUnit:CastSpell(25420) 
end

function FrostpawShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrostpawShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrostpawShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26428, 1, "FrostpawShaman_OnCombat")
RegisterUnitEvent(26428, 2, "FrostpawShaman_OnLeaveCombat")
RegisterUnitEvent(26428, 3, "FrostpawShaman_OnKilledTarget")
RegisterUnitEvent(26428, 4, "FrostpawShaman_OnDied")


--[[ Grizzly Hills -- Frostpaw Trapper.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function FrostpawTrapper_OnCombat(Unit, Event)
Unit:RegisterEvent("FrostpawTrapper_AimedShot", 9000, 0)
Unit:RegisterEvent("FrostpawTrapper_Shoot", 6000, 0)
Unit:RegisterEvent("FrostpawTrapper_WingClip", 12000, 0)
end

function FrostpawTrapper_AimedShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(30614, pUnit:GetMainTank()) 
end

function FrostpawTrapper_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function FrostpawTrapper_WingClip(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32908, pUnit:GetMainTank()) 
end

function FrostpawTrapper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrostpawTrapper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrostpawTrapper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26434, 1, "FrostpawTrapper_OnCombat")
RegisterUnitEvent(26434, 2, "FrostpawTrapper_OnLeaveCombat")
RegisterUnitEvent(26434, 3, "FrostpawTrapper_OnKilledTarget")
RegisterUnitEvent(26434, 4, "FrostpawTrapper_OnDied")


--[[ Grizzly Hills -- Frostpaw Warrior.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function FrostpawWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("FrostpawWarrior_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("FrostpawWarrior_Pummel", 12000, 0)
Unit:RegisterEvent("FrostpawWarrior_Rend", 10000, 0)
end

function FrostpawWarrior_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function FrostpawWarrior_Pummel(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12555, pUnit:GetMainTank()) 
end

function FrostpawWarrior_Rend(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12054, pUnit:GetMainTank()) 
end

function FrostpawWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrostpawWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrostpawWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26357, 1, "FrostpawWarrior_OnCombat")
RegisterUnitEvent(26357, 2, "FrostpawWarrior_OnLeaveCombat")
RegisterUnitEvent(26357, 3, "FrostpawWarrior_OnKilledTarget")
RegisterUnitEvent(26357, 4, "FrostpawWarrior_OnDied")


--[[ Grizzly Hills -- General Gorlok.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function GeneralGorlok_OnCombat(Unit, Event)
Unit:RegisterEvent("GeneralGorlok_BerserkerCharge", 6000, 0)
Unit:RegisterEvent("GeneralGorlok_MortalStrike", 8000, 0)
end

function GeneralGorlok_BerserkerCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16636, pUnit:GetMainTank()) 
end

function GeneralGorlok_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16856, pUnit:GetMainTank()) 
end

function GeneralGorlok_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GeneralGorlok_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GeneralGorlok_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27708, 1, "GeneralGorlok_OnCombat")
RegisterUnitEvent(27708, 2, "GeneralGorlok_OnLeaveCombat")
RegisterUnitEvent(27708, 3, "GeneralGorlok_OnKilledTarget")
RegisterUnitEvent(27708, 4, "GeneralGorlok_OnDied")


--[[ Grizzly Hills -- Goremaw.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Goremaw_OnCombat(Unit, Event)
Unit:RegisterEvent("Goremaw_CarnivorousBite", 10000, 0)
Unit:RegisterEvent("Goremaw_InfectedWorgenBite", 4000, 3)
end

function Goremaw_CarnivorousBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50729, pUnit:GetMainTank()) 
end

function Goremaw_InfectedWorgenBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53174, pUnit:GetMainTank()) 
end

function Goremaw_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Goremaw_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Goremaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27578, 1, "Goremaw_OnCombat")
RegisterUnitEvent(27578, 2, "Goremaw_OnLeaveCombat")
RegisterUnitEvent(27578, 3, "Goremaw_OnKilledTarget")
RegisterUnitEvent(27578, 4, "Goremaw_OnDied")


--[[ Grizzly Hills -- Graymist Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function GraymistHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("GraymistHunter_Gore", 10000, 0)
end

function GraymistHunter_Gore(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32019, pUnit:GetMainTank()) 
end

function GraymistHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GraymistHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GraymistHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26592, 1, "GraymistHunter_OnCombat")
RegisterUnitEvent(26592, 2, "GraymistHunter_OnLeaveCombat")
RegisterUnitEvent(26592, 3, "GraymistHunter_OnKilledTarget")
RegisterUnitEvent(26592, 4, "GraymistHunter_OnDied")


--[[ Grizzly Hills -- Grizzlesnout.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Grizzlesnout_OnCombat(Unit, Event)
Unit:RegisterEvent("Grizzlesnout_GnawBone", 8000, 0)
end

function Grizzlesnout_GnawBone(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50046, pUnit:GetMainTank()) 
end

function Grizzlesnout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Grizzlesnout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Grizzlesnout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27523, 1, "Grizzlesnout_OnCombat")
RegisterUnitEvent(27523, 2, "Grizzlesnout_OnLeaveCombat")
RegisterUnitEvent(27523, 3, "Grizzlesnout_OnKilledTarget")
RegisterUnitEvent(27523, 4, "Grizzlesnout_OnDied")


--[[ Grizzly Hills -- Grocklar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Grocklar_OnCombat(Unit, Event)
Unit:RegisterEvent("Grocklar_StoneFist", 3000, 1)
Unit:RegisterEvent("Grocklar_StoneStomp", 8000, 0)
end

function Grocklar_StoneFist(pUnit, Event) 
pUnit:CastSpell(49676) 
end

function Grocklar_StoneStomp(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49675, pUnit:GetMainTank()) 
end

function Grocklar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Grocklar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Grocklar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32422, 1, "Grocklar_OnCombat")
RegisterUnitEvent(32422, 2, "Grocklar_OnLeaveCombat")
RegisterUnitEvent(32422, 3, "Grocklar_OnKilledTarget")
RegisterUnitEvent(32422, 4, "Grocklar_OnDied")


--[[ Grizzly Hills -- Grumbald One Eye.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function GrumbaldOneEye_OnCombat(Unit, Event)
Unit:RegisterEvent("GrumbaldOneEye_ElementalEnlightenment", 3000, 1)
Unit:RegisterEvent("GrumbaldOneEye_FireBlast", 6000, 0)
Unit:RegisterEvent("GrumbaldOneEye_FrostNova", 9000, 0)
Unit:RegisterEvent("GrumbaldOneEye_FrostfireBolt", 9500, 0)
end

function GrumbaldOneEye_ElementalEnlightenment(pUnit, Event) 
pUnit:CastSpell(52495) 
end

function GrumbaldOneEye_FireBlast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13339, pUnit:GetMainTank()) 
end

function GrumbaldOneEye_FrostNova(pUnit, Event) 
pUnit:CastSpell(11831) 
end

function GrumbaldOneEye_FrostfireBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51779, pUnit:GetMainTank()) 
end

function GrumbaldOneEye_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GrumbaldOneEye_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GrumbaldOneEye_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26681, 1, "GrumbaldOneEye_OnCombat")
RegisterUnitEvent(26681, 2, "GrumbaldOneEye_OnLeaveCombat")
RegisterUnitEvent(26681, 3, "GrumbaldOneEye_OnKilledTarget")
RegisterUnitEvent(26681, 4, "GrumbaldOneEye_OnDied")


--[[ Grizzly Hills -- Guardian Serpent.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function GuardianSerpent_OnCombat(Unit, Event)
Unit:RegisterEvent("GuardianSerpent_TailLash", 6000, 0)
end

function GuardianSerpent_TailLash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34811, pUnit:GetMainTank()) 
end

function GuardianSerpent_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GuardianSerpent_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GuardianSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26806, 1, "GuardianSerpent_OnCombat")
RegisterUnitEvent(26806, 2, "GuardianSerpent_OnLeaveCombat")
RegisterUnitEvent(26806, 3, "GuardianSerpent_OnKilledTarget")
RegisterUnitEvent(26806, 4, "GuardianSerpent_OnDied")


--[[ Grizzly Hills -- Horgrenn Hellcleave.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function HorgrennHellcleave_OnCombat(Unit, Event)
Unit:RegisterEvent("HorgrennHellcleave_IntimidatingRoar", 12000, 1)
Unit:RegisterEvent("HorgrennHellcleave_MortalStrike", 7000, 0)
Unit:RegisterEvent("HorgrennHellcleave_SunderArmor", 6000, 0)
Unit:RegisterEvent("HorgrennHellcleave_Whirlwind", 8000, 0)
end

function HorgrennHellcleave_IntimidatingRoar(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16508, pUnit:GetMainTank()) 
end

function HorgrennHellcleave_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(39171, pUnit:GetMainTank()) 
end

function HorgrennHellcleave_SunderArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15572, pUnit:GetMainTank()) 
end

function HorgrennHellcleave_Whirlwind(pUnit, Event) 
pUnit:CastSpell(38619) 
end

function HorgrennHellcleave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HorgrennHellcleave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HorgrennHellcleave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27718, 1, "HorgrennHellcleave_OnCombat")
RegisterUnitEvent(27718, 2, "HorgrennHellcleave_OnLeaveCombat")
RegisterUnitEvent(27718, 3, "HorgrennHellcleave_OnKilledTarget")
RegisterUnitEvent(27718, 4, "HorgrennHellcleave_OnDied")


--[[ Grizzly Hills -- Ice Serpent.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IceSerpent_OnCombat(Unit, Event)
Unit:RegisterEvent("IceSerpent_IceSlash", 7000, 0)
end

function IceSerpent_IceSlash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(51878, pUnit:GetMainTank()) 
end

function IceSerpent_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceSerpent_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26446, 1, "IceSerpent_OnCombat")
RegisterUnitEvent(26446, 2, "IceSerpent_OnLeaveCombat")
RegisterUnitEvent(26446, 3, "IceSerpent_OnKilledTarget")
RegisterUnitEvent(26446, 4, "IceSerpent_OnDied")


--[[ Grizzly Hills -- Iceshard Elemental.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IceshardElemental_OnCombat(Unit, Event)
Unit:RegisterEvent("IceshardElemental_IceSpike", 8000, 0)
end

function IceshardElemental_IceSpike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50094, pUnit:GetMainTank()) 
end

function IceshardElemental_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IceshardElemental_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IceshardElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24228, 1, "IceshardElemental_OnCombat")
RegisterUnitEvent(24228, 2, "IceshardElemental_OnLeaveCombat")
RegisterUnitEvent(24228, 3, "IceshardElemental_OnKilledTarget")
RegisterUnitEvent(24228, 4, "IceshardElemental_OnDied")


--[[ Grizzly Hills -- Infected Grizzly Bear.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function InfectedGrizzlyBear_OnCombat(Unit, Event)
Unit:RegisterEvent("InfectedGrizzlyBear_InfectedBite", 8000, 0)
end

function InfectedGrizzlyBear_InfectedBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49861, pUnit:GetMainTank()) 
end

function InfectedGrizzlyBear_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfectedGrizzlyBear_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfectedGrizzlyBear_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26706, 1, "InfectedGrizzlyBear_OnCombat")
RegisterUnitEvent(26706, 2, "InfectedGrizzlyBear_OnLeaveCombat")
RegisterUnitEvent(26706, 3, "InfectedGrizzlyBear_OnKilledTarget")
RegisterUnitEvent(26706, 4, "InfectedGrizzlyBear_OnDied")


--[[ Grizzly Hills -- Iron Rune Avenger.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IronRuneAvenger_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneAvenger_RuneofRetribution", 3000, 1)
end

function IronRuneAvenger_RuneofRetribution(pUnit, Event) 
pUnit:CastSpell(52628) 
end

function IronRuneAvenger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneAvenger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneAvenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26786, 1, "IronRuneAvenger_OnCombat")
RegisterUnitEvent(26786, 2, "IronRuneAvenger_OnLeaveCombat")
RegisterUnitEvent(26786, 3, "IronRuneAvenger_OnKilledTarget")
RegisterUnitEvent(26786, 4, "IronRuneAvenger_OnDied")


--[[ Grizzly Hills -- Iron Rune Overseer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IronRuneOverseer_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneOverseer_CallLightning", 6000, 0)
end

function IronRuneOverseer_CallLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32018, pUnit:GetMainTank()) 
end

function IronRuneOverseer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneOverseer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneOverseer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27177, 1, "IronRuneOverseer_OnCombat")
RegisterUnitEvent(27177, 2, "IronRuneOverseer_OnLeaveCombat")
RegisterUnitEvent(27177, 3, "IronRuneOverseer_OnKilledTarget")
RegisterUnitEvent(27177, 4, "IronRuneOverseer_OnDied")


--[[ Grizzly Hills -- Iron Rune Shaper.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IronRuneShaper_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneShaper_MoldRune", 3000, 1)
end

function IronRuneShaper_MoldRune(pUnit, Event) 
pUnit:CastSpell(52622) 
end

function IronRuneShaper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneShaper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneShaper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26270, 1, "IronRuneShaper_OnCombat")
RegisterUnitEvent(26270, 2, "IronRuneShaper_OnLeaveCombat")
RegisterUnitEvent(26270, 3, "IronRuneShaper_OnKilledTarget")
RegisterUnitEvent(26270, 4, "IronRuneShaper_OnDied")


--[[ Grizzly Hills -- Iron Rune-Smith.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IronRuneSmith_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneSmith_LightningCharged", 4000, 1)
Unit:RegisterEvent("IronRuneSmith_SmeltRune", 10000, 0)
end

function IronRuneSmith_LightningCharged(pUnit, Event) 
pUnit:CastSpell(52701) 
end

function IronRuneSmith_SmeltRune(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52699, pUnit:GetMainTank()) 
end

function IronRuneSmith_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneSmith_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneSmith_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26408, 1, "IronRuneSmith_OnCombat")
RegisterUnitEvent(26408, 2, "IronRuneSmith_OnLeaveCombat")
RegisterUnitEvent(26408, 3, "IronRuneSmith_OnKilledTarget")
RegisterUnitEvent(26408, 4, "IronRuneSmith_OnDied")


--[[ Grizzly Hills -- Iron Rune Weaver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IronRuneWeaver_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneWeaver_RuneWeaving", 9000, 0)
end

function IronRuneWeaver_RuneWeaving(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52713, pUnit:GetMainTank()) 
end

function IronRuneWeaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneWeaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneWeaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26820, 1, "IronRuneWeaver_OnCombat")
RegisterUnitEvent(26820, 2, "IronRuneWeaver_OnLeaveCombat")
RegisterUnitEvent(26820, 3, "IronRuneWeaver_OnKilledTarget")
RegisterUnitEvent(26820, 4, "IronRuneWeaver_OnDied")


--[[ Grizzly Hills -- Iron Thane Argrum.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IronThaneArgrum_OnCombat(Unit, Event)
Unit:RegisterEvent("IronThaneArgrum_CallLightning", 6000, 0)
Unit:RegisterEvent("IronThaneArgrum_LightningShield", 4000, 0)
end

function IronThaneArgrum_CallLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32018, pUnit:GetMainTank()) 
end

function IronThaneArgrum_LightningShield(pUnit, Event) 
pUnit:CastSpell(52651) 
end

function IronThaneArgrum_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronThaneArgrum_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronThaneArgrum_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26348, 1, "IronThaneArgrum_OnCombat")
RegisterUnitEvent(26348, 2, "IronThaneArgrum_OnLeaveCombat")
RegisterUnitEvent(26348, 3, "IronThaneArgrum_OnKilledTarget")
RegisterUnitEvent(26348, 4, "IronThaneArgrum_OnDied")


--[[ Grizzly Hills -- Iron Thane Furyhammer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function IronThaneFuryhammer_OnCombat(Unit, Event)
Unit:RegisterEvent("IronThaneFuryhammer_Furyhammer", 8000, 0)
Unit:RegisterEvent("IronThaneFuryhammer_FuryhammersImmunity", 15000, 1)
end

function IronThaneFuryhammer_Furyhammer(pUnit, Event) 
pUnit:CastSpell(61576) 
end

function IronThaneFuryhammer_FuryhammersImmunity(pUnit, Event) 
pUnit:CastSpell(47922) 
end

function IronThaneFuryhammer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronThaneFuryhammer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronThaneFuryhammer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26405, 1, "IronThaneFuryhammer_OnCombat")
RegisterUnitEvent(26405, 2, "IronThaneFuryhammer_OnLeaveCombat")
RegisterUnitEvent(26405, 3, "IronThaneFuryhammer_OnKilledTarget")
RegisterUnitEvent(26405, 4, "IronThaneFuryhammer_OnDied")


--[[ Grizzly Hills -- Ironhide.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Ironhide_OnCombat(Unit, Event)
Unit:RegisterEvent("Ironhide_Charge", 10000, 0)
Unit:RegisterEvent("Ironhide_Maul", 6000, 0)
Unit:RegisterEvent("Ironhide_Swipe", 5000, 0)
end

function Ironhide_Charge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32323, pUnit:GetMainTank()) 
end

function Ironhide_Maul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34298, pUnit:GetMainTank()) 
end

function Ironhide_Swipe(pUnit, Event) 
pUnit:FullCastSpellOnTarget(31279, pUnit:GetMainTank()) 
end

function Ironhide_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Ironhide_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Ironhide_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27715, 1, "Ironhide_OnCombat")
RegisterUnitEvent(27715, 2, "Ironhide_OnLeaveCombat")
RegisterUnitEvent(27715, 3, "Ironhide_OnKilledTarget")
RegisterUnitEvent(27715, 4, "Ironhide_OnDied")


--[[ Grizzly Hills -- Lightning Sentry.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function LightningSentry_OnCombat(Unit, Event)
Unit:RegisterEvent("LightningSentry_ChargedSentryTotem", 4000, 1)
end

function LightningSentry_ChargedSentryTotem(pUnit, Event) 
pUnit:CastSpell(52703) 
end

function LightningSentry_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LightningSentry_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LightningSentry_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26407, 1, "LightningSentry_OnCombat")
RegisterUnitEvent(26407, 2, "LightningSentry_OnLeaveCombat")
RegisterUnitEvent(26407, 3, "LightningSentry_OnKilledTarget")
RegisterUnitEvent(26407, 4, "LightningSentry_OnDied")


--[[ Grizzly Hills -- Longhoof Grazer.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function LonghoofGrazer_OnCombat(Unit, Event)
Unit:RegisterEvent("LonghoofGrazer_HeadButt", 8000, 0)
end

function LonghoofGrazer_HeadButt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(42320, pUnit:GetMainTank()) 
end

function LonghoofGrazer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LonghoofGrazer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LonghoofGrazer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26418, 1, "LonghoofGrazer_OnCombat")
RegisterUnitEvent(26418, 2, "LonghoofGrazer_OnLeaveCombat")
RegisterUnitEvent(26418, 3, "LonghoofGrazer_OnKilledTarget")
RegisterUnitEvent(26418, 4, "LonghoofGrazer_OnDied")


--[[ Grizzly Hills -- Overseer Durval.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function OverseerDurval_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerDurval_RuneofDestruction", 8000, 0)
end

function OverseerDurval_RuneofDestruction(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52715, pUnit:GetMainTank()) 
end

function OverseerDurval_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerDurval_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerDurval_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26920, 1, "OverseerDurval_OnCombat")
RegisterUnitEvent(26920, 2, "OverseerDurval_OnLeaveCombat")
RegisterUnitEvent(26920, 3, "OverseerDurval_OnKilledTarget")
RegisterUnitEvent(26920, 4, "OverseerDurval_OnDied")


--[[ Grizzly Hills -- Overseer Korgan.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function OverseerKorgan_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerKorgan_CallLightning", 6000, 0)
Unit:RegisterEvent("OverseerKorgan_RevitalizingRune", 10000, 0)
end

function OverseerKorgan_CallLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32018, pUnit:GetMainTank()) 
end

function OverseerKorgan_RevitalizingRune(pUnit, Event) 
pUnit:CastSpell(52714) 
end

function OverseerKorgan_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerKorgan_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerKorgan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26921, 1, "OverseerKorgan_OnCombat")
RegisterUnitEvent(26921, 2, "OverseerKorgan_OnLeaveCombat")
RegisterUnitEvent(26921, 3, "OverseerKorgan_OnKilledTarget")
RegisterUnitEvent(26921, 4, "OverseerKorgan_OnDied")


--[[ Grizzly Hills -- Overseer Lochli.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function OverseerLochli_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerLochli_Thunderstorm", 11000, 0)
end

function OverseerLochli_Thunderstorm(pUnit, Event) 
pUnit:CastSpell(52717) 
end

function OverseerLochli_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerLochli_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerLochli_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26922, 1, "OverseerLochli_OnCombat")
RegisterUnitEvent(26922, 2, "OverseerLochli_OnLeaveCombat")
RegisterUnitEvent(26922, 3, "OverseerLochli_OnKilledTarget")
RegisterUnitEvent(26922, 4, "OverseerLochli_OnDied")


--[[ Grizzly Hills -- Redfang Elder.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RedfangElder_OnCombat(Unit, Event)
Unit:RegisterEvent("RedfangElder_ChainHeal", 12000, 0)
Unit:RegisterEvent("RedfangElder_Hurricane", 10000, 0)
end

function RedfangElder_ChainHeal(pUnit, Event) 
pUnit:CastSpell(14900) 
end

function RedfangElder_Hurricane(pUnit, Event) 
pUnit:CastSpell(32717) 
end

function RedfangElder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RedfangElder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RedfangElder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26436, 1, "RedfangElder_OnCombat")
RegisterUnitEvent(26436, 2, "RedfangElder_OnLeaveCombat")
RegisterUnitEvent(26436, 3, "RedfangElder_OnKilledTarget")
RegisterUnitEvent(26436, 4, "RedfangElder_OnDied")


--[[ Grizzly Hills -- Redfang Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RedfangHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("RedfangHunter_CarnivorousBite", 10000, 0)
Unit:RegisterEvent("RedfangHunter_Net", 11000, 0)
Unit:RegisterEvent("RedfangHunter_Shoot", 6000, 0)
end

function RedfangHunter_CarnivorousBite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(30639, pUnit:GetMainTank()) 
end

function RedfangHunter_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12024, pUnit:GetMainTank()) 
end

function RedfangHunter_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function RedfangHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RedfangHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RedfangHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26356, 1, "RedfangHunter_OnCombat")
RegisterUnitEvent(26356, 2, "RedfangHunter_OnLeaveCombat")
RegisterUnitEvent(26356, 3, "RedfangHunter_OnKilledTarget")
RegisterUnitEvent(26356, 4, "RedfangHunter_OnDied")


--[[ Grizzly Hills -- Rune Reaver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RuneReaver_OnCombat(Unit, Event)
Unit:RegisterEvent("RuneReaver_RuneofRetribution", 3000, 1)
end

function RuneReaver_RuneofRetribution(pUnit, Event) 
pUnit:CastSpell(52628) 
end

function RuneReaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RuneReaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RuneReaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26268, 1, "RuneReaver_OnCombat")
RegisterUnitEvent(26268, 2, "RuneReaver_OnLeaveCombat")
RegisterUnitEvent(26268, 3, "RuneReaver_OnKilledTarget")
RegisterUnitEvent(26268, 4, "RuneReaver_OnDied")


--[[ Grizzly Hills -- Rune Smith Durar.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RuneSmithDurar_OnCombat(Unit, Event)
Unit:RegisterEvent("RuneSmithDurar_LightningCharged", 4000, 1)
end

function RuneSmithDurar_LightningCharged(pUnit, Event) 
pUnit:CastSpell(52701) 
end

function RuneSmithDurar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RuneSmithDurar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RuneSmithDurar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26409, 1, "RuneSmithDurar_OnCombat")
RegisterUnitEvent(26409, 2, "RuneSmithDurar_OnLeaveCombat")
RegisterUnitEvent(26409, 3, "RuneSmithDurar_OnKilledTarget")
RegisterUnitEvent(26409, 4, "RuneSmithDurar_OnDied")


--[[ Grizzly Hills -- Rune Smith Kathorn.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RuneSmithKathorn_OnCombat(Unit, Event)
Unit:RegisterEvent("RuneSmithKathorn_LightningCharged", 4000, 1)
end

function RuneSmithKathorn_LightningCharged(pUnit, Event) 
pUnit:CastSpell(52701) 
end

function RuneSmithKathorn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RuneSmithKathorn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RuneSmithKathorn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26410, 1, "RuneSmithKathorn_OnCombat")
RegisterUnitEvent(26410, 2, "RuneSmithKathorn_OnLeaveCombat")
RegisterUnitEvent(26410, 3, "RuneSmithKathorn_OnKilledTarget")
RegisterUnitEvent(26410, 4, "RuneSmithKathorn_OnDied")


--[[ Grizzly Hills -- Runed Giant.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RunedGiant_OnCombat(Unit, Event)
Unit:RegisterEvent("RunedGiant_RuneFist", 3000, 1)
Unit:RegisterEvent("RunedGiant_Stomp", 11000, 0)
end

function RunedGiant_RuneFist(pUnit, Event) 
pUnit:CastSpell(49717) 
end

function RunedGiant_Stomp(pUnit, Event) 
pUnit:CastSpell(55196) 
end

function RunedGiant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunedGiant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunedGiant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26417, 1, "RunedGiant_OnCombat")
RegisterUnitEvent(26417, 2, "RunedGiant_OnLeaveCombat")
RegisterUnitEvent(26417, 3, "RunedGiant_OnKilledTarget")
RegisterUnitEvent(26417, 4, "RunedGiant_OnDied")


--[[ Grizzly Hills -- Runic Battle Golem.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RunicBattleGolem_OnCombat(Unit, Event)
Unit:RegisterEvent("RunicBattleGolem_BattleRunes", 7000, 0)
end

function RunicBattleGolem_BattleRunes(pUnit, Event) 
pUnit:CastSpell(52630) 
end

function RunicBattleGolem_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunicBattleGolem_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunicBattleGolem_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26284, 1, "RunicBattleGolem_OnCombat")
RegisterUnitEvent(26284, 2, "RunicBattleGolem_OnLeaveCombat")
RegisterUnitEvent(26284, 3, "RunicBattleGolem_OnKilledTarget")
RegisterUnitEvent(26284, 4, "RunicBattleGolem_OnDied")


--[[ Grizzly Hills -- Runic Lightning Gunner.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RunicLightningGunner_OnCombat(Unit, Event)
Unit:RegisterEvent("RunicLightningGunner_LightningGunShot", 6000, 0)
end

function RunicLightningGunner_LightningGunShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(46982, pUnit:GetMainTank()) 
end

function RunicLightningGunner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunicLightningGunner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunicLightningGunner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26414, 1, "RunicLightningGunner_OnCombat")
RegisterUnitEvent(26414, 2, "RunicLightningGunner_OnLeaveCombat")
RegisterUnitEvent(26414, 3, "RunicLightningGunner_OnKilledTarget")
RegisterUnitEvent(26414, 4, "RunicLightningGunner_OnDied")


--[[ Grizzly Hills -- Runic War Golem.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function RunicWarGolem_OnCombat(Unit, Event)
Unit:RegisterEvent("RunicWarGolem_RunePunch", 10000, 0)
end

function RunicWarGolem_RunePunch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52702, pUnit:GetMainTank()) 
end

function RunicWarGolem_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunicWarGolem_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunicWarGolem_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26347, 1, "RunicWarGolem_OnCombat")
RegisterUnitEvent(26347, 2, "RunicWarGolem_OnLeaveCombat")
RegisterUnitEvent(26347, 3, "RunicWarGolem_OnKilledTarget")
RegisterUnitEvent(26347, 4, "RunicWarGolem_OnDied")


--[[ Grizzly Hills -- Rustblood.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Rustblood_OnCombat(Unit, Event)
Unit:RegisterEvent("Rustblood_Cleave", 8000, 0)
Unit:RegisterEvent("Rustblood_HeadSmash", 10000, 0)
Unit:RegisterEvent("Rustblood_Knockback", 11000, 0)
Unit:RegisterEvent("Rustblood_LightningBolt", 6000, 0)
end

function Rustblood_Cleave(pUnit, Event) 
pUnit:CastSpell(42746) 
end

function Rustblood_HeadSmash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14102, pUnit:GetMainTank()) 
end

function Rustblood_Knockback(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49398, pUnit:GetMainTank()) 
end

function Rustblood_LightningBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(49454, pUnit:GetMainTank()) 
end

function Rustblood_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Rustblood_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Rustblood_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27717, 1, "Rustblood_OnCombat")
RegisterUnitEvent(27717, 2, "Rustblood_OnLeaveCombat")
RegisterUnitEvent(27717, 3, "Rustblood_OnKilledTarget")
RegisterUnitEvent(27717, 4, "Rustblood_OnDied")


--[[ Grizzly Hills -- Saronite Horror.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SaroniteHorror_OnCombat(Unit, Event)
Unit:RegisterEvent("SaroniteHorror_SeethingEvil", 3000, 1)
end

function SaroniteHorror_SeethingEvil(pUnit, Event) 
pUnit:CastSpell(52342) 
end

function SaroniteHorror_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SaroniteHorror_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SaroniteHorror_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26646, 1, "SaroniteHorror_OnCombat")
RegisterUnitEvent(26646, 2, "SaroniteHorror_OnLeaveCombat")
RegisterUnitEvent(26646, 3, "SaroniteHorror_OnKilledTarget")
RegisterUnitEvent(26646, 4, "SaroniteHorror_OnDied")


--[[ Grizzly Hills -- Scourge Deathspeaker.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ScourgeDeathspeaker_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgeDeathspeaker_Fireball", 6000, 0)
Unit:RegisterEvent("ScourgeDeathspeaker_FlameoftheSeer", 3000, 1)
end

function ScourgeDeathspeaker_Fireball(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52282, pUnit:GetMainTank()) 
end

function ScourgeDeathspeaker_FlameoftheSeer(pUnit, Event) 
pUnit:CastSpell(52281) 
end

function ScourgeDeathspeaker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgeDeathspeaker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgeDeathspeaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27615, 1, "ScourgeDeathspeaker_OnCombat")
RegisterUnitEvent(27615, 2, "ScourgeDeathspeaker_OnLeaveCombat")
RegisterUnitEvent(27615, 3, "ScourgeDeathspeaker_OnKilledTarget")
RegisterUnitEvent(27615, 4, "ScourgeDeathspeaker_OnDied")


--[[ Grizzly Hills -- Scout Captain Carter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ScoutCaptainCarter_OnCombat(Unit, Event)
Unit:RegisterEvent("ScoutCaptainCarter_DebilitatingStrike", 7000, 0)
end

function ScoutCaptainCarter_DebilitatingStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38621, pUnit:GetMainTank()) 
end

function ScoutCaptainCarter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScoutCaptainCarter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScoutCaptainCarter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27783, 1, "ScoutCaptainCarter_OnCombat")
RegisterUnitEvent(27783, 2, "ScoutCaptainCarter_OnLeaveCombat")
RegisterUnitEvent(27783, 3, "ScoutCaptainCarter_OnKilledTarget")
RegisterUnitEvent(27783, 4, "ScoutCaptainCarter_OnDied")


--[[ Grizzly Hills -- Seething Hate.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SeethingHate_OnCombat(Unit, Event)
Unit:RegisterEvent("SeethingHate_SeethingEvil", 3000, 1)
end

function SeethingHate_SeethingEvil(pUnit, Event) 
pUnit:CastSpell(52342) 
end

function SeethingHate_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SeethingHate_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SeethingHate_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32429, 1, "SeethingHate_OnCombat")
RegisterUnitEvent(32429, 2, "SeethingHate_OnLeaveCombat")
RegisterUnitEvent(32429, 3, "SeethingHate_OnKilledTarget")
RegisterUnitEvent(32429, 4, "SeethingHate_OnDied")


--[[ Grizzly Hills -- Selas.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function Selas_OnCombat(Unit, Event)
Unit:RegisterEvent("Selas_AxeVolley", 6000, 0)
Unit:RegisterEvent("Selas_KillingRage", 5000, 0)
end

function Selas_AxeVolley(pUnit, Event) 
pUnit:CastSpell(53239) 
end

function Selas_KillingRage(pUnit, Event) 
pUnit:CastSpell(52071) 
end

function Selas_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Selas_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Selas_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27580, 1, "Selas_OnCombat")
RegisterUnitEvent(27580, 2, "Selas_OnLeaveCombat")
RegisterUnitEvent(27580, 3, "Selas_OnKilledTarget")
RegisterUnitEvent(27580, 4, "Selas_OnDied")


--[[ Grizzly Hills -- Sergeant Bonesnap.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SergeantBonesnap_OnCombat(Unit, Event)
Unit:RegisterEvent("SergeantBonesnap_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("SergeantBonesnap_HeroicStrike", 5000, 0)
Unit:RegisterEvent("SergeantBonesnap_Intercept", 9000, 0)
end

function SergeantBonesnap_DemoralizingShout(pUnit, Event) 
pUnit:CastSpell(13730) 
end

function SergeantBonesnap_HeroicStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(25710, pUnit:GetMainTank()) 
end

function SergeantBonesnap_Intercept(pUnit, Event) 
pUnit:FullCastSpellOnTarget(27577, pUnit:GetMainTank()) 
end

function SergeantBonesnap_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SergeantBonesnap_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SergeantBonesnap_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27493, 1, "SergeantBonesnap_OnCombat")
RegisterUnitEvent(27493, 2, "SergeantBonesnap_OnLeaveCombat")
RegisterUnitEvent(27493, 3, "SergeantBonesnap_OnKilledTarget")
RegisterUnitEvent(27493, 4, "SergeantBonesnap_OnDied")


--[[ Grizzly Hills -- Serpent Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SerpentDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("SerpentDefender_TailLash", 8000, 0)
end

function SerpentDefender_TailLash(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34811, pUnit:GetMainTank()) 
end

function SerpentDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SerpentDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SerpentDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(29693, 1, "SerpentDefender_OnCombat")
RegisterUnitEvent(29693, 2, "SerpentDefender_OnLeaveCombat")
RegisterUnitEvent(29693, 3, "SerpentDefender_OnKilledTarget")
RegisterUnitEvent(29693, 4, "SerpentDefender_OnDied")


--[[ Grizzly Hills -- Shade of Arugal.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function ShadeofArugal_OnCombat(Unit, Event)
Unit:RegisterEvent("ShadeofArugal_PhaseOut", 45000, 0)
Unit:RegisterEvent("ShadeofArugal_ShadowBolt", 8000, 0)
Unit:RegisterEvent("ShadeofArugal_WorgensCommand", 15000, 1)
end

function ShadeofArugal_PhaseOut(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53052, pUnit:GetMainTank()) 
end

function ShadeofArugal_ShadowBolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53086, pUnit:GetMainTank()) 
end

function ShadeofArugal_WorgensCommand(pUnit, Event) 
pUnit:FullCastSpellOnTarget(53070, pUnit:GetMainTank()) 
end

function ShadeofArugal_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ShadeofArugal_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ShadeofArugal_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27018, 1, "ShadeofArugal_OnCombat")
RegisterUnitEvent(27018, 2, "ShadeofArugal_OnLeaveCombat")
RegisterUnitEvent(27018, 3, "ShadeofArugal_OnKilledTarget")
RegisterUnitEvent(27018, 4, "ShadeofArugal_OnDied")


--[[ Grizzly Hills -- Silverbrook Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SilverbrookDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookDefender_LumberjackSlam", 8000, 0)
Unit:RegisterEvent("SilverbrookDefender_Rend", 10000, 0)
end

function SilverbrookDefender_LumberjackSlam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52318, pUnit:GetMainTank()) 
end

function SilverbrookDefender_Rend(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12054, pUnit:GetMainTank()) 
end

function SilverbrookDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27676, 1, "SilverbrookDefender_OnCombat")
RegisterUnitEvent(27676, 2, "SilverbrookDefender_OnLeaveCombat")
RegisterUnitEvent(27676, 3, "SilverbrookDefender_OnKilledTarget")
RegisterUnitEvent(27676, 4, "SilverbrookDefender_OnDied")


--[[ Grizzly Hills -- Silverbrook Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SilverbrookHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookHunter_ImprovedWingClip", 14000, 0)
Unit:RegisterEvent("SilverbrookHunter_Shoot", 6000, 0)
end

function SilverbrookHunter_ImprovedWingClip(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47168, pUnit:GetMainTank()) 
end

function SilverbrookHunter_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SilverbrookHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27546, 1, "SilverbrookHunter_OnCombat")
RegisterUnitEvent(27546, 2, "SilverbrookHunter_OnLeaveCombat")
RegisterUnitEvent(27546, 3, "SilverbrookHunter_OnKilledTarget")
RegisterUnitEvent(27546, 4, "SilverbrookHunter_OnDied")


--[[ Grizzly Hills -- Silverbrook Trapper.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SilverbrookTrapper_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookTrapper_HookedNet", 12000, 0)
Unit:RegisterEvent("SilverbrookTrapper_Shoot", 6000, 0)
end

function SilverbrookTrapper_HookedNet(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13608, pUnit:GetMainTank()) 
end

function SilverbrookTrapper_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SilverbrookTrapper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookTrapper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookTrapper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26679, 1, "SilverbrookTrapper_OnCombat")
RegisterUnitEvent(26679, 2, "SilverbrookTrapper_OnLeaveCombat")
RegisterUnitEvent(26679, 3, "SilverbrookTrapper_OnKilledTarget")
RegisterUnitEvent(26679, 4, "SilverbrookTrapper_OnDied")


--[[ Grizzly Hills -- Silverbrook Villager.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SilverbrookVillager_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookVillager_Chop", 5000, 0)
end

function SilverbrookVillager_Chop(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43410, pUnit:GetMainTank()) 
end

function SilverbrookVillager_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookVillager_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookVillager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26708, 1, "SilverbrookVillager_OnCombat")
RegisterUnitEvent(26708, 2, "SilverbrookVillager_OnLeaveCombat")
RegisterUnitEvent(26708, 3, "SilverbrookVillager_OnKilledTarget")
RegisterUnitEvent(26708, 4, "SilverbrookVillager_OnDied")


--[[ Grizzly Hills -- Silverbrook Worgen.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SilverbrookWorgen_OnCombat(Unit, Event)
Unit:RegisterEvent("SilverbrookWorgen_Dash", 10000, 0)
end

function SilverbrookWorgen_Dash(pUnit, Event) 
pUnit:CastSpell(36589) 
end

function SilverbrookWorgen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SilverbrookWorgen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SilverbrookWorgen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(47417, 1, "SilverbrookWorgen_OnCombat")
RegisterUnitEvent(47417, 2, "SilverbrookWorgen_OnLeaveCombat")
RegisterUnitEvent(47417, 3, "SilverbrookWorgen_OnKilledTarget")
RegisterUnitEvent(47417, 4, "SilverbrookWorgen_OnDied")


--[[ Grizzly Hills -- Westfall Brigade Marine.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function WestfallBrigadeMarine_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeMarine_ConcussionBlow", 9000, 0)
Unit:RegisterEvent("WestfallBrigadeMarine_SunderArmor", 5000, 0)
end

function WestfallBrigadeMarine_ConcussionBlow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52719, pUnit:GetMainTank()) 
end

function WestfallBrigadeMarine_SunderArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50307, pUnit:GetMainTank()) 
end

function WestfallBrigadeMarine_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeMarine_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeMarine_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27501, 1, "WestfallBrigadeMarine_OnCombat")
RegisterUnitEvent(27501, 2, "WestfallBrigadeMarine_OnLeaveCombat")
RegisterUnitEvent(27501, 3, "WestfallBrigadeMarine_OnKilledTarget")
RegisterUnitEvent(27501, 4, "WestfallBrigadeMarine_OnDied")


--[[ Grizzly Hills -- Solstice Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 3th, 2009. ]]


function SolsticeHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("SolsticeHunter_ImmolationTrap", 2000, 1)
Unit:RegisterEvent("SolsticeHunter_MultiShot", 10000, 0)
Unit:RegisterEvent("SolsticeHunter_ScorpidSting", 9000, 0)
Unit:RegisterEvent("SolsticeHunter_SerpentSting", 11000, 0)
Unit:RegisterEvent("SolsticeHunter_Shoot", 6000, 0)
end

function SolsticeHunter_ImmolationTrap(pUnit, Event) 
pUnit:CastSpell(52606) 
end

function SolsticeHunter_MultiShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14443, pUnit:GetMainTank()) 
end

function SolsticeHunter_ScorpidSting(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52604, pUnit:GetMainTank()) 
end

function SolsticeHunter_SerpentSting(pUnit, Event) 
pUnit:FullCastSpellOnTarget(31975, pUnit:GetMainTank()) 
end

function SolsticeHunter_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function SolsticeHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SolsticeHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SolsticeHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26389, 1, "SolsticeHunter_OnCombat")
RegisterUnitEvent(26389, 2, "SolsticeHunter_OnLeaveCombat")
RegisterUnitEvent(26389, 3, "SolsticeHunter_OnKilledTarget")
RegisterUnitEvent(26389, 4, "SolsticeHunter_OnDied")


--[[ Grizzly Hills -- Syreian the Bonecarver.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function SyreiantheBonecarver_OnCombat(Unit, Event)
Unit:RegisterEvent("SyreiantheBonecarver_FrostArrow", 7000, 0)
Unit:RegisterEvent("SyreiantheBonecarver_ImprovedWingClip", 13000, 0)
Unit:RegisterEvent("SyreiantheBonecarver_Shoot", 6000, 0)
end

function SyreiantheBonecarver_FrostArrow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38952, pUnit:GetMainTank()) 
end

function SyreiantheBonecarver_ImprovedWingClip(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47168, pUnit:GetMainTank()) 
end

function SyreiantheBonecarver_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50092, pUnit:GetMainTank()) 
end

function SyreiantheBonecarver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SyreiantheBonecarver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SyreiantheBonecarver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32438, 1, "SyreiantheBonecarver_OnCombat")
RegisterUnitEvent(32438, 2, "SyreiantheBonecarver_OnLeaveCombat")
RegisterUnitEvent(32438, 3, "SyreiantheBonecarver_OnKilledTarget")
RegisterUnitEvent(32438, 4, "SyreiantheBonecarver_OnDied")


--[[ Grizzly Hills -- Tallhorn Stag.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function TallhornStag_OnCombat(Unit, Event)
Unit:RegisterEvent("TallhornStag_Gore", 10000, 0)
end

function TallhornStag_Gore(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32019, pUnit:GetMainTank()) 
end

function TallhornStag_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TallhornStag_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TallhornStag_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26363, 1, "TallhornStag_OnCombat")
RegisterUnitEvent(26363, 2, "TallhornStag_OnLeaveCombat")
RegisterUnitEvent(26363, 3, "TallhornStag_OnKilledTarget")
RegisterUnitEvent(26363, 4, "TallhornStag_OnDied")


--[[ Grizzly Hills -- Tatjana.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function Tatjana_OnCombat(Unit, Event)
Unit:RegisterEvent("Tatjana_Cutdown", 8000, 0)
end

function Tatjana_Cutdown(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32009, pUnit:GetMainTank()) 
end

function Tatjana_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tatjana_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tatjana_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27627, 1, "Tatjana_OnCombat")
RegisterUnitEvent(27627, 2, "Tatjana_OnLeaveCombat")
RegisterUnitEvent(27627, 3, "Tatjana_OnKilledTarget")
RegisterUnitEvent(27627, 4, "Tatjana_OnDied")


--[[ Grizzly Hills -- Tecahuna.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function Tecahuna_OnCombat(Unit, Event)
Unit:RegisterEvent("Tecahuna_TecahunaVenomSpit", 9000, 0)
end

function Tecahuna_TecahunaVenomSpit(pUnit, Event) 
pUnit:FullCastSpellOnTarget(47629, pUnit:GetMainTank()) 
end

function Tecahuna_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tecahuna_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tecahuna_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26865, 1, "Tecahuna_OnCombat")
RegisterUnitEvent(26865, 2, "Tecahuna_OnLeaveCombat")
RegisterUnitEvent(26865, 3, "Tecahuna_OnKilledTarget")
RegisterUnitEvent(26865, 4, "Tecahuna_OnDied")


--[[ Grizzly Hills -- Thane Torvald Eriksson.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function ThaneTorvaldEriksson_OnCombat(Unit, Event)
Unit:RegisterEvent("ThaneTorvaldEriksson_ArcaneShot", 7000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_MultiShot", 10000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_Shoot", 6000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_TorvaldsDeterrence", 11000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_Volley", 13000, 0)
end

function ThaneTorvaldEriksson_ArcaneShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34829, pUnit:GetMainTank()) 
end

function ThaneTorvaldEriksson_MultiShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52813, pUnit:GetMainTank()) 
end

function ThaneTorvaldEriksson_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(50512, pUnit:GetMainTank()) 
end

function ThaneTorvaldEriksson_TorvaldsDeterrence(pUnit, Event) 
pUnit:CastSpell(57057) 
end

function ThaneTorvaldEriksson_Volley(pUnit, Event) 
pUnit:CastSpell(56843) 
end

function ThaneTorvaldEriksson_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ThaneTorvaldEriksson_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ThaneTorvaldEriksson_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27377, 1, "ThaneTorvaldEriksson_OnCombat")
RegisterUnitEvent(27377, 2, "ThaneTorvaldEriksson_OnLeaveCombat")
RegisterUnitEvent(27377, 3, "ThaneTorvaldEriksson_OnKilledTarget")
RegisterUnitEvent(27377, 4, "ThaneTorvaldEriksson_OnDied")


--[[ Grizzly Hills -- The Anvil.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function TheAnvi_OnCombat(Unit, Event)
Unit:RegisterEvent("TheAnvi_MoltenBlast", 8000, 0)
end

function TheAnvi_MoltenBlast(pUnit, Event) 
pUnit:CastSpell(61577) 
end

function TheAnvi_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TheAnvi_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TheAnvi_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26406, 1, "TheAnvi_OnCombat")
RegisterUnitEvent(26406, 2, "TheAnvi_OnLeaveCombat")
RegisterUnitEvent(26406, 3, "TheAnvi_OnKilledTarget")
RegisterUnitEvent(26406, 4, "TheAnvi_OnDied")


--[[ Grizzly Hills -- Torgg Thundertotem.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function TorggThundertotem_OnCombat(Unit, Event)
Unit:RegisterEvent("TorggThundertotem_ChainLightning", 9000, 0)
Unit:RegisterEvent("TorggThundertotem_CorruptedNovaTotem", 2000, 1)
Unit:RegisterEvent("TorggThundertotem_EarthShock", 6000, 0)
Unit:RegisterEvent("TorggThundertotem_HealingWave", 13000, 0)
end

function TorggThundertotem_ChainLightning(pUnit, Event) 
pUnit:FullCastSpellOnTarget(16033, pUnit:GetMainTank()) 
end

function TorggThundertotem_CorruptedNovaTotem(pUnit, Event) 
pUnit:CastSpell(31991) 
end

function TorggThundertotem_EarthShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15501, pUnit:GetMainTank()) 
end

function TorggThundertotem_HealingWave(pUnit, Event) 
pUnit:CastSpell(15982) 
end

function TorggThundertotem_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TorggThundertotem_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TorggThundertotem_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27716, 1, "TorggThundertotem_OnCombat")
RegisterUnitEvent(27716, 2, "TorggThundertotem_OnLeaveCombat")
RegisterUnitEvent(27716, 3, "TorggThundertotem_OnKilledTarget")
RegisterUnitEvent(27716, 4, "TorggThundertotem_OnDied")


--[[ Grizzly Hills -- Undead Miner.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function UndeadMiner_OnCombat(Unit, Event)
Unit:RegisterEvent("UndeadMiner_PunctureWound", 7000, 0)
Unit:RegisterEvent("UndeadMiner_ThrowLantern", 9000, 1)
end

function UndeadMiner_PunctureWound(pUnit, Event) 
pUnit:FullCastSpellOnTarget(48374, pUnit:GetMainTank()) 
end

function UndeadMiner_ThrowLantern(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52608, pUnit:GetMainTank()) 
end

function UndeadMiner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UndeadMiner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UndeadMiner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26891, 1, "UndeadMiner_OnCombat")
RegisterUnitEvent(26891, 2, "UndeadMiner_OnLeaveCombat")
RegisterUnitEvent(26891, 3, "UndeadMiner_OnKilledTarget")
RegisterUnitEvent(26891, 4, "UndeadMiner_OnDied")


--[[ Grizzly Hills -- Ursoc.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function Ursoc_OnCombat(Unit, Event)
Unit:RegisterEvent("Ursoc_CrunchArmor", 6000, 0)
Unit:RegisterEvent("Ursoc_OldGodsInfluence", 10000, 1)
Unit:RegisterEvent("Ursoc_Summon BloodoftheOldGod", 5000, 1)
end

function Ursoc_CrunchArmor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52581, pUnit:GetMainTank()) 
end

function Ursoc_OldGodsInfluence(pUnit, Event) 
pUnit:FullCastSpellOnTarget(52583, pUnit:GetMainTank()) 
end

function Ursoc_SummonBloodoftheOldGod(pUnit, Event) 
pUnit:CastSpell(52560) 
end

function Ursoc_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Ursoc_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Ursoc_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26633, 1, "Ursoc_OnCombat")
RegisterUnitEvent(26633, 2, "Ursoc_OnLeaveCombat")
RegisterUnitEvent(26633, 3, "Ursoc_OnKilledTarget")
RegisterUnitEvent(26633, 4, "Ursoc_OnDied")


--[[ Grizzly Hills -- Ursus Mauler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function UrsusMauler_OnCombat(Unit, Event)
Unit:RegisterEvent("UrsusMauler_Maul", 5000, 0)
end

function UrsusMauler_Maul(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12161, pUnit:GetMainTank()) 
end

function UrsusMauler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UrsusMauler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UrsusMauler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26644, 1, "UrsusMauler_OnCombat")
RegisterUnitEvent(26644, 2, "UrsusMauler_OnLeaveCombat")
RegisterUnitEvent(26644, 3, "UrsusMauler_OnKilledTarget")
RegisterUnitEvent(26644, 4, "UrsusMauler_OnDied")


--[[ Grizzly Hills -- Varlam.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function Varlam_OnCombat(Unit, Event)
Unit:RegisterEvent("Varlam_Cleave", 9000, 0)
Unit:RegisterEvent("Varlam_MortalStrike", 7000, 0)
end

function Varlam_Cleave(pUnit, Event) 
pUnit:CastSpell(15496) 
end

function Varlam_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32736, pUnit:GetMainTank()) 
end

function Varlam_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Varlam_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Varlam_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27579, 1, "Varlam_OnCombat")
RegisterUnitEvent(27579, 2, "Varlam_OnLeaveCombat")
RegisterUnitEvent(27579, 3, "Varlam_OnKilledTarget")
RegisterUnitEvent(27579, 4, "Varlam_OnDied")


--[[ Grizzly Hills -- Venture Co Evacuee.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function VentureCoEvacuee_OnCombat(Unit, Event)
Unit:RegisterEvent("VentureCoEvacuee_QuickFeet", 5000, 0)
end

function VentureCoEvacuee_QuickFeet(pUnit, Event) 
pUnit:CastSpell(50054) 
end

function VentureCoEvacuee_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VentureCoEvacuee_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VentureCoEvacuee_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27830, 1, "VentureCoEvacuee_OnCombat")
RegisterUnitEvent(27830, 2, "VentureCoEvacuee_OnLeaveCombat")
RegisterUnitEvent(27830, 3, "VentureCoEvacuee_OnKilledTarget")
RegisterUnitEvent(27830, 4, "VentureCoEvacuee_OnDied")


--[[ Grizzly Hills -- Venture Co Straggler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function VentureCoStraggler_OnCombat(Unit, Event)
Unit:RegisterEvent("VentureCoStraggler_Chop", 5000, 0)
end

function VentureCoStraggler_Chop(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43410, pUnit:GetMainTank()) 
end

function VentureCoStraggler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VentureCoStraggler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VentureCoStraggler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27570, 1, "VentureCoStraggler_OnCombat")
RegisterUnitEvent(27570, 2, "VentureCoStraggler_OnLeaveCombat")
RegisterUnitEvent(27570, 3, "VentureCoStraggler_OnKilledTarget")
RegisterUnitEvent(27570, 4, "VentureCoStraggler_OnDied")


--[[ Grizzly Hills -- Vladek.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function Vladek_OnCombat(Unit, Event)
Unit:RegisterEvent("Vladek_Enrage", 10000, 0)
end

function Vladek_Enrage(pUnit, Event) 
pUnit:CastSpell(32714) 
end

function Vladek_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Vladek_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Vladek_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27547, 1, "Vladek_OnCombat")
RegisterUnitEvent(27547, 2, "Vladek_OnLeaveCombat")
RegisterUnitEvent(27547, 3, "Vladek_OnKilledTarget")
RegisterUnitEvent(27547, 4, "Vladek_OnDied")


--[[ Grizzly Hills -- Warlord Zimbo.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function WarlordZimbo_OnCombat(Unit, Event)
Unit:RegisterEvent("WarlordZimbo_SkullCrack", 8000, 0)
Unit:RegisterEvent("WarlordZimbo_WarlordRoar", 2000, 1)
end

function WarlordZimbo_SkullCrack(pUnit, Event) 
pUnit:FullCastSpellOnTarget(3551, pUnit:GetMainTank()) 
end

function WarlordZimbo_WarlordRoar(pUnit, Event) 
pUnit:CastSpell(52283) 
end

function WarlordZimbo_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarlordZimbo_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarlordZimbo_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26544, 1, "WarlordZimbo_OnCombat")
RegisterUnitEvent(26544, 2, "WarlordZimbo_OnLeaveCombat")
RegisterUnitEvent(26544, 3, "WarlordZimbo_OnKilledTarget")
RegisterUnitEvent(26544, 4, "WarlordZimbo_OnDied")


--[[ Grizzly Hills -- Westfall Brigade Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function WestfallBrigadeDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeDefender_Strike", 6000, 0)
end

function WestfallBrigadeDefender_Strike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14516, pUnit:GetMainTank()) 
end

function WestfallBrigadeDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27758, 1, "WestfallBrigadeDefender_OnCombat")
RegisterUnitEvent(27758, 2, "WestfallBrigadeDefender_OnLeaveCombat")
RegisterUnitEvent(27758, 3, "WestfallBrigadeDefender_OnKilledTarget")
RegisterUnitEvent(27758, 4, "WestfallBrigadeDefender_OnDied")


--[[ Grizzly Hills -- Westfall Brigade Elite.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function WestfallBrigadeElite_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeElite_Hamstring", 10000, 0)
Unit:RegisterEvent("WestfallBrigadeElite_Strike", 8000, 0)
end

function WestfallBrigadeElite_Hamstring(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9080, pUnit:GetMainTank()) 
end

function WestfallBrigadeElite_Strike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(11976, pUnit:GetMainTank()) 
end

function WestfallBrigadeElite_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeElite_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeElite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27549, 1, "WestfallBrigadeElite_OnCombat")
RegisterUnitEvent(27549, 2, "WestfallBrigadeElite_OnLeaveCombat")
RegisterUnitEvent(27549, 3, "WestfallBrigadeElite_OnKilledTarget")
RegisterUnitEvent(27549, 4, "WestfallBrigadeElite_OnDied")


--[[ Grizzly Hills -- Westfall Brigade Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function WestfallBrigadeHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeHunter_AimedShot", 7000, 0)
end

function WestfallBrigadeHunter_AimedShot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38861, pUnit:GetMainTank()) 
end

function WestfallBrigadeHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27462, 1, "WestfallBrigadeHunter_OnCombat")
RegisterUnitEvent(27462, 2, "WestfallBrigadeHunter_OnLeaveCombat")
RegisterUnitEvent(27462, 3, "WestfallBrigadeHunter_OnKilledTarget")
RegisterUnitEvent(27462, 4, "WestfallBrigadeHunter_OnDied")


--[[ Grizzly Hills -- Wounded Skirmisher.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function WoundedSkirmisher_OnCombat(Unit, Event)
Unit:RegisterEvent("WoundedSkirmisher_Cleave", 9000, 0)
Unit:RegisterEvent("WoundedSkirmisher_Hamstring", 10000, 0)
Unit:RegisterEvent("WoundedSkirmisher_MortalStrike", 7000, 0)
end

function WoundedSkirmisher_Cleave(pUnit, Event) 
pUnit:CastSpell(15496) 
end

function WoundedSkirmisher_Hamstring(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9080, pUnit:GetMainTank()) 
end

function WoundedSkirmisher_MortalStrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32736, pUnit:GetMainTank()) 
end

function WoundedSkirmisher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoundedSkirmisher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoundedSkirmisher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27463, 1, "WoundedSkirmisher_OnCombat")
RegisterUnitEvent(27463, 2, "WoundedSkirmisher_OnLeaveCombat")
RegisterUnitEvent(27463, 3, "WoundedSkirmisher_OnKilledTarget")
RegisterUnitEvent(27463, 4, "WoundedSkirmisher_OnDied")


--[[ Grizzly Hills -- Wounded Westfall Infantry.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, January, 4th, 2009. ]]


function WoundedWestfallInfantry_OnCombat(Unit, Event)
Unit:RegisterEvent("WoundedWestfallInfantry_HolyShock", 6000, 0)
Unit:RegisterEvent("WoundedWestfallInfantry_SealofCommand", 4000, 1)
end

function WoundedWestfallInfantry_HolyShock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32771, pUnit:GetMainTank()) 
end

function WoundedWestfallInfantry_SealofCommand(pUnit, Event) 
pUnit:CastSpell(29385) 
end

function WoundedWestfallInfantry_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoundedWestfallInfantry_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoundedWestfallInfantry_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27482, 1, "WoundedWestfallInfantry_OnCombat")
RegisterUnitEvent(27482, 2, "WoundedWestfallInfantry_OnLeaveCombat")
RegisterUnitEvent(27482, 3, "WoundedWestfallInfantry_OnKilledTarget")
RegisterUnitEvent(27482, 4, "WoundedWestfallInfantry_OnDied")