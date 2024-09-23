
let active = new Map(); 
module.exports = (client) => {
    const config = require("./config.js");
    const Discord = require("discord.js");
    const MySQLEvents = require('@rodrigogs/mysql-events');
    var mysql      = require('mysql2');
    const connection = mysql.createConnection({
      host     : config.databaseHost,
      user     : config.databaseUser,
      password : config.databasePassword,
      database: "acore_auth"
    });

    module.exports = connection
     
    connection.connect(function(err) {
      if (err) {
        console.error(`Error connecting: ${err.stack}`);
        return;
      }
     
      console.log('Connected as id ' + connection.threadId);
    });

    const instance = new MySQLEvents(connection, {
      startAtEnd: true,
      excludedSchemas: {
        mysql: true,
      },
    });
    
    instance.on(MySQLEvents.EVENTS.CONNECTION_ERROR, console.error);
    instance.on(MySQLEvents.EVENTS.ZONGJI_ERROR, console.error);
  };
    
