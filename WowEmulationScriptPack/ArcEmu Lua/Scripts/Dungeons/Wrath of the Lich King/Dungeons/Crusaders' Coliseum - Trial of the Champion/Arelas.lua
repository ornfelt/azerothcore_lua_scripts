--[[
Highlord Tirion Fordring yells: A mighty blow has been dealt to the Lich King! You have proven yourselves as able bodied champions of the Argent Crusade. Together we will strike against Icecrown Citadel and destroy what remains of the Scourge! There is no challenge that we cannot face united!
Highlord Tirion Fordring yells: A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.
Highlord Tirion Fordring yells: Arthas! You are hopelessly outnumbered! Lay down Frostmourne and I will grant you a just death.
Highlord Tirion Fordring yells: Begin!
Highlord Tirion Fordring yells: Champions, you're alive! Not only have you defeated every challenge of the Trial of the Crusader, but also thwarted Arthas' plans! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of the Crusade's mages to transport you to the surface!
Highlord Tirion Fordring yells: Everyone calm down! Compose yourselves! There is no conspiracy at play here! The warlock acted on his own volition, outside of influences from the Alliance. The tournament must go on!
Highlord Tirion Fordring yells: Go now and rest; you've earned it.
Highlord Tirion Fordring yells: Grand Warlock Wilfred Fizzlebang will summon forth your next challenge. Stand by for his entry.
Highlord Tirion Fordring yells: Hailing from the deepest, darkest caverns of the Storm Peaks, Gormok the Impaler! Battle on, heroes!
Highlord Tirion Fordring yells: My congratulations, champions. Through trials both planned and unexpected, you have triumphed.
Highlord Tirion Fordring yells: Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourge's most powerful lieutenants: fearsome val'kyr, winged harbingers of the Lich King!
Highlord Tirion Fordring yells: Quickly, heroes, destroy the demon lord before it can open a portal to its twisted demonic realm!
Highlord Tirion Fordring yells: Steel yourselves, heroes, for the twin terrors, Acidmaw and Dreadscale, enter the arena!
Highlord Tirion Fordring yells: The air itself freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!
Highlord Tirion Fordring yells: The loss of Wilfred Fizzlebang, while unfortunate, should be a lesson to those that dare dabble in dark magic. Alas, you are victorious and now must face the next challenge.
Highlord Tirion Fordring yells: The monstrous menagerie has been vanquished!
Highlord Tirion Fordring yells: The next battle will be against the Argent Crusade's most powerful knights! Only by defeating them will you be deemed worthy...
Highlord Tirion Fordring yells: Tragic... They fought valiantly, but the beasts of Northrend triumphed. Let us observe a moment of silence for our fallen heroes.
Highlord Tirion Fordring yells: Very well. I will allow it. Fight with honor!
Highlord Tirion Fordring yells: Welcome, champions! You have heard the call of the Argent Crusade and you have boldly answered! It is here, in the Crusaders' Coliseum, that you will face your greatest challenges. Those of you who survive the rigors of the coliseum will join the Argent Crusade on its march to Icecrown Citadel.
Highlord Tirion Fordring yells: Welcome, champions. Today, before the eyes of your leaders and peers, you will prove yourselves worthy combatants.
Highlord Tirion Fordring yells: Well done. You have proven yourself today-
Highlord Tirion Fordring yells: Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess.
Highlord Tirion Fordring yells: What is the meaning of this?
Highlord Tirion Fordring yells: You may begin!
Highlord Tirion Fordring yells: You will first be facing three of the Grand Champions of the Tournament! These fierce contenders have beaten out all others to reach the pinnacle of skill in the joust.
]]--


function Tirion_OnSpawn(pUnit, event)
	pUnit:PlaySoundToSet(16036)
	pUnit:SendChatMessage(12, 0, "Welcome champions, you have heard the call of the Argent Crusade and you have boldly answered. It is here in the Crusaders Coliseum thatll you face your greatest challenges. Those of you that survive the riggers of the coliseum will join the Argent Crusade on its march to Icecrown Citadel.")
end


RegisterUnitEvent(34996, 18, "Tirion_OnSpawn")
	

