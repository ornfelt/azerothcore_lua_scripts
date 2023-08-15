--[[
16747	PS_Tyrannus_Openning01
16748	PS_Tyrannus_Openning02
16749	PS_Tyrannus_Openning03
16750	PS_Tyrannus_Openning04
16751	PS_Tyrannus_Openning05
16752	PS_Tyrannus_Forgemaster01
16753	PS_Tyrannus_Krick01
16754	PS_Tyrannus_Krick02
16755	PS_Tyrannus_Ambush01
16756	PS_Tyrannus_Ambush02
16757	PS_Tyrannus_GauntletStart01
16758	PS_Tyrannus_Prefight01
16759	PS_Tyrannus_Prefight02
16760	PS_Tyrannus_Aggro01
16761	PS_Tyrannus_Slay01
16762	PS_Tyrannus_Slay02
16763	PS_Tyrannus_Death01
16764	PS_Tyrannus_Mark01
16765	PS_Tyrannus_Kite01
16766	PS_Tyrannus_Attack
16767	PS_Tyrannus_Wound
16768	PS_Tyrannus_WoundCrit
------------------------------------------------------------------
Scourgelord Tyrannus yells: Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.
Scourgelord Tyrannus yells: Another shall take his place. You waste your time.
Scourgelord Tyrannus yells: Do not think that I shall permit you entry into my master's sanctum so easily. Pursue me if you dare.
Scourgelord Tyrannus yells: Ha, such an amusing gesture from the rabble. When I have finished with you, my master's blade will feast upon your souls. Die.
Scourgelord Tyrannus yells: Hrmph, fodder. Not even fit to labor in the quarry. Relish these final moments for soon you will be nothing more than mindless undead.
Scourgelord Tyrannus yells: Impossible.... Rimefang.... warn....
Scourgelord Tyrannus yells: Intruders have entered the master's domain. Signal the alarms!
Scourgelord Tyrannus yells: Minions, destroy these interlopers!
Scourgelord Tyrannus yells: Perhaps you should have stayed... in the mountains!
Scourgelord Tyrannus yells: Persistent whelps! You will not reach the entrance of my lord's lair! Soldiers, destroy them!
Scourgelord Tyrannus yells: Power... overwhelming!
Scourgelord Tyrannus yells: Rimefang, destroy this fool!
Scourgelord Tyrannus yells: Rimefang, trap them within the tunnel! BURY THEM ALIVE!
Scourgelord Tyrannus yells: Such a shameful display. You are better off dead.
Scourgelord Tyrannus yells: Worthless gnat! Death is all that awaits you!
Scourgelord Tyrannus yells: Your last waking memory will be of agonizing pain.
Scourgelord Tyrannus yells: Your pursuit shall be in vain, intruders, for the Lich King has placed an army of undead at my command! Behold!
]]--


function Tyrannus_OnCombat (pUnit, Event)
pUnit:SendChatMessage(14, 0, "Alas, brave brave heroes, do you hear the clatter of bone and steel coming up behind you? that is your end!")
pUnit:RegisterEvent("Tyrannus_Forceful", 18000, 0)
punit:RegisterEvent("Tyrannus_Overlord", 20000, 0)
punit:RegisterEvent("Tyrannus_Unholy", 24000, 0)
pUnit:RegisterEvent("Tyrannus_Mark", 16000, 0)
pUnit:RegisterEvent("Tyrannus_Icyblast", 19000, 0)
end

function Tyrannus_Forceful (pUnit, Event)
pUnit:FullCastSpellOnTarget(69155, pUnit:GetMainTank())
end

function Tyrannus_Overlord (pUnit, Event)
pUnit:FullCastSpellOnTarget (69172, pUnit:GetRandomPlayer(0))
end

function Tyrannus_Unholy (pUnit, Event)
pUnit:CastSpell(69167)
pUnit:SendChatMessage(14, 0, "Power... overwhelming!")
pUnit:SendChatMessage(42, 0, "Scourgelord Tyrannus roars and swells with dark might!")
end

function Tyrannus_Mark (pUnit, Event)
pUnit:FullCastSpellOnTarget (69275, pUnit:GetRandomPlayer(0))
pUnit:SendChatMessage(14, 0, "Rimefang, destroy this fool!")
pUnit:RegisterEvent("Tyrannus_Hoarfrost", 16000, 0)
end

function Tyrannus_Hoarfrost (pUnit, Event)
pUnit:FullCastSpellOnTarget (69245, pUnit:GetRandomPlayer(0))
end

function Tyrannus_Icyblast (pUnit, Event)
pUnit:FullCastSpellOnTarget (69238, pUnit:GetRandomPlayer(0))
end

function Tyrannus_OnKillPlr (pUnit, Event)
end

function Tyrannus_OnDeath (pUnit, Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "Impossible.... Rimefang.... warn....")
end

function Tyrannus_OnLeaveCombat (pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(36658, 1, "Tyrannus_OnCombat")
RegisterUnitEvent(36658, 2, "Tyrannus_OnLeaveCombat")
RegisterUnitEvent(36658, 3, "Tyrannus_OnKillPlr")
RegisterUnitEvent(36658, 4, "Tyrannus_OnDeath")