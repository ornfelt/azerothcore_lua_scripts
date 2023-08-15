#pragma once

class ScriptPersistentVariables
{
public:
	ScriptPersistentVariables()
	{
		LoadValuesFromDB();
	}
	int32 GetInt32Value(uint32 Key1, uint32 Key2, int32 *IsNAN);
	void SetInt32Value(uint32 Key1, uint32 Key2, int32 Val);
	void DelInt32Value(uint32 Key1, uint32 Key2);
private:
	void LoadValuesFromDB();
	std::map<uint64,int32> IntValues;
};
