const Discord = require("discord.js")
const config = require('../config.js')
const client = require('../server.js')
const crypto = require('crypto')
const connection = require('../databasesql.js');
const soap = require("../soap.js");
module.exports = {
	name: 'password',
	description: 'Changes an account password.',
    DMonly: true,
	execute(message, args) {
        if(!args[0]) return message.reply(`You need to add a username after the command. \nUsage: **!password <username> <newpassword>**`)
        if(!args[1]) return message.reply(`You need to add a new password after the username. \nUsage: **!password <username> <newpassword>**`)
        let username = args[0];
        let password = args[1];
          connection.query('select exists(select id from account where reg_mail = ? AND username = ?)', [message.author.id, username], (error, results, fields) => {

            if (error) return message.reply('An error occured.')

            if (Object.values(results[0])[0] === 1) {
              try {
              soap.Soap(`account set password ${username} ${password} ${password}`)
              .then(result => { 

                console.log(result)
                if(result.faultString) return message.reply("Error.") 

                    const embed = new Discord.MessageEmbed()
                    .setColor(config.color)
                    .setTitle('Password changed')
                    .setDescription('Take a look at your new account info below:')
                    .addField('Username', username, true)
                    .addField('Password', password, true)
                    .setTimestamp()
                    .setFooter('Password command', client.user.displayAvatarURL());
            
                  message.channel.send(embed);

                }).catch(error => console.log("There was an error, please check the soap connection of the bot."))
              } catch (error) {
                console.log(error)
              }
            } else {
              message.reply(`This username doesn't exist or you do not own the account.`)
            }
            
          })
          
	},
};