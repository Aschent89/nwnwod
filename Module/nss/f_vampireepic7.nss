#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_SUNPROOF, GetPCSpeaker())
   && UseSunproof) return TRUE;
return FALSE;
}


