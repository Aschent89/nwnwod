#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_REFUGE, GetPCSpeaker())
   && UseRefuge) return TRUE;
return FALSE;
}
