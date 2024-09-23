const Discord = require("discord.js")
const config = require('../config.js')
const client = require('../server.js')
const crypto = require('crypto')
const connection = require('../databasesql.js');
const soap = require("../soap.js");
module.exports = {
	name: 'create',
	description: 'Creates new game account.',
  DMonly: true,
	execute(message, args) {
        if(!args[0]) return message.reply(`You need to add a username after the command. \nUsage: **!create <username> <password>**`)
        if(!args[1]) return message.reply(`You need to add a password after the username. \nUsage: **!create <username> <password>**`)
        let username = args[0];
        let password = args[1];
        connection.query('USE acore_auth')
          connection.query('select COUNT(username) from account where reg_mail = ?', [message.author.id], (error, results, fields) => {

            if (error) return message.reply('An error occured.')


            if (Object.values(results[0])[0] <= 25) {
              try {
              soap.Soap(`account create ${username} ${password}`)
              .then(result => { 

                console.log(result)
                if(result.faultString) return message.reply("Username already exists.") 
              
                else connection.query(`UPDATE account set reg_mail = '${message.author.id}' WHERE username = '${username}'`)


                    const embed = new Discord.MessageEmbed()
                    .setColor(config.color)
                    .setTitle('Account Created')
                    .setDescription('Take a look at your account info below:')
                    .addField('Username', username, true)
                    .addField('Password', password, true)
                    .setTimestamp()
                    .setFooter('Create command', client.user.displayAvatarURL());
            
                  message.channel.send(embed);

                })
              } catch (error) {
                console.log(error)
              }
            } else {
              message.reply('You already have 25 accounts!')
            }
            
          })
          
	},
};