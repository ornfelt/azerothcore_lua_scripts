#pragma once
#include "ScriptPCH.h"

class SpellRegulator
{
private:
    typedef std::unordered_map<uint32, float> RegulatorContainer; // spellid, percentage
public:
	static SpellRegulator* instance()
	{
		static SpellRegulator instance;
		return &instance;
	}

	void Regulate(uint32& damage, uint32 spellId)
	{
        RegulatorContainer::const_iterator itr = RegulatorMaps.find(spellId);

        if (itr == RegulatorMaps.end())
			return;


        float val = RegulatorMaps[spellId];

		if (!val || val == 100.0f)
			return;

		damage = (damage / 100.0f) * val;
	}

	void LoadFromDB()
	{
        RegulatorMaps.clear();
		uint32 msTime = getMSTime();
		QueryResult result = WorldDatabase.Query("SELECT * FROM spellregulator");

		if (!result)
			return;

		uint32 count = 0;
		do{
			Field* fields = result->Fetch();
            RegulatorMaps[fields[0].GetUInt32()] = fields[1].GetFloat();
			++count;
		} while (result->NextRow());
		//sLog->OutDebug("server.loading", "Loaded %u regulated spells in %u ms", count, GetMSTimeDiffToNow(msTime));
	}
    private:
        RegulatorContainer RegulatorMaps;
};

#define sSpellRegulator SpellRegulator::instance()

class RegulatorLoader : public WorldScript
{
public:
	RegulatorLoader() : WorldScript("SpellRegulatorLoader") {}

	void OnStartup()
	{
		sSpellRegulator->LoadFromDB();
	}
};