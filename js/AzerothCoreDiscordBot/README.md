# Project Status: Abandoned
Note: This repository is no longer actively maintained or updated.

Bot startup
----------------------------

Info: This bot uses Discord ID and stores it into the SQL database acore_auth => account => reg_mail

This way it verifies if the user is trying to use his own account created using the bot

Requirements:

    - NodeJS (Tested with v16.6.2)
    - Modules (Use installation to install them)
    - Discord Account with a bot account for bot token

Installation:

    - Run "npm install", this will install all dependencies
    - Rename "config_template.js" to "config.js" and insert all your information: token, usernames, passwords, ...
    - Make sure your AzerothCore server has enabled SOAP.

Startup: 

    - Use a terminal
    - Command: npm start

Extra information:

    - Special thanks to Village#9461 (no github) for funding the project.
