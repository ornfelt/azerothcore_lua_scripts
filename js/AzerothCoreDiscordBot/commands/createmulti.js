const Discord = require("discord.js")
const config = require('../config.js')
const client = require('../server.js')
const crypto = require('crypto')
const connection = require('../databasesql.js');
const soap = require("../soap.js");
module.exports = {
	name: 'createmulti',
	description: 'Creates new game accounts. It will use the name and password given and add a number to it at the end.',
  DMonly: true,
	execute(message, args) {
        if(!args[0]) return message.reply(`You need to add an amount of accounts. \nUsage: **!createmulti <amountofaccounts> <username> <password>**`)
        if(isNaN(args[0])) return message.reply(`The amount of accounts needs to be a number. \nUsage: **!createmulti <amountofaccounts> <username> <password>**`)
        if(!args[1]) return message.reply(`You need to add a username after the amount. \nUsage: **!createmulti <amountofaccounts> <username> <password>**`)
        if(!args[2]) return message.reply(`You need to add a password after the username. \nUsage: **!createmulti <amountofaccounts> <username> <password>**`)
        if(args[2].length > 14)  return message.reply(`Password needs to be smaller than 14 characters.`)
        let amount = parseInt(args[0]);
        let username = args[1];
        let password = args[2];

        const embed = new Discord.MessageEmbed()
        .setColor(config.color)
        .setTitle('Accounts Created')
        .setDescription('Take a look at your accounts info below:')
        .setTimestamp()
        .setFooter('Createmulti command', client.user.displayAvatarURL());
        connection.query('USE acore_auth')
        for(let counter = 1, myError = false; counter <= amount && myError === false; counter++){
          connection.query('select count(username) from account where reg_mail = ?', [message.author.id], (error, results, fields) => {

            if (error) return message.reply('An error occured.')
            console.log(Object.values(results[0])[0])
            if (Object.values(results[0])[0] <= 25) {
              try {
              soap.Soap(`account create ${username}${counter} ${password}`)
              .then(result => { 
                console.log(result)
                if(result.faultString) {
                  myError = true;
                  if(counter >= amount) message.reply("Username already exists.")
                  
                    return;

                }
              
                else{
                  embed.addField(counter + ". Username | Password ", username + counter + " | " + password, false)
                  connection.query(`UPDATE account set reg_mail = '${message.author.id}' WHERE username = '${username}${counter}'`, (error, results, fields) => {

                  
                  })
                  
                }
      
            
            if(counter >= amount && myError === false) {

              console.log(embed)
              return message.channel.send(embed);
            } 
             
          })

        } catch (error) {
          console.log(error)
        }
      } else {
          if(counter === amount) message.reply('You already have 25 accounts!')
          myError = true;
        }
          })
        }
        
    
	},
};