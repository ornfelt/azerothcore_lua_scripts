local SD = {}

SD.SpellAuraInterruptFlags = {
	None                        							= 0,
	HostileActionReceived       							= 2 ^ 0,
	Damage                      							= 2 ^ 1,
	Action                      							= 2 ^ 2,
	Moving													= 2 ^ 3,
}

SD.SpellFlags = {
	None 													= 0,
	
}

SD.SpellAttr = {
	SPELL_ATTR_PASSIVE										= 2 ^ 0,
	SPELL_ATTR_IS_CHANNELED									= 2 ^ 1,
	SPELL_ATTR_ALLOW_WHILE_STEALTHED						= 2 ^ 2,
	SPELL_ATTR_PREVENTS_ANIM								= 2 ^ 3,
	SPELL_ATTR_IGNORE_LINE_OF_SIGHT							= 2 ^ 4,
	SPELL_ATTR_NOT_AN_ACTION								= 2 ^ 5,
	SPELL_ATTR_CANT_CRIT									= 2 ^ 6,
	SPELL_ATTR_ALLOW_AURA_WHILE_DEAD						= 2 ^ 7,
	SPELL_ATTR_ALLOW_CAST_WHILE_CASTING						= 2 ^ 8,
	SPELL_ATTR_AURA_IS_BUFF									= 2 ^ 9,
	SPELL_ATTR_NOT_IN_SPELLBOOK								= 2 ^ 10,
	SPELL_ATTR_REMOVE_ENTERING_ARENA						= 2 ^ 11,
	SPELL_ATTR_ALLOW_WHILE_FLEEING							= 2 ^ 12,
	SPELL_ATTR_ALLOW_WHILE_CONFUSED							= 2 ^ 13,
	SPELL_ATTR_HASTE_AFFECTS_DURATION						= 2 ^ 14,
	SPELL_ATTR_NOT_IN_BG_OR_ARENA							= 2 ^ 15,
	SPELL_ATTR_NOT_USABLE_IN_ARENA							= 2 ^ 16,
	SPELL_ATTR_REACTIVE_DAMAGE_PROC							= 2 ^ 17,
	SPELL_ATTR_IGNORE_GCD									= 2 ^ 18,
	SPELL_ATTR_BREAKABLE_BY_DAMAGE							= 2 ^ 19 -- 524288
}

SD.TriggerFlags = {
	TRIGGERED_NONE											= 0,
	TRIGGERED_IGNORE_GCD									= 2 ^ 0,
	TRIGGERED_IGNORE_CAST_IN_PROGRESS						= 2 ^ 1,
	TRIGGERED_CAST_DIRECTLY									= 2 ^ 2,
	TRIGGERED_DISALLOW_PROC_EVENTS							= 2 ^ 3,
}

SD.DamageType = {
	NODAMAGE												= 2 ^ 0,
}

return SD
