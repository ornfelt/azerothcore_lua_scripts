/*
 * Copyright (C) 2010-2012 Project SkyFire <http://www.projectskyfire.org/>
 * Copyright (C) 2010-2012 Oregon <http://www.oregoncore.com/>
 * Copyright (C) 2006-2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptPCH.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "Mail.h"
#include <cstring>

//This function is called when the player logs in (every login)
void OnLogin(Player* player)
{
    uint16 maxLevel;

    // every character should have first aid upon first login
    if (!player->HasSpell(27028))
        player->learnSpell(27028);

    if (player->HasSkill(SKILL_FIRST_AID) && player->GetBaseSkillValue(SKILL_FIRST_AID) < 375)
    {
        maxLevel = player->GetPureMaxSkillValue(SKILL_FIRST_AID);
        player->SetSkill(SKILL_FIRST_AID, maxLevel, maxLevel);
        //player->learnSkillAllSpells(SKILL_FIRST_AID, maxLevel);
        player->learnSpell(27033); // heavy netherweave bandage
        player->removeSpell(3275); // unlearn linen bandage
    }

    // Smolderforge arena title modification
    // see if player is an arena finalist with title
    uint32 playerGuid = player->GetGUIDLow();
    QueryResult_AutoPtr result = CharacterDatabase.PQuery("SELECT guid, title, earnedSeason, currentSeason, type, awarded, numKeepSeasons FROM season_titles WHERE guid = '%u'", playerGuid);
    if (result)
    {
        do
        {
            Field *fields = result->Fetch();
            uint32 guid = fields[0].GetUInt32();
            uint8 title = fields[1].GetUInt8();
            uint8 earnedSeason = fields[2].GetUInt8();
            uint8 currentSeason = fields[3].GetUInt8();
            uint8 arenaType = fields[4].GetUInt8();
            uint8 awarded = fields[5].GetUInt8();
            uint8 numKeepSeasons = fields[6].GetUInt8();

            uint32 rewardItemId = 390998; // base item ID for rewards packages
            std::string mailMessage = "";
            std::ostringstream ss;
            ss << earnedSeason - 1; // earned season is always the new season, subtrack one to reference previous season.
            mailMessage = "You recent efforts in rated arena have placed you at the top 3 for season " + ss.str() + "! Attached below are your exclusive mounts to ride upon for the next two seasons, and your tabard which you may keep permanently.";

            CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(title);

            if (earnedSeason == currentSeason && titleEntry) // we may need to add a title
            {
                if (!awarded)
                {
                    if (!player->HasTitle(titleEntry))
                        player->SetTitle(titleEntry);

                    player->GetSession()->SendAreaTriggerMessage("Congratulations! You're an arena finalist! Your title has been added and if you were one of the top 3 teams, your mounts and tabard will be delivered to your mailbox.");
                    ChatHandler(player).PSendSysMessage("Congratulations! You're an arena finalist! Your title has been added and if you were one of the top 3 teams, your mounts and tabard will be delivered to your mailbox.");

                    switch (title)
                    {
                    case 42: // glad
                    case 62: // merc glad
                    case 71: // veng glad
                    {
                        rewardItemId += title + arenaType;

                        Item* ToMailItem = Item::CreateItem(rewardItemId, 1, player);
                        ToMailItem->SaveToDB();

                        MailDraft("Arena Rewards", sObjectMgr->CreateItemText(mailMessage))
                            .AddItem(ToMailItem)
                            .SendMailTo(MailReceiver(player), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM), MAIL_CHECK_MASK_RETURNED);

                        CharacterDatabase.PExecute("UPDATE `season_titles` SET awarded = 1, numKeepSeasons = 1 WHERE guid = %u AND title = %u AND type = %u", playerGuid, title, arenaType);
                        break;
                    }
                    default: // non-glads
                        CharacterDatabase.PExecute("UPDATE `season_titles` SET awarded = 1 WHERE guid = %u AND title = %u AND type = %u", playerGuid, title, arenaType);
                        break;
                    }
                }
            }

            if (earnedSeason < currentSeason && titleEntry) // we have a title to remove
            {
                if (player->HasTitle(titleEntry))
                {
                    if (!numKeepSeasons) // no seasons left to hold onto title, remove
                    {
                        player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
                        player->SetTitle(titleEntry, true);
                        CharacterDatabase.PExecute("DELETE FROM season_titles WHERE guid = %u AND title = %u AND type = %u", playerGuid, title, arenaType);

                        player->RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);
                        switch (title)
                        {
                        case 42:
                            player->DestroyItemCount(37676, 1, true, false); // nether drake
                            break;
                        case 62:
                            player->DestroyItemCount(34092, 1, true, false); // merc drake
                            break;
                        case 71:
                            player->DestroyItemCount(30609, 1, true, false); // venge drake
                            break;
                        }

                        switch (arenaType)
                        {
                        case 2: // 2v2
                            player->DestroyItemCount(33225, 1, true, false); // spectral - 33225
                            break;
                        case 3: // 3v3
                            player->DestroyItemCount(21176, 1, true, false); // aq - 21176
                            break;
                        case 5: // 3v3 solo queue
                            player->DestroyItemCount(37719, 1, true, false); // zhevra - 37719
                            break;
                        }
                    }
                    else if (numKeepSeasons)
                    {
                        switch (title)
                        {
                        case 71: // Vengeful Gladiator
                        case 62: // Merciless Gladiator
                        case 42: // Gladiator
                            CharacterDatabase.PExecute("UPDATE season_titles SET earnedSeason = %u, numKeepSeasons = %u WHERE guid = %u AND title = %u AND type = %u", earnedSeason + 1, numKeepSeasons - 1, playerGuid, title, arenaType);
                            break;
                        }
                    }
                }
            }
        }
        while (result->NextRow());
    }
    else if (!result) // player has no record, check for titles
    {
        CharTitlesEntry const* vGlad = sCharTitlesStore.LookupEntry(71);
        CharTitlesEntry const* mGlad = sCharTitlesStore.LookupEntry(62);
        CharTitlesEntry const* glad = sCharTitlesStore.LookupEntry(42);
        CharTitlesEntry const* duelist = sCharTitlesStore.LookupEntry(43);
        CharTitlesEntry const* rival = sCharTitlesStore.LookupEntry(44);
        CharTitlesEntry const* challenger = sCharTitlesStore.LookupEntry(45);

        if (player->HasTitle(vGlad))
        {
            player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            player->SetTitle(vGlad, true);
        }
        if (player->HasTitle(mGlad))
        {
            player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            player->SetTitle(mGlad, true);
        }
        if (player->HasTitle(glad))
        {
            player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            player->SetTitle(glad, true);
        }
        if (player->HasTitle(duelist))
        {
            player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            player->SetTitle(duelist, true);
        }
        if (player->HasTitle(rival))
        {
            player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            player->SetTitle(rival, true);
        }
        if (player->HasTitle(challenger))
        {
            player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            player->SetTitle(challenger, true);
        }
    }
}

//This function is called when the player logs out
void OnLogout(Player* player)
{
}

//This function is called when the player kills another player
void OnPVPKill(Player* killer, Player *killed)
{
}

 void AddSC_onevents()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "scripted_on_events";
    newscript->pOnLogin = &OnLogin;
    newscript->pOnLogout = &OnLogout;
    newscript->pOnPVPKill = &OnPVPKill;

    newscript->RegisterSelf();
}
