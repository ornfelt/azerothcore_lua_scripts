--- Made for fun by Chisou

local hs_no_coldown = true

local HSN = {}

function HSN.OnHsCast(e, p, s, c)
	local spell_id = s:GetEntry()
	
	if spell_id == 8690 then
		p:RegisterEvent(HSN.OnHsResetDelay, 50, 0, p)
	end
end

function HSN.OnHsResetDelay(i, d, r, p)
	p:ResetSpellCooldown(8690)
	p:RemoveEventById(i)
end

if hs_no_coldown then
	RegisterPlayerEvent(5, HSN.OnHsCast)
end