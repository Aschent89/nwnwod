#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER2, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_LOOK_OF_HUNGER, GetPCSpeaker())
   && UseLookOfHunger
   && UseLookOfHungerLevel2) return TRUE;
return FALSE;
}