function Arelas_OnGossipTalk(pUnit, event, player)
	pUnit:GossipCreateMenu(1, player, 0)
	pUnit:GossipMenuAddItem(0, "I am ready.", 1, 0)
	pUnit:GossipMenuAddItem(0, "I am not ready.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function Arelas_OnGossipSelect(pUnit, event, player, id, intid, pmisc)
	if(intid == 1) then
	pUnit:SpawnCreature(34996, 746.661682, 558.761353, 435.407013, 1.615844, 35, 0)
	player:GossipComplete()
	pUnit:SpawnLocalCreature(35604, 35, 0)
	pUnit:Despawn(100, 0)
	local team = player:GetTeam()
	if(team == 0) then
		local choice = math.random(1, 3)
		if(choice == 1) then
			pUnit:SpawnCreature(12009, 737.817810, 664.172607, 412.395111, 4.754529, 14, 0)
			pUnit:SpawnCreature(12006, 746.825989, 662.499084, 411.712555, 4.686143, 14, 0)
			pUnit:SpawnCreature(12008, 756.921082, 663.784058, 412.394165, 4.616966, 14, 0)
		elseif(choice == 2) then
			pUnit:SpawnCreature(12009, 737.817810, 664.172607, 412.395111, 4.754529, 14, 0)
			pUnit:SpawnCreature(12007, 746.825989, 662.499084, 411.712555, 4.686143, 14, 0)
			pUnit:SpawnCreature(12005, 756.921082, 663.784058, 412.394165, 4.616966, 14, 0)
		elseif(choice == 3) then
			pUnit:SpawnCreature(12007, 737.817810, 664.172607, 412.395111, 4.754529, 14, 0)
			pUnit:SpawnCreature(12006, 746.825989, 662.499084, 411.712555, 4.686143, 14, 0)
			pUnit:SpawnCreature(12005, 756.921082, 663.784058, 412.394165, 4.616966, 14, 0)
			end
end

		if(team == 1) then
			local weird = math.random(1, 3)
			if(weird == 1) then
				pUnit:SpawnCreature(12000, 737.817810, 664.172607, 412.395111, 4.754529, 14, 0)
				pUnit:SpawnCreature(12001, 746.825989, 662.499084, 411.712555, 4.686143, 14, 0)
				pUnit:SpawnCreature(12002, 756.921082, 663.784058, 412.394165, 4.616966, 14, 0)
			elseif(weird == 2) then
				pUnit:SpawnCreature(12003, 737.817810, 664.172607, 412.395111, 4.754529, 14, 0)
				pUnit:SpawnCreature(12004, 746.825989, 662.499084, 411.712555, 4.686143, 14, 0)
				pUnit:SpawnCreature(12002, 756.921082, 663.784058, 412.394165, 4.616966, 14, 0)
			elseif(weird == 3) then
				pUnit:SpawnCreature(12002, 737.817810, 664.172607, 412.395111, 4.754529, 14, 0)
				pUnit:SpawnCreature(12004, 746.825989, 662.499084, 411.712555, 4.686143, 14, 0)
				pUnit:SpawnCreature(12000, 756.921082, 663.784058, 412.394165, 4.616966, 14, 0)
			        end
	  end
end

	if(intid == 2) then
		player:GossipComplete()
		end
end

RegisterUnitGossipEvent(35005, 1, "Arelas_OnGossipTalk")
RegisterUnitGossipEvent(35005, 2, "Arelas_OnGossipSelect")

function Ambrose_OnSpawn(pUnit, event)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
			pUnit:SetMaxMana(159760)
			pUnit:SetMana(159760)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(315000)
			pUnit:SetHealth(315000)
			end
end
			
RegisterUnitEvent(12000, 18, "Ambrose_OnSpawn")

function DummyArelas_OnSpawn(pUnit, event)
	pUnit:RegisterEvent("DummyArelas_Move", 20000, 1)
	-- yell stuff --
	pUnit:MoveTo(698.035217, 600.620911, 412.390625, 0.400121)
end

function DummyArelas_Move(pUnit, event)
	pUnit:MoveTo(704.810669, 603.286804, 412.391998, 0.449600)
end

RegisterUnitEvent(35604, 18, "DummyArelas_OnSpawn")