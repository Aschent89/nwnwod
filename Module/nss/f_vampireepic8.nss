#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_BLOOD_OF_LAND, GetPCSpeaker())
   && UseBloodOfTheLand) return TRUE;
return FALSE;
}
