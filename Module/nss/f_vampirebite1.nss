#include "f_vampirebite_h"

int StartingConditional()
{
    return CanSpreadVampirism && (Determine_Vampire_Level(OBJECT_SELF) >= SpreadVampirismLevel);
}
