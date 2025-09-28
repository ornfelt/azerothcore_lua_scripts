
<h1>Eluna AH Bot - Project is WIP but functional</h1>
<p>Welcome to mostlynick's <strong>Eluna AH Bot</strong> module! This script is designed for automated auction house operations in AzerothCore emulation environments. It supports both buyer and seller functionalities, and is designed to be plug-and-play with extensive configuration options.</p>
<img src="https://raw.githubusercontent.com/mostlynick3/azerothcore-lua-ah-bot/master/icon.png" alt="Settings Image">

<h2>Features</h2>
<ul>
	<li>Plug and Play</li>
	<li>Extensive Filters</li>
	<li>Buyer and Seller Capabilities</li>
	<li>Supports both Bids and Buyouts</li>
	<li>Compatible with all Eluna versions supporting async DB queries (slight modifications needed otherwise)</li>
</ul>

<h2>Key Configuration Options</h2>
<h3>Bot Settings</h3>
<ul>
	<li><strong>Enable AH Bot</strong> - Enables or disables the auction house bot. Default is <code>true</code>.</li>
	<li><strong>AH Bots</strong> - List of player GUIDs used as bots. Can be customized.</li>
	<li><strong>Enabled Auction Houses</strong> - Specifies which auction houses the bot operates in (e.g., alliance, horde, neutral).</li>
	<li><strong>Enable Debugging</strong> - Configurable debugging options for both bot actions and item handling.</li>
	<li><strong>Startup Delay</strong> - Sets a delay after bot initialization to avoid server lag.</li>
  <li><strong>Some settings include:</strong> </li>
  <br><img src="https://raw.githubusercontent.com/mostlynick3/azerothcore-lua-ah-bot/master/images/settings.png" alt="Settings Image">
</ul>

<h3>Buyer Features</h3>
<ul>
	<li><strong>Enable Buyer</strong> - Controls whether the bot will buy items. Default is <code>true</code>.</li>
	<li><strong>AH Buy Timer</strong> - Specifies how frequently the bot purchases items (in hours).</li>
	<li><strong>Place Bid/Buyout Chance</strong> - Configures the chances of the bot placing a bid or buyout on items.</li>
	<li><strong>Realistic Bidding</strong> - The buyer bot is configured to bid within acceptable ranges of prices, and can be configured to bid over players or not.</li>
  <br><img src="https://raw.githubusercontent.com/mostlynick3/azerothcore-lua-ah-bot/master/images/bids.png" alt="AH Bot's Realistic Bids">
</ul>

<h3>Seller Features</h3>
<ul>
	<li><strong>Enable Seller</strong> - Controls whether the bot will post items for sale. Default is <code>true</code>.</li>
	<li><strong>Max Auctions</strong> - Maximum number of auctions the bot can post.</li>
	<li><strong>Repopulation Chance</strong> - Percentage chance the bot will repopulate the auction house when the number of items falls below a threshold.</li>
	<li><strong>Apply Random Properties</strong> - The AH bot is able to instantiate all items, including those with random properties and suffixes.</li>
  <br><img src="https://raw.githubusercontent.com/mostlynick3/azerothcore-lua-ah-bot/master/images/sales.png" alt="AH Bot's Wide Variety of Sales">
</ul>

<h3>Item Filters</h3>
<ul>
	<li><strong>Allowed Qualities</strong> - Configures the allowed item qualities for sale (e.g., Common, Rare, Epic).</li>
	<li><strong>Allowed Classes</strong> - Specifies which class items can be sold.</li>
	<li><strong>Allowed Races</strong> - Configures which races' items can be sold.</li>
	<li><strong>Item Weighting</strong> - Customizes how different item types are prioritized in the selling process.</li>
</ul>

<h2>Additional Features</h2>
<ul>
	<li><strong>GM Messaging</strong> - Sends messages to online GMs to notify them of bot actions or critical errors.</li>
	<li><strong>In-Game Management Comamnds</strong> - Type 'ahbot' to manage your AH bots.<br>
  <br><img src="https://raw.githubusercontent.com/mostlynick3/azerothcore-lua-ah-bot/master/images/commands.png" alt="In-Game Commands">
</li>
</ul>

<h2>AzerothCore Module Details</h2>
<p>Author: mostlynick3</p>
<p>Repository: <a href="https://github.com/mostlynick3/azerothcore-lua-ah-bot" target="_blank">https://github.com/mostlynick3/azerothcore-lua-ah-bot</a>.</p>
<p>Download ZIP: <a href="https://github.com/mostlynick3/azerothcore-lua-ah-bot/archive/refs/heads/main.zip" target="_blank">https://github.com/mostlynick3/azerothcore-lua-ah-bot/archive/refs/heads/main.zip</a>.</p>
<p>License: GPL-3.0</p>
