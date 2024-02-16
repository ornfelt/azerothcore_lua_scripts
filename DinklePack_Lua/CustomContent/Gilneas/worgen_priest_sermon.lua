local NPCID = 1400021

local sermonText = {
    "Beloved brothers and sisters of Gilneas,",
    "We gather here today as proud Worgen, united in spirit and purpose, to seek guidance and solace in the Light that shines even in the darkest of times.",
    "Our people have faced unfathomable challenges. We've witnessed our world turned upside down, as we were cursed, forever changing our lives.",
	"But despite the shadows that have enveloped us, we have persevered and remained steadfast in our faith.",
    "Let us take a moment to remember the words of the Light, as written in the sacred texts:",
    "'In the face of darkness, the Light shall guide you. In the depths of despair, the Light shall uplift you. And in your darkest hour, the Light shall never abandon you.'",
	"Our transformation has granted us unique strengths. We are fierce and resilient, and we possess an unwavering loyalty to our people.",
	"Yet, we must also acknowledge the ferocity that lies within us, the beast that threatens to consume our humanity.",
	"It is through our faith that we find solace and strength, as we embrace our dual nature. We are Worgen, and we are Gilnean.",
	"We have been blessed with the Light's grace, and it is our duty to extend that grace to our fellow citizens, whether human or Worgen.",
	"In our darkest moments, it is easy to succumb to despair, to lose ourselves in the shadows of doubt and fear.",
    "But, my dear brothers and sisters, we must never forget the unyielding love the Light has for us.",
	"We must remind ourselves of the Light's presence within our hearts, and the blessings it bestows upon us.",
	"Let us reflect upon the teachings of the Light and embrace its wisdom:",
	"Compassion: We must show kindness and empathy towards our fellow Gilneans, helping those in need and offering solace to those who suffer. We are all bound by the same curse, and together, we will prevail.",
	"Resilience: As the Worgen, we have faced incredible adversity, and yet we stand strong. It is through our unwavering determination and our faith in the Light that we continue to endure.",
	"Unity: Our strength lies in our unity, in our solidarity as brothers and sisters of Gilneas. Together, we are an unstoppable force against the darkness that threatens our world.",
	"As we stand here today, let us remember the words of the Light and strive to uphold its teachings in all that we do.",
    "May the Light's divine grace continue to shine upon us, guiding our path through the shadows and leading us to a brighter future.",
}

local function SendSermonText(eventId, delay, repeats, npc)
    local index = npc:GetData("sermonIndex") or 1
    npc:SendUnitSay(sermonText[index], 0)
	npc:PerformEmote(396)
    index = index + 1
    
    if index > #sermonText then
        index = 1 
    end

    npc:SetData("sermonIndex", index)
    npc:RegisterEvent(SendSermonText, 10000, 1)
end

local function StartSermon(player)
    local priest = player:GetNearestCreature(500, NPCID)
    if priest and not priest:GetData("sermonStarted") then
        priest:SetData("sermonStarted", true)
        priest:RegisterEvent(SendSermonText, 3000, 1)
    end
end


local function Gpriest_OnPlayerMapChange(event, player)
    StartSermon(player)
end

local function GPriest_OnPlayerUpdateZone(event, player, newZone, newArea)
    StartSermon(player)
end


RegisterPlayerEvent(28, Gpriest_OnPlayerMapChange)
RegisterPlayerEvent(27, GPriest_OnPlayerUpdateZone)