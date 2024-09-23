#pragma once

/*
Persistent server script variables is a simple key/value pairs. 
Variables can contain an additional key for the value to segment variable groups
*/

//add new variable types or variable groups here to avoid DB collision
enum ServerScriptVariableTypes
{
	SSV_Player_Automount,		// does this player have automount
    SSV_Player_Morph,
    SSV_Player_LastLogin,
    SSV_Player_ConsecutiveLogins,
    SSV_Player_ConsecutiveLoginAwarded,
};

int32 GetScripVariableInt32(uint32 Key1, uint32 Key2, int32 *IsNAN);
void SetScripVariableInt32(uint32 Key1, uint32 Key2, int32 Val);
void DelScripVariableInt32(uint32 Key1, uint32 Key2);
