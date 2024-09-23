local OrgSpellCast = {}

OrgSpellCast.ORG_ID = {3296, 400039, 400040, 400041, 400045, 400059, 400060, 400061, 400070, 400071}
OrgSpellCast.SPELL_ID = 100193
OrgSpellCast.CREDIT_NPC_ID = 3296

function OrgSpellCast.OnSpellCast(event, caster, spell)
    local target = spell:GetTarget()
    if target and spell:GetEntry() == OrgSpellCast.SPELL_ID then
        local isValidTarget = false
        for _, orgID in ipairs(OrgSpellCast.ORG_ID) do
            if target:GetEntry() == orgID then
                isValidTarget = true
                break
            end
        end
        if not isValidTarget then
            caster:SendBroadcastMessage("That target is not valid.")
            spell:Cancel()
        elseif target:HasAura(OrgSpellCast.SPELL_ID) then
            caster:SendBroadcastMessage("You've already used the Shadow-Drenched Cloth on that defender!")
            spell:Cancel()
        else
            -- give kill credit to NPC ID 3296
            caster:KilledMonsterCredit(OrgSpellCast.CREDIT_NPC_ID)
        end
    end
end

RegisterPlayerEvent(5, OrgSpellCast.OnSpellCast)
