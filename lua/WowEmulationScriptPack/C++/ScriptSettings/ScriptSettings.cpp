#include "DatabaseEnv.h"
#include "ScriptSettings.h"

ScriptPersistentVariables *SSV = NULL;

#define ComposeKey(Key1,Key2) ( (uint64)Key1 | ((uint64)Key2 << 31))

void ScriptPersistentVariables::LoadValuesFromDB()
{
    QueryResult result = CharacterDatabase.Query("select * from ServerScriptVariables");
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();

            uint32 Key1 = fields[0].GetUInt32();
            uint32 Key2 = fields[1].GetUInt32();
            int32 Val = fields[2].GetInt32();
            IntValues[ComposeKey(Key1, Key2)] = Val;
        } while (result->NextRow());
    }
}

int32 ScriptPersistentVariables::GetInt32Value(uint32 Key1, uint32 Key2, int32 *IsNAN)
{
    uint64 KompositeKey = ComposeKey(Key1, Key2);
    auto it = IntValues.find(KompositeKey);
    if (it == IntValues.end())
    {
        if (IsNAN != NULL)
            *IsNAN = 1;
        return 0;
    }
    if (IsNAN != NULL)
        *IsNAN = 0;
	return it->second;
}

void ScriptPersistentVariables::SetInt32Value(uint32 Key1, uint32 Key2, int32 Val)
{
	uint64 KompositeKey = ComposeKey(Key1, Key2);
	auto it = IntValues.find(KompositeKey);
	
	//need to create it
	char Query[500];
    if (it == IntValues.end())
        sprintf_s(Query, sizeof(Query), "Insert into ServerScriptVariables values (%d,%d,%d)", Key1, Key2, Val);
    //need to update it
    else if (it->second != Val)
        sprintf_s(Query, sizeof(Query), "Update ServerScriptVariables set Val = %d where Key1 = %d and Key2 = %d", Val, Key1, Key2);
    else
        return; //nothing to be done here
	CharacterDatabase.Execute(Query);
	
	IntValues[KompositeKey] = Val;
}

void ScriptPersistentVariables::DelInt32Value(uint32 Key1, uint32 Key2)
{
    uint64 KompositeKey = ComposeKey(Key1, Key2);
    auto it = IntValues.find(KompositeKey);
    if (it != IntValues.end())
    {
        IntValues.erase(KompositeKey);
        char Query[500];
        sprintf_s(Query, sizeof(Query), "delete from ServerScriptVariables where Key1 = %d and Key2 = %d", Key1, Key2);
        CharacterDatabase.Execute(Query);
    }
}

void InitScriptSettings()
{
    if (SSV == NULL)
        SSV = new ScriptPersistentVariables();
}

//The API we will use in other scripts
int32 GetScripVariableInt32(uint32 Key1, uint32 Key2, int32 *IsNAN)
{
    InitScriptSettings();
	return SSV->GetInt32Value(Key1,Key2,IsNAN);
}

void SetScripVariableInt32(uint32 Key1, uint32 Key2, int32 Val)
{
    InitScriptSettings();
	SSV->SetInt32Value(Key1,Key2,Val);
}

void DelScripVariableInt32(uint32 Key1, uint32 Key2)
{
    InitScriptSettings();
	SSV->DelInt32Value(Key1,Key2);
}

void AddScriptSettingsScripts()
{
    /*
    CREATE TABLE `ServerScriptVariables` (
    `Key1` INT NULL,
    `Key2` INT NULL,
    `Val` INT NULL,
    INDEX `Index1` (`Key1`, `Key2`),
    UNIQUE KEY `relation` (`Key1`,`Key2`)
    )
    COLLATE='latin1_swedish_ci'
    ENGINE=InnoDB;
    */
	SSV = NULL;
    InitScriptSettings();
}
