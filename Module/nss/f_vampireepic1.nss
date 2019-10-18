#include "f_vampire_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_IMP_THRALL, GetPCSpeaker())
   && CanMakeThralls
   && MakeThrallLevel <= Determine_Vampire_Level(GetPCSpeaker())
   && UseImprovedThrall) return TRUE;
return FALSE;
}
