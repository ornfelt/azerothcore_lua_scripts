# Black Market Auction House (BMAH) for AzerothCore 3.3.5
![image](https://github.com/user-attachments/assets/d5b71450-5871-45fd-ba70-578a0bc2831a)

A faithful backport of the Mists of Pandaria Black Market Auction House assets and functionality to AzerothCore 3.3.5 using the Eluna Lua engine.

---

## 🌟 Features

- **Authentic MoP UI**: Recreated the look & feel of the Mists of Pandaria BMAH.  
- **Server-Side Logic**: Written in Eluna Lua; handles auctions, bids, refunds & mail notifications.  
- **Client AddOn**: Scrollable auction frame, hot-item panel, bid input, tooltips & click handlers.  
- **Automated Maintenance**: 5-minute ticks to age auctions, flush expired items, and auto-fill when empty.  
- **GM Commands**: `/bmah flush` & `/bmah fill` for manual control.  
- **Configurable**: Adjust vendor NPC IDs, item pools, prices, durations, mail templates & stationeries.  

## 🛠️ Requirements

- AzerothCore 3.3.5 with Eluna enabled.  
- CharDB & WorldDB access for table creation and item lookups.  

## 🚀 Installation

### 1. Server Module

1. Copy `bmah_server.lua` into your Eluna scripts directory:

2. Make sure your  `BMAH_VENDOR_NPCs` is properly configured to your custom gossip enabled npc.
   
3. Restart your server; the `blackmarketauctionhouse` table will be created automatically.

### 2. Client AddOn

1. Copy the `BlackMarketUI` folder into your WoW client’s AddOns directory (or stuff it into a patch):
   
2. Reload the UI (`/reload`) or restart the client.

## ⚙️ Configuration

1. Server‑Side (bmah_server.lua)

- `Vendor NPCs:` Edit the BMAH_VENDOR_NPCs table with your chosen NPC IDs.

- `Pricing Tiers:` Adjust common_price, rare_price, ultra_rare_price variables.

- `Rarirty-Rates` Customize how frequently you see Commons/Rares/UltraRare items.
  
- `Add New Items!:` Very simple to add new items to the pool.

## 🎮 Usage

1. Talk to your configured vendor NPC to open the BMAH UI.

2. Browse auctions and view the “Hot Item” panel for featured items.

3. Enter a bid amount and click Bid or use the Hot Bid button.

4. GM Commands:
   - `/bmah flush` — Expire all current auctions and immediately mail the items to their highest bidders. 
   - `/bmah fill`  — Immediately refill the auction house.

## 🤝 Contributing

- Bug reports, enhancements, and pull requests are welcome! Please fork the repo and open a pull request with your changes.

## 📄 License

- Released under the GPL-3.0 License. See LICENSE for full details.
