function Huloz_OnCombat(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Ahh! More lambs to the slaughter!")
	pUnit:PlaySoundToSet(12463)
	pUnit:RegisterEvent("Combat_Talk", 30000, 0)
	pUnit:RegisterEvent("Meteor_Slash", 60000, 0)
	pUnit:RegisterEvent("Burn", 70000, 0)
	pUnit:RegisterEvent("Stomp", 45000, 0)
	pUnit:RegisterEvent("Enrage", 360000, 1)
end

function Huloz_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()	
end

function Huloz_OnKilledTarget (pUnit, event)
	local Choice=math.random(1, 3)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "Perish, insect!")
			pUnit:PlaySoundToSet(12464)
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "You are meat!")
			pUnit:PlaySoundToSet(12465)
		elseif Choice==3 then
			pUnit:SendChatMessage(14, 0, "Too easy!")
			pUnit:PlaySoundToSet(12466)
end
end

function Huloz_OnDied(pUnit, event)
	pUnit:SendChatMessage(14, 0, "Gah! Well done... Now... this gets... interesting... ")
	pUnit:PlaySoundToSet(12471)
	pUnit:RemoveEvents()	
end


function Enrage(pUnit, event)
	pUnit:CastSpell(26662)
	pUnit:SendChatMessage(14, 0, "So much for a real challenge... Die!")
	pUnit:PlaySoundToSet(12470)
end

function Stomp(pUnit, event)
	local stomptarget=pUnit:GetMainTank(1)
	pUnit:FullCastSpellOnTarget(45185, stomptarget)
	stomptarget:RemoveAura(46394)	
end

function Burn(pUnit, event)
	pUnit:CastSpellOnTarget(46394, pUnit:GetRandomPlayer(1))	
end

function Meteor_Slash(pUnit, event)
pUnit:FullCastSpell(45150)
end

function Combat_Talk(pUnit, event)
	local Choice=math.random(1, 3)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "Bring the fight to me!")
			pUnit:PlaySoundToSet(12467)
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Another day, another glorious battle!")
			pUnit:PlaySoundToSet(12468)
		elseif Choice==3 then
			pUnit:SendChatMessage(14, 0, "I live for this!")
			pUnit:PlaySoundToSet(12469)
end	
end

RegisterUnitEvent(65021, 1, "Huloz_OnCombat")
RegisterUnitEvent(65021, 2, "Huloz_OnLeaveCombat")
RegisterUnitEvent(65021, 3, "Huloz_OnKilledTarget")
RegisterUnitEvent(65021, 4, "Huloz_OnDied")