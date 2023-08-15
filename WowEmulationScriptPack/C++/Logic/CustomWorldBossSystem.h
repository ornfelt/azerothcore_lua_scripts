
#ifndef _WORLDBOSSSYSTEM_H
#define _WORLDBOSSSYSTEM_H


class CustomWorldBossSystem {

private:
	void insertNewKillCounter(int bossid, int counter);
	void updateKillCounter(int bossid, int counter);

public:

	void updateCounter(int bossid);

};



#endif