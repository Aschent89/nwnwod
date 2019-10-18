#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, GetPCSpeaker())
   && UseChildrenOfTheNight) return TRUE;
return FALSE;
}

