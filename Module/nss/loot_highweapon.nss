
#include "x0_i0_treasure"

void main()
{

    CTG_CreateSpecificBaseTypeTreasure(TREASURE_TYPE_HIGH, GetLastOpener(), OBJECT_SELF, TREASURE_BASE_TYPE_WEAPON);

     DelayCommand(300.0, ActionLockObject(OBJECT_SELF));

}

