#include "f_vampire_spls_h"
#include "f_vampirebite_h"

int StartingConditional()
{
    if(!GetIsVampire(GetPCSpeaker())) return FALSE;
    object oOwner = GetLocalObject(OBJECT_SELF, "FALLEN_VAMPIRE_COFFIN");
    if(GetIsObjectValid(oOwner) && oOwner != GetPCSpeaker() && Determine_Vampire_Level(oOwner) < Determine_Vampire_Level(GetPCSpeaker())) return TRUE;
    return FALSE;
}
