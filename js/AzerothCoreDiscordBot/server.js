const Discord = require("discord.js")
const fs = require("fs")
const config = require("./config.js")
const client = new Discord.Client();

require('./databasesql.js')(client)
const connection = require('./databasesql.js')
module.exports = client

client.commands = new Discord.Collection();
client.aliases = new Discord.Collection()
client.cooldowns = new Discord.Collection();
client.DMonlies = new Discord.Collection();
const commandFiles = fs.readdirSync('./commands').filter(file => file.endsWith('.js'));

for (const file of commandFiles) {
	const command = require(`./commands/${file}`);
	client.commands.set(command.name, command);

	if (command.DMonly === true) {
			client.DMonlies.set(command.name, command)
	}
}


// Startup
client.on('ready', () => {
    console.log("----------")
	console.log(`Logged in as ${client.user.tag}!`);
    console.log("----------")
	client.user.setActivity(config.statusMessage, { type: 'PLAYING' });
	setInterval(() => {
		client.user.setActivity(config.statusMessage, { type: 'PLAYING' });
	  }, 360000);
});

// Command Handler

client.on('message', async message => {

	if (!message.content.startsWith(config.prefix) || message.author.bot) return;

	const args = message.content.slice(config.prefix.length).trim().split(/ +/);
	const command = args.shift().toLowerCase();
	const { DMonlies } = client;

	const DMonlyCommand = DMonlies.get(command);

	if(message.guild !== null && DMonlyCommand) return message.reply("This is a DM only command.")
	if(!client.commands.has(command)) return;

	const { cooldowns } = client;

		if (!cooldowns.has(command.name)) {
			cooldowns.set(command.name, new Discord.Collection());
		}

		const now = Date.now();
		const timestamps = cooldowns.get(command.name);
		const cooldownAmount = (command.cooldown || 3) * 1000;

		if (timestamps.has(message.author.id)) {
			const expirationTime = timestamps.get(message.author.id) + cooldownAmount;

			if (now < expirationTime) {
				const timeLeft = (expirationTime - now) / 1000;
				return message.reply(`Please wait ${timeLeft.toFixed(1)} more second(s) before using this command again.`);
			}
		}

	try {
		if(client.commands.has(command)) client.commands.get(command).execute(message, args)

		timestamps.set(message.author.id, now);
		setTimeout(() => timestamps.delete(message.author.id), cooldownAmount);	

	} catch (error) {
		console.error(error);
		message.reply('There was an error trying to execute that command!');
	}
});



client.login(config.token)
