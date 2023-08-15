Grumbo'z-VIP-System
==========
first off .. .. this system is from my non-profit server and has a custom db column called 'votes'.
so you have to modify your website to also add a value to this column when a player clicks each vote link for this to work proper(dont ask me how... i only barely know howto with wilson212's website.), OR edit the Core to grab the vote data from a different location, OR remove all contents reguarding votes, OR just run it as-is and votes will just allways be 0 unless they use a VIP Stone.

you MUST add all 3 columns to your auth.account table.

	USE `auth`;
	ALTER TABLE `account`
		ADD COLUMN `vip` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' AFTER `activation`,
		ADD COLUMN `mg` MEDIUMINT(20) UNSIGNED NOT NULL DEFAULT '0' AFTER `vip`,
		ADD COLUMN `votes` MEDIUMINT(20) UNSIGNED NOT NULL DEFAULT '0' AFTER `mg`; 
	
	USE `world`;
	ALTER TABLE `item_template`
		ADD COLUMN `vip` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' AFTER `VerifiedBuild`;

VIP System.

	allows for up to VIP XX. currently set to 10
	you can set max VIP in the core(VIPMAX).
	
	VOTECOUNT is for the votes part (how many Votes it takes to gain +1 VIP level. currently set to 125.

	A VIP Coin that will Display your VIP stats.

	a #buff command that will filter for vip level 1-10/11-20, if player has VIP Coin,  and if in a guild

	a VIP Stone to increase a players vip level.

	a banker so players can deposit and withdraw MG from there acct's bank.
		MG is accessable by ALL toons on specific account.

	a hyper-dynamic drop table to apply MG to drop from creatures.

	a MG rewarder system that rewards players MG who are in a guild every half hour they are logged on.

	a PvP reward system that rewards or deducts MG from a winner/loser.

	a command to reset player talents plus give extra talent points based on vip level.
	a command players can use outside of bg's to revive them selves when they have a VIP Coin in there inventory.

	a hyper-dynamic custom item VIP Super-Vendor.

	A kewl world chat script that displays the players VIP level and security level plus with icons and the 

	"#chat" requirement removed.
		Icons tell the players team and class and GM tag for gm's.
		Player names are interact-able.
		Uses the world chat channel so just switch to the world channel and chat away without having 
		to use the annoying "#chat" command over -n- over again.

The Guild Gold Perk is NOT supported by Mangos as they dont have the Guild:DepositBankMoney() method.

MG = Magic Gold.

enjoy everyone :D

I'm trying to make this as Dynamic as possible so the end-user can easily add there own scripts to run with it. 
or pick and choose what they want to use from the provided scripts.
