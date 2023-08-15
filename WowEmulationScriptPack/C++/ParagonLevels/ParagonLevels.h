#pragma once


enum ParagonStatTypes
{
    PS_Srength,
    PS_Agility,
    PS_Stamina,
    PS_Intellect,
    PS_Spirit,
    PS_MovementSpeed,
    PS_Haste,
    PS_CritChance,
    PS_CritValue,
    PS_Armor,
    PS_AllResist,
    PS_LifeRegen,
    PS_AreaDamage,
    PS_LifeStealFlat,
    PS_DustGain,
    PS_MAX_STAT_TYPES,
    PS_ParagonLevel = -2,       //index to be sent to the client
    PS_ParagonFreePoints = -1,  //index to be sent to the client
};

void GetParagonLevelAndPointsUnSpent(Player *p, uint32 &Level, uint32 &UnSpent);
void GetParagonStatStatus(Player *p, uint32 Stat, uint32 &Points);
void ParagonBuyStat(Player *p, uint32 Stat);
