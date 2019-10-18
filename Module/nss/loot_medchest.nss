
#include "x0_i0_treasure"

void main()
{

    CTG_CreateTreasure(TREASURE_TYPE_MED, GetLastOpener(), OBJECT_SELF);

 DelayCommand(300.0, ActionLockObject(OBJECT_SELF));

}


