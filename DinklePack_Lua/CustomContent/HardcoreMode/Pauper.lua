local Taxable = {}

Taxable.ITEM_ID = 800086
Taxable.MONEY_MULTIPLIER = 0.1
Taxable.MESSAGES = {
    "The taxman cometh! 90% of your earnings have vanished into thin air.",
    "Like magic, but less fun, 90% of your earnings disappeared.",
    "Congratulations! 90% of your earnings have been donated to 'Taxation Without Representation Foundation'.",
    "Breaking news: Local adventurer loses 90% of their income. Details at 11.",
    "90% of your earnings decided they'd rather be somewhere else.",
    "A gnome ran off with 90% of your earnings. You should probably look into that.",
    "You've been visited by the tax fairy! Unfortunately, she took 90% of your earnings.",
    "Your earnings decided to take a 90% vacation.",
    "Remember that 90% of your earnings you used to have? Yeah, about that...",
	"Whoops! Looks like 90% of your earnings fell into an inter-dimensional portal.",
    "Your earnings have been taxed at the goblin rate. You're 90% lighter now.",
    "Some say wealth is overrated. Enjoy your 90% lighter purse.",
    "90% of your earnings were abducted by tax aliens. They said they come in peace.",
    "A mysterious force whisked away 90% of your earnings. It left a 'thank you' note.",
    "You feel a slight breeze as 90% of your earnings make a swift exit.",
    "A murloc ran by and ate 90% of your earnings. It seemed to enjoy it.",
    "90% of your earnings have been drafted into the army of the tax king.",
    "A gnome from the Taxation Bureau sends their regards. Also, they took 90% of your earnings.",
	"An invisible tax imp just did a dance and 90% of your earnings joined in.",
	"A taxing tornado just swept through your purse. It left 10% behind, how considerate!",
    "The taxman strikes again! 90% of your earnings are MIA.",
	"90% of your earnings got lost in the Twisting Nether. Happens to the best of us.",
    "A gnome engineer needed 90% of your earnings for... science. Don't ask.",
    "Looks like Nozdormu messed with your timeline. 90% of your earnings? Never existed.",
    "You feel lighter, and not in a good way. A rogue named Tax just pickpocketed 90% of your earnings!",
    "An ethereal trader just offered you a deal you couldn't refuse. 90% of your earnings for a shiny... pebble?",
    "A goblin shouts in the distance, 'Time is money, friend!' as 90% of your earnings inexplicably disappears.",
    "90% of your earnings were just donated to the 'Dwarven Ale Appreciation Society'. They thank you for your generosity.",
    "Pepe needed a new hat. Your 90% contribution will be remembered.",
    "The spirit healers have started charging a 'convenience fee'. There goes 90% of your earnings.",
    "You suddenly remember a hefty debt you owed to Gazlowe. 90% of your earnings should cover it... for now."
}

function Taxable.TAX_OnMoneyChange(event, player, amount)
    if player:HasItem(Taxable.ITEM_ID) then
        if amount > 0 then
            local newAmount = amount * Taxable.MONEY_MULTIPLIER + 1 
            local message = Taxable.MESSAGES[math.random(#Taxable.MESSAGES)]
            player:SendBroadcastMessage(message)
            return newAmount 
        end
    end
end

RegisterPlayerEvent(14, Taxable.TAX_OnMoneyChange)
