#include "f_vampire_spls_h"

int StartingConditional()
{
if(!GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_TWIN_ABYSS, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_KIN_DAMNED, GetPCSpeaker())
   && GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, GetPCSpeaker())
   && UseChildrenOfTheNight
   && UseKinOfTheDamned
   && UseTwinOfTheAbyss) return TRUE;
return FALSE;
}

