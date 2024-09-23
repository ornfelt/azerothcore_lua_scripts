/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
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

// This is where scripts' loading functions should be declared:
void AddSC_Transmogrification();
void AddSC_CrossfactionBattlegrounds();
void AddSC_AutoBalance();
void AddSC_AddCongratsOnLevelScripts();
void AddSC_AddCustomServerScripts();
void AddSC_npc_1v1arena();
void AddSC_AddIpTrackerScripts();
void AddSC_AddMoneyForKillsScripts();
void AddSC_AddPlayerNotSpeakScripts();
void AddSC_AddBeastMasterScripts();
void AddSC_AddNPCBufferScripts();
void AddSC_AddNPCGamblerScripts();
void AddSC_Npc_VisualWeaponScripts();
void AddSC_AddRewardSystemScripts();
void AddSC_GOMove_commandscript();
void AddSC_premium_account();
void AddSC_custom_reload_commands();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddCustomScripts()
{
    AddSC_Transmogrification();
	AddSC_CrossfactionBattlegrounds();
    AddSC_AutoBalance();
	AddSC_AddCongratsOnLevelScripts();
	AddSC_AddCustomServerScripts();
	AddSC_npc_1v1arena();
	AddSC_AddIpTrackerScripts();
	AddSC_AddMoneyForKillsScripts();
	AddSC_AddPlayerNotSpeakScripts();
	AddSC_AddBeastMasterScripts();
	AddSC_AddNPCBufferScripts();
	AddSC_AddNPCGamblerScripts();
	AddSC_Npc_VisualWeaponScripts();
	AddSC_AddRewardSystemScripts();
	AddSC_GOMove_commandscript();
	AddSC_premium_account();
    AddSC_custom_reload_commands();
}
