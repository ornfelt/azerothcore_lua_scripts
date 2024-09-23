const Discord = require("discord.js")
const config = require('../config.js')
const client = require('../server.js')
const crypto = require('crypto')
const connection = require('../databasesql.js');
const soap = require("../soap.js");
module.exports = {
	name: 'online',
	description: 'Gives list of online players.',
    DMonly: false,
	execute(message, args) {
    let counter = 0;
    let onlinePlayers = 0;
    connection.query('USE acore_characters')
    connection.query('select name from characters where online = 1', (error, results1, fields) => {

      if(!results1) {
        onlinePlayers = "There is no one online!"

        const embed = new Discord.MessageEmbed()
        .setColor(config.color)
        .setTitle('Online Players')
        .setDescription(onlinePlayers)
        .setTimestamp()
        .setFooter('Online command', client.user.displayAvatarURL());

        return message.channel.send(embed);
      
      }

      if (error) return console.log(error)

      onlinePlayers = [];
      results1.forEach(name => {
        onlinePlayers.push(name.name)
        counter++;
      });

      if (counter > 0 ) {
    
        console.log(onlinePlayers)
        const embed = new Discord.MessageEmbed()
        .setColor(config.color)
        .setTitle('Online Players')
        .setDescription(onlinePlayers)
        .addField(`Amount of characters online:`, counter + ` characters`)
        .setTimestamp()
        .setFooter('Online command', client.user.displayAvatarURL());
        
        message.channel.send(embed);
      } else {
        onlinePlayers = 'There is no one online.'

        const embed = new Discord.MessageEmbed()
        .setColor(config.color)
        .setTitle('Online Players')
        .setDescription(onlinePlayers)
        .addField(`Amount of characters online:`, counter + ` characters`)
        .setTimestamp()
        .setFooter('Online command', client.user.displayAvatarURL());
        
        message.channel.send(embed);
      }

    
})
	},
};