local gameobject = 716100
local ArtifactSpellId = 707478
local startAmountStack = 50
local SpellIdChest = 707479

function artifacts(event, go, player)
	player:AddAura(ArtifactSpellId,player)
	local aura = player:GetAura(ArtifactSpellId)
	aura:SetStackAmount( startAmountStack )
end

local function mapsChange(event, player)
	if(player:HasAura(ArtifactSpellId)) then
        player:RemoveAura(ArtifactSpellId)
	end
end

function onKill(event, killer, killed)
local aura = 0
local stack = 0
	if(killer ~= killed) then
		if(killed:HasAura(ArtifactSpellId)) then
			aura = killed:GetAura(ArtifactSpellId)
			stack = aura:GetStackAmount()
			killed:RemoveAura(ArtifactSpellId)
			if(killer:HasAura(ArtifactSpellId)) then
				aura = killer:GetAura(ArtifactSpellId)
				local Killerstack = aura:GetStackAmount()
				aura:SetStackAmount(Killerstack - 1)
				killer:SummonGameObject( gameobject, killer:GetX(), killer:GetY(), killer:GetZ(), 1, 60 )
			else
				killer:AddAura(ArtifactSpellId,killer)
				aura = killer:GetAura(ArtifactSpellId)
		--		if(stack > 1 )then
		--			aura:SetStackAmount(stack - 1 )
		--		else
					aura:SetStackAmount(stack)
		--		end
			end
		end
		if(killer:HasAura(ArtifactSpellId)) then
			aura = killer:GetAura(ArtifactSpellId)
			stack = aura:GetStackAmount()
			if(stack <= 1) then
				killer:RemoveAura(ArtifactSpellId)
				killer:CastSpell( killer, SpellIdChest, true )
				else
				aura:SetStackAmount(stack - 1)
			end
		end
	end
end

RegisterPlayerEvent(6, onKill )
RegisterGameObjectEvent( gameobject, 14, artifacts )
RegisterPlayerEvent(28, mapsChange)