#pragma once

class Player;

unsigned long long GetSingleTargetDPS(Player *Owner);

void ResetSingleTargetDPS(Player *Owner); // using this for automated testing
