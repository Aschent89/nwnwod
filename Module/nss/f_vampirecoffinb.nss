#include "f_vampire_spls_h"

int StartingConditional()
{
if(GetIsVampire(GetPCSpeaker())) return FALSE;
return GetLocalInt(OBJECT_SELF, "FALLEN_ROSEWARD");
}
