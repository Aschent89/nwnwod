#include "f_vampirebite_h"

int StartingConditional()
{
    return CanDrainLevels && (Determine_Vampire_Level(OBJECT_SELF) >= DrainLevelsLevel);
}

