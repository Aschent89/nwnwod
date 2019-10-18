
#include "x0_i0_treasure"

void main()
{

    CTG_CreateSpecificBaseTypeTreasure(TREASURE_TYPE_MED, GetLastOpener(), OBJECT_SELF, TREASURE_BASE_TYPE_ARMOR);

     DelayCommand(300.0, ActionLockObject(OBJECT_SELF));
}

