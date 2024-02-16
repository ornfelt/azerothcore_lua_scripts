## Spell Charges Script Overview

This script introduces a unique functionality to spells within the AzerothCore framework, allowing a spell to be cast twice before a cooldown period is initiated. This implementation requires the use of three distinct spells, with one being optional:

- **Main Spell**: This is the primary spell that players will cast. It should not have a cooldown in spell.dbc.
- **Hidden Dummy Spell**: A spell that is not directly cast by the player but is invoked by the script to initiate the cooldown process. This spell should contain the desired the cooldown period that will be applied after the second charge of the main spell is used.
- **Visual Indicator Spell** (Optional): This spell serves as a visual cue to the player, indicating the cooldown status of the main spell. It is represented by a dummy aura, which has a duration matching that of the hidden dummy spell's cooldown.

### Functionality

Upon casting the main spell for the first time, the script checks if the hidden dummy spell is on cooldown. If not, the dummy spell is cast, representing the use of the first charge without applying a cooldown to the main spell. When the main spell is cast again while the hidden dummy spell is on cooldown, the script applies a cooldown to the main spell, signifying the consumption of the second charge. Optionally, the visual indicator spell can be cast to visually represent the cooldown period to the player.

This approach provides a flexible mechanism for implementing spells with multiple charges before a cooldown is incurred.

I've actually created a more complex script that is forthcoming in a later video which allows the cooldown period to be visually applied directly to the spell. There's quite a few additional steps involved, however, and is functionally the same. This script is primarilly for beginners in cpp. 

Video Tutorial:
https://youtu.be/Rwigf0MSG1s
