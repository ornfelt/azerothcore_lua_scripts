-- Will dump all spells to a json

abotSpellResult='[';
tabCount = GetNumSpellTabs()
for a=1,tabCount do
	tabName,tabTexture,tabOffset,numEntries=GetSpellTabInfo(a)
	for b=tabOffset+1,tabOffset+numEntries do 
		abSpellName, abSpellRank = GetSpellName(b,"BOOKTYPE_SPELL")
		if abSpellName then
			abName, abRank, _, abCosts, _, _, abCastTime, abMinRange, abMaxRange = GetSpellInfo(abSpellName, abSpellRank)
			abotSpellResult=abotSpellResult..
			'{'..
				'"spellbookName": "'..tostring(tabName or 0)..'",'..
				'"spellbookId": "'..tostring(a or 0)..'",'..
				'"name": "'..tostring(abSpellName or 0)..'",'..
				'"rank": "'..tostring(abSpellRank or 0)..'",'..
				'"castTime": "'..tostring(abCastTime or 0)..'",'..
				'"minRange": "'..tostring(abMinRange or 0)..'",'..
				'"maxRange": "'..tostring(abMaxRange or 0)..'",'..
				'"costs": "'..tostring(abCosts or 0)..'"'..
			'}';
			if a < tabCount or b < tabOffset+numEntries then
				abotSpellResult=abotSpellResult..','
			end
		end
	end
end
abotSpellResult=abotSpellResult..']'