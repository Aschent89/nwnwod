#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_TURNPROOF, GetPCSpeaker())
   && UseTurnProof) return TRUE;
return FALSE;
}

