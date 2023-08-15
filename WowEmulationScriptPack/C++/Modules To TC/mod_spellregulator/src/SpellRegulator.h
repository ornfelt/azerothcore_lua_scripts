#pragma once
#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "ScriptLoader.h"
#include "Log.h"

class SpellRegulator
{
public:
	static SpellRegulator* instance()
	{
		static SpellRegulator instance;
		return &instance;
	}

	void Regulate(uint32& damage, uint32 spellId)
	{
		if (RegulatorContainer.find(spellId) == RegulatorContainer.end())
			return;


		float val = RegulatorContainer[spellId];

		if (!val || val == 100.0f)
			return;

		damage = (damage / 100.0f) * val;
	}

	void LoadFromDB()
	{
		RegulatorContainer.clear();
		uint32 msTime = getMSTime();
		QueryResult result = WorldDatabase.Query("SELECT * FROM spellregulator");

		if (!result)
			return;

		uint32 count = 0;
		do{
			Field* fields = result->Fetch();
			RegulatorContainer[fields[0].GetUInt32()] = fields[1].GetFloat();
			++count;
		} while (result->NextRow());
		//sLog->outString("Loaded %d regulated spells in %d ms", count, GetMSTimeDiffToNow(msTime)); //Need to be fixed
	}

private:
	std::unordered_map<uint32, float> RegulatorContainer; // spellid, percentage
};

#define sSpellRegulator SpellRegulator::instance()

class RegulatorLoader : public WorldScript
{
public:
	RegulatorLoader() : WorldScript("SpellRegulatorLoader") {}

	void OnStartup() override
	{
		sSpellRegulator->LoadFromDB();
	}
};
