function mb_Shaman_Elemental_OnLoad()
	mb_Shaman_SetEarthTotem("Tremor Totem")
	mb_Shaman_SetFireTotem("Totem of Wrath")
	mb_Shaman_SetWaterTotem("Healing Stream Totem")
	mb_Shaman_SetAirTotem("Wrath of Air Totem")

	mb_RegisterInterruptSpell("Wind Shear")
	mb_EnableIWTDistanceClosing("Lightning Bolt")
end

function mb_Shaman_Elemental_OnUpdate()
	if not mb_IsReadyForNewCast() then
		return
	end

	if mb_Drink() then
		return
	end

	if mb_ResurrectRaid("Ancestral Spirit") then
		return
	end

	if mb_Shaman_ApplyWeaponEnchants("Flametongue Weapon") then
		return
	end

	if mb_Shaman_HandleTotems() then
		return
	end

	if not UnitBuff("player", "Water Shield") then
		CastSpellByName("Water Shield")
		return
	end

	if not mb_AcquireOffensiveTarget() then
		return
	end

	if mb_UnitPowerPercentage("player") < 60 then
		if mb_CastSpellWithoutTarget("Thunderstorm") then
			return
		end
	end

	if mb_cleaveMode > 0 then
		local range = CheckInteractDistance("target", 2)
		if range then
			if mb_CastSpellWithoutTarget("Fire Nova") then
				return
			end

		end
	end

	if mb_ShouldUseDpsCooldowns("Lightning Bolt") and UnitAffectingCombat("player") then
		mb_UseItemCooldowns()
		mb_CastSpellWithoutTarget("Elemental Mastery")
	end

	if mb_Shaman_Elemental_HandleFlameShock() then
		return
	end

	if mb_Shaman_Elemental_HandleLightning() then
		return
	end
end

function mb_Shaman_Elemental_HandleFlameShock()

	if mb_GetMyDebuffTimeRemaining("target", "Flame Shock") == 0 then
		if mb_CastSpellOnTarget("Flame Shock") then
			return true
		end
	end

	if mb_GetMyDebuffTimeRemaining("target", "Flame Shock") < 1.5 then
		if mb_CastSpellOnTarget("Lightning Bolt") then
			return true
		end
	end

	if mb_CastSpellOnTarget("Lava Burst") then
		return true
	end

	return false
end

function mb_Shaman_Elemental_HandleLightning()

	if mb_CastSpellOnTarget("Chain Lightning") then
		return true
	end

	if mb_CastSpellOnTarget("Lightning Bolt") then
		return true
	end

	return false
end