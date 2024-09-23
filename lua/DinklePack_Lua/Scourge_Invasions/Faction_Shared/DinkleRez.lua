local DeathSoundPlayer = {}

DeathSoundPlayer.SPELL_ID = 100191
DeathSoundPlayer.AURA_1 = 100003
DeathSoundPlayer.AURA_2 = 100168
DeathSoundPlayer.AURA_3 = 80112
DeathSoundPlayer.SOUND_ID = 183255

local function PlaySound(eventId, delay, repeats, killed)
    killed:PlayDirectSound(DeathSoundPlayer.SOUND_ID)
end

function DeathSoundPlayer.OnKilledByCreature(event, killer, killed)
    if (killed:HasAura(DeathSoundPlayer.AURA_1) or killed:HasAura(DeathSoundPlayer.AURA_2) or killed:HasAura(DeathSoundPlayer.AURA_3)) then
        if not killed:HasSpellCooldown(DeathSoundPlayer.SPELL_ID) then
            killed:CastSpell(killed, DeathSoundPlayer.SPELL_ID, false)
            killed:RegisterEvent(PlaySound, 4500, 1) 
        end
    end
end

RegisterPlayerEvent(8, DeathSoundPlayer.OnKilledByCreature)
