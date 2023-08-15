#include "ScriptPCH.h"
#include "ItemPrototype.h"

// All Text will be stored here for easy configuration

// ScriptName much match scriptName in creature_template
#define REQUESTER_SCRIPT_NAME "custom_gossip_script_itemrequester"

// Menus
#define REQUESTER_MENU_REQUEST_ITEM "Request an item"
#define REQUESTER_MENU_REQUEST_CONFIRMATION "Enter Item Id Or Name"
#define REQUESTER_MENU_EXIT	"[Exit]"

// Errors
#define REQUESTER_ERROR_INVALID_ITEM "Invalid Item entered"
#define REQUESTER_ERROR_QUALITY_TOO_HIGH "Requested Item Quality is too high."
#define REQUESTER_ERROR_REQUIREMENTS_NOT_MET "Item cannot be requested, you do not meet the requirements."
#define REQUESTER_ERROR_ITEM_CREATION_FAILED "Item creation failed"

// Mail
#define REQUESTER_DEFAULT_MAIL_SUBJECT "ItemRequester: Your item has arrived"
#define REQUESTER_DEFAULT_MAIL_BODY ""
#define REQUESTER_MAIL_SUCCESS "Item has been mailed"

// Level Requirements
enum REQUESTER_QUALITY_LEVEL_REQUIRED
{
	REQUESTER_QUALITY_LEVEL_PNU		= 55,	// ITEM_QUALITY_POOR / ITEM_QUALITY_NORMAL / ITEM_QUALITY_UNCOMMON
	REQUESTER_QUALITY_LEVEL_RARE	= 60,	// ITEM_QUALITY_RARE
	REQUESTER_QUALITY_LEVEL_EPIC	= 65	// ITEM_QUALITY_EPIC
};

enum ITEM_REQUESTER_MENUS
{
	ITEM_REQUESTER_MENU_SELECT_ITEM	= 1,
	ITEM_REQUESTER_MENU_EXIT,
};

class ItemRequester : public CreatureScript
{
	public:
		ItemRequester() : CreatureScript(REQUESTER_SCRIPT_NAME) {}
		
		bool OnGossipHello(Player *pPlayer, Creature *pCreature) 
		{ 
            if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
                return false;

			pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(8, 0, REQUESTER_MENU_REQUEST_ITEM, ITEM_REQUESTER_MENU_SELECT_ITEM, GOSSIP_ACTION_INFO_DEF + 1, REQUESTER_MENU_REQUEST_CONFIRMATION, 0, true);
			pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(8, 0, REQUESTER_MENU_EXIT, ITEM_REQUESTER_MENU_EXIT, GOSSIP_ACTION_INFO_DEF + 1, "", false);
			pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
			return true; 
		}

        bool OnGossipSelect(Player *pPlayer, Creature *pCreature, uint32 sender, uint32 action) 
		{
			pPlayer->PlayerTalkClass->ClearMenus();
			switch(sender)
			{
				case ITEM_REQUESTER_MENU_EXIT:
				{
					pPlayer->CLOSE_GOSSIP_MENU();
				}break;
			}

			return true;
		}

		bool OnGossipSelectCode(Player *pPlayer, Creature *pCreature, uint32 sender, uint32 action, const char *pCode)
		{
			switch(sender)
			{
				case ITEM_REQUESTER_MENU_SELECT_ITEM:
				{
					pPlayer->CLOSE_GOSSIP_MENU();
					uint32 itemId = atol(pCode);
                    ItemTemplate const* itemProto = sObjectMgr->GetItemTemplate(itemId); 
                     
                    if (!itemProto)
                    {
                        pPlayer->GetSession()->SendNotification(REQUESTER_ERROR_INVALID_ITEM);
                        return true;
                    }

					if(itemProto == NULL)
					{
						pPlayer->GetSession()->SendNotification(REQUESTER_ERROR_INVALID_ITEM);
						return true;
					}

					if(CheckQualityRequirements(pPlayer, itemProto->Quality) == false)
					{
						pPlayer->GetSession()->SendNotification(REQUESTER_ERROR_REQUIREMENTS_NOT_MET);
						return true;
					}
					if(CreateItemAndMailToPlayer(pPlayer, itemId) == true)
						pPlayer->GetSession()->SendNotification(REQUESTER_MAIL_SUCCESS);
					else
						pPlayer->GetSession()->SendNotification(REQUESTER_ERROR_ITEM_CREATION_FAILED );
				}break;
			}
			return true;
		}

		bool CheckQualityRequirements(Player *pPlayer, uint32 qualityType)
		{
			switch(qualityType)
			{
				case ITEM_QUALITY_POOR:
				case ITEM_QUALITY_NORMAL:
				case ITEM_QUALITY_UNCOMMON:
				{
					if(pPlayer->getLevel() >= REQUESTER_QUALITY_LEVEL_PNU)
						return true;

				}break;

				case ITEM_QUALITY_RARE:
				{
					if(pPlayer->getLevel() >= REQUESTER_QUALITY_LEVEL_RARE)
						return true;
				}break;

				case ITEM_QUALITY_EPIC:
				{
					if(pPlayer->getLevel() >= REQUESTER_QUALITY_LEVEL_EPIC)
						return true;
				}break;

				default:
				{
                    pPlayer->GetSession()->SendNotification(REQUESTER_ERROR_QUALITY_TOO_HIGH);
				}break;
			}
			return false;
		}

		bool CreateItemAndMailToPlayer(Player *pPlayer, uint32 itemId)
		{
			Item *pItem = new Item();
			if(pItem->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_ITEM), itemId, pPlayer) == false)
				return false;

			MailSender toSend(MAIL_NORMAL, pPlayer->GetGUIDLow(), MAIL_STATIONERY_GM);
			SQLTransaction trans = CharacterDatabase.BeginTransaction();
			pItem->SaveToDB(trans);

			MailDraft mailDraft(REQUESTER_DEFAULT_MAIL_SUBJECT, REQUESTER_DEFAULT_MAIL_BODY);
			mailDraft.AddItem(pItem);
			mailDraft.SendMailTo(trans, MailReceiver(pPlayer), toSend);
			CharacterDatabase.CommitTransaction(trans);
			return true;
		}
};

void AddSC_ItemRequester()
{
	new ItemRequester();
}