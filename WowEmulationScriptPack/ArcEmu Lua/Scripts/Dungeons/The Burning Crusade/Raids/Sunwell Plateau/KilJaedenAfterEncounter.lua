-- The Encounter of Velen and Liadrin Talking
-- AFTER Kil'Jaeden Dies this is what happens
function Velen_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("Velen_Talk1", 4000, 1)
end

function Liadrin_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("Liadrin_Talk", 81000, 0)
end

function Velen_Talk1(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Mortal heroes, your victory here today was foretold long ago. My brother's anguished cry of defeat will echo across the universe, bringing renewed hope to all those who still stand against the Burning Crusade. ")
	pUnit:RegisterEvent("Velen_Talk2",25000, 1)
	pUnit:PlaySoundToSet(12515)
end

function Velen_Talk2(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "As the Legion's final defeat draws ever-nearer, stand proud in the knowledge that you have saved worlds without number from the flame.")
	pUnit:PlaySoundToSet(12516)
	pUnit:RegisterEvent("Velen_Talk2part2",14000, 1)
	pUnit:RegisterEvent("Velen_Talk3",24000, 1)
	end

function Velen_Talk2part2(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Just as this day marks an ending, so too does it herald a new beginning...")
	pUnit:PlaySoundToSet(12517)
end

function Velen_Talk3(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "The creature Entropius, whom you were forced to destroy, was once the noble naaru, M'uru. In life, M'uru channeled vast energies of Light and Hope. For a time, a misguided few sought to steal those energies... ")
	pUnit:PlaySoundToSet(12518)
	pUnit:RegisterEvent("Velen_Talk4",32000, 1)
	end

function Liadrin_Talk(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Our arrogance was unpardonable. We damned one of the most noble beings of all. We may never atone for this sin. ")
	pUnit:PlaySoundToSet(12524)
	pUnit:RegisterEvent("Liadrin_Talk2",9000, 1)
	end

function Velen_Talk4(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Then fortunate it is, that I have reclaimed the noble naaru's spark from where it fell! Where faith dwells, hope is never lost, young blood elf. ")
	pUnit:PlaySoundToSet(12519)
	pUnit:RegisterEvent("Velen_Talk5",5000, 1)
end

function Liadrin_Talk2(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Can it be?")
	pUnit:PlaySoundToSet(12525)
	pUnit:RegisterEvent("Liadrin_Talk3",2000, 1)
end

function Velen_Talk5(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Gaze now, mortals - upon the Heat Of M'uru! Unblemished. Bathed by the light of Creation - just as it was at the Dawn. ")
	pUnit:PlaySoundToSet(12519)
	pUnit:RegisterEvent("Velen_Talk6",16000, 1)
end

function Velen_Talk6(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "In time, the light and hope held within - will rebirth more than this mere fount of power... Mayhap, they will rebirth the soul of a nation. ")
	pUnit:PlaySoundToSet(12521)
	pUnit:RegisterEvent("Velen_Talk7",15000, 1)
end

function Liadrin_Talk3(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Blessed ancestors! I feel it... so much love... so much grace... there are... no words... impossible to describe...")
	pUnit:PlaySoundToSet(12525)
	pUnit:RegisterEvent("Liadrin_Talk3",31000, 1)
end

function Velen_Talk7(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Salvation, young one. It waits for us all. ")
	pUnit:PlaySoundToSet(12522)
	pUnit:RegisterEvent("Velen_Talk8",6000, 1)
end

function Velen_Talk8(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Farewell... ")
	pUnit:PlaySoundToSet(12523)
end

RegisterUnitEvent(26246, 6, "Velen_OnSpawn")
RegisterUnitEvent(25246, 6, "Liadrin_OnSpawn")