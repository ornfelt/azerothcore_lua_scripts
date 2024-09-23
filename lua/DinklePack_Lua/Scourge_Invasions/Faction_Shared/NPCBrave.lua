local BraveWarrior = {}
BraveWarrior.BRAVE_IDS = {5412, 5614, 5511, 5512, 957, 7798, 11026, 5518, 5510, 5509, 1416, 5514, 29016, 29019, 3518, 1472, 31423, 3314, 3312, 3323, 5188, 3370, 3368, 3371, 3316, 3405, 11046, 3347, 3348, 6986, 31433}
BraveWarrior.BRAVERY_DIALOGUE = {
  "I fear no enemy!",
  "I will fight to the bitter end!",
  "This battle is mine!",
  "This is MY city!",
  "My courage will never falter!",
  "I'll show you what true bravery is!",
  "I am unbreakable!",
  "This fight is mine to win!",
  "I'll fight until my last breath!",
  "Pfft, you think you can scare the likes of me!?"
}

local shouldSpeak = math.random() < 0.5

function BraveWarrior.OnCombat(event, creature, target)
  if shouldSpeak then
    creature:SendUnitSay(BraveWarrior.BRAVERY_DIALOGUE[math.random(#BraveWarrior.BRAVERY_DIALOGUE)], 0)
    shouldSpeak = not shouldSpeak
  else
    shouldSpeak = not shouldSpeak
  end
end

for i, id in ipairs(BraveWarrior.BRAVE_IDS) do
  RegisterCreatureEvent(id, 1, BraveWarrior.OnCombat)
end
