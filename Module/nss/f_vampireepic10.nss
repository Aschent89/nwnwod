#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_HOLY_VAMPIRE, GetPCSpeaker())
   && GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_GOOD
   && UseHolyVampire) return TRUE;
return FALSE;
}

