#include "f_vampire_spls_h"

int StartingConditional()
{
    if(GetIsVampire(GetPCSpeaker()))
        {
        if(GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_HOLYWATER") ||
           GetLocalInt(OBJECT_SELF, "FALLEN_VAMPIRE_GARLIC"))
            {
            if((17 + d20()) < (GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE)
                              + GetAbilityScore(GetPCSpeaker(), ABILITY_WISDOM)))
                return TRUE;
            }
        }
    return FALSE;
}
